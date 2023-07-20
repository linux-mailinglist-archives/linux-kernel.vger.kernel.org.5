Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E371775AD49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGTLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGTLpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:45:05 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2160.outbound.protection.outlook.com [40.92.62.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CC197
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D17ipNmXDSku29Iv6LWxB00DpvXxS2prySG/MCEBXXbJYp04TqZmEf4JTNgVUwm20lvLREUuS360EGF8e9UTtXmccsSSlJcV8jpmiv8XH2zbS0FGT+i5mRRUTiHQyzu9gbo2/jWtVZC43IUPcIL15vUFA9ti02oQKBS+mq8YoH4O6LGCGwMMLbV4eHp6/ZRKnnpUu8FXiL7L9cRde/nBX9dbhphxx274g+sL/0emotVVjQstrZvXe9XEx7U8H22BMINT/PRDULnT41MehN6jtO05FU5N72mDLTY03dLVFQHdwV6J8uI1gNPQYXdLau3ZxjpH/yMG/YDk6VUrfTcvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln1gmJAeOr68tqxOplSLgVqBDUhCYE1OfNqsZfdW6hA=;
 b=c61Gc5V00lIaBwSQ/rLLOb31ehjeK79wPt6WRwGBpO/4B9mSk2VEMk51wqujcSb/NMCpHJjYxkm9busx9DF5UVoJB6xnIOGp4cT6HFnwhGPhwqaWKYhJ0PSE38Zdv5xNlSxDfDASeaCBGs+cz3GPjKt8NGRdjsXsyMc1+morztMKOKhV0raVOuB0mxIBXojxYcOPoUoY+yxrRgU5ZdcaFIQ+ohfX2rZv7Ty816CMps1O7VRTVHJF6UdSOYomTHzfJlv23MRirzLAQkMe1fucM+ibeL6GM27cirus/eZBcF9FUc0kVpkAKIeDTiSAnWy6XQ3ffubluKKVURMS5mDJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln1gmJAeOr68tqxOplSLgVqBDUhCYE1OfNqsZfdW6hA=;
 b=vNv5DAQFX3xWYlzlKpDscJCg2s3OyGrzdq4QoQs1Ms08H2LVmqjKhQwLP67Kg856TPlyhzYrW6iIxDRobM5Vn+21VZGiAx7qbRYDtNG1Y9xXCC+F4tlsBzJULqCNhfpNJfxOg1z/Uit+Z5tb7HtRPocAUdwLS2uau5GTmEyY9yBj0i3zGXqSzTSds2llBOo9P59mHE9SHiARo0MnjjU39NGsAifbrBaVZ1kgSUUGiejjU71PViFZuJHX34NTfvqVB4McUWIphsZgNK3xuoeZcPHZY89W/F/lER/rJ9iEyjiUsZKJtNMuFyoqvhQ8uPH8600MktUeHBqFIv+gi57IgQ==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SY4P282MB2234.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:f8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Thu, 20 Jul 2023 11:44:58 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b%5]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 11:44:58 +0000
From:   Dong Zhihong <donmor3000@hotmail.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, donmor3000@hotmail.com, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6] LoongArch: Fix CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER on non-FDT systems
Date:   Thu, 20 Jul 2023 19:43:10 +0800
Message-ID: <MEYP282MB2597CE76DFC2B421C1A4594CD93EA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RSe+R+d4Oncy5BV0uq955c0xbVFqkgrvwCJqlvR970RDa0gsun33SaFbeXTDZdQZ]
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:128::9)
X-Microsoft-Original-Message-ID: <20230720114309.4022651-1-donmor3000@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2597:EE_|SY4P282MB2234:EE_
X-MS-Office365-Filtering-Correlation-Id: 881b366a-78d6-49a0-a90c-08db8916be8f
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnoM1/t0WSu07T06taLkTSGCyjvTllJfY5bVLCXkWx11mBxa1FgaM5y195hoG4w6YPHHhaHnYvyEVhHTRhtR8VBe5SHrU/NhuQyXqzwa9f/bqWuJ+vkpT3KrcH07TtvJ9W64dryaT2B+waz4bn0+rhSA/Roxrq4UNnBZsV10m07zlVi1WFDv+Yc5pgAK9iSgZAywJ3Ug5bJnRXwiQN6Wd7bgIf/+euA/xijQS5W4xI2YnbUMZkimgVIea7huy7RbIjKDWXaM1t8xvxU10b6EFsoiEndkTWO16bXbADuKas3pFOOfShdAWbs8ATpds4vVt6fJT7w3/m4xC3KsPXQMtJoc7tnndli1UtjhlVtWynlW8JKK1vC70zH0mmOd045chP6m9oXh21Gh/XdL01hBDQ6vS8pfIn1PChCWQ2hx1bQGJ7K7ZVSnsxVjkuPfJV+kj0C6CeJTMWtVc3bwsuwhVZOs/HVzLZibOABM4Wci6VGHx/oEVf1MvsdYEyO+EJr5Q+7d0XeHKHww7OUDHwEcYlcebAZEUZ4Vldsz4liWjgvREnh3CuJhQDQ/fJU0StsZtsjFIuGYVPxk0rae4Dvb0APvZDt6QCL67l3exmkcQQlGaVxL1Bb2JGkjcHhU7sOviPM1WsQMZwOnIo4kF8T3O8QvGwN68eLxRTARz8ZchUQS2I3TIKUYA7i+u2AgLmg1jq/VUsLjthwtwfykKJh2POuzzXvFgWTxAMTrR+9C+BWCjE4VsSIkDI0NFlFFXyUnO6Q=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VV5mUiI+6Km6B/MgntKbEC/V3m96Yec0bNlJDaacMK5Sl07kgDIkK4L0JWC25Dj5isWZmw12HRmKGoZr0KMiAXZIJiN+K+KWL2w69TStylaXSuMrxGkv12GeGrGgLn3MY5khN3glMxGdFQL7L3f1Kgh33G4/tGujPVvoyTJHJX6i6LHCYqMcF8LhmceglSbGIwJo+chLKG5xTSpdPEVmyeJgVGRNSCtdRJr3yVMsj44vR2SQqYfsfszvkRT3AzTs5ekJ9BDg/KLG6e8c+y/yeR5DxjezwJp2DD373Ex+A0xg4TcZwmFaOXhY/e6EHxPpiXtU1DGcONRrRdPp12Vi1jji2YQ60aCbWIqOvRBJQEADfu9JWUUwq1IB0d4c7LJ7Wmiq1zCQLmcI+QlZ5Ng2fXLsePR6rYdniA/yonuxdEw6NVDUnshbMTpa2F7OvCtrS7OGa6o174PJSdvjKksn3BnBKPVKzq7mJ/O5+Zwn3JXCoyLQ/DV6kFHuLmzrdoOROCHP+V0+t8maWJe3ESrfnS9C5xjzlDHybXZ+rAs9eiCdNVyAkLm8q73aJCHWbAWqjUsRE6CKCG1FzE3CW4DXVOQmt0tNUjgDykL76lvFQKV3dnTAulTMaLaqaKG2aeeO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SSwWkEkdnNjWT1L1uwz8Qf/phyYwqNt787VauY+ISjEB0DKv1pMEPr/MQPcV?=
 =?us-ascii?Q?LTyfBnUwXN6tCG9G+vdQPmFuwnj3+ZMMQnKZJGbQyacQVsm2empYtooK59AC?=
 =?us-ascii?Q?4AGDnw9yGobiEMhVhDNWVb7yJjVzyT0DtBkHcbbNoFzsQASWsn/Vwbcj3uVe?=
 =?us-ascii?Q?o000v3+HWIGx1dGjWG0lsMyac1vToEhhF1jXR3pX6LQqrQzJv/ZyduRWQp90?=
 =?us-ascii?Q?ymzjQSYtGPchjnJaxPdfef+58SUIGT9nY1QN7hnS75js7hscqWhMW7BZDb/S?=
 =?us-ascii?Q?sGBIG6E3wjSHJLyQ7EA9Latuu/Nj/mqqWIA9ZoHzvetKEux0KNf3b37TCHA0?=
 =?us-ascii?Q?cio9HOLYNR/ImoAJ9ufToVvU2rNsWkTN8IQ5vi64dTn8DvcOfFxm3izvJbX+?=
 =?us-ascii?Q?IqGRhUIBUswGjk8JMg6tlaOXC2ZfWnCT9wAbHlJVGIjfCKVePx1nhSWS1Kk9?=
 =?us-ascii?Q?5ZaLDJmHzccxJp0UcMh4skqihY/8WEbI+zttvCRlUoAgUzj52X69hHlN5bRi?=
 =?us-ascii?Q?g7ixoawwY9FIxK/88EVbfVpGrNk51btCgRt1NXpkgztfBqvC02A3z987FMjo?=
 =?us-ascii?Q?ZLvsbD0IdzkxR+xv4wqCE5y+/Dek3NoGEaG4ztRPs/uxkd9KrDIOeY6+Qk7S?=
 =?us-ascii?Q?ATy8ajOYeXSO0OiFEtqxYDRDk7q7IyhmEx8U5Og9FNpacj84+U2er9jJa4nN?=
 =?us-ascii?Q?Dmt572ldaG/Y/UgRt8fu/I82frIlYWKAOWzH168OLcmjYeAbVhs40L4zHr66?=
 =?us-ascii?Q?d9mebKCdteh0ig4592wpjOA1cr1t4NNWgCXj0os9IzDLAwFHsp++CFHxpUV4?=
 =?us-ascii?Q?8L346e62zdpkHE8BgFct3rt79VZiuK2o6CmJzGf/TH+Ff9qi4u3h7phEXDKO?=
 =?us-ascii?Q?5FiA/DwFDMr40fIoDbh2XTfGrAz127PKinGIoMPFfjW0vqrJH+ERblKDcs3/?=
 =?us-ascii?Q?P1/PT64gYmGpsTiexVK/pfgNQCBArN83peYzAe6JtrPqC8GzSH9AYS3+U8X6?=
 =?us-ascii?Q?L2B0sLKTjXHELD3DSYOPmu1ZLEtugzBsULfMOM8u7JnrDwHGWueaWjYI7twK?=
 =?us-ascii?Q?BZXOvY2MwfS9HkeLsknwuUIAin1S0DfZ+AvxdJGEjYlUKab3GRbcHR6DSXJ0?=
 =?us-ascii?Q?wB3YKoYTd7USqyGsxzPlBvYFXxy11MfqHMQGx0TQQL6A7B7hXqXTpM6bs9Ph?=
 =?us-ascii?Q?V0j7vYwX6TfKUL7PX0uhu1pTJggsEYYhFScmTUIyashvppxBTa/Kj32mmshK?=
 =?us-ascii?Q?ECRMuTo+iuxrkJU/p8kA4mwRRVttdOl97VCZZTTXwzTBCHTK41qKIfxbBgA1?=
 =?us-ascii?Q?ENo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b366a-78d6-49a0-a90c-08db8916be8f
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 11:44:58.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2234
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On FDT systems these command line processing are already taken care of
by early_init_dt_scan_chosen(). Add similar handling to the non-FDT
code path to allow these config options to work for non-FDT boxes too.

Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
---
v5 -> v6: Update commit message (Xuerui)
v4 -> v5: Update commit message and adjust the code logic (Huacai)
v3 -> v4: Make CONFIG_CMDLINE appended to the end of command line (Huacai);
	Removed unnecessary #ifdef since CONFIG_CMDLINE is always a string on
	LoongArch
	Reworded comments
	Reworded the subject of commit message (Huacai)
v2 -> v3: Reworded the commit message again to make it imperative (Ruoyao)
v1 -> v2: Reworded the commit message so it's more imperative (Markus);
	Added `goto out` to FDT part (Huacai)

 arch/loongarch/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 78a00359bde3..49cb8e06f9e5 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -332,9 +332,25 @@ static void __init bootcmdline_init(char **cmdline_p)
 			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 
 		strlcat(boot_command_line, init_command_line, COMMAND_LINE_SIZE);
+		goto out;
 	}
 #endif
 
+	/*
+	 * Append built-in command to the retrieved one if
+	 * CONFIG_CMDLINE_EXTEND is enabled.
+	 */
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+	}
+
+	/*
+	 * Use built-in command line if nothing is retrieved from boot loader.
+	 */
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0])
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+
 out:
 	*cmdline_p = boot_command_line;
 }
-- 
2.25.1


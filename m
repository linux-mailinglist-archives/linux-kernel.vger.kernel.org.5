Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2C755A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGQEJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGQEJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:09:29 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2151.outbound.protection.outlook.com [40.92.62.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05944E5C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duv2E/SrH8micmphLQEAguBCG4u8RC79j+vZQLqmvqdcFBxOlGg/JSV+q8quMKwLlthEPmGkDvcdoIpKOPieBmkX1LOrFq3WrnpJY18XJM0pn2emlDsY2gjLdka5zDUx4ncM7NvzIkAe/JOHaih1QZtpbH5dPK+GAiI6oWbJ1tPPpM1SNPFqQKxbKRPBm2o4sWcLPcHa/+rQLKO5kCdngPtGcLbZLZR38b7k+Xhj3uM/SL743KatejCgrz2zGN4+36f+iddNE0t7ry1kTAhbwAT/KKrKOM+EUlAKeMzqPzy8ZsYXUWY3PKt8GJHBr7l3AmQLLGT+hDVq9s3Pl0jpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igZmnfifkENC6CTRV81llERce/mry1gsr3u1hrGWxo8=;
 b=TnElxQswfvC+7nOqkoa4Lay4ONhvk4dsX5pPb1L73nJgwLSNHEtnWFchy1zg/vFHqaWvH2KCNOtZeYXzoahs0kzP8jizqvDirmT19mXdFlPcM2AMa+plE9NwxsZmpNllT8GtvA+QzDWaNkp9KDWz5rGklCWW+vO9hw+0Nc0s7pwFVJ6eua/uWjE5UB9bFbCdlIM8IvXXXA7zZL/o3ELnojYh5w5v9H0VdDuu4AjR+jt1B5GQPExzG3yCShJoRauJ8AmbZc2os8oLc6n4B/3wZWJ/W2WjdlVJfx94L+AExymlkJKph8nnYlhX135qtfeorkZ25GJQMKTA+q5mY774vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igZmnfifkENC6CTRV81llERce/mry1gsr3u1hrGWxo8=;
 b=gaxURlJkZwsnAzY+Q/xb2tv176GInzxlxp7YnaLyxaAcjdZlUQHIDZYfgZBorfE0VUowgPc1BcPHiFqsiK+8j4pDIi+IxmH8b5aWEmvbpg1N44EFBuHZBW3g6yQVPsGHdEo29jsTVHmgytWZaJHnd2+ZW8eaQ1zRLFHp1PRJAwRrsiGjNv1wZhTTRpkB8ZmiAHLicuHMihrMkT1KqQTBsQosEfMdL2N/xypLCaC8yuszQHzNM6fuTeD7fFgKEpkf1iXsKMbwnK44gAr5YlrnqFrn1luLaZjryQ83U08BJhIhWzcaUj3SEtSdaxRPit7Mj6AJ5odjzdcC0fWSqWhskQ==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by MEYP282MB3069.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 04:09:14 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 04:09:14 +0000
From:   Dong Zhihong <donmor3000@hotmail.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, donmor3000@hotmail.com, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] LoongArch: Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Date:   Mon, 17 Jul 2023 12:08:32 +0800
Message-ID: <MEYP282MB2597514C7A4697A72F829B78D93BA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RKEzU21GUhIKkoULrDkKJfTl0RHekunDjubjMhymHVVMLfjYhazKT4rBQ5VZTAaR]
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:128::9)
X-Microsoft-Original-Message-ID: <20230717040831.3922677-1-donmor3000@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2597:EE_|MEYP282MB3069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1ebc5b-3b2d-4412-5f05-08db867b9444
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TX+98G58r7uyptP6GwWPkkn9EaKHxGJWUntCsuxeqf7fUisIKoFjjnocCS2P1237EfrFs2lTxSrfETQMEH5joQXDh2h3Pr07rTRszSs9jIAJjWhvOT5Z6Ade45iCpuDxQmvYrXl/MqSzMWKp3WrJgjZDPRCu1qZBRuqGV1/2kxrqj2Jc2Cq9bLvr5rR5HjgvaWa+tazZ6wIrnMYJS742anLt37Jke/n1nVLBMQLVEf8RRC6jwi+gtiK1/jus9lN4Wk9e++OjmKHVUtjZiW9JHHgOvIrSx7c15pEStO1EA7FCBKJG5MbEYiAPZ575lTrIoDmC05Tn/Dbe3GLBeFeEuucqXCMxP8GSVZtVKPoYaWpe8zsiKU/LfNJg8cSI/GW5yCs/fQhNy5pBkuEcvuwxTeWwAoslyH0HCalAoC+FgqlHW5tBz+wpMTgbCuKJtlTroB5cyXO9St/RZeLP/VB5BO48OQcRvWJHFkue0r40JpmdJFUsVI/Q/DuBlcBkTPKXQ7c88lVl302UJV6Neq3TLCCY+Vh/cB1OC035wW0IumiT7H2/gMTWw4QShpmaNHP9ByaYbzmoSvaisV7EGkNH6t9D3gHgxBdB2qLM70kKCv/HrZA3CaXdbQORv6T1TKGlx+GMal6QqOlpXjH7JhDz6Z/vI8cFiTwoFgkEhCW6KkVpeeHpab5nbmNEzdxFhUG64H0+nm2562FfKdM/nIpZ6WpzaFeHmISWFWh87Xn9riGsOZTEuM00d3/yD2R3jMH4fXPxwLqC2OGiDVmCRaiD0r7jHfK5Pqbxfc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IsfzT2KCECsM1x6UA5GN+PIupGv4CJp22kEoIoJZ/GE5fI943tKHEZEF9ddIV7WDbBCN/q5zEfmzoM1hbSnkqltL4f6R9PHg68kEU5B4U8QsMR4C/KxEka4jpLQggla4zQiDHweNVfLb6KG+GcKyqysOQhs97nz7ngEtMxsHY35L04Lf93KyjOvphPuLeqTGbInBhBwWn4WgtSszMSbP/D330LBO91qE1FnftCZXoTwrPepFNwNnSrD1vLu9MDnemmcEsqtOnAc3tzXewpa3X1ECyLxnyeOSxpitsXUzRemSkMRDxAxPUQdiMHbosVnih27dgWUXh6VzBilxH4ReF62QAfoHk7hy0MdzAxkHpIar8nSJ+rISeIT/FDx5SzMxdQJ+3IxyaLg7ZwcNrn6tD8ISZCusQSg8eMg3ccOD0H2YlPD+yfbQ2vAnYcbkbztZfrcA/4VCFqm8Q+0nTRiUGpQqaCqzueiMtt8N/thoxSEQ9QX8MZNq6H9dlzaLLw2ewTiJDAT6D5xCb1fvk1PD5Hkujk15ZaPVQfhKE48ZM1uxYRSZxe6K1ULeuq8KyRoY7Bxh7VR30/udZLTLsCYg+0eEWLcAaKBowQqrHD42SXSlVvFC3AKw2ggKLn2QLW/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohnzJRXMtNw0IqYixVvQ3lo9FztrhVYYOWbK6ecBwHchs0dSJbE42nUgzuXk?=
 =?us-ascii?Q?2sfICz/zriO0BnJnShLYpfgLZ7RcoP8/yhb4qMLErryr6mqL4Z3h7Eoskv5d?=
 =?us-ascii?Q?1+JIXbup0roNqaYNbreGTJ7pMJq8MvFNbBkSuUkCynEzMz0G2jVPkrJQNHOS?=
 =?us-ascii?Q?y9bVNGNTjBhZu5h2/rB9zNBqPN8MMNGlFZgiJiyW1mRS3YdwNLcVdu0LN9yt?=
 =?us-ascii?Q?kSfwrZWexOENIfo4uT49XSpFWOd+JSS+09U9uo87caRXbX5y4gzptsqcsNZl?=
 =?us-ascii?Q?pJLjknenCv+ipKBc7lTmFes5VfInHLvAi5Ki6sm9Ncv+w+Tjq1yYfwLiMbhV?=
 =?us-ascii?Q?kBlIt2DmQHTTirCxFUY+UL2V8ki+WvQ7K3qGNBG9CvB7C4oQrlYdTdMIAX6j?=
 =?us-ascii?Q?C8C1CrRyCo2XadzrhwWiep1u+x2iZQspSpnLxid25cZmeJWyMfG7JouwlJSN?=
 =?us-ascii?Q?VaGJ/nekvC6nYlwUnToTqmbykEZCHP3dC7w5KrJlIPqr93QVyk5zaBYOh706?=
 =?us-ascii?Q?DvRZZPA3tcYWIiMS/Hd/5Xwwzmpgym/ylf8ceykf4CQTECHTpDjER9GbjejO?=
 =?us-ascii?Q?x+nHZx1KG2oQuzqgRBTa241W+3v9bEKiM6AtEmToauokOb8IR3n9J0Fp/ay0?=
 =?us-ascii?Q?HGvJnXd+EFBE5h7QIczUKaLJzvIUZozgr8xsOVhQM8QevfexvgAPi98iLVVH?=
 =?us-ascii?Q?uemwC1G515DN0AAq2rII3OpQUExXzgNbnN73MbikH7wG6bUxaaLsozX9UBjX?=
 =?us-ascii?Q?VLhhhbyHrFftaqjsqypQeKZsHoZT/tpo2MlIjvTAqM7QlxWgzmMzWGD0ioQ8?=
 =?us-ascii?Q?x0A7M8Ug9R9N55DdHRR4JwAMW5kSoWDBQ5Y4mcXVwncVbnTRgIW/Oqwi5xD+?=
 =?us-ascii?Q?kIk9P1SQyy557JxAx7K5o9Q8EMNrOkpBfEFeMIYZRRqucA47pwa/0RwS7Iil?=
 =?us-ascii?Q?+t4TtUp/FoORrPpZvMlD9kqFdL2a5Lo/RP1Vr2FOOmrDTTeSCqlbIoDCgMzp?=
 =?us-ascii?Q?aaNZrbxVAbKeAc6DrjI+MJz71JqDUF4ocmF54pM3dp1r38uIFaqbSVuxJdMQ?=
 =?us-ascii?Q?t6BHUrn6PLds/EZkhUq9GsJcIB7YbYJJ0E0D4LcKuDOAeGWbZcDkBbtiNu5F?=
 =?us-ascii?Q?qK3uTu1oHYdd/ZSBk2Hfrnszni0vnsSILENpbdkmOVs0aNXjwCRAE4Jjgtk1?=
 =?us-ascii?Q?5qTceHZiE+X0VsEzCyy6kTYdV3bUp06amSGd4d6AiVAzVAH5Wa25gS+RkMps?=
 =?us-ascii?Q?1L4XazsaIhNvQRaEHxcOixUghCI0jMLbI3NiosmFan9oDOekjTI5njK1TnB2?=
 =?us-ascii?Q?pxE=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1ebc5b-3b2d-4412-5f05-08db867b9444
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 04:09:14.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB3069
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

Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and
CONFIG_CMDLINE_BOOTLOADER. The touched function is bootcmdline_init()`.
There's already code handling CONFIG_CMDLINE_FORCE, which replaces
`boot_command_line` with CONFIG_CMDLINE and immediately`goto out`. It'd be
similar way to handle CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER,
so some code is added after OF_FLATTREE part to handle them.

Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
---

v4 -> v3: Make CONFIG_CMDLINE appended to the end of command line (Huacai);
	Removed unnecessary #ifdef since CONFIG_CMDLINE is always a string on
	loongarch
v3 -> v2: Reworded the commit message again to make it imperative (Ruoyao)
v2 -> v1: Reworded the commit message so it's more imperative (Markus);
	Added `goto out` to FDT part (Huacai)

 arch/loongarch/kernel/setup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 78a00359bde3..3cafda1a409e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -332,7 +332,24 @@ static void __init bootcmdline_init(char **cmdline_p)
 			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 
 		strlcat(boot_command_line, init_command_line, COMMAND_LINE_SIZE);
+		goto out;
+	}
+#endif
+
+#ifdef CONFIG_CMDLINE
+	/*
+	 * If CONFIG_CMDLINE_BOOTLOADER is enabled then we use thei built-in
+	 * command line if no command line given, or we append given command
+	 * line to the built-in one if CONFIG_CMDLINE_EXTEND is enabled.
+	 */
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, init_command_line, COMMAND_LINE_SIZE);
 	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0])
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif
 
 out:
-- 
2.25.1


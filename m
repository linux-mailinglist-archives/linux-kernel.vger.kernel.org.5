Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F302755C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGQGvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGQGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:51:22 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2173.outbound.protection.outlook.com [40.92.62.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653F1B6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5h13RhVzxe35ExQ393Iiyc0LFFJHHO+QlqhOGRmmGoSm3AAt9otMZz9RxYml47t9dUdmpUf7CLv4KVjQ4n1C1fcyAYz1+8RIxLldAlJ7NC0oq6s7fNMTp7Lpzfhpx24NPaqWF/tcV6PvT6NAr09qnRypfQZ513P1ABuHzTDDtAkm5auyoor/bMkAmmfMzNNQVIK1xUKlqAcmS7a/oLjKtGXyySMjN4J3enAd7jPqXU8hHPMGnOz4c8/IOkRogbcjZTSH9OFpePK8vtc2ZI+WyoFzeXA3ZSod5rwM+4wQYSGykNXo1aFZ5i70SV7cYk5VqG4P91wLHeZoSRECC/JFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CBKxSeT2IPYJC1b3mz4TYY/ak5WVyvO0cK3vrwlKGA=;
 b=XSeHEle4mXcWUiQ24RDyp/hB5EHJXvuXcJvkZno+GL5vvuLIuQ07XdlJ05MBnf2PRH6JOAAVwJ+rBSSyXS3VwzF7mzgqIRp9almCkhW94xTs2jc/+9jrYcXnnGK4tI06MkTJ9bhdOzHnsEFdIEiga/jypWHYJLwdb/TPRlO3KDkcn+NrFk+Du7HCC0/B5Em1qjCnw4Qzog7Lhp61opHQtPvA3Z2Ab2auZOKBoeiUuj7McXWgwY7sdAbL1V36vo623ZMXIN4WqF+gnD2wyb7d65Cg8dP9vz1U9bgQ5WutHBiQ6aOEbGp+xyj1iiOea7wmHZAhjZTmTEgYYmZJ8Uqd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CBKxSeT2IPYJC1b3mz4TYY/ak5WVyvO0cK3vrwlKGA=;
 b=cHSdCpn7tziVEsFnjxpzs++iUkSbD0GyCBpv84zgll5wvoIT0ZLBQOBVLyivz0+iUEwNSOouELmR5wFt4jna+daX4jNUrhC5htjbX9K1x49Ka9CrE7EeCiKrV762gLenR4fFzAArvVFuHyxVSK4Z/yYM86lYFfCuog03Ifk211HjfPMpefIHtccBdoEnI0/u8B276WsgNcPqyL6E8xkGQvdc9Xle1DKj2WBy0y0w3MPoli+SxXBdlbDKJfybgOESJAmHOi11dQb10qy0jrdW/YgsDlm1HX4NoMMI1w31kzPSCxmK5cJTx7EifAX51XpYJQbe0qWx7r1pKDy44ncnwQ==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SY4P282MB3956.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 06:51:16 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 06:51:16 +0000
From:   Dong Zhihong <donmor3000@hotmail.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, donmor3000@hotmail.com, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] LoongArch: Fix CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER handling
Date:   Mon, 17 Jul 2023 14:50:33 +0800
Message-ID: <MEYP282MB259720FF3C1683A75881EF02D93BA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [TIcbrYGyZ9I7VEZo0B/yKHSy6G3oIIohqvNOkrEgH8soSnno2qp39Y4SavZyZdvq]
X-ClientProxiedBy: TY2PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:404:a::33) To MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:128::9)
X-Microsoft-Original-Message-ID: <20230717065032.3926101-1-donmor3000@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2597:EE_|SY4P282MB3956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3313fd28-4a70-4128-2644-08db869237d0
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWYnBBcTvvGLqcpVf9fa5+uERbl/sKB6KaTjROB6miWp9ArHcSfCcmRQqa0mb3gvT2Iw64lThEoyBasCKeJgO3Vz9j4wLtKSu9DB33OC0GAbJT9OY+3hcd7BSR54DGdoPBv5JW1yl6Cf3gjR7qnckYZMaFu1OtGxr/XacFXoklWS6UahYlnwcj6jO0zR9u9Ks+5cIFpMPbUiJDyzhPoGQ6VZap+9y/CeXqOr5qQzwFE1jzXK0VzKOfL0oYNB8Ukx8HxWKYnN5P9waMKZodny98jfZ9Xvf8ouqXjaGT9UPi3A0ZBkVvt/sEycXJ8x9BxG3avxUVn/gruSHyFrG4OtekaE9D6og1eKjMcnYKXf06fo6ERsSKc5VP+woXyWGHfz2OkkQX45rtITlG3UKAnesX6FzLA1a90wdMcqFNCkxZfJP2VQBugB/jnAAcIhdSmcgFbUU/zAk2y53UzNfZkHcF9Dqm3595TNO6KfITJFaiAmt52Oejp0ieyiUfv43PrEqE/FFsMLnhnFg6tXt9h6zxOxBSW81wpWyBo7kHmogEO8j95Zf1o1tLPQbTkakT1kxELCsdmrATmIZptNpmBxGx+ln/FCGhlSBrgoGwLpjsuBbZWpG6rG1hFVRp83z1Cm85Wo2T1cYjcWFGwpJAiwpjxOIGYsTK0uea06TbnSGGp1oJiI97jI+ZE+sWgfmuqiakZqjQyqhZXqVTT22YlhtlfNBvYv7YS5p2Cj6G+ZzXuHLzTwhl5kJWU56epTXIaLona7iMNXIeiPxD0lDalk+5HjI69dnBfIG8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBZyUIqGB2/niIK2JbLl6xpLwtpNjRkM0VeC5eTJDhmcPjvpG8bD5FuBP1TDXPnIlnJvspMjz9HV9MwFEfUka5yMWDEpPk//htljzVkySZd81/Tf4FTXsE2CWGyqV85zsjp6xay6RZ2uSUkPSdzryZfNcKHgeOM3IcjkP/kdUActI+ZNuD6ypBjmwP2H46hpRJNG/x4+XuRe3qCSHAAtldJrmSDNfQwDriPooiKmidEjuARsAG5Bl8s5ex5j73ePLaXcnFfqETDE02QMxobXgPQ9jS5Ulosi7Q7D084D4Nh4ePUwccxiWv8lgrpEzZqreBOG/1ZApXQg9D8tv1TYvRKuSpgs/YQLqK3SZJrNJJYaiiBygRQSWppA+E37DljfyAMs4wMB2PtfOQwMgNo4PybINabsl6otJoTetsufDekIU315sg4guIkP0Y2vT3/+XoLe8pGtmD6o1LapjlFxP8+gMFEf8PqcIkdM+81q64521vri6RY7v1ZfybPKLZspaMriURgfSOSuhfxRq/0ZSi2b4RdNaPKV3QF9x+6R0c9PXFfY8Xb/UrVY8EPRTEPdvK1dUawC4kSYutQc77TALeqVTOvZZqfYGS2ydEBj4KxF/LBKFXA9jMRjpWaLVOgc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdkG/+1O31RDpuYQJhOG0GGig3+7lq+wBcRDwTaUi4QBjiLCkhwM7Krrr2Sw?=
 =?us-ascii?Q?VzT+VX+ZaS4agePkX98W+DHjDW1JfeniVa2fFfwUN4fwm1hrUKqAMOMNM5mM?=
 =?us-ascii?Q?U2csrCcgUgrO9D7ghx/Le0agDrenOKYvxIoE4A46HV+YfjuYwZuikkU50LId?=
 =?us-ascii?Q?xsd4TYLUy5kkbQo+999InqeNuVxqzKz6BMsgnOu+MQxlKEPCiWR8vjVMjMec?=
 =?us-ascii?Q?A7M7NUFPc0E7kOf1YgSyfoMFnatY+VOrbl6297Exvf37SCN5pfJ2IQrBVC3k?=
 =?us-ascii?Q?TNiNerfm2abRjIDuVLKcp0tA5UpZhuKx4UpLuLdEc7cIRxc01qgM6TNV7tPt?=
 =?us-ascii?Q?QA8SXEdqD7G2Qf0asbqBUVW+X5VaFCQvTrO++5SESL+0Dy25wXMaGOj61OSA?=
 =?us-ascii?Q?U6wfnPry6cbojU962hnW0wZnK2NbZkssZ/iUKu5m/7lMIYPv3+CzMuMDEp9K?=
 =?us-ascii?Q?KTMh3I9ZrtP4JVrcNBtvUDq3tIEqHkJPyGIl52awm7jqbUcQnjDxCbZF/ef2?=
 =?us-ascii?Q?0DuqAoQoOA18frk3HVsq5UkEQRr8tnYSbPB9ofvIBgmQE/9iI4DT3iYGojpN?=
 =?us-ascii?Q?V11XvkY0p7uu8qbSRYdvHStvtvHhjLmJqkhHkLZDMxnAmbPe8KHJB/Gz+Cpw?=
 =?us-ascii?Q?P/gKhaGvCEwl2NzVAiBLo0vpFTyr1+70uDrWm7MlQl9Ch22QCu1reu2+V+aJ?=
 =?us-ascii?Q?nWPqmpcgn8zCJdjinP0wR8l1ioBCeGc03UnRYAGwWc5r7TqCMM+2PT4Tw1ns?=
 =?us-ascii?Q?qSUezi49yIFpiszKo+IE4x+Gb96MgmgmYzWMoFlPLM6KSRz+tBHcwOAiQ566?=
 =?us-ascii?Q?KrC0+1cPbLEo6rkzKDCL29QDCUXnw9HqOzag07v54TU4ZBgLwqej2W9VM+Oi?=
 =?us-ascii?Q?beYpGf1M/2Zf+VZAmBfFwOkmYX3Rkf4yyFpOBtzYx5iXcT84BNcZsdVk/nhi?=
 =?us-ascii?Q?C/nA7K60DZvM/Ny7bkGhLvSXcgkmx3Ej85yy/5zeS1aP2MA/THVXWCn+dHTB?=
 =?us-ascii?Q?nRlDUg0JI1wQZrFzNijcIv9nie35OT7p3Vu2btyML3JJMSxhM8la52y7Hd7z?=
 =?us-ascii?Q?kjFZ/Go4iihjiWeX3SOGy5gKdaxUKhDwo/AaqRS8oONKycbgFxxf4je65Zeq?=
 =?us-ascii?Q?XTyDVE3CMCV865XQrAXYqp6qIe6fizaEKe+kuNQkCrCTzcuAX4xLGd74zNdZ?=
 =?us-ascii?Q?m31rvsdmp5U4xAuDdKiHDh8uV0T1xkp5IWnusBm9Mb8jYm2bqSg+4D+FIewZ?=
 =?us-ascii?Q?dw6eIUe59Orhp5jJOwY/zLHUQLPWFOBfNmDAm8RZjccHDo9sDUELKaNW8eP6?=
 =?us-ascii?Q?ryU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3313fd28-4a70-4128-2644-08db869237d0
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:51:16.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
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
	LoongArch
	Reworded comments
	Reworded the subject of commit message (Huacai)
v3 -> v2: Reworded the commit message again to make it imperative (Ruoyao)
v2 -> v1: Reworded the commit message so it's more imperative (Markus);
	Added `goto out` to FDT part (Huacai)

 arch/loongarch/kernel/setup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 78a00359bde3..a98f33553acf 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -332,9 +332,26 @@ static void __init bootcmdline_init(char **cmdline_p)
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
+		goto out;
+	}
+
+	/*
+	 * Use built-in command line if nothing is retrieved from boot loader.
+	 */
+	if (!boot_command_line[0])
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+
 out:
 	*cmdline_p = boot_command_line;
 }
-- 
2.25.1


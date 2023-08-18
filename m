Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A51C78039E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357170AbjHRCDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357164AbjHRCD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:03:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BF30DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jysoNCFAomVDpJZDAOH0jzYjlVYJfS5grmSSG8OHwhrd9TG3w9UTO81d6ATsEbwOaXvXzAZBzqyqK+Zu/u0WoPE33yzAyv/fNBoEd+db5eq0Hu0kfidtc6BmTNejUG0/PwQvTouZi1QJkO+93lCFznwNWEGEgcyL9Hx8b0Nnfun+Cg2H0hOvNNqTi4P+P6a/PYLuQ0AysuPkjzR2+bCndfjH5mPP9lSIJimcTV471FY4Z4huMKyPUpLpj+c5BAhuP834f2NEGDMSDn71D07E5PxCkWRBMCr9FUQMi6lJIbTs7ofhcEbwWl5LbCoFXzo6v7AdlGW9XgrQU5kQWpRKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNpnzVwjjyxtELgMuRBAyCA9ttxX+fXKC4GcTcSLrXI=;
 b=BYkARK883QFcM0Uuci3iO7R1PI6qxuJu0Bq2HJpjwCnL65z3K2ajWdACebc6yHyzCYQAgiGtZjlblirYipkix91hC9a2AlBVXe3rwkqcf05YXRzMAe/y1hnhUzcMOddGIJJDv3mSBZctBg8iQ7HFAKjqC5pKglpmKuVb//Tog3i8TzMHsLIueWAnLKZi6yhAw4CiVG4D7lbktNAasuOEQGk6T5IWsYXyvJESQBSgN/LZ7GOznY1DlLKnNZwDglaWHWgf9cVz7ux522wQQkb2MI56qEuiGqDQnOy1bcNVzaj42Wq3aSTdJ7Sn4jgrRUi8xIGxuOxqi4bI5lICBTUWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNpnzVwjjyxtELgMuRBAyCA9ttxX+fXKC4GcTcSLrXI=;
 b=L4pLT2q1j6GzLJY4lbXtrUNWOqCEYjEKeQoWRTHIGBDE3PRu3tRyQcyAIXCXkas/ffEkfBZk3dJ4TwfJGCH0iofjKx9riZYaM1OSvS8pd7oPV4MHrcVAhwByOnteqO3I4ZaxX+WTfuMhYT350Ad4XUMbkjeYEyNOSpyyIO7yTL60UjhhTgA3FtOvK5RA3WiiyyY0dPjsGa89cMHAuppgI0yDwXFy8v+v2TJ29mjf7NG3UiPRw0Obyz6OKAM7C8sWzGM/a+CEcNG6j3irsjWbRvil0Lbe16+DRa+aA3HsTvNroKh0OJfBs3AY7Wrejsb6c6yoUsD0k4omT7CkOKKArA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3227.apcprd06.prod.outlook.com (2603:1096:100:3f::10)
 by PUZPR06MB5817.apcprd06.prod.outlook.com (2603:1096:301:f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 02:03:19 +0000
Received: from SL2PR06MB3227.apcprd06.prod.outlook.com
 ([fe80::820:ac7e:8524:1bb6]) by SL2PR06MB3227.apcprd06.prod.outlook.com
 ([fe80::820:ac7e:8524:1bb6%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 02:03:19 +0000
From:   Qi Han <hanqi@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs_io: add do_clearflags to clear nocompress/compress flag
Date:   Fri, 18 Aug 2023 10:03:03 +0800
Message-Id: <20230818020303.20337-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To SL2PR06MB3227.apcprd06.prod.outlook.com
 (2603:1096:100:3f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3227:EE_|PUZPR06MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e6641e-eefb-4595-0485-08db9f8f4a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIfa4aBwILtZr8T4mDAcI90YDK0FLvzoF0QDkHD5Zccni6mUNWwCXD8MeEsqnkM/ODwOAv04Spu6FjmKSTFigr5RPFWj4HfYYDxTAqISh7kvqG2GuXQ7Yw1eqgsfrxFgAg8ZP+El2dJhEqOTCx51c9uEReAUuwwq8cIvFzqbHEKANFZL8aO9rbtkzVLCgdS44eryiCfOhM83dwL8HryfTtoQ/vscfZwwVtcdt9jX713rco/npl6erfRcg2Hove9mewwx2G+gKzO1xFs7DWTx4PTkZljJ7VNNHcfD9mi4EagLAwEirGuilblfB/OViCGNm5SS9QE2KVVpduH9QwUzCz+nrk+hVapVMnpXPYS8sUeLMxBY1XUreTVfW2oaoEn/QsM+ORtJwYbG+pF+/IJ7hLAJtKjGvRPdQafn2Q7VXhid5ce4WKcDBX+C7Xoztl2Au0PEf6ORBP6p/fcnrAKwh3BjKpa3Btgt4YZZz0IUq8HbnV/M+DYKklfK4iDlTMt4KxtcEUlZydnR/x08BPJh7+a54zr+12Dlfj4DUchCPgM0VaJDNyTDWhNXs0f7s4YTFEPqnQbvDNvW7Cv1dDBcVJ6QytDBICB2Z/ZZAd2a7ASiPUrEzOjgHamN+inIp/uY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3227.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(186009)(451199024)(1800799009)(36756003)(86362001)(4326008)(5660300002)(8936002)(8676002)(2906002)(41300700001)(1076003)(6666004)(6506007)(107886003)(6486002)(26005)(2616005)(6512007)(52116002)(66946007)(478600001)(316002)(38350700002)(38100700002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqkeMrdOgskInzfQm8CGGEQfIljodHw15QE9Nouqa1e6bTOGFBgO0Wz8al0u?=
 =?us-ascii?Q?2EwJDUPVmzL0eaI2QTCapBrYPmvaszk9OHe9wRpN6RfEHN6unet9A18NnbxA?=
 =?us-ascii?Q?4izLtosCOTLAOzGHK6VNPZ2FDOXOEUeF4wxVDdyVuPXKOwABTraTqLG8oU8u?=
 =?us-ascii?Q?QUpDQg/T4fOMNRe8ZdVmeHWsSv/jSlwEz4cFTJPjWolLkAViBXCfyTU7jZpa?=
 =?us-ascii?Q?HRlc8/ezmY9COwS+msxjpvX5nUGige1Ezz0COPAqhZamY41m2uUfBYFhezgi?=
 =?us-ascii?Q?we6JyYjN9ZeS0KsWNMCDaBcgqPhm0Vl1GQoHaJTtDoufVd8s3WYAd8E1wc3w?=
 =?us-ascii?Q?ulURQDGQk5QrcQvRw0sdMslzwfipZAzZNcZpolTi7kbPmiUXtFZ1zKNS9JAs?=
 =?us-ascii?Q?zPW4ESlYrE3JEXdo9DCn972+a4s4q/H/uoEHV9SIwg1+fjJl0kwNs866jkRE?=
 =?us-ascii?Q?f7S3vL5Psws+2LpZveibWiIfzdO6iINKFSiPNe6Y6DRR8pgF3DkkCviE7I95?=
 =?us-ascii?Q?c649720skvkwOMDWWsV9/SuUz1WeKznMm5lVRgBwRl935SjJhubnwlEl1Co5?=
 =?us-ascii?Q?ABqQhzD9wOZMiOfvmeM8UHb9Qhh26JRgJJ9tyzS5FiOxkC6SdWssTDePCx7t?=
 =?us-ascii?Q?HnCrHDgsFX8oHM/4oBhRe3HHB/h3cHz52PPvKT8o9b7+iLBSeRyHokwDLAYy?=
 =?us-ascii?Q?6R/8PvDKAoSyLwcc2fZo8oXn5If9jFczXyqhHIvbYe0iyX8Bxi0o3IUS7jr2?=
 =?us-ascii?Q?K5b1aqoopkiqFqxpptgfEX1RhOrq0DKNzXeS0CfA+talxuXATdHicamWQB2k?=
 =?us-ascii?Q?JC+Isbn/HVMGIuTPK8WEbWLvlDnfxCn4MhACIyRTn4ex02XtxqNyInijx6Tv?=
 =?us-ascii?Q?P3A74XE43K8Igh0ieTelzQUxrpjlfeG77WEhF1Fa4FgjY1VmaXPh4f8d1SmP?=
 =?us-ascii?Q?aw/9zSQuEiHNRLalptYDmbiXJSZvDUBkyIuxi/yeELo105IZ4fV9H6aWs4+O?=
 =?us-ascii?Q?LQ7dDyGP5t4FEvvhpn4H1ql4qHFxYMkLIMun4UmaP97HUzZPJCO/BERfVEI4?=
 =?us-ascii?Q?zuNU+WO+oDiMICSwCvs7z1AHaf1BbFONCaoJGtiIBIiaK5H475VcUSGVLBwW?=
 =?us-ascii?Q?e2e+QF6OYtQA9hjPUrQr2Y3VHSlOqFhCP/iAa2J6w+2EWDMtUU6nlik795jV?=
 =?us-ascii?Q?l0DFqDEomfP7Z51EWPc7QEjNfHPcZmBAe7qu1AkAwnn2tyaWiOiR/vNo/Xhz?=
 =?us-ascii?Q?tc64AEHJucWuQo/zKNc38eyiOyeUjRwGBIBBpWwjYPbbQRIgxqAypbRXwP0v?=
 =?us-ascii?Q?IoHxr40WCrfkHEGCzcnDnkLLQBDM64LCtu49c4jLcZWHBOQZitcwDUjBWIhc?=
 =?us-ascii?Q?qrL6u/XtbA40Oy+mbWSlgOBplF8jWJMX2znbjQveIt/XSYHi2EAGlYilfbPr?=
 =?us-ascii?Q?CinfW20XCd/ZHXDWXtphvs9qXTSxOg6mX0hHj9KxdocqrSkZH7hX3SIOCVJc?=
 =?us-ascii?Q?OIMyzw2Qasp2hfcIu7j3FodxHc0TIOkRa6UxE6QMchYWCek7LUFk2x5G5t3q?=
 =?us-ascii?Q?Pa/mzICkh/tkpNYJR4nlXLZpXvMLDkJWYnJLS2pZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e6641e-eefb-4595-0485-08db9f8f4a69
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3227.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 02:03:18.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y57jwPVHfgz2mb1q+o/57CDFHHd7XzeTBXjqFwQ08iyuRQQuUn3fm2JRLdehd+arEoKD5ZaML9xhBokn2UFsAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5817
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align f2fs_io functionality with chattr +/-c and +/-m, the
do_clearflags function has been added to clear the FS_COMPR_FL and
FS_NOCOMP_FL flags.

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 man/f2fs_io.8           |  4 ++++
 tools/f2fs_io/f2fs_io.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index 450f1b7..4ffb28d 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -18,6 +18,10 @@ Get the flags associated with the specified file.
 Set an f2fs file on specified file.  The flag can be casefold,
 compression, and nocompression.
 .TP
+\fBclearflags\fR \fI[flag] [file]\fR
+Clear the specified flag on the target file, which can be compression
+and nocompression.
+.TP
 \fBshutdown\fR \fIshutdown filesystem\fR
 Freeze and stop all IOs for the file system mounted on
 .IR dir.
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 73ac700..a450bf1 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -330,6 +330,42 @@ static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define clearflags_desc "clearflags ioctl"
+#define clearflags_help						\
+"f2fs_io clearflags [flag] [file]\n\n"				\
+"clear a flag given the file\n"					\
+"flag can be\n"							\
+"  compression\n"						\
+"  nocompression\n"						\
+
+static void do_clearflags(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	long flag = 0;
+	int ret, fd;
+
+	if (argc != 3) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	fd = xopen(argv[2], O_RDONLY, 0);
+
+	ret = ioctl(fd, F2FS_IOC_GETFLAGS, &flag);
+	printf("get a flag on %s ret=%d, flags=%lx\n", argv[1], ret, flag);
+	if (ret)
+		die_errno("F2FS_IOC_GETFLAGS failed");
+
+	if (!strcmp(argv[1], "compression"))
+		flag &= ~FS_COMPR_FL;
+	else if (!strcmp(argv[1], "nocompression"))
+		flag &= ~FS_NOCOMP_FL;
+
+	ret = ioctl(fd, F2FS_IOC_SETFLAGS, &flag);
+	printf("clear a flag on %s ret=%d, flags=%s\n", argv[2], ret, argv[1]);
+	exit(0);
+}
+
 #define shutdown_desc "shutdown filesystem"
 #define shutdown_help					\
 "f2fs_io shutdown [level] [dir]\n\n"			\
@@ -1464,6 +1500,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(set_verity),
 	CMD(getflags),
 	CMD(setflags),
+	CMD(clearflags),
 	CMD(shutdown),
 	CMD(pinfile),
 	CMD(fallocate),
-- 
2.39.0


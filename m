Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3BC77CB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjHOLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbjHOLUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:20:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449619B9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaB+9hO21AKpFNreTKpPzICK1KFk2yf892JwN7bzpxrEajyKeO7YMMZd6mzC3oPnheTNSnVV/4y20Gcl01SPzt1ETimBHu1l97FcdHP+cBwM8O+VveTxR+c1vMlF92iopmFNxv5G2LXKJD8iCu9hMgWNSmNtb9COSzv7eT86oir/rWt7C831RodLBmPfb062cBeQMjrOKCqttIyycFs92HcsuTWXv2/ttxbtaPwehEerztLEMQaZf2fZV4Zff7qDrti35giZXo5OOU2/ZuGhFnw7fV7UfVy9CNQjATe/JmYRa+Ad6y7ER0siylMFoq3T7PLG1n7Jj5BG0uvxEZv5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAIhZjfU5ab3zLESPAsi3bcDj0iNHqZIy73PFk8JBzs=;
 b=ATm1j+14fKfNOHcB9lengtRb468DqQ2sJfru1NriAZsCPGocnqH0a/2KAd9TUFWQzwCPsP7yXQZjQLg1AqytAMk3i2LdemLZiXj1tAW8ga8fArIqr6+n6q1dsb5oJDkFRs2eYxWKoqkgFr++fKsjzIzKdpYdu0WvvbftXvPIA/VJxF2dIHTVQvbWEP749BsUUH0Su0v8Bfd4njCVcr90jQ7q6BdiujxIRMoLDssGVZuF+EzmosPCPC/E899tqewBV/K8NPjcvqw2+JF1xeRhKAUmmfYqOsr4C3rwvTfbTZsjY0E43p1XS5qE/hgBT0+fsTAkfIZtnO2dz9liV7RGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAIhZjfU5ab3zLESPAsi3bcDj0iNHqZIy73PFk8JBzs=;
 b=Bw7V8dAqaAklyfVv5X0Lqel0mSo0aaiLhmE4D/6wHBwEaskq/ZnqNQJGMdVTUT9Q/e44porlfJseCkPbUd4ZSgolqT2sGv2nvXx0CDaru+49+1FhT0DPIUuGgbdAvc0dkMeUHVZYgE6Z2CVCkn4SzZzAWo4Fg5HXHcnRLu5lFm+URQYcsRL1S3Modk8oDUiiYalZafmNcuz5CtfkpceHCofqpL/lzhD0M/I6hFb5mabOn9DeHf4tINkcLcPJvl418dWBtAODRBVPtci5DHjz2ja+7wjHJ/AC8iKF56bQ0e7UeBHNjwzPXN24BcLaNPdPjp2baxQmoa5Ls3nViLV1MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3227.apcprd06.prod.outlook.com (2603:1096:100:3f::10)
 by SEYPR06MB6310.apcprd06.prod.outlook.com (2603:1096:101:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 11:19:45 +0000
Received: from SL2PR06MB3227.apcprd06.prod.outlook.com
 ([fe80::820:ac7e:8524:1bb6]) by SL2PR06MB3227.apcprd06.prod.outlook.com
 ([fe80::820:ac7e:8524:1bb6%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 11:19:45 +0000
From:   Qi Han <hanqi@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs_io: add do_clearflags to clear nocompress/compress flag
Date:   Tue, 15 Aug 2023 19:19:28 +0800
Message-Id: <20230815111928.31542-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To SL2PR06MB3227.apcprd06.prod.outlook.com
 (2603:1096:100:3f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3227:EE_|SEYPR06MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e58d57d-ac23-44ea-077f-08db9d818727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lgn2hr0z6og/am53GI1IoYOogkGieWNFkDPzcIg5idx2tiIzuu6hWvDDq9czEt8RrgRFjRFemttQRjuBwjXjfBBS0wXGTFT8wFbFQ6R9jj6c2KyFYbL6LF73y1OyQG45SI7ZDz8VfD+g/+Zp9GK3KaAr19mbinwFOMbOIy35C0FcyP1syGp3HSgp/15DrGmKO7dlJNeio4EnW51GXZFQOBJBPc+DUmDTq31x6XvqS95EzYj3+vm5XtVHVvrQIrDa+Rzv1qxFdf4Dtp0T6g19l5jJkqKEsgQptzAHYho5yRGEq+Jn77MimAHo46GNzcgZ6vBACOnG/nCXtSTYlj1MEvXx/XdJDda21yBdDP4DlIkIrch4yXTjHpQVnr1OHh4j6CvplvJtb0OVHAgMrDqUMYJ4aK+6RZqCCD16JD//NXMiUcKKKbD2IjWdRUTtiNIalmXhwqvE8V20xJhL2emspoREYzHq4X0Wli9tJDopUrTmaTN/mU1fMXdd8lnBKhitdgsZwCbMp9PZvhPvOkhezea+rSl9j9mZ5YYguabOpNQ53XRqUsWpaxeJ/Tz+wym6XSFb/0/D1XyOOKQlDTmVDDe4Iq/nE45oTqyA2w+P6rpi9eDoBRmTJUyaCGcKf7hB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3227.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230029)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199022)(1800799007)(186007)(38100700002)(38350700002)(86362001)(36756003)(66556008)(5660300002)(66476007)(41300700001)(66946007)(8676002)(8936002)(107886003)(2616005)(6512007)(6486002)(52116002)(6666004)(478600001)(4326008)(316002)(1076003)(26005)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWVjKkdCVGjl4rrReYVusV8P68W9H5haQco+HkJoMjJjLMEzGfikmuI4lr6y?=
 =?us-ascii?Q?vfMudd1YIvChadwJptLkaq6rkiTYunFUtakP51gxCHFGXpTV4VLO9DDM4WsN?=
 =?us-ascii?Q?QR2CRYFLqQSeu9rWtXOBPevkd21MMsEqaZYcrdo/KqsdnhyPF7s9f0XE8GNA?=
 =?us-ascii?Q?lOyU3NIfD2lvmnxf4OgyD24aIV/pk6d+caGoDCBczMn9eUcnJVvoNUh2HXTd?=
 =?us-ascii?Q?iPmpQ7oNKnUya6U/WwTIYaeL2302jkS6qlArn4DYVfo2pN7tIrIdUWPk9xa8?=
 =?us-ascii?Q?zvDdb2BlRrf38639BDb9QhrXOJbcEjuWrcpnqOlpATMv9RlkepJQho2ooCjD?=
 =?us-ascii?Q?piPoTZ+Z1/qEQ7zOeNadqjgKJ5IZLVvuonz5qD4AODBKfIgkwHVAMHm4GNCT?=
 =?us-ascii?Q?tU0yfvgW01y/KV/kAm/9cbTkFDKIR33pn8q+CqGfKrLDDWwErAaHnxp8sRdB?=
 =?us-ascii?Q?ielxohzT6EZiKxvCdkayW3wbJlQ+bBCWFJbyoLDqiyOlKpJebH7Fq7STlr44?=
 =?us-ascii?Q?2+9TdllPVwr61EcckU1z+/fH2L5gJr8V3Puog1+dc0dO9Y0YWJUYq8Tln84w?=
 =?us-ascii?Q?sLxFIL9XMnbNYD8DfXWRlLKFS/tqAhZgsWhoJS7nS1qDn9KF37fYEDagILkf?=
 =?us-ascii?Q?52+7l+I7s68DB/4Wa9gxqkLVkPeEn4knFrTwRSL1isuJYfEv//dgU4YCsQX6?=
 =?us-ascii?Q?eDFkokmsqB99oqN4YHjutFeoqfj2FiRevnZO5qfarQ+IZ4TaVnkcX00PpOHj?=
 =?us-ascii?Q?AcIb9IAaENlX0UnEs6id/D0lfxaie+GW1/wnYNyZR6W6ZPkCX9G+lLkXz4eo?=
 =?us-ascii?Q?FN6bIKpNuVIxQlvWQJodc438KVl+DGm2UeE0GCl385ZYDY8h2eePDsm29uG9?=
 =?us-ascii?Q?Fn9JbGKEviv/qt+eCY0ho/LhsGHr4E7QVrtcW/8XPSWYiNbOqu3qFziphec4?=
 =?us-ascii?Q?1c8iruTJFzQRbIk+z+rrRHgLMcifs/5HrVVzpq5LVbNQqPujxwv61gunx/7r?=
 =?us-ascii?Q?yYGZF5OCl0+e/0qTSY0/IDNYiB/q+44PsJIh6io+bTunR/dV/6n5rl9tkQdg?=
 =?us-ascii?Q?lP/bZ2GvKD2EIa0vAQDk9xgqgwkA1P9rtsNu9+obQhn4AsxwmTUiBRiLs0co?=
 =?us-ascii?Q?Ekp577tdugMusp1+v4Jqipz/hNAS/UOQ302lYd+J/WORn+kW5ElQIjtFB1FD?=
 =?us-ascii?Q?XtdxGAL/jZpvk1wshc4ZezT/2bYThLAVBgVW43q7wHA41jBUOZIT3JOyCq+8?=
 =?us-ascii?Q?kk5igyUMuYMJOpuMKEHUkm/vlSrFYCJoh/CMwG45tYQ1/SttJ99vaSnzG0PU?=
 =?us-ascii?Q?sDCyF7OCq0LCyOaTmutmkWjpzeWYRIjTtM7VIJkfxjRc/E25bkt2vMiK2Bli?=
 =?us-ascii?Q?z+bgXFOAXTVbpzx1BDNnuKioGGjuTVDNlhWwsuNAR7UIT+/PoG/q09LkN3vD?=
 =?us-ascii?Q?oMJXWoCk5FyJEeUO5mms9D80Y5t0zm3/F4FKu1qu+mbYvo3CO7bRfyd+AQjQ?=
 =?us-ascii?Q?n+4Lf0lply2FPi4/dlbtLDrY8kK8D2x5Z5E+zYbfGEi9eqraMo2W6k6s3SXH?=
 =?us-ascii?Q?WgX33SIshbdEdL0lRcKIX5b0BSydszwqtoyEs2El?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e58d57d-ac23-44ea-077f-08db9d818727
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3227.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:19:45.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGV0UtZpsfv3DX5RZ05qZnQhIIkCHBXmmBtUfmm2ZzZGTJz4iV1vhCjv+JVsQ/KIt3oVJ3GQMoNKSJUb+ckOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6310
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
+Clear an f2fs file on specified file.  The flag can be compression,
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


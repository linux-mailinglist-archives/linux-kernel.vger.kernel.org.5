Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB337F09F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 01:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjKTAH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 19:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjKTAH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 19:07:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2043.outbound.protection.outlook.com [40.92.91.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F8139;
        Sun, 19 Nov 2023 16:07:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmO7kUXIQXs66/gj22HLG/y05IQy6Fr7K7k31GjSyc6MpOtSbxeNzQHhm22xcugHcl4xZ3Z5KMXlylOm8ONyfsO8RhTsb3FZMm+jG5DHH2OGiDCrEZFwNf7wQ53mzuqxw9PAETd8KMRjTVAL8FKjDHsLIqlVe3Za+hWBuze1+zuU/B8V4TufjDOEuzPookf88gtbaQHu3m2mF5PvENRoor4FBSvUlkK6SoJH/V/JuZIGW7A2KCT6lFzdDvC2Q6zwIodZTZr3zxZ8K/6oM7a0RNYJGXUzDeP0bN9zfrCs25zUDSPs3YOkPeTP770BhFUrPk4rXSnkK7ZIysm9df8Fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Rkp2+I3Utyu/eHj+COHMWxecxo6bl7BCcTTJMZuNOI=;
 b=Em2LzzvY6aG9tz+7KEgC8D2cqkoxiIbbp2EPXPLqqN/5C00gQ+Bvb3iP+wFAIdW5Lo4Nj6LlZ1mH0R+qpQo9VRDn9F9DDqrk0yjKJ0kFc5kcbiBWj1sfXSaUtrGG+XDcr9xPkjqWOI+W1maU1i8uKGAKcmxkqfvBvd5EgvuJwdWpzDeJg3mbv/ylw8cq0xs1mxxJl3g3NoS7BJbkj/evkj9Fudr74HdtbDhgZrpA951mAu+dMCS/GPSphG0GpQYeehKrfXZ2+9HnrsGRZfthu7tGuDiUJetFNdHyYt9tNxtqPTloqgL7qacNkltsdbBbIAz5OFfVvbjkB8vGdS1gfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rkp2+I3Utyu/eHj+COHMWxecxo6bl7BCcTTJMZuNOI=;
 b=Gnpf+8o3aAWGCQRbHeZzWsTunjMTUbAZ/TPp2+oofI/GrjHVRXFQpgMSLT7+jP3Cl8lXfdWOSlTn4g1fsbYLnPZ2Z2GE3POygVq/Bic3QZoD/656eC1Nq9e0ggZa+tGwEmN2R5OTY7Tb5n1SOQUe0rjtvlwgRWHr+/G1yWPsT52S3xl2KSEzp3QNW382e/Vg0j8jedafrbMCsNfyw7yvNmR8B5D2QIfwKjz0ZqZ7Rlopr/A9Xp5l8EISIHxueVa7MjRQeMSJNxkstiPpT2nE/htBcGXPVtPV+/3YOchoGMyWoF7j6J5kLU9NPxPxqyBRHGD8m0TUVjdC0xtc3JLCUA==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS8PR10MB6173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 00:07:50 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 00:07:50 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     kgdb-bugreport@lists.sourceforge.net,
        linux-trace-kernel@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/2] kdb: Replace the use of simple_strto with safer kstrto in kdb_main
Date:   Mon, 20 Nov 2023 05:37:23 +0530
Message-ID: <GV1PR10MB6563E0F8DB2D335BD9CFE4D3E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [psuvO/RxnQfAktTkYNRR2vXB7b3sNwWI]
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID: <20231120000723.360560-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS8PR10MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a542e1-b425-4184-e0b5-08dbe95cbbfd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLJpYYQeM6jMKkug0EVTRZcnTu3PfzlJMGYr8/l28+A420PjUkbt7PUzzTPoCH23fOoXjqk4IpSDdOxZaQHlZvYKstPpX59R32AH/9qpzgSG6FYg7zmmubDtuIlGUVzBv30PuXrOcMYehv2oBkRwkHhGtKcGX3MKc0P1/NYVqfXWRrI882LEdvv1yzV8wnNt0Ya+iPxwAWnPEpnhtjm/HZAhk8qRWwOgMWzwwomkeGH5tmMAbF44exl3X4zFHRyg7tVzdx4g9mKfsXjGWb5xBckG/HAoLT8xpu9H/PsuoAC9c4CmK+6DWRiAcNjKKBOtZabHDPYBKFclvsxg2EN32Mfa+69XnPgkYrq/urd/WX6fZgGB40A4uUZz4wIrM+0S2No2YhHrX7xFWTU2A4/lRXVlKRIirh4xJKr9Xbznuf9E4720yFVib7TkiQYVBqTZoqh6I1SHbc10wrDbPKrn+ylHkcCVrzaG4cuoWNJL5Y1nysle16SCSFQ07QY2qjPSXCmFCHNhct+A4+zvHylTDpKxULXAZBMEqO9Zqbkx2A2XPVIIcqne9nZwr26cpawiWZzTqFZlWX5rj1aadX4sX9e4hTJ4rgclf3OXbIFOaRYbKbfP+OxixRKae3P+0wmz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRPN+TXQfyXdEbXr6RNRD2yvqGyO3qhWhv8DuQcSbsht1QsqiGa7qFtrwgU9?=
 =?us-ascii?Q?u57s5pWLPbZceEbtv1A/KZ/3iQqZ7p2kmgk9EFgPyfqDCOHUVKry9Ohv/CFh?=
 =?us-ascii?Q?qysOW/t93jhqDtlAfDyVkkRkNKuIwBZeNOeOxjV2QbxGBI3yRin4ybuzjLLL?=
 =?us-ascii?Q?HAflv0JGB5F5ARH8U2g91ZBoNr4zSf4tWTeJh9RAIXM5et1izDcUvyYg+gby?=
 =?us-ascii?Q?5VPiNUOPgpIZa5ooBkJq0DppJBeQ5yLDB43IZu8DEDHlBlenijnpaJ1tAI+g?=
 =?us-ascii?Q?FaPYT64ukRhtUNzzzgJa0d3CFQsJnDEkKGgT2yNqet09neAwGSu9aSreBWqB?=
 =?us-ascii?Q?0CUGuCAsLThA2VT+Wzt3cBzkV+fvVKo2uCFWG7dcBwEv8pht8/xzbcdCMbHZ?=
 =?us-ascii?Q?C5ysExJHydvPZVosn7muWVyySukDwilqZL+rM7+yN31Htk5FLu4JuzssylIG?=
 =?us-ascii?Q?a8ywnY/PcitTJjj4CDtdYbdjBQtZDyj6btZkZbh5MXT/2JcQQpoZFCBPit+9?=
 =?us-ascii?Q?CgMWpjoQCgFjvEmDqe12XvD9tgou6Or5MdL4XjuEtukzMG4JCyujL3YboAud?=
 =?us-ascii?Q?3COSj5SIZNMnEg6on4mKJYs0c3XNzVv9qvILE9paw+fBd1FQvlJ8rZacfXND?=
 =?us-ascii?Q?yQiQ1w40/lcdNanOSmHpSYGw5ZpXesdKQXJfC7M8PQJ2zVLNPV3H/Q7ACtuo?=
 =?us-ascii?Q?v35E0fersWBgDbH36SXmnd3pIPj7p/X6nuROrBnjqekcTWb3AUjkCzdOHpzD?=
 =?us-ascii?Q?wMbTvKMtVxVltPAzbTk0dO+nEQQqGKIlkKkIzSOcYooFyM2+6RmxBjiDexfR?=
 =?us-ascii?Q?tRBoTuiK+fBxpsry2V7Y+am34etv20wCNY2Y8a3IPoMuKUwmYPSOsHOnZpAl?=
 =?us-ascii?Q?REfnKAb6gIeXmkDQFSoL6mB2R/aSR+mlXZ9DhfSJ4slbSqyMPxsCC4aQgJ1z?=
 =?us-ascii?Q?Aob+W2Sc+8yQwlpoPqkr3OME+wXyoqk8GHeUmH1C930Bfuoi5QUu6jJAQpak?=
 =?us-ascii?Q?QNJvh6U/XfupgOwgixlJgyJzClbtsKOo77P3iKBNLwoxKfV2eUwztNCyKVi1?=
 =?us-ascii?Q?EbfbtGVBW9axNTS2kbbz9hLXmPpwpVcSvFqYpIFfgppIKw/0x24nV/hpDbBu?=
 =?us-ascii?Q?c9pMuQbGUvjUFITg/pT72c6EzaNmtYV2E1cQdnt25j7/nszI8H1CIIadoMwQ?=
 =?us-ascii?Q?9hclxBzRX1PoYzdEpmn8bvaodOMn61sOFKyRYO/a19QtlOlFz6+SlPXPdSg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a542e1-b425-4184-e0b5-08dbe95cbbfd
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 00:07:50.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_str* family of functions perform no error checking in
scenarios where the input value overflows the intended output variable.
This results in these functions successfully returning even when the
output does not match the input string.

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch replaces all uses of the simple_strto* series of functions
with their safer kstrto* alternatives.

Side effects of this patch:
- Every string to long or long long conversion using kstrto* is now
  checked for failure.
- kstrto* errors are handled with appropriate `KDB_BADINT` wherever
  applicable.
- A good side effect is that we end up saving a few lines of code
  since unlike in simple_strto* functions, kstrto functions do not
  need an additional "end pointer" variable, and the return values
  of the latter can be directly checked in an "if" statement without
  the need to define additional `ret` or `err` variables.
  This, of course, results in cleaner, yet still easy to understand
  code.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 kernel/debug/kdb/kdb_main.c | 70 +++++++++++--------------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 6b213c8252d6..a6e4bec7854d 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -316,8 +316,8 @@ static int kdbgetulenv(const char *match, unsigned long *value)
 		return KDB_NOTENV;
 	if (strlen(ep) == 0)
 		return KDB_NOENVVALUE;
-
-	*value = simple_strtoul(ep, NULL, 0);
+	if (kstrtoul(ep, 0, value))
+		return KDB_BADINT;
 
 	return 0;
 }
@@ -412,42 +412,21 @@ static void kdb_printenv(void)
  */
 int kdbgetularg(const char *arg, unsigned long *value)
 {
-	char *endp;
-	unsigned long val;
-
-	val = simple_strtoul(arg, &endp, 0);
-
-	if (endp == arg) {
-		/*
-		 * Also try base 16, for us folks too lazy to type the
-		 * leading 0x...
-		 */
-		val = simple_strtoul(arg, &endp, 16);
-		if (endp == arg)
+	/*
+	 * If the first fails, also try base 16, for us
+	 * folks too lazy to type the leading 0x...
+	 */
+	if (kstrtoul(arg, 0, value))
+		if (kstrtoul(arg, 16, value))
 			return KDB_BADINT;
-	}
-
-	*value = val;
-
 	return 0;
 }
 
 int kdbgetu64arg(const char *arg, u64 *value)
 {
-	char *endp;
-	u64 val;
-
-	val = simple_strtoull(arg, &endp, 0);
-
-	if (endp == arg) {
-
-		val = simple_strtoull(arg, &endp, 16);
-		if (endp == arg)
+	if (kstrtou64(arg, 0, value))
+		if (kstrtou64(arg, 16, value))
 			return KDB_BADINT;
-	}
-
-	*value = val;
-
 	return 0;
 }
 
@@ -483,10 +462,10 @@ int kdb_set(int argc, const char **argv)
 	 */
 	if (strcmp(argv[1], "KDBDEBUG") == 0) {
 		unsigned int debugflags;
-		char *cp;
+		int ret;
 
-		debugflags = simple_strtoul(argv[2], &cp, 0);
-		if (cp == argv[2] || debugflags & ~KDB_DEBUG_FLAG_MASK) {
+		ret = kstrtouint(argv[2], 0, &debugflags);
+		if (ret || debugflags & ~KDB_DEBUG_FLAG_MASK) {
 			kdb_printf("kdb: illegal debug flags '%s'\n",
 				    argv[2]);
 			return 0;
@@ -1631,10 +1610,10 @@ static int kdb_md(int argc, const char **argv)
 		if (!argv[0][3])
 			valid = 1;
 		else if (argv[0][3] == 'c' && argv[0][4]) {
-			char *p;
-			repeat = simple_strtoul(argv[0] + 4, &p, 10);
+			if (kstrtouint(argv[0] + 4, 10, &repeat))
+				return KDB_BADINT;
 			mdcount = ((repeat * bytesperword) + 15) / 16;
-			valid = !*p;
+			valid = 1;
 		}
 		last_repeat = repeat;
 	} else if (strcmp(argv[0], "md") == 0)
@@ -2095,15 +2074,11 @@ static int kdb_dmesg(int argc, const char **argv)
 	if (argc > 2)
 		return KDB_ARGCOUNT;
 	if (argc) {
-		char *cp;
-		lines = simple_strtol(argv[1], &cp, 0);
-		if (*cp)
+		if (kstrtoint(argv[1], 0, &lines))
 			lines = 0;
-		if (argc > 1) {
-			adjust = simple_strtoul(argv[2], &cp, 0);
-			if (*cp || adjust < 0)
+		if (argc > 1)
+			if (kstrtouint(argv[2], 0, &adjust) || adjust < 0)
 				adjust = 0;
-		}
 	}
 
 	/* disable LOGGING if set */
@@ -2440,14 +2415,12 @@ static int kdb_help(int argc, const char **argv)
 static int kdb_kill(int argc, const char **argv)
 {
 	long sig, pid;
-	char *endp;
 	struct task_struct *p;
 
 	if (argc != 2)
 		return KDB_ARGCOUNT;
 
-	sig = simple_strtol(argv[1], &endp, 0);
-	if (*endp)
+	if (kstrtol(argv[1], 0, &sig))
 		return KDB_BADINT;
 	if ((sig >= 0) || !valid_signal(-sig)) {
 		kdb_printf("Invalid signal parameter.<-signal>\n");
@@ -2455,8 +2428,7 @@ static int kdb_kill(int argc, const char **argv)
 	}
 	sig = -sig;
 
-	pid = simple_strtol(argv[2], &endp, 0);
-	if (*endp)
+	if (kstrtol(argv[2], 0, &pid))
 		return KDB_BADINT;
 	if (pid <= 0) {
 		kdb_printf("Process ID must be large than 0.\n");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2708E7F09ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 01:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjKTAEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 19:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKTAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 19:04:32 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2083.outbound.protection.outlook.com [40.92.91.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078FD13A;
        Sun, 19 Nov 2023 16:04:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2j4sGzh+nO1T1UQioDthM/CMv8DXwIHdyaFfRCKVVYm+ZPkChUsfRxWPq/LA6etyubj4FX0bWqsdvvQOSHI3Mu0KhRO3UteZb3Vgc8j0hIBnRmHg/T6/o70vUpCSJHDz0IReQ2vyFYzzXBRh4kxqaWv7dG3rJgeqkHRwoUsMgSm/Q+EikQJTeb0CgZ9yuEwgIftvytg/Plo2R3R22LasXVbLj58N9AHQIRZ2wp9IR0WHVKPy41MOdtrTQjm3KfMgRUdBl8SvnxT/F5cVlKJYS+ke4Fnw65zYM+uUNA9HZgsI84JcBu/hu2XrHnLOACtvnLL0lgKEG5XYTtwewzn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g11QrkDSBIAJbZu88aqK0HXtr+sMeOnahGGAOP7xDk=;
 b=ARgxzccGXpo7/wu7I/0L5nATFM77j5SPYHxfvtDiVP5N61ULuCeKv2MNeOefnyNs4dKOWyR5xFeMyo7OSgl+wMMazIbtWzlN6G/2blCZnOnWx3mNflRIpwSurAx7qkLlTfUGYMymDxAOXLw+LN/5081vNWapORYgNAfSHqQwIHxZ+ZcNswtK/1ES1303T3BKtOwqRDr5ai1B/fmXNCMKloQFRQ+m2LIaDVn7XsvAaOPB8MKE4lszs07eKLbgAD+owySm98w2uyZPxMMJe5WOTusSsSugtRX1+S2W+uFtDBiB9AWmJJ16h+TulTaBN5lJFGXVf+TBSNN948fPq8JwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g11QrkDSBIAJbZu88aqK0HXtr+sMeOnahGGAOP7xDk=;
 b=kn7lFaMebzRdScMCXidmt+WtPpK+5x43aeOPiz1cADSH8RYPP3kB3kSsCdIdc3FgjZwwRZXiXA4CXWYMIH6JKxsC1xd0Gm5ThlB9ZxU8eeAgBCrfNR0e9Ls0a4YGDuF+UlcvehGgJZiGpBL44QzDMyfiUlL17vpm6UW2zyhncrc4I1tDtF/Bg2SHTk7Ro+SlPjYjiSTowCicHAoFvVRNDAUkX0OJngGdf9L3+6YkgL1vKc4Q6u/TtoPk7uy/iJMlMV42N7YDOlpazwcInjU6/5wCRxQpF5FCIOnwSbdVeW07XyPahf/0psegeodUE7zuYiHwMo17GHa6jwpeP+XChA==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS8PR10MB6173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 00:04:27 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 00:04:26 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     kgdb-bugreport@lists.sourceforge.net,
        linux-trace-kernel@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/2] Replace the use of simple_strtol/ul functions with kstrto
Date:   Mon, 20 Nov 2023 05:34:05 +0530
Message-ID: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [NYhL6MtTjM8EsixAEDVcXCibrIcaG/Fh]
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID: <20231120000405.360208-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS8PR10MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f0dabb-2e72-46fd-eb9d-08dbe95c4260
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjymhnWGZWRlgVJEUXTbQiRQb7jkVGxpC0Fhok4qonWrHOqHyCa7LyD8DrMdZ89/PxpEIKlJC4KZSvGmKGMnDz/nEkXe33LXxcltqlD3eWLdFhUljAgLo6sj/l833t70XDrLEGlBg+BtgHqzxYqSVZlWPRpHdxKRo0fEClwJSwUiHqWILjT3JZhKS4NVLvZQITEFvxfa476isSBwqI+dYIS4+i2OBjW2earpU9kzTS5IU3zjIKkDUGRwX0CXhRhcAC3EBRf+lm1IJCoFi/J7j9lowD4pltsGV9gPfH04hzChlnmDKhEdobW6vE5KbdNomnRV4afkvoDvzGp2JfrZAF2jsPAKRq4Qy0GQtrcBUtP5jn/lIgtoclUPNeTcQ1a8UfUQY3u1zE2xtN0xATjUJ4Fc9Lan1tuUEN64Lgl8ILWzzCJp//i5VwmqKb7YbEhYvBrW8QHxNrkVBzEcQkplmmVVdBbTOIZ23LyW1j5dP6yLWgJmo+1yF6HWtLnlKdPgR0RajK8p+WUlVHyJSVOxevzmFH0qlMTRQ9Rgpr1YbN7Q8NS9mIKjmV0SbF+6l9YQ8lhj0pXH3p35GBUkiyQteDAqx6YzQy2r4sa6ARyc9BeZpxW3EpyL7EFeG2FgwsS+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKuOYRPpTy8V38IEt3/OCCRhEph/o8CRTRApGUtm3k/PYo5JapsBaHCZeW9+?=
 =?us-ascii?Q?MVwZVDCQ0zstbmlLBS4+vxuT/Xk5Anm34ainASq7Rlh0r+wERorL6GG068E1?=
 =?us-ascii?Q?8HtoyHkJqwSrlAT85YO83h2qsfAASTjBbqvS1Y0TYPLQVwsaNaZKRHNE8csg?=
 =?us-ascii?Q?51DP2il2VU52zTLJTbCztM4Xf8sU/68JuAbyes9N2lL5rjz9eDNSay+FNSzQ?=
 =?us-ascii?Q?NmB1CBtwonfFTu5UVTF8p+rlIHTi16TKRNPjhx+15M9ji6KQbZx0ubvkAMB4?=
 =?us-ascii?Q?NB0k9BIFqIHYlCYDX15PmjpjrpkZMTvKJYVKZbFZBdyb6ng/M+6FKbEYqcB2?=
 =?us-ascii?Q?mg9xNCirFisLWtLlfRDmKOcyuohYdKRiUw5FUyEgRP4KkkyMLO8tpAun545w?=
 =?us-ascii?Q?XJywjnCrytfB50CuCH5z6twoiIaA+CnBZpG9PIQSd1OZFkVjNa01r5EgCuMU?=
 =?us-ascii?Q?38xnhELK32aZDA2J6FiV24wtWHkYw2+K6Xwd29MF8PsGADfiMGn3jSJZx8aD?=
 =?us-ascii?Q?7wPVM7WsvU3ESqEFzHfzvGpxRa6o9qrkGb7x8Xpyzc/TZlimd18Y685sKOBt?=
 =?us-ascii?Q?ShKwg6xTTVvxlPgSTeY3b5mcqkVxl/MTgoLYsXPIwLF1rBnuVzVZ4HcQnIxP?=
 =?us-ascii?Q?isIRVBHRuI38vf6OHXF3SzKlSeBynPeE24V8BADRlKmlz8QjqnOoa6gYGUGJ?=
 =?us-ascii?Q?akbNC71KGMo1S1LTwAfsapewdR8TKR6ql1p3b3aX0005dOP9cMTvj1v8ixFa?=
 =?us-ascii?Q?V6R2VEnZTzzx5uj96n06QzEcPKk3ayenoBsUQtzZwbPG3W856EvB38nN+5H+?=
 =?us-ascii?Q?9sOf0w1bumrF7yzDBvt7fo8NYC0cFeMzNo3Or5BcHZD/xif1KNAWTy7eZPQu?=
 =?us-ascii?Q?4/CmoD6SQMygToNONw/eUA/orlV9kvZumxx6y5H0m3eayiXBl2IX0v4rTEy/?=
 =?us-ascii?Q?WdZF3sVd8tUj7u2XYzhtpDio4tkSSdfpM4WfrlhVivZ2H99biBL8OPoTvWk+?=
 =?us-ascii?Q?ePCBJ1frjJkPwKqcrbsWEsscMi2S3Tr4pFA2GBvgZQNjW5psXkLtQBh1soc2?=
 =?us-ascii?Q?fCpXGgwr6YyG041Ff9Jc4nQNB8LCBbMwsbWddvmjupGG1dg21iKK+B45lG23?=
 =?us-ascii?Q?CAM+GkFzeNg8AVa/yLWVWOyXAqdCJgVdBB9pB20JFuuESsMP6HeqpQC1eDv+?=
 =?us-ascii?Q?NiCWayfiOF1SuJ1yvQWG2J3gc+mnmPNXrLx1ouKrKJXR8nZRexM9EK5Q9ug?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f0dabb-2e72-46fd-eb9d-08dbe95c4260
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 00:04:26.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_str* family of functions perform no error checking in
scenarios where the input value overflows the intended output variable.
This results in these function successfully returning even when the
output does not match the input string.

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch series replaces uses of the simple_strto* series of function
with the safer  kstrto* alternatives.

  
[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Yuran Pereira (2):
  kdb: Replace the use of simple_strto with safer kstrto in kdb_main
  trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump

 kernel/debug/kdb/kdb_main.c | 70 +++++++++++--------------------------
 kernel/trace/trace_kdb.c    | 14 ++++----
 2 files changed, 27 insertions(+), 57 deletions(-)

-- 
2.25.1


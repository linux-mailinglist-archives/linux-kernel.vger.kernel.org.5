Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCDB7F5102
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbjKVUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjKVUBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:01:24 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2022.outbound.protection.outlook.com [40.92.73.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374FA3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:01:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI9pfK3IzCKmskNuLLNjWKOsXkgT1qgimoPsE6w9Na3/r0eaq2xy9Dzjcr8CO4MqHx436SchNc2V0apf29gcuYn/XJhuBH0lieR6+TxOmeW8P3/lQDp2PM3mfm/5kthwWOseCOFtwql6WoASdJ7l0YyMzePcO4Hjuq+/A8dXV6z1kxm+ycZ8J4iU/2FseCVHZSS+Q6Pyt3n5KUzN1VrzQzohNQhzQmlyQjL7OKtkCI1ybiD3q0oxGEzltFCxDuIF0k7/VU8v/0LqO/oVDcHD8r6va+3NZc0BtlPG6stQYatX49nZJ7E/teHQgWUIkzclMevJ4dSBTUqk8n2f4vpluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku+6B/f2hbZg/RMFnqksMlwNqWlAh1NeLIbus46z+zQ=;
 b=g+UUrIULqN9hItuSOygRXZMgnNoeE8T7Al2rtYt2ujL/5n/gq1WQqH+BC4zMzLi7frvAi7fmCnqvefFh49SgzDqU7KWthU3zfgmrPaNrRw4ASOQ0VT6q3Q7me1DFgzSO1Ur2oa5RRKZS6K0jAvcsflyJEUpqqIFN18MjPLrlt9kkNjZKXqNLQJNaj1ynBw9uHg1MmmNo+/WMDCufYke+Qxj7ThiwQoHGZ63UpxL64+nxI1MPgCY50QIUfxz+lICf+6mI1WYSMetZrxz5S+20B7J4wvWW5l+gA2Inx3v1CJC47kjLIii/zjf3HiBLE+6GreWhLezOGB0v6JxLUVm3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku+6B/f2hbZg/RMFnqksMlwNqWlAh1NeLIbus46z+zQ=;
 b=c4Buh0RwETylyjx0EgNrPkGMKcKubiM7e/TCqH7BaV+tPfT6mu3AHsTCUj8gCt30IfE7iaILURIBLcfbA+6uN97FTf7GCEOkP2UZL+u+PBkJ48kwA4cc8vFIiL2yeXVxXkr63u6bFtRS1Z38zCvoqBqrZ+eqUa+iZNopMkEx25orNuilper2aT7yVRSOTITaP+6itYkkkPSy07EX9rFSUnNP8YyHgkEHDtk+r3apSIlUHOIt393HKQs0jcj8xzKYqjxvCMYwkuTzeGnX2CDy8VNsdqQgdVOTfwZmhNYI/WJfY2zRu0ZIjTPhAO3qrhJx/VbRXseazmzf6++aD8RpYg==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AM8P193MB1107.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 20:01:17 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.020; Wed, 22 Nov 2023
 20:01:17 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kfence: Replace local_clock() with ktime_get_boot_fast_ns()
Date:   Wed, 22 Nov 2023 20:00:26 +0000
Message-ID: <VI1P193MB0752A2F21C050D701945B62799BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [78f8OsnKq6VggDlHJdXdRclrcXszWgly]
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231122200026.105411-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AM8P193MB1107:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9e6723-a192-4f11-f7ae-08dbeb95c9e2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQAKRaIiU0gcqyk0DgShAMOy5HEjCltLkRQNeJ9CHrCE+vp7sI5YT4qJmmnjNpE6C6vboZxzf0dtu3spAdvzqRl7Pmk+bYwNQFOmuVcJCpkoKbWqi4VjAziSqSvI9JCYMQdyKo3vXMMy0O9urY7w/b1OzIn8j98w1q1/I8n+k6vApO+27uqh8RNR8+yC5sU6/g3/I//ATJpLuipU6Ke8fhNunyzwhLk76LuR95szd/I1o1QPbq29t9rZ6/XTBo6LoDPCgBGrNI5pGJv7dp/9bxM7aLhB0DaQU8oIRVuG+XQBYJWDYGppMakFw34EqPwFIHoELg9hcG/j6VKuC47+awQqVPlpskw3wPfjlcIhOcW6IyN9XV4GfI+yiFcqGNNv8pwlFmgeirtc3jlBh9QXtmLbMiNAmTcx+gT0kXkAFaU2Ctw/Sur5UbmF0Z7fwAZLWwM/qKAy7VaXIsg/Lx/FOCu7iqUz529hCXb1iERlkNhY7QeNmvzbBHcrkCTCeGNWTqUonOv7out/aM2M1vEnq7pagqP+Ve5oisdagnobH62WCMZr8p2RtldQ3fsJZd1A
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eth6GuGvWtSiV7pZfMXjwvMT9vDzXPBrOtul90+uwKNpIdxDjqAJDOSK0fh9?=
 =?us-ascii?Q?TJs0KqaOg2yBbJWG7Yem4LJ3WDxKIZAn8e3JYBOmFzHzws3PAvqnePAtzzIZ?=
 =?us-ascii?Q?L1QY+QkUtTSFgjBKZgEKAOTfuG3Bpyxl6YgAejUEgRwQM+/VXxDi7C236Yvv?=
 =?us-ascii?Q?PFaz6aRyQwiJtKphARUdda2M9QrgoJeHigJPGPzZlFbeW9iXaUpinyIYTt00?=
 =?us-ascii?Q?U38Zkae+NkBwU5cyLNWb+sW4pZeruc8yEfDZpLuAbw35YhQeXiYzPxn6u0WQ?=
 =?us-ascii?Q?0WIaz6Z6va+2ks+071KU1CATwLOSN22/F51O4FR1dx0M5NehKilNZE59P52d?=
 =?us-ascii?Q?BXUVevCLEdPs7t8zxNFDiRFY5EZ2Ks98ZIxDb31/UHT5BGVJoTK3Vty+U4Rp?=
 =?us-ascii?Q?burBJj7WPbEfEWrxn1c48F8LzOUCQuHW7rTDQMAxiLjjppec/DT6VjfSDDag?=
 =?us-ascii?Q?BwFrESAvaX6jkxGpCUCIcRmXTAyYNeLuI4sFqc7mzDmUFllofx6jWJ0nvGJi?=
 =?us-ascii?Q?HzNUkCn2R3I0fG+ik08g+0Aaes3uBo2vG4/Brj8Jy+HlPHS1AxWj1D5pFE8I?=
 =?us-ascii?Q?Ct0/W1U8nvSM6PZhnWGZAmVd5VGiMTnSiGsuPGf5bN0RJGCZ4pg5BDfHhXhU?=
 =?us-ascii?Q?qqaj1oJzO/+X+EB+rHKjf528WUX3Dwwwgyfytos1mQuSQrvxvqrvn+YonnFl?=
 =?us-ascii?Q?DPV24MZgiMXucc9RAMAHiwWiDm2u0x/SSA0lrWlb+bjJx1QeXVeHI4StvuD5?=
 =?us-ascii?Q?b2xDetXCHqlbpRZZuBKE/VxUB3ZJ3mbfWvrvbOV/F6OhoUOdUoEw0gJT1KzT?=
 =?us-ascii?Q?UbSI+bVpmQdzt74w2QPb+J8L6CiumS5b1iriS3RplqIVcud09h6hrO/YAD0R?=
 =?us-ascii?Q?jA+2x+CMmnGOjMfqidpCQjqDnC8RVp7SeKOfPDT7zKa50/Q0Y0rG+grzhSU0?=
 =?us-ascii?Q?rmAlUu6vG8rgDPWLeAhioxwtIjXR2t1G0zF8qEcfz1WZ7fqhrCI0wJWOP48R?=
 =?us-ascii?Q?J6gJaaRPesxN6kPO+4i3TJ1qNcyLZeGuWKLkMHyLxi/79vNox06FuAwVGsgl?=
 =?us-ascii?Q?Ou1XoKr0eqVXBi/UVNLOmdGzOzyBBIsAe2nshn0B0rPtQPHtcpWb52HhWgDO?=
 =?us-ascii?Q?gZz+EGrkbEpDL2MAxpaEENBlksuQ/XA5H5ypzcX40FBT3kU93oL8k1tzNO4w?=
 =?us-ascii?Q?bL7ZRsUpOPcFHLFQU5CwnxClflFwd7dLFWgtXRQEffQZVXBmrHSM07xcGcc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9e6723-a192-4f11-f7ae-08dbeb95c9e2
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 20:01:17.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time obtained by local_clock() is the local CPU time, which may
drift between CPUs and is not suitable for comparison across CPUs.

It is possible for allocation and free to occur on different CPUs,
and using local_clock() to record timestamps may cause confusion.

ktime_get_boot_fast_ns() is based on clock sources and can be used
reliably and accurately for comparison across CPUs.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 mm/kfence/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 3872528d0963..041c03394193 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -295,7 +295,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 	track->num_stack_entries = num_stack_entries;
 	track->pid = task_pid_nr(current);
 	track->cpu = raw_smp_processor_id();
-	track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
+	track->ts_nsec = ktime_get_boot_fast_ns();
 
 	/*
 	 * Pairs with READ_ONCE() in
-- 
2.39.2


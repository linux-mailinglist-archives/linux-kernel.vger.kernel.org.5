Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B431A78E7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbjHaIL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjHaIL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:11:56 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2159.outbound.protection.outlook.com [40.92.63.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7EE58;
        Thu, 31 Aug 2023 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YycYX2AIqlmvtI9LGmpJZNLSWULLMk8jQXR5+q6pt3j94+xpToazHXqfeBtV523GneAhrs2BdSCQaHqfZ3AScqehUXixTEA2iL/K4gTcYic8iyO4s6d2GDyW2HO8IrLNrdcmqZ5x6pwTdbMRwekWoypjvNUeutS/J2TRGS+4vhGJqh3TfO/8daicB8rAwXbLvByTfekZlFOEZZ6ZI6QF3jkrQjcXuqMbKeHObEzyq1DnZDE84o85HWXNtMxLwSXpuSnb5L3MMW5X6oyQ/LzrHR1pRgNrGcvXEIad2nicjdaaFUFGyINKRbSrrnvwz8qr9Iw5mWLnCVwadi8sb+MEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HMHRrquBkHdDxfCq9TkdacyyvWzcgv1i6Otl7MO1yU=;
 b=IIfW6BvMu/Mp+9nBu+GTXGUjNsYwT+cg71R5nZE9sgGGoSkkDKwfzdIGYyjRIqZLM4iOG5fTcUPrfjlZ/et5Q0kgcHQpuSGln6K0TYtfuCHnICB0vx30kPcrWew2FCoYPiWxPUTv4S4QYREPvLvzQtEcyVFN3XAR4Gc9qBnh4m6tDtvu4x6yfwEnxqMlfXf547Bn0smobkWCvOEGbyvRyf2jFMd6Y2Gm697mLxC34EglOZEn0cinbMZXM06vMO3j+B0idpWbSUg5ILKjoAqMaCbwJu321LUOfTcqQsMTWmD7NyI5XtZQvhlc9T1miL9juhu32SliyKS9zDFM+vW5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HMHRrquBkHdDxfCq9TkdacyyvWzcgv1i6Otl7MO1yU=;
 b=Di3il+lrISNtVL7oljKl+vqtqPT8KviNveZq7FOXZdwi/P5X9agZDDtuoGYYeaDZy4NqQgZsuYYm22x+zocgOXylgdraRpHQKKKlng6a3G14VIecw/iOemZSRvf0t2ToyoKg/CWItEDy2VQ6Gy25sIMLIO8MqSW8RJY4r7GBvZ/V/yuD23nDNletKrTSTkWRG0wE76aGLtxekEKfk8XA++34rRfbYvwkddFgjmiPn7X63s2XzUvcMoP+cORjW4dXhHJHnctew1r0mzPw3qy9+gMgoxu4xZuXpOe+NjlOmIRAiqEeg0u41WYq656OIYmz0Lq5fSL2s4TixnesP0c4eA==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 ME4P282MB0918.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:91::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 08:10:58 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::62ca:cc8a:e3db:1f2c]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::62ca:cc8a:e3db:1f2c%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 08:10:58 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     peterz@infradead.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        Tianyi Liu <i.pear@outlook.com>
Subject: [PATCH] Introduce callchains for guests
Date:   Thu, 31 Aug 2023 16:09:02 +0800
Message-ID: <SY4P282MB10848199D3F93AA47A845B8B9DE5A@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [c1vncLW2AR9MozWZ8tubht75zN203V6fqsIXXdca01pTNSOGsm/xwQ==]
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20230831080902.9722-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|ME4P282MB0918:EE_
X-MS-Office365-Filtering-Correlation-Id: 555e74bc-7a99-42a6-89ad-08dba9f9ce51
X-MS-Exchange-SLBlob-MailProps: ymJijV9pwJlABLGYt43ueJtBBtu40BKZa4WU8pYfCrH9IJReMd27yZPHp2W9fo5Tf2neb+ssx1wDx3gCkCeqJTkAtSS7PfplQVcnPFX5ifoKVwvQLEz5h3XPjDKV/zffnilZjlYYuHM+PQHE907ZJAReZpU9jPYyD6JlZuHyHSt1m5Whfd8NYcGe+3Myx8xQiPuLNh5sfMcppqjHxFgO69PbRBPO9apk77CLBXYeDsRK0cCNWS4N2nIpK1D6RG29PKEiM5EIKA6kmkMXtYrYVFRcxplyKa23hDDQZLUBB4UaS053zQD6BuCB0GSHMxRIDN+4sOsXrfgnBC1UOKCt/AK8X0/gqPa3wc2IMpIixnrsGeZcIikDbl3UV6oRhGIu0x4wa91EFkWCDnA2o+9MICoOjzZ4NGfiO5eWTReaJtvY4wkLD5Os9dgD8dmTQtD8P6Y/QNXR5y0aBg32Mcs2D/mmsLtGwdP8wsKk42Qu3369RCnTfXuXWPpoGZn+DdDJ6sCVco32jSkyj1hHj7A5lgFnnkSuy4hbk/aGxgI/KRr2AcrjeNWJeI3APAKTUqiMgP+TUe5ZmfgkqAzEd55BpU8YiW8ABfoXPuBw8hy/9Q8hB6lIeqxIWjQVlHNjJ0AOam40lLZ3CSQFifoPE0IOaMx/EKl7nxkCBMfkd829fWy9jg0kK7HXRxJwvfpIAmyJPuyyRVSOvMIz0fI7ZyFk8jwyRViEDxOfVHxjFIUDvCIGVD81IpOqDHCKEVXdlbElL/xep/oHKSjjs4yV6nrOfdLqPEQSczqyQY3E6cTxcvkXbBPHKE8arinu5TIs8XgC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2qDovwZol7aRqBSRm8BdAqkWb/2IkpLVBqOEyhMV5WLvDZzqnKtEcMrYoRIFzQHWbqdQI1WCdxnEJb0Z2F9T4yceHaJaqr1mpgRooM//07wazbXSaVx1oTAc07Cvattae5mARTTaAbrIR0v2GBYYLQcurrD4JRmjGy4RR3fY+6S0tNCiv05P+/r59PP1QYZAcJvJ5hF3sGb3gvTj5PuCTSn7zqRA8Te2qgkbkhpRIlTNu0/idOZx0BwqqR1gxziIB3ckNS1dx6XbMkHWKPR+rJVMxlhD/2YaSzTsx4fNNg3GWYR3xByHIqtHhOTzgGpSYSp4Y3epS8TBw3gjPKVlvAf9aycqGovZnHHNiVowkliiTMeRbQkgbBULB8IaEcwKmRnfKLtQQnXGSvLhdCpCP0oKhza7H10T2PY0Y5o24pemDhHujpgvwhooHF42yX3g1VJ+rAB6uZAu70S0ix0IlOnAsw/WDP9sNJoA5nqItqObP/zw7WYeR95gOUynID9wRhnUm1r8KfHXl6tF8MqvOi0CxUtTTGUYvV27Noylr48DIB2Zg3UPc0Ho95vDqL8pooNhPoyC5aOa/LYWXSNfxebsPetaRgtj2cHkl6d15U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GPM4Rv/4QUGyvRfRl7uV3zaH5R+MPiQldSAZ+4JVM8QlpuCcy+H60mqw8ux9?=
 =?us-ascii?Q?owFOEtjVPd7215YPEXDpz7q2WbhZvOO8pz/3JcRz26kvQvJ/g6HTdmqqKklN?=
 =?us-ascii?Q?b961e33N8VfpCx2HV/IIpcVDpU6pQYNwkiV4mxZiMEdtNMBtxrhsCrPpgF0z?=
 =?us-ascii?Q?juz1kCB3MAdKlcOzufLRF130oBAkmCZ1Vtn5MX9Ozsa+VV+me0fqdfjLPzSA?=
 =?us-ascii?Q?BvUEXC6wcmq+I13oc1KrooLuUEZdJbxU5laJLBKXfdMgbPQasW4tV+gDfC/o?=
 =?us-ascii?Q?Pz4VpoEvtSK/42d5h2i9M/3WmM26v0/aB/3euiqGBPHzYbEWcg+sVkQYOBaX?=
 =?us-ascii?Q?FfAE82AK8xyiB4fVbWZvx7YTj/tDhZCBovoubmLfQHLX4d4xwJgOy9pslNeu?=
 =?us-ascii?Q?VeQe56DFwt7dvqjFIaythQOce4+kEHiBsXUjqm03ByBvZEwgy00m5oWcyBRj?=
 =?us-ascii?Q?iz5x3v/vOGtLnB71iy9esG+e3YMUtRehXaKI4NEWXYtePXCYs9QKfaPVN097?=
 =?us-ascii?Q?22xZjvyVAYG0UqUaTQkVl5C3K5wctaWLILovcHWHzJS1aTzYPhnZlDE1dGfS?=
 =?us-ascii?Q?qsqpflPMvAU4VZzi/I/VmSZZv1fqc48ZZiE5X/p5Fg29QuLjhIqdzGM/VeP3?=
 =?us-ascii?Q?+7QOGOSMJjbZET7or/lYl9Rzj6MM4YU0cNhnR1xIBrg3A2P+jvFN87HB4Dq/?=
 =?us-ascii?Q?+gXndsPG72qcueGI96bRBPTJNyVVO+ZLoN8fmUzJrkOfpXnEEX6V0HXSYN+w?=
 =?us-ascii?Q?fWAqq2csTu78/J4JfX7XChq2ZpyOighaOcgV0ULhH4bU+pPuLtul+eRE1p0L?=
 =?us-ascii?Q?4rH6CitYZQhsisL9lljJY/pr07yN55fJafN5RBnTQJh6asOmKmKc8Nhq/Jpb?=
 =?us-ascii?Q?Rmg49E4nNldpGNd1EACqoRDsIIoAZns51Z0ozDfb6IC4O7jG/g0AMCato9eJ?=
 =?us-ascii?Q?6M0ZZ7kQC2id1Jc7nmLZ1rlxkgr3J2nTIlNDaWhiz5htLURBkXH1oQSPC2d7?=
 =?us-ascii?Q?vdbt/EG2ltLV6s6nbwE0S1ffsevnulWGZh8KZnTOOUGRWWO2USPHn9UcPXwn?=
 =?us-ascii?Q?0fmhPiqgaV5W42zhG9Oo1toG8OuwO0t5wy57gtFfuSqN3bmXQ+9rS4+xchlo?=
 =?us-ascii?Q?Y1YVAsoUefMe2uz7CVi1/0eYmbSJgqAGtTYVRMzq0yuuFabQOJ67CoNM8s1i?=
 =?us-ascii?Q?a2JDPk0s/DXj1cl8UO3/oGjNLPZXJGIRg1g6FqM9Q9DIW0vheZj/+BpXKbGk?=
 =?us-ascii?Q?Y4z9V5w5Jj0+vDWndbga?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555e74bc-7a99-42a6-89ad-08dba9f9ce51
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:10:58.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0918
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serves as the foundation for enabling callchains for guests,
(used by `perf kvm`). This functionality is useful for me, and I
noticed it holds the top spot on the perf wiki TODO list [1], so I'd like
to implement it. This patch introduces a `perf_callchain_guest` interface,
which different architectures can implement according to their own
specifications.

This is part of a series of patches. Since these patches are spread across
various modules like perf, kvm, arch/*, I plan to first submit some
foundational patches and gradually submit the complete implementation.
The full implementation can be found at [2], and it has been tested on
an x86_64 machine.

Since perf tools currently do not support callchain types with
PERF_CONTEXT_GUEST*, I temporarily used PERF_CONTEXT_KERNEL for ease of
testing and validation. This will be rectified once the perf tools patches
are applied.

Furthermore, do you think it's necessary to introduce a new guest filter
in the parameters of `get_perf_callchain`? Alternatively, should we add
two separate filters, `guest_user` and `guest_kernel`, to make these
filters entirely independent?

This is my first time submitting a patch for a new feature in the kernel,
and I would greatly appreciate any suggestions.

[1] https://perf.wiki.kernel.org/index.php/Todo
[2] https://github.com/i-Pear/linux/pull/2/files

Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 kernel/events/callchain.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..eacb6ccf7034 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -45,6 +45,10 @@ __weak void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 {
 }
 
+__weak void perf_callchain_guest(struct perf_callchain_entry_ctx *entry)
+{
+}
+
 static void release_callchain_buffers_rcu(struct rcu_head *head)
 {
 	struct callchain_cpus_entries *entries;
@@ -183,6 +187,7 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
 	int rctx;
+	unsigned int guest_state;
 
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
@@ -194,6 +199,26 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	ctx.contexts       = 0;
 	ctx.contexts_maxed = false;
 
+	guest_state = perf_guest_state();
+	if (guest_state) {
+		if (add_mark) {
+			if (guest_state & PERF_GUEST_USER)
+				/*
+				 * TODO: Change this to PERF_CONTEXT_GUEST_USER,
+				 * which is currently not recognized by perf utils.
+				 */
+				perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
+			else
+				/*
+				 * TODO: Change this to PERF_CONTEXT_GUEST_KERNEL,
+				 * which is currently not recognized by perf utils.
+				 */
+				perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
+		}
+		perf_callchain_guest(&ctx);
+		goto exit_put;
+	}
+
 	if (kernel && !user_mode(regs)) {
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
-- 
2.34.1


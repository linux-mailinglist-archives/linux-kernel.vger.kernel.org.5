Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095B57FAC75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjK0VTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:18:58 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2105.outbound.protection.outlook.com [40.92.58.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801041A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYo3LQ+y4r9JbvYAN/TafUiF3Jc1fWWFvcj7UE10v50WuOFa5R9fHqoXFRwr8YabPm4cCIhRpyVwdRjiQJvlWfr7h7L8TQOcyzSA9KZ//t3olEocdW6JHoYS3klglbchBfkuIkCoZJ8Bkypp+FTrLjxB+EeCmsOrpzPOmMklAezCot+Mfkp5OK+bK7p8S+Ou+LkhB0li92vK4H8mh1a2IWww86X6HOi44rWmVzuk0VRBog/BR8mbbXjbgzb4GGOedzUMamqhjyXmuPInUJxFH/ptZxXSIa2PSzhifrovOPoxXVwNj2R9iOUK9md2AO0Q0v6FJPv+NuxqEdGLX0q7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a8sAfnyzU8RwB1qe95F6+6w65cx/kPYT3PrEBc+32U=;
 b=U7IxAmduMxX0LEyLAmMwsi6m/t3vm0nf2xMAU8LSaZdFg4lhsBPgk1DF9/X7uHyJqAt4cgrKCv4yyP4yMEmmat0IJwrnJNdJu+02Mk/69BUJ9zhP2MiDEcpLEE3k4GGbpSXsRCGIRP6mcmkfpz0URangKbbtZ+phyKwZNVPi9ShL5+cVJU1p7DbPbX9yBGZhG4f7HMRZKK606Y++Zei5M8gkVyBz9RCQmh1Bo5OmEJHXzWZ0BEy/covXhi8bmm6n+yfCcRU7NRFd/dTmXTQOQqeWadWByRM5yi5KpjmnAyZOI+u3Tk35nkCL4Qoy53M4zUai3m/IKGkADrijktUxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a8sAfnyzU8RwB1qe95F6+6w65cx/kPYT3PrEBc+32U=;
 b=WpZ6Eq8c6kvbvaTM59j2IEpg49WeXDu6rYciyZ0Es3FqB4RnVB6QRX+TB+nx9+3cPm7hanhOYRB3Kha7b822qbIW40r2cVdRD3fpEmxSl+W2Ztmbosrxw6OH35YcrkHBWKIeWsvdL4ek3FE8NEFOsKPTC4fvKg2qdIQ3O920fallJzTwpo16M/AlZdQnyxpRHB8lupl3m1IB8/ELdDjS4GUbut2YUQzMtrN4fgPkuDB9+OXwsNTQiirLvqJh7+GAUz670OmKaNkJM3kfvnSaIAVTfvYHHmJ5aj3pJ8wDtHZjY316dIMo2ZjEUF70Q6QMu+u1FAo62xzw2LCl9Hm8jw==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PAXP193MB1823.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 21:18:51 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 21:18:51 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] kasan: Record and report more information
Date:   Mon, 27 Nov 2023 21:17:31 +0000
Message-ID: <VI1P193MB0752BD991325D10E4AB1913599BDA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [d5+hz9hkTuMPEdBF6GuiwOVuUHHASSnp]
X-ClientProxiedBy: LO4P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::6) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231127211731.265280-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PAXP193MB1823:EE_
X-MS-Office365-Filtering-Correlation-Id: d65e40f0-146a-4bca-8ba7-08dbef8e7398
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYIO4JzvCkKjxydC+Tg/doriKFHBIMW4JR0fdK/Dis5pNpz+uuav84AXFezrZyGW0qHaYauT6y6x+bU8+5di2dsq4R103eKOigRwFBlw4pvdZ5LlXsCfGaD1cMfdUmCrtvGFILF2V5WJ3Cxh8O65X6WqZUA0V+FmRNBU4nX/hHzzuuOyuwGO5+jPh31nNq2Gnda+jXFpxn/act8Dk2RLQkWg0H5ExOt/CCLy+QV4NuIUy3TMb1+ss1pJN4I/kaow82dVN1SkVG825bf06kU/97p7zOXCu0lujEA9JMEFfdicYzF0QRelOQw2X460l37paEMfSVVG4ZaO35zvUEEBfJ7cmmSD9vWCogOp9HjacFFVSxD/ocZaRLUPrvnEXao6ecv3DVaYXYlGk0YGqViNVtboX6B9cy4fRedFw0Y8SP3ve1vFmG5BJcasP3KWXgcJjBHzhLVUidTARwVffpRbfdavcqjSiRDrhoMkN5Sh2dfl1Q5v+GSl6PWWMj0OEfF+DLpZRV2d5hfXQlx7yxH+o6Lyno02APVLy2uj1do09fSCeTcCaKb7Y9yTKyrA6hLI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2/MzpGyvH7ZTpXA9WYm6gNcn8YAwBILsxVHKdL5TnjNfwZULtEnTjqIGWpV?=
 =?us-ascii?Q?HnuzksBqrzJxb2tR2FeNLBzTGcpZy4y4KXLENXjLoW+hGcMWARzpSoXOj9es?=
 =?us-ascii?Q?B5qoqcbLcM3IuQ25Ke/CR9N6zHWCzHJ7JveSIvQbMc3kmwCcXEFcqlH3Ckyz?=
 =?us-ascii?Q?8KPXJUlVZOOGx7u3vlK8jyqTTwyRqjuV2JflYv0EgvpBAaLQRTI6ijfXBgmw?=
 =?us-ascii?Q?cKjasuYnZFizI9FPW6ULNmDMLEMxjBOfGRNdEcpcRiLtg/n2blBOlpXoB3id?=
 =?us-ascii?Q?t7vIhlDXvHW/g0n+U/C0x8ovFBA/HGE43NMNIWQcCwQ7leSykVYvJJPJWac+?=
 =?us-ascii?Q?9v2fdT8qQggxUk8vQctExXh334eXsVCeZCQgXE/vbQ2W8tTx23tf5o9MTLQE?=
 =?us-ascii?Q?uBLzlkRFgcQCLqT/HvDXVlsYNbzrx02wryxC5rGbJanotrosU2iH8cFpbo+q?=
 =?us-ascii?Q?zJQQscDpZL9HafYZY/hwzzDSPy4yMpfneFP7xKcLMzQxyN2YRKwHTk+A45So?=
 =?us-ascii?Q?C2Z4Tcuw6fn217gAu2X7rEMl+Dkx1m0xwSl9+hjjQ8zQ40jKQi4s/MltHwwF?=
 =?us-ascii?Q?APulnwNENYCZ/aXBbAlaK5T5ScQ1VGSEZGVRcGO7BUnXx31UYTitXhNiROxL?=
 =?us-ascii?Q?CrBVb5nlVQOOtoz4YF0gVbZ2cj1mMxTfxGD6iTPqLkDNEpvAu/OpCl15KbeJ?=
 =?us-ascii?Q?IyWGrg03qOJaxx22WVg28BLx99WbYhO/5beuR7A/xa/eBNtKX82zkmDFfq+B?=
 =?us-ascii?Q?YlXA15VBjBruPfCg8UHExW56MbmjHtTJsiNdxklreTnfZmAGo9bK5k25MmIh?=
 =?us-ascii?Q?QT2e6SZ4UMxyIOA2bn17R+LlNfAGFejNI0ox1Af/DPsaFAXblarDu1IfIxGc?=
 =?us-ascii?Q?OBxaA5v2TbJk9VjBjU1daBRWuxLLYrbun31s6SYEbAuhTph+1MtO8Zs2Blh/?=
 =?us-ascii?Q?Iry9Nna84oii9YQpAd7UqINLJzsfXM8Mgcb63nB/HQ6qpj8F6DDLXV9+guoJ?=
 =?us-ascii?Q?0gGxcysKaRoNlGaPFDbkIul0rtBKmVwD90prTWAfEYnLXwp+lBx70G2bTroH?=
 =?us-ascii?Q?XPZPRBGGLak8GCtbjvqHzGtQhJUAvX6RyA/ndyprxRlH3Zz4lP16gQf3qd2n?=
 =?us-ascii?Q?eyejvbuWImGqcgfVvbJax8AXo1AOgdKX3O1H5zoGKUCazSngIRgQ4275t0Qx?=
 =?us-ascii?Q?wKktbfzdh0KywkUh+duRwxvFtObzafWSSMcuFnRZM8BpXPUhwzW5Ncn7lds?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65e40f0-146a-4bca-8ba7-08dbef8e7398
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 21:18:51.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record and report more information to help us find the cause of the
bug and to help us correlate the error with other system events.

This patch adds recording and showing CPU number and timestamp at
allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO). The
timestamps in the report use the same format and source as printk.

Error occurrence timestamp is already implicit in the printk log,
and CPU number is already shown by dump_stack_lvl, so there is no
need to add it.

In order to record CPU number and timestamp at allocation and free,
corresponding members need to be added to the relevant data structures,
which will lead to increased memory consumption.

In Generic KASAN, members are added to struct kasan_track. Since in
most cases, alloc meta is stored in the redzone and free meta is
stored in the object or the redzone, memory consumption will not
increase much.

In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
struct kasan_stack_ring_entry. Memory consumption increases as the
size of struct kasan_stack_ring_entry increases (this part of the
memory is allocated by memblock), but since this is configurable,
it is up to the user to choose.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
V2 -> V3: Use a single field to store the timestamp and convert to
sec/usec only when printing the report.

V1 -> V2: Use bit field to reduce memory consumption. Add more detailed
config help. Cancel printing of redundant error occurrence timestamp.

 lib/Kconfig.kasan      | 21 +++++++++++++++++++++
 mm/kasan/common.c      |  8 ++++++++
 mm/kasan/kasan.h       |  8 ++++++++
 mm/kasan/report.c      | 12 ++++++++++++
 mm/kasan/report_tags.c | 15 +++++++++++++++
 mm/kasan/tags.c        | 15 +++++++++++++++
 6 files changed, 79 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 935eda08b1e1..8653f5c38be7 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -207,4 +207,25 @@ config KASAN_MODULE_TEST
 	  A part of the KASAN test suite that is not integrated with KUnit.
 	  Incompatible with Hardware Tag-Based KASAN.
 
+config KASAN_EXTRA_INFO
+	bool "Record and report more information"
+	depends on KASAN
+	help
+	  Record and report more information to help us find the cause of the
+	  bug and to help us correlate the error with other system events.
+
+	  Currently, the CPU number and timestamp are additionally
+	  recorded for each heap block at allocation and free time, and
+	  8 bytes will be added to each metadata structure that records
+	  allocation or free information.
+
+	  In Generic KASAN, each kmalloc-8 and kmalloc-16 object will add
+	  16 bytes of additional memory consumption, and each kmalloc-32
+	  object will add 8 bytes of additional memory consumption, not
+	  affecting other larger objects.
+
+	  In SW_TAGS KASAN and HW_TAGS KASAN, depending on the stack_ring_size
+	  boot parameter, it will add 8 * stack_ring_size bytes of additional
+	  memory consumption.
+
 endif # KASAN
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b5d8bd26fced..fe6c4b43ad9f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/stackdepot.h>
@@ -49,6 +50,13 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u32 cpu = raw_smp_processor_id();
+	u64 ts_nsec = local_clock();
+
+	track->cpu = cpu;
+	track->timestamp = ts_nsec >> 3;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 	track->pid = current->pid;
 	track->stack = kasan_save_stack(flags,
 			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b29d46b83d1f..5e298e3ac909 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -187,6 +187,10 @@ static inline bool kasan_requires_meta(void)
 struct kasan_track {
 	u32 pid;
 	depot_stack_handle_t stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u64 cpu:20;
+	u64 timestamp:44;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 };
 
 enum kasan_report_type {
@@ -278,6 +282,10 @@ struct kasan_stack_ring_entry {
 	u32 pid;
 	depot_stack_handle_t stack;
 	bool is_free;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u64 cpu:20;
+	u64 timestamp:44;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 };
 
 struct kasan_stack_ring {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e77facb62900..a938237f6882 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -262,7 +262,19 @@ static void print_error_description(struct kasan_report_info *info)
 
 static void print_track(struct kasan_track *track, const char *prefix)
 {
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u64 ts_nsec = track->timestamp;
+	unsigned long rem_usec;
+
+	ts_nsec <<= 3;
+	rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
+
+	pr_err("%s by task %u on cpu %d at %lu.%06lus:\n",
+			prefix, track->pid, track->cpu,
+			(unsigned long)ts_nsec, rem_usec);
+#else
 	pr_err("%s by task %u:\n", prefix, track->pid);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 	if (track->stack)
 		stack_depot_print(track->stack);
 	else
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 55154743f915..979f284c2497 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -27,6 +27,15 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
 	return "invalid-access";
 }
 
+#ifdef CONFIG_KASAN_EXTRA_INFO
+static void kasan_complete_extra_report_info(struct kasan_track *track,
+					 struct kasan_stack_ring_entry *entry)
+{
+	track->cpu = entry->cpu;
+	track->timestamp = entry->timestamp;
+}
+#endif /* CONFIG_KASAN_EXTRA_INFO */
+
 void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
 	unsigned long flags;
@@ -73,6 +82,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 
 			info->free_track.pid = entry->pid;
 			info->free_track.stack = entry->stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+			kasan_complete_extra_report_info(&info->free_track, entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 			free_found = true;
 
 			/*
@@ -88,6 +100,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 
 			info->alloc_track.pid = entry->pid;
 			info->alloc_track.stack = entry->stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+			kasan_complete_extra_report_info(&info->alloc_track, entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 			alloc_found = true;
 
 			/*
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 739ae997463d..c13b198b8302 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -13,6 +13,7 @@
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/mm.h>
+#include <linux/sched/clock.h>
 #include <linux/stackdepot.h>
 #include <linux/static_key.h>
 #include <linux/string.h>
@@ -93,6 +94,17 @@ void __init kasan_init_tags(void)
 	}
 }
 
+#ifdef CONFIG_KASAN_EXTRA_INFO
+static void save_extra_info(struct kasan_stack_ring_entry *entry)
+{
+	u32 cpu = raw_smp_processor_id();
+	u64 ts_nsec = local_clock();
+
+	entry->cpu = cpu;
+	entry->timestamp = ts_nsec >> 3;
+}
+#endif /* CONFIG_KASAN_EXTRA_INFO */
+
 static void save_stack_info(struct kmem_cache *cache, void *object,
 			gfp_t gfp_flags, bool is_free)
 {
@@ -128,6 +140,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	entry->pid = current->pid;
 	entry->stack = stack;
 	entry->is_free = is_free;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	save_extra_info(entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 
 	entry->ptr = object;
 
-- 
2.39.2


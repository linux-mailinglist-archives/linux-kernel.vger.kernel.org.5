Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC57F95C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjKZWZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:25:38 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2034.outbound.protection.outlook.com [40.92.91.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91FED
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVcvMsTouluahEAm4FzQy8CraUxrYn/ki09Pt1u+KlGSQcLHu4GVyIPrd57xUD1/UrLbV0KcMYEBi7LttVnfEoUn1toVser+4rZesL4tTmZvcnAsbGDpkGLKy6+yejVaT395yObuDh6l7yEvgTTfcaPuD9CTmVb2pEI5qyVnJd3F5+oFXw5oC0JC6UlN0/RHm+shvqHeqiNKoRZSdhpkD7oR6uCiktWC1H2lWAM0x0YGyy/DSbf4iPhm6GDd0O7+cAXDLmlkp7HVUrPAipsXgB6/mf31eU8Qr+jcF1dnMTFwwBYOvF45tyrhHpEFofhPUMuebkSsORdzGzE4HD3LtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTe9aM+fjlA10OQyyR23o+HAgb9+PrgvP0lWfd0cnBs=;
 b=TQdjje/eJK36mvH3u/t+8Ly1gOixfVxT75g8J4eK79yswauXTIJjDIjbsvriQd2QRgsKGWKOo/35kS7KNZLCeSHc0thJECEREKnv7Oujg6ie04PrgKK4RC/dOE3nSizRruFM+7zWnxeoQkALHSsnd0Zj81o3EgV8/azs0dUHiugV4uaOUKOpP1ZWsOVF6h8SEWWJm+KjAPl1/jsE60Vn77ZM7B3csiRrQPXYCRx9NOiKHZzsFJ9/9ha1kAmPF26Rl4oG1c5XJhrdDYtuCV76drqIF7kh7beXhovWEdVGBr3SukymQfmnUOQ6U2QK1o5ougXYNcz5ZvH/t2daSK0z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTe9aM+fjlA10OQyyR23o+HAgb9+PrgvP0lWfd0cnBs=;
 b=mCE6IjEH0L2K9yvdmO2UhrNQtO/yyWfZDzTBb8mJUc7KlGY5+cDZizXdo4T40/bj/FwAXizDHtnGwgmp4qgYYemeJmSN5MUoQrMKRTs4BeJE/6y08yOp9bspp/MEghdW/FXAqQ64niG4G7cB9xifZDQOTvg7lAncdJYSfqtPI8+SGigA04XsDBhMVMg49lyl7znXzm5wceE1zwFI5Iq/JfI2HVRLaMxecFbgCY8WE1YeiCg9svLi8kjSfSjqAdAz+OGvgbFcEULw84K3vDYGf3L5ZVXvDc1MtS+SsPGM67vGl2mgeyxwDkXhWMYMupUjQkGBVl85BOBQ3V008LimuQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DB8P193MB0695.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:147::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 22:25:41 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 22:25:41 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] kasan: Record and report more information
Date:   Sun, 26 Nov 2023 22:24:25 +0000
Message-ID: <VI1P193MB07529BC28E5B333A8526BEBD99BEA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [d8Q4vUfspLfUTUoWHZPUFBITuUhW/iON]
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231126222425.226688-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DB8P193MB0695:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4979fd-c456-419c-2b6c-08dbeece9f63
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdVvgAvvhIFsvk3ATaW8y0ZbpBNnoh7e5x2pVRAMszxr/j2S159JPq8RKRQKlR58Ezd88+fpsoFhJmKca4KDLErjCvmDbNucy4rC9JlCFzqvN3vTBRZ3D5/nzxEnqbKyfKHhQu+o9yb+J6UNfW1sl7j1zbCIEDw/2wUf47sG0oolXOKLOKdn4dlfl2yB3rdTaWof+WWGzWhRQrPtbpD0DR3K0z/no5Me8dVu0/wDHTnAbY9dwdmF4rbdBsZyeiFQrjv/KkbAtUlv+o2cP4Xrr6R1VJGIeocuB5N/8P2IA1WzbgH018N52yz0s65ngbscQ80uuow+0PsKd9rU1//KZfIZ8wlSj78XSYgSyBbanp+7HYOpWGUritGlJrjIQVlgQg8ZTlgdIwGQifZoBCpcyjjAC2gnvDfi8xq3REQ+08Xj1jJQmZ4sUrSdkXQFhV/2PSnZBFIGdZWBiMMwD4PqkCzJ617Lq9cKtTaOZKQyyStWdDMgZQaNiat+yMGalkECtuSMBA/eybca30gpK37zjAKOgZkOcRURM4u99VotbmCCk5aKQGBpnIGDb5e3keBC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNBDu8AR2FX1v2zMUIUNaqLfbqbgqSzzvGl8OfNw203MkwK3UCqpyr2k2B7Y?=
 =?us-ascii?Q?rbVh1z0xctZh1cFL4M5+qatTxa9++yeQo7I6pyvagpZ+1+WgJeIl1nMeqtkP?=
 =?us-ascii?Q?tBFWkjo2vglDuVqPkt/U92/oBCXRRLAqjuAw72I9yJMflOKNHKopKYzWZbGr?=
 =?us-ascii?Q?VKFgo4/owwDIU3LzwLOxVT8O2ULXRZxBF1tepJ4YsvOpTnKCYWMT3BXxvVh8?=
 =?us-ascii?Q?Nref59mBYdOwxGLs5iaUwGqd26Pfo4wlRBPwKLCyOpspM7i4Syh4+2PX6KOw?=
 =?us-ascii?Q?3O+HZE2IiU8agBg1cpAEEfFbR6Ha3KGRJySOSDUrMFAhWboeitbbYaqlAqIq?=
 =?us-ascii?Q?n3VHrHglx7btkO11GddyOhxa3BQGUyqwQ/jtNIcx2IuqGWCykEoWClSLg/Ah?=
 =?us-ascii?Q?TZVaAdYSTiZo6GlzouMbEIsiXkygx6FKnzkrxytPB0g0zaRsK9gIvyi17u0H?=
 =?us-ascii?Q?oeFKWDc9JKirMqTzXhQUgeLITA1b3pV9Ga0G5wHLucalWHuySy2RiivLauCZ?=
 =?us-ascii?Q?+r9kJoSCKHe8Egnopa7ZdVXxXXGEGn9+etG3V3YDuUFyx9dhQ7TPYvE0TcnS?=
 =?us-ascii?Q?bInog0ka7eXvE2vQysrRRPfA8gwsPEZUy4zRjWORw//IYYn78iG3Gqv6IuZH?=
 =?us-ascii?Q?h4MW0qlfDqaiK0bHM0FTrV76kS7ZV4IQ85IdaGw3n92avAYcnnYjsOkIlbIY?=
 =?us-ascii?Q?hND9iO1Qhqofwy959BmPHf//xGEZLfl4TosIV+//n/pyBAsxZShLJVL53pyd?=
 =?us-ascii?Q?ZMONE4fUTQR5HZceaIBpYja2GK/LK3l93rSnEcLm8EidtTL923PfYMy4bBYw?=
 =?us-ascii?Q?JWzdSzc/SxFgaXJQpZ7plQWTR+IThnfEJ1ZTWCe75ChakLRt7ieFDnl5tZUw?=
 =?us-ascii?Q?ME4SwCRcM2RWV3DPauF6QC8y7NcDMwcSt0TcubYmc4qd8ggwulYkCsTuEp0T?=
 =?us-ascii?Q?ky0JcD9AqldaQkl5lUYlvdUXMoxkcGCFDG0FXi+6MBCf/9bWxio67VPs62Ue?=
 =?us-ascii?Q?3IANx0XEY5cfnuR9JqU7shsqJGj7CX2pJLEMrDWDFxJ9IJ0LIcFzYEda5TeY?=
 =?us-ascii?Q?ipCtJ2htIgt+borC4Gl7wy4nRPj3z23bV94V3dBrjD146ps/0ymw1oewVTFu?=
 =?us-ascii?Q?zECYx78VXZJLxjonuc3yfJAHY0wxuduWVoLoFileTZ20rnnMYUeHaZ9HqWnn?=
 =?us-ascii?Q?8hWVSJS/qqFiX2dVdqYxsJ8JDGJ0fD3+bkeBOJDeBliJc+IQCvo2rtfC5s4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4979fd-c456-419c-2b6c-08dbeece9f63
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 22:25:41.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
V1 -> V2: Use bit field to reduce memory consumption. Add more detailed
config help. Cancel printing of redundant error occurrence timestamp.

 lib/Kconfig.kasan      | 21 +++++++++++++++++++++
 mm/kasan/common.c      | 10 ++++++++++
 mm/kasan/kasan.h       | 10 ++++++++++
 mm/kasan/report.c      |  6 ++++++
 mm/kasan/report_tags.c | 16 ++++++++++++++++
 mm/kasan/tags.c        | 17 +++++++++++++++++
 6 files changed, 80 insertions(+)

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
index b5d8bd26fced..2f0884c762b7 100644
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
@@ -49,6 +50,15 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u32 cpu = raw_smp_processor_id();
+	u64 ts_nsec = local_clock();
+	unsigned long rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
+
+	track->cpu = cpu;
+	track->ts_sec = ts_nsec;
+	track->ts_usec = rem_usec;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 	track->pid = current->pid;
 	track->stack = kasan_save_stack(flags,
 			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b29d46b83d1f..2a37baa4ce2f 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -187,6 +187,11 @@ static inline bool kasan_requires_meta(void)
 struct kasan_track {
 	u32 pid;
 	depot_stack_handle_t stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u64 cpu:20;
+	u64 ts_sec:22;
+	u64 ts_usec:22;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 };
 
 enum kasan_report_type {
@@ -278,6 +283,11 @@ struct kasan_stack_ring_entry {
 	u32 pid;
 	depot_stack_handle_t stack;
 	bool is_free;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u64 cpu:20;
+	u64 ts_sec:22;
+	u64 ts_usec:22;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 };
 
 struct kasan_stack_ring {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e77facb62900..8cd8f6e5cf24 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -262,7 +262,13 @@ static void print_error_description(struct kasan_report_info *info)
 
 static void print_track(struct kasan_track *track, const char *prefix)
 {
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	pr_err("%s by task %u on cpu %d at %u.%06us:\n",
+			prefix, track->pid, track->cpu,
+			track->ts_sec, track->ts_usec);
+#else
 	pr_err("%s by task %u:\n", prefix, track->pid);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 	if (track->stack)
 		stack_depot_print(track->stack);
 	else
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 55154743f915..bf895b1d2dc2 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -27,6 +27,16 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
 	return "invalid-access";
 }
 
+#ifdef CONFIG_KASAN_EXTRA_INFO
+static void kasan_complete_extra_report_info(struct kasan_track *track,
+					 struct kasan_stack_ring_entry *entry)
+{
+	track->cpu = entry->cpu;
+	track->ts_sec = entry->ts_sec;
+	track->ts_usec = entry->ts_usec;
+}
+#endif /* CONFIG_KASAN_EXTRA_INFO */
+
 void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
 	unsigned long flags;
@@ -73,6 +83,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 
 			info->free_track.pid = entry->pid;
 			info->free_track.stack = entry->stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+			kasan_complete_extra_report_info(&info->free_track, entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 			free_found = true;
 
 			/*
@@ -88,6 +101,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 
 			info->alloc_track.pid = entry->pid;
 			info->alloc_track.stack = entry->stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+			kasan_complete_extra_report_info(&info->alloc_track, entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 			alloc_found = true;
 
 			/*
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 739ae997463d..c172e115b9bb 100644
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
@@ -93,6 +94,19 @@ void __init kasan_init_tags(void)
 	}
 }
 
+#ifdef CONFIG_KASAN_EXTRA_INFO
+static void save_extra_info(struct kasan_stack_ring_entry *entry)
+{
+	u32 cpu = raw_smp_processor_id();
+	u64 ts_nsec = local_clock();
+	unsigned long rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
+
+	entry->cpu = cpu;
+	entry->ts_sec = ts_nsec;
+	entry->ts_usec = rem_usec;
+}
+#endif /* CONFIG_KASAN_EXTRA_INFO */
+
 static void save_stack_info(struct kmem_cache *cache, void *object,
 			gfp_t gfp_flags, bool is_free)
 {
@@ -128,6 +142,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	entry->pid = current->pid;
 	entry->stack = stack;
 	entry->is_free = is_free;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	save_extra_info(entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 
 	entry->ptr = object;
 
-- 
2.39.2


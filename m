Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686C87AE6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjIZHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:33:48 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69D5DC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:33:38 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230926073334epoutp042093073dffa7b396fe32186d9e3f87cd~IYoxUNGKk2702727027epoutp04H
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:33:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230926073334epoutp042093073dffa7b396fe32186d9e3f87cd~IYoxUNGKk2702727027epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695713614;
        bh=kMLO3gVzR9OmOkeO+X1L7iFxmq+nyJ0FFCBcvLMBvC4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=C/dl4ilzLO0YHZTbbsBF6GIa9I6GWT5kgek1UZ804eiV+/5sikaic5CfLUflji3ys
         8BBCF53iJ2ldi+UzXb5uhGort2cDTmVOC81PyK7V2LGlUeygdeuP8AbdRoEaD4xoKm
         LIuYHUWWFOZP3UwnxFiSBTBPFbpI0cDEWcy441E0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230926073334epcas1p204f25b5e50bd7c9133b3682193498757~IYow18fyU3167231672epcas1p2n;
        Tue, 26 Sep 2023 07:33:34 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.222]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rvs194l8kz4x9Q5; Tue, 26 Sep
        2023 07:33:33 +0000 (GMT)
X-AuditID: b6c32a38-4dbf8700000027b3-81-6512894d9b7c
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.F2.10163.D4982156; Tue, 26 Sep 2023 16:33:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4] vmscan: add trace events for lru_gen
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>,
        Yu Zhao <yuzhao@google.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "sj@kernel.org" <sj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da@epcms1p3>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230926073333epcms1p14c9798232b395007eb20becb5dbc4b4e@epcms1p1>
Date:   Tue, 26 Sep 2023 16:33:33 +0900
X-CMS-MailID: 20230926073333epcms1p14c9798232b395007eb20becb5dbc4b4e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmga5vp1CqwesORYs569ewWaze5GvR
        vXkmo0Xv+1dMFk37ZrJbXN41h83i3pr/rBZH1p9lsdjX8YDJ4vDXN0wW79Z/YbOY3djHaPFu
        whdWB16Pw2/eM3vsnHWX3aNl3y12jwWbSj02repk89j0aRK7x4kZv1k8+rasYvQ4s+AIu8fn
        TXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        tysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjOaZp5iLFhVXHH79RH2BsbOwC5GTg4JAROJv31HmbsYuTiEBHYwSjRMbWHvYuTg4BUQ
        lPi7QxikRljARmJyx2cWEFtIQEni7I8r7BBxa4n9i2YwgdhsApYS229OZASxRQTCJCYsm8gC
        MpNZYD2LxI/njxghlvFKzGh/ygJhS0tsX74VLM4p4Cdx5PxyNoi4qMTN1W/ZYez3x+ZD9YpI
        tN47ywxhC0o8+LmbEWbOn+PPoXqLJZZ1PmCCsGskVpxbBRU3l2h4u5IN4i9fidvtFiBhFgFV
        ien/10ONcZF4sG0HmM0sIC+x/e0cZpByZgFNifW79CFKFCV2/p4LVcIn8e5rDyvMVzvmPYHa
        qibR8uwrVFxG4u+/Z1C2h8SNp1OgwdzPJHF11VrGCYwKsxAhPQvJ5lkImxcwMq9iFEstKM5N
        Ty02LDCBR25yfu4mRnAy1rLYwTj37Qe9Q4xMHIyHGCU4mJVEeH8940sV4k1JrKxKLcqPLyrN
        SS0+xGgK9PNEZinR5HxgPsgriTc0sTQwMTMysTC2NDZTEuc99qo3RUggPbEkNTs1tSC1CKaP
        iYNTqoFJ0DfLemWIp4iY1ZSMiMmfJJM3TVRtkZnzmkvvCXtuv1bE+SW1ZqezH6uoPLj9dOWt
        VR7vv6x50z9hY8WhiHDvtbE2b+cZepg8TlSvlF52pF5YZ+ekBY1pQf87Xs+UsxTb1nfzg5qx
        UIZU7hen6jlfGLpSw5h+LN/ZnZ3odvRZV4Pzha3vluxetnPz/88mni8LVjYveBjxq6aiYqFO
        0+EE220v5PpUTn14yNJ70GTTsqttbz/N88xoSLK0lPtY4PjXo6Q5rj3E/dK/v/sD9+643Pb+
        +625M7d/vzh53e762bIJU0te9DHO3RW873av/+0v36/VSZvdXyU40frPb//3Fv9n3bLVa3vM
        IibCsXllixJLcUaioRZzUXEiABLf5XdPBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c
References: <20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da@epcms1p3>
        <CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
        <20230926042250.6028-1-jaewon31.kim@samsung.com>
        <CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcms1p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Mon, Sep 25, 2023 at 10:20?PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>>
>>> As the legacy lru provides, the lru_gen needs some trace events for
>>> debugging.
>>>
>>> This commit introduces 2 trace events.
>>>   trace_mm_vmscan_lru_gen_scan
>>>   trace_mm_vmscan_lru_gen_evict
>>>
>>> Each event is similar to the following legacy events.
>>>   trace_mm_vmscan_lru_isolate,
>>>   trace_mm_vmscan_lru_shrink_[in]active
>>
>>We should just reuse trace_mm_vmscan_lru_isolate and
>>trace_mm_vmscan_lru_shrink_inactive instead of adding new tracepoints.
>>
>>To reuse trace_mm_vmscan_lru_isolate, we'd just need to append two new
>>names to LRU_NAMES.
>>
>>The naming of trace_mm_vmscan_lru_shrink_inactive might seem confusing
>>but it's how MGLRU maintains the compatibility, e.g., the existing
>>active/inactive counters in /proc/vmstat.
>
>
>Hello
>
>Actually I had tried to reuse them. But some value was not that compatible.
>Let me try that way again.
>
>>

Hello Yu Zhao

Could you look into what I tried below? I reused the legacy trace events as you recommened.

For the nr_scanned for trace_mm_vmscan_lru_shrink_inactive, I just used the scanned returned from isolate_folios.
I thought this is right as scan_folios also uses its isolated.
  __count_vm_events(PGSCAN_ANON + type, isolated);
But I guess the scanned in scan_folios is actually the one used in shrink_inactive_list

I tested this on both 0 and 7 of /sys/kernel/mm/lru_gen/enabled


diff --git a/mm/vmscan.c b/mm/vmscan.c
index a4e44f1c97c1..b61a0156559c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4328,6 +4328,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
        int sorted = 0;
        int scanned = 0;
        int isolated = 0;
+       int skipped = 0;
        int remaining = MAX_LRU_BATCH;
        struct lru_gen_folio *lrugen = &lruvec->lrugen;
        struct mem_cgroup *memcg = lruvec_memcg(lruvec);
@@ -4341,7 +4342,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
        for (i = MAX_NR_ZONES; i > 0; i--) {
                LIST_HEAD(moved);
-               int skipped = 0;
+               int skipped_zone = 0;
                int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
                struct list_head *head = &lrugen->folios[gen][type][zone];
 
@@ -4363,16 +4364,17 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
                                isolated += delta;
                        } else {
                                list_move(&folio->lru, &moved);
-                               skipped += delta;
+                               skipped_zone += delta;
                        }
 
-                       if (!--remaining || max(isolated, skipped) >= MIN_LRU_BATCH)
+                       if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
                                break;
                }
 
-               if (skipped) {
+               if (skipped_zone) {
                        list_splice(&moved, head);
-                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
+                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
+                       skipped += skipped_zone;
                }
 
                if (!remaining || isolated >= MIN_LRU_BATCH)
@@ -4387,6 +4389,9 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
        __count_memcg_events(memcg, item, isolated);
        __count_memcg_events(memcg, PGREFILL, sorted);
        __count_vm_events(PGSCAN_ANON + type, isolated);
+       trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
+                                   scanned, skipped, isolated,
+                                   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
        /*
         * There might not be eligible folios due to reclaim_idx. Check the
@@ -4517,6 +4522,9 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 retry:
        reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
        sc->nr_reclaimed += reclaimed;
+       trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
+                       scanned, reclaimed, &stat, sc->priority,
+                       type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
        list_for_each_entry_safe_reverse(folio, next, &list, lru) {
                if (!folio_evictable(folio)) {



>>> Here's an example
>>>   mm_vmscan_lru_gen_scan: classzone=2 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=anon
>>>   mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=64 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
>>>   mm_vmscan_lru_gen_scan: classzone=1 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=file
>>>   mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=64 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=12 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>
>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>>> ---
>>> v4: wrap with #ifdef CONFIG_LRU_GEN
>>> v3: change printk format
>>> v2: use condition and make it aligned
>>> v1: introduce trace events
>>> ---
>>>  include/trace/events/mmflags.h |  9 ++++
>>>  include/trace/events/vmscan.h  | 96 ++++++++++++++++++++++++++++++++++
>>>  mm/vmscan.c                    | 20 +++++--
>>>  3 files changed, 120 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
>>> index 1478b9dd05fa..6dfe85bd4e81 100644
>>> --- a/include/trace/events/mmflags.h
>>> +++ b/include/trace/events/mmflags.h
>>> @@ -274,6 +274,12 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY, "softdirty"     )               \
>>>                 EM (LRU_ACTIVE_FILE, "active_file") \
>>>                 EMe(LRU_UNEVICTABLE, "unevictable")
>>>
>>> +#ifdef CONFIG_LRU_GEN
>>> +#define LRU_GEN_NAMES          \
>>> +               EM (LRU_GEN_ANON, "anon") \
>>> +               EMe(LRU_GEN_FILE, "file")
>>> +#endif
>>> +
>>>  /*
>>>   * First define the enums in the above macros to be exported to userspace
>>>   * via TRACE_DEFINE_ENUM().
>>> @@ -288,6 +294,9 @@ COMPACTION_PRIORITY
>>>  /* COMPACTION_FEEDBACK are defines not enums. Not needed here. */
>>>  ZONE_TYPE
>>>  LRU_NAMES
>>> +#ifdef CONFIG_LRU_GEN
>>> +LRU_GEN_NAMES
>>> +#endif
>>>
>>>  /*
>>>   * Now redefine the EM() and EMe() macros to map the enums to the strings
>>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>>> index d2123dd960d5..2080ef742f89 100644
>>> --- a/include/trace/events/vmscan.h
>>> +++ b/include/trace/events/vmscan.h
>>> @@ -327,6 +327,102 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>>>                 __print_symbolic(__entry->lru, LRU_NAMES))
>>>  );
>>>
>>> +#ifdef CONFIG_LRU_GEN
>>> +TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
>>> +       TP_PROTO(int highest_zoneidx,
>>> +               int order,
>>> +               unsigned long nr_requested,
>>> +               unsigned long nr_scanned,
>>> +               unsigned long nr_skipped,
>>> +               unsigned long nr_taken,
>>> +               int lru),
>>> +
>>> +       TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, lru),
>>> +
>>> +       TP_CONDITION(nr_scanned),
>>> +
>>> +       TP_STRUCT__entry(
>>> +               __field(int, highest_zoneidx)
>>> +               __field(int, order)
>>> +               __field(unsigned long, nr_requested)
>>> +               __field(unsigned long, nr_scanned)
>>> +               __field(unsigned long, nr_skipped)
>>> +               __field(unsigned long, nr_taken)
>>> +               __field(int, lru)
>>> +       ),
>>> +
>>> +       TP_fast_assign(
>>> +               __entry->highest_zoneidx = highest_zoneidx;
>>> +               __entry->order = order;
>>> +               __entry->nr_requested = nr_requested;
>>> +               __entry->nr_scanned = nr_scanned;
>>> +               __entry->nr_skipped = nr_skipped;
>>> +               __entry->nr_taken = nr_taken;
>>> +               __entry->lru = lru;
>>> +       ),
>>> +
>>> +       /*
>>> +        * classzone is previous name of the highest_zoneidx.
>>> +        * Reason not to change it is the ABI requirement of the tracepoint.
>>> +        */
>>> +       TP_printk("classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
>>> +               __entry->highest_zoneidx,
>>> +               __entry->order,
>>> +               __entry->nr_requested,
>>> +               __entry->nr_scanned,
>>> +               __entry->nr_skipped,
>>> +               __entry->nr_taken,
>>> +               __print_symbolic(__entry->lru, LRU_GEN_NAMES))
>>> +);
>>> +
>>> +TRACE_EVENT(mm_vmscan_lru_gen_evict,
>>> +
>>> +       TP_PROTO(int nid, unsigned long nr_reclaimed,
>>> +               struct reclaim_stat *stat, int priority, int file),
>>> +
>>> +       TP_ARGS(nid, nr_reclaimed, stat, priority, file),
>>> +
>>> +       TP_STRUCT__entry(
>>> +               __field(unsigned long, nr_reclaimed)
>>> +               __field(unsigned long, nr_dirty)
>>> +               __field(unsigned long, nr_writeback)
>>> +               __field(unsigned long, nr_congested)
>>> +               __field(unsigned long, nr_immediate)
>>> +               __field(unsigned int, nr_activate0)
>>> +               __field(unsigned int, nr_activate1)
>>> +               __field(unsigned long, nr_ref_keep)
>>> +               __field(unsigned long, nr_unmap_fail)
>>> +               __field(int, nid)
>>> +               __field(int, priority)
>>> +               __field(int, reclaim_flags)
>>> +       ),
>>> +
>>> +       TP_fast_assign(
>>> +               __entry->nid = nid;
>>> +               __entry->nr_reclaimed = nr_reclaimed;
>>> +               __entry->nr_dirty = stat->nr_dirty;
>>> +               __entry->nr_writeback = stat->nr_writeback;
>>> +               __entry->nr_congested = stat->nr_congested;
>>> +               __entry->nr_immediate = stat->nr_immediate;
>>> +               __entry->nr_activate0 = stat->nr_activate[0];
>>> +               __entry->nr_activate1 = stat->nr_activate[1];
>>> +               __entry->nr_ref_keep = stat->nr_ref_keep;
>>> +               __entry->nr_unmap_fail = stat->nr_unmap_fail;
>>> +               __entry->priority = priority;
>>> +               __entry->reclaim_flags = trace_reclaim_flags(file);
>>> +       ),
>>> +
>>> +       TP_printk("nid=%d nr_reclaimed=%lu nr_dirty=%lu nr_writeback=%lu nr_congested=%lu nr_immediate=%lu nr_activate_anon=%u nr_activate_file=%u nr_ref_keep=%lu nr_unmap_fail=%lu priority=%d flags=%s",
>>> +               __entry->nid, __entry->nr_reclaimed,
>>> +               __entry->nr_dirty, __entry->nr_writeback,
>>> +               __entry->nr_congested, __entry->nr_immediate,
>>> +               __entry->nr_activate0, __entry->nr_activate1,
>>> +               __entry->nr_ref_keep, __entry->nr_unmap_fail,
>>> +               __entry->priority,
>>> +               show_reclaim_flags(__entry->reclaim_flags))
>>> +);
>>> +#endif
>>> +
>>>  TRACE_EVENT(mm_vmscan_write_folio,
>>>
>>>         TP_PROTO(struct folio *folio),
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 6f13394b112e..0c8b48bcb461 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -5005,6 +5005,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>>         int sorted = 0;
>>>         int scanned = 0;
>>>         int isolated = 0;
>>> +       int skipped = 0;
>>>         int remaining = MAX_LRU_BATCH;
>>>         struct lru_gen_folio *lrugen = &lruvec->lrugen;
>>>         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>> @@ -5018,7 +5019,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>>
>>>         for (i = MAX_NR_ZONES; i > 0; i--) {
>>>                 LIST_HEAD(moved);
>>> -               int skipped = 0;
>>> +               int skipped_zone = 0;
>>>                 int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
>>>                 struct list_head *head = &lrugen->folios[gen][type][zone];
>>>
>>> @@ -5040,16 +5041,17 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>>                                 isolated += delta;
>>>                         } else {
>>>                                 list_move(&folio->lru, &moved);
>>> -                               skipped += delta;
>>> +                               skipped_zone += delta;
>>>                         }
>>>
>>> -                       if (!--remaining || max(isolated, skipped) >= MIN_LRU_BATCH)
>>> +                       if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
>>>                                 break;
>>>                 }
>>>
>>> -               if (skipped) {
>>> +               if (skipped_zone) {
>>>                         list_splice(&moved, head);
>>> -                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
>>> +                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
>>> +                       skipped += skipped_zone;
>>>                 }
>>>
>>>                 if (!remaining || isolated >= MIN_LRU_BATCH)
>>> @@ -5065,6 +5067,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>>         __count_memcg_events(memcg, PGREFILL, sorted);
>>>         __count_vm_events(PGSCAN_ANON + type, isolated);
>>>
>>> +#ifdef CONFIG_LRU_GEN
>>> +       trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
>>> +                       scanned, skipped, isolated, type);
>>> +#endif
>>
>>These functions are already within CONFIG_LRU_GEN.
>>
>>>         /*
>>>          * There might not be eligible folios due to reclaim_idx. Check the
>>>          * remaining to prevent livelock if it's not making progress.
>>> @@ -5194,6 +5200,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>>>  retry:
>>>         reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
>>>         sc->nr_reclaimed += reclaimed;
>>> +#ifdef CONFIG_LRU_GEN
>>> +       trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
>>> +                                     sc->priority, type);
>>> +#endif
>>
>>Ditto.

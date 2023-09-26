Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD17AE4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjIZFLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIZFLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:11:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11415B0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 22:10:48 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230926051036epoutp04700748c8b4a5fee804b3127f45a33db9~IWr8N19_B1458314583epoutp04l
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:10:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230926051036epoutp04700748c8b4a5fee804b3127f45a33db9~IWr8N19_B1458314583epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695705036;
        bh=Vt0elXedZqgWLyBE7pThZJd+8eocA4qr/TmweEqV/U0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hNEyqmoZ28pvVQqjWwBrReupHLz1OeTULZu7axhEvZnm3LToveHGkbAnTAWTfdaRA
         fAoohZwDOHey0NN340LoZAdPhbMrs3e7y3o2albAJYflA3uLInA8pZY+sCuqLkcMTX
         /8rLT+VnScPhXJywpvWsfT5+//36m0/I5pfs6efc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230926051035epcas1p42d2b1b264ca9187eac8812c5afdc9d92~IWr7x04d41223612236epcas1p4X;
        Tue, 26 Sep 2023 05:10:35 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RvnrC3SzRz4x9Q8; Tue, 26 Sep
        2023 05:10:35 +0000 (GMT)
X-AuditID: b6c32a4c-d19fe70000004a18-97-651267cb1083
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.4B.18968.BC762156; Tue, 26 Sep 2023 14:10:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4] vmscan: add trace events for lru_gen
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Yu Zhao <yuzhao@google.com>
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
In-Reply-To: <CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da@epcms1p3>
Date:   Tue, 26 Sep 2023 14:10:35 +0900
X-CMS-MailID: 20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmvu7pdKFUg+7fEhZz1q9hs1i9ydei
        e/NMRove96+YLJr2zWS3uLxrDpvFvTX/WS2OrD/LYrGv4wGTxeGvb5gs3q3/wmYxu7GP0eLd
        hC+sDrweh9+8Z/bYOesuu0fLvlvsHgs2lXpsWtXJ5rHp0yR2jxMzfrN49G1ZxehxZsERdo/P
        m+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgV6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGe8PPqDqeBOaMXjVwuZGhjf23QxcnJICJhI3Nj2nK2LkYtDSGAPo8SKLf+Zuhg5OHgF
        BCX+7hAGqREWsJGY3PGZBcQWElCSOPvjCjtE3Fpi/6IZTCA2m4ClxPabExlBbBEBeYkJL5+x
        g8xkFljPIvHj+SNGiGW8EjPan7JA2NIS25dvBYtzCgRKTJ7+mQ0iLipxc/Vbdhj7/bH5UL0i
        Eq33zjJD2IISD37uZoSZ8+f4c6jeYollnQ+YIOwaiRXnVkHFzSUa3q5kg/jLV2L+ebAxLAKq
        Eu0vj0CtcpHo2NgENpIZ6P7tb+cwg5QzC2hKrN+lD1GiKLHz91yoEj6Jd197WGG+2jHvCdRW
        NYmWZ1+h4jISf/89g7I9JG48ncIMCebTjBKde8+wTWBUmIUI6VlINs9C2LyAkXkVo1RqQXFu
        emqyYYGhbl5qOTyCk/NzNzGCk7KWzw7G7+v/6h1iZOJgPMQowcGsJML76xlfqhBvSmJlVWpR
        fnxRaU5q8SFGU6C/JzJLiSbnA/NCXkm8oYmlgYmZkYmFsaWxmZI4b8yn9hQhgfTEktTs1NSC
        1CKYPiYOTqkGprr/jU47vjjUBaz39J6auLLUM8RyeYHYwt9TZv3LesI+66TyNrmPtfFPeX3s
        1Vbs83o19TLD3Vsfeb4Gl+z647wz44xoStppz6IJAVYKp28v0/omv+VloLuO5u2mE+kNXI/e
        Ca1Naj8gcvDBkZnbY08yH5GxqUr2kWz4mb4iRvJQ5ztl8fMyEoucXbh7QqUePnEsaLrRIGXK
        aChky71Edvo2n8jS893TkjUfuZ/UXz2//tP8dTEO1/cZXcus25hiIdO/zMAr//yfd88ju65W
        r1VK233pVn90R6usvsd6BvP/0SemiqV61y1/EH1uydlpkrJP5VS139tN+LcuQ0p27uWNSkv7
        S1/Onhi0dpGxrhJLcUaioRZzUXEiAGUF4o1TBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c
References: <CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
        <20230926042250.6028-1-jaewon31.kim@samsung.com>
        <CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcms1p3>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Sep 25, 2023 at 10:20?PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>
>> As the legacy lru provides, the lru_gen needs some trace events for
>> debugging.
>>
>> This commit introduces 2 trace events.
>>   trace_mm_vmscan_lru_gen_scan
>>   trace_mm_vmscan_lru_gen_evict
>>
>> Each event is similar to the following legacy events.
>>   trace_mm_vmscan_lru_isolate,
>>   trace_mm_vmscan_lru_shrink_[in]active
>
>We should just reuse trace_mm_vmscan_lru_isolate and
>trace_mm_vmscan_lru_shrink_inactive instead of adding new tracepoints.
>
>To reuse trace_mm_vmscan_lru_isolate, we'd just need to append two new
>names to LRU_NAMES.
>
>The naming of trace_mm_vmscan_lru_shrink_inactive might seem confusing
>but it's how MGLRU maintains the compatibility, e.g., the existing
>active/inactive counters in /proc/vmstat.


Hello

Actually I had tried to reuse them. But some value was not that compatible.
Let me try that way again.

>
>> Here's an example
>>   mm_vmscan_lru_gen_scan: classzone=2 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=anon
>>   mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=64 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
>>   mm_vmscan_lru_gen_scan: classzone=1 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=file
>>   mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=64 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=12 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>
>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> ---
>> v4: wrap with #ifdef CONFIG_LRU_GEN
>> v3: change printk format
>> v2: use condition and make it aligned
>> v1: introduce trace events
>> ---
>>  include/trace/events/mmflags.h |  9 ++++
>>  include/trace/events/vmscan.h  | 96 ++++++++++++++++++++++++++++++++++
>>  mm/vmscan.c                    | 20 +++++--
>>  3 files changed, 120 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
>> index 1478b9dd05fa..6dfe85bd4e81 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> @@ -274,6 +274,12 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY, "softdirty"     )               \
>>                 EM (LRU_ACTIVE_FILE, "active_file") \
>>                 EMe(LRU_UNEVICTABLE, "unevictable")
>>
>> +#ifdef CONFIG_LRU_GEN
>> +#define LRU_GEN_NAMES          \
>> +               EM (LRU_GEN_ANON, "anon") \
>> +               EMe(LRU_GEN_FILE, "file")
>> +#endif
>> +
>>  /*
>>   * First define the enums in the above macros to be exported to userspace
>>   * via TRACE_DEFINE_ENUM().
>> @@ -288,6 +294,9 @@ COMPACTION_PRIORITY
>>  /* COMPACTION_FEEDBACK are defines not enums. Not needed here. */
>>  ZONE_TYPE
>>  LRU_NAMES
>> +#ifdef CONFIG_LRU_GEN
>> +LRU_GEN_NAMES
>> +#endif
>>
>>  /*
>>   * Now redefine the EM() and EMe() macros to map the enums to the strings
>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>> index d2123dd960d5..2080ef742f89 100644
>> --- a/include/trace/events/vmscan.h
>> +++ b/include/trace/events/vmscan.h
>> @@ -327,6 +327,102 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>>                 __print_symbolic(__entry->lru, LRU_NAMES))
>>  );
>>
>> +#ifdef CONFIG_LRU_GEN
>> +TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
>> +       TP_PROTO(int highest_zoneidx,
>> +               int order,
>> +               unsigned long nr_requested,
>> +               unsigned long nr_scanned,
>> +               unsigned long nr_skipped,
>> +               unsigned long nr_taken,
>> +               int lru),
>> +
>> +       TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, lru),
>> +
>> +       TP_CONDITION(nr_scanned),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(int, highest_zoneidx)
>> +               __field(int, order)
>> +               __field(unsigned long, nr_requested)
>> +               __field(unsigned long, nr_scanned)
>> +               __field(unsigned long, nr_skipped)
>> +               __field(unsigned long, nr_taken)
>> +               __field(int, lru)
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->highest_zoneidx = highest_zoneidx;
>> +               __entry->order = order;
>> +               __entry->nr_requested = nr_requested;
>> +               __entry->nr_scanned = nr_scanned;
>> +               __entry->nr_skipped = nr_skipped;
>> +               __entry->nr_taken = nr_taken;
>> +               __entry->lru = lru;
>> +       ),
>> +
>> +       /*
>> +        * classzone is previous name of the highest_zoneidx.
>> +        * Reason not to change it is the ABI requirement of the tracepoint.
>> +        */
>> +       TP_printk("classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
>> +               __entry->highest_zoneidx,
>> +               __entry->order,
>> +               __entry->nr_requested,
>> +               __entry->nr_scanned,
>> +               __entry->nr_skipped,
>> +               __entry->nr_taken,
>> +               __print_symbolic(__entry->lru, LRU_GEN_NAMES))
>> +);
>> +
>> +TRACE_EVENT(mm_vmscan_lru_gen_evict,
>> +
>> +       TP_PROTO(int nid, unsigned long nr_reclaimed,
>> +               struct reclaim_stat *stat, int priority, int file),
>> +
>> +       TP_ARGS(nid, nr_reclaimed, stat, priority, file),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(unsigned long, nr_reclaimed)
>> +               __field(unsigned long, nr_dirty)
>> +               __field(unsigned long, nr_writeback)
>> +               __field(unsigned long, nr_congested)
>> +               __field(unsigned long, nr_immediate)
>> +               __field(unsigned int, nr_activate0)
>> +               __field(unsigned int, nr_activate1)
>> +               __field(unsigned long, nr_ref_keep)
>> +               __field(unsigned long, nr_unmap_fail)
>> +               __field(int, nid)
>> +               __field(int, priority)
>> +               __field(int, reclaim_flags)
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->nid = nid;
>> +               __entry->nr_reclaimed = nr_reclaimed;
>> +               __entry->nr_dirty = stat->nr_dirty;
>> +               __entry->nr_writeback = stat->nr_writeback;
>> +               __entry->nr_congested = stat->nr_congested;
>> +               __entry->nr_immediate = stat->nr_immediate;
>> +               __entry->nr_activate0 = stat->nr_activate[0];
>> +               __entry->nr_activate1 = stat->nr_activate[1];
>> +               __entry->nr_ref_keep = stat->nr_ref_keep;
>> +               __entry->nr_unmap_fail = stat->nr_unmap_fail;
>> +               __entry->priority = priority;
>> +               __entry->reclaim_flags = trace_reclaim_flags(file);
>> +       ),
>> +
>> +       TP_printk("nid=%d nr_reclaimed=%lu nr_dirty=%lu nr_writeback=%lu nr_congested=%lu nr_immediate=%lu nr_activate_anon=%u nr_activate_file=%u nr_ref_keep=%lu nr_unmap_fail=%lu priority=%d flags=%s",
>> +               __entry->nid, __entry->nr_reclaimed,
>> +               __entry->nr_dirty, __entry->nr_writeback,
>> +               __entry->nr_congested, __entry->nr_immediate,
>> +               __entry->nr_activate0, __entry->nr_activate1,
>> +               __entry->nr_ref_keep, __entry->nr_unmap_fail,
>> +               __entry->priority,
>> +               show_reclaim_flags(__entry->reclaim_flags))
>> +);
>> +#endif
>> +
>>  TRACE_EVENT(mm_vmscan_write_folio,
>>
>>         TP_PROTO(struct folio *folio),
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 6f13394b112e..0c8b48bcb461 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5005,6 +5005,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>         int sorted = 0;
>>         int scanned = 0;
>>         int isolated = 0;
>> +       int skipped = 0;
>>         int remaining = MAX_LRU_BATCH;
>>         struct lru_gen_folio *lrugen = &lruvec->lrugen;
>>         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>> @@ -5018,7 +5019,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>
>>         for (i = MAX_NR_ZONES; i > 0; i--) {
>>                 LIST_HEAD(moved);
>> -               int skipped = 0;
>> +               int skipped_zone = 0;
>>                 int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
>>                 struct list_head *head = &lrugen->folios[gen][type][zone];
>>
>> @@ -5040,16 +5041,17 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>                                 isolated += delta;
>>                         } else {
>>                                 list_move(&folio->lru, &moved);
>> -                               skipped += delta;
>> +                               skipped_zone += delta;
>>                         }
>>
>> -                       if (!--remaining || max(isolated, skipped) >= MIN_LRU_BATCH)
>> +                       if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
>>                                 break;
>>                 }
>>
>> -               if (skipped) {
>> +               if (skipped_zone) {
>>                         list_splice(&moved, head);
>> -                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
>> +                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
>> +                       skipped += skipped_zone;
>>                 }
>>
>>                 if (!remaining || isolated >= MIN_LRU_BATCH)
>> @@ -5065,6 +5067,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>         __count_memcg_events(memcg, PGREFILL, sorted);
>>         __count_vm_events(PGSCAN_ANON + type, isolated);
>>
>> +#ifdef CONFIG_LRU_GEN
>> +       trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
>> +                       scanned, skipped, isolated, type);
>> +#endif
>
>These functions are already within CONFIG_LRU_GEN.
>
>>         /*
>>          * There might not be eligible folios due to reclaim_idx. Check the
>>          * remaining to prevent livelock if it's not making progress.
>> @@ -5194,6 +5200,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>>  retry:
>>         reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
>>         sc->nr_reclaimed += reclaimed;
>> +#ifdef CONFIG_LRU_GEN
>> +       trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
>> +                                     sc->priority, type);
>> +#endif
>
>Ditto.

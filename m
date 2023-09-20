Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EF17A74CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjITHuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjITHuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:50:01 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1389D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:49:53 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230920074949epoutp01d06440dfaa234ede96c0401f3e7df352~Gi-Pk4N7b2781627816epoutp01W
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:49:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230920074949epoutp01d06440dfaa234ede96c0401f3e7df352~Gi-Pk4N7b2781627816epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695196189;
        bh=i58ZkLZkk/P5k3DKdwoGOc6L9UHO7+MgGuc1nYssIAU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=VoZqTPP3tm6M7RExmL+pZtqtgL0C5uSOO/QNL+zXdBqgPD+SZ1oN1OAijNLWmuOES
         gq9UbW2Fu1iOUw0KFkQNf2zzAFawK2qejLx6o3tOmFZ0CSpqFeNqYxlTbL3qmeMuW8
         03ujYzX/HpnJQiuSBwEngANkr9RsSxbiaX7wdJOI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230920074948epcas1p39221f2dc9f392bfe1645a42fb03c5c77~Gi-PE7Oqg2471724717epcas1p3o;
        Wed, 20 Sep 2023 07:49:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.225]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rr9fh3Rw2z4x9Q2; Wed, 20 Sep
        2023 07:49:48 +0000 (GMT)
X-AuditID: b6c32a35-76dfa7000000271c-50-650aa41caa4f
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.1A.10012.C14AA056; Wed, 20 Sep 2023 16:49:48 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] vmscan: add trace events for lru_gen
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
CC:     "yuzhao@google.com" <yuzhao@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230919095927.5a964094@gandalf.local.home>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230920074948epcms1p82d18c2f4d6a0b5699d50fc419b9ba9fe@epcms1p8>
Date:   Wed, 20 Sep 2023 16:49:48 +0900
X-CMS-MailID: 20230920074948epcms1p82d18c2f4d6a0b5699d50fc419b9ba9fe
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmvq7MEq5Ug96tYhZz1q9hs1i9ydei
        e/NMRove96+YLJr2zWS3uLxrDpvFvTX/WS2OrD/LYrGv4wGTxbv1X9gsZjf2MVq8m/CF1YHH
        4/Cb98weO2fdZfdo2XeL3WPBplKPTZ8msXucmPGbxaNvyypGjzMLjrB7fN4kF8AZlW2TkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SxkkJZYk4pUCgg
        sbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE74+316+wF
        L0Mrbr8Na2D85tzFyMkhIWAi8az1CFsXIxeHkMAORoltnzuZuxg5OHgFBCX+7hAGqREWsJGY
        PX8PI4gtJKAkcfbHFXaIuLXE/kUzmEBsNgFLie03J4LViAjES3zd3sYOMpNZoItFYs+s5ewQ
        y3glZrQ/ZYGwpSW2L98K1sAJ1Dy9vYsZIi4qcXP1W3YY+/2x+YwQtohE672zUDWCEg9+7maE
        mfPn+HM2CLtYYlnnAyYIu0ZixblVUHFziYa3K9kg/vKVWLCkCiTMIqAqcejZBqiRLhLfTt0F
        O41ZQF5i+9s54GBgFtCUWL9LH6JEUWLn77mMECV8Eu++9rDCfLVj3hOorWoSLc++QsVlJP7+
        e8YKMkZCwENi2wZGSChvZpSYtPEX2wRGhVmIgJ6FZPEshMULGJlXMYqlFhTnpqcWGxYYwqM2
        OT93EyM46WqZ7mCc+PaD3iFGJg7GQ4wSHMxKIry5alypQrwpiZVVqUX58UWlOanFhxhNgV6e
        yCwlmpwPTPt5JfGGJpYGJmZGJhbGlsZmSuK8zI96U4QE0hNLUrNTUwtSi2D6mDg4pRqYVmjU
        NNoIN+fJ2x9ynVny4WboE8lvEbWGrzUnrdW98u+QenfTnqvNH+/c6riowpaTW1m0zssnpe2F
        5jLugj1h3tucnCIzjzvE8VrsdnWQdD5e0HRSxURpu/czjln7Cj4tPmbNbn6l2/RC2l0FidcC
        Ip8vVuUpFDJtOz1R7Ef4pUvqyzIOr7rwL8ZIOafpvuj3OcKauyz/LOqbu79PV9s8Rolz38VG
        Y5YvG2Y+mO/DenjGu8ZFB4L8vmq8mm35YNJ3fiuDN78iDz+awOnuUntv57aYrsrIYtM/qULL
        HRxdvpiedDrUWOY0Mcm570a7esLhM6aNs2ZfUVfh/VZsGJjgmJoufbdyxZ6028YzWfqUWIoz
        Eg21mIuKEwHhdVMUQwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b
References: <20230919095927.5a964094@gandalf.local.home>
        <20230919025216.1878-1-jaewon31.kim@samsung.com>
        <CGME20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b@epcms1p8>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 19 Sep 2023 11:52:16 +0900
>Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>>  /*
>>   * Now redefine the EM() and EMe() macros to map the enums to the strings
>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>> index d2123dd960d5..e8f9d0452e89 100644
>> --- a/include/trace/events/vmscan.h
>> +++ b/include/trace/events/vmscan.h
>> @@ -327,6 +327,55 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>>  		__print_symbolic(__entry->lru, LRU_NAMES))
>>  );
>>  
>> +TRACE_EVENT(mm_vmscan_lru_gen_scan,
>> +	TP_PROTO(int highest_zoneidx,
>> +		int order,
>> +		unsigned long nr_requested,
>> +		unsigned long nr_scanned,
>> +		unsigned long nr_skipped,
>> +		unsigned long nr_taken,
>> +		isolate_mode_t isolate_mode,
>> +		int lru),
>
>This is a lot of parameter passing, can you consolidate it?
>
>(see below to where you call this)
>
>> +
>> +	TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(int, highest_zoneidx)
>> +		__field(int, order)
>> +		__field(unsigned long, nr_requested)
>> +		__field(unsigned long, nr_scanned)
>> +		__field(unsigned long, nr_skipped)
>> +		__field(unsigned long, nr_taken)
>> +		__field(unsigned int, isolate_mode)
>> +		__field(int, lru)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->highest_zoneidx = highest_zoneidx;
>> +		__entry->order = order;
>> +		__entry->nr_requested = nr_requested;
>> +		__entry->nr_scanned = nr_scanned;
>> +		__entry->nr_skipped = nr_skipped;
>> +		__entry->nr_taken = nr_taken;
>> +		__entry->isolate_mode = (__force unsigned int)isolate_mode;
>> +		__entry->lru = lru;
>> +	),
>> +
>> +	/*
>> +	 * classzone is previous name of the highest_zoneidx.
>> +	 * Reason not to change it is the ABI requirement of the tracepoint.
>> +	 */
>> +	TP_printk("isolate_mode=%d classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
>> +		__entry->isolate_mode,
>> +		__entry->highest_zoneidx,
>> +		__entry->order,
>> +		__entry->nr_requested,
>> +		__entry->nr_scanned,
>> +		__entry->nr_skipped,
>> +		__entry->nr_taken,
>> +		__print_symbolic(__entry->lru, LRU_GEN_NAMES))
>> +);
>> +
>>  TRACE_EVENT(mm_vmscan_write_folio,
>>  
>>  	TP_PROTO(struct folio *folio),
>> @@ -437,6 +486,53 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
>>  		show_reclaim_flags(__entry->reclaim_flags))
>>  );
>>  
>> +TRACE_EVENT(mm_vmscan_lru_gen_evict,
>> +
>> +	TP_PROTO(int nid, unsigned long nr_reclaimed,
>> +		struct reclaim_stat *stat, int priority, int file),
>> +
>> +	TP_ARGS(nid, nr_reclaimed, stat, priority, file),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(int, nid)
>
>On 64 bit architectures, this causes a 4 byte hole in the ring buffer
>layout. Please keep 32 bit size fields paired with other 32 bit size if
>possible. That is, move the above "int nid" down where it doesn't cause a
>long field to be 4 bytes away.
>
>> +		__field(unsigned long, nr_reclaimed)
>> +		__field(unsigned long, nr_dirty)
>> +		__field(unsigned long, nr_writeback)
>> +		__field(unsigned long, nr_congested)
>> +		__field(unsigned long, nr_immediate)
>> +		__field(unsigned int, nr_activate0)
>> +		__field(unsigned int, nr_activate1)
>> +		__field(unsigned long, nr_ref_keep)
>> +		__field(unsigned long, nr_unmap_fail)
>
>		__field(int, nid)
>
>here!
>
>> +		__field(int, priority)
>> +		__field(int, reclaim_flags)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->nid = nid;
>> +		__entry->nr_reclaimed = nr_reclaimed;
>> +		__entry->nr_dirty = stat->nr_dirty;
>> +		__entry->nr_writeback = stat->nr_writeback;
>> +		__entry->nr_congested = stat->nr_congested;
>> +		__entry->nr_immediate = stat->nr_immediate;
>> +		__entry->nr_activate0 = stat->nr_activate[0];
>> +		__entry->nr_activate1 = stat->nr_activate[1];
>> +		__entry->nr_ref_keep = stat->nr_ref_keep;
>> +		__entry->nr_unmap_fail = stat->nr_unmap_fail;
>> +		__entry->priority = priority;
>> +		__entry->reclaim_flags = trace_reclaim_flags(file);
>> +	),
>> +
>> +	TP_printk("nid=%d nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
>> +		__entry->nid, __entry->nr_reclaimed,
>> +		__entry->nr_dirty, __entry->nr_writeback,
>> +		__entry->nr_congested, __entry->nr_immediate,
>> +		__entry->nr_activate0, __entry->nr_activate1,
>> +		__entry->nr_ref_keep, __entry->nr_unmap_fail,
>> +		__entry->priority,
>> +		show_reclaim_flags(__entry->reclaim_flags))
>> +);
>> +
>>  TRACE_EVENT(mm_vmscan_node_reclaim_begin,
>>  
>>  	TP_PROTO(int nid, int order, gfp_t gfp_flags),
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 6f13394b112e..cc10e3fb8fa2 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5005,6 +5005,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>  	int sorted = 0;
>>  	int scanned = 0;
>>  	int isolated = 0;
>> +	int skipped = 0;
>>  	int remaining = MAX_LRU_BATCH;
>>  	struct lru_gen_folio *lrugen = &lruvec->lrugen;
>>  	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>> @@ -5018,7 +5019,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>  
>>  	for (i = MAX_NR_ZONES; i > 0; i--) {
>>  		LIST_HEAD(moved);
>> -		int skipped = 0;
>> +		int skipped_zone = 0;
>>  		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
>>  		struct list_head *head = &lrugen->folios[gen][type][zone];
>>  
>> @@ -5040,16 +5041,17 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>  				isolated += delta;
>>  			} else {
>>  				list_move(&folio->lru, &moved);
>> -				skipped += delta;
>> +				skipped_zone += delta;
>>  			}
>>  
>> -			if (!--remaining || max(isolated, skipped) >= MIN_LRU_BATCH)
>> +			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
>>  				break;
>>  		}
>>  
>> -		if (skipped) {
>> +		if (skipped_zone) {
>>  			list_splice(&moved, head);
>> -			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
>> +			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
>> +			skipped += skipped_zone;
>>  		}
>>  
>>  		if (!remaining || isolated >= MIN_LRU_BATCH)
>> @@ -5065,6 +5067,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>  	__count_memcg_events(memcg, PGREFILL, sorted);
>>  	__count_vm_events(PGSCAN_ANON + type, isolated);
>>  
>> +	if (scanned)
>
>BTW, you can make this branch conditional with the trace event logic, so
>that it isn't tested when tracing is enabled. That is, remove the
> "if (scanned)" test and use TRACE_EVENT_CONDITION() as I show below.
>
>> +		trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order,
>> +				MAX_LRU_BATCH, scanned, skipped, isolated,
>> +				sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
>
>Why not pass the sc in to the trace event, and then do the assigning there?
>
>// use CONDITION to test scanned
>
>TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
>
>	TP_PROTO(struct scan_control *sc,
>		unsigned long nr_requested,
>		unsigned long nr_scanned,
>		unsigned long nr_skipped,
>		unsigned long nr_taken,
>		int lru),
>
>	TP_ARGS(...)
>
>	TP_CONDITION(nr_scanned)
>
>	TP_fast_assign(
>		__entry->highest_zoneidx = sc->reclaim_idx;
>		__entry->order = sc->order;
>		__entry->nr_requested = nr_requested;
>		__entry->nr_scanned = nr_scanned;
>		__entry->nr_skipped = nr_skipped;
>		__entry->nr_taken = nr_taken;
>		__entry->isolate_mode = (__force unsigned int)(sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
>		__entry->lru = lru;
>	),
>
>Lots of parameters can be expensive to pass, as it requires more copying.
>
>-- Steve

Great. Thank you for your comment.

For the putting the struct scan_control *sc inside the trace,
I couldn't do that because struct scan_control is defined in mm/vmscan.c.
I think I should not move it to a seperate header file.

As you may expect, I just made this by copying the existing
trace_mm_vmscan_lru_isolate and trace_mm_vmscan_lru_shrink_inactive

I've tried to change like this.
Would this be good for you?


--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -327,7 +327,7 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
                __print_symbolic(__entry->lru, LRU_NAMES))
 );
 
-TRACE_EVENT(mm_vmscan_lru_gen_scan,
+TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
        TP_PROTO(int highest_zoneidx,
                int order,
                unsigned long nr_requested,
@@ -339,6 +339,8 @@ TRACE_EVENT(mm_vmscan_lru_gen_scan,
 
        TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
 
+       TP_CONDITION(nr_scanned),
+
        TP_STRUCT__entry(
                __field(int, highest_zoneidx)
                __field(int, order)
@@ -494,7 +496,6 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
        TP_ARGS(nid, nr_reclaimed, stat, priority, file),
 
        TP_STRUCT__entry(
-               __field(int, nid)
                __field(unsigned long, nr_reclaimed)
                __field(unsigned long, nr_dirty)
                __field(unsigned long, nr_writeback)
@@ -504,6 +505,7 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
                __field(unsigned int, nr_activate1)
                __field(unsigned long, nr_ref_keep)
                __field(unsigned long, nr_unmap_fail)
+               __field(int, nid)
                __field(int, priority)
                __field(int, reclaim_flags)
        ),

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5131,10 +5131,9 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
        __count_memcg_events(memcg, PGREFILL, sorted);
        __count_vm_events(PGSCAN_ANON + type, isolated);
 
-       if (scanned)
-               trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order,
-                               MAX_LRU_BATCH, scanned, skipped, isolated,
-                               sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
+       trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
+                       scanned, skipped, isolated,
+                       sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);



>
>
>>  	/*
>>  	 * There might not be eligible folios due to reclaim_idx. Check the
>>  	 * remaining to prevent livelock if it's not making progress.
>> @@ -5194,6 +5200,8 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>>  retry:
>>  	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
>>  	sc->nr_reclaimed += reclaimed;
>> +	trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
>> +				      sc->priority, type);
>>  
>>  	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
>>  		if (!folio_evictable(folio)) {
>

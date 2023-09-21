Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAA7AA4D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjIUWVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjIUWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:20:51 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D305A5441
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:58:41 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230921060916epoutp0484f1bef0426235a5c8d5de374a6d152f~G1QvXnt7r2744627446epoutp04c
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 06:09:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230921060916epoutp0484f1bef0426235a5c8d5de374a6d152f~G1QvXnt7r2744627446epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695276556;
        bh=I8UM2dlWqwJKF2IV08T8CuxTIF9GZtJKl3Qqt09nY/I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=onAix5jUPMdb8CfFj2m6Y6Mjm/5GQtxT4N+q71xojyq00znsl4cFJEEK6RabXncT5
         zI46GIk9qPvGbXLUOSnebF+oVW6IMv4uhvGlGzJ+g+SbH5o+VIjHZWuBWGlHmLkMTT
         bVPExzsXaNlUqCIYrYRr2NWwZW8vhyImmArO9hrI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230921060916epcas1p2d7a0acf2f0d470e9710f1913d8bf209f~G1Qu23-xt3228832288epcas1p2Q;
        Thu, 21 Sep 2023 06:09:16 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.227]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RrlNC51KRz4x9Px; Thu, 21 Sep
        2023 06:09:15 +0000 (GMT)
X-AuditID: b6c32a4c-d19fe70000004a18-20-650bde0be748
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.92.18968.B0EDB056; Thu, 21 Sep 2023 15:09:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE: (2) [PATCH] vmscan: add trace events for lru_gen
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
In-Reply-To: <20230920103233.145ac387@gandalf.local.home>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230921060915epcms1p6a03b613816b2a99d75ddfd1e8c4a44f7@epcms1p6>
Date:   Thu, 21 Sep 2023 15:09:15 +0900
X-CMS-MailID: 20230921060915epcms1p6a03b613816b2a99d75ddfd1e8c4a44f7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmgS73Pe5Ug5Y2dYs569ewWaze5GvR
        vXkmo0Xv+1dMFk37ZrJbXN41h83i3pr/rBZH1p9lsdjX8YDJ4t36L2wWsxv7GC3eTfjC6sDj
        cfjNe2aPnbPusnu07LvF7rFgU6nHpk+T2D1OzPjN4tG3ZRWjx5kFR9g9Pm+SC+CMyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpYSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgVqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsfXDI5aC
        T1IVPUemsTUw7hLuYuTkkBAwkdi4exlrFyMXh5DAHkaJ6ZebmLoYOTh4BQQl/u4AqxEWsJV4
        c2wiO4gtJKAkcfbHFXaIuLXE/kUzmEBsNgFLie03JzKC2CIC8RJft7exg8xkFuhikdgzazk7
        xDJeiRntT1kgbGmJ7cu3gjVwAjWfP/eQFSIuKnFz9Vt2GPv9sfmMELaIROu9s8wQtqDEg5+7
        GWHm/Dn+nA3CLpZY1vmACcKukVhxbhVU3Fyi4e1KMJtXwFeidcpusDksAqoS8/b+gqp3kfgx
        4RuYzSwgL7H97RxmUDgwC2hKrN+lD1GiKLHz91xGiBI+iXdfe1hh3tox7wnUGDWJlmdfoeIy
        En//PWMFGSMh4CGxbQMjJJiXMUncurSefQKjwixESM9CsngWwuIFjMyrGKVSC4pz01OTDQsM
        dfNSy+ERnJyfu4kRnIC1fHYwfl//V+8QIxMH4yFGCQ5mJRHe5E9cqUK8KYmVValF+fFFpTmp
        xYcYTYHensgsJZqcD8wBeSXxhiaWBiZmRiYWxpbGZkrivDGf2lOEBNITS1KzU1MLUotg+pg4
        OKUamIqMJ3Xf41zv+UPWn3v+P+tDNdN9rsv9ObqDx9ivo+CldJvVF9bJLw/ZO1x8IGn2wvj9
        zWPbDx/aZln87NzavkjPeqNzs2sEs6f92S7IPmmpKb/Z54fml/cs2Png6tOr+2843vt+WqBw
        54zUFSGZXclX+r4GTrPf63tAdY2/2VHeuKlxz/PVVpQtnzfdp17C/8Hi39qK/KsU/y8LOO43
        +dJ2qdSwOzc/69zUkk1qYf65anHJpY7nNcan0qW10zY9mdsy6b/K3Pr/xuoC6456PSrsnMiR
        u/3vz+1hDMU3c1u6hDO/vElv23meWTMusDF5fVK4U5IG+2srltvW7fV5fpmHp6TsiRBz8vr+
        SmH7g+VKLMUZiYZazEXFiQCIJqZ6SQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b
References: <20230920103233.145ac387@gandalf.local.home>
        <20230919095927.5a964094@gandalf.local.home>
        <20230919025216.1878-1-jaewon31.kim@samsung.com>
        <20230920074948epcms1p82d18c2f4d6a0b5699d50fc419b9ba9fe@epcms1p8>
        <CGME20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b@epcms1p6>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Great. Thank you for your comment.
>> 
>> For the putting the struct scan_control *sc inside the trace,
>> I couldn't do that because struct scan_control is defined in mm/vmscan.c.
>> I think I should not move it to a seperate header file.
>
>Well if you ever decide to do so, one thing to do is to move the
>trace/events/vmscan.h into mm/ as trace_vmscan.h so that it would have
>access to local header files. Then all you need to do is to move the
>struct scan_control into a local mm/X.h header file.
>
>> 
>> As you may expect, I just made this by copying the existing
>> trace_mm_vmscan_lru_isolate and trace_mm_vmscan_lru_shrink_inactive
>> 
>> I've tried to change like this.
>> Would this be good for you?
>
>The below looks fine to me. Thanks.
>
>-- Steve

Thank you for your comment.
But I still don't know if I can move the strut scan_control into a
new separate header file, mm/X.h. I guess it was meant to be located
in vmscan.c only.

Let me just send v2 patch with only this change, and wait for other
mm guys comments regarding the moving the struct scan_control thing.

Thank you very much.

>
>> 
>> 
>> --- a/include/trace/events/vmscan.h
>> +++ b/include/trace/events/vmscan.h
>> @@ -327,7 +327,7 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>>                 __print_symbolic(__entry->lru, LRU_NAMES))
>>  );
>>  
>> -TRACE_EVENT(mm_vmscan_lru_gen_scan,
>> +TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
>>         TP_PROTO(int highest_zoneidx,
>>                 int order,
>>                 unsigned long nr_requested,
>> @@ -339,6 +339,8 @@ TRACE_EVENT(mm_vmscan_lru_gen_scan,
>>  
>>         TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
>>  
>> +       TP_CONDITION(nr_scanned),
>> +
>>         TP_STRUCT__entry(
>>                 __field(int, highest_zoneidx)
>>                 __field(int, order)
>> @@ -494,7 +496,6 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
>>         TP_ARGS(nid, nr_reclaimed, stat, priority, file),
>>  
>>         TP_STRUCT__entry(
>> -               __field(int, nid)
>>                 __field(unsigned long, nr_reclaimed)
>>                 __field(unsigned long, nr_dirty)
>>                 __field(unsigned long, nr_writeback)
>> @@ -504,6 +505,7 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
>>                 __field(unsigned int, nr_activate1)
>>                 __field(unsigned long, nr_ref_keep)
>>                 __field(unsigned long, nr_unmap_fail)
>> +               __field(int, nid)
>>                 __field(int, priority)
>>                 __field(int, reclaim_flags)
>>         ),
>> 
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5131,10 +5131,9 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>>         __count_memcg_events(memcg, PGREFILL, sorted);
>>         __count_vm_events(PGSCAN_ANON + type, isolated);
>>  
>> -       if (scanned)
>> -               trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order,
>> -                               MAX_LRU_BATCH, scanned, skipped, isolated,
>> -                               sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
>> +       trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
>> +                       scanned, skipped, isolated,
>> +                       sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
>> 
>> 
>> 
>> >

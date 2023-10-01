Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737E7B4A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 01:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjJAXld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 19:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJAXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 19:41:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE02BF;
        Sun,  1 Oct 2023 16:41:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b28dee4de8so322722666b.1;
        Sun, 01 Oct 2023 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696203687; x=1696808487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCw6Qf7uaEQJpAr4uqh6Rw9ragn/5xvPfhWBouy9/U4=;
        b=a+UJIzQGGORm7BSiFrfbg4Sz2gzoAcpV6NNxyhN15/p3MAioYLOg/vKAYsIjJGOlG0
         HE/Jivq9e5D5t2M2WFPXcNIAIQQdjXpFUBWeb1vma880nAZt7vxBOOuo3QHv0epGt/zC
         LfgzaCgMpYQ2HfKfPZU8YPcZJtyuTuNCD3Wb83UJBwJLX9BzX4MDsGDA3bfgL/2JjmUN
         Au+gG214vXCsgAoNrb6AQq69sGvDnCmfIzM+8xDBN7d6muiN8doHwveR3wErE4mNMIz/
         gJr/k//nwTbKKUPE9LILoEsgPHq29bc2LUUo3R+w+y0bmbjBqTvZVv4JP5nz9rwhqoyx
         6Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696203687; x=1696808487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCw6Qf7uaEQJpAr4uqh6Rw9ragn/5xvPfhWBouy9/U4=;
        b=kcTwZrCm/uJuRwBkcYhu6QgSASNqXttFNmuFT0BaW7cDmdCvn7Oa2hevIZfcZNHGqk
         gmqLyVcawRLn/CuU/Ybg7iiO1hf8QdPEnWyZHNHWsXmgZxp8HMjXrSN5U+cXb3/78OKY
         E0d8TadF5vfDprdiMJ6qt1M0bwerKdCEIXPEp6eTtsMtBfqOKpwfNpfbBtHygjMmQOfn
         rIjxjo0fHdN+O4cncEcluU020ukbFYtLn9wSw6EJLIcvLnmvHm+PfonOT9udHOR+9nLm
         aHl23Y/n2dFC3/9LeV7ItcKD2SzF4aIcCa1bpAK2xFTx2742o69rsMsyALuI3zxVOK1Y
         pRsw==
X-Gm-Message-State: AOJu0YyYYi4LuOalj6WkMKmoCiTVBOR2VjA8RMf+SOTjb6hLbSOEYyXq
        bh9qU93LvwHYxYTieqvJjR1tp1a+S5qc6R7OmJE=
X-Google-Smtp-Source: AGHT+IHmk1YnWFiKu+cNPgBJIsBy+qelPFXYFGFUBywv2fg/TeAZnUdFpQPAGdzT3mP0V8HkRBBxzbHmZFy+EE8NVoI=
X-Received: by 2002:a05:6402:430f:b0:522:580f:8304 with SMTP id
 m15-20020a056402430f00b00522580f8304mr8767814edc.1.1696203687373; Sun, 01 Oct
 2023 16:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da@epcms1p3>
 <CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
 <20230926042250.6028-1-jaewon31.kim@samsung.com> <CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcms1p5>
 <20230926073333epcms1p14c9798232b395007eb20becb5dbc4b4e@epcms1p1> <20230926141519epcms1p5b7808c768df48647516f458529e4e3c8@epcms1p5>
In-Reply-To: <20230926141519epcms1p5b7808c768df48647516f458529e4e3c8@epcms1p5>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Mon, 2 Oct 2023 08:41:15 +0900
Message-ID: <CAJrd-Uu16oZncaFzycGoyryxyjEGFWJdecQoShveGV6_GGJLiQ@mail.gmail.com>
Subject: Re: [PATCH v4] vmscan: add trace events for lru_gen
To:     jaewon31.kim@samsung.com
Cc:     Yu Zhao <yuzhao@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "sj@kernel.org" <sj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yu Zhao

Could you give me your comment? I am waiting for your opinion on the
reuse method. I'm planning to resend it as a complete patch with it.
Thank you.


On Tue, Sep 26, 2023 at 11:15=E2=80=AFPM =EA=B9=80=EC=9E=AC=EC=9B=90 <jaewo=
n31.kim@samsung.com> wrote:
>
> >>>On Mon, Sep 25, 2023 at 10:20?PM Jaewon Kim <jaewon31.kim@samsung.com>=
 wrote:
> >>>>
> >>>> As the legacy lru provides, the lru_gen needs some trace events for
> >>>> debugging.
> >>>>
> >>>> This commit introduces 2 trace events.
> >>>>   trace_mm_vmscan_lru_gen_scan
> >>>>   trace_mm_vmscan_lru_gen_evict
> >>>>
> >>>> Each event is similar to the following legacy events.
> >>>>   trace_mm_vmscan_lru_isolate,
> >>>>   trace_mm_vmscan_lru_shrink_[in]active
> >>>
> >>>We should just reuse trace_mm_vmscan_lru_isolate and
> >>>trace_mm_vmscan_lru_shrink_inactive instead of adding new tracepoints.
> >>>
> >>>To reuse trace_mm_vmscan_lru_isolate, we'd just need to append two new
> >>>names to LRU_NAMES.
> >>>
> >>>The naming of trace_mm_vmscan_lru_shrink_inactive might seem confusing
> >>>but it's how MGLRU maintains the compatibility, e.g., the existing
> >>>active/inactive counters in /proc/vmstat.
> >>
> >>
> >>Hello
> >>
> >>Actually I had tried to reuse them. But some value was not that compati=
ble.
> >>Let me try that way again.
> >>
> >>>
> >
> >Hello Yu Zhao
> >
> >Could you look into what I tried below? I reused the legacy trace events=
 as you recommened.
> >
> >For the nr_scanned for trace_mm_vmscan_lru_shrink_inactive, I just used =
the scanned returned from isolate_folios.
> >I thought this is right as scan_folios also uses its isolated.
> >  __count_vm_events(PGSCAN_ANON + type, isolated);
> >But I guess the scanned in scan_folios is actually the one used in shrin=
k_inactive_list
>
> please ignore nr_scanned thing above I just misread the code.
>
> This is an example, I think it works well.
>
>  mm_vmscan_lru_isolate: isolate_mode=3D0 classzone=3D2 order=3D0 nr_reque=
sted=3D4096 nr_scanned=3D64 nr_skipped=3D0 nr_taken=3D64 lru=3Dinactive_fil=
e
>  mm_vmscan_lru_shrink_inactive: nid=3D0 nr_scanned=3D64 nr_reclaimed=3D63=
 nr_dirty=3D0 nr_writeback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activat=
e_anon=3D0 nr_activate_file=3D1 nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=
=3D2 flags=3DRECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>
> >
> >I tested this on both 0 and 7 of /sys/kernel/mm/lru_gen/enabled
> >
> >
> >diff --git a/mm/vmscan.c b/mm/vmscan.c
> >index a4e44f1c97c1..b61a0156559c 100644
> >--- a/mm/vmscan.c
> >+++ b/mm/vmscan.c
> >@@ -4328,6 +4328,7 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
> >        int sorted =3D 0;
> >        int scanned =3D 0;
> >        int isolated =3D 0;
> >+       int skipped =3D 0;
> >        int remaining =3D MAX_LRU_BATCH;
> >        struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> >        struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
> >@@ -4341,7 +4342,7 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
> >
> >        for (i =3D MAX_NR_ZONES; i > 0; i--) {
> >                LIST_HEAD(moved);
> >-               int skipped =3D 0;
> >+               int skipped_zone =3D 0;
> >                int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
> >                struct list_head *head =3D &lrugen->folios[gen][type][zo=
ne];
> >
> >@@ -4363,16 +4364,17 @@ static int scan_folios(struct lruvec *lruvec, st=
ruct scan_control *sc,
> >                                isolated +=3D delta;
> >                        } else {
> >                                list_move(&folio->lru, &moved);
> >-                               skipped +=3D delta;
> >+                               skipped_zone +=3D delta;
> >                        }
> >
> >-                       if (!--remaining || max(isolated, skipped) >=3D =
MIN_LRU_BATCH)
> >+                       if (!--remaining || max(isolated, skipped_zone) =
>=3D MIN_LRU_BATCH)
> >                                break;
> >                }
> >
> >-               if (skipped) {
> >+               if (skipped_zone) {
> >                        list_splice(&moved, head);
> >-                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped=
);
> >+                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped=
_zone);
> >+                       skipped +=3D skipped_zone;
> >                }
> >
> >                if (!remaining || isolated >=3D MIN_LRU_BATCH)
> >@@ -4387,6 +4389,9 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
> >        __count_memcg_events(memcg, item, isolated);
> >        __count_memcg_events(memcg, PGREFILL, sorted);
> >        __count_vm_events(PGSCAN_ANON + type, isolated);
> >+       trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_=
BATCH,
> >+                                   scanned, skipped, isolated,
> >+                                   type ? LRU_INACTIVE_FILE : LRU_INACT=
IVE_ANON);
> >
> >        /*
> >         * There might not be eligible folios due to reclaim_idx. Check =
the
> >@@ -4517,6 +4522,9 @@ static int evict_folios(struct lruvec *lruvec, str=
uct scan_control *sc, int swap
> > retry:
> >        reclaimed =3D shrink_folio_list(&list, pgdat, sc, &stat, false);
> >        sc->nr_reclaimed +=3D reclaimed;
> >+       trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
> >+                       scanned, reclaimed, &stat, sc->priority,
> >+                       type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> >
> >        list_for_each_entry_safe_reverse(folio, next, &list, lru) {
> >                if (!folio_evictable(folio)) {
> >

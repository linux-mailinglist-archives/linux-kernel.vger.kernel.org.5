Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4047AE4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjIZEnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjIZEnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:43:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E297
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:42:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-414ba610766so250561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695703378; x=1696308178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoC6U6DormUl1mocoqw5nM9OGVZ4Fofl8JzZojtmuKQ=;
        b=dhDba4o+OfXyL3N4K8Vh4Pr+2YNfFoq1qxter94iNESepKZxL4Y+0TAPAtU4sh5qOI
         Wb8Ig3mQ1av9kyZv5fIyPZJs0uew7ubIsjEF4TY31vZXaTE3Z4Hn5DxCUOqoacXEaD39
         ztBD+spcIkQ186p7nIVld6C5eBVfnSosCONPH563r0p9RU2+W/F9I6LsyTCTpd6z/iw9
         95YeXWj2fXdIp9u7cimNznSCg8GJ5Ash8H2Uf+CR70HqTRjELISpbr/q1YzEOC1mVhfD
         5qvTKxl4sIjQCle8L+OGTpwrdSf6zHlBWpQZ+47sc1AmXwUNQhyO7GJMmbFBSuZhYn4Q
         Xmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703378; x=1696308178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoC6U6DormUl1mocoqw5nM9OGVZ4Fofl8JzZojtmuKQ=;
        b=Y94FviYJjgsoIOeqCXvGQVF3X6kVaYVRfhdajDJm4fWpdVSU53Kqa5p2rzkAmBT3XX
         HiR884TU2fUgKillrcmlPHNiwOwaFpFddweCMUk0Gd2CJz/EPWj0nIc/dCCyciOa2XOT
         DDjoJ6BOrKQ8oa7al2llGaTz5Qn/LCIDiMxV2gzme0ta/SfIRMwUxuPguiZzVyyBo82D
         x1qWPRtDv9fkIAhn8gKEnyGzpD8AeTfNf6awxmkXkbwaCQlLvlcoMnZC2yED8JAcKd75
         Yfhaz+umd+30BGrFKavAVgs3xULAWaI6lp6AkJzcNvlOZQ7sJbs0n7mU9ASbnpG/NuX3
         4qcA==
X-Gm-Message-State: AOJu0YxXL/0vTyNF/tuI24Pcf1ybeQF2ZpKBE/1JWkdfPFgZTjIsO4ma
        QAAPNuJ/JS9By1OMFiyTW1JfspV+n6o3cpnXHxPHQg==
X-Google-Smtp-Source: AGHT+IHg9BZE9kehIkRwunfBeTpf0rW+DMKNfVOg2JTfPkGQzEpOViVbp2YQwA4/jXtxdK9JJGB6bA5dfxOG9Z9XsrE=
X-Received: by 2002:a05:622a:5cf:b0:403:e1d1:8b63 with SMTP id
 d15-20020a05622a05cf00b00403e1d18b63mr205845qtb.24.1695703378283; Mon, 25 Sep
 2023 21:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcas1p1.samsung.com>
 <20230926042250.6028-1-jaewon31.kim@samsung.com>
In-Reply-To: <20230926042250.6028-1-jaewon31.kim@samsung.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 25 Sep 2023 22:42:21 -0600
Message-ID: <CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
Subject: Re: [PATCH v4] vmscan: add trace events for lru_gen
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     rostedt@goodmis.org, tjmercier@google.com, kaleshsingh@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
        sj@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        jaewon31.kim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:20=E2=80=AFPM Jaewon Kim <jaewon31.kim@samsung.c=
om> wrote:
>
> As the legacy lru provides, the lru_gen needs some trace events for
> debugging.
>
> This commit introduces 2 trace events.
>   trace_mm_vmscan_lru_gen_scan
>   trace_mm_vmscan_lru_gen_evict
>
> Each event is similar to the following legacy events.
>   trace_mm_vmscan_lru_isolate,
>   trace_mm_vmscan_lru_shrink_[in]active

We should just reuse trace_mm_vmscan_lru_isolate and
trace_mm_vmscan_lru_shrink_inactive instead of adding new tracepoints.

To reuse trace_mm_vmscan_lru_isolate, we'd just need to append two new
names to LRU_NAMES.

The naming of trace_mm_vmscan_lru_shrink_inactive might seem confusing
but it's how MGLRU maintains the compatibility, e.g., the existing
active/inactive counters in /proc/vmstat.

> Here's an example
>   mm_vmscan_lru_gen_scan: classzone=3D2 order=3D0 nr_requested=3D4096 nr_=
scanned=3D64 nr_skipped=3D0 nr_taken=3D64 lru=3Danon
>   mm_vmscan_lru_gen_evict: nid=3D0 nr_reclaimed=3D64 nr_dirty=3D0 nr_writ=
eback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activat=
e_file=3D0 nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D2 flags=3DRECLAIM_W=
B_ANON|RECLAIM_WB_ASYNC
>   mm_vmscan_lru_gen_scan: classzone=3D1 order=3D0 nr_requested=3D4096 nr_=
scanned=3D64 nr_skipped=3D0 nr_taken=3D64 lru=3Dfile
>   mm_vmscan_lru_gen_evict: nid=3D0 nr_reclaimed=3D64 nr_dirty=3D0 nr_writ=
eback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activat=
e_file=3D0 nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D12 flags=3DRECLAIM_=
WB_FILE|RECLAIM_WB_ASYNC
>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
> v4: wrap with #ifdef CONFIG_LRU_GEN
> v3: change printk format
> v2: use condition and make it aligned
> v1: introduce trace events
> ---
>  include/trace/events/mmflags.h |  9 ++++
>  include/trace/events/vmscan.h  | 96 ++++++++++++++++++++++++++++++++++
>  mm/vmscan.c                    | 20 +++++--
>  3 files changed, 120 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflag=
s.h
> index 1478b9dd05fa..6dfe85bd4e81 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -274,6 +274,12 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY, "softdirty"     )=
               \
>                 EM (LRU_ACTIVE_FILE, "active_file") \
>                 EMe(LRU_UNEVICTABLE, "unevictable")
>
> +#ifdef CONFIG_LRU_GEN
> +#define LRU_GEN_NAMES          \
> +               EM (LRU_GEN_ANON, "anon") \
> +               EMe(LRU_GEN_FILE, "file")
> +#endif
> +
>  /*
>   * First define the enums in the above macros to be exported to userspac=
e
>   * via TRACE_DEFINE_ENUM().
> @@ -288,6 +294,9 @@ COMPACTION_PRIORITY
>  /* COMPACTION_FEEDBACK are defines not enums. Not needed here. */
>  ZONE_TYPE
>  LRU_NAMES
> +#ifdef CONFIG_LRU_GEN
> +LRU_GEN_NAMES
> +#endif
>
>  /*
>   * Now redefine the EM() and EMe() macros to map the enums to the string=
s
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.=
h
> index d2123dd960d5..2080ef742f89 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -327,6 +327,102 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>                 __print_symbolic(__entry->lru, LRU_NAMES))
>  );
>
> +#ifdef CONFIG_LRU_GEN
> +TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
> +       TP_PROTO(int highest_zoneidx,
> +               int order,
> +               unsigned long nr_requested,
> +               unsigned long nr_scanned,
> +               unsigned long nr_skipped,
> +               unsigned long nr_taken,
> +               int lru),
> +
> +       TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skip=
ped, nr_taken, lru),
> +
> +       TP_CONDITION(nr_scanned),
> +
> +       TP_STRUCT__entry(
> +               __field(int, highest_zoneidx)
> +               __field(int, order)
> +               __field(unsigned long, nr_requested)
> +               __field(unsigned long, nr_scanned)
> +               __field(unsigned long, nr_skipped)
> +               __field(unsigned long, nr_taken)
> +               __field(int, lru)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->highest_zoneidx =3D highest_zoneidx;
> +               __entry->order =3D order;
> +               __entry->nr_requested =3D nr_requested;
> +               __entry->nr_scanned =3D nr_scanned;
> +               __entry->nr_skipped =3D nr_skipped;
> +               __entry->nr_taken =3D nr_taken;
> +               __entry->lru =3D lru;
> +       ),
> +
> +       /*
> +        * classzone is previous name of the highest_zoneidx.
> +        * Reason not to change it is the ABI requirement of the tracepoi=
nt.
> +        */
> +       TP_printk("classzone=3D%d order=3D%d nr_requested=3D%lu nr_scanne=
d=3D%lu nr_skipped=3D%lu nr_taken=3D%lu lru=3D%s",
> +               __entry->highest_zoneidx,
> +               __entry->order,
> +               __entry->nr_requested,
> +               __entry->nr_scanned,
> +               __entry->nr_skipped,
> +               __entry->nr_taken,
> +               __print_symbolic(__entry->lru, LRU_GEN_NAMES))
> +);
> +
> +TRACE_EVENT(mm_vmscan_lru_gen_evict,
> +
> +       TP_PROTO(int nid, unsigned long nr_reclaimed,
> +               struct reclaim_stat *stat, int priority, int file),
> +
> +       TP_ARGS(nid, nr_reclaimed, stat, priority, file),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, nr_reclaimed)
> +               __field(unsigned long, nr_dirty)
> +               __field(unsigned long, nr_writeback)
> +               __field(unsigned long, nr_congested)
> +               __field(unsigned long, nr_immediate)
> +               __field(unsigned int, nr_activate0)
> +               __field(unsigned int, nr_activate1)
> +               __field(unsigned long, nr_ref_keep)
> +               __field(unsigned long, nr_unmap_fail)
> +               __field(int, nid)
> +               __field(int, priority)
> +               __field(int, reclaim_flags)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->nid =3D nid;
> +               __entry->nr_reclaimed =3D nr_reclaimed;
> +               __entry->nr_dirty =3D stat->nr_dirty;
> +               __entry->nr_writeback =3D stat->nr_writeback;
> +               __entry->nr_congested =3D stat->nr_congested;
> +               __entry->nr_immediate =3D stat->nr_immediate;
> +               __entry->nr_activate0 =3D stat->nr_activate[0];
> +               __entry->nr_activate1 =3D stat->nr_activate[1];
> +               __entry->nr_ref_keep =3D stat->nr_ref_keep;
> +               __entry->nr_unmap_fail =3D stat->nr_unmap_fail;
> +               __entry->priority =3D priority;
> +               __entry->reclaim_flags =3D trace_reclaim_flags(file);
> +       ),
> +
> +       TP_printk("nid=3D%d nr_reclaimed=3D%lu nr_dirty=3D%lu nr_writebac=
k=3D%lu nr_congested=3D%lu nr_immediate=3D%lu nr_activate_anon=3D%u nr_acti=
vate_file=3D%u nr_ref_keep=3D%lu nr_unmap_fail=3D%lu priority=3D%d flags=3D=
%s",
> +               __entry->nid, __entry->nr_reclaimed,
> +               __entry->nr_dirty, __entry->nr_writeback,
> +               __entry->nr_congested, __entry->nr_immediate,
> +               __entry->nr_activate0, __entry->nr_activate1,
> +               __entry->nr_ref_keep, __entry->nr_unmap_fail,
> +               __entry->priority,
> +               show_reclaim_flags(__entry->reclaim_flags))
> +);
> +#endif
> +
>  TRACE_EVENT(mm_vmscan_write_folio,
>
>         TP_PROTO(struct folio *folio),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6f13394b112e..0c8b48bcb461 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5005,6 +5005,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         int sorted =3D 0;
>         int scanned =3D 0;
>         int isolated =3D 0;
> +       int skipped =3D 0;
>         int remaining =3D MAX_LRU_BATCH;
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
> @@ -5018,7 +5019,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>
>         for (i =3D MAX_NR_ZONES; i > 0; i--) {
>                 LIST_HEAD(moved);
> -               int skipped =3D 0;
> +               int skipped_zone =3D 0;
>                 int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                 struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
>
> @@ -5040,16 +5041,17 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
>                                 isolated +=3D delta;
>                         } else {
>                                 list_move(&folio->lru, &moved);
> -                               skipped +=3D delta;
> +                               skipped_zone +=3D delta;
>                         }
>
> -                       if (!--remaining || max(isolated, skipped) >=3D M=
IN_LRU_BATCH)
> +                       if (!--remaining || max(isolated, skipped_zone) >=
=3D MIN_LRU_BATCH)
>                                 break;
>                 }
>
> -               if (skipped) {
> +               if (skipped_zone) {
>                         list_splice(&moved, head);
> -                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped)=
;
> +                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped_=
zone);
> +                       skipped +=3D skipped_zone;
>                 }
>
>                 if (!remaining || isolated >=3D MIN_LRU_BATCH)
> @@ -5065,6 +5067,10 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
>         __count_memcg_events(memcg, PGREFILL, sorted);
>         __count_vm_events(PGSCAN_ANON + type, isolated);
>
> +#ifdef CONFIG_LRU_GEN
> +       trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_=
BATCH,
> +                       scanned, skipped, isolated, type);
> +#endif

These functions are already within CONFIG_LRU_GEN.

>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -5194,6 +5200,10 @@ static int evict_folios(struct lruvec *lruvec, str=
uct scan_control *sc, int swap
>  retry:
>         reclaimed =3D shrink_folio_list(&list, pgdat, sc, &stat, false);
>         sc->nr_reclaimed +=3D reclaimed;
> +#ifdef CONFIG_LRU_GEN
> +       trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
> +                                     sc->priority, type);
> +#endif

Ditto.

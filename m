Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257E8807C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441798AbjLFXjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjLFXjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:39:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCEA4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:39:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5394a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701905958; x=1702510758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXDE6J1nVfJg93wGJKDjkzbUE0s3CIXmehRMH73JMCU=;
        b=pm0UkKa/+DWIDnsZusJr4TVyh+AZZsQp2D9z3j8wugLmzDeBA6uicon2bw7Pp/VG6X
         Lq1CnuQSFjdZGQrh+9qgbranToIXf7vNIpPULs6h73hz/JTz3+Z0N32F0FhFYHmjt0kM
         jHpcsRMud5TmtgYMFO0HZ799H5HnXYEfeUwlSvlS5TmL2zYXeLyq3GSYnYIIkKwhljqe
         NQzWox8YgHy+figv/4Ac4GyRvz64VhyK7OQRF6DKkuE4jJ3CyTPIz0pDIQN6fQgxJ7ub
         GHss51ugxiWSxOpG8waYGgq1agu1TwuyGg6v6VmViWWjyuJjRR+4NU0jVTceAHVfZAt+
         bxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905958; x=1702510758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXDE6J1nVfJg93wGJKDjkzbUE0s3CIXmehRMH73JMCU=;
        b=KYsC+s3iY0tj16ZyyUPKVx9wmdIcB3p4tWjHQt4+vKIf2uE0dHDU3gVNwC2q/BGZwQ
         WYIlylAw/ZEpGKTIhH62AH1IN5n0RBvId0pG1v2xytcK7bbOotJPxYmYqMfdjDxSl5Sq
         wlStn7eORdGFOWkRgZCslmtOVuTg06n9uHZhWZ5fFqVux3Ns596J+MQgw/sGeB1b8hn1
         yjfB2WwjdQZsF7DbCtD3y9XBVJ5NqQ0zH/TGGSPmk9qGksQK9LHpVq8cWS2t4QnXXQx8
         gIp2DojCO+wqxGSpg2WcnG9IcRd6FWuf7gBYt4LhhoVB03KIjlxOsbMlB5DhAGUlO3Ke
         6WlQ==
X-Gm-Message-State: AOJu0YwgaX1BOiIKMiGUYOb3r03hrWKP9dku2RMTz91FrVc6/RbzQJ1I
        egA17YT3NhZ4Np9VeVn49l3RDvOdpSMo7GeUZ2irzQ==
X-Google-Smtp-Source: AGHT+IFKP8XUxAXse9Lx6CIFn+syqtsYY8Wpp8RCyiOHqdGl5W23i0Cvc+SJ6knGPcsHbBgWRjy2uAEAQOt2f+HWLYg=
X-Received: by 2002:a50:d0cc:0:b0:54c:9996:7833 with SMTP id
 g12-20020a50d0cc000000b0054c99967833mr136601edf.7.1701905957898; Wed, 06 Dec
 2023 15:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-19-irogers@google.com>
 <CAM9d7chbysNaH++LQgeskZ_LRAF7KuErexapDTWRf-zsgPOq1g@mail.gmail.com>
In-Reply-To: <CAM9d7chbysNaH++LQgeskZ_LRAF7KuErexapDTWRf-zsgPOq1g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 15:39:06 -0800
Message-ID: <CAP-5=fWnvRqQY5fX1ada3c+7Xsh4+Up2cxR12xkgQSKf1-OgBg@mail.gmail.com>
Subject: Re: [PATCH v5 18/50] perf maps: Refactor maps__fixup_overlappings
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 3:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 27, 2023 at 2:10=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Rename to maps__fixup_overlap_and_insert as the given mapping is
> > always inserted. Factor out first_ending_after as a utility
> > function. Minor variable name changes. Switch to using debug_file()
> > rather than passing a debug FILE*.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/maps.c   | 62 ++++++++++++++++++++++++----------------
> >  tools/perf/util/maps.h   |  2 +-
> >  tools/perf/util/thread.c |  3 +-
> >  3 files changed, 39 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index f13fd3a9686b..40df08dd9bf3 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> > @@ -334,20 +334,16 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
> >         return args.printed;
> >  }
> >
> > -int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE =
*fp)
> > +/*
> > + * Find first map where end > new->start.
>
> s/new/map/.
>
> > + * Same as find_vma() in kernel.
> > + */
> > +static struct rb_node *first_ending_after(struct maps *maps, const str=
uct map *map)
> >  {
> >         struct rb_root *root;
> >         struct rb_node *next, *first;
> > -       int err =3D 0;
> > -
> > -       down_write(maps__lock(maps));
> >
> >         root =3D maps__entries(maps);
> > -
> > -       /*
> > -        * Find first map where end > map->start.
> > -        * Same as find_vma() in kernel.
> > -        */
> >         next =3D root->rb_node;
> >         first =3D NULL;
> >         while (next) {
> > @@ -361,8 +357,22 @@ int maps__fixup_overlappings(struct maps *maps, st=
ruct map *map, FILE *fp)
> >                 } else
> >                         next =3D next->rb_right;
> >         }
> > +       return first;
> > +}
> > +
> > +/*
> > + * Adds new to maps, if new overlaps existing entries then the existin=
g maps are
> > + * adjusted or removed so that new fits without overlapping any entrie=
s.
> > + */
> > +int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>
> Do we really need this rename (map -> new)?  It seems just to create
> unnecessary diffs.  Also I'd like to avoid 'new' as it's a keyword in C++
> although we don't compile with C++ compilers.

Agreed on the C++ issue, but this is also an issue in linux/list.h
that uses the same naming convention. The reason for the change from
map to new is that "pos->map" and "map" read very similarly, so the
code is more intention revealing with the change.


> > +{
> > +
> > +       struct rb_node *next;
> > +       int err =3D 0;
>
> Maybe you can add this line or let the caller pass it to reduce the diff.
>
>     FILE *fp =3D debug_file();

Good idea. Done in v6.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> > +       down_write(maps__lock(maps));
> >
> > -       next =3D first;
> > +       next =3D first_ending_after(maps, new);
> >         while (next && !err) {
> >                 struct map_rb_node *pos =3D rb_entry(next, struct map_r=
b_node, rb_node);
> >                 next =3D rb_next(&pos->rb_node);
> > @@ -371,27 +381,27 @@ int maps__fixup_overlappings(struct maps *maps, s=
truct map *map, FILE *fp)
> >                  * Stop if current map starts after map->end.
> >                  * Maps are ordered by start: next will not overlap for=
 sure.
> >                  */
> > -               if (map__start(pos->map) >=3D map__end(map))
> > +               if (map__start(pos->map) >=3D map__end(new))
> >                         break;
> >
> >                 if (verbose >=3D 2) {
> >
> >                         if (use_browser) {
> >                                 pr_debug("overlapping maps in %s (disab=
le tui for more info)\n",
> > -                                        map__dso(map)->name);
> > +                                        map__dso(new)->name);
> >                         } else {
> > -                               fputs("overlapping maps:\n", fp);
> > -                               map__fprintf(map, fp);
> > -                               map__fprintf(pos->map, fp);
> > +                               pr_debug("overlapping maps:\n");
> > +                               map__fprintf(new, debug_file());
> > +                               map__fprintf(pos->map, debug_file());
> >                         }
> >                 }
> >
> > -               rb_erase_init(&pos->rb_node, root);
> > +               rb_erase_init(&pos->rb_node, maps__entries(maps));
> >                 /*
> >                  * Now check if we need to create new maps for areas no=
t
> >                  * overlapped by the new map:
> >                  */
> > -               if (map__start(map) > map__start(pos->map)) {
> > +               if (map__start(new) > map__start(pos->map)) {
> >                         struct map *before =3D map__clone(pos->map);
> >
> >                         if (before =3D=3D NULL) {
> > @@ -399,7 +409,7 @@ int maps__fixup_overlappings(struct maps *maps, str=
uct map *map, FILE *fp)
> >                                 goto put_map;
> >                         }
> >
> > -                       map__set_end(before, map__start(map));
> > +                       map__set_end(before, map__start(new));
> >                         err =3D __maps__insert(maps, before);
> >                         if (err) {
> >                                 map__put(before);
> > @@ -407,11 +417,11 @@ int maps__fixup_overlappings(struct maps *maps, s=
truct map *map, FILE *fp)
> >                         }
> >
> >                         if (verbose >=3D 2 && !use_browser)
> > -                               map__fprintf(before, fp);
> > +                               map__fprintf(before, debug_file());
> >                         map__put(before);
> >                 }
> >
> > -               if (map__end(map) < map__end(pos->map)) {
> > +               if (map__end(new) < map__end(pos->map)) {
> >                         struct map *after =3D map__clone(pos->map);
> >
> >                         if (after =3D=3D NULL) {
> > @@ -419,23 +429,25 @@ int maps__fixup_overlappings(struct maps *maps, s=
truct map *map, FILE *fp)
> >                                 goto put_map;
> >                         }
> >
> > -                       map__set_start(after, map__end(map));
> > -                       map__add_pgoff(after, map__end(map) - map__star=
t(pos->map));
> > -                       assert(map__map_ip(pos->map, map__end(map)) =3D=
=3D
> > -                               map__map_ip(after, map__end(map)));
> > +                       map__set_start(after, map__end(new));
> > +                       map__add_pgoff(after, map__end(new) - map__star=
t(pos->map));
> > +                       assert(map__map_ip(pos->map, map__end(new)) =3D=
=3D
> > +                               map__map_ip(after, map__end(new)));
> >                         err =3D __maps__insert(maps, after);
> >                         if (err) {
> >                                 map__put(after);
> >                                 goto put_map;
> >                         }
> >                         if (verbose >=3D 2 && !use_browser)
> > -                               map__fprintf(after, fp);
> > +                               map__fprintf(after, debug_file());
> >                         map__put(after);
> >                 }
> >  put_map:
> >                 map__put(pos->map);
> >                 free(pos);
> >         }
> > +       /* Add the map. */
> > +       err =3D __maps__insert(maps, new);
> >         up_write(maps__lock(maps));
> >         return err;
> >  }
> > diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> > index b94ad5c8fea7..62e94d443c02 100644
> > --- a/tools/perf/util/maps.h
> > +++ b/tools/perf/util/maps.h
> > @@ -133,7 +133,7 @@ struct addr_map_symbol;
> >
> >  int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
> >
> > -int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE =
*fp);
> > +int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)=
;
> >
> >  struct map *maps__find_by_name(struct maps *maps, const char *name);
> >
> > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > index b6986a81aa6d..3d47b5c5528b 100644
> > --- a/tools/perf/util/thread.c
> > +++ b/tools/perf/util/thread.c
> > @@ -345,8 +345,7 @@ int thread__insert_map(struct thread *thread, struc=
t map *map)
> >         if (ret)
> >                 return ret;
> >
> > -       maps__fixup_overlappings(thread__maps(thread), map, stderr);
> > -       return maps__insert(thread__maps(thread), map);
> > +       return maps__fixup_overlap_and_insert(thread__maps(thread), map=
);
> >  }
> >
> >  struct thread__prepare_access_maps_cb_args {
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >

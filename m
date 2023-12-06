Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA858074CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379159AbjLFQUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379156AbjLFQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:20:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4CBD49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:20:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so14044a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701879610; x=1702484410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ohk1NigG1siEm2bhRosTQx5GQPGROk7jnoQwA25Duw=;
        b=X2R18QKP1ZZXw/e0bE6uZGrGTf3/+5XitcdVkzlsWn4uWzkKAVHP6ygEvFwErxc4Yr
         mrdEgMyiuk8a+W2ehu0pO9mPZDn3Hk/W5L8I5ro/pLtonKRlGmUg7GX8nw43ZAEIV3an
         BKZMinLPovFMQKEFUFOz7RDlOziSs3FOwKut3Lw5i550XxkTxz61LTfvQ4oTgqziBtKx
         j3zUF6SUr3/bfmB1DBd9mYh5G5bLU5orYPpGmH/Y7ooIcLMvvuODNPEXb4pQgUvDoJ1E
         KyAE5KoMNJBvKl1YK0Yn6/rmvgzdpzVPLGCTfcpe0EO+fx6UFNqii9VlvmmOmt8RRvkc
         GyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701879610; x=1702484410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ohk1NigG1siEm2bhRosTQx5GQPGROk7jnoQwA25Duw=;
        b=RtFTUiF5O7rvfAOmwosk+DapHKrx4Awobw1/30/RwCWimH4BQpQtb5RH2P9F6Np8Ly
         EB0tSiL7VdfZ1p0DhiOMk6HUisDxGn5qD7JvcLfmBwHJoeabR+6AwMTFSVoJ5OrCeScD
         YPm59vqz01XNOO8j4twoe491EA8191ob6FtK3tqQJgRmFtRdEfprVIpkCKm5FcBNYQgk
         QYwARofXF68Ugcu61UK53RZMzEeQ0vym/HnkVw+wZmQ/X55LFswHk6qLvEf1zpA+BvWI
         UftYDqyGYWcJ5B2wl0iAx8mB7fl0Gi7XkCoPsl3W80idAf1d7n5ua3Zw91xHWER4AUVo
         xMGQ==
X-Gm-Message-State: AOJu0YzenEoXTJIP6VSISr6OZ8j7XSLi9DbK+ePZF6v/BI+C9aI+fROy
        vBdnE4ZPw2KOT4pTJIAKkwHSB0LJz/qtd/mo0xiFXw==
X-Google-Smtp-Source: AGHT+IGTR/Rk+eOsjAdKc1agrSCsE5xPkHKd6gTfwrG6riHWP49IsYvaaux9AO7Qyi40m4a7Pk+nLdJ2VsGpVbtnkNk=
X-Received: by 2002:a50:cc8b:0:b0:54b:8f42:e3dc with SMTP id
 q11-20020a50cc8b000000b0054b8f42e3dcmr100950edi.2.1701879609815; Wed, 06 Dec
 2023 08:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-13-irogers@google.com>
 <CAM9d7cgrx7vjLtnSt6Y4q+vtok=kSy6V83xe0c6cT6BVY2m-oA@mail.gmail.com> <ZXB7z8ff0J0IDW1m@kernel.org>
In-Reply-To: <ZXB7z8ff0J0IDW1m@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 08:19:58 -0800
Message-ID: <CAP-5=fV0=XLLBq6x+hpBSAqBEpQ2H72eyyoS3xEv7CzY1YMFLQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/50] perf map: Simplify map_ip/unmap_ip and make map
 size smaller
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 5:49=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Mon, Dec 04, 2023 at 03:39:08PM -0800, Namhyung Kim escreveu:
> > Hi Ian,
> >
> > On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > When mapping an IP it is either an identity mapping or a DSO relative
> > > mapping, so a single bit is required in the struct to identify
> > > this. The current code uses function pointers, adding 2 pointers per
> > > map and also pushing the size of a map beyond 1 cache line. Switch to
> > > using a byte to identify the mapping type (as well as priv and
> > > erange_warned), to avoid any masking. Change struct maps's layout to
> > > avoid holes.
> > >
> > > Before:
> > > ```
> > > struct map {
> > >         u64                        start;                /*     0    =
 8 */
> > >         u64                        end;                  /*     8    =
 8 */
> > >         _Bool                      erange_warned:1;      /*    16: 0 =
 1 */
> > >         _Bool                      priv:1;               /*    16: 1 =
 1 */
> > >
> > >         /* XXX 6 bits hole, try to pack */
> > >         /* XXX 3 bytes hole, try to pack */
> > >
> > >         u32                        prot;                 /*    20    =
 4 */
> > >         u64                        pgoff;                /*    24    =
 8 */
> > >         u64                        reloc;                /*    32    =
 8 */
> > >         u64                        (*map_ip)(const struct map  *, u64=
); /*    40     8 */
> > >         u64                        (*unmap_ip)(const struct map  *, u=
64); /*    48     8 */
> > >         struct dso *               dso;                  /*    56    =
 8 */
> > >         /* --- cacheline 1 boundary (64 bytes) --- */
> > >         refcount_t                 refcnt;               /*    64    =
 4 */
> > >         u32                        flags;                /*    68    =
 4 */
> > >
> > >         /* size: 72, cachelines: 2, members: 12 */
> > >         /* sum members: 68, holes: 1, sum holes: 3 */
> > >         /* sum bitfield members: 2 bits, bit holes: 1, sum bit holes:=
 6 bits */
> > >         /* last cacheline: 8 bytes */
> > > };
> > > ```
> > >
> > > After:
> > > ```
> > > struct map {
> > >         u64                        start;                /*     0    =
 8 */
> > >         u64                        end;                  /*     8    =
 8 */
> > >         u64                        pgoff;                /*    16    =
 8 */
> > >         u64                        reloc;                /*    24    =
 8 */
> > >         struct dso *               dso;                  /*    32    =
 8 */
> > >         refcount_t                 refcnt;               /*    40    =
 4 */
> > >         u32                        prot;                 /*    44    =
 4 */
> > >         u32                        flags;                /*    48    =
 4 */
> > >         enum mapping_type          mapping_type:8;       /*    52: 0 =
 4 */
> > >
> > >         /* Bitfield combined with next fields */
> > >
> > >         _Bool                      erange_warned;        /*    53    =
 1 */
> > >         _Bool                      priv;                 /*    54    =
 1 */
> > >
> > >         /* size: 56, cachelines: 1, members: 11 */
> > >         /* padding: 1 */
> > >         /* last cacheline: 56 bytes */
> > > };
> > > ```
> >
> > Thanks for doing this!  I really wanted to clean up the map
> > code and to make it more intuitive.
> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Applied
>
> > A few nitpicks below.
>
> Ian, please consider those for a follow up clarifying patch.

Thanks, I think the variable name should be done. The PIC vs DSO, I
think there is a bit more cognitive load recognizing PIC means an
offset within the DSO than just using DSO. The existing naming used
dso so I think there is some consistency in using it here. I also
think PIC as a term is used to mean the code within an object is PC or
otherwise relative, enabling it to be loaded anywhere. We could have a
static object which isn't position independent but be using DSO
relative offsets for it, in which case PIC would be misleading. But I
think it is a minor issue.

Ian

> - Arnaldo
>
> > > ---
> > >  tools/perf/util/machine.c    |  3 +-
> > >  tools/perf/util/map.c        | 20 +--------
> > >  tools/perf/util/map.h        | 83 +++++++++++++++++++---------------=
--
> > >  tools/perf/util/symbol-elf.c |  6 +--
> > >  tools/perf/util/symbol.c     |  6 +--
> > >  5 files changed, 50 insertions(+), 68 deletions(-)
> > >
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index be3dab9d5253..b6831a1f909d 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -1360,8 +1360,7 @@ __machine__create_kernel_maps(struct machine *m=
achine, struct dso *kernel)
> > >         if (machine->vmlinux_map =3D=3D NULL)
> > >                 return -ENOMEM;
> > >
> > > -       map__set_map_ip(machine->vmlinux_map, identity__map_ip);
> > > -       map__set_unmap_ip(machine->vmlinux_map, identity__map_ip);
> > > +       map__set_mapping_type(machine->vmlinux_map, MAPPING_TYPE__IDE=
NTITY);
> > >         return maps__insert(machine__kernel_maps(machine), machine->v=
mlinux_map);
> > >  }
> > >
> > > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > > index f64b83004421..54c67cb7ecef 100644
> > > --- a/tools/perf/util/map.c
> > > +++ b/tools/perf/util/map.c
> > > @@ -109,8 +109,7 @@ void map__init(struct map *map, u64 start, u64 en=
d, u64 pgoff, struct dso *dso)
> > >         map__set_pgoff(map, pgoff);
> > >         map__set_reloc(map, 0);
> > >         map__set_dso(map, dso__get(dso));
> > > -       map__set_map_ip(map, map__dso_map_ip);
> > > -       map__set_unmap_ip(map, map__dso_unmap_ip);
> > > +       map__set_mapping_type(map, MAPPING_TYPE__DSO);
> > >         map__set_erange_warned(map, false);
> > >         refcount_set(map__refcnt(map), 1);
> > >  }
> > > @@ -172,7 +171,7 @@ struct map *map__new(struct machine *machine, u64=
 start, u64 len,
> > >                 map__init(result, start, start + len, pgoff, dso);
> > >
> > >                 if (anon || no_dso) {
> > > -                       map->map_ip =3D map->unmap_ip =3D identity__m=
ap_ip;
> > > +                       map->mapping_type =3D MAPPING_TYPE__IDENTITY;
> > >
> > >                         /*
> > >                          * Set memory without DSO as loaded. All map_=
_find_*
> > > @@ -630,18 +629,3 @@ struct maps *map__kmaps(struct map *map)
> > >         }
> > >         return kmap->kmaps;
> > >  }
> > > -
> > > -u64 map__dso_map_ip(const struct map *map, u64 ip)
> > > -{
> > > -       return ip - map__start(map) + map__pgoff(map);
> > > -}
> > > -
> > > -u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> > > -{
> > > -       return ip + map__start(map) - map__pgoff(map);
> > > -}
> > > -
> > > -u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
> > > -{
> > > -       return ip;
> > > -}
> > > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > > index 1b53d53adc86..3a3b7757da5f 100644
> > > --- a/tools/perf/util/map.h
> > > +++ b/tools/perf/util/map.h
> > > @@ -16,23 +16,25 @@ struct dso;
> > >  struct maps;
> > >  struct machine;
> > >
> > > +enum mapping_type {
> > > +       /* map__map_ip/map__unmap_ip are given as offsets in the DSO.=
 */
> > > +       MAPPING_TYPE__DSO,
> >
> > I slightly prefer __PIC than __DSO, but won't argue. :)
> >
> > > +       /* map__map_ip/map__unmap_ip are just the given ip value. */
> > > +       MAPPING_TYPE__IDENTITY,
> > > +};
> > > +
> > >  DECLARE_RC_STRUCT(map) {
> > >         u64                     start;
> > >         u64                     end;
> > > -       bool                    erange_warned:1;
> > > -       bool                    priv:1;
> > > -       u32                     prot;
> > >         u64                     pgoff;
> > >         u64                     reloc;
> > > -
> > > -       /* ip -> dso rip */
> > > -       u64                     (*map_ip)(const struct map *, u64);
> > > -       /* dso rip -> ip */
> > > -       u64                     (*unmap_ip)(const struct map *, u64);
> > > -
> > >         struct dso              *dso;
> > >         refcount_t              refcnt;
> > > +       u32                     prot;
> > >         u32                     flags;
> > > +       enum mapping_type       mapping_type:8;
> > > +       bool                    erange_warned;
> > > +       bool                    priv;
> > >  };
> > >
> > >  struct kmap;
> > > @@ -41,38 +43,11 @@ struct kmap *__map__kmap(struct map *map);
> > >  struct kmap *map__kmap(struct map *map);
> > >  struct maps *map__kmaps(struct map *map);
> > >
> > > -/* ip -> dso rip */
> > > -u64 map__dso_map_ip(const struct map *map, u64 ip);
> > > -/* dso rip -> ip */
> > > -u64 map__dso_unmap_ip(const struct map *map, u64 ip);
> > > -/* Returns ip */
> > > -u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
> > > -
> > >  static inline struct dso *map__dso(const struct map *map)
> > >  {
> > >         return RC_CHK_ACCESS(map)->dso;
> > >  }
> > >
> > > -static inline u64 map__map_ip(const struct map *map, u64 ip)
> > > -{
> > > -       return RC_CHK_ACCESS(map)->map_ip(map, ip);
> > > -}
> > > -
> > > -static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> > > -{
> > > -       return RC_CHK_ACCESS(map)->unmap_ip(map, ip);
> > > -}
> > > -
> > > -static inline void *map__map_ip_ptr(struct map *map)
> > > -{
> > > -       return RC_CHK_ACCESS(map)->map_ip;
> > > -}
> > > -
> > > -static inline void* map__unmap_ip_ptr(struct map *map)
> > > -{
> > > -       return RC_CHK_ACCESS(map)->unmap_ip;
> > > -}
> > > -
> > >  static inline u64 map__start(const struct map *map)
> > >  {
> > >         return RC_CHK_ACCESS(map)->start;
> > > @@ -123,6 +98,34 @@ static inline size_t map__size(const struct map *=
map)
> > >         return map__end(map) - map__start(map);
> > >  }
> > >
> > > +/* ip -> dso rip */
> > > +static inline u64 map__dso_map_ip(const struct map *map, u64 ip)
> > > +{
> > > +       return ip - map__start(map) + map__pgoff(map);
> > > +}
> > > +
> > > +/* dso rip -> ip */
> > > +static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> >
> > I think it's better to use 'rip' consistently in the variable name
> > if possible.
> >
> > Thanks,
> > Namhyung
> >
> >
> > > +{
> > > +       return ip + map__start(map) - map__pgoff(map);
> > > +}
> > > +
> > > +static inline u64 map__map_ip(const struct map *map, u64 ip)
> > > +{
> > > +       if ((RC_CHK_ACCESS(map)->mapping_type) =3D=3D MAPPING_TYPE__D=
SO)
> > > +               return map__dso_map_ip(map, ip);
> > > +       else
> > > +               return ip;
> > > +}
> > > +
> > > +static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> > > +{
> > > +       if ((RC_CHK_ACCESS(map)->mapping_type) =3D=3D MAPPING_TYPE__D=
SO)
> > > +               return map__dso_unmap_ip(map, ip);
> > > +       else
> > > +               return ip;
> > > +}
> > > +
> > >  /* rip/ip <-> addr suitable for passing to `objdump --start-address=
=3D` */
> > >  u64 map__rip_2objdump(struct map *map, u64 rip);
> > >
> > > @@ -294,13 +297,13 @@ static inline void map__set_dso(struct map *map=
, struct dso *dso)
> > >         RC_CHK_ACCESS(map)->dso =3D dso;
> > >  }
> > >
> > > -static inline void map__set_map_ip(struct map *map, u64 (*map_ip)(co=
nst struct map *map, u64 ip))
> > > +static inline void map__set_mapping_type(struct map *map, enum mappi=
ng_type type)
> > >  {
> > > -       RC_CHK_ACCESS(map)->map_ip =3D map_ip;
> > > +       RC_CHK_ACCESS(map)->mapping_type =3D type;
> > >  }
> > >
> > > -static inline void map__set_unmap_ip(struct map *map, u64 (*unmap_ip=
)(const struct map *map, u64 rip))
> > > +static inline enum mapping_type map__mapping_type(struct map *map)
> > >  {
> > > -       RC_CHK_ACCESS(map)->unmap_ip =3D unmap_ip;
> > > +       return RC_CHK_ACCESS(map)->mapping_type;
> > >  }
> > >  #endif /* __PERF_MAP_H */
> > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-el=
f.c
> > > index 9e7eeaf616b8..4b934ed3bfd1 100644
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -1392,8 +1392,7 @@ static int dso__process_kernel_symbol(struct ds=
o *dso, struct map *map,
> > >                         map__set_start(map, shdr->sh_addr + ref_reloc=
(kmap));
> > >                         map__set_end(map, map__start(map) + shdr->sh_=
size);
> > >                         map__set_pgoff(map, shdr->sh_offset);
> > > -                       map__set_map_ip(map, map__dso_map_ip);
> > > -                       map__set_unmap_ip(map, map__dso_unmap_ip);
> > > +                       map__set_mapping_type(map, MAPPING_TYPE__DSO)=
;
> > >                         /* Ensure maps are correctly ordered */
> > >                         if (kmaps) {
> > >                                 int err;
> > > @@ -1455,8 +1454,7 @@ static int dso__process_kernel_symbol(struct ds=
o *dso, struct map *map,
> > >                         map__set_end(curr_map, map__start(curr_map) +=
 shdr->sh_size);
> > >                         map__set_pgoff(curr_map, shdr->sh_offset);
> > >                 } else {
> > > -                       map__set_map_ip(curr_map, identity__map_ip);
> > > -                       map__set_unmap_ip(curr_map, identity__map_ip)=
;
> > > +                       map__set_mapping_type(curr_map, MAPPING_TYPE_=
_IDENTITY);
> > >                 }
> > >                 curr_dso->symtab_type =3D dso->symtab_type;
> > >                 if (maps__insert(kmaps, curr_map))
> > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > index 82cc74b9358e..314c0263bf3c 100644
> > > --- a/tools/perf/util/symbol.c
> > > +++ b/tools/perf/util/symbol.c
> > > @@ -956,8 +956,7 @@ static int maps__split_kallsyms(struct maps *kmap=
s, struct dso *dso, u64 delta,
> > >                                 return -1;
> > >                         }
> > >
> > > -                       map__set_map_ip(curr_map, identity__map_ip);
> > > -                       map__set_unmap_ip(curr_map, identity__map_ip)=
;
> > > +                       map__set_mapping_type(curr_map, MAPPING_TYPE_=
_IDENTITY);
> > >                         if (maps__insert(kmaps, curr_map)) {
> > >                                 dso__put(ndso);
> > >                                 return -1;
> > > @@ -1475,8 +1474,7 @@ static int dso__load_kcore(struct dso *dso, str=
uct map *map,
> > >                         map__set_start(map, map__start(new_map));
> > >                         map__set_end(map, map__end(new_map));
> > >                         map__set_pgoff(map, map__pgoff(new_map));
> > > -                       map__set_map_ip(map, map__map_ip_ptr(new_map)=
);
> > > -                       map__set_unmap_ip(map, map__unmap_ip_ptr(new_=
map));
> > > +                       map__set_mapping_type(map, map__mapping_type(=
new_map));
> > >                         /* Ensure maps are correctly ordered */
> > >                         map_ref =3D map__get(map);
> > >                         maps__remove(kmaps, map_ref);
> > > --
> > > 2.43.0.rc1.413.gea7ed67945-goog
> > >
>
> --
>
> - Arnaldo

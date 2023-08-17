Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844AE78013D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355861AbjHQWoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355879AbjHQWnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:43:55 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2022835AE;
        Thu, 17 Aug 2023 15:43:52 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34ab6718a91so1159605ab.2;
        Thu, 17 Aug 2023 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312231; x=1692917031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAcfoBWgciBFJYW9bhpIF//l9LXeM9k/m9kbUBDKhL0=;
        b=pYveKdsRHY0QOWfVGfmQUvKjfZUfRYiC45sT9tNvIXQnktjHu4vikVGxAtzupSQ6b9
         Ns99abg3rXQx33/fZvaQwlA50KfGGNs5QA7y/ySMV82ExSRHhaI98H9Gdqayng1VakvI
         XSkz2VQ/UVP8ejwzGnV1M2je9kQ+vnYiCadOgTB2gCDlmfRl1h/9HLrUV+ce3zNsCbxc
         JG+bbGTf9Ikt9cJncMkyaE/dE+9pZXIxIQ4V+O81fD0bwOY2MTTpriNHELi4KmyxF2l0
         h5fKvoImFMj9JrQklUCkyKDDXgv6QOTFny2lRY3pDAsiaCo8c50WSvyB33uULbfFvAch
         Ueww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312231; x=1692917031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAcfoBWgciBFJYW9bhpIF//l9LXeM9k/m9kbUBDKhL0=;
        b=PQ+B+/xOb+w1AjUIFRxIog0rf4Yz5pJdZHg1fAOk275E+uu9WqmCD2rPDvS/ZKp/e+
         9qBCxY7NDx4eA/EAwKL+g99j96dBHHCkKTnwq2UQ3loqyTyc13Us8Xcv7T8iMoQSHJ9O
         dcywqLGqF+4ptuuioLoYrHLxDtp31SZ36Rl0KtJ9YyNn3Rpr7Nz9LzH9nzOShM+ktrpc
         NbWoVgVU0AifxNovUYweI9JKbtNmmosW4MR410FfmHDp55FE4ddfSHNzhLDOvvs6IyrL
         GjJFmR2psnW1nuDnAE8xcGasIYmPGtK7TusYraptxL4Lf+ZmOYNOGVJmSsM97Ru2Mq7H
         Uepw==
X-Gm-Message-State: AOJu0YyPsuFE84os0q48KyPHW+2PPMEokFZ4F7WPGRsFvPo2jjxebsq1
        77xW4x/4jej0mQ/xPtyu3j41eWo9wJTnKMHYWJPGoRvnUdLDHQ==
X-Google-Smtp-Source: AGHT+IH36G8vQbwPb6HpQ+iijeLPdf2SYcHZnWAycajuU5AUJMcf4+3iIHLW/EWGqCHzMP3J+Ov3ThIEd/q0/Nhhimk=
X-Received: by 2002:a05:6e02:c63:b0:348:8576:15b5 with SMTP id
 f3-20020a056e020c6300b00348857615b5mr980081ilj.3.1692312231062; Thu, 17 Aug
 2023 15:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230817164733.2475092-1-nphamcs@gmail.com> <20230817190126.3155299-1-nphamcs@gmail.com>
 <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
In-Reply-To: <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 17 Aug 2023 15:43:39 -0700
Message-ID: <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yu Zhao <yuzhao@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
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

On Thu, Aug 17, 2023 at 1:50 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Aug 17, 2023 at 12:01=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > In eviction recency check, we are currently not holding a local
> > reference to the memcg that the refaulted folio belonged to when it was
> > evicted. This could cause serious memcg lifetime issues, for e.g in the
> > memcg hierarchy traversal done in mem_cgroup_get_nr_swap_pages(). This
> > has occurred in production:
> >
> > [ 155757.793456] BUG: kernel NULL pointer dereference, address: 0000000=
0000000c0
> > [ 155757.807568] #PF: supervisor read access in kernel mode
> > [ 155757.818024] #PF: error_code(0x0000) - not-present page
> > [ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
> > [ 155757.839985] Oops: 0000 [#1] SMP
> > [ 155757.846444] CPU: 7 PID: 1380944 Comm: ThriftSrv-pri3- Kdump: loade=
d Tainted: G S                 6.4.3-0_fbk1_rc0_594_g8d0cbcaa67ba #1
> > [ 155757.870808] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive=
 MP, BIOS YMM16 05/24/2021
> > [ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > [ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 00 =
48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 74 =
42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
> > [ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
> > [ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: ffff8=
88280183000
> > [ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: ffff8=
88bbc2d1000
> > [ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: ffff8=
88ad9cedba0
> > [ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: ffff8=
88b23a7b000
> > [ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 00000=
7ffffc71354
> > [ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000) =
knlGS:0000000000000000
> > [ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 00000=
000007706e0
> > [ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > [ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > [ 155758.091376] PKRU: 55555554
> > [ 155758.096957] Call Trace:
> > [ 155758.102016]  <TASK>
> > [ 155758.106502]  ? __die+0x78/0xc0
> > [ 155758.112793]  ? page_fault_oops+0x286/0x380
> > [ 155758.121175]  ? exc_page_fault+0x5d/0x110
> > [ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
> > [ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > [ 155758.148060]  workingset_test_recent+0xda/0x1b0
> > [ 155758.157133]  workingset_refault+0xca/0x1e0
> > [ 155758.165508]  filemap_add_folio+0x4d/0x70
> > [ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
> > [ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
> > [ 155758.191738]  filemap_read+0x68d/0xdf0
> > [ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
> > [ 155758.207981]  ? __napi_schedule+0x55/0x90
> > [ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
> > [ 155758.224601]  do_syscall_64+0x3d/0x80
> > [ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > [ 155758.242473] RIP: 0033:0x7f62c29153b5
> > [ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f7 =
ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
> > [ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX: =
0000000000000011
> > [ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 00007=
f62c29153b5
> > [ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 00000=
00000000076
> > [ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 00000=
00064d5230c
> > [ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 00000=
0000003c041
> > [ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 00000=
0000027d450
> > [ 155758.376661]  </TASK>
> >
> > This patch fixes the issue by getting a local reference inside
> > unpack_shadow().
> >
> > Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs refa=
ult container")
>
> Beyond mem_cgroup_get_nr_swap_pages(), we still use the eviction_memcg
> without grabbing a ref to it first in workingset_test_recent() (and in
> workingset_refault() before that) as well as lru_gen_test_recent().
>
> Wouldn't the fix go back even further? or am I misinterpreting the proble=
m?
Hmm I don't see eviction_memcg being used outside of *_test_recent
(the rest just uses memcg =3D folio_memcg(folio), which if I'm not mistaken=
 is
the memcg that is refaulting the folio into memory).

Inside workingset_test_recent(), the only other place where eviction_memcg
is used is for mem_cgroup_lruvec. This function call won't crash whether
eviction_memcg is valid or not. The crash only happens during
mem_cgroup_get_nr_swap_pages, which has an upward traversal from
eviction_memcg to root.

Let me know if this does not make sense and/or is insufficient to ensure
safe upward traversal from eviction_memcg to root!
>
>
>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/workingset.c | 65 ++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 43 insertions(+), 22 deletions(-)
> >
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index da58a26d0d4d..03cadad4e484 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -206,10 +206,19 @@ static void *pack_shadow(int memcgid, pg_data_t *=
pgdat, unsigned long eviction,
> >         return xa_mk_value(eviction);
> >  }
> >
> > -static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgd=
at,
> > -                         unsigned long *evictionp, bool *workingsetp)
> > +/*
> > + * Unpacks the stored fields of a shadow entry into the given pointers=
.
> > + *
> > + * The memcg pointer is only populated if the memcg recorded in the sh=
adow
> > + * entry is valid. In this case, a reference to the memcg will be acqu=
ired,
> > + * and a corresponding mem_cgroup_put() will be needed when we no long=
er
> > + * need the memcg.
> > + */
> > +static void unpack_shadow(void *shadow, struct mem_cgroup **memcgp,
> > +                       pg_data_t **pgdat, unsigned long *evictionp, bo=
ol *workingsetp)
> >  {
> >         unsigned long entry =3D xa_to_value(shadow);
> > +       struct mem_cgroup *memcg;
> >         int memcgid, nid;
> >         bool workingset;
> >
> > @@ -220,7 +229,24 @@ static void unpack_shadow(void *shadow, int *memcg=
idp, pg_data_t **pgdat,
> >         memcgid =3D entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
> >         entry >>=3D MEM_CGROUP_ID_SHIFT;
> >
> > -       *memcgidp =3D memcgid;
> > +       /*
> > +        * Look up the memcg associated with the stored ID. It might
> > +        * have been deleted since the folio's eviction.
> > +        *
> > +        * Note that in rare events the ID could have been recycled
> > +        * for a new cgroup that refaults a shared folio. This is
> > +        * impossible to tell from the available data. However, this
> > +        * should be a rare and limited disturbance, and activations
> > +        * are always speculative anyway. Ultimately, it's the aging
> > +        * algorithm's job to shake out the minimum access frequency
> > +        * for the active cache.
> > +        */
> > +       memcg =3D mem_cgroup_from_id(memcgid);
> > +       if (memcg && css_tryget(&memcg->css))
> > +               *memcgp =3D memcg;
> > +       else
> > +               *memcgp =3D NULL;
> > +
> >         *pgdat =3D NODE_DATA(nid);
> >         *evictionp =3D entry;
> >         *workingsetp =3D workingset;
> > @@ -262,15 +288,16 @@ static void *lru_gen_eviction(struct folio *folio=
)
> >  static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec=
 **lruvec,
> >                                 unsigned long *token, bool *workingset)
> >  {
> > -       int memcg_id;
> >         unsigned long min_seq;
> >         struct mem_cgroup *memcg;
> >         struct pglist_data *pgdat;
> >
> > -       unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
> > +       unpack_shadow(shadow, &memcg, &pgdat, token, workingset);
> > +       if (!mem_cgroup_disabled() && !memcg)
> > +               return false;
>
> +Yu Zhao
>
> There is a change of behavior here, right?
>
> The existing code will continue if !mem_cgroup_disabled() && !memcg is
> true, and mem_cgroup_lruvec() will return the lruvec of the root
> memcg. Now we are just returning false.
>
> Is this intentional?
Oh right, there is. Should have cc-ed Yu Zhao as well, my bad.
get_maintainers.pl isn't always sufficient I guess :)

But yeah, this behavioral change is intentional.

Correct me if I'm wrong of course, but it seems like MGLRU should
follow the same pattern here. That is, once we return from unpack_shadow,
the possible scenarios are the same as prescribed in workingset_test_recent=
:

1. If mem_cgroup is disabled, we can ignore this check.
2. If mem_cgroup is enabled, then the only reason why we get NULL
memcg from unpack_shadow is if the eviction_memcg is no longer
valid.  We should not try to get its lruvec, or substitute it with the
root memcg, but return false right away (i.e not recent).
>
> >
> > -       memcg =3D mem_cgroup_from_id(memcg_id);
> >         *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> > +       mem_cgroup_put(memcg);
> >
> >         min_seq =3D READ_ONCE((*lruvec)->lrugen.min_seq[file]);
> >         return (*token >> LRU_REFS_WIDTH) =3D=3D (min_seq & (EVICTION_M=
ASK >> LRU_REFS_WIDTH));
> > @@ -421,36 +448,29 @@ bool workingset_test_recent(void *shadow, bool fi=
le, bool *workingset)
> >         unsigned long refault_distance;
> >         unsigned long workingset_size;
> >         unsigned long refault;
> > -       int memcgid;
> >         struct pglist_data *pgdat;
> >         unsigned long eviction;
> >
> >         if (lru_gen_enabled())
> >                 return lru_gen_test_recent(shadow, file, &eviction_lruv=
ec, &eviction, workingset);
> >
> > -       unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
> > -       eviction <<=3D bucket_order;
> > -
> > +       unpack_shadow(shadow, &eviction_memcg, &pgdat, &eviction, worki=
ngset);
> >         /*
> > -        * Look up the memcg associated with the stored ID. It might
> > -        * have been deleted since the folio's eviction.
> > +        * When memcg is enabled, we only get !memcg here if the
> > +        * eviction group has been deleted. In that case, ignore
> > +        * the refault.
> >          *
> > -        * Note that in rare events the ID could have been recycled
> > -        * for a new cgroup that refaults a shared folio. This is
> > -        * impossible to tell from the available data. However, this
> > -        * should be a rare and limited disturbance, and activations
> > -        * are always speculative anyway. Ultimately, it's the aging
> > -        * algorithm's job to shake out the minimum access frequency
> > -        * for the active cache.
> > +        * When memcg is disabled, we always get NULL since there
> > +        * is no root_mem_cgroup for !CONFIG_MEMCG. Continue; the
> > +        * mem_cgroup_lruvec() will get us the global lruvec.
> >          *
> > -        * XXX: On !CONFIG_MEMCG, this will always return NULL; it
> > -        * would be better if the root_mem_cgroup existed in all
> > +        * XXX: It would be better if the root_mem_cgroup existed in al=
l
> >          * configurations instead.
> >          */
> > -       eviction_memcg =3D mem_cgroup_from_id(memcgid);
> >         if (!mem_cgroup_disabled() && !eviction_memcg)
> >                 return false;
> >
> > +       eviction <<=3D bucket_order;
> >         eviction_lruvec =3D mem_cgroup_lruvec(eviction_memcg, pgdat);
> >         refault =3D atomic_long_read(&eviction_lruvec->nonresident_age)=
;
> >
> > @@ -493,6 +513,7 @@ bool workingset_test_recent(void *shadow, bool file=
, bool *workingset)
> >                 }
> >         }
> >
> > +       mem_cgroup_put(eviction_memcg);
> >         return refault_distance <=3D workingset_size;
> >  }
> >
> > --
> > 2.34.1

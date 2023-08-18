Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C625E78124A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379186AbjHRRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379201AbjHRRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:46:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F272271B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:46:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so1514060a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692380793; x=1692985593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh3Sq+IuCOWea7xoo/y+cRJ00XnZrF+21TAAKt4rG0Y=;
        b=sA5LnpTLZGFV5rdPrqDcVkFeWjCEDuOPT6KGSZayAV44DkYPE00fUgRo1hs9bd/M7F
         Rye4D9G/OR4dp7iTlLmXCZmTwqpWIi5Zrix3XLSTglOTRUruR4vXoxw7n+h5jOpP1VOt
         5RF7pqPbA2ooPega8+06hwPYZeDLJs9Akx4zYWKpCf4Lcl4mRUJpLb6ydQx4neWdShmM
         caxHKtsjm4a2iUc9ARgbag1OCmnN0fZ3ysZM6c+mZ/5g2z/DpDYZan7wJTeVlQ9cS9tr
         LQ/Fb3b/f7Tewm61FsveG7VHeOuNIPJ2z1tx/3extlrELtAUudiY5qZwRTbRkOPOipyz
         qveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380793; x=1692985593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh3Sq+IuCOWea7xoo/y+cRJ00XnZrF+21TAAKt4rG0Y=;
        b=XN6Wfl6NpQ9iK+YtiP5FEhZda8Ne7kAZ6pog4pH0p26hDMC3HjrZLX9TrzTqrMyqIz
         MQXGOGhazaFrJaosMBC6+KsnVaeRNScyHUQ+y1emlP/VNoJF3CHqkL26dIZYzuTbDH66
         SBhQbLPUTkfH47qYCgHXTI5mqt0LsYR8QYygWSzaEn9spg3Ed5U8Tuhniz32eM8Qv7rz
         BM5RsMQsxqCe1QK0c5wIh4f2vOrtDyYc6G8bOyoMzTrihcP0s3S5fMj1EBFgUNlxTErK
         +ff3loAhfl6rqJlvWybU+1IRpa0O6g4pQXxpSN/BeecnDRHZWL3CybIGiRw84xX6xBpW
         CyKA==
X-Gm-Message-State: AOJu0YzatuSdhDaEvMcTKMmO0IFVcMG9ptphZIPsVsd+HvZhSKPI9lUo
        5YOOfe/c116dQ2eyTfPHEEf7wuOs+gxK2N60JTqg2g==
X-Google-Smtp-Source: AGHT+IEGhLJ1td+XP4CIp12KYODSdrJR1mQxU6f0uZBw3thmRgYuoxY4R1rd27wSalVFr03Q1Z3pZWTyUr7OtpZ1N30=
X-Received: by 2002:a17:906:748f:b0:9a1:6aea:50d6 with SMTP id
 e15-20020a170906748f00b009a16aea50d6mr789759ejl.65.1692380793271; Fri, 18 Aug
 2023 10:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230817164733.2475092-1-nphamcs@gmail.com> <20230817190126.3155299-1-nphamcs@gmail.com>
 <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org> <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org>
In-Reply-To: <20230818173544.GA142196@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 18 Aug 2023 10:45:56 -0700
Message-ID: <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yu Zhao <yuzhao@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
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

On Fri, Aug 18, 2023 at 10:35=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > On Fri, Aug 18, 2023 at 6:49=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 05:12:17PM -0600, Yu Zhao wrote:
> > > > On Thu, Aug 17, 2023 at 4:50=E2=80=AFPM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > On Thu, Aug 17, 2023 at 3:43=E2=80=AFPM Nhat Pham <nphamcs@gmail.=
com> wrote:
> > > > > >
> > > > > > On Thu, Aug 17, 2023 at 1:50 PM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > > > > > >
> > > > > > > On Thu, Aug 17, 2023 at 12:01=E2=80=AFPM Nhat Pham <nphamcs@g=
mail.com> wrote:
> > > > > > > >
> > > > > > > > In eviction recency check, we are currently not holding a l=
ocal
> > > > > > > > reference to the memcg that the refaulted folio belonged to=
 when it was
> > > > > > > > evicted. This could cause serious memcg lifetime issues, fo=
r e.g in the
> > > > > > > > memcg hierarchy traversal done in mem_cgroup_get_nr_swap_pa=
ges(). This
> > > > > > > > has occurred in production:
> > > > > > > >
> > > > > > > > [ 155757.793456] BUG: kernel NULL pointer dereference, addr=
ess: 00000000000000c0
> > > > > > > > [ 155757.807568] #PF: supervisor read access in kernel mode
> > > > > > > > [ 155757.818024] #PF: error_code(0x0000) - not-present page
> > > > > > > > [ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 =
PMD 0
> > > > > > > > [ 155757.839985] Oops: 0000 [#1] SMP
> > > > > > > > [ 155757.846444] CPU: 7 PID: 1380944 Comm: ThriftSrv-pri3- =
Kdump: loaded Tainted: G S                 6.4.3-0_fbk1_rc0_594_g8d0cbcaa67=
ba #1
> > > > > > > > [ 155757.870808] Hardware name: Wiwynn Twin Lakes MP/Twin L=
akes Passive MP, BIOS YMM16 05/24/2021
> > > > > > > > [ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3=
d/0xb0
> > > > > > > > [ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 =
c0 00 00 00 48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 =
48 39 d1 74 42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 0=
0 00 48
> > > > > > > > [ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 0001028=
6
> > > > > > > > [ 155757.947755] RAX: 00000000003a3b1c RBX: 000007fffffffff=
f RCX: ffff888280183000
> > > > > > > > [ 155757.962202] RDX: 0000000000000000 RSI: 0007fffffffffff=
f RDI: ffff888bbc2d1000
> > > > > > > > [ 155757.976648] RBP: 0000000000000001 R08: 000000000000000=
b R09: ffff888ad9cedba0
> > > > > > > > [ 155757.991094] R10: ffffea0039c07900 R11: 000000000000001=
0 R12: ffff888b23a7b000
> > > > > > > > [ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d100=
0 R15: 000007ffffc71354
> > > > > > > > [ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9=
c0000(0000) knlGS:0000000000000000
> > > > > > > > [ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> > > > > > > > [ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb800=
4 CR4: 00000000007706e0
> > > > > > > > [ 155758.062473] DR0: 0000000000000000 DR1: 000000000000000=
0 DR2: 0000000000000000
> > > > > > > > [ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff=
0 DR7: 0000000000000400
> > > > > > > > [ 155758.091376] PKRU: 55555554
> > > > > > > > [ 155758.096957] Call Trace:
> > > > > > > > [ 155758.102016]  <TASK>
> > > > > > > > [ 155758.106502]  ? __die+0x78/0xc0
> > > > > > > > [ 155758.112793]  ? page_fault_oops+0x286/0x380
> > > > > > > > [ 155758.121175]  ? exc_page_fault+0x5d/0x110
> > > > > > > > [ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
> > > > > > > > [ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > > > > > > > [ 155758.148060]  workingset_test_recent+0xda/0x1b0
> > > > > > > > [ 155758.157133]  workingset_refault+0xca/0x1e0
> > > > > > > > [ 155758.165508]  filemap_add_folio+0x4d/0x70
> > > > > > > > [ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
> > > > > > > > [ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
> > > > > > > > [ 155758.191738]  filemap_read+0x68d/0xdf0
> > > > > > > > [ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
> > > > > > > > [ 155758.207981]  ? __napi_schedule+0x55/0x90
> > > > > > > > [ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
> > > > > > > > [ 155758.224601]  do_syscall_64+0x3d/0x80
> > > > > > > > [ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > > > > > > [ 155758.242473] RIP: 0033:0x7f62c29153b5
> > > > > > > > [ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 =
e8 b4 e6 f7 ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 =
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 f=
f 48 8b
> > > > > > > > [ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 0000029=
3 ORIG_RAX: 0000000000000011
> > > > > > > > [ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c=
0 RCX: 00007f62c29153b5
> > > > > > > > [ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d298600=
0 RDI: 0000000000000076
> > > > > > > > [ 155758.332678] RBP: 00007f6234c5fff0 R08: 000000000000000=
0 R09: 0000000064d5230c
> > > > > > > > [ 155758.347452] R10: 000000000027d450 R11: 000000000000029=
3 R12: 000000000003c041
> > > > > > > > [ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b06=
0 R15: 000000000027d450
> > > > > > > > [ 155758.376661]  </TASK>
> > > > > > > >
> > > > > > > > This patch fixes the issue by getting a local reference ins=
ide
> > > > > > > > unpack_shadow().
> > > > > > > >
> > > > > > > > Fixes: f78dfc7b77d5 ("workingset: fix confusion around evic=
tion vs refault container")
> > > > > > >
> > > > > > > Beyond mem_cgroup_get_nr_swap_pages(), we still use the evict=
ion_memcg
> > > > > > > without grabbing a ref to it first in workingset_test_recent(=
) (and in
> > > > > > > workingset_refault() before that) as well as lru_gen_test_rec=
ent().
> > > > > > >
> > > > > > > Wouldn't the fix go back even further? or am I misinterpretin=
g the problem?
> > > > > > Hmm I don't see eviction_memcg being used outside of *_test_rec=
ent
> > > > > > (the rest just uses memcg =3D folio_memcg(folio), which if I'm =
not mistaken is
> > > > > > the memcg that is refaulting the folio into memory).
> > > > > >
> > > > > > Inside workingset_test_recent(), the only other place where evi=
ction_memcg
> > > > > > is used is for mem_cgroup_lruvec. This function call won't cras=
h whether
> > > > > > eviction_memcg is valid or not.
> > > > >
> > > > > If eviction_memcg is invalid because the memory was already freed=
, we
> > > > > are basically dereferencing garbage in mem_cgroup_lruvec() aren't=
 we?
> > > > >
> > > > > > The crash only happens during
> > > > > > mem_cgroup_get_nr_swap_pages, which has an upward traversal fro=
m
> > > > > > eviction_memcg to root.
> > > > > >
> > > > > > Let me know if this does not make sense and/or is insufficient =
to ensure
> > > > > > safe upward traversal from eviction_memcg to root!
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > ---
> > > > > > > >  mm/workingset.c | 65 ++++++++++++++++++++++++++++++++-----=
------------
> > > > > > > >  1 file changed, 43 insertions(+), 22 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/mm/workingset.c b/mm/workingset.c
> > > > > > > > index da58a26d0d4d..03cadad4e484 100644
> > > > > > > > --- a/mm/workingset.c
> > > > > > > > +++ b/mm/workingset.c
> > > > > > > > @@ -206,10 +206,19 @@ static void *pack_shadow(int memcgid,=
 pg_data_t *pgdat, unsigned long eviction,
> > > > > > > >         return xa_mk_value(eviction);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static void unpack_shadow(void *shadow, int *memcgidp, pg_=
data_t **pgdat,
> > > > > > > > -                         unsigned long *evictionp, bool *w=
orkingsetp)
> > > > > > > > +/*
> > > > > > > > + * Unpacks the stored fields of a shadow entry into the gi=
ven pointers.
> > > > > > > > + *
> > > > > > > > + * The memcg pointer is only populated if the memcg record=
ed in the shadow
> > > > > > > > + * entry is valid. In this case, a reference to the memcg =
will be acquired,
> > > > > > > > + * and a corresponding mem_cgroup_put() will be needed whe=
n we no longer
> > > > > > > > + * need the memcg.
> > > > > > > > + */
> > > > > > > > +static void unpack_shadow(void *shadow, struct mem_cgroup =
**memcgp,
> > > > > > > > +                       pg_data_t **pgdat, unsigned long *e=
victionp, bool *workingsetp)
> > > > > > > >  {
> > > > > > > >         unsigned long entry =3D xa_to_value(shadow);
> > > > > > > > +       struct mem_cgroup *memcg;
> > > > > > > >         int memcgid, nid;
> > > > > > > >         bool workingset;
> > > > > > > >
> > > > > > > > @@ -220,7 +229,24 @@ static void unpack_shadow(void *shadow=
, int *memcgidp, pg_data_t **pgdat,
> > > > > > > >         memcgid =3D entry & ((1UL << MEM_CGROUP_ID_SHIFT) -=
 1);
> > > > > > > >         entry >>=3D MEM_CGROUP_ID_SHIFT;
> > > > > > > >
> > > > > > > > -       *memcgidp =3D memcgid;
> > > > > > > > +       /*
> > > > > > > > +        * Look up the memcg associated with the stored ID.=
 It might
> > > > > > > > +        * have been deleted since the folio's eviction.
> > > > > > > > +        *
> > > > > > > > +        * Note that in rare events the ID could have been =
recycled
> > > > > > > > +        * for a new cgroup that refaults a shared folio. T=
his is
> > > > > > > > +        * impossible to tell from the available data. Howe=
ver, this
> > > > > > > > +        * should be a rare and limited disturbance, and ac=
tivations
> > > > > > > > +        * are always speculative anyway. Ultimately, it's =
the aging
> > > > > > > > +        * algorithm's job to shake out the minimum access =
frequency
> > > > > > > > +        * for the active cache.
> > > > > > > > +        */
> > > > > > > > +       memcg =3D mem_cgroup_from_id(memcgid);
> > > > > > > > +       if (memcg && css_tryget(&memcg->css))
> > > > > > > > +               *memcgp =3D memcg;
> > > > > > > > +       else
> > > > > > > > +               *memcgp =3D NULL;
> > > > > > > > +
> > > > > > > >         *pgdat =3D NODE_DATA(nid);
> > > > > > > >         *evictionp =3D entry;
> > > > > > > >         *workingsetp =3D workingset;
> > > > > > > > @@ -262,15 +288,16 @@ static void *lru_gen_eviction(struct =
folio *folio)
> > > > > > > >  static bool lru_gen_test_recent(void *shadow, bool file, s=
truct lruvec **lruvec,
> > > > > > > >                                 unsigned long *token, bool =
*workingset)
> > > > > > > >  {
> > > > > > > > -       int memcg_id;
> > > > > > > >         unsigned long min_seq;
> > > > > > > >         struct mem_cgroup *memcg;
> > > > > > > >         struct pglist_data *pgdat;
> > > > > > > >
> > > > > > > > -       unpack_shadow(shadow, &memcg_id, &pgdat, token, wor=
kingset);
> > > > > > > > +       unpack_shadow(shadow, &memcg, &pgdat, token, workin=
gset);
> > > > > > > > +       if (!mem_cgroup_disabled() && !memcg)
> > > > > > > > +               return false;
> > > > > > >
> > > > > > > +Yu Zhao
> > > > > > >
> > > > > > > There is a change of behavior here, right?
> > > > > > >
> > > > > > > The existing code will continue if !mem_cgroup_disabled() && =
!memcg is
> > > > > > > true, and mem_cgroup_lruvec() will return the lruvec of the r=
oot
> > > > > > > memcg. Now we are just returning false.
> > > > > > >
> > > > > > > Is this intentional?
> > > > > > Oh right, there is. Should have cc-ed Yu Zhao as well, my bad.
> > > > > > get_maintainers.pl isn't always sufficient I guess :)
> > > > > >
> > > > > > But yeah, this behavioral change is intentional.
> > > > > >
> > > > > > Correct me if I'm wrong of course, but it seems like MGLRU shou=
ld
> > > > > > follow the same pattern here. That is, once we return from unpa=
ck_shadow,
> > > > > > the possible scenarios are the same as prescribed in workingset=
_test_recent:
> > > > > >
> > > > > > 1. If mem_cgroup is disabled, we can ignore this check.
> > > > > > 2. If mem_cgroup is enabled, then the only reason why we get NU=
LL
> > > > > > memcg from unpack_shadow is if the eviction_memcg is no longer
> > > > > > valid.  We should not try to get its lruvec, or substitute it w=
ith the
> > > > > > root memcg, but return false right away (i.e not recent).
> > > > > > >
> > > > >
> > > > > I will leave this for Yu :)
> > > >
> > > > Thanks, Yosry.
> > > >
> > > > Hi Nhat, it seems unnecessary to me to introduce a get/put into
> > > > lru_gen_test_recent() because it doesn't suffer from the bug this
> > > > patch tries to fix. In theory, the extra get/put can impact
> > > > performance, though admittedly the impact is unlikely to be
> > > > measurable. Regardless, the general practice is to fix the bug
> > > > locally, i.e., when the mem_cgroup_get_nr_swap_pages() path is take=
n,
> > > > rather than change the unrelated path. Thank you.
> > >
> > > Hey guys,
> > >
> > > I had suggested to have it in unpack_shadow() to keep things simple,
> > > and not further complicate the lifetime rules in this code. The
> > > tryget() is against a per-cpu counter, so it's not expensive.
> > >
> > > The NULL deref is evidence that while *some* cgroup members are still
> > > accessible once it's dead, not all of it is. There is no explicit
> > > guarantee from the cgroup code that anything BUT the tryget() is stil=
l
> > > valid against group that is under rcu freeing.
> > >
> > > Since it isn't expensive, let's keep it simple and robust, and preven=
t
> > > future bugs of the same class, by always ensuring the cgroup is alive
> > > before accessing random members. Especially in non-cgroup code.
> >
> > I looked at this again today with fresh eyes, and I want to go back to
> > what I initially said. Isn't RCU protection in this case enough to
> > keep the memcg "valid" (i.e accessible, not garbage)? The tryget is
> > not a lot of complexity or performance tax, but I want to really
> > understand what's happening here.
>
> Hm. I think you're right that something is still missing from the
> analysis.
>
> > Looking at the code again, this seems to be the sequence of events on
> > the cgroup side:
> > - css_put() puts the last reference invoking a call to css_release()
> > - css_release() queues css_release_work_fn()
> > - css_release() does some bookkeeping, makes some callbacks, and
> > queues css_free_rwork_fn() to run *after* an RCU grace period.
> > - css_free_rwork_fn() makes callbacks to free the memory, ultimately
> > freeing the memcg.
> >
> > On the memcg idr side, the removal sequence of events seem to be:
> > - mem_cgroup_id_put() will decrement the id ref and check if falls to 0
> > - If the id ref falls to 0, we call mem_cgroup_id_remove() *then* css_p=
ut()
> >
> > On the workingset_refault() side, the sequence of events seems to be:
> > - rcu_read_lock()
> > - memcg =3D mem_cgroup_from_id()
> > - ... // use memcg
> > - rcu_read_unlock()
> >
> > So technically, after holding the rcu read lock, if we find the memcg
> > in the idr, it must be valid, and it must not be freed until after the
> > rcu read section is completed. It's not just the cgroup internal
> > implementation, it's the contract between cgroup core and controllers
> > such as memcg.
> >
> > The memory controller expects a sequence of callbacks during freeing:
> > css_offline() -> css_released() -> css_free(). So memcg code is within
> > its right to access any fields of struct mem_cgroup that are not freed
> > by the css_offline() or css_released() until css_free() is called,
> > right?
> >
> > Here is a guess / question, because I am not really familiar with
> > memory barriers and such, but is it at all possible that the actual
> > problem is reordering of instructions in mem_cgroup_id_put_many(),
> > such that we actually execute css_put() *before*
> > mem_cgroup_id_remove()?
> >
> > If this happens it seems possible for this to happen:
> >
> > cpu #1                                  cpu#2
> >                                              css_put()
> >                                              /* css_free_rwork_fn is qu=
eued */
> > rcu_read_lock()
> > mem_cgroup_from_id()
> >                                              mem_cgroup_id_remove()
> > /* access memcg */
>
> I don't quite see how that'd possible. IDR uses rcu_assign_pointer()
> during deletion, which inserts the necessary barriering. My
> understanding is that this should always be safe:
>
>   rcu_read_lock()                 (writer serialization, in this case ref=
 count =3D=3D 0)
>   foo =3D idr_find(x)               idr_remove(x)
>   if (foo)                        kfree_rcu(foo)
>     LOAD(foo->bar)
>   rcu_read_unlock()

How does a barrier inside IDR removal protect against the memcg being
freed here though?

If css_put() is executed out-of-order before mem_cgroup_id_remove(),
the memcg can be freed even before mem_cgroup_id_remove() is called,
right?

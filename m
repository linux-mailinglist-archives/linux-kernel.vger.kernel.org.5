Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F177FDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354394AbjHQS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354504AbjHQS0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:26:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4A3C16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:26:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso1292831fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296699; x=1692901499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTCzY45neRf9bLG0/HZXpMx1Auiac0ZDw5Pu30+Zc5Y=;
        b=JgtobsF5w8cLXojXpzy5vFUVkWdUsq0DRhT8ba5XIg2hgKolBhgh2VbC26FfnwJWC9
         Q3aJzC6xBnZpxfg4mJtdy4uPpsDRT32X5cjLUj2+gmkGgqil9X8mEh1DJ3ueSkRI7VJT
         m1f4CYqiRC8KSIYM1jFK2rCs8vv1MChQzD5O1ZzGAzLx5ORa521U0fD2seWL+K1DgBPw
         ij1qXmXOB+xGTcYtdrnkw7TSbCYHKfmy6f2lHZ8lDdnVWJg4SWwsSXWVjt4oTwTF4UDz
         ywjOdcZ6Sx7JU3NAaGny0od3l8zI2S3zvjcq7mU+ONR3SheaY1Wg2RK63pzT/V5esH64
         xf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296699; x=1692901499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTCzY45neRf9bLG0/HZXpMx1Auiac0ZDw5Pu30+Zc5Y=;
        b=JzvtDI9rckFr7xGyCHlhlT/sctXtoEqkb/JU6XedVTl1PL+cn6MhX1J5k/oERshs8P
         ukoMh68gdzdikUfE2qLAwz2m+x1OPnaOTUT3/J/r28DqICGdvzoNFLl5JF00RjdLfTGB
         FsAvV4FbQr1STajfqEJi5v4lZgV7RcKqblw7sy4Dz7tZGfIcjGzQLuqIdLlkMzZ8Eyf6
         +Jo9MTEDL5toMdpvc38q9BFRMKl4waTR7tVpQGKQo8pxaAFezD+x1aaVvNHIyFi8kmCC
         uMcLfVUxuMIRYl6e3XehBv2aIeyjOY+aqLEHEGC7d/Ia1XFwK3neRsbh+RkA+2PzsSVx
         vZ/g==
X-Gm-Message-State: AOJu0YwmqHfvppdpZ24wn74EmCNUg3TQonjPSyYQ7LmGZ5QxUj8dEeBQ
        liNs7wrUsFdn56m/fOTwEzP+RDcfujxYbD1HMEvuDw==
X-Google-Smtp-Source: AGHT+IE50cnqvaE0+vUzqUjw3t9ZgyGRNYS1PoufZg3xW9PDTtIyg250o9j5dwUqW3d4wVEGjwL5lqXKmWHmq9w13VY=
X-Received: by 2002:a2e:6806:0:b0:2ba:18e5:1064 with SMTP id
 c6-20020a2e6806000000b002ba18e51064mr129890lja.14.1692296698761; Thu, 17 Aug
 2023 11:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230817164733.2475092-1-nphamcs@gmail.com> <CAJD7tkYnhTOTR8OOzvmC4dbctEE951dfbAm=wZN7gEXvLNLRng@mail.gmail.com>
 <CAKEwX=PFMV0PE5WRw2C==pNCqTg7SaY+NFF59b=kZF0xbe8=9g@mail.gmail.com>
In-Reply-To: <CAKEwX=PFMV0PE5WRw2C==pNCqTg7SaY+NFF59b=kZF0xbe8=9g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 17 Aug 2023 11:24:22 -0700
Message-ID: <CAJD7tkYU0Mhprw4yP08rOyEMibZ-nh=hTvW-gvveaJQ5QVJCPA@mail.gmail.com>
Subject: Re: [PATCH] workingset: ensure memcg is valid for recency check
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        kernel-team@meta.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Thu, Aug 17, 2023 at 11:13=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> Thanks for the review, Yosry!
> On Thu, Aug 17, 2023 at 10:40=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Thu, Aug 17, 2023 at 9:47=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > In eviction recency check, we are currently not holding a local
> > > reference to the memcg that the refaulted folio belonged to when it w=
as
> > > evicted. This could cause serious memcg lifetime issues, for e.g in t=
he
> > > memcg hierarchy traversal done in mem_cgroup_get_nr_swap_pages(). Thi=
s
> > > has occurred in production:
> >
> > Doesn't workingset_refault() call workingset_test_recent() under RCU?
> Yep we're under RCU protection. But the eviction_memcg is grabbed
> from a memcg id packed in the shadow - its reference count might
> go down to 0 in the meantime and get killed.

I see, is this basically protecting against a race with
mem_cgroup_id_put_many()? My thought was that given that we have an
id, then we should have a ref to the memcg, but if we race with
mem_cgroup_id_put_many() we might get the id just before it is removed
and the ref is put, and then use the memcg after it's freed.

Is this what's happening here? If yes, I think this makes sense.

>
> This pattern (tryget memcg inside RCU) is done in a couple
> other places too.
> > Shouldn't this guarantee the validity of the memcg?
> >
> > >
> > > [ 155757.793456] BUG: kernel NULL pointer dereference, address: 00000=
000000000c0
> > > [ 155757.807568] #PF: supervisor read access in kernel mode
> > > [ 155757.818024] #PF: error_code(0x0000) - not-present page
> > > [ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
> > > [ 155757.839985] Oops: 0000 [#1] SMP
> > > [ 155757.846444] CPU: 7 PID: 1380944 Comm: ThriftSrv-pri3- Kdump: loa=
ded Tainted: G S                 6.4.3-0_fbk1_rc0_594_g8d0cbcaa67ba #1
> > > [ 155757.870808] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passi=
ve MP, BIOS YMM16 05/24/2021
> > > [ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > > [ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 0=
0 48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 7=
4 42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
> > > [ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
> > > [ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: fff=
f888280183000
> > > [ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: fff=
f888bbc2d1000
> > > [ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: fff=
f888ad9cedba0
> > > [ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: fff=
f888b23a7b000
> > > [ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 000=
007ffffc71354
> > > [ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000=
) knlGS:0000000000000000
> > > [ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 000=
00000007706e0
> > > [ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > [ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
> > > [ 155758.091376] PKRU: 55555554
> > > [ 155758.096957] Call Trace:
> > > [ 155758.102016]  <TASK>
> > > [ 155758.106502]  ? __die+0x78/0xc0
> > > [ 155758.112793]  ? page_fault_oops+0x286/0x380
> > > [ 155758.121175]  ? exc_page_fault+0x5d/0x110
> > > [ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
> > > [ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > > [ 155758.148060]  workingset_test_recent+0xda/0x1b0
> > > [ 155758.157133]  workingset_refault+0xca/0x1e0
> > > [ 155758.165508]  filemap_add_folio+0x4d/0x70
> > > [ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
> > > [ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
> > > [ 155758.191738]  filemap_read+0x68d/0xdf0
> > > [ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
> > > [ 155758.207981]  ? __napi_schedule+0x55/0x90
> > > [ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
> > > [ 155758.224601]  do_syscall_64+0x3d/0x80
> > > [ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > [ 155758.242473] RIP: 0033:0x7f62c29153b5
> > > [ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f=
7 ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
> > > [ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX=
: 0000000000000011
> > > [ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 000=
07f62c29153b5
> > > [ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 000=
0000000000076
> > > [ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 000=
0000064d5230c
> > > [ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 000=
000000003c041
> > > [ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 000=
000000027d450
> > > [ 155758.376661]  </TASK>
> > >
> > > This patch fixes the issue by getting a local reference inside
> > > unpack_shadow().
> > >
> > > Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs re=
fault container")
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  mm/workingset.c | 57 ++++++++++++++++++++++++++++++-----------------=
--
> > >  1 file changed, 35 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/mm/workingset.c b/mm/workingset.c
> > > index da58a26d0d4d..c20b26bb6cb1 100644
> > > --- a/mm/workingset.c
> > > +++ b/mm/workingset.c
> > > @@ -206,10 +206,11 @@ static void *pack_shadow(int memcgid, pg_data_t=
 *pgdat, unsigned long eviction,
> > >         return xa_mk_value(eviction);
> > >  }
> > >
> >
> > > -static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **p=
gdat,
> > > -                         unsigned long *evictionp, bool *workingsetp=
)
> > > +static void unpack_shadow(void *shadow, struct mem_cgroup **memcgp,
> > > +                       pg_data_t **pgdat, unsigned long *evictionp, =
bool *workingsetp)
> >
> > We should probably document that we are returning a memcg with a ref
> > on it, or change the name to put "get" and "memcg" in there somewhere.
> > Alternatively we could separate the function that gets the memcg from
> > the shadow (e.g. get_memcg_from_shadow or so).
> Hmm I feel like unpack as a verb is good here. But I can add a small
> comment/documentation above the function to signify that this
> function holds a reference to the memcg, and a corresponding
> put call will be needed, if that helps.

I don't want to be nitpicking, so no strong opinions here :)

> >
> > I would also hold an RCU read lock here so that the call to
> > mem_cgroup_from_id() is valid. I know all callers currently do, but it
> > may change later. Alternatively we can add an assertion or a warning.
> I prefer the assertion idea. But FWIW, mem_cgroup_from_id()
> already has a warning for this
> (WARN_ON_ONCE(!rcu_read_lock_held()))
>
> Seems redundant to me, especially if the reason why we care
> about unpack_shadow() being under RCU is for
> mem_cgroup_from_id() to be valid.
> >

Fair enough, I guess basic testing with debugging enabled should spot
any misuse quickly enough.

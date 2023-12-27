Return-Path: <linux-kernel+bounces-11956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9B81EE25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA2BB222A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDE2CCDF;
	Wed, 27 Dec 2023 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1B0gjg2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C82C866
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ccbd9000f3so22799721fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703672585; x=1704277385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWEBKp33uVGlNchuGTUp5xMHWUT1mc4rjOp6MiUpCLw=;
        b=S1B0gjg2pasYb4Phqod4pDfid+w72cbRGNvQFEeX4n/Knh5K5v/zhZBTbgoXNrkhR5
         GbabxbN2DLijueJ/PtbQ4Ri4hbz3gxsgkmpkB6eV2MftlvjPgaX+VTZ4bLhhFznUnvbO
         EnJMfErgSJi9+nTDc3n9i37f1fzzww89KLaJzA18pzcy28DBwQLkxer7lqnk/xAZ5eQm
         3EH1N3MNd6Ez9qbq2Sh7tBITbv8SUs6/+BBmkm911Xj40GOHy2Ljl5/o56z6NWDe/F5n
         tlGCQG9ycu8dvkmOB9JjdmRM4qk5jBCFN24eT6z9d8Os1d9LlzF1L/2QhdixdacztMJB
         EKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672585; x=1704277385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWEBKp33uVGlNchuGTUp5xMHWUT1mc4rjOp6MiUpCLw=;
        b=qZc3UH6/tqcUsY9155Xj6+z1e73L3vUIKlXCU8CumNrb/CBy/7mc60kl5tW3wlFnHA
         YGVakCeRhKtWyeD56q0sboYtZ0TBLi+uz6f2jOYVIDOsb1I0ydBzqHt7sOQFgQIig9Wr
         IelbxdHq9AbJpmy9D9VPgdVLqCgjixdGIkZDbDQTUVkWKzPrcBdSQh39WqRfeACZQjB0
         BLAzRHeGqWuw9JdO+8MFI9p/Bhp7vHKnu2xF11gpWs7eMKNlP/I/9iZOIn/c7Zc+bWu7
         5HVnsyJumsk9EMigqmz4H2sj3Hxu1XOhF5KIvGXqm0vA6cY6d4tpwLjcSCNbQXlGOSxX
         2kwA==
X-Gm-Message-State: AOJu0Yw1Q6HZQQjs4TXr0kfxypCh79K0qUC+1c++VdoPJbBBElxP3Uqm
	VSaLbOZKEW65mYCFMiII81kDNBVQV0ipejOT6e0EA87Sul8tug==
X-Google-Smtp-Source: AGHT+IEfiuI8ruMSqrE9pC62hOSMKH4DHm+C5Yw54mqvJLfYaUGnfIa3LqKRr1xYgFjim+gB27B6l+sihzt0z3W64YA=
X-Received: by 2002:a2e:b1c2:0:b0:2cc:695a:ab4f with SMTP id
 e2-20020a2eb1c2000000b002cc695aab4fmr2964406lja.104.1703672584484; Wed, 27
 Dec 2023 02:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-2-ryncsn@gmail.com>
 <CAF8kJuNPCvNyjy71Q9Kncq26ndAwSWhVH1cJ8s=1Exr=AmLgSA@mail.gmail.com>
In-Reply-To: <CAF8kJuNPCvNyjy71Q9Kncq26ndAwSWhVH1cJ8s=1Exr=AmLgSA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Dec 2023 18:22:46 +0800
Message-ID: <CAMgjq7Dzf48pu5mJQFdqLxW9c=1N0jC4u53xY3fALBvv9Yrq1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, lru_gen: batch update counters on againg
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=89 07:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kairui,
>
> Some early feedback on your patch. I am still working  my way through
> your patches.
> Might have more questions.

Hi Chris,

Thanks for the review.

> On Fri, Dec 22, 2023 at 2:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > When lru_gen is aging, it will update mm counters page by page,
> > which causes a higher overhead if age happens frequently or there
> > are a lot of pages in one generation getting moved.
> > Optimize this by doing the counter update in batch.
> >
> > Although most __mod_*_state has its own caches the overhead
> > is still observable.
> >
> > Tested in a 4G memcg on a EPYC 7K62 with:
> >
> >   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
> >     -a 0766 -t 16 -B binary &
> >
> >   memtier_benchmark -S /tmp/memcached.socket \
> >     -P memcache_binary -n allkeys \
> >     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
> >     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
> >
> > Average result of 18 test runs:
> >
> > Before: 44017.78 Ops/sec
> > After:  44687.08 Ops/sec (+1.5%)
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 55 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b4ca3563bcf4..e3b4797b9729 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3095,9 +3095,47 @@ static int folio_update_gen(struct folio *folio,=
 int gen)
> >         return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> >  }
> >
> > +/*
> > + * Update LRU gen in batch for each lru_gen LRU list. The batch is lim=
ited to
> > + * each gen / type / zone level LRU. Batch is applied after finished o=
r aborted
> > + * scanning one LRU list.
> > + */
> > +struct gen_update_batch {
> > +       int delta[MAX_NR_GENS];
> > +};
> > +
> > +static void lru_gen_update_batch(struct lruvec *lruvec, bool type, int=
 zone,
> "type" need to be int, it is either  LRU_GEN_FILE or LRU_GEN_ANON.

Yes, I'll update it with some more test results later.


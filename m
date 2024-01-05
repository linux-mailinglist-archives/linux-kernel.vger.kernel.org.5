Return-Path: <linux-kernel+bounces-17473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C2824DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CE9284743
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A7569F;
	Fri,  5 Jan 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgtVEfVo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB1566E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204e1203a22so522364fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 20:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704430007; x=1705034807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUfBlkaw9RVz2P7LcdBmGlWAkW41RXh8NLtRAVaPRl0=;
        b=LgtVEfVoqY6WHPpi1sTHrzIwZiErs2Bwzwth6FWoeNs0md6D4GxSazgXGQ1DKVDE0i
         cepsrw6cSt/VN3EERxMEmHowkCJiFn6CQXrL0XV1sAs1rcjDDZZD4/BPT2NpjWKicDtN
         gT2C6/I5CBUEyTUpbPH7viFDHKb/WgYSTHr+oZcdajHYVxDKHBiGi4p0xVSN2U1yHRmq
         UA3By+viHU6W6TQS8BWgliOkSkrkizh+Yz7QmNPH/ilL+InEBd+IGYUzZcprKEgQo5Rx
         g285AUSRW0Wx6OD30PczrFl58KyrW4KeyzD4IxViL3pFiqE9S8zrNGOTlGvNXygXMOyU
         DfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704430007; x=1705034807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUfBlkaw9RVz2P7LcdBmGlWAkW41RXh8NLtRAVaPRl0=;
        b=eY7TarZry12ibGF5S/GOlJS2epEMFUbkCB64kVA/tezcMHt+amYLq98LJ58eWVY7PZ
         nm07beNSXrv7tD1VLgAujf5r7R/sIO3bxEMvNi3oJUpamoZIHJj0poTXn+2uGTkuMfSE
         Nqs3zYCXdR+4NoVoHXmvxFdhVpQEEBZmHwRJK0Ey57S69iivaORlOJEzSxuE3zLOdM6K
         E3MFvAzLfKpQxshVpbbbM9BtRd3PsjVesha6OBXnZ5HefcYNxu+ChaT03NMbonJdx9zI
         dTx4CXWB0CD9P85eqNSszHv+rgDABHebWaLIP8ZezPMlmyppSuszFs3tBoRTDhpa/jP9
         aCGA==
X-Gm-Message-State: AOJu0YxQJdDQEUxAJo9DFe5tGUnW+jx5V4Yx/HafhnLgML80iQHqRwqB
	bvHkCADP2wL9PGDJvI1EM34efLXyHUsLzPtfPfY=
X-Google-Smtp-Source: AGHT+IGFz31oQMEO6zstk6s3c1R2dUfriG3xgKlo5vi3XvjPA9H5/erkA9gCmdFcdH1Yq7BhPAY68MLICW80JxhCy2U=
X-Received: by 2002:a05:6870:4191:b0:205:c9fa:8b0d with SMTP id
 y17-20020a056870419100b00205c9fa8b0dmr1465559oac.73.1704430007497; Thu, 04
 Jan 2024 20:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104054030.14733-1-xuewen.yan@unisoc.com> <ZZcJ-3MXF4BPqPtL@boqun-archlinux>
In-Reply-To: <ZZcJ-3MXF4BPqPtL@boqun-archlinux>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 5 Jan 2024 12:46:36 +0800
Message-ID: <CAB8ipk9+BAFOa_4Dm2hs-bpfmMC_LHkaAb=JUVBq1CChX11wzA@mail.gmail.com>
Subject: Re: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, ke.wang@unisoc.com, 
	zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jan 5, 2024 at 3:44=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> Hi,
>
> On Thu, Jan 04, 2024 at 01:40:30PM +0800, Xuewen Yan wrote:
> > The lookup_chain_cache_add will get graph_lock, but the
> > validate_chain do not unlock before return 0.
> >
>
> Thanks for looking into this, a few comment below:
>
> > So add graph_unlock before return 0.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >  kernel/locking/lockdep.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 151bd3de5936..24995e1ebc62 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3855,8 +3855,11 @@ static int validate_chain(struct task_struct *cu=
rr,
> >                */
> >               int ret =3D check_deadlock(curr, hlock);
> >
> > -             if (!ret)
> > +             if (!ret) {
> > +                     graph_unlock();
>
> Note that when check_deadlock() return 0, there is a
> print_deadlock_bug() before the return, so I think it covers the
> graph_unlock() (see debug_locks_off_graph_unlock()).

Yes, I did not see the check_deadlock's details carefully.

>
> >                       return 0;
> > +             }
> > +
> >               /*
> >                * Add dependency only if this lock is not the head
> >                * of the chain, and if the new lock introduces no more
> > @@ -3865,9 +3868,9 @@ static int validate_chain(struct task_struct *cur=
r,
> >                * serializes nesting locks), see the comments for
> >                * check_deadlock().
> >                */
> > -             if (!chain_head && ret !=3D 2) {
> > -                     if (!check_prevs_add(curr, hlock))
> > -                             return 0;
> > +             if (!chain_head && ret !=3D 2 && !check_prevs_add(curr, h=
lock)) {
> > +                     graph_unlock();
>
> This part is interesting, usually when an internal function in lockdep
> returns 0, it means there is an error (either a deadlock or internal
> error), and that means a print_*() would be called, and the graph lock
> will be unlocked in that print_*(). However, in check_prevs_add() there
> is one condition where it will return 0 without any print_*(), that is:
>
>
> in check_prev_add():
>
>                         /* <prev> is not found in <next>::locks_before */
>                         return 0;
>
> it's an internal error where <next> is in the <prev>::locks_after list
> but <prev> is not in the <next>::locks_before list, which should seldom
> happen: it's dead code. If you put a graph_unlock() before that return,
> I think it covers all the cases, unless I'm missing something subtle.

If only this condition does not unlock, It is indeed better to put
graph_unlock here.
I would change the patch in the V2.

>
> Are you hitting a real issue or this is found by code reading?

Indeed, we hit a real issue:
One cpu did not call graph_unlock, as a result, caused a deadlock with
other cpus,
because any cpu calling raw_spin_lock would get the graph_lock first.

Thanks!

--
BR
xuewen

>
> Regards,
> Boqun
>
> > +                     return 0;
> >               }
> >
> >               graph_unlock();
> > --
> > 2.25.1
> >
>


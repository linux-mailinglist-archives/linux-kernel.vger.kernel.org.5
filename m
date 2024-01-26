Return-Path: <linux-kernel+bounces-40497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B983E1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936EBB24A14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAAC210F3;
	Fri, 26 Jan 2024 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0nHJgqg"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA01EF1E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294219; cv=none; b=uCqeDpM8ZMNhszLmzX8j+x7PRZC6MJA7CLZu49GtEWGt50BPtbFAB4REhn6pLfBqS9dEXoiwQyGZtYln+5gl1cOpQijFiE2/NmcnXgcVGiTtEMTvOFlyM+drdmeGVc0YLYC2N3dJyDKVIR8v1zUcnTpYlay2hooQXaG36gro6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294219; c=relaxed/simple;
	bh=XbBNz5Xjkbj/AigQvzkQA0KxKZPt6W9V1ChoC5N95fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s165kd/iwAC6Pw03ou05LqcVcmN1WahEaiGT/8zDbMam+Z7veURyof1QPkdO7/N+tLxyAgyFp3olsoUTdrNj6NH+eF0h9Lysi4HqcMGX9JRPVBdEFoWiOnBDi/+6Se8u8x8HjP2wswkPYHeZMPAi/6ySAEdTc51+Rv37bTsc1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0nHJgqg; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2dfbe5363so300970241.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706294217; x=1706899017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqXd2LbuyI9Qqh/FQNpz2+SVm8Ny+cq215471CRHkUI=;
        b=R0nHJgqgxv0qdog4A8pOsl2Cz+7jt7hTWx4EYYF9Ho05YjzWZd8+ub9OVZi0WNAn5T
         iwQ+PsVYM0Fh1bzxLxdB0d/L/0iF85zKGGGOLSSr+zpt5u3qkUGhWNpm6Yxyb6rYtaTG
         ic901xgFsGnjmvR7/BQ3ZyhmhobSUC/HwTo8X0G+hRhHmOHWy75GvneckJj1GUN12ArJ
         6rjjUjr1rhoZTcCCsxVy26yO9msup4O368mGm/lzzSIctKxr8E83JpvQ3Xk8iiRNCurk
         EkeCMOKtqFrCBbjyDTTE2I1UJtl/xh5qVxrUd0qINQsN+0ezKGkCpPwuhfPd/yQEGU8C
         edMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294217; x=1706899017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqXd2LbuyI9Qqh/FQNpz2+SVm8Ny+cq215471CRHkUI=;
        b=X+Xwq2k7BImYnHUzt4fUH813W4YV8GO3z6MuPe8XOFjCy2USw9zOXfcp11cBYILaNL
         GReINqX60TWPyO/B2V9fVPz+jUT4Y88EKZIr7Ce5VoOAZJyrDd54ys/yl+1MrUg1kAzQ
         naBLduH0sqj3oY0Mj6677GrU6NJu+I35AeFR7CYqROBpZGHuhh2SUYcSwTbo27qHAEY8
         jsJ73rUzns7gsppNrGaMemFIGBp1ZCMNVhMY2bUVc8w3//725WTLdKYHVH0rNDcMs8DW
         Cp7RCyys0bM6yAJ6S0yY91KJ3gREqQWJcJzwbvYqe0qDE3gjph7Zfz47k3gQsKGmGaS0
         00fg==
X-Gm-Message-State: AOJu0Yw7EiUdOXW0DEh6fuMfZ7dQBTxEeyA9A/J036RDMdT0Q9LYrcNa
	tQZ70bejDG72zoKmpxtaNNQyOHBE1NXC4GbBp2ME7pK0Tb1knT6gisyfbaIDsFusfqFLf8BAiHp
	m/IF3bF7th7XtnPYCfYQcRHIdZ1E=
X-Google-Smtp-Source: AGHT+IE1MLjGKr2ux1azYw+58wmOiUvg8E5WXoQmTYbkOgivsJfz1JIsqBfE4B/XNtYEHyZgtl89a1r7kKpPcLkAmz0=
X-Received: by 2002:a05:6122:4c0f:b0:4b6:e383:5f with SMTP id
 ff15-20020a0561224c0f00b004b6e383005fmr235259vkb.25.1706294216914; Fri, 26
 Jan 2024 10:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com> <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
In-Reply-To: <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 26 Jan 2024 10:36:45 -0800
Message-ID: <CAOMdWSKu9PhyjfWga-eMcAUiBF4Fg9dnt+husNRZgkL1rp_HFQ@mail.gmail.com>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing tasklet_struct
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	Mike Snitzer <msnitzer@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Damien Le Moal <damien.lemoal@wdc.com>, Bob Liu <bob.liu@oracle.com>, Hou Tao <houtao1@huawei.com>, 
	Nathan Huckleberry <nhuck@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset="UTF-8"

> > There's a problem with the tasklet API - there is no reliable way how to
> > free a structure that contains tasklet_struct. The problem is that the
> > function tasklet_action_common calls task_unlock(t) after it called the
> > callback. If the callback does something that frees tasklet_struct,
> > task_unlock(t) would write into free memory.
>
> Ugh.
>
> I see what you're doing, but I have to say, I dislike this patch
> immensely. It feels like a serious misdesign that is then papered over
> with a hack.
>
> I'd much rather see us trying to move away from tasklets entirely in
> cases like this. Just say "you cannot do that".
>
 The idea of moving away from using tasklets has been discussed several times.
I am working on entirely moving away from using tasklets. Ofcourse, we have
some subsystems(like DMA), where we need to do a little more.

> In fact, of the two cases that want this new functionality, at least
> dm-verity already makes tasklets a conditional feature that isn't even
> enabled by default, and that was only introduced in the last couple of
> years.
>
> So I think dm-verity would be better off just removing tasklet use,
> and we should check whether there are better models for handling the
> latency issue.
>
> The dm-crypt.c case looks different, but similar. I'm not sure why it
> doesn't just use the workqueue for the "in interrupt" case. Like
> dm-verity, it already does have a workqueue option, and it's a
> setup-time option to say "don't use the workqueue for reads / writes".
> But it feels like the code should just say "tough luck, in interrupt
> context we *will* use workqueues".
>
> So honestly, both of the cases you bring up seem to be just BUGGY. The
> fix is not to extend tasklets to a new thing, the fix is to say "those
> two uses of tasklets were broken, and should go away".
>
> End result: I would suggest:
>
>  - just get rid of the actively buggy use of tasklets. It's not
> necessary in either case.
>
>  - look at introducing a "low-latency atomic workqueue" that looks
> *exactly* like a regular workqueue, but has the rule that it's per-cpu
> and functions on it cannot sleep
>
> because I think one common issue with workqueues - which are better
> designed than tasklets - is that scheduling latency.
>
> I think if we introduced a workqueue that worked more like a tasklet -
> in that it's run in softirq context - but doesn't have the interface
> mistakes of tasklets, a number of existing workqueue users might
> decide that that is exactly what they want.
>
> So we could have a per-cpu 'atomic_wq' that things can be scheduled
> on, and that runs from softirqs just like tasklets, and shares the
> workqueue queueing infrastructure but doesn't use the workqueue
> threads.
>
> Yes, the traditional use of workqueues is to be able to sleep and do
> things in process context, so that sounds a bit odd, but let's face
> it, we
>
>  (a) already have multiple classes of workqueues
>
>  (b) avoiding deep - and possibly recursive - stack depths is another
> reason people use workqueues
>
>  (c) avoiding interrupt context is a real concern, even if you don't
> want to sleep
>
> and I really *really* would like to get rid of tasklets entirely.
>
> They started as this very specific hardcoded softirq thing used by
> some drivers, and then the notion was generalized.
>
> And I think it was generalized badly, as shown by this example.
>
> I have added Tejun to the cc, so that he can throw his hands up in
> horror and say "Linus, you're crazy, your drug-fueled idea would be
> horrid because of Xyz".
>
> But *maybe* Tejun has been taking the same drugs I have, and goes
> "yeah, that would fit well".
>
> Tejun? Please tell me I'm not on some bad crack..
>
>                Linus
>
       - Allen


Return-Path: <linux-kernel+bounces-74804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545785DAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F02821ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6827EEF9;
	Wed, 21 Feb 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH92JAc4"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9777655;
	Wed, 21 Feb 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522395; cv=none; b=gsU750kI1IFG2kBOkU2xSONTr+HmUk5BpZ0O5yH6NzFGothdR7Nn1CV29pCA6Tidfk0y/VgSm6B0m95g9VbI3tCQyiOkCDIt//MEdrjr3h98+wrKUuT0Au1pc1964/1R+xQQhT8cs2qJwxRCQ4VlYzc1tBw/ntcp4akq5tWY+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522395; c=relaxed/simple;
	bh=0zrk4fdplPJ2n7pqwehQ2mMRsYQmSHU9ZrkHmQMyXB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PD4wYKSlzVaa/uCljW+lYUcOdOWWs8XA5cu+M/mEUcAX6BjvvSHJ09uHExG/qKYTxKhWcbksJrLAR1ELU6uox/0pQDxY0NmPN5pFGYsQSAZ+jbb/sc56sb0JHUt0eGhSk9H7PwmySQyDA16ZjX40MsjNjiFQUiiQdwsDSf4Mrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH92JAc4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394bec856fso4388016f8f.0;
        Wed, 21 Feb 2024 05:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708522391; x=1709127191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXwFlpGNxUJXMBoZb/7WFuYFIsMhJGhTGFkLifb6BE4=;
        b=RH92JAc4WT4A5AxgXWmBDYxKfByWXrL7tcd/2Dq9Hl5fRJ4qyrOonmoawf2ktjeMNG
         pdubTWMAM7t2qn8KZc3vyhkeuBAruH3wqS+JFUfryHBdVnhw4Kw3xVZwpMmM5KmIXj1u
         HEM1MfIoqijPU6qP0s/zm9Gv7I7z74LFCVKL2kxs6NavRApe5Okf6Cd5eoS3USck8/Fk
         WMLZ4N90O+tyOzB5dQo0Nmh20YYlODr+CW8ItEABJ3VhpUdof05JbtbKnjE0JD2Obt9l
         BKy9EWibXCr1RZzlOHkV0GvyDu5nPmpwH/1YeZeWSAZ4QssXgmy5iDErr9/vO10NKl/M
         b6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522391; x=1709127191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXwFlpGNxUJXMBoZb/7WFuYFIsMhJGhTGFkLifb6BE4=;
        b=u2JQ0xHe0fWT5nK12+BmYDNQhdl6pzPx1hsS+nHh/0FaL8/FkE7x6fwtp6gR3bqD+L
         XCAgh6ylHf6DhX0G5qD0KfnR0eeoSHzEJJG5kKewguho5w+AXwOudPD9It0QjWZbwV3U
         tMNsZQlPtqp67MpWF2hoXgvW/gqalIzqcKldzCASu56Rat628BPSQ2R5dpN2XAJd9eqo
         RHjIJ0Nuiy7e7riGpZtR6Eh3f8ccKyztQqCJHGbLGn5UoAbxFYPlHDp+B7ujpHphsdLm
         PxNI5a0o2AIgrNbSNzDpCqAsgSozxCZ4uhEFY9JQjo0qNcu0T+UELjOlmiwdiJI99RNu
         75QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxey2ZwYrIxv4Cnxi5d/SDOd5xlSXS9baVkNtNJGhImV8fAwwc0cTMBzZahA/xXCiURc0G/LwALmJnuaX/UwEmRGEcACFat9v8VQ==
X-Gm-Message-State: AOJu0YwaEK/1yG5+2ACOwCROp6kgabpzFJ7MhRhtMpBsJ0GUTa4yWhLV
	Igf/W96VYok0Ve/xMtT/vT/gl6RC6009Lb1vWIR6l+3E27PAlGFcb3ct/oeNCVL4/3avvcVaLhv
	+2Wvdb+/IjrC+dRtXJKuSGH/+otMajvOcJ+4=
X-Google-Smtp-Source: AGHT+IEWgOrxUHBwwCSEKxqjNbDTwtCIh69VOlo3S3A0SXkMVbeFwVqiYfF8XIhAQ4Z0Kn4eF6rOv+w6ZNGLYKafgPI=
X-Received: by 2002:adf:ec89:0:b0:33d:27c3:9f47 with SMTP id
 z9-20020adfec89000000b0033d27c39f47mr11486295wrn.35.1708522391339; Wed, 21
 Feb 2024 05:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
 <20240118161601.GJ939255@cmpxchg.org> <CAJD7tkb+NCocjpjvM08Nv2fPMDqm4t-YH05TJckz8m1AYFNWUg@mail.gmail.com>
 <20240118173927.GL939255@cmpxchg.org> <CAKEwX=PKBaqcpFwXpf1-M2nZ+ytFv2oCwxRVCe+CC5++rhgY=A@mail.gmail.com>
In-Reply-To: <CAKEwX=PKBaqcpFwXpf1-M2nZ+ytFv2oCwxRVCe+CC5++rhgY=A@mail.gmail.com>
From: Ronald Monthero <debug.penguin32@gmail.com>
Date: Wed, 21 Feb 2024 23:32:34 +1000
Message-ID: <CALk6UxqoBhvotfm83zQWGGfPpfARrMEUVWmT7tn6Tj1k189Q+A@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, akpm@linux-foundation.org, 
	Nhat Pham <nphamcs@gmail.com>, chrisl@kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reviews.
This patch is available at
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patche=
s/mm-zswap-improve-with-alloc_workqueue-call.patch

This patch will later appear in the mm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ronald Monthero <debug.penguin32@gmail.com>
Subject: mm/zswap: improve with alloc_workqueue() call
Date: Tue, 16 Jan 2024 23:31:45 +1000

The core-api create_workqueue is deprecated, this patch replaces the
create_workqueue with alloc_workqueue.  The previous implementation
workqueue of zswap was a bounded workqueue, this patch uses
alloc_workqueue() to create an unbounded workqueue.  The WQ_UNBOUND
attribute is desirable making the workqueue not localized to a specific
cpu so that the scheduler is free to exercise improvisations in any
demanding scenarios for offloading cpu time slices for workqueues.  For
example if any other workqueues of the same primary cpu had to be served
which are WQ_HIGHPRI and WQ_CPU_INTENSIVE.  Also Unbound workqueue happens
to be more efficient in a system during memory pressure scenarios in
comparison to a bounded workqueue.

shrink_wq =3D alloc_workqueue("zswap-shrink",
                     WQ_UNBOUND|WQ_MEM_RECLAIM, 1);

Overall the change suggested in this patch should be seamless and does not
alter the existing behavior, other than the improvisation to be an
unbounded workqueue.

Link: https://lkml.kernel.org/r/20240116133145.12454-1-debug.penguin32@gmai=
l.com
Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/zswap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/zswap.c~mm-zswap-improve-with-alloc_workqueue-call
+++ a/mm/zswap.c
@@ -1884,7 +1884,8 @@ static int zswap_setup(void)
                zswap_enabled =3D false;
        }

-       shrink_wq =3D create_workqueue("zswap-shrink");
+       shrink_wq =3D alloc_workqueue("zswap-shrink",
+                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
        if (!shrink_wq)
                goto fallback_fail;

_

On Fri, Jan 19, 2024 at 4:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Jan 18, 2024 at 9:39=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Thu, Jan 18, 2024 at 09:06:43AM -0800, Yosry Ahmed wrote:
> > > > > > On a different note, I wonder if it would help to perform synch=
ronous
> > > > > > reclaim here instead. With our current design, the zswap store =
failure
> > > > > > (due to global limit hit) would leave the incoming page going t=
o swap
> > > > > > instead, creating an LRU inversion. Not sure if that's ideal.
> > > > >
> > > > > The global shrink path keeps reclaiming until zswap can accept ag=
ain
> > > > > (by default, that means reclaiming 10% of the total limit). I thi=
nk
> > > > > this is too expensive to be done synchronously.
> > > >
> > > > That thresholding code is a bit weird right now.
> > > >
> > > > It wakes the shrinker and rejects at the same time. We're guarantee=
d
> > > > to see rejections, even if the shrinker has no trouble flushing som=
e
> > > > entries a split second later.
> > > >
> > > > It would make more sense to wake the shrinker at e.g. 95% full and
> > > > have it run until 90%.
>
> Yep, we should be reclaiming zswap objects way ahead of the pool
> limit. Hence the new shrinker, which is memory pressure-driven (i.e
> independent of zswap internal limits), and will typically be triggered
> even if the pool is not full. During experiments, I never observe the
> pool becoming full, with the default settings. I'd be happy to extend
> it (or build in extra shrinking logic) to cover these pool limits too,
> if it turns out to be necessary.
>
> > > >
> > > > But with that in place we also *should* do synchronous reclaim once=
 we
> > > > hit 100%. Just enough to make room for the store. This is important=
 to
> > > > catch the case where reclaim rate exceeds swapout rate. Rejecting a=
nd
> > > > going to swap means the reclaimer will be throttled down to IO rate
> > > > anyway, and the app latency isn't any worse. But this way we keep t=
he
> > > > pipeline alive, and keep swapping out the oldest zswap entries,
> > > > instead of rejecting and swapping what would be the hottest ones.
> > >
> > > I fully agree with the thresholding code being weird, and with waking
> > > up the shrinker before the pool is full. What I don't understand is
> > > how we can do synchronous reclaim when we hit 100% and still respect
> > > the acceptance threshold :/
> > >
> > > Are you proposing we change the semantics of the acceptance threshold
> > > to begin with?
> >
> > I kind of am. It's worth looking at the history of this knob.
> >
> > It was added in 2020 by 45190f01dd402112d3d22c0ddc4152994f9e1e55, and
> > from the changelogs and the code in this patch I do not understand how
> > this was supposed to work.
> >
> > It also *didn't* work for very basic real world applications. See
> > Domenico's follow-up (e0228d590beb0d0af345c58a282f01afac5c57f3), which
> > effectively reverted it to get halfway reasonable behavior.
> >
> > If there are no good usecases for this knob, then I think it makes
> > sense to phase it out again.
>
> Yeah this was my original proposal - remove this knob altogether :)
> Based on a cursory read, it just seems like zswap was originally
> trying to shrink (synchronously) one "object", then try to check if
> the pool size is now under the limit. This is indeed insufficient.
> However, I'm not quite convinced by the solution (hysteresis) either.
>
> Maybe we can synchronously shrink a la Domenico, i.e until the pool
> can accept new pages, but this time capacity-based (maybe under the
> limit + some headroom, 1 page for example)? This is just so that the
> immediate incoming zswap store succeeds - we can still have the
> shrinker freeing up space later on (or maybe keep an asynchronous
> pool-limit based shrinker around).


Return-Path: <linux-kernel+bounces-156189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1EE8AFF03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988EC1C22BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3B85940;
	Wed, 24 Apr 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3CKCuAW"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8FBE4D;
	Wed, 24 Apr 2024 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927784; cv=none; b=N0UQbR69DrvWPBuc1En7Rr0aAAi9Z0UoCphdLTjrFrKMyRJuM68Z1xcCwWnKuz7w5+Zr+1PP7h3JYTKCVD0xN1zzXft9Hn+iitqTRU2OdimUx68qBOYzNV8VxErdhA2gY7ZI6q0rkVMZJwSmbPAeJFRW78ZeXec9CzvdIMvW0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927784; c=relaxed/simple;
	bh=EJp1sVABrnMfAEUJyVD42/Rr8+Y/2hh6qEK9xbx70Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdoBFOBNW2gRVe6iIxdDHnBck8C3zJQCLLt+ib7p0S3Br3WHy1U3HZtoQ4lADcfLjoL2UiPm2W4Xp/znDIJd3axNrwugQAKURHKpFdIdod49tQY4US41bnmArKGKj97L8BnymZxT2Ne/BefCewIRGNposZnZ08MIvCR/22FOZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3CKCuAW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a5ef566c7aso5093456a91.1;
        Tue, 23 Apr 2024 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713927782; x=1714532582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBkj0iX8Tib0iQZjsFZ3jbSEgjFQxfkqX+/dN0dL94g=;
        b=i3CKCuAWp+J8BM6DLd1zYjnKhjao6tDdeu2JgdPEN0HBm6hIr9ueXYHGOvYqQP5w0L
         6j/f94p6Fv6PQHPAmdYQ2ZysQ+UkOi1KPQxbtzmhTzA9ZZwx9eDrIgYHAhXd04UGVFBP
         FczWNTkkw46cdaCnLlAan4YFLDQ8zHXDsD9Uk/ZoOUisIeE1fHf+47bEX+bvmQlAfXlo
         gKOjA/lIdpEqe1stuB6qNzowizhBjdT8080Toq1gEv7aAnhmRrdENijy5+UQXgh8voFv
         wkFNbKD3oK4sxOOP5OXznUPP+x1Nux/c/oTe4EgglO6fYXWVjZcG36XwIF/hK0Fp9gjF
         djgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927782; x=1714532582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBkj0iX8Tib0iQZjsFZ3jbSEgjFQxfkqX+/dN0dL94g=;
        b=UDbRV4Mg71QrIvdP/QTkRS4rTOVUIQdOqj2JKJlHqSTUdGFgF8oXJ8e1+J2krVhW61
         NGfGBF3QOgywy/iVymuXi9yl1CpyaC8Gnjb5pg7O3za4WjiKRfAfxoAxgLPIXNWT1A7E
         mucVdc3RuGgb64jl+HQYjGAXPH8Kiv8E2e1DcSnsWd83hh1HsBmYncY7GBF54RlFw8Fn
         dQcesuCiENVIqEA7EzBMUEngLzRnsXx9z+lkJKwF1UHoslPoCaqtwk5tD7DJuGYUy8Po
         XEwK9pPtKzOJKriTUsTWGpE3c+eJCDqA80c2QIP19R2FFm77AVEymfEr/AGQqXyny5KU
         9REg==
X-Forwarded-Encrypted: i=1; AJvYcCW5IfDwPv3DYvKD1DzMWvPhDQGK6FlhjYmBAg7WbnLMF6oMkwSYeMz3nt0yassnzX3OKLrM19vXppdiksVMXKAteftd
X-Gm-Message-State: AOJu0Yy05b9Yz2Pm1E9eqhQJLj9GPtbhUHAFA3+2zUJlZuyL5ZW0NMUF
	QtIhhoc3iUsfjNQmc2dvqLM08Yj2vq3eU/7nuIDMWsD3SAoasWhY4BQwrriyw4N5yHbPCuoYiIy
	v4a55Bixv4EjPnYh+V87ncCUrx4g=
X-Google-Smtp-Source: AGHT+IEuAd4mHZ9xnWnY+Ll0HGUEFg53AtVRwCCaVieJDfUrVgaKveurQnLZssnIa0pxp3e7y2oZC3nx1lZY9bTgJdY=
X-Received: by 2002:a17:90b:33ca:b0:2ab:afb8:e44c with SMTP id
 lk10-20020a17090b33ca00b002abafb8e44cmr1080374pjb.20.1713927782596; Tue, 23
 Apr 2024 20:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-10-jiangshanlai@gmail.com>
 <CAEXW_YSz8xD4WXO0dOyKC6X7BZeqMD2TOCm0=43=owLjJj=PVA@mail.gmail.com>
In-Reply-To: <CAEXW_YSz8xD4WXO0dOyKC6X7BZeqMD2TOCm0=43=owLjJj=PVA@mail.gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 24 Apr 2024 11:02:51 +0800
Message-ID: <CAJhGHyCKE4+g9X=OMXTZ=V=4W+of4D3ZvuywniJOdLYp3pe0cA@mail.gmail.com>
Subject: Re: [PATCH V2 09/11] rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:19=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Sun, Apr 7, 2024 at 5:04=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
> >
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > When the arch code provides HAVE_PCPU_RCU_PREEMPT_COUNT and the
> > corresponding functions, rcu core uses the functions to implement
> > rcu_preempt_depth(), special bits, switching and so on.
> >
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > ---
> >  include/linux/rcupdate.h | 33 +++++++++++++++++++++++++++++++++
> >  kernel/rcu/Kconfig       |  8 ++++++++
> >  kernel/rcu/rcu.h         |  4 ++++
> >  kernel/rcu/tree_plugin.h |  8 ++++++++
> >  4 files changed, 53 insertions(+)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 328667ae8086..e3e5ce44c7dc 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -70,6 +70,8 @@ static inline bool same_state_synchronize_rcu(unsigne=
d long oldstate1, unsigned
> >
> >  void rcu_read_unlock_special(void);
> >
> > +#ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT
> > +
> >  void __rcu_read_lock(void);
> >  void __rcu_read_unlock(void);
> >
> > @@ -81,6 +83,37 @@ void __rcu_read_unlock(void);
> >   */
> >  #define rcu_preempt_depth() READ_ONCE(current->rcu_read_lock_nesting)
> >  #define rcu_preempt_depth_set(val) WRITE_ONCE(current->rcu_read_lock_n=
esting, (val))
> > +#define pcpu_rcu_preempt_special_set() do { } while (0)
> > +#define pcpu_rcu_preempt_special_clear() do { } while (0)
> > +
> > +#else /* #ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT */
> > +
> > +#include <asm/rcu_preempt.h>
> > +
> > +static __always_inline void __rcu_read_lock(void)
> > +{
> > +       pcpu_rcu_preempt_count_add(1);
> > +       barrier();
> > +}
> > +
> > +static __always_inline void __rcu_read_unlock(void)
> > +{
> > +       barrier();
> > +       if (unlikely(pcpu_rcu_preempt_count_dec_and_test()))
> > +               pcpu_rcu_read_unlock_special();
> > +}
>
> Previous code had comments about the barrier(); , can you add back
> those comments?
>
> Also there was a compiler barrier in the body of the if() as well?
>

The two "if"s in the referenced __rcu_read_unlock() are condensed into
a single "if" ("if (unlikely(pcpu_rcu_preempt_count_dec_and_test()))"),
so there is no extra barrier() needed in the body of the "if" which
is analogue to the body of the second "if" of the referenced
__rcu_read_unlock().

The special bit and the rcu_depth_count are condensed, so the code
mostly follows the way how preempt_enable() works.

Thanks
Lai

> For reference:
>
> void __rcu_read_unlock(void)
> {
>         struct task_struct *t =3D current;
>
>         barrier();  // critical section before exit code.
>         if (rcu_preempt_read_exit() =3D=3D 0) {
>                 barrier();  // critical-section exit before .s check.
>                 if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
>                         rcu_read_unlock_special(t);
>         }


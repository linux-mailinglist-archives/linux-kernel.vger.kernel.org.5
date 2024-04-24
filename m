Return-Path: <linux-kernel+bounces-156152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7B8AFE96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E788C1C22249
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8E83A1E;
	Wed, 24 Apr 2024 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy0TP06p"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5A28DDA;
	Wed, 24 Apr 2024 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926599; cv=none; b=jmy2vUoB1wnsoIyjZ8s5xTTF90fw3tV0nC8iBr4CsyTV4ZAQa9xojSpvvNB9HG6H+bsqhqCrQUkJ6nOH+/jV8L25/3m27u0n9NDHC4x4h0TtG9H5cLd1mTxDV2OiE5LC8zo/5dW6USvlgv580ZQGb8DQ0JfLerA9riAK6YNhcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926599; c=relaxed/simple;
	bh=QZR2aHS7+AW6lzCqR7AodE3BpdZxWXr/i2FA4YX8x1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk4BulAqxIfV85+MVr2aDcexRPU+gwCVohDorywVKPgkKbZzNNInqq9zzHP3wCnaRghQWzbAWUhuIzspcppRkwYcYsKRRU9KydOApPSUBrYDDsGfS848KJsqc7ohj6N47rvgrWG4Jl69mZNwf6a2eIrUxZ9GWuscgPe5AlcTUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy0TP06p; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so2373854b3a.2;
        Tue, 23 Apr 2024 19:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926598; x=1714531398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU+Gx/Z2QqbJeW/dEu6ETFyj9ZvH8Y+qoiAfHayNmPo=;
        b=Cy0TP06pE/XW3Hn5UGhJOZALv+I30bb0ICUFoQd1aCxLbpZULnp8X+9RjJZXFE4wnD
         C+5rexJJzBcGeAi/EK+3zZUd18eucEtDFCLnVrmCv/6ZT2yi4wdT8dh1iGy5ENtFgyZT
         kYYNqij0CsTLXhTJ3I4h40mFAATHURI3oR41B9AYzCFFhcpe5Aga8Xnl1z20pcoGsckm
         cWfoj7PgRUXRqNGT9SWeiw6j7WC+X9+6OZ5e5nAOTfLTAzGEY5vefuyQLp4MkxTkusfP
         oi/Qs/yPMtUzO+5RWu1gehK3deBMs2bZ4xJqV3MtGHp3dsPro1Q+aTk6fVUbq5pxDl/I
         lzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926598; x=1714531398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU+Gx/Z2QqbJeW/dEu6ETFyj9ZvH8Y+qoiAfHayNmPo=;
        b=KUowtbsZOFxt6eBEnOLqgcOWgFUF4Ul2LcC1ELf5s6V+qBaGoeANtoQnsYP2J4Xsum
         823T61ohkf3YJnmHJtqIDueww/BQHffLX4DBYBJmuFdRWWSMiuIpNyMuztm3MSBSX/Ta
         psXYxih4nf7QIgwYfjTPVGfQowYZkEguajAh0B4qE8zMLLUfLfedgADJAT7R054i9wZz
         ifa8nwpBFW8nhrXv/JKmD1m4KKBa7ggazZ2Wowfc5JkAzUbJQDgxAWLMd7uk/MEX7S8L
         ByX/rKf3q1PNPTlsPEngVj/uDiiLX8gpdY42tevSoHLpg7NDdFc0IE617hkpCslPwCKS
         pPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKhbQTBsbIadPcTRbI/gnPuvGHetUDTw/+pclMYw/qBGeeS/i7wFvOX+PbDmrl6gK/a5v/oV0sk0Ovdy7G6e4EcXyl
X-Gm-Message-State: AOJu0YwWDfP7erZXsauoNMNDe1v+hCJPMUJKMiZTh5nAt7t2pH6PT9aH
	t1ZDngn+cmeuAApm53sNIIsBIjjfWXQuFS3a2IiKHQ2z7++LXuoUBmAenMTAlQWjLlayiJ+Y0TR
	aDPlkLwyt2tNcRfuDr6PUujHNDEY=
X-Google-Smtp-Source: AGHT+IFWC3huiok3Xjq2wWSe14p16VQxgpQU2Bl2Ka2eNo+7MVrOPBf2lCicJmLbYr5P2vcUYO6F85fCFzlUEu5fbAo=
X-Received: by 2002:a05:6a20:d412:b0:1a9:eeef:f6b3 with SMTP id
 il18-20020a056a20d41200b001a9eeeff6b3mr1040126pzb.53.1713926597666; Tue, 23
 Apr 2024 19:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-12-jiangshanlai@gmail.com>
 <CAEXW_YTin=EgjoypCD=eYh-NLRwxbhdr+B-jBO5TpC4qcef2_Q@mail.gmail.com>
In-Reply-To: <CAEXW_YTin=EgjoypCD=eYh-NLRwxbhdr+B-jBO5TpC4qcef2_Q@mail.gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 24 Apr 2024 10:43:05 +0800
Message-ID: <CAJhGHyBt8y46i9fkpCDS720khgZQhRD5NTfsW2X0U41Edcc=FA@mail.gmail.com>
Subject: Re: [PATCH V2 11/11] x86/rcu: Add THUNK rcu_read_unlock_special_thunk
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:26=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello Lai,
>
> On Sun, Apr 7, 2024 at 5:07=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
> >
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > Add rcu_read_unlock_special_thunk(), so that the inlined rcu_read_unloc=
k()
> > doesn't need any code to save the caller-saved registers.
> >
> > Make rcu_read_unlock() only two instructions in the slow path at the
> > caller site.
> >
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > ---
> >  arch/x86/entry/thunk.S             | 5 +++++
> >  arch/x86/include/asm/rcu_preempt.h | 4 +++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/entry/thunk.S b/arch/x86/entry/thunk.S
> > index 119ebdc3d362..10c60369a67c 100644
> > --- a/arch/x86/entry/thunk.S
> > +++ b/arch/x86/entry/thunk.S
> > @@ -13,3 +13,8 @@ THUNK preempt_schedule_thunk, preempt_schedule
> >  THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
> >  EXPORT_SYMBOL(preempt_schedule_thunk)
> >  EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
> > +
> > +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> > +THUNK rcu_read_unlock_special_thunk, rcu_read_unlock_special
> > +EXPORT_SYMBOL_GPL(rcu_read_unlock_special_thunk)
> > +#endif /* #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT */
> > diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/=
rcu_preempt.h
> > index cb25ebe038a5..acdd73b74c05 100644
> > --- a/arch/x86/include/asm/rcu_preempt.h
> > +++ b/arch/x86/include/asm/rcu_preempt.h
> > @@ -97,9 +97,11 @@ static __always_inline bool pcpu_rcu_preempt_count_d=
ec_and_test(void)
> >                                __percpu_arg([var]));
> >  }
> >
> > +extern asmlinkage void rcu_read_unlock_special_thunk(void);
> > +
> >  #define pcpu_rcu_read_unlock_special()                                =
         \
> >  do {                                                                  =
         \
> > -       rcu_read_unlock_special();
>
> Instead, can you not use __no_caller_saved_registers attribute for
> definition of rcu_read_unlock_special() or does that not work for what
> you're trying to do here?
>

I think it is paramount to make it the same as preempt_schedule[_thunk]()
when it comes to avoiding the caller-saving-registers-procedures in the
unlock paths.

I had no idea of 'no_caller_saved_registers' before, so I haven't tried it.

And there are limits to 'no_caller_saved_registers' either:

https://clang.llvm.org/docs/AttributeReference.html#no-caller-saved-registe=
rs:

Functions specified with the =E2=80=98no_caller_saved_registers=E2=80=99 at=
tribute
should only call other functions with the =E2=80=98no_caller_saved_register=
s=E2=80=99
attribute, or should be compiled with the =E2=80=98-mgeneral-regs-only=E2=
=80=99 flag
to avoid saving unused non-GPR registers.

https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#index-no_00=
5fcaller_005fsaved_005fregisters-function-attribute_002c-x86:

Since GCC doesn=E2=80=99t preserve SSE, MMX nor x87 states, the GCC option
-mgeneral-regs-only should be used to compile functions with
no_caller_saved_registers attribute.

And I don't think =E2=80=98-mgeneral-regs-only=E2=80=99 is being used in th=
e kernel for x86.

Thanks
Lai


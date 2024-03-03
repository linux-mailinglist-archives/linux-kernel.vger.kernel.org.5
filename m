Return-Path: <linux-kernel+bounces-89897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3286F704
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D681C20A28
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8279DBE;
	Sun,  3 Mar 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOnNaB5g"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE11EEF9;
	Sun,  3 Mar 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709497455; cv=none; b=e0Mk4Z9AAMEWSQ2q6tvDMlQsuiuh2zKAjmlwYudJSv0fvS+eVp11AdcAdndX2Rni0JSj98ChR1oElk6Rkq0F5Kl72KxZ6CmPB+lfSgV+JN2MJI1c2enXDC3rN58K6W5buDRFWvTWw79zB6wQoLpOS7jcA0W0fxlbCq1Ls695J8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709497455; c=relaxed/simple;
	bh=wKfsyUf3DPHLb5+bNe7is8QSZZffVwOf6cpgOfSIHKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmgiIGFndpuuLi/FBubxPVbZZ/imiA3/AR4eQSnZyCexRJQt2rdYKdhLt/xmRj60b2W4rwbq/OKdxFyztYcXSrLwPkMfTzd8BcZIuyrTxd2gyrYigQaFOtXzgUQwoQnvRZgz+5NwBBqJ3g7zR7Fr3ZXFkyV2ZK6M+NxDed4lHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOnNaB5g; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d28464c554so51009101fa.3;
        Sun, 03 Mar 2024 12:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709497452; x=1710102252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKfsyUf3DPHLb5+bNe7is8QSZZffVwOf6cpgOfSIHKM=;
        b=eOnNaB5gwSKF+yAULC+bYkT1Qo9k1XYun7DX4jCjUMlV4Si3UocihWUWc2mkVpYl0i
         /UpASdJxhrgJR7qgX5ydHKUfvRflhZly3e8jsNDkLteQCO8Y5xGHC3yrVNsAKVxCqT1S
         S4S7wOvX0ilDxkoiWdz0fOZmu7vKcz+uySpf1V8OcQDZL/Sf9IRL2HE85/PNKefuFI2w
         m5ALkwIzpTRzcf6+1Sd6yCYNZgTlkXZCOBEhRbBypNctIn5EeuBMQUPfOWNuDIbTVy8p
         cVlXwyBXUi7HAJUxzEOexYCgWNdboK6xnG/eiND9tIcg/n0ItMrLdkUGh1xKLQS8Mtdp
         Filg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709497452; x=1710102252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKfsyUf3DPHLb5+bNe7is8QSZZffVwOf6cpgOfSIHKM=;
        b=Y2vHn+6toLa7gLsv3HFE4+qtUVjFvlcx/oQ7Sncle+vT3E/2MYAQ+rpQrxAAEJApo7
         jHbOBVK+9JU0on6SJg96VbpOhqHOUZ+SzSQIxYK+s7Q3eFDiCkazABJsPTLrbK74+teK
         3A5jjIA2obaJLUO1/h/3BNpzqRtWOyh8PZIXXQsgZ17Lj+XAlJWeMDxOzt3LdB8BNGZY
         o9WDiDyOZOh6y+JE8YM+JhGXVEc3tq52rqlwbzmV361OiWN4ueyhwucj9vT9k1NtR06Q
         h9drYzhK33oGgWHKPCE872VqLb+TNSYj/Vo4wtKC1CaaLC7qA56cwFRL/cU/aiEVdI67
         POWA==
X-Forwarded-Encrypted: i=1; AJvYcCVqRTGyJr7LWXNm1a+R7PgvZ79yLHoTg6HyUtqXHve+Lo1sCoWOaoOpY63GlTpgtZV5SW7G74Tpeb9wjZdJAM6BkMT3zRDEOBMxxL1FAhLk8ukGr4kKvP53KrRjAubVv4TuB4nWalD2Bdav
X-Gm-Message-State: AOJu0YwnMgZHyjmI+CsuaGzmFnv9FcVZaOUR9/+whpcvLkDa+e19GMh8
	hV4GluwcMvD3BNsHg1flk2ILuTDnVobl/7Q8n7+KfrZSyV6qyEDg8cGVsuNkDiaZ1f8St6AQBQq
	j0eGxgzpOpliXA6lR2t56Uu2wLVUaAOb7aE0=
X-Google-Smtp-Source: AGHT+IH9bgy2FSfFF72RMPmbMdDYHA6wFzmSr/xvr072k/oq5qVLt8Zj4vIQU4el/XJcMmoQ/A0OKARpu3Bdzci023g=
X-Received: by 2002:a2e:824f:0:b0:2d2:a19a:8625 with SMTP id
 j15-20020a2e824f000000b002d2a19a8625mr5046603ljh.40.1709497452384; Sun, 03
 Mar 2024 12:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx> <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx> <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx> <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
In-Reply-To: <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 3 Mar 2024 21:24:00 +0100
Message-ID: <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 9:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Sun, Mar 3, 2024 at 9:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> >
> > On Sun, Mar 03 2024 at 20:03, Uros Bizjak wrote:
> > > On Sun, Mar 3, 2024 at 5:31=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> > >> I did not follow the __set_gs work closely, so I don't know whether =
Uros
> > >> ever tried to actually mark the per CPU variable __set_gs right away=
,
> > >> which would obviously catch the above 'foo' nonsense.
> > >
> > > No, because [1]:
> > >
> > > "gcc does not provide a way to remove segment qualifiers, which is ne=
eded
> > > to use typeof() to create local instances of the per-cpu variable. Fo=
r
> > > this reason, do not use the segment qualifier for per-cpu variables, =
and
> > > do casting using the segment qualifier instead."
> >
> > Right. I just figured that out myself when playing with it in user
> > space.
> >
> > That's so sad because it would provide us compiler based __percpu
> > validation.
>
> Unfortunately, the c compiler can't strip qualifiers, so typeof() is
> of limited use also when const and volatile qualifiers are used.
> Perhaps some extension could be introduced to c standard to provide an
> unqualified type, e.g. typeof_unqual().

Oh, there is one in C23 [1].

[1] https://en.cppreference.com/w/c/language/typeof

Uros.


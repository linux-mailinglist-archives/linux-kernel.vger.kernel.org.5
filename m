Return-Path: <linux-kernel+bounces-81812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE7867A58
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F81C236BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7912B140;
	Mon, 26 Feb 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lodzc/PJ"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113067E794
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961638; cv=none; b=Z+4VyJXqd9aXyrhkeuailk9y0JuChbi4ddoM9pzlnHeFOOhiqC5qZRkhVWgXwMf32ApBWkSAB68/+eXCWq/IBHEyQz3oe1eSQTG6nEL/sF2OgNrsqcYgVYMfJD9hxjV8nXylHbD7+b/pLPlAFwMEHM2XJ++DlXvO7XZYcePbV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961638; c=relaxed/simple;
	bh=0iyDe1EQgm5oO9vhF/f5ONPzJVHkPLKyTGhY5TjDUDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwaOHb1ACmYKzKyJaczjupnn8FTLxDEystq9Pj68kUs2Im4JxFjBqDIm/1UFZxMaSMHNkGjoe8QhJ9knSW5Z/PFsnpyHZdhnGdeffRNZYZEYwkNwQLP//2pStLB4myVaOfr4PM3fTB4j9EcrIzcpzUNTm2cAP5CPHJyD+nX329c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lodzc/PJ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21f3a4ba205so1227144fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708961636; x=1709566436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CLzmfaxXuoVSovPc9lvPOJuzDpcgdZmABwHl2F0yx7s=;
        b=Lodzc/PJ6v3QIQi/tSgu/A2iOYpmfJaUTOPwFvmgzYIS8WqNzuPbdVo1JuPdDq+u19
         TsGBzZzFEC/SD/LRupuFO6kyHbPq6eD04ex+u44AHaWW0LLUKVXbdqYQXFVuhmlvWhoW
         A9yCHg/INBd32YUabwGGJmvbeDXPRZGOIIKtaEJpXbDbk1qsK0LuLRGzggLTz65RezqY
         VBkKO7hwdxC8WtwWucUS3Mrj2RBKmrEYdJlnBVczuJG1QmUQ+mhFlrubz6tQjXlvQ5PT
         M38WekEAs7imppvioW80jWqz9jgx5YFBBeuiTUd7ZQquXufX2BTr7aEfyaLfJYmhgO5B
         WGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961636; x=1709566436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLzmfaxXuoVSovPc9lvPOJuzDpcgdZmABwHl2F0yx7s=;
        b=DVhVpSsJjXdFINVaKbgrMgkveznXXU6/VBOuJVSsTkn7ncynXd3Dry7szTDS3JPNRW
         T1UgW7oY4VSO0E51c87h2KXeJ4GUBkZZ20uwVp9eFH/RUwsDl7X2GuCqHGAUFEHuFsPf
         4NTfJFUqWmYNM02zcLMxbjGAlSsirqqDo0L/JGu2snhb3eiHm98hmv0D5kLbFZ6OeM2o
         gK5zSEjFJFIcx5hdumus01a8i7zATxIdQVCYY+b7G2OoMsI2AEUPXnl95rEme+Ff+bqp
         DhnqBns44O2Lj09PyDf6R5H7BYSVGC0ljyvljsz7udaeJoBCJrGShd2lglvHsHT+K4bU
         Wd6A==
X-Gm-Message-State: AOJu0YyNtxvu6HEmy+1bmpSs1oJjk1gVNLIntos5X0Z9Tcn7e0eAzuV9
	soryVfBdkcGRapIyPC5wouXJA94YkH+X7IeVDNcTJiouNnzWJ6ss465K9Y/hfMOf6fvLk5P4hIg
	4k5j1KVAckcySFxkV0lRmwGEJjAoj4onYp6uYrw==
X-Google-Smtp-Source: AGHT+IG5sjvFKwX1SIGV1P8Apr8A3z0qef9k616Q7x8HWpNZmoezYTemUXzGOuwXmu3XjXwkLSJISICG8MDkislJq2U=
X-Received: by 2002:a05:6871:58f:b0:21e:b695:dff5 with SMTP id
 u15-20020a056871058f00b0021eb695dff5mr8429175oan.20.1708961636025; Mon, 26
 Feb 2024 07:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
 <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
In-Reply-To: <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 Feb 2024 21:03:44 +0530
Message-ID: <CA+G9fYvTtJm8mhQh=c9WL4Ef_7Mb79CbBjFVoujupXFMrNsa-w@mail.gmail.com>
Subject: Re: arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type
 name 'u128'
To: Arnd Bergmann <arnd@arndb.de>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Fri, 23 Feb 2024 at 14:56, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 23, 2024, at 10:10, Naresh Kamboju wrote:
> > In file included from arch/arm64/include/asm/lse.h:5,
> >                  from arch/arm64/include/asm/cmpxchg.h:14,
> >                  from arch/arm64/include/asm/atomic.h:16,
> >                  from include/linux/atomic.h:7,
> >                  from include/asm-generic/bitops/atomic.h:5,
> >                  from arch/arm64/include/asm/bitops.h:25,
> >                  from include/linux/bitops.h:68,
> >                  from arch/arm64/include/asm/memory.h:209,
> >                  from arch/arm64/include/asm/page.h:46,
> >                  from include/vdso/datapage.h:22,
> >                  from lib/vdso/gettimeofday.c:5,
> >
> >                  from <command-line>:
> > arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
> >   298 |         u128 full;
> >       |         ^~~~
> > arch/arm64/include/asm/atomic_ll_sc.h:305:24: error: unknown type name 'u128'
> >   305 | static __always_inline u128
>
> The problem here is the separation of vdso/*.h headers and
> linux/*.h headers.
>
> Commit a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store
> available for all architectures") introduced a reference to
> the asm/page.h in include/vdso/datapage.h, but this is outside
> of the vdso/*.h namespace and doesn't work in the compat vdso.
>
> I think it is only needed because of the PAGE_SIZE macro,
> so that constant needs to come from somewhere else.
>
> I have an older patch that I never merged to unify the
> page size configuration in Kconfig, and could try to
> dig that out if nobody has a better idea. If we do that,
> we could introduce a CONFIG_PAGE_SIZE.

The 16K and 64k page size builds pass.

>
>     Arnd


Return-Path: <linux-kernel+bounces-117059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD888A687
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2003C1F3DF04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DA47175D;
	Mon, 25 Mar 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a4TNHSkf"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608616B43B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371025; cv=none; b=Gs39fSsbyeomM5aSHHi+MUtIC27HnlcBm/DIwowVJ3N155K94ZJ+n/Nv5nxFZDfD600eyH/r5UC8Enb98fAwK0JoSZfmrQFKJQZlVZbFJiiIBbmcFyFEo55MVNHcoQszRhAnznulaaiqz2Lu5971phe80gRlIL4QDq2Od3v2oHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371025; c=relaxed/simple;
	bh=5RyxoVFw8iV/PhK2kQZFnetLsvcimHQCr4aKA83CIbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuLtJooVEwEulmLIgehlxlPcGuCXiry46uyP3/juVlY8l7CtaMmrEHoN2/XaOnwoEhJOwIbkYY2/PZlrrIQkAWnDx/JqGDZI8JkDC0qTQ3p/fB7YXxKxvVqYzwtRh1tKO0l7XEbZf2l7ApyLZzDKVdeyH7+BhUqD5wimJ0Ws07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a4TNHSkf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2394479a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711371023; x=1711975823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RyxoVFw8iV/PhK2kQZFnetLsvcimHQCr4aKA83CIbw=;
        b=a4TNHSkf345sgU+AhOU4z07DoeTKHgfhTOtCntVFlL5JUPIJD/s/wbEYk8XiPkG5nT
         eRFKk/ZWgWFH2CzOAStB5sGfJQbQoRmqsv9dUgBiS9bz9s8u02qszMcDF90mG9m7JOX8
         ilAaOOg16Ec8Ky13yUBtua2gFPSRhLWISNT6X4Hu23ivWGSsYc6nx2+nGOgpKk8CDD6E
         kSLSVTFKpttG3ROgenDsIv3lXFgwQMEnDCvKn0NJcOSePd9jovd9u3TXBMvFBRyyYBey
         659DD7xK7+6xGDbySP5Z5MzwVGainNWCQtMukMKLXSFNAloigdk76z4/arVERypC4FrW
         YnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711371023; x=1711975823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RyxoVFw8iV/PhK2kQZFnetLsvcimHQCr4aKA83CIbw=;
        b=VDpoesLIOKH/1MXQdGw6QuRAWja2iAS53lRDqgGG2KY2E8s4yb4GENMRJHM/hnax3q
         m2u4cEfkGMaVJ9iXY5Xcs13YL/Qr9za/GWMizJBG06q3uHnAyQygjHiO2ieqjGen1Uvy
         wD5VcqEsHkX8GGjZTwXM06vEi7prlgTeKYorfACXKq0XqLN0f0SFdlVXYYFvY0vvRQw0
         sZWFlF/4Gjx4ilWpj8bY3pplcm7NrZugFh/rksZjFZM8CQlmzlEQ3ZOz7vRAyZ8QnQCC
         k2kIRb3Yvtin8YzUudxj19Klwv8b9rjTaaJWz6Xwb4RST14FNUQZtmisPiT09bArNxz9
         bibg==
X-Forwarded-Encrypted: i=1; AJvYcCVk7uYfh/+aaVm4EBsop7Sw5l5Cpi7Pe2K70ZrifjmKmiTAmW8p753Q6pitmgppTvldI5PTNkZMTusR6sIpJaNwN5rkasy14Xp9tQ6s
X-Gm-Message-State: AOJu0YyBF8CABMzd5OzjY+hBS12Iw+yy16b4hrAYWh2C7ilyQMWwO3st
	06O1hhsiHXVgUo6+r+MdFWBy+dmvpTDN8WomqDpZf3YNwoNKigIW6HjjMI+2wDqYMyiEvl78nSa
	IEODFBFB8Pm5oDjPvB/4bFEoFswKYGdktH9fJIg==
X-Google-Smtp-Source: AGHT+IFavvihRisV9kCaSJXWkP5NlMeM+2ciaavifWQ9HNV1hzqkvuSD7eRB5OdriFQR916iQBclkPwrahehtGboVyQ=
X-Received: by 2002:a17:90a:b30c:b0:29c:5c56:ffea with SMTP id
 d12-20020a17090ab30c00b0029c5c56ffeamr4730905pjr.6.1711371023055; Mon, 25 Mar
 2024 05:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N> <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com> <87zfv0onre.fsf@all.your.base.are.belong.to.us>
 <87il1oedx8.fsf@all.your.base.are.belong.to.us> <CABgGipWPuvwi43v1+60-=0_MN_q_CD0ZGasxHHVWJ37cig5MmA@mail.gmail.com>
 <87msqsotr8.fsf@all.your.base.are.belong.to.us> <CABgGipUayONdvaH0nexBJUai=qT3yqURhinTbDWxORfMDQ_5pw@mail.gmail.com>
In-Reply-To: <CABgGipUayONdvaH0nexBJUai=qT3yqURhinTbDWxORfMDQ_5pw@mail.gmail.com>
From: Robbin Ehn <rehn@rivosinc.com>
Date: Mon, 25 Mar 2024 13:50:11 +0100
Message-ID: <CAEEvPLB0eVXwRxucKDtc4mG11BwueV4pk4g9Zi82MPeTaP41uw@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Andy Chiu <andy.chiu@sifive.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
	Bjorn Topel <bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>, 
	"Cl'ement L'eger" <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Brendan Sweeney <brs@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

> <index-in-dispatch-list>
> func_symbol:
> auipc t0, common_dispatch:high <=3D> j actual_func:
> jalr t0, common_dispatch:low(t0)
>

If you are patching in a jump, I don't see why you wouldn't jump over
ld+jalr? (no need for common dispatch)
Patching jalr with nop, and keeping auipc, addresses the issue with
having to jump in the disabled case.
But needs either common dispatch or per func dispatch.

Thanks, Robbin

> common_dispatch:
> load t1, index + dispatch-list
> ld t1, 0(t1)
> jr t1
>
>
> >
> > > However, one thing I am not very sure is: do we need a destination
> > > address in a "per-function" manner? It seems like most of the time th=
e
> > > destination address can only be ftrace_call, or ftrace_regs_call. If
> > > the number of destination addresses is very few, then we could
> > > potentially reduce the size of
> > > <func_trace_target_data_8B_per_function>.
> >
> > Yes, we do need a per-function manner. BPF, e.g., uses
> > dynamically/JIT:ed trampolines/targets.
> >
> >
> >
> > Bj=C3=B6rn
>
> Cheers,
> Andy


Return-Path: <linux-kernel+bounces-83240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C158690AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC361F25F40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DD13957E;
	Tue, 27 Feb 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBZelrBl"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B01CFA9;
	Tue, 27 Feb 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037269; cv=none; b=hdfQAyK9NqqbFNqbNrcq0JOG7vdmX9PjEQH75qLSrOyatCpOez2wFt741gy9NiVgH22FR3akC1bXihxDUO3DquXw5U4N85yxTORFgduNjCKG2QQAXkDb4JtA986ll+93e/o+CPN3e9yGSET//qXueUfqCta2yrnQjuvV2q9MEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037269; c=relaxed/simple;
	bh=N9j9qlONozduTz+bniTZX4spLz7Dtuw1zBMBtIuIeC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAvtQ/rpmKIwFMeDnzZ0QkosGlyx7O+Vd2rOjDzTdOst3WxmIS+Jt1qiABT76JG/YSAaELO2oJXVfYUlX++PhTj6onoO3gcAJNgdgyP60XqZ33PaWo/otdvHUXtc9AeZo4f4NPXmKxiaeNiaNQ1c6q8S9P5su4GKeeMWzavUAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBZelrBl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2997a92e23bso2887446a91.3;
        Tue, 27 Feb 2024 04:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709037267; x=1709642067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9j9qlONozduTz+bniTZX4spLz7Dtuw1zBMBtIuIeC0=;
        b=SBZelrBlMCrAok/Ji5IEEIJ0HuE10ktW936bNSRp7GdMIR5e+y4QvpsYvEucM5xjeu
         mKdxLMsjdQIalqDWPrC4t2jI6azU5RQJjnWHjz9N4uTEswRgLHcDs7uHx6A2vWPRLu2x
         vYLZQb3dpdY4C8cdspbbw79YWR0oPeMC5x8PD7iQaOGd+f6WdxH16hGFJUwYUI/M/nVp
         FaagOgWF8MIchQBZlC92uGDpHeowb555aiKuff+BubVIEfdqOExTTdV83W5qsZAiVSeg
         TTttIMqUmApTIYcKSQhqSpziL6By7gLclakfPzID3zOEjzxf6FkGgYXFe3TSaC679HBe
         IIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037267; x=1709642067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9j9qlONozduTz+bniTZX4spLz7Dtuw1zBMBtIuIeC0=;
        b=uO+F8ZftviYg1B1Av0GTIAzZmaTq4QfL0Qa+xteX7YJq3dWo6IvUlWEOO0uc9Wde0P
         kQ2YEvixO+XoiMcinQlOcSC8iALGaH4rh+U9g3Iq1TYyXgyVc+xIOOug0Zlt/a+Q9c8C
         FZVdG6sEfdcl3JRFkIT44aOp6R1Ut9oJFH20hGfawK8BjKqxXMu4LsnwhzNINkROJ/Mi
         VGALXQmJPJB3pHpUI0PmXNMsSlIXrt54+zd1rLu762am5RaxSkfjHU+6llatOoEY2bqf
         EbuS4zaGvvqAU2hAFywr88BMURBhKRLdsTrIDecNf8rDuTonm1sG3gwXk7CdQ2rpIU9Y
         z91Q==
X-Forwarded-Encrypted: i=1; AJvYcCV13V7aDEi27eSWyemQ7TcL7ZpvgZK0/hzmplO14Q+UMAMg5IDpgndtRMFus1AUPFoIUxCEyFnr/OFQR41jq3XonhvNloib1UIxxFT9eUrgPzKswE2GVEmueZ27MBCVtzK8oJckBDtvAgTz1CcVkNy4NFmCwabpK7+dGGXVcs/RuxKKkgWOL4OP+Fx40I8FeQ+ErQEJGLhjnfaIM4459EM=
X-Gm-Message-State: AOJu0Yy+8ZO4uMbZebHD84QGA9riTQmoSxOKrWYoTPNcdnGsogBq2HyI
	sgRRFnt/trEac0P/cWDNK0wlSONYiyRChVEJu5whlsYpLmChf2gKsoIyF3lik3yXkE07K0aJvxo
	0rw8qnJ6smy3Z0B9mdD70W5R3ccY=
X-Google-Smtp-Source: AGHT+IEuXAPX9FOqOhNJb3Owku+lxeLjmPjbeDLcLvCF79H6OR73WYykC8gycjj0GEybh553JRImPRMosUkl+JhzaAA=
X-Received: by 2002:a17:90a:5804:b0:299:389e:b611 with SMTP id
 h4-20020a17090a580400b00299389eb611mr5540528pji.47.1709037266902; Tue, 27 Feb
 2024 04:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-perjury-preshow-fc2cf73d552e@spud>
 <CANiq72=mCnm0mKOw5K44PmZ+jF=67jxEEkcXP-E0O8CaUrps=w@mail.gmail.com> <20240227-uncertain-amaze-6197e627ad95@wendy>
In-Reply-To: <20240227-uncertain-amaze-6197e627ad95@wendy>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2024 13:34:14 +0100
Message-ID: <CANiq72=geBobqM0Dc2yv=NjAc3MWXhOrDHfuJ84TgQ+XVxBo0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: make mutually exclusive with CFI_CLANG
To: Conor Dooley <conor.dooley@microchip.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	linux-riscv@lists.infradead.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Ramon de C Valle <rcvalle@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:54=E2=80=AFAM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> I did try to test it but I ran into too many toolchain issues - my
> older copies of LLVM (pre 17) are not multiarch as I built them by hand
> with PGO for x86 and RISC-V. My LLVM 17 is from kernel.org and has no
> libclang. And then the copy of LLVM 18 on kernel.org apparently does not
> support kcfi at all. I gave up there, but I don't see how this would not

I asked Nathan to add libclang a few days ago, and he very quickly did
it for LLVM 18 -- though I don't know the plan for the others. I just
pinged in that thread.

Cheers,
Miguel


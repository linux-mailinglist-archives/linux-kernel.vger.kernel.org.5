Return-Path: <linux-kernel+bounces-50040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929584738A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099AF283922
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86C4145B37;
	Fri,  2 Feb 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZbKRPYqX"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461534779F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888544; cv=none; b=bbBinToJ/2u1CetwAWPyZGXyesZGe6m08aHqzhJM+1X+rUZlAKcjlwNNmjga6YpzxPlgNWcSDr7Dam/xfWxAYCFUo+Jui3fTYD29lyK9BK7Qt6QAxeoYrZegWMwOBOG6+r9Y/R+p17d8q+AR9uScj/zjHS+hbvL5YDlaSUZqY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888544; c=relaxed/simple;
	bh=OiGaU8y/o6fbWR5avhxnnOCplVwis+BAgwhvIPqbVFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csb1dBs4wVX/AtDG1tk6u89jkuddl7fs0hAPzF9vNloDCm7P+dU5aOQlccIpBdUnYkhBpR+7PO4jiYW3kRAbBnD0PP1uhIK6LFthfzbbtcJ4bDVUIt9eE/07sAzHRws2SO8oD/OI9Lq7Le+q4QGXqzPw+glFABjqJ2wuBZXUpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZbKRPYqX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a271a28aeb4so331195166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706888540; x=1707493340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kogXmKbjRAlSmOtOOnfMNwgduTqXGjDmhtreItP19dw=;
        b=ZbKRPYqXhs8YmPNPsVlwSfGLAZDCZHigQ/DbLGx/FyTW210IuLn6oMGYNt6HA/Q1eM
         9h/OqtdDXPKjPJ1lMxqCWMel/I7jsC31bxRwPvjs93jXGhNrJIjkHXI//jQ980s9rQeX
         MtyPx/MNAIGpEjO6sBxDlQ/kBMhaosd2fnfenhXPcTiFAa8aoRjfiFXfzehISRKD88Hp
         2LQWrAwZ/IDjJR1nJPNjiAzsQFVClKV+bexyU8FhGS/MWWiyGqwP+D9uwZrZdITG11UZ
         79zlWSp0rG3kMmV77rS1K2jmNCikR8yRoz776PpCoX0xGxk+9gJzcDANGbSvxFVJwR7b
         FUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888540; x=1707493340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kogXmKbjRAlSmOtOOnfMNwgduTqXGjDmhtreItP19dw=;
        b=oSueLKkE0F4hW7EhT0cIYcwyHes6yid2DDGviMuP2ZYR3Ev3Xta6utqUOD7GzZ10IE
         NZIB0GCndPCYl0fAzFOCF3hxjWJmp93WO/EuYl7rnrcyK0tKhsbh3bS08pbEOiTu8qng
         cX0BCIsSHPkQeCh27fVYkWFlrCe3SaSLGO7iwBZlR3LIgsltuzfKoDJJMHxzz8z0g2cI
         +Giob871CqlDKB11jiEziJHtK/sfS/MS4gtKuAp+MgIXAocOV4VEhH5WTkAOKjlChoRk
         myjXn+KXtLLCCOncZ6vKb2d1vX/CCars08jelE3N562bCY2aj3zWUBqw2WARLtG0d41u
         xOXw==
X-Gm-Message-State: AOJu0YxCTSQJz0ropBc6tKj20nRYYw45OeA6SXhGP79VzP2fsIcIZp4i
	ssOF+CUbbGvrlkRk+kMHVh2lAhC2NDhM3e387s376ujtrTj/Egh7zHHUoVkHfiVtAfye2INRrkT
	lY8b+2tBMEf3vg3mhOMet0v1+L0033AWWHI+92A==
X-Google-Smtp-Source: AGHT+IH/zecNEC28nmVGlGmSbLynz6gk5o5sKPfDBpuJdaR6b+rS66s9/R0EOFKWMVOPLIAlSXsBwV7AsTvhcGsm6n0=
X-Received: by 2002:a17:906:538f:b0:a31:8ca6:dbb0 with SMTP id
 g15-20020a170906538f00b00a318ca6dbb0mr1676412ejo.16.1706888540289; Fri, 02
 Feb 2024 07:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131155929.169961-1-alexghiti@rivosinc.com>
 <20240131155929.169961-5-alexghiti@rivosinc.com> <Zbuy1E7mz9Oui1Dl@andrea>
In-Reply-To: <Zbuy1E7mz9Oui1Dl@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 2 Feb 2024 16:42:09 +0100
Message-ID: <CAHVXubgw0PEZMhFmjA0cAFQ2+_JOYjVfk41qRC9TFdSJtej++w@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT v2 4/4] riscv: Stop emitting preventive sfence.vma
 for new userspace mappings with Svvptc
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>, Dylan Jhong <dylan@andestech.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Thu, Feb 1, 2024 at 4:03=E2=80=AFPM Andrea Parri <parri.andrea@gmail.com=
> wrote:
>
> On Wed, Jan 31, 2024 at 04:59:29PM +0100, Alexandre Ghiti wrote:
> > The preventive sfence.vma were emitted because new mappings must be mad=
e
> > visible to the page table walker but Svvptc guarantees that xRET act as
> > a fence, so no need to sfence.vma for the uarchs that implement this
> > extension.
>
> AFAIU, your first submission shows that you don't need that xRET property=
.
> Similarly for other archs.  What was rationale behind this Svvptc change?

Actually, the ARC has just changed its mind and removed this new
behaviour from the Svvptc extension, so we will take some gratuitous
page faults (but that should be outliners), which makes riscv similar
to x86 and arm64.

>
>
> > This allows to drastically reduce the number of sfence.vma emitted:
> >
> > * Ubuntu boot to login:
> > Before: ~630k sfence.vma
> > After:  ~200k sfence.vma
> >
> > * ltp - mmapstress01
> > Before: ~45k
> > After:  ~6.3k
> >
> > * lmbench - lat_pagefault
> > Before: ~665k
> > After:   832 (!)
> >
> > * lmbench - lat_mmap
> > Before: ~546k
> > After:   718 (!)
>
> This Svvptc seems to move/add the "burden" of the synchronization to xRET=
:
> Perhaps integrate the above counts w/ the perf gains in the cover letter?

Yes, I'll copy that to the cover letter.

Thanks for your interest!

Alex

>
>   Andrea


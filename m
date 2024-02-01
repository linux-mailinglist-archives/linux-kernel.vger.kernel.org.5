Return-Path: <linux-kernel+bounces-47551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86187844F44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACA51F2BF44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3843A1AB;
	Thu,  1 Feb 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4M1o1jf"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2C39FD8;
	Thu,  1 Feb 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756346; cv=none; b=pXARCwLyVbtATYcsfHrgfsvNI21ZJXNd7nvDEvbxPjcpwDLXjpQXDq7GhDgtiYuRXtBE4pebt1t+E7T7Ovza7PEF14IRCfBZB4fFsPQ5IpS3RM5iHH/s7gq7xDf2le/YhYhXWtzdAZy9NyoGZ3FugzEUE9/6M+mrz9quTp5vb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756346; c=relaxed/simple;
	bh=ZMY5v0iedCBTdeMF74iUuLp9UhUF3Cl+Fp1XwNAGpK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKZUJx3lW/ty/AWWL8u2A/IgQDGiHkS3FpQBWPTmUsBv5osIpa3VzmvlI9NK/z6xugNfn9QY+RZz4Ay3wYUX9Vvh/Hm6axVIsOeybCQid723KKpsSHRNGaIQvW15nGYTjzZxXc7G9/rP/SgXZmSMsbAWAX/85rP7oFZHmcpj4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4M1o1jf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51032058f17so488868e87.3;
        Wed, 31 Jan 2024 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706756343; x=1707361143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CpLZHn3p6Y5uqROAkr3ACzV/aHb9p+4CqdQVObwG5g=;
        b=U4M1o1jfG0hGKwd3jFYuWyvRRBizn4SQVOmV9DkHzFj5Lkz4P8qivF5hILZP5K+B8j
         cDFwvb2J7Py4BVUBeh01MjgbYZiqICpiUgCFXOc0vWzIGw/T+4g0r5V/mUl/1FR+nZKQ
         4D7hxYjJNGX/tdC4K4Y3WtbJrKyEdpKEP/pvZn38Y6r84p8cgtIjx2yVqgXs+YAFdMTf
         35urWe13kLTjjH+gJ2C+sadBuJpJ6s/zHxzvEwaRixsUWIsWN4PonvBirP5jfMQ5d+4b
         qKET1PXgBByMF8vSp5DelSEc2SUb8fHNPOfBiEpHQPEf/qjuf8n8f/yKuQMRpAL9oMiU
         WrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706756343; x=1707361143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CpLZHn3p6Y5uqROAkr3ACzV/aHb9p+4CqdQVObwG5g=;
        b=pt8Tv5QRT+tj3nldXM1HDEUYY19gC/k3U3zcT2QPD3TowD2VnwIKwu0ui9IBe7yLa/
         haEiN7OrzDtE4FC4mgc3H2P1CzAU0lm7eQxVevHeV4nS+y0HpvjosI8+lfTVAdlwubgr
         3jj+JcbA0Stj6Vo7hTYkG6q6ssNo2jPXsCxxpBXF5YEZIeDNMLhRO8DnJFg07wSTSen9
         k8D5ZMg9BdhUGoqfMjQt3os03lYyFyO1dC/MpOsVe/94AYn0xp3ULuDmDA1XRWQgi8Ho
         XNU04tXsaqBMRvhEEUUbeXP87ZRJ10iSoGJX1+6A4xT9Zve6g30EcWtc3Xyr1ZhsHC5e
         C4tA==
X-Gm-Message-State: AOJu0YxzNvJX8Oz8ZqRb6yuVnmyflEN3AnULtWPxUR0glRcfLta1Rixv
	2mL4NKiaZglysVLq6MS43je8zcBkr1EkDJQ9x1yMLuh9o3H6H05+pZ/K0TT639CPGJSjg/k4rBL
	oXE0iBovEs7G5E6/VyECu8Sm+1vU=
X-Google-Smtp-Source: AGHT+IFqBWvZMFSoe1kdbaLQ4YMXumTydevNBtADzyVBBimPtohOhhboE3z66Jft4SF2LF6fmofYSXZ8L/E6AOgsCdI=
X-Received: by 2002:a05:6512:3d04:b0:511:2e99:c03 with SMTP id
 d4-20020a0565123d0400b005112e990c03mr439801lfv.8.1706756342679; Wed, 31 Jan
 2024 18:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
 <682f037e-0efe-4d73-b867-f1f86a244836@app.fastmail.com>
In-Reply-To: <682f037e-0efe-4d73-b867-f1f86a244836@app.fastmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Thu, 1 Feb 2024 10:58:51 +0800
Message-ID: <CAJve8okV_9qs6urESw2N-v8LT2-QP40jc1WhHYci7n-r9EoA9Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haibo Xu <haibo1.xu@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, "Conor.Dooley" <conor.dooley@microchip.com>, 
	guoren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
	James Morse <james.morse@arm.com>, linux-riscv@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Len Brown <lenb@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Tony Luck <tony.luck@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Samuel Holland <samuel.holland@sifive.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:33=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jan 31, 2024, at 03:32, Haibo Xu wrote:
> > diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> > index 849c2bd820b9..525297c44250 100644
> > --- a/drivers/acpi/numa/Kconfig
> > +++ b/drivers/acpi/numa/Kconfig
> > @@ -2,7 +2,7 @@
> >  config ACPI_NUMA
> >       bool "NUMA support"
> >       depends on NUMA
> > -     depends on (X86 || ARM64 || LOONGARCH)
> > +     depends on (X86 || ARM64 || LOONGARCH || RISCV)
>
> The dependency is no longer needed now since these are
> the four architectures that support ACPI now that IA64
> is gone.
>
> All of them also 'select ACPI_NUMA' by default, though on
> x86 this can still be disabled by manually turning off
> CONFIG_X86_64_ACPI_NUMA. I suspect we don't actually ever
> want to turn it off on x86 either, so I guess the Kconfig
> option can just be removed entirely.
>

Good catch! Will revert the change in the next version.

To remove the dependency entirely, I think we need a separate patch for it.
What's your opinion?

Regards,
Haibo

>      Arnd


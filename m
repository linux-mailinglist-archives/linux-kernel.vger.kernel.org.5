Return-Path: <linux-kernel+bounces-95205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32B874AA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41002870D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9797E83CA6;
	Thu,  7 Mar 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV/mipkr"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A203633FB;
	Thu,  7 Mar 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803207; cv=none; b=ArBgPwg77hDMR41fjH08/lcRUXXMoQOtH9fhNpZyIUjG5d7Msc0b3xjK+pA0RumZkHzTbKsTqgkAgWBgdG8NtYoAurr1uUvVZMjMSa1/nsMgK3/FgGBFG8FePQXLl0Wp8eIMY9iI1Gx/0Jd4oeJvExbBupj8WDnsHWTrpWnvygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803207; c=relaxed/simple;
	bh=4Gs0ALlJoow9J74owFD4al5jtj3RvYpvgtJMBToY1hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVpR+xM69WcYGy8Ruq9lPnIuMuWjVJ5hkbJ0VwOLN/bMQZ2WHxUzBKb0SR5nFOLm1x2Y+WMcQdF8nCpRoPT5Mpy4CULkO7QEHQWFpOBcsdaTazdiAKIrkN7IsHgTxLGME/sZxuEN1vBQa7FyVvTwFbDe7NH3qMbb1aCe+KtQIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV/mipkr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51381021af1so376736e87.0;
        Thu, 07 Mar 2024 01:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709803204; x=1710408004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80RTQxeG1HoYvnNvzrKo401rks3qN8X2iKrIw4d9yaQ=;
        b=kV/mipkrJ5hGtmUOqBOilJsp80PTP1Zhbj94lAJVLxiMqJDECww2Ojf9OwJPDODbQm
         KIZe+hz49wjhUkyF3uORUpvpg+Y+dO0Y9ZiCFP4C3G5Mp+pe7a8yh+bKH5EM9P0OxEi1
         XJz1VwXfLYfUy97ZpehHjg0fgNZGzbKCUvje1KHgb1HWvhWMOYbTALP2DXnD7eEOC4X/
         94RwO1gjV64RxPC0igFbk14XJd8OfsF/OOrpU0Qju+3WUM2z+kF66ZK/0A59lS8qiNrA
         l+GKV5AD7cWx/gbqG0nHqGPkOGyNUipANNjZ18nGJOhaPgjvOuMJ4wTKPaKmuYGbUiGd
         1lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803204; x=1710408004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80RTQxeG1HoYvnNvzrKo401rks3qN8X2iKrIw4d9yaQ=;
        b=pPnnftxM7ywgT41qh+yVjlYAj5FwHl1GBzdODfN5sc56kNruLMVW/f0gN1LP8XABjb
         cFYmSS63EpWhgHawirx/stC2L74Or0lWWA1GERpal4gIBSkRn0RAPf3sJXzMByzt2EQm
         l1DY0eZiCZ5OuT3j9RvruCQoPnbDOqpCXC9c2lYJzS+eeWr6qUI3swlEcArxsCPgwGKI
         umKwENyGQ/yofR2a+j/qUWbJWbaNV3M3EJZLZPqs2lU9++hs+EkEYn106g+SH2QO+8VL
         KKPsjBPrItl+ZNrAU1eYIRQSA6awLnExNOKRfP4Xbau3lNnanu8HPhAOhJ53vmFiMYJg
         njPg==
X-Forwarded-Encrypted: i=1; AJvYcCWCb5zDG/qIxMWBNY9DqdR/NW4t3+OIGjvKoEdIc8FX1b1DvOHRAOBZWFq4B7nSjL+FQSwxAH5YDZpcHksvhb6FeFhK4W6v+h2gs3zQZgUYcKPaFW7AGFID3L/G6TbspGoA3ccn4xU+cQ==
X-Gm-Message-State: AOJu0Yx3STOP4VRn8H0trZf91HvZrBGO+7BQFl1M/l1gfV6mXgMS1H2/
	NJa/eOScDJD+5x1h7e/4aICHjHblOQq03qn98twiK0vQMluxqSOMyQ4V2EX3bUkDQE2r9Z+CB6x
	1L49EAroaQ1VrF5CWPGZsSDnIuxA=
X-Google-Smtp-Source: AGHT+IEe43Gp9xWf88EuXib+ywhG0E+gf0UnlcztjMhnwdiDupBKxPSSYhqii6oCxJLhS0kHoQOREXn5DPA0iSZD7b0=
X-Received: by 2002:ac2:5f87:0:b0:513:6632:2f62 with SMTP id
 r7-20020ac25f87000000b0051366322f62mr1049502lfe.7.1709803203752; Thu, 07 Mar
 2024 01:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <f23da383a8fdbee15acd41fdcd38ef3a89045a43.1709780590.git.haibo1.xu@intel.com>
 <c9e9da9f-ff81-48eb-beec-4f54921cd268@app.fastmail.com>
In-Reply-To: <c9e9da9f-ff81-48eb-beec-4f54921cd268@app.fastmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Thu, 7 Mar 2024 17:19:52 +0800
Message-ID: <CAJve8o=BsR1SG0k_7mb61Jj1fb+9rc4V9Y=MMX004fpAWE4vjg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: NUMA: Remove ARCH depends option in
 ACPI_NUMA Kconfig
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haibo Xu <haibo1.xu@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Jisheng Zhang <jszhang@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	"Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>, 
	Zong Li <zong.li@sifive.com>, James Morse <james.morse@arm.com>, 
	linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Baoquan He <bhe@redhat.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Tony Luck <tony.luck@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:44=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 7, 2024, at 09:47, Haibo Xu wrote:
> > x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> > would do the same thing, so the dependency is no longer needed
> > since these are the four architectures that support ACPI.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  drivers/acpi/numa/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> > index 849c2bd820b9..2bf47ad1ec9b 100644
> > --- a/drivers/acpi/numa/Kconfig
> > +++ b/drivers/acpi/numa/Kconfig
> > @@ -2,7 +2,6 @@
> >  config ACPI_NUMA
> >       bool "NUMA support"
> >       depends on NUMA
> > -     depends on (X86 || ARM64 || LOONGARCH)
> >       default y if ARM64
>
> Can we remove the prompt as well and make this a
> hidden option? I think this is now always selected
> when it can be used anyway.
>
> If we make it
>
>       def_bool NUMA && !X86
>
> then the select statements except for the X86_64_ACPI_NUMA
> can also go away.
>

Good idea!
Shall we include the ACPI in the def_bool definition?

>       Arnd


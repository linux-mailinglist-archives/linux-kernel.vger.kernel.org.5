Return-Path: <linux-kernel+bounces-126506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3268938CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01E41F216C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48BFBE62;
	Mon,  1 Apr 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4Fe9muz"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54962B67D;
	Mon,  1 Apr 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958669; cv=none; b=k2pM/4bjN4mb2CcmsunxFny/SWdAwbcnuCam/1iOC6ErYRgTNhE8iGir/Id0gG3xl0dibEwadfXrtV4Bb6WKoBK3D4hnec9OzQ36HMBKbF3kVvlwGFlh/Yl1lB1PutwKEhp4GeN0kl8gNxkWFUultdk8+SQmeINsnS0IIqjozzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958669; c=relaxed/simple;
	bh=MqCZEthzj+56GwiyzSk1Iz5eNGmS1DlYXJDS/UbVRh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwF3jpg9dpmk2E2zecpfj7xaC48NtsuIETLn0PznISP9ZQXUP2HrmsmuwMxKOviewulsOiiaL5mT8HlLWT+OtLTW6Ab95ONQrcZhrl45ithA1eC+piEcYx9OEDEJU3IJBugULYr7MdcLt83BuBs/VY4qfkNVnyL6YjU8RkTT5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4Fe9muz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d717603aa5so33834171fa.0;
        Mon, 01 Apr 2024 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711958665; x=1712563465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIPBLDUKvVlC/efDjwEAjrOmS6XB1w+iWO2tkQJfZSI=;
        b=W4Fe9muz/t89OgjDr4tSOSNXxRQI1HzHpagyyggN4KLf/DfBe1bRRZdfwRSjfQuBx+
         LYfxHsG6W8nT+3EL60fwgpUMiou5tCD+iU1arExVINsttOJXcyGtkoLMUnuzrVNY7jLN
         PDEeMFx8wy1eiH7TvtV3aU+gaY8xmSa4ku+MhBpIUE200K/b8Cn9jubDj6PAAUSrzR0A
         9MOqiFFV9lsob7ypY+I/+odIDbCVk3Hmf1M7l2OW+xsMcY81hVn5rAyDw9MW2V7uSWfS
         ro5BKVPAljvY69+jwknI1JDmz01qHtjMSHJy9PUYz2Vn1Udx2aRzyhYYYkkJDRa4SR39
         CS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711958665; x=1712563465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIPBLDUKvVlC/efDjwEAjrOmS6XB1w+iWO2tkQJfZSI=;
        b=rCvu1or3RcjPz9G99w9c079KTxxU3j4ojih2mLuZT1blz1+pV44Wi6si8s2PAyY7sm
         7ORJ/0WhRUHVhtUHYJul5RJjF8wkWRcQSmYn0fJxMBN47pB9832OPgNZjpBmqrvz+yTC
         EbUtQVGshaMq5yWvXi3hP23HTgsDTj9zheLGU77yG0uEfc3+wpe/ocKpgWg+a8TrX1Dv
         CDBX1Bb5PQJMy/KeudM5R1jBmg4vWdx7+D8EhRwJaI3Qtdbw3sL38Ndw9LsazLmukBHq
         cQ06dLTI1vWBByKKxTSM/EtAeQMfME+vhZdyA5NVD07z1BfVSFyfrZdEWd6lGXEzqawz
         3w/A==
X-Forwarded-Encrypted: i=1; AJvYcCWOyjWaJl5d2RExVIYW5uTE6u3fWiE2K3wvVztx+yNV3I8F4iQrDaUt7ZiXasfLgN06Ms0XgezbNzLD5x5XxQcLfCTo51FEwEp78ghkaoEhLnbHhdsah1PB0vCNsSovry6KpbNGTqmwkg==
X-Gm-Message-State: AOJu0YyLaTX1zTCEPTWJdIgbmgheVDRoQfNgy0DUsLKdEW7r/MrwnY36
	N73onJf2FoXdVlfst+aeiH516qkGTwBS+xBmt2Yytcw0w+l62q3TMELb/lXIw3hvg+GtIjr5/yH
	XTHKOaVmQlNlCjO4egfVQHPWXvEw=
X-Google-Smtp-Source: AGHT+IF6MZSEh0qpjHWy2tctMPsCT4wg3Q6kZZ6mM8KnuUoKqHKr0TeNgyq+KgbADsJN1HMt9yrxPapQuQRzM4rXDtQ=
X-Received: by 2002:a2e:9141:0:b0:2d6:f085:1f64 with SMTP id
 q1-20020a2e9141000000b002d6f0851f64mr5832377ljg.48.1711958665425; Mon, 01 Apr
 2024 01:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
 <Zgpf0rqUSEZcSiAV@sunil-laptop>
In-Reply-To: <Zgpf0rqUSEZcSiAV@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 1 Apr 2024 16:04:13 +0800
Message-ID: <CAJve8om9-cTtYKLmB0R=6Wwh5KQ9z+16AFR-tuUkJhJjbn0UEA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Tony Luck <tony.luck@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Alison Schofield <alison.schofield@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 3:18=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> Hi Haibo,
>
> On Thu, Mar 07, 2024 at 04:47:58PM +0800, Haibo Xu wrote:
> > Enable ACPI based NUMA for RISCV in Kconfig.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0bfcfec67ed5..0fb55f166701 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -447,6 +447,7 @@ config NUMA
> >       select HAVE_SETUP_PER_CPU_AREA
> >       select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >       select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > +     select ACPI_NUMA if ACPI
>
> If the firmware didn't provide the SRAT/SLIT on ACPI based systems, then
> there will be a message "Failed to initialise from firmware" from
> arch_acpi_numa_init(). This is not specific to RISC-V. But I am
> wondering why should it be pr_info instead of pr_debug.
>

My understanding is maybe it just wants to expose explicit logs to
avoid any potential
bugs from FW or Kernel.

> Thanks,
> Sunil
> >       select OF_NUMA
> >       select USE_PERCPU_NUMA_NODE_ID
> >       help
> > --
> > 2.34.1
> >


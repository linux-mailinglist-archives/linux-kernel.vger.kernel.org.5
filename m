Return-Path: <linux-kernel+bounces-134138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182789AE23
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AF81F22393
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE41879;
	Sun,  7 Apr 2024 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezwHbvK2"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013628EF;
	Sun,  7 Apr 2024 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712458416; cv=none; b=FCQ9iDS9NOeDGVgQwsdR8LS7MDBazGja1N3bcnL1TOhkhcWxVjmlpXzPIrYK2f4joaWbTRXYCQZAXgyUPlPNmV1m86lV5uhy9EtS13aVYpWPDmsBQwVPtgylzFKjjMTD9XgZqiaG8Rj8Pj+m77+T0wTG+HSduEWQSosZmFZqhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712458416; c=relaxed/simple;
	bh=7eg5LJVoCgGpvIy5viIhvb7qyO28VADsvG9BNbWNZpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcAQg8UL2rp+FTZi8B3rR+WESm3GoCCvsx8rQ2Xjt6p7bHYLeYt0RFzOgdZNNE2p0MIMICmkNux7FCMZb3r4NiRwx7t62frhLBeeKl/SYUiykMDj58iH0X7ebt+mdG9bvhFjMkGYy4tjjZ8tIQ097tIYahQWZzdlI+HnGRjTlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezwHbvK2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d2600569so3208168e87.0;
        Sat, 06 Apr 2024 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712458413; x=1713063213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eg5LJVoCgGpvIy5viIhvb7qyO28VADsvG9BNbWNZpc=;
        b=ezwHbvK2z3Ies88uVdztheUknfDm0oemzV5c0lCXXTApq8MQkEN3J6ktLQ3P/qjfLJ
         zE3Uzt/RiwFN13tgZa5GdGdcT6IMoI0X2HIFiX+Jt1r+VrdOgjdRJRFlA0cimEjzJCZK
         6J53prB+blcvew4n8hSZ8LAEHkhnoDRUCKUE0ma6EfKcU08tA3+HkBfn8aJyhuv6d3LZ
         fVnepi2Q6BDxufm/yWQbzN8w4lhy+RdCoZ+G6C3/T8sXwbu5cmsCk8PDKdTiiXffCPrq
         947gcl2k/BR+MAo3Yw24GzEUHIh7OBleHsVwj9IgTsSVEtW+CQoRY6aiMHn2EJSSrt+8
         3IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712458413; x=1713063213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eg5LJVoCgGpvIy5viIhvb7qyO28VADsvG9BNbWNZpc=;
        b=iJ2lQCNKM82rph/oDnASaeEj9AMThoA6qScbiALy3blxzcPLA3j3AMy9MeiGkcQhMI
         UhvP4LW1AmZq5tMm4xixiKn0L8s6gTDa939pUw4uHTE3bXHxNOVdGYL8u8e9c3yOGhgV
         yx0/xTXUUFngaLahf3p2A2CbpIFCpFdSNUGx1haoafK4xls5iDOl2u0wyFyMQ7XYOBvT
         xyWQSYzI/Be1uOTE55z01H74/CHcJiVg49tlpQxmjS373XETAmlbxSiiVgAscYeiTqZy
         yl6QqW+DS8L6kbtOU3iZ18PeWd45f8Z0PbeaYaUiilgsY0JUwKsEmuKGTlm7TA/uD5ih
         yLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXzMVR7+41Usu2nYZkviyeExYnfmhHJnZV3s+zdfUyLvPo0HXyg9a0pRc82tWxuSBdqy/Xd3iGydBwURQcZ4I9cKxnvb2tA5vULWrb7MOyw4DBtt4Qnxx+uC6EqICPIbbfw/X1uGTuyQ==
X-Gm-Message-State: AOJu0Yy0cF1Ty4IiA9Kwzrjp5Qnlwgm9fPMJ/dRbMRjXAWxtLC4fs2C1
	Y6HxxdJVB9EWBlMFrcMpxcdR2u1WGsloGWrnswoyWQfQGAPxTJTMvkvfhYe65aJ+BJ13blXJXD/
	ShCH5roeywS7DpP4pxgZIxz95xCc=
X-Google-Smtp-Source: AGHT+IGPNaBY7p9jhIbr7kM96+qmULR+lYEMhFuh42Rbxchab60jlMaC+Feq12fbmoMqIEL4NxFEm18CO0ttHSM12Dc=
X-Received: by 2002:ac2:44b7:0:b0:513:cf75:2ccc with SMTP id
 c23-20020ac244b7000000b00513cf752cccmr3762064lfm.0.1712458413059; Sat, 06 Apr
 2024 19:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
 <Zgpf0rqUSEZcSiAV@sunil-laptop> <CAJve8om9-cTtYKLmB0R=6Wwh5KQ9z+16AFR-tuUkJhJjbn0UEA@mail.gmail.com>
 <SJ1PR11MB6083B43290D216B1568642B0FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZgzS7W83iWRII73G@sunil-laptop>
In-Reply-To: <ZgzS7W83iWRII73G@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 7 Apr 2024 10:53:21 +0800
Message-ID: <CAJve8o=VMXGwgGKQJvXiBXFLpqt+afFTG0vFvW-bTguzY76KMg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Moore, Robert" <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, "Schofield, Alison" <alison.schofield@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:54=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Mon, Apr 01, 2024 at 04:57:30PM +0000, Luck, Tony wrote:
> > >> If the firmware didn't provide the SRAT/SLIT on ACPI based systems, =
then
> > >> there will be a message "Failed to initialise from firmware" from
> > >> arch_acpi_numa_init(). This is not specific to RISC-V. But I am
> > >> wondering why should it be pr_info instead of pr_debug.
> > >>
> > >
> > > My understanding is maybe it just wants to expose explicit logs to
> > > avoid any potential bugs from FW or Kernel.
> >
> > There are lots of ACPI enabled systems that aren't NUMA (single
> > socket servers, desktops, laptops). Making this "pr_info()" would just
> > add noise to the boot on all of those.
> >
> Exactly. But this is an existing pr_info message across architectures.
> My suggestion is to add one more patch in this series to convert
> this to pr_debug unless someone has strong reason to keep it pr_info.
>

Sure. I will add a patch to fix it in v3.

Thanks,
Haibo

> Thanks,
> Sunil


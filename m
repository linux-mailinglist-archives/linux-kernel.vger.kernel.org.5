Return-Path: <linux-kernel+bounces-91825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD3871728
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FA31F21FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220947E792;
	Tue,  5 Mar 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar43aHtM"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8E7E59F;
	Tue,  5 Mar 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624568; cv=none; b=CJKzLpEuaHSQb+1imEbE+AcaRJUkKL4yK/J7KDhk3Sa62MI0oOUSrAtO6aZtN8XwZhbQ+nVRhAaw7ZLF0BEcuiQtywWkcEt4NgLJFcxidEENssSQPx2LLLTjv+otMlJ2pnKmxy0zS/uZmzK0wpn7aoMh3WIRWZ17QUtxXs/ixgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624568; c=relaxed/simple;
	bh=1yacK9hpiPuhyJxzTeAxFGss0ekxT9wkeTcOYVFT5O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcEdjm/GgziEzb6JEwKjeN8HEz/SCiE3GNEPKJZR86n25Veq2NRBOE5eejG/0m/tc/kf/ij7txgVuShomENobYBmWHLx8BLk3aYMGdVLrOnGtQEJGnytEIRs92f46py91j9y2tvx6v8pXrrBcrYy76jCfXq2qtenZmJPAs9Xmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar43aHtM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d27184197cso73951831fa.1;
        Mon, 04 Mar 2024 23:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624565; x=1710229365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yacK9hpiPuhyJxzTeAxFGss0ekxT9wkeTcOYVFT5O0=;
        b=Ar43aHtMqGeCfN+f4bGpxxjm0YSfrfFE2gIE4bzf7y8NTgnup1QlKY34z6uGps2aLS
         XAAjwLIVLR9/ZXtFE4wxQAr24hu1JDY/wuNL0mpX2xcGIC/kw6GmUhDr9UCI40BVyE3Q
         4bXGcuVdGCUQEHqgxze+QEumRI/AwRYkdOCNktK20QZh/mo9CJHLGLQIIybQ8Vzl36jD
         Xb/ZVzA2r7Rk4lpOtA33pkbqwpn0wZt+ULkwP4gkOtPkKu+CUxI0kZEihnUkvdLhpf/X
         TcA+vC2X+Y7m5bIgAwRJQaL+bskL0wInt5pcPOJTtkjeHUjEWgi+mPAFoFTnkY2Cl06C
         wO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624565; x=1710229365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yacK9hpiPuhyJxzTeAxFGss0ekxT9wkeTcOYVFT5O0=;
        b=BMbJPW63jtpF168cBaedVwZI8SDkfQlDwcDM5a+ZhvbWXFxe+fwO6dkq/4F5DWbCEr
         rl/hwJYzxRLTMymPDMGPIWQFJhK1y/CfM/qJAa9j7btJc9VOj2WX0suJl7lh8bQ9DE0Y
         xadOLj1SHULovzj+OPCHNMFuEm0l77bHF4ebx66gM8bEQ3xHBwoQBCDIu15We+dA2n41
         Jefr74uysXZk57UuZH8vNfSwsPiiE3sX6/57LDyD7s9iWAk/gdgczT9Y1MjcQw2EVkE7
         8G+cTjfO4fmvyMERngWZXpyKr6Gt3HgJ+FSOUs9Tl91jkLwhgChcyey8mmxEBwMb0WWc
         W/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnLYkri3AaecojjYWPV99YKCdvhPm5BAAUTYbZkmIiSfRd8g5Ta4OnUmF4RxfOUjna9UrUo+LFKUEucczrzo89tUqRGo54Hu6NJx7mOx+RrTpjb3YW6qKRlBgIGFU+q3cHJApXqxEfXQ==
X-Gm-Message-State: AOJu0YzwvQ7OXEinqL8+2jE8XLea2Lp6V6pE424R3CQpmk7mF/1FqgjA
	K75p39dy/YZcb9KuKP74WytHg/dp4+ArDP6v/z05luEptJh4UgImvAGtJD/GZTFDS45U1R0Hk5U
	yS8z0Lyvt8qf4BBsUTWGtZW/42LI=
X-Google-Smtp-Source: AGHT+IH3ogEE3gS9kmBu6JCdtMvf/PW5rL/fmSyuLCQWSV1sV1Mmkgo71z6sH2+EquAbsW+oxtRPML/1nmNxh73v3b8=
X-Received: by 2002:a05:651c:1683:b0:2d2:ef14:593e with SMTP id
 bd3-20020a05651c168300b002d2ef14593emr506670ljb.48.1709624564715; Mon, 04 Mar
 2024 23:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <ZeajHkn6dTQ3krsL@sunil-laptop>
In-Reply-To: <ZeajHkn6dTQ3krsL@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 15:42:32 +0800
Message-ID: <CAJve8on1B7psLYX+Qei0Uxc=GbrGYq52OqV+ZFND9PkPMnyj=g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add ACPI NUMA support for RISC-V
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:44=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Haibo,
> On Wed, Jan 31, 2024 at 10:31:57AM +0800, Haibo Xu wrote:
> > This patch series enable RISC-V ACPI NUMA support which was based on
> > the recently approved ACPI ECR[1].
> >
> > Patch 1/4 is generated from the acpica PR[2] and should be merged throu=
gh
> > the acpica project. Due to this dependency, other 3 patches can only be
> > merged after the corresponding ACPICA patch was pulled into linux.
> >
> > Patch 2/4 add the common SRAT RINTC affinity structure handler.
> > Patch 3/4 add RISC-V specific acpi_numa.c file to parse NUMA informatio=
n
> > from SRAT and SLIT ACPI tables.
> > Patch 4/4 add corresponding ACPI_NUMA config for RISC-V Kconfig.
> >
> > Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
> >
> > [1] https://mantis.uefi.org/mantis/view.php?id=3D2433
>
> Please avoid providing mantis link. It is not useful for people who are
> not UEFI members. Better to provide the link to the PDF version of the
> ECR approved.
>

Sure. Will update with a PDF link in v2.

Thanks,
Haibo

> Thanks,
> Sunil


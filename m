Return-Path: <linux-kernel+bounces-61889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D358517E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D471C21B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347453C486;
	Mon, 12 Feb 2024 15:24:32 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F53CF40;
	Mon, 12 Feb 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751471; cv=none; b=mxcHWkz85+nMnY9+Kyaqitw9KpGYWIWvu4ub1HcUNOLT0ashn7wwijC+PMTxw+6qzefCLgsBmDhePQYY8qZvNXKAaA8+G1uFNg9ialA2R8b5Eqo1/ICwLAYP8Vf+LIl5XKpCQVrtmiI4Gud5M1UHP3LuhdBvsREM6tGSZPO1PnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751471; c=relaxed/simple;
	bh=VpCef5ymTjZWlIhHOT7IU7kvqkqh8Qp8J5J+bFuTgsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxuH843RKoGrjKxAsvoU3W/A9BcNZwSpgVwl8c5kwNAS6b1i2RypYkT5vDEFzCd9FIUpYRRfRvbeP9N44ZpP0NQPcSFB+S/eDOnIgie4GYygiqysqfnj+HkthvDGJbcPJbXKULJhYjcelqOqfFiXakCkEuevxG8ELlA9sAxoj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a134e29d2so598433eaf.0;
        Mon, 12 Feb 2024 07:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751469; x=1708356269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX61is9XJ+iwyxtpB9egcIfV20xyVh4UfYvVFLqfQe0=;
        b=e+g8gSPjLoSlmkfYwfXNHOL3MRjWLay/hF5bjjAPwHxYJXKPFj/QVCOBianZCvKOcM
         J9Sa1SI/cg44dWvSPQJrF25mwL9Z+DMprFHJaLvlwLp+9rOWWXt1ZRvJQkfNRQTD95Xk
         4JM6ZuYd7sNlxsJWQarRI+ONmQccMFKsZTNJWlRvevDvZvRbIYb39f4eSAwWgoZNTpku
         r0XFlr4oJY+T5Gh1MXnOfTN9Z33rrF9qTeCDGBw9kCsp4nlntmFyH96DofwQvjvFoyTG
         kKqT0y6c8nYEGa5mStNb70Cas36s2fFgke5QLYEO78UDqgHQPdS9/sT2Khbyr0QBnb2R
         fdcw==
X-Gm-Message-State: AOJu0YyhVcjv7eBUlMo9BxEhhIBptGFimzd9EflVQgIPo/UOQlmCWhGV
	z4p7GMtSxxJcE0+RbFenFbMvtxHH/aWBQwGSXBPkgSLdSPPsAHZgzlEUkE21YdqG1UnyFZB3Nh1
	wzw+tH/Amb6WaPs3ymePa1wXEBiY=
X-Google-Smtp-Source: AGHT+IHpuXZxCAVszuhp+l0/3Fc85RyOxNFeAKPWhOMAJXcjXJmBrWeeUmfdxx9w751fPRZuQ33ZkYvvTfpnF3DY0Nk=
X-Received: by 2002:a4a:3502:0:b0:599:fbcc:1c75 with SMTP id
 l2-20020a4a3502000000b00599fbcc1c75mr5321083ooa.0.1707751469357; Mon, 12 Feb
 2024 07:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240208034414.22579-1-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 16:24:17 +0100
Message-ID: <CAJZ5v0iwV4mG40hbhomrTgiUoUpn_ocNH_5K84yseSpsZtviVg@mail.gmail.com>
Subject: Re: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 4:44=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> This series enables the support for "Collaborative Processor Performance
> Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> encoding of CPPC registers as defined in RISC-V FFH spec [2].
>
> CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this, is available at [2].
>
> [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Cont=
rol.html#collaborative-processor-performance-control
> [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v=
1.0.0/riscv-ffh.pdf
>
> The series is based on the LPI support series.
> Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicr=
o.com/)
>
> Sunil V L (3):
>   ACPI: RISC-V: Add CPPC driver
>   cpufreq: Move CPPC configs to common Kconfig and add RISC-V
>   RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ
>
>  arch/riscv/configs/defconfig |   1 +
>  drivers/acpi/riscv/Makefile  |   1 +
>  drivers/acpi/riscv/cppc.c    | 157 +++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/Kconfig      |  29 +++++++
>  drivers/cpufreq/Kconfig.arm  |  26 ------
>  5 files changed, 188 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/acpi/riscv/cppc.c
>
> --

This is fine with me, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and it would be good to ask Viresh (who maintains the CPPC cpufreq
driver) for an ACK.

Thanks!


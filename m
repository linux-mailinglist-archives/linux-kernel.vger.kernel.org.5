Return-Path: <linux-kernel+bounces-104400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358587CD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79E0B209F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B0249F3;
	Fri, 15 Mar 2024 12:32:09 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12663D76;
	Fri, 15 Mar 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505929; cv=none; b=tkkm9pxuuogYrLISp5hvsueTnVdZRTWrNPPOlykoU6844v8ESj4asT1qz0I2XH37Hp2MhmHyygK0Dt5zkZ2RNGHiTzTkAL6ZZd3McHichR+QmK22qudFP24j9gz2PMjAMedtthPt9DPq3mikAU40kjkrs5+WeYwJSqeaEYfiCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505929; c=relaxed/simple;
	bh=j31+yMWO3vIgCtHa47BOYcnWShrCl0VEtcdZTnTOWgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIffM4SPoqTiFtQ2uajUmkxf6cQ5iwIl0QSqgoNq11RHh3Nr5oYuFKst99rQCUZ650z1maasO99auZy4Lcsknby+2+nlGLUyNvTmAP+HKNLcpDbRzzFpvCeBZpQqah4BYQDkuiFvlROp8IqkuEOZbuajGQpdTq7A8XS0uqGeQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2219edd959dso675716fac.0;
        Fri, 15 Mar 2024 05:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710505927; x=1711110727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j31+yMWO3vIgCtHa47BOYcnWShrCl0VEtcdZTnTOWgw=;
        b=RRydMfu1Qch89m7BqTK6mpQnwA2I4pMmV+5ySipOaJlPvRWWgCYqDrFSIZ2g7zgips
         M83tdugiPdd2cHiME0HK97VCAKzH5aYPn37m4cf/hbE9/scFbob4PNQr8+l8DuM9fEAh
         ulIS181+m4jw+ldiCK+FfkF0XUvfusUXbI7uO+p8dYrriukVSBMbHxh2V5sNN3m1PKqf
         9EC+u/+9UksXqcNwjSEmL0htdRBIf/0QrbM6nPjtJa/EygFd3h0DCsEBkHjVauK9wNhd
         ruHqznNcDpyrz/npmQN5dDfe7OBni6WFgW9JKj/FzBBOgNXZvSfJCdrvaM5AJPCzUc05
         a+aA==
X-Forwarded-Encrypted: i=1; AJvYcCUWSjsK0srLjvcJv/3MMFyhtg30CjJTfZDQUR+7HnacAZDcHhbs9CxNqV5f/MhkwfO4wwEaGLSWC5fDEy/8fJ48XKj9psGYsOndDrMjcL6lOa3kHtiBy3GIqWaZQ+WZNssns3FUkuZPHw==
X-Gm-Message-State: AOJu0Yx73MALidpyfwxTHQdAeuRYyqA1GR7PEsAtZjjz9Y9ro9/Og1Ef
	dngzk/c99U90dk2oUQNDohhymQTS4P0JMc/WjLNjnZ9EUfe9Xh4gk3NLY2vtRQGiDrrglTsQJi6
	ctnAjYLzrBJxaKwtDBcduWO8SBmA=
X-Google-Smtp-Source: AGHT+IGfMnFTEOnZaqR3REd4OURjr0SyRKy28dnUBfXOV8VCPImJ6jmpCfhSKSb5BKmLCAHTXAFjDVx0p+e6u+QOw88=
X-Received: by 2002:a05:6871:458a:b0:21f:cd7d:9904 with SMTP id
 nl10-20020a056871458a00b0021fcd7d9904mr4604361oab.4.1710505927029; Fri, 15
 Mar 2024 05:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118062930.245937-1-sunilvl@ventanamicro.com> <Zc2U70o7teYnJyp9@sunil-laptop>
In-Reply-To: <Zc2U70o7teYnJyp9@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Mar 2024 13:31:56 +0100
Message-ID: <CAJZ5v0iaVj+E5yq2wph7-tr6y-vzFbfoscxjk9Y_O1iWqNp3Mg@mail.gmail.com>
Subject: Re: [PATCH v3 -next 0/3] RISC-V: ACPI: Add LPI support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:37=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Rafel,
>
> On Thu, Jan 18, 2024 at 11:59:27AM +0530, Sunil V L wrote:
> > This series adds support for Low Power Idle (LPI) on ACPI based
> > platforms.
> >
> > LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
> > enable this is available at [2].
> >
> > [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Co=
ntrol.html#lpi-low-power-idle-states
> > [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download=
/v/riscv-ffh.pdf
> >
> Could you please take a look at this series also and provide ACK if
> looks fine?

I cannot really comment on RISC-V-specific changes.

As for the ACPI Kconfig change, please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to that patch.


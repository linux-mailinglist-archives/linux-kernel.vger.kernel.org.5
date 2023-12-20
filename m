Return-Path: <linux-kernel+bounces-7012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B081A084
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AC81F22C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C83B28E;
	Wed, 20 Dec 2023 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hnMlaTWX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4734539AF7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 21CA53F73C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703080779;
	bh=GORz2Rp468DG/BOConaMtErEasFxTme5lVfMMQP4MUs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hnMlaTWXATqxlutyL15CYB/jXzsNvxV3DyelCltS8S6JwzOSaJxMP9pgmtPJtcFvD
	 ZpC7WFNUslAhETHJYItj0RxRZ/rr0XZbjNl85g5CaT20rrMO2zPvoFfG2So4mQuTIx
	 zRNZaNPqZ8bZ0GGyi9gSpeIZvQnWY3cak0Bh91Y0JYuQeCdUUDBqQr3indLq9lFMLH
	 L47CZfgJMk30BAaB3RYtb4y5QC9A+4BR6sZdTy0f874oJ3Q5xlvlAqupOpFQpZfSgu
	 bv8DnVdmc1ji616+zbSbCWHQxEWkdvjV9NrW4KwBCsnBgWMOANzEw8gZZd4IDKARzx
	 pRaxaKcB/1ESw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4277e532d24so20534091cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080778; x=1703685578;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GORz2Rp468DG/BOConaMtErEasFxTme5lVfMMQP4MUs=;
        b=gxXYGfzz3A+kUZK/EK1DWLJpk6r4FPzwe/IMO8IpDM2PR28jE5xF5buuDzjtzttmy0
         T0gKbQF9H6RH0W70p8IqIAhIHVHvU5lPb3R3nBmYJwtWGoM3G+kuPmgW3H4msRSp14Ub
         mjfD360XXyQDSMoVoq2UvcXb0qSNi+YoTApr+ED882LI7l4XCHleeiGJvA2R6TZGnM0h
         LcGpEQvsV8V05vpOBE6iy9PU1GZv1mHGdbrLmAPrEoIJRZT80rvGY3FhOkZbWh9cg+mu
         pslWojGjSgTbbyMY4uhRDdJfXkBWTUPgbj+qo9Cq5F63BThwwKvB+sYkABN6bqUz9svE
         ouqg==
X-Gm-Message-State: AOJu0YyKem3LtipKpZg6r4iCb0B+s58sC8wmys3x6mWWVlCogEy4hlUt
	GOog6XUq5QIE9LvYw769qcYv4FaIcI9l0EzcD4JpsF2oKtEklAli80paLixGRvtlEFUctfhxOSt
	oZhkk0n8GLWlGKThNPphpDUusbV9rcxeJpfpBCQoB/DAYvMf1fMSXkHBVjQ==
X-Received: by 2002:ac8:7f48:0:b0:423:93ce:bde2 with SMTP id g8-20020ac87f48000000b0042393cebde2mr29365875qtk.63.1703080778008;
        Wed, 20 Dec 2023 05:59:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSaFdvONz8qARVl9xk2ogiIoiNQxVWQOGFEh6uNs6/Cm8/+RY61RyiZi9PYlTSrc0KpTX0sX3yWrbwWUM9sdQ=
X-Received: by 2002:ac8:7f48:0:b0:423:93ce:bde2 with SMTP id
 g8-20020ac87f48000000b0042393cebde2mr29365861qtk.63.1703080777739; Wed, 20
 Dec 2023 05:59:37 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Dec 2023 05:59:37 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231219145402.7879-3-xingyu.wu@starfivetech.com>
References: <20231219145402.7879-1-xingyu.wu@starfivetech.com> <20231219145402.7879-3-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 20 Dec 2023 05:59:37 -0800
Message-ID: <CAJM55Z_X9b=TJt7343kQ68ndN1MvH-rFM9hyEZMJRvQnOk72Yg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] clocksource: Add JH7110 timer driver
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Walker Chen <walker.chen@starfivetech.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Xingyu Wu wrote:
> Add timer driver for the StarFive JH7110 SoC and select it by
> CONFIG_SOC_STARFIVE.
>
> This timer has four free-running and independent 32-bit counters.
> Each channel(counter) can trigger an interrupt when timeout even
> CPU is sleeping. So this timer is used as global timer and register
> clockevent for each CPU core after riscv-timer registration on the
> StarFive JH7110 SoC.
>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  MAINTAINERS                        |   7 +
>  arch/riscv/Kconfig.socs            |   1 +
>  drivers/clocksource/Kconfig        |   9 +
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/timer-jh7110.c | 360 +++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h         |   1 +
>  6 files changed, 379 insertions(+)
>  create mode 100644 drivers/clocksource/timer-jh7110.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9104430e148e..fe0e803606a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20617,6 +20617,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
>  F:	sound/soc/starfive/jh7110_tdm.c
>
> +STARFIVE JH7110 TIMER DRIVER
> +M:	Samin Guo <samin.guo@starfivetech.com>

Last time I sent a mail to samin.guo@starfivetech.com it bounced. Was that just
a temporary error?

/Emil

> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
> +F:	drivers/clocksource/timer-jh7110.c
> +
>  STARFIVE JH71X0 CLOCK DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>


Return-Path: <linux-kernel+bounces-7026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27BA81A0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30164B2110D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F137D21;
	Wed, 20 Dec 2023 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4KEoNhx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADB38DD9;
	Wed, 20 Dec 2023 14:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE02C43391;
	Wed, 20 Dec 2023 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703081052;
	bh=hah0c3+gkGhXsPh3PM6IJDMdLkqSuCgWXu2oMY2gaWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S4KEoNhxLnr0OZYvdrVxgO+PSzhs8vLSmwHTUI0snloPRCR7BGVC4ia15p5yPgQ0I
	 LAZVYXGsm24RJfLoVKdIVrN11p6aN0uHICTNQBycTiIk00Xq1EW5ePIWMmYkjqJ76L
	 hkml+KahNV4EyzgdxxWXNmUqmlU643DknKQJsMvTlAMLL+fAqUgk9XLoMkwSSwvgr7
	 vxhdTFFQ5TlmhBORm84xUiQxsst/1bD9Gu5LG7svBU1ODAEjO+s70JFcBUnYMlBesc
	 jIMTv7o/DO+/I2pfM9dsyreS0WSJfKKXzFKOs+Y3ZKA43vKaFcvHzqsttkEw45R0Pc
	 QhxmeVrX/uiDA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc4029dc6eso68869911fa.1;
        Wed, 20 Dec 2023 06:04:12 -0800 (PST)
X-Gm-Message-State: AOJu0YwD4FUPeqWLKrnR06jpk1sPrwumS+JtuAK0Fg2xze+JXxWd2rNM
	pn6riC1RsiNmO5oQTy5QwY2r1ixjJX0bEqWA0A==
X-Google-Smtp-Source: AGHT+IF4V66pNioiIeRxiat5Fr8KLMNxzNTtoL4Nx1F/4UDthtQsb0MQBvBoGrl3w0HSrJN6pljqmPMH5nPiyvd+njo=
X-Received: by 2002:a2e:3a15:0:b0:2cc:7125:fa86 with SMTP id
 h21-20020a2e3a15000000b002cc7125fa86mr2628132lja.54.1703081050612; Wed, 20
 Dec 2023 06:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214150414.1849058-1-enachman@marvell.com> <20231214150414.1849058-4-enachman@marvell.com>
In-Reply-To: <20231214150414.1849058-4-enachman@marvell.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 20 Dec 2023 08:03:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YacBooMe75dHO3mfwQHapPB+opP7zU+0o_2cmpbv19w@mail.gmail.com>
Message-ID: <CAL_Jsq+YacBooMe75dHO3mfwQHapPB+opP7zU+0o_2cmpbv19w@mail.gmail.com>
Subject: Re: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
To: Elad Nachman <enachman@marvell.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	gregory.clement@bootlin.com, chris.packham@alliedtelesis.co.nz, 
	andrew@lunn.ch, fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, 
	al.stone@linaro.org, timur@codeaurora.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cyuval@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:05=E2=80=AFAM Elad Nachman <enachman@marvell.com>=
 wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Add support for Marvell ac5/x variant of the ARM
> sbsa global watchdog. This watchdog deviates from
> the standard driver by the following items:
>
> 1. Registers reside in secure register section.
>    hence access is only possible via SMC calls to ATF.
>
> 2. There are couple more registers which reside in
>    other register areas, which needs to be configured
>    in order for the watchdog to properly generate
>    reset through the SOC.
>
> The new Marvell compatibility string differentiates between
> the original sbsa mode of operation and the Marvell mode of
> operation.
>
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/watchdog/sbsa_gwdt.c | 247 ++++++++++++++++++++++++++++++++---
>  1 file changed, 226 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 5f23913ce3b4..0bc6f53f0968 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -46,10 +46,13 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/uaccess.h>
>  #include <linux/watchdog.h>
>  #include <asm/arch_timer.h>
> +#include <linux/arm-smccc.h>
>
>  #define DRV_NAME               "sbsa-gwdt"
>  #define WATCHDOG_NAME          "SBSA Generic Watchdog"
> @@ -75,6 +78,68 @@
>  #define SBSA_GWDT_VERSION_MASK  0xF
>  #define SBSA_GWDT_VERSION_SHIFT 16
>
> +/* Marvell AC5/X SMCs, taken from arm trusted firmware */
> +#define SMC_FID_READ_REG       0x80007FFE
> +#define SMC_FID_WRITE_REG      0x80007FFD

One more thing, these IDs are part of the Arm arch range and can't be
used. You should be using the SIP range AIUI.

Perhaps you should look at arm_smc_wdt.c and make that work on your
system. Despite the name, my understanding is it is a ChromeOS defined
watchdog, not an Arm (Ltd) one.

Rob


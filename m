Return-Path: <linux-kernel+bounces-139859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4D8A088B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8128CB221C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC00B13D617;
	Thu, 11 Apr 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5wcyx9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0613CA86;
	Thu, 11 Apr 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817381; cv=none; b=mmt1of5D/hhORCIUDZ7ziIFJvsicd0UlcQMe5Wc9PbzsvAw0NHwc3a3cch5Dh8OxNP2mLLCe4Ni3aHICqvxjwPZ/l2KUgNoMOBkm69YxhyX3y1yqIodzscVPEgG4vjjM3UlkCzwHBeAE2yNaCashJ6mMTAbA5MrZW1X6IsFZypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817381; c=relaxed/simple;
	bh=N+fjYrC1p/JcTL+qhfdZbXsjzDIX8vxqPTYbZPrnCQg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pR1JKcR0ANbCDZFJVV0JzU8HJMzyWxhRc32E+b3k5T/v2x3gWEhRfDvw3+jMWoJbBw1Tv8SVEk5LwG/TkzSAWZoJb5dAO1MwIvJqh/5xEqATT7BpshUDdTRlIAI5teDmXVzkvjAQNNu/128dWDNrDkoFE5hianZIIJU/V+/yof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5wcyx9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D261C433C7;
	Thu, 11 Apr 2024 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712817380;
	bh=N+fjYrC1p/JcTL+qhfdZbXsjzDIX8vxqPTYbZPrnCQg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=E5wcyx9nERJq65xe1mhmfAecCHZFGwm1UobT29TuZ7f6V46z8wOKe86uJbqntraVw
	 9z+i1M4I37TtComxsxwO6ct8jGB/Va2N2VgXp56X5tuJGJr38e+7Ii8l1uGzgun6tf
	 BMfcMzMhXMldPgF4iTLJ6K7hf8J8MMA5Zocqyb6Eh9p4xBwCgm0vyJw6k79d6Y/Iaj
	 fvTlzXL2QFDEi19XBnxaqjnIp3/pqdLb8dGl6m0dVyOG0IAcFXgbgfaF+vq5ZcFEkS
	 wHpyKuXzWRsCjCTO5MgLIT+7fTEvObXceJZxVTu4IzTs+stpyO43Ycjz+j/kXXi9r7
	 uoEvcsUDcdAEw==
Message-ID: <7498985788263268d4acfcd1589a5994.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240409171241.274600-4-gabriel.fernandez@foss.st.com>
References: <20240409171241.274600-1-gabriel.fernandez@foss.st.com> <20240409171241.274600-4-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v10 3/4] clk: stm32: introduce clocks for STM32MP257 platform
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Wed, 10 Apr 2024 23:36:18 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-04-09 10:12:40)
> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-st=
m32mp25.c
> new file mode 100644
> index 000000000000..23876e7d9863
> --- /dev/null
> +++ b/drivers/clk/stm32/clk-stm32mp25.c
> @@ -0,0 +1,1876 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicro=
electronics.
> + */
> +
> +#include <linux/clk.h>

Use clk-provider.h not clk.h

> +#include <linux/of_address.h>

Doubt this is the right include. Drop?

> +#include <linux/platform_device.h>
> +
> +#include "clk-stm32-core.h"
> +#include "reset-stm32.h"
> +#include "stm32mp25_rcc.h"
> +
> +#include <dt-bindings/clock/st,stm32mp25-rcc.h>
[...]
> +       .clock_data     =3D &stm32mp25_clock_data,
> +       .reset_data     =3D &stm32mp25_reset_data,
> +};
> +
> +static const struct of_device_id stm32mp25_match_data[] =3D {
> +       { .compatible =3D "st,stm32mp25-rcc", .data =3D &stm32mp25_data, =
},
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
> +
> +static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       void __iomem *base;
> +
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (WARN_ON(IS_ERR(base)))

Drop WARN_ON

> +               return PTR_ERR(base);


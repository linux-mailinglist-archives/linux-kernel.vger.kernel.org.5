Return-Path: <linux-kernel+bounces-85780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBCB86BAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD76028BA05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6671361C1;
	Wed, 28 Feb 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn6KZG+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890341361A3;
	Wed, 28 Feb 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158686; cv=none; b=oKCqi2/Qo0AY+FWjh9Xm1fxv0FnqA5E5Bb6iSoX6q8p+G5WyJr1qRgLud+7gQzW/dBDS17TX9IOtjKi6yrtW3j878l6DWs6a93RH5qJ5jqfyOBvWvMGkCo6sq9JS9ZgNNjYnlynAefyPP8MrablYknZUyuneNiSdxQYkTABL+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158686; c=relaxed/simple;
	bh=XgRBeERvVGVRTMKOSp0B+k8IqLT4mFYWBW+Ok+EN2DY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Bz1gpzGBO2Srj/CEej96d6glVY74JzfSZubyk4SF/OKhPXXp70Ur/mQntdt7etNNVsrp3ZKa1d1WxqS7Ify4a/j4MIG3e/DR1lDG848pEffzI6Fch+IEYdrtIKK6MgUowoGpsAuMdHeDT6nHvyTxLJAgwHF2MkciDpHbzXu7jok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn6KZG+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15252C433F1;
	Wed, 28 Feb 2024 22:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709158686;
	bh=XgRBeERvVGVRTMKOSp0B+k8IqLT4mFYWBW+Ok+EN2DY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kn6KZG+Vo9H4uSUtWN/Ywm+W5t5mRmUSu3k9ZH+K3+uqq/kvsbHZnqY4LYfPY/h8Y
	 lIKUBFxU4WV4+V3F1d5FugkOWz9puNZlgBu2WX1+Ej8rOaHjyxVxgD+M+8bIuNnIgl
	 UqQf/CRzIFaGFb3aF1T5BNfVYBSeXUzmLxmOZHSn8sF1FYYDmwZibZYAZekzOLB+kf
	 j8hms/IgHk5aLwFfRtV9KyB0/NigVAXa0nEQ1CbG+6dycDdp/0SPNRjgGuYdqER3w5
	 5FvSizj73YbMEVlSrDZasqDhsHirKEzaKCHdt9e6lO8d2D+X2ZM2Nd+SUeq3ioRjwb
	 tqfy9isPUs6sQ==
Message-ID: <d81a0e5a477f03c248111f515ae2e3be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240228082649.1633083-1-peng.fan@oss.nxp.com>
References: <20240228082649.1633083-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858)
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To: Peng Fan (OSS) <peng.fan@oss.nxp.com>, abelvesa@kernel.org, festevam@gmail.com, kernel@pengutronix.de, mturquette@baylibre.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Date: Wed, 28 Feb 2024 14:18:03 -0800
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-02-28 00:26:49)
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-sc=
u.c
> index dd5abd09f3e2..b30d0f8b5bca 100644
> --- a/drivers/clk/imx/clk-lpcg-scu.c
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -6,6 +6,7 @@
> =20
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> @@ -41,6 +42,31 @@ struct clk_lpcg_scu {
> =20
>  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
> =20
> +/* e10858 -LPCG clock gating register synchronization errata */
> +static void do_lpcg_workaround(u32 rate, void __iomem *reg, u32 val)

unsigned long rate

> +{
> +       writel(val, reg);
> +
> +       if (rate >=3D 24000000 || rate =3D=3D 0) {
> +               u32 reg1;

Please declare this variable at the start of the function.

> +
> +               /*
> +                * The time taken to access the LPCG registers from the A=
P core
> +                * through the interconnect is longer than the minimum de=
lay
> +                * of 4 clock cycles required by the errata.
> +                * Adding a readl will provide sufficient delay to prevent
> +                * back-to-back writes.
> +                */
> +               reg1 =3D readl(reg);
> +       } else {
> +               /*
> +                * For clocks running below 24MHz, wait a minimum of
> +                * 4 clock cycles.
> +                */
> +               ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));
> +       }
> +}
> +
>  static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  {
>         struct clk_lpcg_scu *clk =3D to_clk_lpcg_scu(hw);
> @@ -57,7 +83,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
>                 val |=3D CLK_GATE_SCU_LPCG_HW_SEL;
> =20
>         reg |=3D val << clk->bit_idx;
> -       writel(reg, clk->reg);
> +
> +       do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);

I'd prefer the name had 'writel' in it somewhere.
> =20
>         spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>


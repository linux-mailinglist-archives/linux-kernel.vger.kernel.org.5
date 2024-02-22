Return-Path: <linux-kernel+bounces-75962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA9885F130
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1128BB22564
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553F168A4;
	Thu, 22 Feb 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWCqeQ9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DF101F1;
	Thu, 22 Feb 2024 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581484; cv=none; b=CwASvGwKLlOAXIab6GQMskDSAJVLfcC3uorPe6Nc8rylE4pKMAkLcVplGeQEK6c+OLbl4mi4yYXzjmP0oyG1ox0LPjKm7btlPtgcYMTgWfoegSTtLXZBzn3ooxnk5vCc2peHKRK3EUJysrByoe3OfMgFAiYNB4lQKqn4c+2HpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581484; c=relaxed/simple;
	bh=EofOeYODL7p7e0qVfaAW76kCTVxz6mRFJbAg2DnJq6A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hgJxc33xQiR7/GuvM651rJhCshKn5JWUOUcCgJFwADC5C8/2Y+Hk+LDuJAIAbtq0owapulZmKnX8rn3KVkf9dpzaUWTRWYot1vWxnqoxIdCRB3XR+Hbp3jqnZnrP5mgIgcIR5nD3ASS+1ip8n/Av1OhKwnRfPmBmFN7/TMJctPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWCqeQ9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AF1C433F1;
	Thu, 22 Feb 2024 05:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708581484;
	bh=EofOeYODL7p7e0qVfaAW76kCTVxz6mRFJbAg2DnJq6A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GWCqeQ9ZA1pgle3Iuf7PUTJs1bgjWohQyYsMFUTPzRZGI++viJ1Aw35r3Swl9n+Az
	 JtVUJOUlMh90vDDB6B+KW9HdAKhSBi9LA467AZ1x1obMjVVPe8EB8Ugy8/ctbH0PiE
	 YKEfrSXf+bY9FZ01Zt3dtuOFSdUnnGUb85QVkYrTt2SqTqHwQ9NZ93PpgV4JguFXdX
	 oUYl0IXL74hD0FaDm0cjD1It5FLJi/GBlJHS5jtBgpc+4/qP7sCGaGP2mmmc4809Vn
	 gOTKfzm0o7+x9xGgtt1ywmWS+R32cwBqVvzaxsokYr3b3NWGz40FEhTcdKJOaExXDp
	 7pp+W0XQxTt1A==
Message-ID: <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240131182653.2673554-4-tmaimon77@gmail.com>
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-4-tmaimon77@gmail.com>
Subject: Re: [PATCH v23 3/3] clk: npcm8xx: add clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To: Tomer Maimon <tmaimon77@gmail.com>, benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date: Wed, 21 Feb 2024 21:58:01 -0800
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-01-31 10:26:53)
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..eacb579d30af
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM8xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allo=
ws only
[...]
> +
> +/* external clock definition */
> +#define NPCM8XX_CLK_S_REFCLK   "refclk"
> +
> +/* pll definition */
> +#define NPCM8XX_CLK_S_PLL0     "pll0"
> +#define NPCM8XX_CLK_S_PLL1     "pll1"
> +#define NPCM8XX_CLK_S_PLL2     "pll2"
> +#define NPCM8XX_CLK_S_PLL_GFX  "pll_gfx"
> +
> +/* early divider definition */
> +#define NPCM8XX_CLK_S_PLL2_DIV2                "pll2_div2"
> +#define NPCM8XX_CLK_S_PLL_GFX_DIV2     "pll_gfx_div2"
> +#define NPCM8XX_CLK_S_PLL1_DIV2                "pll1_div2"
> +
> +/* mux definition */
> +#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
> +
> +/* div definition */
> +#define NPCM8XX_CLK_S_TH          "th"
> +#define NPCM8XX_CLK_S_AXI         "axi"

Please inline all these string #defines to the place they're used.

> +
> +static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
[..]
> +static struct clk_hw *
> +npcm8xx_clk_register(struct device *dev, const char *name,
> +                    struct regmap *clk_regmap, unsigned int offset,
> +                    unsigned long flags, const struct clk_ops *npcm8xx_c=
lk_ops,
> +                    const struct clk_parent_data *parent_data,
> +                    const struct clk_hw *parent_hw, u8 num_parents,
> +                    u8 shift, u32 mask, unsigned long width,
> +                    const u32 *table, unsigned long clk_flags)
> +{
> +       struct npcm8xx_clk *clk;
> +       struct clk_init_data init =3D {};
> +       int ret;
> +
> +       clk =3D devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> +       if (!clk)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D npcm8xx_clk_ops;
> +       init.parent_data =3D parent_data;
> +       init.parent_hws =3D parent_hw ? &parent_hw : NULL;

Is it necessary to check? Can't it be set unconditionally?

> +       init.num_parents =3D num_parents;
> +       init.flags =3D flags;
> +
> +       clk->clk_regmap =3D clk_regmap;
> +       clk->hw.init =3D &init;
> +       clk->offset =3D offset;
> +       clk->shift =3D shift;
> +       clk->mask =3D mask;
> +       clk->width =3D width;
> +       clk->table =3D table;
> +       clk->flags =3D clk_flags;
> +
> +       ret =3D devm_clk_hw_register(dev, &clk->hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &clk->hw;
[...]
> +
> +static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct npcm8xx_clk *div =3D to_npcm8xx_clk(hw);
> +       unsigned int val;
> +
> +       regmap_read(div->clk_regmap, div->offset, &val);
> +       val =3D val >> div->shift;
> +       val &=3D clk_div_mask(div->width);
> +
> +       return divider_recalc_rate(hw, parent_rate, val, NULL, div->flags,
> +                                  div->width);
> +}
> +
> +static const struct clk_ops npcm8xx_clk_div_ops =3D {
> +       .recalc_rate =3D npcm8xx_clk_div_get_parent,
> +};
> +
> +static int npcm8xx_clk_probe(struct platform_device *pdev)
> +{
> +       struct device_node *parent_np =3D of_get_parent(pdev->dev.of_node=
);

The parent of this device is not a syscon.

> +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> +       struct device *dev =3D &pdev->dev;
> +       struct regmap *clk_regmap;
> +       struct clk_hw *hw;
> +       unsigned int i;
> +
> +       npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_clk_da=
ta, hws,
> +                                                        NPCM8XX_NUM_CLOC=
KS),
> +                                       GFP_KERNEL);
> +       if (!npcm8xx_clk_data)
> +               return -ENOMEM;
> +
> +       clk_regmap =3D syscon_node_to_regmap(parent_np);
> +       of_node_put(parent_np);

Is there another binding update that is going to move this node to be a
child of the syscon?

		gcr: system-controller@f0800000 {
                        compatible =3D "nuvoton,npcm845-gcr", "syscon";
                        reg =3D <0x0 0xf0800000 0x0 0x1000>;
                };


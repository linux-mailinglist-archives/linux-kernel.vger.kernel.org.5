Return-Path: <linux-kernel+bounces-133597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC789A61F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA11C211A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71DE175552;
	Fri,  5 Apr 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVcbNjTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD791E87C;
	Fri,  5 Apr 2024 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353045; cv=none; b=Ge5iyQEAYXNAu/dsXRDSdg42eVeKZrhEnVJjJfvqfXgwm25FkvD0qlXmrKPdaCT6uTKnd9mt3uIx2XL0xHPtmCBNnDbZaMwvTlN4u/gl1y3Q5wwgt7cJ9f0SrhiQKifONtCKVAywxZWIAocwz8Ni20MGapHphe0YK25fFXh9/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353045; c=relaxed/simple;
	bh=HRY5hhaW64V8NU8mf6JssyKiFddMjgw/28ouTE9i8oQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=BO4TZ4LD6FHqEu4pGJDtMw/LF5KS+z4IEXblz4M+Qk1ys9WoN6ylD70fsuyn/fNDNEFl3+ynYRC4BeL4MhKAfaNM7Ta8cPbH2wEt80vTOusn8l4xbLSFkl5Y7Thb3MSr9RWQV82VSC8SRZAfEmAcJlRRshD/zedmm841PtYpXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVcbNjTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C0BC433F1;
	Fri,  5 Apr 2024 21:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712353044;
	bh=HRY5hhaW64V8NU8mf6JssyKiFddMjgw/28ouTE9i8oQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fVcbNjTngZrTTYeW0UvQ09QyyH1QIXo+3JsshjvnlSpw4x5qjkHXS1E9mFu2jal5p
	 3lsWFfAOeSqT8cQiqrD1Ko3zg5zXoioz/UfFHaiXZgxkIEVgD6RKL5Xh/U8BCJ7DfE
	 pTyVDK3QHEVFsjTyyzswPnPpndZzgQGGXJp9GorLmrzy/u3i5NHsjE5Qdpb1t/Y0gM
	 OYyCroRQZN0Wp2Jtb4rtog2FVULbOrWLu/3mQUJyxDTrl6H2UBRgBqDLUisEVjZjFM
	 wfPWR0jvWnJcraIqYAcYK2VjYEPPvR6VNUO8ZNEYf54YtKUUazCP4PPMPNuxNNKPBb
	 ERD1XjKS4h9Mg==
Message-ID: <b39e9d5ecfddef7b0564c2224685d9d0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240219-topic-rb1_gpu-v3-2-86f67786539a@linaro.org>
References: <20240219-topic-rb1_gpu-v3-0-86f67786539a@linaro.org> <20240219-topic-rb1_gpu-v3-2-86f67786539a@linaro.org>
Subject: Re: [PATCH v3 2/5] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>
Date: Fri, 05 Apr 2024 14:37:22 -0700
User-Agent: alot/0.10

Quoting Konrad Dybcio (2024-03-26 14:08:24)
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index 8a412ef47e16..27ba8aa3e577 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -779,6 +792,40 @@ static long clk_alpha_pll_round_rate(struct clk_hw *=
hw, unsigned long rate,
>         return clamp(rate, min_freq, max_freq);
>  }
> =20
> +void clk_huayra_2290_pll_configure(struct clk_alpha_pll *pll, struct reg=
map *regmap,
> +                                  const struct alpha_pll_config *config)
> +{
> +       u32 val;
> +
> +       clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->c=
onfig_ctl_val);
> +       clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config-=
>config_ctl_hi_val);
> +       clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config=
->config_ctl_hi1_val);
> +       clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->tes=
t_ctl_val);
> +       clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->t=
est_ctl_hi_val);
> +       clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->=
test_ctl_hi1_val);
> +       clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
> +       clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->al=
pha);
> +       clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->use=
r_ctl_val);
> +
> +       /* Set PLL_BYPASSNL */
> +       regmap_update_bits(regmap, PLL_MODE(pll), PLL_BYPASSNL, PLL_BYPAS=
SNL);
> +       regmap_read(regmap, PLL_MODE(pll), &val);
> +
> +       /* Wait 5 us between setting BYPASS and deasserting reset */
> +       udelay(5);
> +
> +       /* Take PLL out from reset state */
> +       regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_=
N);
> +       regmap_read(regmap, PLL_MODE(pll), &val);
> +
> +       /* Wait 50us for PLL_LOCK_DET bit to go high */

Is the bit not reliable or something? I'd expect to see a polling loop
here but it's a sleep.

> +       usleep_range(50, 55);


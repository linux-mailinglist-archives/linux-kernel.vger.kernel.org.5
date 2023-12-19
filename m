Return-Path: <linux-kernel+bounces-5593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE8818CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22825B21175
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DF20319;
	Tue, 19 Dec 2023 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsPoUizm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FF20308;
	Tue, 19 Dec 2023 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a268836254aso35630966b.1;
        Tue, 19 Dec 2023 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004371; x=1703609171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iyYRRTfOYCdZhFzzYt7vcnK5tnPRi7bc1hwQ2Xgkro=;
        b=fsPoUizmzbiltTNUCfUQmC6UlJSYDVcd7h9yNA2JNp4hvp4uVPgQX/yniGpw1A78g6
         oaLRo2lBajXndOCVKc8D8I1MTGqmbZL1nMlOIRFLn5PY8my5sTTdYxneuSKGjfy6+q2O
         byB//vUapS89duEClBXxacL0A7hSwmOLIb29xO2QclBGcvEqohiNXJXH+9Rciqkn7oim
         xQQ5SuiolvbAp2Tp15nQnQJV1r9ZN6DV7vVkfnw3uqDnQWyFF2BVuNFC5mkJiUjPrK++
         11Ma7pyEmhK8QrnPN6aBpeM0ghwV6iWaRtKKCWevrhvC4wFvfDFkwu/gwfgfBvflsi33
         pnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004371; x=1703609171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iyYRRTfOYCdZhFzzYt7vcnK5tnPRi7bc1hwQ2Xgkro=;
        b=GhvJfXBTIzMSwIUCgu0TkwZEr27XUtPtvn+1erWsH/1K9h+Rh2mnzhI0XbKT7EgNxp
         bXi195CwQUsFlZD+S2jFsxys1qgdE5t78ODQkJdmiDV0Ua5RzJT/Ap1d8hTQ8smqEfhF
         C68F57faqllOaMThcpJkkdK0X19QmfwPTGS8qYEy8DR0m6GWxmzHr2AzmTymntJIlJVq
         //ozZcSv6mT2XdmBEkwMKZ656vazSQis8e21YfiwinYETynYqxXxo4s0S30DGi8rWeqi
         yG+VBiwVnGzL/iLNk3Jy9a/2a1/VrK73Uj+pzBY25wgnhdybnRt6RRsXPSnOkUVQe5wq
         uRSg==
X-Gm-Message-State: AOJu0YxqH+HlCyaYdIYLv7CIf5qxOQh1hf2m4PnwlZQ5OG+0h4V3KMJA
	2scAlXN69YXt2S0Th2Ar+GQ=
X-Google-Smtp-Source: AGHT+IFJfMra7NcuO7fQEfUYtCoN4Bxnp51stjqeihm0piqP+Wi1lNVa1b2/OyVghxfcNYQDfZPAyA==
X-Received: by 2002:a17:906:2206:b0:a23:3299:f332 with SMTP id s6-20020a170906220600b00a233299f332mr2818692ejs.140.1703004370668;
        Tue, 19 Dec 2023 08:46:10 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id vx4-20020a170907a78400b00a0a2553ec99sm15564251ejc.65.2023.12.19.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:46:10 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH 1/5] clk: sunxi-ng: nkm: Support constraints on m/n ratio and
 parent rate
Date: Tue, 19 Dec 2023 17:46:08 +0100
Message-ID: <5736273.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20231218-pinephone-pll-fixes-v1-1-e238b6ed6dc1@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-1-e238b6ed6dc1@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Frank!

Dne ponedeljek, 18. december 2023 ob 14:35:19 CET je Frank Oltmanns napisal(a):
> The Allwinner A64 manual lists the following constraints for the
> PLL-MIPI clock:
>  - M/N >= 3

This should be "<="

>  - (PLL_VIDEO0)/M >= 24MHz
> 
> The PLL-MIPI clock is implemented as ccu_nkm. Therefore, add support for
> these constraints.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 23 +++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h |  8 ++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index eed64547ad42..2af5c1ebd527 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -16,6 +16,20 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
>  
> +static bool ccu_nkm_is_valid_rate(struct ccu_common *common, unsigned long parent,
> +				  unsigned long n, unsigned long m)
> +{
> +	struct ccu_nkm *nkm = container_of(common, struct ccu_nkm, common);
> +
> +	if (nkm->max_mn_ratio && (m > nkm->max_mn_ratio * n))
> +		return false;
> +
> +	if (nkm->parent_wo_nk && (parent < nkm->parent_wo_nk * m))
> +		return false;
> +
> +	return true;
> +}
> +
>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common,
>  						       struct clk_hw *parent_hw,
>  						       unsigned long *parent, unsigned long rate,
> @@ -32,6 +46,9 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
>  
>  				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
>  
> +				if (!ccu_nkm_is_valid_rate(common, tmp_parent, _n, _m))
> +					continue;
> +
>  				tmp_rate = tmp_parent * _n * _k / _m;
>  
>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
> @@ -65,6 +82,12 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>  	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
>  		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
> +				if ((common->reg == 0x040) && (_m > 3 * _n))
> +					break;
> +
> +				if ((common->reg == 0x040) && (parent < 24000000 * _m))
> +					continue;
> +

You already figured this part.

>  				unsigned long tmp_rate;
>  
>  				tmp_rate = parent * _n * _k / _m;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index 6601defb3f38..d3d3eaf55faf 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -16,6 +16,12 @@
>   * struct ccu_nkm - Definition of an N-K-M clock
>   *
>   * Clocks based on the formula parent * N * K / M
> + *
> + * @max_mn_ratio:	Maximum value for M / N.
> + * @parent_wo_nk:	The minimum rate the parent must provide after applying the divisor,
> + *			but without applying the multipliers, i.e. the contstraint
> + *			   (parent rate)/M >= parent_wo_nk
> + *			must be fulfilled.
>   */
>  struct ccu_nkm {
>  	u32			enable;
> @@ -27,6 +33,8 @@ struct ccu_nkm {
>  	struct ccu_mux_internal	mux;
>  
>  	unsigned int		fixed_post_div;
> +	unsigned long		max_mn_ratio;
> +	unsigned long           parent_wo_nk;

What about max_m_n_ratio and max_parent_m_ratio, to be consistent? This
should also allow to simplify description.

Best regards,
Jernej

>  
>  	struct ccu_common	common;
>  };
> 
> 






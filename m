Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE93777155E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHFNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjHFNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:42:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC1E4A;
        Sun,  6 Aug 2023 06:42:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc512526cso540331966b.1;
        Sun, 06 Aug 2023 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329335; x=1691934135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEx+ZqR+usKBBercOITyC/EAc5ia+Jr9hFT6fjMYzwY=;
        b=GPhHyVXNW5iHzU+Uzck+132AUiEHf0OghscbBNSFqF6kBnJDR142vWP8rgh6IQTFmm
         FLhqB15u+9EHwftqi+AkkCBaBsZ1m1eq8nYcy3aIHTHxi6kRsVF4IYJSG5c4TqACt0eK
         D6TDQvbvwpbxi9KQVEXOfpN+nfXDM6r3Y/KsFeaBhObY7aPh4b/Dp2kZQcx2hqHdpqjv
         R37I8vCMNEzwbpdPiltFX7sL2yz07jtT+YEfdgDu9FG8NM2mBbd3yZXA3uo991V/z8kq
         7/qdscsWTkknI1yjASdHwo69Ostco215Ce5NQoNMSDigHK6jvDgvHhWWeBNryIJxhmuC
         KlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329335; x=1691934135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEx+ZqR+usKBBercOITyC/EAc5ia+Jr9hFT6fjMYzwY=;
        b=CVmN5t11NLBjOy3LA08huttOGo9jBql61xvGcIcL3djWxWiUHm8CKK5vw6wvGEvFtX
         C3cI5joZ73kWV6yLrY0V9I95M29r87Ou1tVN9iDRlV/hF00X6jN42+f3I2wdFxqNBIpf
         yVC2YcidjUF5B0A9lnnSagSLwZ2zrUJhf6ppwxscQHDTqq79yaYRS4Sk0gaeQigrnFOB
         wKRCeHN0+BT7Q/6MhXxvfviscsD/IUtbpAiRc5zvXoRIFeASVruHgfaocQqZxyAQoAaN
         1px6RZy6m8obT0y7wRLFEWWODC0APiRb6HdSbUkK6JASG3OvuVGyUE037HGWq2RnaEE6
         o6UA==
X-Gm-Message-State: AOJu0Yxs76O8TormXUXKdAmnryezOrks5s09EuOVyrSC/zfp6VecTbkG
        owibZriOKca4jz3LAICgt7U=
X-Google-Smtp-Source: AGHT+IFmjZYi0hcJVwMaH7Gd7tt21pCr9H5ZyAUDihj9v3AUGUl18q5jb1ufnmD9/to65CEor1LNKg==
X-Received: by 2002:a17:906:51c6:b0:99b:d007:67b1 with SMTP id v6-20020a17090651c600b0099bd00767b1mr6517352ejk.72.1691329335083;
        Sun, 06 Aug 2023 06:42:15 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id kq7-20020a170906abc700b009888aa1da11sm3949284ejb.188.2023.08.06.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:42:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
Subject: Re: [PATCH v5 07/11] clk: sunxi-ng: nkm: Support finding closest rate
Date:   Sun, 06 Aug 2023 15:42:13 +0200
Message-ID: <23170854.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-7-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-7-db4f5ca33fc3@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 06. avgust 2023 ob 15:06:52 CEST je Frank Oltmanns napisal(a):
> When finding the best rate for a NKM clock, consider rates that are
> higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
> set by using the helper function ccu_is_better_rate().
> 
> Accommodate ccu_mux_helper_determine_rate to this change.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
>  drivers/clk/sunxi-ng/ccu_nkm.c | 20 +++++++++-----------
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
> index 1d557e323169..3ca695439620 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -139,7 +139,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common
> *common, goto out;
>  		}
> 
> -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> +		if (ccu_is_better_rate(common, req->rate, tmp_rate, 
best_rate)) {
>  			best_rate = tmp_rate;
>  			best_parent_rate = parent_rate;
>  			best_parent = parent;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index ea1b77e9b57f..896bb1ef8642 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -17,7 +17,8 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
> 
> -static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw
> *parent_hw, +static unsigned long ccu_nkm_find_best_with_parent_adj(struct
> ccu_common *common, +						
       struct clk_hw *parent_hw,
>  						       
unsigned long *parent, unsigned long rate,
>  						       
struct _ccu_nkm *nkm)
>  {
> @@ -33,10 +34,8 @@ static unsigned long
> ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw, tmp_parent =
> clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
> 
>  				tmp_rate = tmp_parent * _n * _k / 
_m;
> -				if (tmp_rate > rate)
> -					continue;
> 
> -				if ((rate - tmp_rate) < (rate - 
best_rate)) {
> +				if (ccu_is_better_rate(common, 
rate, tmp_rate, best_rate)) {
>  					best_rate = tmp_rate;
>  					best_parent_rate = 
tmp_parent;
>  					best_n = _n;
> @@ -57,7 +56,7 @@ static unsigned long
> ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw, }
> 
>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long
> rate, -				       struct _ccu_nkm *nkm)
> +				       struct _ccu_nkm *nkm, 
struct ccu_common *common)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned long best_n = 0, best_k = 0, best_m = 0;
> @@ -70,9 +69,7 @@ static unsigned long ccu_nkm_find_best(unsigned long
> parent, unsigned long rate,
> 
>  				tmp_rate = parent * _n * _k / _m;
> 
> -				if (tmp_rate > rate)
> -					continue;
> -				if ((rate - tmp_rate) < (rate - 
best_rate)) {
> +				if (ccu_is_better_rate(common, 
rate, tmp_rate, best_rate)) {
>  					best_rate = tmp_rate;
>  					best_n = _n;
>  					best_k = _k;
> @@ -165,9 +162,10 @@ static unsigned long ccu_nkm_round_rate(struct
> ccu_mux_internal *mux, rate *= nkm->fixed_post_div;
> 
>  	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
> -		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
> +		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm, &nkm-
>common);
>  	else
> -		rate = ccu_nkm_find_best_with_parent_adj(parent_hw, 
parent_rate, rate,
> &_nkm); +		rate = ccu_nkm_find_best_with_parent_adj(&nkm->common,
> parent_hw, parent_rate, rate, +					
		 &_nkm);
> 
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /= nkm->fixed_post_div;
> @@ -202,7 +200,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned
> long rate, _nkm.min_m = 1;
>  	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
> 
> -	ccu_nkm_find_best(parent_rate, rate, &_nkm);
> +	ccu_nkm_find_best(parent_rate, rate, &_nkm, &nkm->common);
> 
>  	spin_lock_irqsave(nkm->common.lock, flags);





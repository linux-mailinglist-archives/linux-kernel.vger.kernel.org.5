Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328AB77155A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHFNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHFNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:41:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317AA9;
        Sun,  6 Aug 2023 06:41:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf3f59905so542121066b.3;
        Sun, 06 Aug 2023 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329312; x=1691934112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h3l0kW2b6vVfnZeHC4Hn3Bn63sg4aqSIG5QO3j6yF0=;
        b=F1gSaB7ak6JbrTNLC24zZlh6p0MBTNNa3UQrtJmMhG8OW+MYTzHrrDMrc5BCPvUsW9
         7eoX99pLowYOQ1BdY5bpHxMCNoMq+hkEj2+vgYqYxPkCRwm3ZC+5HLseMoKpGp9+33kR
         NKB+2ayaBYWhdWCrrl5NcY5AnSYCDscuMAAQ/UWzpagRU26xxRGqQw6liXNPwrz7w4qF
         pKlQ8lUVzB3GMdJ3pVLXMfok3HGaKcivRe6RLQplbrPLAb3TQp8aO7uTbFe8Wfy0IfK5
         cmyx4VjAvS8ztZOwCr4VoOa+eedJGXRzTdis+SQy8bz19IhjNMk8qmSBfrw5Yuj61l+k
         LNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329312; x=1691934112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h3l0kW2b6vVfnZeHC4Hn3Bn63sg4aqSIG5QO3j6yF0=;
        b=ib+RlTzCMSeJmwF+opNU42B4QXQ6s0nsvCDcHNYvAGVeHx5PMGnlUHLAz3lIQsnbmS
         oqxTALQaXKYxJhz5joYVBBkXVm3qkAmUt9AXDJVxViqEjQckr+Z/b16ZSCoLi0BCEYnM
         jqtL04BpcSJlgSUoCyZHzXSNSBROU/pt8i2T9EbhmKA6bzAUYSMPyhtZMJWk3vM/UQQH
         /Pc4FL1JhCcwxCoZCoCf15my1MzvpF0FFZUnp+IDMZ4lbsKGIki69yvyBsExSeCGTAnq
         XZ5Umj10Kya3PHaEYIoyz5v6DXz2iSaSydIFSHVi+NOI8xnVSnbPQ5Sntcw/nszgUh93
         0lUg==
X-Gm-Message-State: AOJu0Yy7Ii7N1td47fQs5tyZrCYjN959uwBVCjPIAJpvoKdfN+wNqiCU
        g9LE7BwvD9s4CLPwzqoXylM=
X-Google-Smtp-Source: AGHT+IGtCrikG4mrC+gYRcFUweuBPrubVvV5N14YOGnArL2nkxMEhLWlK00Pz+lMgPhSP5zX1nqiIQ==
X-Received: by 2002:a17:906:20d5:b0:99b:237e:6ee with SMTP id c21-20020a17090620d500b0099b237e06eemr7127559ejc.30.1691329309975;
        Sun, 06 Aug 2023 06:41:49 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906244800b00992b2c55c67sm3976871ejb.156.2023.08.06.06.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:41:49 -0700 (PDT)
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
Subject: Re: [PATCH v5 05/11] clk: sunxi-ng: Add helper function to find closest rate
Date:   Sun, 06 Aug 2023 15:41:48 +0200
Message-ID: <8292789.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-5-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-5-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:50 CEST je Frank Oltmanns napisal(a):
> The default behaviour of clocks in the sunxi-ng driver is to select a
> clock rate that is closest to but less than the requested rate.
> 
> Add the ccu_is_better_rate() helper function that - depending on the
> fact if thc CCU_FEATURE_CLOSEST_RATE flag is set - decides if a rate is
> closer than another rate.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_common.c | 12 ++++++++++++
>  drivers/clk/sunxi-ng/ccu_common.h |  5 +++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_common.c
> b/drivers/clk/sunxi-ng/ccu_common.c index 8d28a7a079d0..8babce55302f 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.c
> +++ b/drivers/clk/sunxi-ng/ccu_common.c
> @@ -39,6 +39,18 @@ void ccu_helper_wait_for_lock(struct ccu_common *common,
> u32 lock) }
>  EXPORT_SYMBOL_NS_GPL(ccu_helper_wait_for_lock, SUNXI_CCU);
> 
> +bool ccu_is_better_rate(struct ccu_common *common,
> +			unsigned long target_rate,
> +			unsigned long current_rate,
> +			unsigned long best_rate)
> +{
> +	if (common->features & CCU_FEATURE_CLOSEST_RATE)
> +		return abs(current_rate - target_rate) < abs(best_rate - 
target_rate);
> +
> +	return current_rate <= target_rate && current_rate > best_rate;
> +}
> +EXPORT_SYMBOL_NS_GPL(ccu_is_better_rate, SUNXI_CCU);
> +
>  /*
>   * This clock notifier is called when the frequency of a PLL clock is
>   * changed. In common PLL designs, changes to the dividers take effect
> diff --git a/drivers/clk/sunxi-ng/ccu_common.h
> b/drivers/clk/sunxi-ng/ccu_common.h index 5ad219f041d5..942a72c09437 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.h
> +++ b/drivers/clk/sunxi-ng/ccu_common.h
> @@ -53,6 +53,11 @@ struct sunxi_ccu_desc {
> 
>  void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock);
> 
> +bool ccu_is_better_rate(struct ccu_common *common,
> +			unsigned long target_rate,
> +			unsigned long current_rate,
> +			unsigned long best_rate);
> +
>  struct ccu_pll_nb {
>  	struct notifier_block	clk_nb;
>  	struct ccu_common	*common;





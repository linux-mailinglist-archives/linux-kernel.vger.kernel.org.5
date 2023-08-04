Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B476FE22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHDKHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjHDKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:07:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7549FE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:07:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-317715ec496so1710465f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691143625; x=1691748425;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=klbDsLcbssIZC1W6RhXqBdxY/IuELEv3DuGedgA5eC8=;
        b=agyK7FVLVoIYjvTPrq2C1JXIerGnElJX2W2PuvJXMEKnB8HkWcBlCTn+m8s2PuiUjt
         RuCAhhWhnouWxd4I98kiDSIFKPHSRzkGMWoU2I9DKvcUsFc/7Qj+hX7/kCiGqcEJmwVN
         GjnkvyolVccIktZ69hvwXAqSK4Gcb65vKw92hW/4xwEDyAlAX4d7He2SAbhkPiIePxzl
         y9yp8CGE4XlxsFM2Jkbzeifu1yUt0WRq3K+GStdEZ1ysBkwr7IO29cyo593poBdEU57+
         m+SUuTKIStt3yo5A9Fy26P9C9HRjd+AlhQZN7s1ltu3NUGpwevwGGkpgg3X1TEqZKAEz
         Vv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143625; x=1691748425;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klbDsLcbssIZC1W6RhXqBdxY/IuELEv3DuGedgA5eC8=;
        b=Gmo3mCmwho7pA7f+kDAx0XpEU373WrZO6a2aRx+d7Q94uLOPnJAT13iUqJb13P37UV
         QQkjPvknYIeiiUp5MJn8umWjnmueZbDIKYUeZp+rKzK51VwOiOervYP8Xi5PJCf6l4lg
         ptQg2I817zV675GDDE7JHIXpuZW6P8FVEEYPz7E1UKMN5oPfaW9PBDM34/TKy8HUdmsI
         EnLn/D/zo1kjkKvgs3WjZB9SAPaLjwcDui6nwCZIs86jntfMbX/N8zpmO2LRGAWJzp4r
         SCyfsR/GYLUCH64oz+BwYnXVy5BsdN2h3tFsstRW1zc1xBBXLJVj1lq1b1Dzj3kBOzkr
         Po+g==
X-Gm-Message-State: AOJu0YwWbchPzOnHht9urojFuq6Zo1yScIIUxWXEwLUVx8hhGxPd0aQ+
        iLIDpgnUdCxx/Nj/hlO7Yp5BmQ==
X-Google-Smtp-Source: AGHT+IE3TR/pQHzsEG8z5C8nmqBMTuqYmNIpXJqYn1NOZwVrxXcnd7FP7J82dM5yIVqspzDEgaqXNQ==
X-Received: by 2002:adf:ea0a:0:b0:317:6348:8a9d with SMTP id q10-20020adfea0a000000b0031763488a9dmr1025869wrm.66.1691143625382;
        Fri, 04 Aug 2023 03:07:05 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:aeaf:609a:5eef:39a8])
        by smtp.gmail.com with ESMTPSA id d10-20020adffd8a000000b003143ba62cf4sm2087969wrr.86.2023.08.04.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:07:05 -0700 (PDT)
References: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org>
 <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-4-762219fc5b28@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 4/9] clk: meson: g12a: make VCLK2 and ENCL clock path
 configurable by CCF
Date:   Fri, 04 Aug 2023 12:04:34 +0200
In-reply-to: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-4-762219fc5b28@linaro.org>
Message-ID: <1jwmybnmt3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 03 Aug 2023 at 14:03, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> In order to setup the DSI clock, let's make the unused VCLK2 clock path
> configuration via CCF.
>
> The nocache option is removed from following clocks:
> - vclk2_sel
> - vclk2_input
> - vclk2_div
> - vclk2
> - vclk_div1
> - vclk2_div2_en
> - vclk2_div4_en
> - vclk2_div6_en
> - vclk2_div12_en
> - vclk2_div2
> - vclk2_div4
> - vclk2_div6
> - vclk2_div12
> - cts_encl_sel
>
> vclk2 and vclk2_div uses the newly introduced vclk regmap driver
> to handle the enable and reset bits.
>
> In order to set a rate on cts_encl via the vclk2 clock path,
> the NO_REPARENT flag is set on cts_encl_sel & vclk2_sel in order
> to keep CCF from selection a parent.
> The parents of cts_encl_sel & vclk2_sel are expected to be defined
> in DT.
>
> The following clock scheme is to be used for DSI:
>
> xtal
> \_ gp0_pll_dco
>    \_ gp0_pll
>       |- vclk2_sel
>       |  \_ vclk2_input
>       |     \_ vclk2_div
>       |        \_ vclk2
>       |           \_ vclk2_div1
>       |              \_ cts_encl_sel
>       |                 \_ cts_encl	-> to VPU LCD Encoder
>       |- mipi_dsi_pxclk_sel
>       \_ mipi_dsi_pxclk_div
>          \_ mipi_dsi_pxclk		-> to DSI controller
>
> The mipi_dsi_pxclk_div is set as RO in order to use the same GP0
> for mipi_dsi_pxclk and vclk2_input.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/g12a.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 5d62134335c1..552c8efb1ad8 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -22,6 +22,7 @@
>  #include "clk-regmap.h"
>  #include "clk-cpu-dyndiv.h"
>  #include "vid-pll-div.h"
> +#include "vclk.h"
>  #include "meson-eeclk.h"
>  #include "g12a.h"
>  
> @@ -3165,7 +3166,7 @@ static struct clk_regmap g12a_vclk2_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = g12a_vclk_parent_hws,
>  		.num_parents = ARRAY_SIZE(g12a_vclk_parent_hws),
> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>  	},
>  };
>  
> @@ -3193,7 +3194,7 @@ static struct clk_regmap g12a_vclk2_input = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_sel.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,

... oh, I see. Ignore the comment patch #2

>  	},
>  };
>  
> @@ -3215,19 +3216,22 @@ static struct clk_regmap g12a_vclk_div = {
>  };
>  
>  static struct clk_regmap g12a_vclk2_div = {
> -	.data = &(struct clk_regmap_div_data){
> +	.data = &(struct clk_regmap_vclk_div_data){
>  		.offset = HHI_VIID_CLK_DIV,
>  		.shift = 0,
>  		.width = 8,
> +		.enable_bit_idx = 16,
> +		.reset_bit_idx = 17,
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "vclk2_div",
> -		.ops = &clk_regmap_divider_ops,
> +		.ops = &clk_regmap_vclk_div_ops,
>  		.parent_hws = (const struct clk_hw *[]) {
>  			&g12a_vclk2_input.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_GET_RATE_NOCACHE,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -3246,16 +3250,17 @@ static struct clk_regmap g12a_vclk = {
>  };
>  
>  static struct clk_regmap g12a_vclk2 = {
> -	.data = &(struct clk_regmap_gate_data){
> +	.data = &(struct clk_regmap_vclk_data){
>  		.offset = HHI_VIID_CLK_CNTL,
> -		.bit_idx = 19,
> +		.enable_bit_idx = 19,
> +		.reset_bit_idx = 15,
>  	},
>  	.hw.init = &(struct clk_init_data) {
>  		.name = "vclk2",
> -		.ops = &clk_regmap_gate_ops,
> +		.ops = &clk_regmap_vclk_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -3339,7 +3344,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3353,7 +3358,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3367,7 +3372,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3381,7 +3386,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3395,7 +3400,7 @@ static struct clk_regmap g12a_vclk2_div12_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3461,6 +3466,7 @@ static struct clk_fixed_factor g12a_vclk2_div2 = {
>  			&g12a_vclk2_div2_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3474,6 +3480,7 @@ static struct clk_fixed_factor g12a_vclk2_div4 = {
>  			&g12a_vclk2_div4_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3487,6 +3494,7 @@ static struct clk_fixed_factor g12a_vclk2_div6 = {
>  			&g12a_vclk2_div6_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3500,6 +3508,7 @@ static struct clk_fixed_factor g12a_vclk2_div12 = {
>  			&g12a_vclk2_div12_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3561,7 +3570,7 @@ static struct clk_regmap g12a_cts_encl_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = g12a_cts_parent_hws,
>  		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>  	},
>  };
>  
> @@ -3717,7 +3726,7 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = g12a_mipi_dsi_pxclk_parent_hws,
>  		.num_parents = ARRAY_SIZE(g12a_mipi_dsi_pxclk_parent_hws),
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>  	},
>  };
>  
> @@ -3729,7 +3738,7 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_div = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mipi_dsi_pxclk_div",
> -		.ops = &clk_regmap_divider_ops,
> +		.ops = &clk_regmap_divider_ro_ops,
>  		.parent_hws = (const struct clk_hw *[]) {
>  			&g12a_mipi_dsi_pxclk_sel.hw
>  		},


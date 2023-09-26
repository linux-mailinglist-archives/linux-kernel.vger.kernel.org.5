Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B147AE87C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjIZI7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjIZI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:59:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5239193;
        Tue, 26 Sep 2023 01:59:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c16757987fso50187731fa.3;
        Tue, 26 Sep 2023 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695718772; x=1696323572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDxyIanx1EgUP6RwXNa3/gfvrl1yPz037Py9AOoQmr8=;
        b=WKi7/ymGOFSWaZbuwrF6EHR6WhETnz/bGYJgOSYxHtlypivwVwqYiMtvFjR9gmsjNk
         zUGlmLcrkJgMYE5qtl3tYTNa3UcZTchG5P10MaXoojUNyXhc7XwLZWttJhXWZ3rLch4p
         yyhraT1I+kAMG8d5vELgUXJUq0BcR1XS2dnijOslOF2qDsJCgt4kRmU0RTr2deGShmwi
         I3WLuPUSwNKEWDqWYKqhWQrrmuXCm68tyEby1XbHuaO6cheCLMaS5pAirnYbmN+FrvcG
         O5ComA2dn1/0TEiuVU2o754fICcUmjgDZdIYFmEQYFRunVTvIKNrn69yezxfWSxttRL6
         HfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695718772; x=1696323572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDxyIanx1EgUP6RwXNa3/gfvrl1yPz037Py9AOoQmr8=;
        b=C9TEGqZ3W7mn8S38KMqIRpJpud5nW7f2nUPxC74osztYX1LGSlUJ9/8E1QbmXVDbkJ
         SNg2TEg8AmVKfln2oy1VJG88BFhGXHmlXZ2dGsdjy7VBq8Z5ty1oht5EGs9rIC0PD+P0
         7/b9Ugh3Gq7QvIWtkg91RaV6kVLFq4AP4Ex8+LqVLsdfiYfZ3biONIlT7rUbei1AJtlc
         ivW+6/QHwv1Et0ezehu+KoZmqwg2DJyQEMWodcIYiKCt5g+n+oI+sQvTzyL4HMNnTzvd
         E1G7n2cHF+/zSmkCNsWPPfYTa81p+0hS9VjOa+hrmZydQTxFMqJ6Jz7r6ThYVKWIsu9B
         TVhw==
X-Gm-Message-State: AOJu0Yw74xbnlnrGC0F6SYTMMmfNKnwuJCBbjAhlcFsv0+dARDtFdCJN
        h9+HZncJ1yg7FYDd480ls5U=
X-Google-Smtp-Source: AGHT+IFcY99Qsw63+nqFSyAl4/ZRgH21dvMnWnaxUZA3NccBZXaLNtFD9rYkablw31Fpuvzev55HJA==
X-Received: by 2002:a2e:964d:0:b0:2bf:f9b3:d335 with SMTP id z13-20020a2e964d000000b002bff9b3d335mr7914172ljh.15.1695718771564;
        Tue, 26 Sep 2023 01:59:31 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t6-20020a2e9c46000000b002bcda31af28sm2552580ljj.42.2023.09.26.01.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 01:59:31 -0700 (PDT)
Date:   Tue, 26 Sep 2023 11:59:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] spi: dt-bindings: Make "additionalProperties: true"
 explicit
Message-ID: <666tt3bztep2zapk7o7h2psx32z53leitd4sm6xicxlhxhf4pv@vm6e32xszxq2>
References: <20230925212614.1974243-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925212614.1974243-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:26:00PM -0500, Rob Herring wrote:
> Make it explicit that child nodes have additional properties and the
> child node schema is not complete. The complete schemas are applied
> separately based the compatible strings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

For the DW APB/AHB SSI bindings:
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml        | 2 ++
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml        | 2 ++
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
>  Documentation/devicetree/bindings/spi/rockchip-sfc.yaml         | 2 ++
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 2 ++
>  5 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
> index a6f34bdd1d3c..e1ab3f523ad6 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
> @@ -46,6 +46,8 @@ properties:
>  patternProperties:
>    "^.*@[0-9a-f]+":
>      type: object
> +    additionalProperties: true
> +
>      properties:
>        reg:
>          items:
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index 28b8ace63044..3b47b68b92cb 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -68,6 +68,8 @@ properties:
>  patternProperties:
>    "^.*@[0-9a-f]+":
>      type: object
> +    additionalProperties: true
> +
>      properties:
>        reg:
>          items:
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> index 9ae1611175f2..48e97e240265 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -50,6 +50,7 @@ properties:
>  patternProperties:
>    "@[0-9a-f]+$":
>      type: object
> +    additionalProperties: true
>  
>      properties:
>        spi-rx-bus-width:
> diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> index 339fb39529f3..ac1503de0478 100644
> --- a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> +++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> @@ -47,6 +47,8 @@ properties:
>  patternProperties:
>    "^flash@[0-3]$":
>      type: object
> +    additionalProperties: true
> +
>      properties:
>        reg:
>          minimum: 0
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index a47cb144b09f..6348a387a21c 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -160,6 +160,8 @@ properties:
>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> +    additionalProperties: true
> +
>      properties:
>        reg:
>          minimum: 0
> -- 
> 2.40.1
> 

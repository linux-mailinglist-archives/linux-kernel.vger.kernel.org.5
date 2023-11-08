Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C57E5BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjKHRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjKHRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:06:25 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608F1FF9;
        Wed,  8 Nov 2023 09:06:23 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1efb9571b13so4460044fac.2;
        Wed, 08 Nov 2023 09:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463183; x=1700067983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ2/nMs6Yhr8uLWvhSvoVwmUCFZ9QIvsLIyUzisytuo=;
        b=JAiOnSAicbZhZFSXZwGUrsjdFdZ/QIve4EWeYvGUOWGlOyr/qBtFTzi1HIh/U8WGTt
         GSXXe01z2GWFA8mhirrR3wpHmFgfYpxz2wGs7iAXCXPIV6bxNHrcDbsquylO9Kg4nxRW
         yTmi/Kl/JqGU5mPuaXaVlKctQs3oq8C2MUsloj43msw45VQRVCOE4heOZ1gbxNl5+HZq
         Ho6RjUlNIQzQkfHnOFeLr7+dbwbw1XBWoxi6IZ7skXAfAZr1Yn73BywUq4beEYADZxjC
         a/RCaXkABPNhdEPlKrcjqpX+jlmyLFR85q7XkKpNpVEALezswYX0ysMLM3mfKhenEVZV
         M4VA==
X-Gm-Message-State: AOJu0Yyi3xkfJLVYh9uPTM1aL/DpSORtDWDXpsLDIm1oSB86Do/+3+io
        2WLHoOQhCZ79s+FNfPpG+aO4n/GrXA==
X-Google-Smtp-Source: AGHT+IEOaDEK1hhUOVnQKXn6NQZy8cHEJSI37j2QsJ/ZyCIwLP3zjaw2qRMcFv8I7yZh5+9SjZd/9g==
X-Received: by 2002:a05:6870:63a8:b0:1ea:3e52:b66e with SMTP id t40-20020a05687063a800b001ea3e52b66emr3089914oap.41.1699463182820;
        Wed, 08 Nov 2023 09:06:22 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ef4-20020a0568701a8400b001efb3910402sm375323oab.0.2023.11.08.09.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:06:22 -0800 (PST)
Received: (nullmailer pid 2432899 invoked by uid 1000);
        Wed, 08 Nov 2023 17:06:21 -0000
Date:   Wed, 8 Nov 2023 11:06:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Message-ID: <20231108170621.GA2417622-robh@kernel.org>
References: <20231106103259.703417-1-jbrunet@baylibre.com>
 <20231106103259.703417-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106103259.703417-3-jbrunet@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:32:49AM +0100, Jerome Brunet wrote:
> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
> 
> The previous clock bindings for these SoCs described the driver and not the
> HW itself. The clock provided was used to set the parent of the input clock
> mux among the possible parents hard-coded in the driver.
> 
> The new bindings allows to describe the actual clock inputs of the PWM in
> DT, like most bindings do, instead of relying of hard-coded data.
> 
> The new bindings make the old one deprecated.
> 
> There is enough experience on this HW to know that the PWM is exactly the
> same all the supported SoCs. There is no need for a per-SoC compatible.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 754b70fc2db0..3aa522c4cae4 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -22,6 +22,7 @@ properties:
>            - amlogic,meson-g12a-ao-pwm-ab
>            - amlogic,meson-g12a-ao-pwm-cd
>            - amlogic,meson-s4-pwm
> +          - amlogic,meson8-pwm-v2
>        - items:
>            - const: amlogic,meson-gx-pwm
>            - const: amlogic,meson-gxbb-pwm
> @@ -37,7 +38,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 4
>  
>    clock-names:
>      minItems: 1
> @@ -70,11 +71,14 @@ allOf:
>                - amlogic,meson-gx-pwm
>                - amlogic,meson-gx-ao-pwm
>      then:
> -      # Historic bindings tied to the driver implementation
> +      # Obsolete historic bindings tied to the driver implementation
>        # The clocks provided here are meant to be matched with the input
>        # known (hard-coded) in the driver and used to select pwm clock
>        # source. Currently, the linux driver ignores this.
> +      deprecated: true
>        properties:
> +        clocks:
> +          maxItems: 2
>          clock-names:
>            oneOf:
>              - items:
> @@ -83,6 +87,26 @@ allOf:
>                  - const: clkin0
>                  - const: clkin1
>  
> +  # Newer binding where clock describe the actual clock inputs of the pwm
> +  # block. These are necessary but some inputs may be grounded.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8b-pwm-v2
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          items:
> +            - description: input clock 0 of the pwm block
> +            - description: input clock 1 of the pwm block
> +            - description: input clock 2 of the pwm block
> +            - description: input clock 3 of the pwm block
> +      required:
> +        - clocks

Again, clock-names?

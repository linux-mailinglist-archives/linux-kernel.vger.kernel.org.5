Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5186E80714B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378664AbjLFNxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378633AbjLFNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:53:09 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70AA4;
        Wed,  6 Dec 2023 05:53:14 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b84e328327so4107432b6e.2;
        Wed, 06 Dec 2023 05:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870793; x=1702475593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELAnzgA5DxDxpCpfzQO17fyyUMvM5sG9LtRZSNKeVTs=;
        b=jaNHeYQrQ3G5640sj2BCWSIUkdQMoyNnua+BLdjlHAs3E/Q1CT75FBjqSbgIA/uLnQ
         cgs0tBqkhiza8lOXWC0x0Q4W5Qfuem9TDWxQw58wcVCP+QUahCmrrl5Sb9U2Xwi+Ez4B
         NlFDWUwugE3oKaFhll5AeW72NLyCYyHJ4ggsi9NMpr/Ygx3LZwBzyBjvGYjS5xxQc2rO
         RQ+3+rvBhmODOnAUSi3hhhklrV083FuCX3lrRZTUu2EQq6rbT76KN8/qL3zMubJtOqmN
         BegjkTNohaEE5YtKzfOWZeotvkM1aXIP4eLZxX8UwlPuw9Pe0/8+CWlbi0v2N+f10k/m
         2D9w==
X-Gm-Message-State: AOJu0YypRurF8pxrbO0nYb0042lukWSfgEk5PKFncb41i90yC/WYyg5Z
        7fK2hq+QkgYqFXtvWeV0/WQ4CE7xbA==
X-Google-Smtp-Source: AGHT+IEVaa/iHpBSbWcNgoXvomDJzk20fAqRd+fvaRNdmt3y7YPgh2MfstnaZSYrJPliRoSiim9bqg==
X-Received: by 2002:a05:6808:318b:b0:3b8:b55a:84aa with SMTP id cd11-20020a056808318b00b003b8b55a84aamr1125383oib.43.1701870793491;
        Wed, 06 Dec 2023 05:53:13 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm19-20020a0568081a9300b003b9d36eb9c4sm65604oib.57.2023.12.06.05.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:53:12 -0800 (PST)
Received: (nullmailer pid 2045482 invoked by uid 1000);
        Wed, 06 Dec 2023 13:53:11 -0000
Date:   Wed, 6 Dec 2023 07:53:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
Message-ID: <20231206135311.GA2043711-robh@kernel.org>
References: <20231204144429.45197-1-linux.amoon@gmail.com>
 <20231204144429.45197-2-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204144429.45197-2-linux.amoon@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:14:25PM +0530, Anand Moon wrote:
> Add the binding example for the USB3.1 Genesys Logic GL3523
> integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> hub.
> 
> For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> with shared resets and power supplies, this property is used to identify
> the hubs with which these are shared.
> 
> GL3523 has built-in 5V to 3.3V and 5V to 1.2V regulators, which serves
> power to the USB HUB, it uses 5V power regulator.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V6: fix the description of the regulators
> Updated the commit message for regulator updates.
> add reviewed by Conor Dooley
> [1] https://lore.kernel.org/all/20231130053130.21966-2-linux.amoon@gmail.com/
> v5: upgrade peer-hub description : Conor Dooley
> [0] https://www.genesyslogic.com.tw/en/product_view.php?show=67 [Block Diagram]
> v4: Fix the description of peer-hub and update the commit message.
> Schematics of the Odroid N2+
> https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
> V3: fix the dt_binding_check error, added new example for Genesys GL3523
> v2: added Genesys GL3523 binding
> v1: none
> ---
>  .../bindings/usb/genesys,gl850g.yaml          | 65 +++++++++++++++++--
>  1 file changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> index ee08b9c3721f..c6f63a69396d 100644
> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
>  maintainers:
>    - Icenowy Zheng <uwu@icenowy.me>
>  
> -allOf:
> -  - $ref: usb-device.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -27,12 +24,46 @@ properties:
>  
>    vdd-supply:
>      description:
> -      the regulator that provides 3.3V core power to the hub.
> +      The regulator that provides 3.3V or 5.0V core power to the hub.
> +
> +  peer-hub:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> +      with shared resets and power supplies, this property is used to identify
> +      the hubs with which these are shared.
>  
>  required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - $ref: usb-device.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - usb5e3,608
> +    then:
> +      properties:
> +        peer-hub: false
> +        vdd-supply: false
> +        reset-gpios: true
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - usb5e3,610
> +              - usb5e3,620
> +    then:
> +      properties:
> +        peer-hub: true
> +        vdd-supply: true
> +        reset-gpios: true

No need for this if schema. The default is they are allowed.

Rob

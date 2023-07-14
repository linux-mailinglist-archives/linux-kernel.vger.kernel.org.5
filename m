Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6479E754069
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjGNRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjGNRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:24:48 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D56F359F;
        Fri, 14 Jul 2023 10:24:47 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78654448524so84110739f.2;
        Fri, 14 Jul 2023 10:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355487; x=1691947487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38SB8JSzOcrI7IJ42Nd3yrcEKyK7JHRpErlbmfrx1QM=;
        b=IFHlsFRi5A8Ypk73xX5Y2EU5uoXdG9OSeBoq4Jrsd0ai+NyGLKmlzZh08DABKIfJO2
         C4HwnPqh8bgSaN17Yp4GbnOKLi6VUO7ml9GX+AzJ61hA8hiQZ9Go1Q70i2zG9WAac1X1
         UjE2jH8xhfjp/fIQI/BAWfpoGwa5fxpzYB8ZSM/e/0JWMQtOIPNAUTX4MXfic6XJ+Zyf
         FQcCU72PjX0vkb1+0gHVB/gfvoM4bawe9Al8WGkQi+Gpq8srCKDzU0pZaP91kwSA38Yt
         EMC1q2smOcUosDHg0w/4AEqSY7AMgULOzPhTSOexZejW63lEYe1ic6Q6GSaQK2xoRvf/
         ipFg==
X-Gm-Message-State: ABy/qLafDmh9CnWaiNi7+6MUqiPl58+DqqkrDt5zDbYXTTSxd0GTtBLg
        Gcfo4X1y/SOfLi1yIX+T0Q==
X-Google-Smtp-Source: APBJJlHjy7NQb45aTJubpQC/KkFW4I126CzjwcHnZGS3P92nyelRg6dygeLUfW1iOMQHcZqRO1g6jg==
X-Received: by 2002:a6b:c40a:0:b0:783:344d:6b46 with SMTP id y10-20020a6bc40a000000b00783344d6b46mr5039194ioa.21.1689355486815;
        Fri, 14 Jul 2023 10:24:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u6-20020a02cb86000000b0042b298507b3sm2722992jap.42.2023.07.14.10.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:24:46 -0700 (PDT)
Received: (nullmailer pid 4013008 invoked by uid 1000);
        Fri, 14 Jul 2023 17:24:44 -0000
Date:   Fri, 14 Jul 2023 11:24:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
Message-ID: <20230714172444.GA4003281-robh@kernel.org>
References: <20230713202123.231445-1-alex@shruggie.ro>
 <20230713202123.231445-2-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713202123.231445-2-alex@shruggie.ro>
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

On Thu, Jul 13, 2023 at 11:21:23PM +0300, Alexandru Ardelean wrote:
> For VSC8351 and similar PHYs, a new property was added to generate a clock
> signal on the CLKOUT pin.

Sorry, didn't think about it on v1, but I would imagine other vendors' 
PHYs have similar functionality. We should have something common. We 
have the clock binding for clocks already, so we should consider if 
that should be used here. It may look like an overkill for what you 
need, but things always start out that way. What if you want to turn the 
clock on and off as well?

> This change documents the change in the device-tree bindings doc.

That's obvious.

> 
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
> 
> Changelog v1 -> v2:
> * https://lore.kernel.org/netdev/20230706081554.1616839-2-alex@shruggie.ro/
> * changed property name 'vsc8531,clkout-freq-mhz' -> 'mscc,clkout-freq-mhz'
>   as requested by Rob
> * added 'net-next' tag as requested by Andrew
> 
>  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 0a3647fe331b..085d0e8a834e 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -31,6 +31,10 @@ Optional properties:
>  			  VSC8531_LINK_100_ACTIVITY (2),
>  			  VSC8531_LINK_ACTIVITY (0) and
>  			  VSC8531_DUPLEX_COLLISION (8).
> +- mscc,clkout-freq-mhz	: For VSC8531 and similar PHYs, this will output
> +			  a clock signal on the CLKOUT pin of the chip.
> +			  The supported values are 25, 50 & 125 Mhz.
> +			  Default value is no clock signal on the CLKOUT pin.
>  - load-save-gpios	: GPIO used for the load/save operation of the PTP
>  			  hardware clock (PHC).
>  
> @@ -69,5 +73,6 @@ Example:
>                  vsc8531,edge-slowdown	= <7>;
>                  vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
>                  vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
> +                mscc,clkout-freq-mhz	= <50>;
>  		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
>          };
> -- 
> 2.41.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244837C77F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347397AbjJLUju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344197AbjJLUjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:39:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C71CA;
        Thu, 12 Oct 2023 13:39:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF8C433C7;
        Thu, 12 Oct 2023 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143186;
        bh=YJviJ9TTXMty5MqtVYmE4vtdJQJkkUbztuRoWP9UlcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=at49mz3jeCld/u54898zJStVhF4+Y+EwX4Yb22QzIgeQvAcezYRKVRa5Kv4u8DelW
         hP1PsSWyh3/Xh6l+OBU3PEk8vVwnXTy9N2d+i9O+pQEn0IafYIff1EOg6pubdT/wKU
         c65SiUTcwippzl3SMLiCrYCCxKLYt1mVeZ3wABsHN4XXgmyjpCgA0EgzeCAcibkarJ
         9bvAafoc3N+AgFhuMi+SAtFoC/xe2XJKd6U5zSJMjWKTW7NgJ5Dw6Bj0/f/gUEk+vJ
         4iE4jkwsXwS+WUBlS+cZ5EOB4nKitm2YG1peZ+F2kXqqLtrhI99KDcNa+ctCC1pD2k
         eZpCZMiSkyQBA==
Received: (nullmailer pid 1703831 invoked by uid 1000);
        Thu, 12 Oct 2023 20:39:44 -0000
Date:   Thu, 12 Oct 2023 15:39:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1
 system-management node
Message-ID: <20231012203944.GA1699468-robh@kernel.org>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-2-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011090510.114476-2-ychuang570808@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:05:07AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add compatible 'syscon' to the system-management node.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml        | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> index 34c5c1c08ec1..3ce7dcecd87a 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      items:
>        - const: nuvoton,ma35d1-reset
> +      - const: syscon

Presumably you already have a driver for nuvoton,ma35d1-reset, so just 
make it create a regmap. I assume this is the reason you want to add 
'syscon'?

Rob

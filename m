Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1C75C9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGUOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGUOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143630C4;
        Fri, 21 Jul 2023 07:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F9461CD4;
        Fri, 21 Jul 2023 14:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97CDC433CB;
        Fri, 21 Jul 2023 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949476;
        bh=f5CmuKxpJu9jR+oixBzVmJVKyjN2Z5YWoED2/Oqe//8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGgQ/hDou9SKGtlP/OvopQ6cIKkLxeRwlf02RcsRiUj6Hx7Hpm/YVg9dyxwGboy9X
         01nmDjExuidnMQQlZ41rLyyK4dSrbo4RQ/GJQYzKqK36AIewcUCkzct5UtgC87U3RK
         CTD5tseiGBR6IoyoOn0WMc1Bqj+pawVctnpJp3ui0HzwkIJdib2mydJYbhOf3rrYS3
         /zhwvXN1LssqjfFrqXKseCy3MmbFHU4/djIn9sjdI2G4c2eYvCOJemRES5ry1bkRoq
         KcPTomxYUs2rw3LqEc2wzwzv/pwJO6bQlYENadqB3ME3eIB5NC8ZjtrLWjIRHDyRgr
         2IKqlCN0zsZpA==
Received: (nullmailer pid 1079108 invoked by uid 1000);
        Fri, 21 Jul 2023 14:24:33 -0000
Date:   Fri, 21 Jul 2023 08:24:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: snps,dwmac: add
 phy-supply support
Message-ID: <20230721142433.GA1012219-robh@kernel.org>
References: <20230721110345.3925719-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721110345.3925719-1-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:03:43PM +0200, Marco Felsch wrote:
> Document the common phy-supply property to be able to specify a phy
> regulator.

What common property? I don't see any such property in 
ethernet-controller.yaml.

> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changelog:
> v4:
> - no changes
> v3:
> - no changes
> v2
> - add ack-by
> 
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc23..847ecb82b37ee 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -160,6 +160,9 @@ properties:
>        can be passive (no SW requirement), and requires that the MAC operate
>        in a different mode than the PHY in order to function.
>  
> +  phy-supply:
> +    description: PHY regulator

Is this for an serdes, sgmii, etc. type phy or ethernet phy? Either way, 
this property belongs in the PHY's node because it is the PHY that has 
supply connection. I'm guessing you put this here for the latter case 
because ethernet PHYs on MDIO are "discoverable" except for the small 
problem that powering them on is not discoverable. 

Rob

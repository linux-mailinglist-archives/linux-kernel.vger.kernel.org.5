Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8001D782F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjHURep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjHURep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8578F7;
        Mon, 21 Aug 2023 10:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 585B46408B;
        Mon, 21 Aug 2023 17:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C4CC433C7;
        Mon, 21 Aug 2023 17:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692639282;
        bh=s+/xqjg7X5KwSvn6RZv3TdvG5pAi5ArV5S810IETFV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Laiy+1+YHu2bGlgIoy0SKeyPtn4QGYk8vLhYZ+GfQ2rY33FsnvgXg1YQTnWdIocFV
         KJU8ED58mqu4ydAs3NFTO8vdXGadzFyuKrtZMG81xob5P1m+I9eg/7LB7mnMVtVc7H
         Ch5tAL9siTlSkngrNtSS2S/N3byBXSpCu3CjEW9+KN4O1eD47agyE+j5cP0rPl76tN
         +vCCQeIisPwrswhm/LYhaDdmFLr/xlTHjQk+x6NGktp4o1eIqPbYycIo7u4lWwKSYR
         CXJGnzIAIajhWjwX2dNyC4ASP68EkX/xCsNP72P1FKtWyIBnDB8fWW8omSPV/G4U68
         EKHxorSbC8gRQ==
Received: (nullmailer pid 2005872 invoked by uid 1000);
        Mon, 21 Aug 2023 17:34:40 -0000
Date:   Mon, 21 Aug 2023 12:34:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] dt-bindings: sound: sun4i-i2s: Add channel-dins
 property
Message-ID: <20230821173440.GA2002457-robh@kernel.org>
References: <20230811201406.4096210-1-contact@jookia.org>
 <20230811201406.4096210-7-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811201406.4096210-7-contact@jookia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 06:14:05AM +1000, John Watts wrote:
> The R329 variant of the sun4i I2S controller supports multiple
> data input pins (din pins) for receiving data. Each channel can have
> its data input pin configured.
> 
> Allow this to be configured using a new channel-dins property.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  .../sound/allwinner,sun4i-a10-i2s.yaml        | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
> index 739114fb6549..402549f9941c 100644
> --- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
> @@ -52,6 +52,13 @@ properties:
>        - const: apb
>        - const: mod
>  
> +  channel-dins:

Needs a vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description:
> +      This is a list of DIN pin numbers, each used for a receiving I2S
> +      channel. Pins are mapped to channels based on array index.
> +      Channel 0 is the first number, then channel 1, and so on.

Constraints on the values? 255 is valid pin number?

> +
>    # Even though it only applies to subschemas under the conditionals,
>    # not listing them here will trigger a warning because of the
>    # additionalsProperties set to false.
> @@ -144,4 +151,19 @@ examples:
>          dma-names = "rx", "tx";
>      };
>  
> +  - |
> +    i2s0_d1: i2s@2032000 {

Drop unused labels.

However, I don't really think adding 1 property justifies a whole other 
example.

> +            #sound-dai-cells = <0>;
> +            compatible = "allwinner,sun20i-d1-i2s",
> +                         "allwinner,sun50i-r329-i2s";
> +            reg = <0x2032000 0x1000>;
> +            interrupts = <0 26 0>;
> +            clocks = <&ccu 86>, <&ccu 82>;
> +            clock-names = "apb", "mod";
> +            resets = <&ccu 34>;
> +            dmas = <&dma 3>, <&dma 3>;
> +            dma-names = "rx", "tx";
> +            channel-dins = /bits/ 8 <0 0 1 1 2 2>;
> +    };
> +
>  ...
> -- 
> 2.41.0
> 

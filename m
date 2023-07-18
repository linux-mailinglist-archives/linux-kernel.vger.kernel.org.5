Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4421B758843
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGRWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGRWJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9421FEA;
        Tue, 18 Jul 2023 15:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AAC61240;
        Tue, 18 Jul 2023 22:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CECC433C7;
        Tue, 18 Jul 2023 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689718126;
        bh=BcSJ+APt15bxTEa2qIWY+dbSjXSa6zCDNvGS//Pq2Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mrz2Gd2AHkJMrJ6fkA1itsrLXUW7EkYGZ0A0UFy/PU40f2AVA4OvFVWYJYmZrX1GL
         fuDhQK+hM7XWG0gIqwYoWOQuvpKPWE3s2Cm2o8aBFO2sd2kZN5o9aqWuunbxoSS2ey
         yXiooGgGiNovpynYnVnQ3ea1VDeh2tmZlSjnRHCNNqMWPQ6fRwN2N6J7b5bIzBlURK
         wub6eymDeU1uRAyRbWXe2rzwv8gOJRt41q47jm90N77uC6309g2YfXf0LbVwjhgN2f
         eSsaZZ/ni74+OpmzyDoB/S73mm7utxpptKLuw8qcYVxJN+lLLByWSlf8Xh1vxRnZ42
         zib9oxJRH4Z0w==
Received: (nullmailer pid 1979772 invoked by uid 1000);
        Tue, 18 Jul 2023 22:08:43 -0000
Date:   Tue, 18 Jul 2023 16:08:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: simple-card: add triggers
 properties
Message-ID: <20230718220843.GA1944897-robh@kernel.org>
References: <20230715083046.108674-1-fido_max@inbox.ru>
 <20230715083046.108674-3-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715083046.108674-3-fido_max@inbox.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 11:30:43AM +0300, Maxim Kochetkov wrote:
> The trigger-start/stop properties allows to specify DAI link
> trigger ordering method.

Obviously. Why do you need these? What problem does it solve?

I don't think these belong in simple-card. What's next? What if you need 
delays between each step? This is the problem with 'simple' or 'generic' 
bindings. It's a never ending addition of properties which are not well 
thought out.

> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  .../bindings/sound/simple-card.yaml           | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index 59ac2d1d1ccf..f1878d470d83 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -99,6 +99,28 @@ definitions:
>      description: the widget names for which pin switches must be created.
>      $ref: /schemas/types.yaml#/definitions/string-array
>  
> +  trigger-start:
> +    description: |-
> +      Start trigger ordering method:
> +      default: Link->Component->DAI
> +      ldc: Link->DAI->Component
> +    $ref: /schemas/types.yaml#/definitions/string
> +    items:
> +      enum:
> +        - default

Why do you need a value of 'default'? What's the default when the 
property is not present?

> +        - ldc
> +
> +  trigger-stop:
> +    description: |-
> +      Stop trigger ordering method:
> +      default: DAI->Component->Link
> +      ldc: Component->DAI->Link
> +    $ref: /schemas/types.yaml#/definitions/string
> +    items:
> +      enum:
> +        - default
> +        - ldc
> +
>    format:
>      description: audio format.
>      items:
> @@ -210,6 +232,10 @@ properties:
>      maxItems: 1
>    simple-audio-card,mic-det-gpio:
>      maxItems: 1
> +  simple-audio-card,trigger-start:
> +    $ref: "#/definitions/trigger-start"
> +  simple-audio-card,trigger-stop:
> +    $ref: "#/definitions/trigger-stop"

Don't continue this 'simple-audio-card,' prefix pattern. With it, no 
other binding can use these properties.

>  
>  patternProperties:
>    "^simple-audio-card,cpu(@[0-9a-f]+)?$":
> @@ -259,6 +285,11 @@ patternProperties:
>          maxItems: 1
>        mic-det-gpio:
>          maxItems: 1
> +      trigger-start:
> +        $ref: "#/definitions/trigger-start"
> +      trigger-stop:
> +        $ref: "#/definitions/trigger-stop"
> +
>  
>      patternProperties:
>        "^cpu(-[0-9]+)?$":
> -- 
> 2.40.1
> 

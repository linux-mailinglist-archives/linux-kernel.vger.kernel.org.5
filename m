Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66FF776766
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjHISfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHISfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98411FCC;
        Wed,  9 Aug 2023 11:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3B66437F;
        Wed,  9 Aug 2023 18:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE32C433C7;
        Wed,  9 Aug 2023 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691606102;
        bh=eWIcFJcIOce9R+MiShzB4DBQliucalbMzrHgeEI0yNM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TRmbA+tv8/5zaarlgznVkhEEdWGtXA3HDVkEqUfiSuKPWBpA4vPxpH8os9hr2wKXB
         SDZOmFaNQ3mjQQSrWR065s4lbKtwUf0co3Do476+Zw8KSspML8IREvBC99j+AHhMg7
         l7zX5j+9e4RtzFBkh+x9c4zI0xrCZWhAK9Czrtm2rw0nNLTiV3lqMUuCPppQVZ/mDl
         XEkCR2M2rHd3GtGDzkrSOEb+1q2Mkbjle3KgpGJFSYE22cgfVbiPbIvbG1nTFQle23
         Bvy926toJrX3HLOGfz8a/k8hdf4UGZjJ583UAg3MXigLTv7OqFSI1hYbFt5ycvbkhO
         LErp1mIecGPRw==
Message-ID: <d6fc0b52-7f0f-ebfb-b4cf-8e4b28f8ee86@kernel.org>
Date:   Wed, 9 Aug 2023 20:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] dt-bindings: leds: add mp3326
Content-Language: en-US
To:     "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>,
        "Leal (Long) Li" <Leal.Li@monolithicpower.com>
References: <fb09088db71f45169739addbaae770be@monolithicpower.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <fb09088db71f45169739addbaae770be@monolithicpower.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 08:39, Yuxi (Yuxi) Wang wrote:
> Add dt-bindings for Monolithic Power System MP3326.
> 
> Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

> ---
>  .../devicetree/bindings/leds/leds-mp3326.yaml | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-mp3326.yaml b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> new file mode 100644
> index 000000000000..3a059340b902
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-mp3326.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for MP3326 from Monolithic Power Systems.

Drop final dot.

> +
> +maintainers:
> +  - Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> +
> +description: |
> +  Bindings for the Monolithic Power Systems MP3326 LED Drivers.

Drop "Bindings for"

> +
> +  For more product information please see the link below:
> +    https://www.monolithicpower.com/en/products/mp3326.html

Missing blank line.

> +properties:
> +  compatible:
> +    const: MPS,MP3326

Do you see anywhere, absolutely anywhere capital letters in compatibles?

> +
> +  reg:
> +    description: I2C slave address of the controller.

Drop description, obvious.

> +    maxItems: 1
> +
> +  led-protect:
> +    description: LED short protection threshold.

Does not look like common property... missing vendor prefix. Use common
unit suffix, so "-microvolt"

> +    enum:
> +      - 0 #2V
> +      - 1 #3V
> +      - 2 #4V
> +      - 3 #5V
> +
> +  switch_status:
> +    description: Master switch for all channels.
> +    enum:
> +      - 0 #close all channels
> +      - 1 #open all channels

This is so bad that actually disappointing...

1. Missing vendor prefix
2. No underscores in properties
3. Missing type/ref
4. And does not look at all as hardware property. Drop.


> +
> +patternProperties:
> +  "^rgb(-[0-9a-f]+)?$":

Aren't these called "led"?

> +    description: RGB group.
> +    type: object
> +    unevaluatedProperties: false

Missing ref to proper LED schema.

> +    properties:
> +      rgb_r:

Nope, nope.

> +        description: Red light of the RGB group.
> +        maxItems: 16
> +        minItems: 1
> +      rgb_g:
> +        description: Green light of the RGB group.
> +        maxItems: 16
> +        minItems: 1
> +      rgb_b:
> +        description: Blue light of the RGB group.
> +        maxItems: 16
> +        minItems: 1
> +      brightness:
> +        description: Brightness of the RGB group.
> +        maxItems: 63
> +        minItems: 0
> +      required:
> +        - rgb_r
> +        - rgb_g
> +        - rgb_b
> +        - brightness
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +    MP3326@30 {

No, this is neither DTS nor proper bindings. Remove all this. Start FROM
SCRATCH from example-schema.yaml. Entirely from scratch.

> +        compatible = "mps,MP3326";
> +        reg = <0x30>;
> +        led-protect =<3>;
> +        switch_status=<1>;
> +
> +        /*RGB group 1*/
> +        rgb1@0{
> +            rgb_r=<1>;

This is not even coding style for DTS...


Best regards,
Krzysztof


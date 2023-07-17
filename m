Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF7F755BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGQGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGQGgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA23E9;
        Sun, 16 Jul 2023 23:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FCED60F5D;
        Mon, 17 Jul 2023 06:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF51BC433CA;
        Mon, 17 Jul 2023 06:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689575760;
        bh=CcL6kmNEqvVjt0DsY1Zq8glXhJJSkIlcA2Roz493NaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L67EcV+jfNrUWt4tNqqN0ZroKPdED1hism02sKPa831oaiwkrfHMlSIEWB7lYUEkm
         vAUFQX+v6zZ6O6GrlhJVkVzs8eaI3G0wSMjZl9r8XBZ0gPrgEd5tBftcQ1jdF3rNQI
         HaXC4oOC3YSzYmdt/oj2co2n314xC87yXIFO4hr/0DE6ca9reWmh5tAjCL8RwghCA7
         5FBq+2TWmgnai2rFnMISYhkN/ZDq7kYWrrPcv/Y5V+R8Ih+hfMuK6ydFANAneCyeyg
         Azp+WFwN46cQcRQxA/kZZFAFPy9QtmVgZxZSgaOyhJ+chB7xXsgyt4fT0dkpPvVPYh
         cuquHQvdnKyWg==
Message-ID: <5e5d1a1e-f106-9dd6-c19e-f933e8e70dd4@kernel.org>
Date:   Mon, 17 Jul 2023 08:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Content-Language: en-US
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1689541455.git.andrea.collamati@gmail.com>
 <a7d5154b-baca-5cef-586e-a1fc211d7202@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <a7d5154b-baca-5cef-586e-a1fc211d7202@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2023 23:26, Andrea Collamati wrote:
> Add documentation for mcp4728
> 
> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>

What changed? Where is the changelog?

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

> ---
>  .../bindings/iio/dac/microchip,mcp4728.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> new file mode 100644
> index 000000000000..c971d34794db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip mcp4728 DAC
> +
> +maintainers:
> +  - Andrea Collamati <andrea.collamati@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4728

No improvements.


> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |
> +      Provides both power and acts as the reference supply on the mcp4728
> +      when Internal Vref is not selected.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mcp4728@60 {

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

All of the comments seem to be ignored. I don't understand why you
decided not to respond to me.

To clarify: there is already binding for it - mcp4725.



Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1D763E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjGZSfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjGZSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:35:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F95626AE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:35:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b974031aeaso929141fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690396511; x=1691001311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qegFHGSehVmB/bKSv5hsbDkHSV7yfpItUCSJOe7Qt94=;
        b=uPzhgrDOy2Fbe/kOcN679VwkLqi/phvKzcLTGFQVBsrLKWp/7baAKEs8U5kX9Jv04z
         f1mmV33fdFv1z2Fne2sT+3MVJydUTrylhmWM11St5erGbASvrja8B4fFN5iUYM5BBTEY
         G1cqlcQDf3/v8Tu2k0uwF029nx4Iq/QJslYzfTpsJL9Khyu41m6HO4L0fJ+9XgwgK4w7
         YF/XLjBkmHd/c+lk9FOlap3GFFf61NAHrEetZGB9PPKDDBpsjZAu65SZvn6dkhw28Ypd
         nP5VbxLmfNE6osYzLC55abeDO1BMC9nVhJRmYy9Cn65adOJwdmU1bhkXL3OCcqsxht2Y
         f7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396511; x=1691001311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qegFHGSehVmB/bKSv5hsbDkHSV7yfpItUCSJOe7Qt94=;
        b=Lnp/bdNdBJJhoPNPUBxp04j/UAZKYgTOyNptPNeVRPr6skyQiDaft4brm17s8e1EOu
         YGru8kYVE+FbFzo2JoY4xubaouVwC8lYDwaTArexloqX/d5yuO7AjA0yNI579spTvixi
         LXBAR9USaTec/ODhbCVa202mYZzobgFtzwDo2q1Wq/tjxrVitl/FxWeB5s1FEUCsd10n
         4qSVNhTiSAyavoUxajpwp86A9XMT/1i9J7ESiC6TBlIx0pkgA/Mrfb6zLTAVgmomXS3F
         78bqr0fa0EoHlVbsEByy7uyWgxKApajLmoGjn5FzTWBhVJ0hmXXlrT7Y5KH1Kw4d8AEW
         CICg==
X-Gm-Message-State: ABy/qLYGV/arL+z57IDrpJBpEbr2JtxCBBAdrBlyD8sH6FHuM+vxjUpg
        AebTvDrolP78E/hC7EESLc9xR2JJZLWSZvcOo4M=
X-Google-Smtp-Source: APBJJlHJSy7HcP2PpQ1ZHF5FFxonujpEo3ZsxvHv78MqUncBYwNTzFw/B56K9sJZKNEv69k7gS+XoA==
X-Received: by 2002:a05:651c:226:b0:2b8:36d4:7b0a with SMTP id z6-20020a05651c022600b002b836d47b0amr2178679ljn.29.1690396511581;
        Wed, 26 Jul 2023 11:35:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906235800b00992acab8c45sm10091069eja.12.2023.07.26.11.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:35:11 -0700 (PDT)
Message-ID: <61fce1da-c8dd-f911-e4bb-b2198612e7c6@linaro.org>
Date:   Wed, 26 Jul 2023 20:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new
 TDD engine driver
Content-Language: en-US
To:     Eliza Balas <eliza.balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230726071103.12172-1-eliza.balas@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726071103.12172-1-eliza.balas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 09:11, Eliza Balas wrote:
> Add device tree documentation for the AXI TDD Core.
> The generic TDD controller is in essence a waveform generator
> capable of addressing RF applications which require Time Division
> Duplexing, as well as controlling other modules of general
> applications through its dedicated 32 channel outputs.
> 
> The reason of creating the generic TDD controller was to reduce
> the naming confusion around the existing repurposed TDD core
> built for AD9361, as well as expanding its number of output
> channels for systems which require more than six controlling signals.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Subject: drop driver. Bindings are for hardware, not drivers... unless
driver is here a hardware term?

> 
> Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> ---
>  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> new file mode 100644
> index 000000000000..1894c1c34d4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml

Why is this in misc? No suitable directory?

> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/adi,axi-tdd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI TDD Core
> +
> +maintainers:
> +  - Eliza Balas <eliza.balas@analog.com>
> +
> +description: |
> +  Bindings for the new generic TDD CORE, which is part of the Analog Devices hdl reference designs.

Drop boiler plate, so "Bindings for the new generic". Instead, describe
the hardware.

> +  For more information see the wiki: https://wiki.analog.com/resources/fpga/docs/axi_tdd

Not enough. Describe it more. Here.

Also, wrap according to Linux style, so at 80.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,axi-tdd-2.00.a

Versioned blocks... https://wiki.analog.com/resources/fpga/docs/axi_tdd
says nothing about 2.00.a


> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: System clock
> +      - description: TDD Core clock
> +
> +  clock-names:
> +    items:
> +      - const: s_axi_aclk
> +      - const: intf_clk
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    tdd: tdd@84a00000 {

Drop label, not used.

> +            compatible = "adi,axi-tdd-2.00.a";

Use 4 spaces for example indentation.

> +            reg = <0x84a00000 0x10000>;
> +            clocks = <&zynqmp_clk_PL0_REF>, <&zynqmp_clk_PL1_REF>;
> +            clock-names = "s_axi_aclk", "intf_clk";
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aee340630eca..280e66ccdd56 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1360,6 +1360,13 @@ F:	Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>  F:	Documentation/hwmon/max31760.rst
>  F:	drivers/hwmon/max31760.c
>  
> +ANALOG DEVICES INC GENERIC TDD ENGINE DRIVER

I am pretty sure G is before M. It's difficult, I know.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c192ac7357683f78c2e6d6e75adfcc29deb8c4ae


Best regards,
Krzysztof


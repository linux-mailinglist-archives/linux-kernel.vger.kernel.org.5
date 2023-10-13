Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262A7C830A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjJMKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJMKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:30:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E9BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:30:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so22253435e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697193031; x=1697797831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+h/kZfTw83QY2/IOa9NtcHwPdk/CMoNteBC37+Wpag=;
        b=zguR//5I3Tyno3W3lGsATOzZ7Zr1EB9aoWttVkhkq/Or+xN1Xsy1nU4viKFf/UkzjP
         68sw86bhKByKj1oyJyjrfSq8x5lcbb4xcdTZkB+aCW7+0c0cehTk0x/lz7NMsK5p+faS
         LFsGsyumXy6Ds8NBnhwCZedD2XT+JqT2M1NRbwCzoIuPzV9vj9oQidRqBJ52mf2Pt9tK
         7DJeDvvFZKC9FFxdDKaTsmQbTdWHEUE48V++VhWht7Y/qobVNyN8ducJr4xby6DXmdL4
         /F59DIOhLZCVvVIVMNNWivAkNEZd3oEKsBy6Kci4RrlIOSwYA/67XWsEY/OInDrra3EF
         t/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697193031; x=1697797831;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+h/kZfTw83QY2/IOa9NtcHwPdk/CMoNteBC37+Wpag=;
        b=TfMni1juF9adRqdRqJy/lmBQj1jcYfeB1xvdYi6peY43VfwUSQNVSBkt4AAHM14I1N
         RMFTyQxUF7Dy4HWHjeJGNWlKHJB4mU1HFrWULv8tMF8Dmcq82A6ij8UrDSRKH1Dsw6aY
         GFWPW91rk7lL28N6Hhv1Qp63xk7Yf6pZoBmk6zvzqPrdZ3ozxRIDGTN4Ujxnt6lJourG
         RmI/nPxzXSY4aaLMsF2cCQuTQVK2urzs8JhfceqpOFoSv9S2OJEfyvek2N4CiT6RH6Qf
         VGhytCygSmC0LVMZglX/hnLVpudNb8oaBpirZTp+h1sOZI7nzKsZL3myjpUDIG08UB8K
         jYmQ==
X-Gm-Message-State: AOJu0YyuIG/6plPutP635HNEbh25MPF05vW77Y2houh42K6AjjuBmtVE
        aX8PBiRI9zzfXD7j0AMOuOLTfg==
X-Google-Smtp-Source: AGHT+IGwtA0NnYLcUmGdfwVOIk0Oc3Dy7n1YZ7YvR8lcmLlYutaWTbhC51lAZTGB3FtU3Th7xolJ1w==
X-Received: by 2002:a05:600c:3652:b0:402:98cd:a3e9 with SMTP id y18-20020a05600c365200b0040298cda3e9mr22441322wmq.32.1697193030972;
        Fri, 13 Oct 2023 03:30:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600001c900b0032179c4a46dsm20484740wrx.100.2023.10.13.03.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 03:30:30 -0700 (PDT)
Message-ID: <02d3fa42-75a3-4f4f-ade6-204c8146d694@linaro.org>
Date:   Fri, 13 Oct 2023 12:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to
 yaml
Content-Language: en-US
To:     Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
 <20231013101450.573-3-praveen.teja.kundanala@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231013101450.573-3-praveen.teja.kundanala@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 12:14, Praveen Teja Kundanala wrote:
> Convert the xlnx,zynqmp-nvmem.txt to yaml.
> 
> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
> ---
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 46 ---------------
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
> deleted file mode 100644
> index 4881561b3a02..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> ---------------------------------------------------------------------------
> -=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
> ---------------------------------------------------------------------------
> -The nvmem_firmware node provides access to the hardware related data
> -like soc revision, IDCODE... etc, By using the firmware interface.
> -
> -Required properties:
> -- compatible: should be "xlnx,zynqmp-nvmem-fw"
> -
> -= Data cells =
> -Are child nodes of silicon id, bindings of which as described in
> -bindings/nvmem/nvmem.txt
> -
> --------
> - Example
> --------
> -firmware {
> -	zynqmp_firmware: zynqmp-firmware {
> -		compatible = "xlnx,zynqmp-firmware";
> -		method = "smc";
> -
> -		nvmem_firmware {
> -			compatible = "xlnx,zynqmp-nvmem-fw";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			/* Data cells */
> -			soc_revision: soc_revision {
> -				reg = <0x0 0x4>;
> -			};
> -		};
> -	};
> -};
> -
> -= Data consumers =
> -Are device nodes which consume nvmem data cells.
> -
> -For example:
> -	pcap {
> -		...
> -
> -		nvmem-cells = <&soc_revision>;
> -		nvmem-cell-names = "soc_revision";
> -
> -		...
> -	};
> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> new file mode 100644
> index 000000000000..e03ed8c32537
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Zynq UltraScale+ MPSoC Non Volatile Memory interface
> +
> +description: |
> +    The ZynqMP MPSoC provides access to the hardware related data
> +    like SOC revision, IDCODE.
> +
> +maintainers:
> +  - Kalyani Akula <kalyani.akula@amd.com>
> +  - Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"

Drop quotes.

> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-nvmem-fw
> +
> +  '#address-cells':
> +    const: 1

Drop

> +
> +  '#size-cells':
> +    const: 1

Drop

> +
> +required:
> +  - compatible

required: block goes after patternProperties: block

> +
> +patternProperties:
> +  "^soc_revision@0$":

Why do you define individual memory cells? Is this part of a binding?
IOW, OS/Linux requires this?

> +    type: object
> +    description:
> +      This node is used to read SOC version and IDCODE of ZynqMP. Read-only.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false

Instead: unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    nvmem_firmware {

Underscores are not allowed in node names.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Look at other files for examples.


> +        compatible = "xlnx,zynqmp-nvmem-fw";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        /* Data cells */
> +        soc_revision: soc_revision@0 {

Drop unused label. No underscores in node names.


Best regards,
Krzysztof


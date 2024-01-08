Return-Path: <linux-kernel+bounces-19254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F3E826A61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C232822C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C517DDBD;
	Mon,  8 Jan 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeSBxLOK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AE1170A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5572a9b3420so4359649a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704705135; x=1705309935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCQW0rkxNEasQRa0C22OqzB0FitOoQqFTHS04U2tYdY=;
        b=qeSBxLOKCUdHdQywvTqF8pEwvCW/YTC4s/DqkBwTqheiLenS0Cf8XSZd8DCW2M/hOk
         z+dnjiIr3tSrYYSnycrC0UrIvvnYjyv3So8QoIDojkk5s/W9qWZq8HxaiI1gljmF6YGY
         KIBiwsTzjVlimQf0r66AJcUDGsV4S+/M2i9DBUIO2ZXv9J+efmTose9gmrvtdPBoPpO0
         YLLnvssErhmpNeC9jKjOVrz3p+DgHpnrC6g5fwkStIwZkXHh0K6QIrDslP0xETd5JWgw
         9mlqRpFgdqR/24iy/PJEzmZzF35wCIfX82NJlDp4HlFbs/iARtcK15SuvEPOXau/HlR9
         DS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705135; x=1705309935;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCQW0rkxNEasQRa0C22OqzB0FitOoQqFTHS04U2tYdY=;
        b=FMED0GmNPflMWhwIVSMVScfMZGWXPQRCab+h/mneUwK7gExDMbiPQIDf2XauE3w3a2
         E41cje8uwiWqAxrsEGPWwdf/v8gdIsAYI4phSHwBP0fVYjbSsTCondUT/9QxnajIh5uX
         oSj54nQImQuEBjuGzksfw2aCtUQ2q5gAbQowL+sbnYbihkaRza8h28cpZ2XtKtpbsSUV
         61nocLnUP6ADm7m9zU8AXZ9QLPrM6gLSANGbYrdyUmFJkJRCUNByQNbL9mwd3NzqD9Ky
         bSLRN5FN8dqeai5+GX4X91lm7NOHAYhPJ9L3Zoj0N/gy6xYskQbEjA3ntisS5lK4aQ2V
         oyUQ==
X-Gm-Message-State: AOJu0YzJibBHQ79DSNMLLj8TqB1I5FCWU4iFZR+DlV4CZVoc+rGIj3XU
	G7qbntdRFctPI/+cmT2B7zNpcWO+ZP1h7Q==
X-Google-Smtp-Source: AGHT+IES+uUFdAzIx140aZM4jNIZGqxQ/hYkygmRqeccf0pP9hb8yw8yxC4/+n1Xm0lWpsGQweS/sw==
X-Received: by 2002:a17:906:7da:b0:a28:7191:b45c with SMTP id m26-20020a17090607da00b00a287191b45cmr3064166ejc.37.1704705134800;
        Mon, 08 Jan 2024 01:12:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id ws6-20020a170907704600b00a2a360d719fsm1708288ejb.221.2024.01.08.01.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 01:12:14 -0800 (PST)
Message-ID: <37949d7b-43d1-4fc2-9c09-fcbcacbfbcfd@linaro.org>
Date: Mon, 8 Jan 2024 10:12:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: fpga: altera: Convert bridge bindings to
 yaml
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <e738a64f742982bba6c7a8ea3cbc660f81316d2b.1704470663.git.michal.simek@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e738a64f742982bba6c7a8ea3cbc660f81316d2b.1704470663.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/01/2024 17:04, Michal Simek wrote:
> Convert Altera's bridges to yaml with using fpga-bridge.yaml.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Thank you for your patch. There is something to discuss/improve.


> -Example:
> -	fpga_bridge3: fpga-bridge@ffc25080 {
> -		compatible = "altr,socfpga-fpga2sdram-bridge";
> -		reg = <0xffc25080 0x4>;
> -		bridge-enable = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> new file mode 100644
> index 000000000000..a3f3fe2729f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml

altr,socfpga-fpga2sdram-bridge.yaml

> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altera-fpga2sdram-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera FPGA To SDRAM Bridge
> +
> +maintainers:
> +  - Xu Yilun <yilun.xu@intel.com>
> +
> +allOf:
> +  - $ref: fpga-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    const: altr,socfpga-fpga2sdram-bridge
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    fpga-bridge@ffc25080 {
> +        compatible = "altr,socfpga-fpga2sdram-bridge";
> +        reg = <0xffc25080 0x4>;
> +        bridge-enable = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> deleted file mode 100644
> index 8b26fbcff3c6..000000000000
> --- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Altera Freeze Bridge Controller Driver
> -
> -The Altera Freeze Bridge Controller manages one or more freeze bridges.
> -The controller can freeze/disable the bridges which prevents signal
> -changes from passing through the bridge.  The controller can also
> -unfreeze/enable the bridges which allows traffic to pass through the
> -bridge normally.
> -
> -Required properties:
> -- compatible		: Should contain "altr,freeze-bridge-controller"
> -- regs			: base address and size for freeze bridge module
> -
> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> -
> -Example:
> -	freeze-controller@100000450 {
> -		compatible = "altr,freeze-bridge-controller";
> -		regs = <0x1000 0x10>;
> -		bridge-enable = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
> new file mode 100644
> index 000000000000..4a89e3980669
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml


altr,freeze-bridge-controller.yaml

> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altera-freeze-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera Freeze Bridge Controller
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Altera Freeze Bridge Controller manages one or more freeze bridges.
> +  The controller can freeze/disable the bridges which prevents signal
> +  changes from passing through the bridge. The controller can also
> +  unfreeze/enable the bridges which allows traffic to pass through the bridge
> +  normally.
> +
> +maintainers:
> +  - Xu Yilun <yilun.xu@intel.com>
> +
> +allOf:
> +  - $ref: fpga-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    const: altr,freeze-bridge-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    fpga-bridge@100000450 {
> +        compatible = "altr,freeze-bridge-controller";
> +        reg = <0x1000 0x10>;
> +        bridge-enable = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> deleted file mode 100644
> index 68cce3945b10..000000000000
> --- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -Altera FPGA/HPS Bridge Driver
> -
> -Required properties:
> -- regs		: base address and size for AXI bridge module
> -- compatible	: Should contain one of:
> -		  "altr,socfpga-lwhps2fpga-bridge",
> -		  "altr,socfpga-hps2fpga-bridge", or
> -		  "altr,socfpga-fpga2hps-bridge"
> -- resets	: Phandle and reset specifier for this bridge's reset
> -- clocks	: Clocks used by this module.
> -
> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> -
> -Example:
> -	fpga_bridge0: fpga-bridge@ff400000 {
> -		compatible = "altr,socfpga-lwhps2fpga-bridge";
> -		reg = <0xff400000 0x100000>;
> -		resets = <&rst LWHPS2FPGA_RESET>;
> -		clocks = <&l4_main_clk>;
> -		bridge-enable = <0>;
> -	};
> -
> -	fpga_bridge1: fpga-bridge@ff500000 {
> -		compatible = "altr,socfpga-hps2fpga-bridge";
> -		reg = <0xff500000 0x10000>;
> -		resets = <&rst HPS2FPGA_RESET>;
> -		clocks = <&l4_main_clk>;
> -		bridge-enable = <1>;
> -	};
> -
> -	fpga_bridge2: fpga-bridge@ff600000 {
> -		compatible = "altr,socfpga-fpga2hps-bridge";
> -		reg = <0xff600000 0x100000>;
> -		resets = <&rst FPGA2HPS_RESET>;
> -		clocks = <&l4_main_clk>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
> new file mode 100644
> index 000000000000..f8210449dfed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml

altr,socfpga-hps2fpga-bridge.yaml

> @@ -0,0 +1,63 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altera-hps2fpga-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera FPGA/HPS Bridge
> +
> +maintainers:
> +  - Xu Yilun <yilun.xu@intel.com>
> +
> +allOf:
> +  - $ref: fpga-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - altr,socfpga-lwhps2fpga-bridge
> +      - altr,socfpga-hps2fpga-bridge
> +      - altr,socfpga-fpga2hps-bridge
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/altr,rst-mgr.h>
> +
> +    fpga-bridge@ff400000 {
> +      compatible = "altr,socfpga-lwhps2fpga-bridge";
> +      reg = <0xff400000 0x100000>;
> +      bridge-enable = <0>;
> +      clocks = <&l4_main_clk>;
> +      resets = <&rst LWHPS2FPGA_RESET>;
> +    };
> +
> +    fpga_bridge1: fpga-bridge@ff500000 {
> +      compatible = "altr,socfpga-hps2fpga-bridge";

Just keep one example. They are all "the same".

Best regards,
Krzysztof



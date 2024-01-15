Return-Path: <linux-kernel+bounces-26164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228E82DC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1A61C21C02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757717736;
	Mon, 15 Jan 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJeXsAZ+"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C417984
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55818b733f7so7728347a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705331706; x=1705936506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDEQEBN9gLO6683loCAz8Gcv3e9K7DtmlKI7Bpi49YI=;
        b=jJeXsAZ+olukHyJSC43JwEEKolqnHhjMr3/HQIkT8tvPRGJILxFZKGOM/TWc5ILdj0
         pFy4kLiuqWvys1Eu6VwaREIj0NgPIP5K2406W7mynN4xYHsf6dNHTfaSzJNGc60H+YR/
         z1KqL9OryfbLXGRrb5uLikiryQ8Cx9acyF8Y2MlWZuQzgaI8RqL5mXwrXJwsGuCDtJlD
         vu3PbuAL8BJnD7uAETd1JiYP4R9FGmh0l+tfIEniVnv0ztutvbqQsE6O7196LvrxQt7N
         9sth5X1KEIHrQI2onUlPRi56yYKxMmw9OSXQ3NAB35JrX0y8eYCNByetF7yZ6WNKhjMn
         jn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705331706; x=1705936506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDEQEBN9gLO6683loCAz8Gcv3e9K7DtmlKI7Bpi49YI=;
        b=TPHP2bEBeGWyNZqIFsiNN9zqCWYptJSTo3BCLH8DV0kAScMpbCZG8f/xyUyU7oxEOi
         eIqDrvj+/V76SusT/LzkGrl5Ez810nfujm14WdCqZTVif7VgB3kjJtiK3SlnOWiWV+xc
         VbI9/8uGKaI4IlCqUtWctjjquY13k16Xzq7tCeb30B+Gmx3juAOTM0bXCHcv71q9EWhv
         tK3Xu6vjj0DhV3tZ+SbgLED0WlkbtknAsNjMP0R1yQC0IAPKGUfyTYF3UNbsDl3wZmp5
         sSOyAEK9fAgoEGhq7+7ozMbBEV0S1cOTUdZzU2CvyOW8R0eFJLk9JEbz6zXUqm88E2Xe
         3nTQ==
X-Gm-Message-State: AOJu0Yy0a9bPJ2C8VJRWTDSIw0ZFCrPPZGyGw3/zjhRYAqDJh5DHw+ft
	TZ7aURMHYiDmyU8dcL8WgG5ZaNumcJesYQ==
X-Google-Smtp-Source: AGHT+IFy/5kCjTUmSlWt2ID8uQhME/XCKfRmJU7CsIWmN2JCpGLrboapEyArtvQhTUxYpuRHg+cAuQ==
X-Received: by 2002:a50:99d9:0:b0:557:2b83:195 with SMTP id n25-20020a5099d9000000b005572b830195mr3164546edb.38.1705331706392;
        Mon, 15 Jan 2024 07:15:06 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id n7-20020a056402434700b0055915dc8e74sm2715851edc.81.2024.01.15.07.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 07:15:05 -0800 (PST)
Message-ID: <c3c92468-a1db-498b-b4a2-7926b84cb5ea@linaro.org>
Date: Mon, 15 Jan 2024 16:15:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: fpga: Conver fpga-region binding to yaml
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
References: <39e1362352959706b1f67c6feaeec2639ead4610.1705062319.git.michal.simek@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <39e1362352959706b1f67c6feaeec2639ead4610.1705062319.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2024 13:25, Michal Simek wrote:
> Convert the generic fpga region DT binding to json-schema.
> There are some differences compare to txt version.
> 1. DT overlay can't be described in example that's why directly include
> information from overlay to node which was referenced. It is visible in
> example with /* DT Overlay contains: &... */
> 
> 2. All example have been rewritten to be simpler and describe only full
> reconfiguration and partial reconfiguration with one bridge.
> Completely drop the case where fpga region can inside partial
> reconfiguration region which is already described in description
> 
> 3. Fixed some typos in descriptions compare to txt version but most of it
> is just c&p from txt file.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Please let me know if there is a way to describe overlays to dt root to be
> able to reference fpga region back.
> ---

..

> ---
> -[1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
> -[2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
> -[3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> new file mode 100644
> index 000000000000..bf4bb54bfbfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> @@ -0,0 +1,372 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

You relicense the GPL-2.0, so you need to ask all copyright holders to
ack your patch. At least try to identify them...


> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/fpga-region.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FPGA Region
> +
> +maintainers:
> +  - Michal Simek <michal.simek@amd.com>
> +
> +description: |
> +  CONTENTS
> +   - Introduction
> +   - Terminology
> +   - Sequence
> +   - FPGA Region
> +   - Supported Use Models
> +   - Constraints


..


> +  Constraints
> +  ===========
> +
> +  It is beyond the scope of this document to fully describe all the FPGA design
> +  constraints required to make partial reconfiguration work[1] [2] [3], but a few
> +  deserve quick mention.
> +
> +  A persona must have boundary connections that line up with those of the partition
> +  or region it is designed to go into.
> +
> +  During programming, transactions through those connections must be stopped and
> +  the connections must be held at a fixed logic level.  This can be achieved by
> +  FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
> +
> +  --
> +  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
> +  [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
> +  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
> +
> +properties:
> +  $nodename:
> +    pattern: "^fpga-region([0-9]|[1-9][0-9]+)?$"

Missing -:

"^fpga-region(-([0-9]|[1-9][0-9]+))?$"


> +
> +  compatible:
> +    const: fpga-region
> +
> +  ranges: true

This does not feel right - you do not allow any unit address, so ranges
should cause warnings.

> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  config-complete-timeout-us:
> +    description:
> +      The maximum time in microseconds time for the FPGA to go to operating
> +      mode after the region has been programmed.
> +
> +  encrypted-fpga-config:
> +    type: boolean
> +    description:
> +      Set if the bitstream is encrypted.
> +
> +  external-fpga-config:
> +    type: boolean
> +    description:
> +      Set if the FPGA has already been configured prior to OS boot up.
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string

This already has a type: string-array. You need maxItems instead.

> +    description:
> +      Should contain the name of an FPGA image file located on the firmware
> +      search path. If this property shows up in a live device tree it indicates
> +      that the FPGA has already been programmed with this image.
> +      If this property is in an overlay targeting an FPGA region, it is
> +      a request to program the FPGA with that image.
> +
> +  fpga-bridges:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should contain a list of phandles to FPGA Bridges that must be

This says list of phandles, but you allow only one.

> +      controlled during FPGA programming along with the parent FPGA bridge.
> +      This property is optional if the FPGA Manager handles the bridges.
> +      If the fpga-region is  the child of an fpga-bridge, the list should not
> +      contain the parent bridge.
> +
> +  fpga-mgr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should contain a phandle to an FPGA Manager.  Child FPGA Regions
> +      inherit this property from their ancestor regions.  An fpga-mgr property
> +      in a region will override any inherited FPGA manager.
> +
> +  partial-fpga-config:
> +    type: boolean
> +    description:
> +      Set if partial reconfiguration is to be done, otherwise full
> +      reconfiguration is done.
> +
> +  region-freeze-timeout-us:
> +    description:
> +      The maximum time in microseconds to wait for bridges to successfully
> +      become disabled before the region has been programmed.
> +
> +  region-unfreeze-timeout-us:
> +    description:
> +      The maximum time in microseconds to wait for bridges to successfully
> +      become enabled after the region has been programmed.
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object
> +
> +required:
> +  - compatible
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +  - fpga-mgr
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /*
> +     * Full Reconfiguration without Bridges
> +     */
> +    fpga_mgr0: fpga-mgr@f8007000 {
> +      compatible = "xlnx,zynq-devcfg-1.0";
> +      reg = <0xf8007000 0x100>;
> +      clocks = <&clkc 12>;
> +      clock-names = "ref_clk";
> +      interrupt-parent = <&intc>;
> +      interrupts = <0 8 4>;
> +      syscon = <&slcr>;
> +    };
> +
> +    fpga_region0: fpga-region0 {

fpga-region {

> +      compatible = "fpga-region";
> +      ranges;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      fpga-mgr = <&fpga_mgr0>;
> +
> +      /* DT Overlay contains: &fpga_region0 */
> +      firmware-name = "zynq-gpio.bin";
> +      gpio@40000000 {
> +        compatible = "xlnx,xps-gpio-1.00.a";
> +        reg = <0x40000000 0x10000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +      };
> +    };
> +
> +  - |
> +    /*
> +     * Partial reconfiguration with Bridges
> +     */
> +    fpga_mgr1: fpga-mgr@f8007000 {
> +      compatible = "xlnx,zynq-devcfg-1.0";
> +      reg = <0xf8007000 0x100>;
> +      clocks = <&clkc 12>;
> +      clock-names = "ref_clk";
> +      interrupt-parent = <&intc>;
> +      interrupts = <0 8 4>;
> +      syscon = <&slcr>;
> +    };
> +
> +    fpga_bridge1: fpga-bridge@100000450 {
> +      compatible = "xlnx,pr-decoupler-1.00", "xlnx,pr-decoupler";
> +      reg = <0x10000045 0x10>;
> +      clocks = <&clkc 15>;
> +      clock-names = "aclk";
> +    };
> +
> +    fpga_region1: fpga-region1 {

fpga-region {

> +      compatible = "fpga-region";


Best regards,
Krzysztof



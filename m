Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D77CBA99
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjJQGLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQGLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:11:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9BEA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:11:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d9cb5e0fcso3362570f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697523107; x=1698127907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWQrRSxyZxWQXQfkNM8B2PO8+EYitkaZ74T6aQHCXWE=;
        b=IYJzhepdOjbm2Wkbowr2r5MbbWKfOjERwGhqlajlmgg1o3c9G4zLS4yyDUW1bnGMvD
         ynwvNycGyhdvnQJ0z2eWsVvbI7PYo4q68oMRflItNy0S06c9OF3Y2Vf5dqwzsh/vRyJg
         j6+iCy1gtYFwU7mCMO3NWq7Yue4bzySXvn96ooQSuymgoyk6f0baCTzUVt5hqP25/Ww3
         xdksnocTuKBIAS05PiZXtKnBRv02NmI0nGnBPVsegMB3gtJtwmj4GoE/W+9rHDQxu5Em
         DdF0I5aouzC8W55LzXelDRy9JgLd1Aln0BpykfPY8tHY2OGJqubY+zVmXgpz1osLbI/j
         ktUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523107; x=1698127907;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWQrRSxyZxWQXQfkNM8B2PO8+EYitkaZ74T6aQHCXWE=;
        b=tlUq0kRtioGO7Y6ipgHX5Q9zLdGEATvI9czYC25ErnPrM51kpCKF2ZsjGGs1dGc2qX
         aze/QlOEaEFKibVjJwrtQL58vQWFwF9VknixLF9T4NS7apGx0PNvI+nCJmzIlkfsOiQV
         5LxjElpmrg4Lnkfglg9kB7MjXWknjsK5StDKNjaS7x55OpUZPhMBBZ91abyiIFq5MW2Y
         JQbsOcfPhWHogVTZkdH8M3xfWEoyKBj+5xkp6+TZyIKZIHnuYk6mWELPRaMIHArLf+5H
         gUVgcJFmRZF7jBQXxCcfS5+3URwhdCjwIoRFYr0tcS7VO/yzYhL/X/Npl1/NoehjNymc
         rndw==
X-Gm-Message-State: AOJu0YzQH10IaAlcSiaySQm8p+7BxjvYfZ5BJd/jA1w5zUTXyayt4sFW
        bk0STk2UEPRsxuHETMZ0sMSH1Q==
X-Google-Smtp-Source: AGHT+IF7zTSX+tT/iakPNFQ1yaCFozPkYTPJrImivePSS4W7LctjNS6rMwo5cphZrYVK2M4imoeZGg==
X-Received: by 2002:adf:e301:0:b0:313:f0d7:a43 with SMTP id b1-20020adfe301000000b00313f0d70a43mr1279719wrj.23.1697523107356;
        Mon, 16 Oct 2023 23:11:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id o22-20020a5d58d6000000b0031980783d78sm875979wrf.54.2023.10.16.23.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 23:11:46 -0700 (PDT)
Message-ID: <9f53e647-7c38-435f-bc74-e4f417445830@linaro.org>
Date:   Tue, 17 Oct 2023 08:11:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] dt-bindings: usb: qcom,dwc3: Introduce flattened
 qcom,dwc3 binding
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-10-ab4a84165470@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231016-dwc3-refactor-v1-10-ab4a84165470@quicinc.com>
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

On 17/10/2023 05:11, Bjorn Andersson wrote:
> The Qualcomm USB block consists of three intertwined parts, the XHCI,
> the DWC3 core and the Qualcomm DWC3 glue. The three parts can not be
> operated independently, but the binding was for historical reasons split
> to mimic the Linux driver implementation.
> 
> The split binding also makes it hard to alter the implementation, as
> properties and resources are split between the two nodes, in some cases
> with some duplication.
> 
> Introduce a new binding, with a single representation of the whole USB
> block in one node.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         | 482 +++++++++++++++++++++
>  .../devicetree/bindings/usb/snps,dwc3.yaml         |  14 +-
>  2 files changed, 491 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> new file mode 100644
> index 000000000000..cb50261c6a36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -0,0 +1,482 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SuperSpeed DWC3 USB SoC controller
> +
> +maintainers:
> +  - Wesley Cheng <quic_wcheng@quicinc.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      items:
> +        - enum:
> +            - qcom,ipq4019-dwc3
> +            - qcom,ipq5018-dwc3
> +            - qcom,ipq5332-dwc3
> +            - qcom,ipq6018-dwc3
> +            - qcom,ipq8064-dwc3
> +            - qcom,ipq8074-dwc3
> +            - qcom,ipq9574-dwc3
> +            - qcom,msm8953-dwc3
> +            - qcom,msm8994-dwc3
> +            - qcom,msm8996-dwc3
> +            - qcom,msm8998-dwc3
> +            - qcom,qcm2290-dwc3
> +            - qcom,qcs404-dwc3
> +            - qcom,sa8775p-dwc3
> +            - qcom,sc7180-dwc3
> +            - qcom,sc7280-dwc3
> +            - qcom,sc8180x-dwc3
> +            - qcom,sc8280xp-dwc3
> +            - qcom,sc8280xp-dwc3-mp
> +            - qcom,sdm660-dwc3
> +            - qcom,sdm670-dwc3
> +            - qcom,sdm845-dwc3
> +            - qcom,sdx55-dwc3
> +            - qcom,sdx65-dwc3
> +            - qcom,sdx75-dwc3
> +            - qcom,sm4250-dwc3
> +            - qcom,sm6115-dwc3
> +            - qcom,sm6125-dwc3
> +            - qcom,sm6350-dwc3
> +            - qcom,sm6375-dwc3
> +            - qcom,sm8150-dwc3
> +            - qcom,sm8250-dwc3
> +            - qcom,sm8350-dwc3
> +            - qcom,sm8450-dwc3
> +            - qcom,sm8550-dwc3

This enum could be replaced with '{}'. Alternatively, drop enum entire
select replaced with:
- contains
  - items:
      - const: qcom,dwc3
      - const: snps,dwc3



> +        - const: qcom,dwc3
> +        - const: snps,dwc3
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,ipq4019-dwc3
> +          - qcom,ipq5018-dwc3
> +          - qcom,ipq5332-dwc3
> +          - qcom,ipq6018-dwc3
> +          - qcom,ipq8064-dwc3
> +          - qcom,ipq8074-dwc3
> +          - qcom,ipq9574-dwc3
> +          - qcom,msm8953-dwc3
> +          - qcom,msm8994-dwc3
> +          - qcom,msm8996-dwc3
> +          - qcom,msm8998-dwc3
> +          - qcom,qcm2290-dwc3
> +          - qcom,qcs404-dwc3
> +          - qcom,sa8775p-dwc3
> +          - qcom,sc7180-dwc3
> +          - qcom,sc7280-dwc3
> +          - qcom,sc8180x-dwc3
> +          - qcom,sc8280xp-dwc3
> +          - qcom,sc8280xp-dwc3-mp
> +          - qcom,sdm660-dwc3
> +          - qcom,sdm670-dwc3
> +          - qcom,sdm845-dwc3
> +          - qcom,sdx55-dwc3
> +          - qcom,sdx65-dwc3
> +          - qcom,sdx75-dwc3
> +          - qcom,sm4250-dwc3
> +          - qcom,sm6115-dwc3
> +          - qcom,sm6125-dwc3
> +          - qcom,sm6350-dwc3
> +          - qcom,sm6375-dwc3
> +          - qcom,sm8150-dwc3
> +          - qcom,sm8250-dwc3
> +          - qcom,sm8350-dwc3
> +          - qcom,sm8450-dwc3
> +          - qcom,sm8550-dwc3
> +      - const: qcom,dwc3
> +      - const: snps,dwc3
> +
> +  reg:
> +    description: Offset and length of register set for QSCRATCH wrapper
> +    maxItems: 1
> +
> +  power-domains:
> +    description: specifies a phandle to PM domain provider node

Drop description

> +    maxItems: 1
> +
> +  required-opps:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      Several clocks are used, depending on the variant. Typical ones are::
> +       - cfg_noc:: System Config NOC clock.
> +       - core:: Master/Core clock, has to be >= 125 MHz for SS operation and >=
> +                60MHz for HS operation.
> +       - iface:: System bus AXI clock.
> +       - sleep:: Sleep clock, used for wakeup when USB3 core goes into low
> +                 power mode (U3).
> +       - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
> +                     mode. Its frequency should be 19.2MHz.
> +    minItems: 1
> +    maxItems: 9
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 9
> +
> +  resets:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: usb-ddr
> +      - const: apps-usb
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 5
> +
> +  interrupt-names:
> +    minItems: 2
> +    maxItems: 5
> +
> +  qcom,select-utmi-as-pipe-clk:
> +    description:
> +      If present, disable USB3 pipe_clk requirement.
> +      Used when dwc3 operates without SSPHY and only
> +      HS/FS/LS modes are supported.
> +    type: boolean
> +
> +  wakeup-source: true
> +
> +# Required child node:

Drop


...

> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index d81c2e849ca9..d6914b8cef6a 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -44,14 +44,18 @@ properties:
>        It's either a single common DWC3 interrupt (dwc_usb3) or individual
>        interrupts for the host, gadget and DRD modes.
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 5
>  
>    interrupt-names:
> -    minItems: 1
> -    maxItems: 4
>      oneOf:
> -      - const: dwc_usb3
> -      - items:
> +      - minItems: 1
> +        maxItems: 5
> +        items:
> +          - const: dwc_usb3
> +        additionalItems: true

This is not correct change. Before, one dwc_usb3 interrupt was combined
allowed, or a set of host+peripheral+otg+wakeup. Now, you allow combined
dwc_usb3 with anything.



Best regards,
Krzysztof


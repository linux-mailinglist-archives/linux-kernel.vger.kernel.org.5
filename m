Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8007792B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbjIEQyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354478AbjIEL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:59:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D61AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:59:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so3333602a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693915177; x=1694519977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MG0Nhg1W7b5wNWtTY+WBpN6gGjenK9zPawNVXiy4rFs=;
        b=uo4JLLHxcpsZ+1k9YONkNmrTLgejPUYC2PYvYGbpNDFD60K331UgVGJzV/eILmautN
         kTLaxlcpmGZMpGH0jPrHE5KIAq/7am2RgvT+BvQL3RN05zydfM+eaFYN97SjE5rN0c6U
         uGAiN/yPR0mgDHXsB2D1dSEiLNEyxo5hqFgeTVP4bqdIa0Ax/r9Srcd4vULrNMuPznKS
         Xmesb6BLCqyWDol6leWMyUg2ajXu2PtWH58O+nTVekR1H9xxwjc+25CMnSKFHsT4SUyh
         QAvVyFktnsiyDjFGsLh7vntWrIlhYvTmaw/D2l32uNrqVoXWS2a78MNUr+TWffKvrAYW
         UpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693915177; x=1694519977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG0Nhg1W7b5wNWtTY+WBpN6gGjenK9zPawNVXiy4rFs=;
        b=izg+FCpHKBBWLye7D/4PKgW6EWjzz8DsECNlf1rry44hwGw4RgXA/Wilgq/2lhaZNr
         kMthuHWj45z41KYuhlX8uSuqVYFhtmJcCY20u7jzW6hsiTHSX2HWcX3qaocQ4Cw+oE0u
         dL2LMjsG0JbulpBPb15qWjGs8Wg8jFIlKgpDXbbdU3ezUZEthywV+v2IG0V+9qW+waJc
         SsBm0b9KESsZJrMu3A94LHomQA/GgkKmF9hbeiV2y7yJgY6gmVjcQcPe6BGUBwgNRqds
         7wiVMvl0p6HcmlpgYdkXbVY8jnHi/R9PCIPRAhzEKhDC28EYmDMY9BJuBSBSYvttS9X2
         pSYA==
X-Gm-Message-State: AOJu0Yw8/OZIgvsJxJjnSPR+x99hHnHzq90aavS1OQrGXM+lA0FDAWlR
        7BOCzoNGpN2t3uF6NIui3TdeXw==
X-Google-Smtp-Source: AGHT+IE6a1ExoObFvqj+qBBtiUE9AGxJcNNshk+ae8fGtV99y3l1l23ej25irHxV/IdQfF3pH/iM+Q==
X-Received: by 2002:a05:6402:327:b0:524:547b:59eb with SMTP id q7-20020a056402032700b00524547b59ebmr8950570edw.15.1693915177691;
        Tue, 05 Sep 2023 04:59:37 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402069a00b0051e2670d599sm7112416edy.4.2023.09.05.04.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 04:59:37 -0700 (PDT)
Message-ID: <3a4988ae-97d7-66ee-5787-294b1204b1e2@linaro.org>
Date:   Tue, 5 Sep 2023 13:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 1/2] dt-bindings: PCI: ti,j721e-pci-*: Add
 "ti,syscon-pcie-refclk-out" property
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230905114816.2993628-1-a-verma1@ti.com>
 <20230905114816.2993628-2-a-verma1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905114816.2993628-2-a-verma1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 13:48, Achal Verma wrote:
> Added "ti,syscon-pcie-refclk-out" property to specify the ACSPCIE clock
> buffer register offset in SYSCON, which would be used to enable serdes
> reference clock output.
> 
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index a2c5eaea57f5..27bdc52282c4 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -44,6 +44,18 @@ properties:
>            - description: pcie_ctrl register offset within SYSCON
>      description: Specifier for configuring PCIe mode and link speed.
>  
> +  ti,syscon-pcie-refclk-out:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: Phandle to the SYSCON entry
> +          - description: lock2_kick0 register offset within SYSCON
> +          - description: lock2_kick1 register offset within SYSCON
> +          - description: acspcie_ctrl register offset within SYSCON
> +          - description: pcie_refclk_clksel register offset within SYSCON
> +          - description: clock source index to source ref clock
> +    description: Specifier for enabling ACSPCIe clock buffer for reference clock output.

No, syscon is not a way to avoid creating clock/reset/power controllers.
NAK.


>    power-domains:
>      maxItems: 1
>  
> @@ -99,6 +111,7 @@ required:
>    - reg
>    - reg-names
>    - ti,syscon-pcie-ctrl
> +  - ti,syscon-pcie-refclk-out

So an ABI break?

>    - max-link-speed
>    - num-lanes
>    - power-domains
> @@ -153,3 +166,43 @@ examples:
>              dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>          };
>      };
> +
> +  -
> +    #include <dt-bindings/mux/mux.h>
> +    #include <dt-bindings/mux/ti-serdes.h>
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/phy/phy-ti.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie1_rc: pcie@2910000 {
> +                compatible = "ti,j784s4-pcie-host";
> +                reg = <0x00 0x02910000 0x00 0x1000>,

No need for new example. It's anyway wrongly formatted...


Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6E80A1DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573722AbjLHLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjLHLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:09:32 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69110F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:09:38 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-db5311eab29so2066052276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702033777; x=1702638577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W+6I4hiDdnv4ZiBUCigpUef8rfkBrmTbuDLH13/aZAU=;
        b=x1ehbaEm2VR3cEpsz//L5GD9Egd8PhH/A1pQJIzXcgwPRRM13akb9jBGu17FDjbyZk
         DRtKI6Fk3aqQZzZT/9GUFEPwKT5jyDqiY52f5DSuMeohd8h77PwAQ6rgUCVq4jNC6ClO
         BqemzQNalICjVO6KQ72OfbHSioFOQ33fiGIgVHYU7YJIrgJDwLSYaIhgkh5JAUyOmdJS
         fDE3HS6D+QusAUAgnevMYNyZTinUrzMIvqww6NPAeaxpHohqXJEiLHsbUZpLdPO1Z31s
         vqqLLEBaShVaEBMk3AaQR6nwSivd5yM74/ZtJ+Is9KLE7msd92VRyAPjwNZKZqaNlxQF
         eSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033777; x=1702638577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+6I4hiDdnv4ZiBUCigpUef8rfkBrmTbuDLH13/aZAU=;
        b=VN1Hf8lBDQo6oWUM3vgnvbwtatA9MMlgiGgA+6H+r1es3Aiza1hBwXBc/Z5fZgY/DQ
         ELgFbDbZmjW2m3jyXDJNlpPmkgbE9NVcBhR6ILkl06xH1r1OozN06h1MBAQiuQN5JhZk
         topc5FUrOuS14rv0RK1VWuzqPGMQrS9LWVrFbGZX9SsnbEHDSiR1TKWlKFuYHOBN14Kb
         oJXYA98MuHag6wgTLIY1l1L4eNDXI7F53jmJexebSr91OpSXv+ouhCYNKKWrZnZgPImT
         itlmSYoBzl+wp3pgu1+nnUm6DMDM/AHC9CDikP4RWENa/Hoel8DxMMXnBinep0uMopP1
         bEOA==
X-Gm-Message-State: AOJu0Yx323kGBoNjf36eLW/m3Ouj/t4bUXyPJsxB2/gCG0p5EXF0BcQn
        3TyoMS8IUuHnZaw4Hw/hFlvLeidjE+ye2Y+3400lsA==
X-Google-Smtp-Source: AGHT+IE1UQ/9GBLRNmLtO49k8MQX9GWPLfHA1VvWI72wjp9t27xAyw5cLWsq5Zjt6KbfXotzloHsdZhoFr0Qqw9y9KY=
X-Received: by 2002:a25:bfc2:0:b0:db7:dacf:6209 with SMTP id
 q2-20020a25bfc2000000b00db7dacf6209mr3461261ybm.91.1702033777658; Fri, 08 Dec
 2023 03:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org> <20231208105155.36097-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231208105155.36097-3-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:09:26 +0200
Message-ID: <CAA8EJpqKM45=6R0fHjDjNWfZpR-QxRoJo-ioB-t-WT188jpqnA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: qcom: correct clocks for SM8150
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 12:52, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> PCI node in Qualcomm SM8150 should have exactly 8 clocks, including the
> ref clock.
>
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Please take the patch via PCI tree.
>
> Changes in v3:
> 1. New patch: Split from sc8180x change.
> 2. Add refclk as explained here:
>    https://lore.kernel.org/all/20231121065440.GB3315@thinkpad/
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 5214bf7a9045..a93ab3b54066 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -559,6 +559,32 @@ allOf:
>            contains:
>              enum:
>                - qcom,pcie-sm8150
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 8
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: tbu # PCIe TBU clock
> +            - const: ref # REFERENCE clock

Can we change the order of the tbu and ref clocks and fold this into
the sc810x case?

> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
>                - qcom,pcie-sm8250
>      then:
>        oneOf:
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

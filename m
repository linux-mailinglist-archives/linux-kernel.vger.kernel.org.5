Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6158128E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjLNHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjLNHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:15:51 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2322EB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:15:57 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5e248b40c97so22632667b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702538156; x=1703142956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hyuj6L4AEIo77b1y5Vbh5MTrD0n68EvFYvH7xGhCjqA=;
        b=HW2dUlKuh5ESUmOaYRbiyzbvaDRcmFw2QlVR3dGYxoYY67WfLWhwJkf9aMmGkWyTp4
         wsNFeQinxl3D9mBay7BhlCy2dJ1NaVz9AZrFIPikHQeeSKbXfe1fEyDWI5ssjI41YmUa
         yNTIVS/g043RyNT0CLAQkdE2OmqTMuvqsOGX71IqOI51+YPiafFSHg2KfqdN9INXqu5S
         jTS+rFJoSyHZLb1R9tr32CJQe4NuFjNSmwZoPH8+8GicVX12jPv+dr3mO+FsHgrkiU5v
         0EvAoyrZIreVSge7g8N60KOjR1RlNW4Wx0JBYdrubeoRK3HqT6DQpDhyg3YNLA63WjdR
         3nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702538156; x=1703142956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hyuj6L4AEIo77b1y5Vbh5MTrD0n68EvFYvH7xGhCjqA=;
        b=uLoROFOLJTTtKxaQos9/uqbLPn33Qv4AQw4il4qzPFqGA07Q+WDho4q9K4fO3tuQgn
         isltDfqoG1/H0fEw6C1X/WINEuhowbykDUiiUoexDSXCnFt1QB6A0W5POwtdwv1CSCJv
         VvblmGUe1tTkDcZXElvczIn6f1j3AxHJW7i31zXve1ec64gX6OMKgg92EkV5/09uOOWu
         +jOdI/lEMm6GtxqKqXWZMOEMyPyvivEQTUXqwCXNmdOZ0LSPUD/WvI0P/lKsn/dloupC
         qRJ2uxKVxAhcJAX2b7rBoSH5s7eoi5XE086qTnqiwVpoRhjK6BcMU84cqokSqBdbzey0
         vwNA==
X-Gm-Message-State: AOJu0Ywo62sAcs21OfVD+sCgY9qnj8kdMI885jdvP6AkQALYvvDR32+7
        UbErcEvhBJEzD3MxpCxmkotCQe0wJ0izHnYCnFT5dg==
X-Google-Smtp-Source: AGHT+IH3+Sw3exQcLiS7Au2pmyJWOiOy946o670EL9T8G4UD/WLVLtSaMDRzk5R+ja2Q0rT5BFDKfRPi9nleUY6Lf3Q=
X-Received: by 2002:a81:c30e:0:b0:5e3:9b5f:e3f with SMTP id
 r14-20020a81c30e000000b005e39b5f0e3fmr358653ywk.59.1702538156139; Wed, 13 Dec
 2023 23:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com> <20231214062847.2215542-8-quic_ipkumar@quicinc.com>
In-Reply-To: <20231214062847.2215542-8-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 09:15:45 +0200
Message-ID: <CAA8EJppyd5-TQmvzRB3rBhRQtMLdu=6u5aQd5rWHitRuaJXzpA@mail.gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: PCI: qcom: Add IPQ5332 SoC
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
        quic_nsekar@quicinc.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 08:30, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> Add support for the PCIe controller on the Qualcomm
> IPQ5332 SoC to the bindings.
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..af5e67d2a984 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,pcie-apq8064
>            - qcom,pcie-apq8084
>            - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq5332
>            - qcom,pcie-ipq6018
>            - qcom,pcie-ipq8064
>            - qcom,pcie-ipq8064-v2
> @@ -170,6 +171,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-ipq5332
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
>      then:
> @@ -332,6 +334,39 @@ allOf:
>              - const: ahb # AHB reset
>              - const: phy_ahb # PHY AHB reset
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq5332

As you seem to be depending on the ipq9574, could you please reuse the
DT entry too?

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: ahb # AHB clock
> +            - const: aux # Auxiliary clock
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: axi_bridge # AXI bridge clock
> +            - const: rchng
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: sticky # Core sticky reset
> +            - const: axi_m_sticky # AXI master sticky reset
> +            - const: axi_m # AXI master reset
> +            - const: axi_s_sticky # AXI slave sticky reset
> +            - const: axi_s # AXI slave reset
> +            - const: ahb # AHB reset
> +            - const: aux # AUX reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -790,6 +825,7 @@ allOf:
>                enum:
>                  - qcom,pcie-apq8064
>                  - qcom,pcie-ipq4019
> +                - qcom,pcie-ipq5332
>                  - qcom,pcie-ipq8064
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

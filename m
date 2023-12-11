Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0860080D432
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjLKRjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbjLKRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:39:32 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E36FE8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:39:38 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db5e692d4e0so4930333276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702316377; x=1702921177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm/U5iX89/NkKIBpHMc6e7m4WD1ivJqJGvRe8VbK7nY=;
        b=xMk5Kx40uxnogy9AW7ZGbyel1segDScwJiW1q/8+184jID9Hc+mGeFtmnwtQ1IpDQz
         SYMeM/SdNzq99X/NS5fiqnSNzlPmTiOBnRFr+5oxsAhYf0KDA3+C07qcUQYZVF+r3tva
         EmhGlI7m8AqvI/C+gjP0wOVkLwWID8pJvqIaleVOUApl0zU//TRSkmH9L0NnJpehbblD
         4skez4shaR3btqb0eaTCUlaeKrMKB0klyYKtTlSA3NRhN7iozRnw41Iydt50YZUNZG/z
         Ycyf639054gAT8I4DG65lehK/OnZyjcjiUYeLgrnN1Rn0N6wq14k9zKAR8fXKNzRY32R
         1Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316377; x=1702921177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm/U5iX89/NkKIBpHMc6e7m4WD1ivJqJGvRe8VbK7nY=;
        b=qtD+QWIaZ8UM9ouGbQSEZRrFEgm45eQJus4PtguIZSTjOniDA2CRdnTfk+WXY6wxvI
         MuUW6z88+4wUOy+EPty8fW4R4tgjh1ulVzvYfZY9Qubh3/pSBUg7HoH0LiQ3uBfgwhqs
         OkA/oqYP8Yk4OCuxUg64APsgQ/OA3ZdHYsVSegj9031b8F9Vjf6Dkn4UrhFsWS2+tnoT
         sgVkNcGuntml3kprCHD/vyqjeoKq0J21Re86r1YeP1d3XqtzEjuCJsoBhRBxb7UtWOXf
         FeMMtzWmFrN8Aa1fOgvJJFZMK+6gtbYd8Lkf6WN6UIfl17edYlnQ3N/6PD7fUeaDa+l1
         mXAw==
X-Gm-Message-State: AOJu0YzVtwb6a9cYm9yu45KkT0JcV2v0lqdOkkMKQ5ECB3pfie3zxoQH
        ECuQcZkh7leA1CtIx+nJrkYyA1o1oLRpEOfRRTdY5w==
X-Google-Smtp-Source: AGHT+IFP/Y5PRlU1eXMLK1DEPHD4ZlTXHmj1o1ZRYUX5WxIJwcx84DGmQIVNKNxHrRJGzAv/k5G2es+ZoybkpQPW+kc=
X-Received: by 2002:a05:6902:1a44:b0:db9:8c22:a455 with SMTP id
 cy4-20020a0569021a4400b00db98c22a455mr3582817ybb.11.1702316377187; Mon, 11
 Dec 2023 09:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Dec 2023 19:39:25 +0200
Message-ID: <CAA8EJppQNnLhH2XNg1qSTuY9uvChLU2rWy3Ep97yq8yLgwAJYg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom-sdx55: Fix the base address of PCIe PHY
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 19:24, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> While convering the binding to new format, serdes address specified in the
> old binding was used as the base address. This causes a boot hang as the
> driver tries to access memory region outside of the specified address. Fix
> it!
>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: stable@vger.kernel.org # 6.6
> Fixes: bb56cff4ac03 ("ARM: dts: qcom-sdx55: switch PCIe QMP PHY to new style of bindings")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index 2aa5089a8513..a88f186fcf03 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -436,9 +436,9 @@ pcie_ep: pcie-ep@1c00000 {
>                         status = "disabled";
>                 };
>
> -               pcie_phy: phy@1c07000 {
> +               pcie_phy: phy@1c06000 {
>                         compatible = "qcom,sdx55-qmp-pcie-phy";
> -                       reg = <0x01c07000 0x2000>;
> +                       reg = <0x01c06000 0x2000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

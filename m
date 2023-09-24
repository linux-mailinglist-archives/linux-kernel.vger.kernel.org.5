Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C257ACC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjIXWTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXWTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:19:33 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA994EE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:19:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59c0d329a8bso62727497b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695593967; x=1696198767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/PeCxenQF1oBMIaK9Z0Z7Bxv1CupWtNWD6y8Xind8Y=;
        b=c2cahi02j2Q/CFf1o5qdUXk3AooV9EQVtIrYxJ4kbBNuspnwbUopEjJlbzJwf0Xz9+
         QG7DaNjjN+uDDhZMDBKhGebxSbJJHA5RN/iUeEPaF43+K0o3nDvzyu9T8ZXLyGPTKT3m
         OZTAKnwYaNSM/LHmePDuNjsFrGu7ke6mGuANYc48Hxzp3hQLiKGTMvnPjtY5cG0sk4IL
         fGXrow9hcQDS8ZNwBYJKdY76jAoVuwxlkMVhW8t6uKHPCEuwmo2rvSVIv0FhcV4P8U6K
         Az03MvO/12AwrLkMKjYCcSak4I6cIcKPqo5+cQ+vaydx66JdlRlnJdYr1hEKy2OvuXdi
         B5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695593967; x=1696198767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/PeCxenQF1oBMIaK9Z0Z7Bxv1CupWtNWD6y8Xind8Y=;
        b=dOrBqz4bUKkq811tQeejrZI1fp1v2LjLIhbZ8zmhNdKQIw8pJ6fCf2nfGekr+kRh8x
         ZOGq5tz2cnixjJpbqetvK8zHly7HqVc2lMYxfxoLTZiP8nc93zpHbZfvNnGJ/U0sPeiP
         B7IzmkXnpUKE05SYxSwLR16jrHaH4O87qCYjjxc8zqEqfw/uqEwf3u7k5eUPqpRJm2j5
         /LP7GkxFbtTcOyqa6JoeGUBM+RYjXmqGFBobau3ojCDPpnOqv2nlM4Yorqs1ZHofdtIF
         NgllX6E51uRW6VHX+OPvdgSxrFtR8t0t6SULkFmNEaIGv1KUHVYw/++LmUQTUmqv/p0Q
         8pyA==
X-Gm-Message-State: AOJu0YxdwqDMx6e0wXD+tO25mU2gIC+QVvCV6Mmaq0Rtvb/j2PMcgKFy
        tGA7znXNbarlTuyf6mT9q4D6QhQ/xq784IJ1l9Rehw==
X-Google-Smtp-Source: AGHT+IGS2JGmskFp4BL/JB5SCJAVyM6ud3ky+fox2mQdtLF42SZ+CNqRFX6h6xPTVQ9385hW0AEMaR0NJMlLlNSe4aY=
X-Received: by 2002:a05:690c:851:b0:59f:6766:2c12 with SMTP id
 bz17-20020a05690c085100b0059f67662c12mr2018465ywb.39.1695593966876; Sun, 24
 Sep 2023 15:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230924183103.49487-1-krzysztof.kozlowski@linaro.org> <20230924183103.49487-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230924183103.49487-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 25 Sep 2023 01:19:16 +0300
Message-ID: <CAA8EJprU2YiZi+XE-w5GKPXkPWV32imeZ5ktsczP+GnGzdMYoQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/3] ARM: dts: qcom: sdx65: add missing GCC clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sept 2023 at 21:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The SDX65 GCC clock controller expects two required clocks:
> pcie_pipe_clk and usb3_phy_wrapper_gcc_usb30_pipe_clk.  The first one is
> provided by existing phy node, but second is not yet implemented.
>
>   qcom-sdx65-mtp.dtb: clock-controller@100000: clocks: [[11, 0], [11, 1], [12]] is too short
>   qcom-sdx65-mtp.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk'] is too short
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> index c9790217320b..4a8cc28fa1db 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> @@ -204,8 +204,16 @@ soc: soc {
>                 gcc: clock-controller@100000 {
>                         compatible = "qcom,gcc-sdx65";
>                         reg = <0x00100000 0x001f7400>;
> -                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>;
> -                       clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                                <&rpmhcc RPMH_CXO_CLK_A>,
> +                                <&sleep_clk>,
> +                                <&pcie_phy>,
> +                                <0>;

Maybe <&usb_ssphy> or <&usb_qmpphy>?

> +                       clock-names = "bi_tcxo",
> +                                     "bi_tcxo_ao",
> +                                     "sleep_clk",
> +                                     "pcie_pipe_clk",
> +                                     "usb3_phy_wrapper_gcc_usb30_pipe_clk";
>                         #power-domain-cells = <1>;
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

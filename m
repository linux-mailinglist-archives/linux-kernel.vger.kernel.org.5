Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1227EEF20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjKQJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345935AbjKQJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:44:47 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651B26A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:43:21 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7c011e113so20209577b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700214200; x=1700819000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R60GE1grOZhSgQJmwUPI1cIFXHxyuZjPPb2sra1cTeo=;
        b=X2ClTBHSMok0Lq09cu57RXe681AS9ESLULBSzKamYFH5FEL8Lc2d5NVkmEECvpSfzI
         lz9HjeBAQ8YycDEU8bYFiXeF+9SCPoI7iEX92QJJgObf+jMesVjWFtxz6tzSAFaLEXF/
         R/Kep407fjEzcmCW31nI0Z7lSuuZ4Wh1AHmolReFL1LKwnT2ozVpeoyGCT6wJ3LvvjrM
         Wvp4RKxpHweC9Yh2l/a5ZDkOQxQY5Qmj8bwFL+JvbAtuCetO/vDm7+t4qEVf36GUlL3d
         KVTKGLt8TNIfd5jJq2Ur3SPNb3ud9v3dQc9zIcFQw3P67bjg5ZXgFUDkoLmN2iQDg8Hr
         Gecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700214200; x=1700819000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R60GE1grOZhSgQJmwUPI1cIFXHxyuZjPPb2sra1cTeo=;
        b=MzlJTrLNztlc+YSjHebhOTtqGQgxqxMWqgf1uFTZKViWhWlJqmJ1+jQjHkWUAjD9El
         uslLIDUL+U0qa0vrrQLtpX+VcISE5UzcMco856GmsKQx+J1+TRsZ93gIjaf0SWjNyeUG
         uLauq0y7RZ7FyZaZRVbgAywNT8/5hJMGOEu9Zu4g1UAmnxCQQbwwE4cNUvbpsCU3gGEp
         J8Tr8Z3e83AnDiBorhKF3v4kHvvenBCMtlT10vFUKSfyehGemWpPNGnmjHhFxD+hcvE5
         ZSbftvfaE8pgkg5qkTxEscZLt63TSEkIe/5kAa1IfCg5WblZfQ1paibDHzXmSgCufWOo
         RYLg==
X-Gm-Message-State: AOJu0Ywn5CKHuik+R4Y8aoAWdbqkuga88Vk8ure42mpUnvYTiqnLMWBS
        +yYUzS0D8wRukxm3ezZSpMOhGnPiVW0IuqdwCUjAf65HVNyoY6+F
X-Google-Smtp-Source: AGHT+IHijDMw7dVNsnx/0cPoAMMqwa6/HkZCv4flRGEHMVUM8M8jmfpuR5+loOHJGVyJRp67n0QNq3GU8XRbRqsybhk=
X-Received: by 2002:a0d:f301:0:b0:59e:9a44:9db9 with SMTP id
 c1-20020a0df301000000b0059e9a449db9mr17702165ywf.26.1700214200458; Fri, 17
 Nov 2023 01:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20231117080737.606687-1-quic_rohiagar@quicinc.com> <20231117080737.606687-2-quic_rohiagar@quicinc.com>
In-Reply-To: <20231117080737.606687-2-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 11:43:09 +0200
Message-ID: <CAA8EJppTyVV5KKQkVUAvzSTZDz8s8QC9Co4da2UJP9jM=zcSKA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 10:08, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Add interconnect nodes to support interconnects on SDX75.
> Also parallely add the interconnect property for UART required
> so that the bootup to shell does not break with interconnects
> in place.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 52 +++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index e180aa4023ec..b4723faf8655 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -8,6 +8,8 @@
>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sdx75-gcc.h>
> +#include <dt-bindings/interconnect/qcom,icc.h>
> +#include <dt-bindings/interconnect/qcom,sdx75.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -203,6 +205,19 @@ scm: scm {
>                 };
>         };
>
> +       clk_virt: interconnect-0 {
> +               compatible = "qcom,sdx75-clk-virt";
> +               #interconnect-cells = <2>;
> +               qcom,bcm-voters = <&apps_bcm_voter>;
> +               clocks = <&rpmhcc RPMH_QPIC_CLK>;
> +       };
> +
> +       mc_virt: interconnect-1 {
> +               compatible = "qcom,sdx75-mc-virt";
> +               #interconnect-cells = <2>;
> +               qcom,bcm-voters = <&apps_bcm_voter>;
> +       };
> +
>         memory@80000000 {
>                 device_type = "memory";
>                 reg = <0x0 0x80000000 0x0 0x0>;
> @@ -434,6 +449,9 @@ qupv3_id_0: geniqup@9c0000 {
>                         clock-names = "m-ahb",
>                                       "s-ahb";
>                         iommus = <&apps_smmu 0xe3 0x0>;
> +                       interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
> +                                        &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>;
> +                       interconnect-names = "qup-core";
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
> @@ -444,6 +462,12 @@ uart1: serial@984000 {
>                                 reg = <0x0 0x00984000 0x0 0x4000>;
>                                 clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
>                                 clock-names = "se";
> +                               interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
> +                                                &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
> +                                               <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +                                                &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>;
> +                               interconnect-names = "qup-core",
> +                                                    "qup-config";
>                                 interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
>                                 pinctrl-0 = <&qupv3_se1_2uart_active>;
>                                 pinctrl-1 = <&qupv3_se1_2uart_sleep>;
> @@ -453,6 +477,20 @@ uart1: serial@984000 {
>                         };
>                 };
>
> +               system_noc: interconnect@1640000 {
> +                       compatible = "qcom,sdx75-system-noc";
> +                       reg = <0x0 0x01640000 0x0 0x4b400>;
> +                       #interconnect-cells = <2>;
> +                       qcom,bcm-voters = <&apps_bcm_voter>;
> +               };
> +
> +               pcie_anoc: interconnect@16c0000 {
> +                       compatible = "qcom,sdx75-pcie-anoc";
> +                       reg = <0x0 0x016c0000 0x0 0x14200>;
> +                       #interconnect-cells = <2>;
> +                       qcom,bcm-voters = <&apps_bcm_voter>;
> +               };
> +
>                 tcsr_mutex: hwlock@1f40000 {
>                         compatible = "qcom,tcsr-mutex";
>                         reg = <0x0 0x01f40000 0x0 0x40000>;
> @@ -733,6 +771,20 @@ cpufreq_hw: cpufreq@17d91000 {
>                         #freq-domain-cells = <1>;
>                         #clock-cells = <1>;
>                 };
> +
> +               dc_noc: interconnect@190e0000 {
> +                       compatible = "qcom,sdx75-dc-noc";
> +                       reg = <0x0 0x190e0000 0x0 0x8200>;
> +                       #interconnect-cells = <2>;
> +                       qcom,bcm-voters = <&apps_bcm_voter>;
> +               };
> +
> +               gem_noc: interconnect@19100000 {
> +                       compatible = "qcom,sdx75-gem-noc";
> +                       reg = <0x0 0x19100000 0x0 0x34080>;
> +                       #interconnect-cells = <2>;
> +                       qcom,bcm-voters = <&apps_bcm_voter>;
> +               };
>         };
>
>         timer {
> --
> 2.25.1
>
>


--
With best wishes
Dmitry

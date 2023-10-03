Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF44B7B6611
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbjJCKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbjJCKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:06:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262FB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:06:10 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8162698f0dso779862276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696327570; x=1696932370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kYY6vWSNKTYmeOsWDutWjp0Dy6WB1jcBj72iJmFRNeI=;
        b=hZv12M4ax010irFg/GAeEbYpI9KBMLl/iReEqiqjnnuVEYDJ5qYu3R5pPF7m1hY1pt
         PehaCD1R/44YP1gNdmgoE0VBS4NDm8KhWSLm5kUp/NgRV5q5EpObPvLsqqx5qsBFnjwe
         EgrfojmlndaxafuF5byfLRg1BC7GKGk5nwTw/zQchbxkx9OiZIwOytjEHlA0qNsAlyui
         /OA54p7pXDtW85Y7K7YB0y/wbQ3kWwPAx9tPrkNk58/iE2zw7HkDdkQMsrZQgqxb+ht1
         nYitg7jHrm2wld0ZB8GQ0XagVjKg9ORJfLO7qCgMyd2TBU344PCigckVqHP6w/mMvxkH
         tepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696327570; x=1696932370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYY6vWSNKTYmeOsWDutWjp0Dy6WB1jcBj72iJmFRNeI=;
        b=IqGur9Jhjeajy3f3HdNKy952nvO7zi9Ah6Y42idQX08mrIwbDoyl1F+Efo2eI2dNgN
         GXCEUNCiyG6psoKLnDBi7zqu0Me2N/A2tCzO89vDevVb29d5iPABzyqGS/Us/MuAPZco
         xVJqAm+uGuORIqQLDqvgBm83FPqiFLhsfTkYF25aoF822I8t+1UUPEWGRHOA8BGW5AMa
         N6aD0gjP2U/mHBNDDzJvfzDfBzkYN/ODfkNz+JFxztdvAfhdfMBL+qHth5FuM8A7SpYI
         LfD5Jgke5f4W7E8d5j9yj6DYC8ryCHaToFXXxbC3ubec3NFyOSDNLUr8t2wXyR8DDpUa
         U00g==
X-Gm-Message-State: AOJu0YzjljRpNhyxoNXCS5FkIZtLFeFkYmgDeYhsHs5m9NtckUWkgtXl
        nJqXmE/FOPTD1jcf8DuNx6l+7wFQMUs2Z51F+ZkUZg==
X-Google-Smtp-Source: AGHT+IEDEkigzAbnvMlvaSmR+AEMY+sHV+2ys05HA/+WcAgzhebgJvzC/TVDaIgh0Bvv8g81P7mvrJdNShphvBDncwU=
X-Received: by 2002:a25:a545:0:b0:d62:6838:74b9 with SMTP id
 h63-20020a25a545000000b00d62683874b9mr12769755ybi.55.1696327569696; Tue, 03
 Oct 2023 03:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <1696327472-21776-1-git-send-email-quic_rohiagar@quicinc.com> <1696327472-21776-2-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1696327472-21776-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 13:05:58 +0300
Message-ID: <CAA8EJpp0+8FBtrmC7MGRkAdiavGSBUH7oAcQ0rN1OzLCWnsk8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 at 13:04, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Add interconnect nodes to support interconnects on SDX75.
> Also parallely add the interconnect property for UART required
> so that the bootup to shell does not break with interconnects
> in place.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 52 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index e180aa4..ac0b785 100644
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
> @@ -197,6 +199,19 @@
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

Interconnect comes after firmware, 'i' > 'f'.

> +
>         firmware {
>                 scm: scm {
>                         compatible = "qcom,scm-sdx75", "qcom,scm";
> @@ -434,6 +449,9 @@
>                         clock-names = "m-ahb",
>                                       "s-ahb";
>                         iommus = <&apps_smmu 0xe3 0x0>;
> +                       interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
> +                                        &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>;
> +                       interconnect-names = "qup-core";
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
> @@ -444,6 +462,12 @@
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
> @@ -453,6 +477,20 @@
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
> @@ -733,6 +771,20 @@
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
> 2.7.4
>


-- 
With best wishes
Dmitry

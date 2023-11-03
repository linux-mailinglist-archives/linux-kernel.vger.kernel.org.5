Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F87E0B08
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjKCWWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjKCWW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:22:29 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8652D4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:22:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7c011e113so31154247b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699050144; x=1699654944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qWI+PV/SDboxEvAPKg+OoS5n3L7WiPbDaIYDczDd0jc=;
        b=s3l0tjm81pnXEU9iqzb373BcALf27buDoEPXIGrPYS4Z4PYzuT/NaOv3gooaUJBX2i
         rUtecEdnfE12YrfGwR6WO6p+n5cN1ADrwMgPD5Xf3KoKzGQ3gyAzwRk8VyWA6DZjh3J3
         vzrsNzPy2JRfB54CE6HtHaiS8/WRGtZD6t3ywVYoRWq1nuwJSdvnzn6Fw9PFdkrUGr/g
         aJWU/1tWzD7LmSNfX77sH+VyB1IJtIrwLlDkCmWPIZ9Ls5XCMv0b/uRIt4eQPwapzewl
         +D4SgZR9B+Vaa+SslNm+RRNqD8N11oLq6cy8oQ4X8eru13YXWa3Z3W2xPL3by9x+AAzM
         xhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699050144; x=1699654944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWI+PV/SDboxEvAPKg+OoS5n3L7WiPbDaIYDczDd0jc=;
        b=vHMWqvmFHfqU+5HWus8/10RDG+eUQgL3uhFsLG0VMYXne9biEs+aSeXZbgjXZpq5Uj
         ikd8oMOmWVkdOrWoJjNCdlJx1a3Vl4Gt0Wlaw3+wqmsTD9v5Y5Svn08yzMNJilItZeMP
         PAWwNtN/tWnhkjjzWOog8V2emdqAb8LGI0VeJJss6q2AZF6BfwUnif8cuaH59Io/zbi4
         s9pXtcdcQx2OWUL9w4lr0sy58WYvL2A25U3dp6GNcPg+PSoim1oYjuKjz/5FD1RoJEEz
         Pzfuxa2ZGPYzbUwyoxgJAOvqs49uLCL5B2seFzUxTTA2th8jkr/fnbS79Yglkplr2uLX
         Oaew==
X-Gm-Message-State: AOJu0YwYdInhwdZX2hfx/Tz/TmQWDSM9elXwjGbROTTl3pOL+7zCYgN3
        zhh2i9YkciUhTafdR3U9GTY8Ny5qNK3JRGuTpOcABgkuy3jr9/tN
X-Google-Smtp-Source: AGHT+IEvwOQRASOwZGAyChlFnOe3cexDSPfbY/7ZMKQAancAt/Jk3NfQp0mNzKCtOl6fx3qoOCQ73QPsuFCERgid3dw=
X-Received: by 2002:a81:8357:0:b0:59f:4f56:59bc with SMTP id
 t84-20020a818357000000b0059f4f5659bcmr4756416ywf.42.1699050143799; Fri, 03
 Nov 2023 15:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com> <20231103184655.23555-3-quic_kbajaj@quicinc.com>
In-Reply-To: <20231103184655.23555-3-quic_kbajaj@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 4 Nov 2023 00:22:12 +0200
Message-ID: <CAA8EJprNyu0r_mV9hbKA1fSvoEvTHuk5umxU8H64Voj_cnZcFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nainmeht@quicinc.com
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

On Fri, 3 Nov 2023 at 20:49, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
> platform. QCM6490 is derived from SC7280 meant for various
> form factor including IoT.
>
> Supported features are, as of now:
> * Debug UART
> * eMMC (only in IDP)
> * USB
>
> Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  33 ++
>  .../boot/dts/qcom/qcm6490-iot-common.dtsi     | 291 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qcm6490-rb3.dts      |  26 ++
>  4 files changed, 352 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 73c3be0f8872..29cd77000970 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -82,6 +82,8 @@ dtb-$(CONFIG_ARCH_QCOM)       += msm8998-sony-xperia-yoshino-maple.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8998-sony-xperia-yoshino-poplar.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8998-xiaomi-sagit.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcm6490-fairphone-fp5.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += qcm6490-idp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += qcm6490-rb3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qdu1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> new file mode 100644
> index 000000000000..b1d1b8f40bdb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "qcm6490-iot-common.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. QCM6490 IDP";
> +       compatible = "qcom,qcm6490-idp", "qcom,qcm6490";
> +
> +       aliases {
> +               serial0 = &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&sdhc_1 {
> +       non-removable;
> +       no-sd;
> +       no-sdio;
> +
> +       vmmc-supply = <&vreg_l7b_2p952>;
> +       vqmmc-supply = <&vreg_l19b_1p8>;
> +
> +       status = "okay";
> +};
> +
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
> new file mode 100644
> index 000000000000..01adc97789d0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi

I have mixed feelings towards this file. Usually we add such 'common'
files only for the phone platforms where most of the devices are
common.
Do you expect that IDP and RB3 will have a lot of common code other
than these regulator settings?

> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sc7280.dtsi"
> +#include "pm7325.dtsi"
> +#include "pm8350c.dtsi"
> +#include "pmk8350.dtsi"
> +
> +&apps_rsc {
> +       regulators-0 {
> +               compatible = "qcom,pm7325-rpmh-regulators";
> +               qcom,pmic-id = "b";
> +
> +               vreg_s1b_1p872: smps1 {
> +                       regulator-min-microvolt = <1840000>;
> +                       regulator-max-microvolt = <2040000>;
> +               };
> +
> +               vreg_s2b_0p876: smps2 {
> +                       regulator-min-microvolt = <570070>;
> +                       regulator-max-microvolt = <1050000>;
> +               };
> +
> +               vreg_s7b_0p972: smps7 {
> +                       regulator-min-microvolt = <535000>;
> +                       regulator-max-microvolt = <1120000>;
> +               };
> +
> +               vreg_s8b_1p272: smps8 {
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1500000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
> +               };
> +
> +               vreg_l1b_0p912: ldo1 {
> +                       regulator-min-microvolt = <825000>;
> +                       regulator-max-microvolt = <925000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2b_3p072: ldo2 {
> +                       regulator-min-microvolt = <2700000>;
> +                       regulator-max-microvolt = <3544000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3b_0p504: ldo3 {
> +                       regulator-min-microvolt = <312000>;
> +                       regulator-max-microvolt = <910000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l4b_0p752: ldo4 {
> +                       regulator-min-microvolt = <752000>;
> +                       regulator-max-microvolt = <820000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               reg_l5b_0p752: ldo5 {
> +                       regulator-min-microvolt = <552000>;
> +                       regulator-max-microvolt = <832000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l6b_1p2: ldo6 {
> +                       regulator-min-microvolt = <1140000>;
> +                       regulator-max-microvolt = <1260000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l7b_2p952: ldo7 {
> +                       regulator-min-microvolt = <2400000>;
> +                       regulator-max-microvolt = <3544000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l8b_0p904: ldo8 {
> +                       regulator-min-microvolt = <870000>;
> +                       regulator-max-microvolt = <970000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l9b_1p2: ldo9 {
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1304000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l11b_1p504: ldo11 {
> +                       regulator-min-microvolt = <1504000>;
> +                       regulator-max-microvolt = <2000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l12b_0p751: ldo12 {
> +                       regulator-min-microvolt = <751000>;
> +                       regulator-max-microvolt = <824000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l13b_0p53: ldo13 {
> +                       regulator-min-microvolt = <530000>;
> +                       regulator-max-microvolt = <824000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l14b_1p08: ldo14 {
> +                       regulator-min-microvolt = <1080000>;
> +                       regulator-max-microvolt = <1304000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l15b_0p765: ldo15 {
> +                       regulator-min-microvolt = <765000>;
> +                       regulator-max-microvolt = <1020000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l16b_1p1: ldo16 {
> +                       regulator-min-microvolt = <1100000>;
> +                       regulator-max-microvolt = <1300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l17b_1p7: ldo17 {
> +                       regulator-min-microvolt = <1700000>;
> +                       regulator-max-microvolt = <1900000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l18b_1p8: ldo18 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <2000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l19b_1p8: ldo19 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <2000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-1 {
> +               compatible = "qcom,pm8350c-rpmh-regulators";
> +               qcom,pmic-id = "c";
> +
> +               vreg_s1c_2p19: smps1 {
> +                       regulator-min-microvolt = <2190000>;
> +                       regulator-max-microvolt = <2210000>;
> +               };
> +
> +               vreg_s2c_0p752: smps2 {
> +                       regulator-min-microvolt = <750000>;
> +                       regulator-max-microvolt = <800000>;
> +               };
> +
> +               vreg_s5c_0p752: smps5 {
> +                       regulator-min-microvolt = <465000>;
> +                       regulator-max-microvolt = <1050000>;
> +               };
> +
> +               vreg_s7c_0p752: smps7 {
> +                       regulator-min-microvolt = <465000>;
> +                       regulator-max-microvolt = <800000>;
> +               };
> +
> +               vreg_s9c_1p084: smps9 {
> +                       regulator-min-microvolt = <1010000>;
> +                       regulator-max-microvolt = <1170000>;
> +               };
> +
> +               vreg_l1c_1p8: ldo1 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1980000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2c_1p62: ldo2 {
> +                       regulator-min-microvolt = <1620000>;
> +                       regulator-max-microvolt = <1980000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3c_2p8: ldo3 {
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <3540000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l4c_1p62: ldo4 {
> +                       regulator-min-microvolt = <1620000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l5c_1p62: ldo5 {
> +                       regulator-min-microvolt = <1620000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l6c_2p96: ldo6 {
> +                       regulator-min-microvolt = <1650000>;
> +                       regulator-max-microvolt = <3544000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l7c_3p0: ldo7 {
> +                       regulator-min-microvolt = <3000000>;
> +                       regulator-max-microvolt = <3544000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l8c_1p62: ldo8 {
> +                       regulator-min-microvolt = <1620000>;
> +                       regulator-max-microvolt = <2000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l9c_2p96: ldo9 {
> +                       regulator-min-microvolt = <2700000>;
> +                       regulator-max-microvolt = <35440000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l10c_0p88: ldo10 {
> +                       regulator-min-microvolt = <720000>;
> +                       regulator-max-microvolt = <1050000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l11c_2p8: ldo11 {
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <3544000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l12c_1p65: ldo12 {
> +                       regulator-min-microvolt = <1650000>;
> +                       regulator-max-microvolt = <2000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l13c_2p7: ldo13 {
> +                       regulator-min-microvolt = <2700000>;
> +                       regulator-max-microvolt = <3544000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_bob_3p296: bob {
> +                       regulator-min-microvolt = <3008000>;
> +                       regulator-max-microvolt = <3960000>;
> +               };
> +       };
> +};
> +
> +&qupv3_id_0 {
> +       status = "okay";
> +};
> +
> +&uart5 {
> +       compatible = "qcom,geni-debug-uart";

Maybe we should add qcm6490.dtsi, which has this compat string (and
other possible differences between sc7280 and qcm6490).

> +       status = "okay";
> +};
> +
> +&usb_1 {
> +       status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +       dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +       vdda-pll-supply = <&vreg_l10c_0p88>;
> +       vdda33-supply = <&vreg_l2b_3p072>;
> +       vdda18-supply = <&vreg_l1c_1p8>;
> +
> +       status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +       vdda-phy-supply = <&vreg_l6b_1p2>;
> +       vdda-pll-supply = <&vreg_l1b_0p912>;
> +
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts b/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
> new file mode 100644
> index 000000000000..5b4c2826ac5c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +/* PM7250B is configured to use SID8/9 */
> +#define PM7250B_SID 8
> +#define PM7250B_SID1 9
> +
> +#include "qcm6490-iot-common.dtsi"
> +#include "pm7250b.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. QCM6490 RB3";

Is this a marketing name of the platform?

> +       compatible = "qcom,qcm6490-rb3", "qcom,qcm6490";

chassis-type = ?

> +
> +       aliases {
> +               serial0 = &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> --
> 2.42.0
>


-- 
With best wishes
Dmitry

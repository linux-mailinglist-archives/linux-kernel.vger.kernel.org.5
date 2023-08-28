Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33078BA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjH1VPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjH1VPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:15:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6030DC3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:15:14 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d746d030a86so3543596276.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693257313; x=1693862113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdPUuO+5Wgy+RzMxb25jT3lt4a9QfI+UniKfgePVb+c=;
        b=FhmgJyb3lFJFozfVzZHVdM0pw03kugwk2zgj5CWbCZOEhEMM8h0Mj+cuNrv3QWwk+8
         TD82/ZF+8WxXK4FPSlFehptBN1+GXGfE0XLFu5dWhqgYnluaO1qdyAjnEeE3vzrVbtGN
         ouLPQYg2iVwzEGd3JaorDrXRJc05AlPWynDOfMKi63em8Ohze76IdSOMLChmqJgGKPaO
         n4/Kwcb1WHYOELQUrt9yXrov/wIZZBu9sMrDwApcBmEtXingJJjSunVEc8NhffQxrmdC
         VhQHmWtz5v3W5Wz3AwNQPRCsZu91QKZ/3y1Tmeyx3gWsMe/Zm8f4WDbce5RshU483XYU
         nzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693257313; x=1693862113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdPUuO+5Wgy+RzMxb25jT3lt4a9QfI+UniKfgePVb+c=;
        b=iuPkD49tqHjRTbLwU5IWNG0AQU76gOwwskVkpegMM1o63jH+Q+deLdcCLEI+QcpmXK
         HWLSvIfoLezIrqLwmpfdtVCCDwEzG6jcSr+5nRg0DpM3OasXEyxK/qQd0jmqVckjkB2y
         x3GOLnS3PfdCjz4HAe3HdzPWm0cBEHpv5t7epAK/n/Wk60buN7RwldhW3cydeJrLGy6U
         dEWmdPPy9cdo4ClXVmFgg42HL/SkzAxRk3lXaqLy5tbtYf9N9l+FIzpSVQ/zcjcBBlgY
         kJShAD2+17tzJIYoc5GnJW/s0lUop2AGBplhfkftx1d7sKZhZM0eqjVe20KDwXWxJXrE
         4erA==
X-Gm-Message-State: AOJu0YxPCQAFbsh4dEiEIDRmj2Ac4iP0c6PD4NbVbp/qAijPOspSDELx
        itW1g/r+gwYy/BRJummNmnSNV8UiYTYWcSIrFsBPyQ==
X-Google-Smtp-Source: AGHT+IGvmw0atX8oX/5HRlmnGPifcNLIAMBpgQDepD0vJlej1ChpIrVIY43hytZlMEp5wvrbu1ZxI4OKoFou1Wil3a0=
X-Received: by 2002:a25:5:0:b0:d68:6f21:ddff with SMTP id 5-20020a250005000000b00d686f21ddffmr24841108yba.43.1693257313473;
 Mon, 28 Aug 2023 14:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com> <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
In-Reply-To: <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Aug 2023 00:15:02 +0300
Message-ID: <CAA8EJpoHCW2H12U9wzmz5a86TriZr9mLuPi6D6h02byAWOG2mQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] thermal/drivers/qcom/tsens: Add support for IPQ5018 tsens
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 22:20, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
> The soc does not have a RPM, hence tsens has to be reset and
> enabled in the driver init. Adding the driver support for same.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 115 ++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h    |   2 +-
>  2 files changed, 116 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index dc1c4ae2d8b0..a74dae69408b 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -42,6 +42,59 @@ static struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
>         },
>  };
>
> +struct tsens_legacy_calibration_format tsens_ipq5018_nvmem = {
> +       .base_len = 8,
> +       .base_shift = 2,
> +       .sp_len = 6,
> +       .mode = { 0, 8 },
> +       .invalid = { 0, 2 },
> +       .base = { { 0, 11 }, { 0, 19 } },
> +       .sp = {
> +               { { 0, 27 },  { 1, 1 } },
> +               { { 1, 7 },  { 1, 13 } },
> +               { { 1, 19 },  { 1, 25 } },
> +               { { 1, 31 },  { 2, 5 } },
> +               { { 2, 11 },  { 3, 0 } },
> +       },
> +};
> +
> +static void fixup_ipq5018_points(int mode, u32 *p1, u32 *p2)
> +{
> +       if (mode == NO_PT_CALIB) {
> +               p1[0] = 403;
> +               p2[0] = 688;
> +               p1[1] = 390;
> +               p2[1] = 674;
> +               p1[2] = 341;
> +               p2[2] = 635;
> +               p1[3] = 387;
> +               p2[3] = 673;
> +               p1[4] = 347;
> +               p2[4] = 639;
> +       }
> +}
> +
> +static int calibrate_ipq5018(struct tsens_priv *priv)
> +{
> +       u32 p1[10], p2[10];
> +       u32 *qfprom_cdata;
> +       int mode;
> +
> +       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> +       if (IS_ERR(qfprom_cdata))
> +               return PTR_ERR(qfprom_cdata);
> +
> +       mode = tsens_read_calibration_legacy(priv, &tsens_ipq5018_nvmem,
> +                                            p1, p2,
> +                                            qfprom_cdata, NULL);

No, this should be used only in _legacy_ cases. Please use
tsens_calibrate_common() / tsens_calibrate_nvmem() / etc.

> +
> +       fixup_ipq5018_points(mode, p1, p2);
> +       compute_intercept_slope(priv, p1, p2, mode);
> +       kfree(qfprom_cdata);
> +
> +       return 0;
> +}
> +
>  static int calibrate_v1(struct tsens_priv *priv)
>  {
>         u32 p1[10], p2[10];
> @@ -79,6 +132,18 @@ static struct tsens_features tsens_v1_feat = {
>         .trip_max_temp  = 120000,
>  };
>
> +static struct tsens_features tsens_v1_ipq5018_feat = {
> +       .ver_major      = VER_1_X,
> +       .crit_int       = 0,
> +       .combo_int      = 0,
> +       .adc            = 1,
> +       .srot_split     = 1,
> +       .max_sensors    = 11,
> +       .trip_min_temp  = -40000,
> +       .trip_max_temp  = 120000,
> +       .no_early_init  = 1,
> +};
> +
>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>         /* ----- SROT ------ */
>         /* VERSION */
> @@ -150,6 +215,43 @@ static int __init init_8956(struct tsens_priv *priv) {
>         return init_common(priv);
>  }
>
> +static int init_ipq5018(struct tsens_priv *priv)
> +{
> +       int ret;
> +       u32 mask;
> +
> +       init_common(priv);
> +       if (!priv->tm_map)
> +               return -ENODEV;
> +
> +       ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
> +       if (ret) {
> +               dev_err(priv->dev, "Reset failed\n");
> +               return ret;
> +       }
> +
> +       mask = GENMASK(10, 0);

#define this, then inline the variable. Or extract this codepiece into
generic function which uses num_sensors to calculate the mask

> +       ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
> +       if (ret) {
> +               dev_err(priv->dev, "Sensor Enable failed\n");
> +               return ret;
> +       }
> +
> +       ret = regmap_field_write(priv->rf[TSENS_EN], 1);
> +       if (ret) {
> +               dev_err(priv->dev, "Enable failed\n");
> +               return ret;
> +       }
> +
> +       ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
> +       if (ret) {
> +               dev_err(priv->dev, "Reset failed\n");

This error message is useless. You can not determine if it comes from
this error or from setting the reset bit.

> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct tsens_ops ops_generic_v1 = {
>         .init           = init_common,
>         .calibrate      = calibrate_v1,
> @@ -187,3 +289,16 @@ struct tsens_plat_data data_8976 = {
>         .feat           = &tsens_v1_feat,
>         .fields         = tsens_v1_regfields,
>  };
> +
> +const struct tsens_ops ops_ipq5018 = {
> +       .init           = init_ipq5018,
> +       .calibrate      = calibrate_ipq5018,
> +       .get_temp       = get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_ipq5018 = {
> +       .num_sensors    = 5,
> +       .ops            = &ops_ipq5018,
> +       .feat           = &tsens_v1_ipq5018_feat,
> +       .fields         = tsens_v1_regfields,
> +};
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index fb73e3dd0de9..5f0bdbeedf90 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -645,7 +645,7 @@ extern struct tsens_plat_data data_8960;
>  extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
>
>  /* TSENS v1 targets */
> -extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
> +extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956, data_ipq5018;
>
>  /* TSENS v2 targets */
>  extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

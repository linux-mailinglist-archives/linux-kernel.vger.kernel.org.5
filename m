Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C00F75491C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGOOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:05:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59029F3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:05:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso5185821fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689429939; x=1692021939;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib923rpivUZ1jvzbxCzQGvcnNRmC5ad0dwo5LcqVneA=;
        b=J16ipK8TY987Danz8/Ldk4OTLh0OFfsEhXL/TufpPJtfbWHhmXjcnf/boZT+yyFAFS
         hEmihbPJrjuh/Io66yBdu5Tw9PZEfCCL+nhpCr9r/r3ouSoEnI4a/1q4OtqzHeSQtC5+
         huUOkbGCvwWPQx+DCu1yHxD5rChEZzlBq2H3HnW43GC9Z/B9/dpYprUZEPfUv3+fDWgo
         6WfDu0LC/KnkyKtdsLa48dasT6dDTer8/9qHSsVxUzbZ0jKhRVYZdeYvyG3dagz+VZDF
         1UMoYKnGpkPSq5vPlUeL2yo8dgUPM1esEyM466Jk0cAqzEGmXxEy80u3nxUj7or2fQqW
         29zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689429939; x=1692021939;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib923rpivUZ1jvzbxCzQGvcnNRmC5ad0dwo5LcqVneA=;
        b=jqlmqt+4DcWnmcYzgqgAaJ1cBDdTn4lkWuN0Ua7QT8gId0DNvsWh2jF6vHDJJtB4Ww
         smsyvwRLDvPex5pSOkKWA1WhUyY9sAfxcfZgNG/umpb10uCoJ0jUI/MDRlU2MWpZwzMN
         ej6cCI3haRNhITTr3HYQN/gQq17vekHKtuft0rXA5pGEHejEuPPpIwAKj1Heawaq+h1H
         guYKupPLe2N36lm0hvWimVJuPmMjtmxn77UHmlRe/nxgpiETTvU39q7Sl4LzHHWoJjbv
         KssZaCWb2IQLSz2gxdWbTzGs9oPOyE5YpG1i3DeajSefMhZvYGfqn5py46yotB3rmGSp
         9cKw==
X-Gm-Message-State: ABy/qLapAmW4EJ+Leajc10ouF5cMiiC2XWAMEs2bXkPefqeccBIfSOlS
        kXlQRKE+SwibHVYEUkQK/Uj/Cw==
X-Google-Smtp-Source: APBJJlH8HGvdUBxHhBr4MrnT42WVCHdvTz+M9GgeVJLv+rJMwkztYrNCGZfRCWlQL8rK1xiYyn3UaQ==
X-Received: by 2002:a2e:9583:0:b0:2b5:1b80:263a with SMTP id w3-20020a2e9583000000b002b51b80263amr6864972ljh.47.1689429939586;
        Sat, 15 Jul 2023 07:05:39 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id v11-20020a2e960b000000b002b6de6deb5asm2521884ljh.2.2023.07.15.07.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:05:39 -0700 (PDT)
Message-ID: <1fbb2e36-87d7-339d-ba2f-42916a213607@linaro.org>
Date:   Sat, 15 Jul 2023 16:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
 <20230713052732.787853-2-quic_ipkumar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 1/5] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
In-Reply-To: <20230713052732.787853-2-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.2023 07:27, Praveenkumar I wrote:
> SoCs without RPM have to enable sensors and calibrate from the kernel.
> Though TSENS IP supports 16 sensors, not all are used. So used hw_id
> to enable the relevant sensors.
> 
> Added new calibration function for V2 as the tsens.c calib function
> only supports V1.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
[...]

>  
>  /* ----- SROT ------ */
>  #define SROT_HW_VER_OFF	0x0000
>  #define SROT_CTRL_OFF		0x0004
> +#define SROT_MEASURE_PERIOD	0x0008
> +#define SROT_Sn_CONVERSION	0x0060
> +#define V2_SHIFT_DEFAULT	0x0003
> +#define V2_SLOPE_DEFAULT	0x0cd0
> +#define V2_CZERO_DEFAULT	0x016a
> +#define ONE_PT_SLOPE		0x0cd0
> +#define TWO_PT_SHIFTED_GAIN	921600
> +#define ONE_PT_CZERO_CONST	94
> +#define SENSOR_CONVERSION(n)	(((n) * 4) + SROT_Sn_CONVERSION)
> +#define CONVERSION_SLOPE_SHIFT	10
> +#define CONVERSION_SHIFT_SHIFT	23
Please define bitfields with GENMASK() and use FIELD_PREP/GET() helpers

>  
>  /* ----- TM ------ */
>  #define TM_INT_EN_OFF			0x0004
> @@ -59,6 +71,11 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	/* CTRL_OFF */
>  	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>  	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
> +
> +	/* MAIN_MEASURE_PERIOD */
> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>  
>  	/* ----- TM ------ */
>  	/* INTERRUPT ENABLE */
> @@ -104,6 +121,130 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
> +{
> +	u32 slope, czero, val;
> +	char name[15];
What's the rationale behind choosing 15 here?

> +	int ret;
> +
[...]

> +static int tsens_v2_calibration(struct tsens_priv *priv)
> +{
> +	struct device *dev = priv->dev;
> +	u32 mode, base0, base1;
> +	int i, ret;
> +
> +	if (priv->num_sensors > MAX_SENSORS)
> +		return -EINVAL;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
> +	if (ret == -ENOENT)
> +		dev_warn(priv->dev, "Calibration data not present in DT\n");
I think bindings don't allow that anyway

> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Calibrate each sensor */
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		ret = tsens_v2_calibrate_sensor(dev, &priv->sensor[i], priv->srot_map,
> +						mode, base0, base1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
> +{
> +	int i, ret;
> +	u32 val = 0;
> +	struct device *dev = priv->dev;
Reverse-Christmas-tree, please.

> +
> +	ret = init_common(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, priv->srot_map,
> +							 priv->fields[CODE_OR_TEMP]);
> +	if (IS_ERR(priv->rf[CODE_OR_TEMP]))
> +		return PTR_ERR(priv->rf[CODE_OR_TEMP]);
> +
> +	priv->rf[MAIN_MEASURE_PERIOD] = devm_regmap_field_alloc(dev, priv->srot_map,
> +								priv->fields[MAIN_MEASURE_PERIOD]);
> +	if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD]))
> +		return PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
> +
> +	regmap_field_write(priv->rf[TSENS_SW_RST], 0x1);
> +
> +	/* Update measure period to 2ms */
What's the unit? Can we name the 0x1 value?

> +	regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], 0x1);
> +
> +	/* Enable available sensors */
> +	for (i = 0; i < priv->num_sensors; i++)
> +		val |= 1 << priv->sensor[i].hw_id;
> +
> +	regmap_field_write(priv->rf[SENSOR_EN], val);
> +
> +	/* Real temperature format */
What does that mean?

> +	regmap_field_write(priv->rf[CODE_OR_TEMP], 0x1);
> +
> +	regmap_field_write(priv->rf[TSENS_SW_RST], 0x0);
> +
> +	/* Enable TSENS */
> +	regmap_field_write(priv->rf[TSENS_EN], 0x1);
It would be really nice if you could provide the names of all these
magic values.

Konrad
> +
> +	return 0;
> +}
> +
>  static const struct tsens_ops ops_generic_v2 = {
>  	.init		= init_common,
>  	.get_temp	= get_temp_tsens_valid,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 98c356acfe98..9dc0c2150948 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>  	if (ret)
>  		goto err_put_device;
> -	if (!enabled) {
> +	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
>  		dev_err(dev, "%s: device not enabled\n", __func__);
>  		ret = -ENODEV;
>  		goto err_put_device;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2805de1c6827..b2e8f0f2b466 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -35,6 +35,7 @@ enum tsens_ver {
>  	VER_0_1,
>  	VER_1_X,
>  	VER_2_X,
> +	VER_2_X_NO_RPM,
>  };
>  
>  enum tsens_irq_type {
> @@ -168,6 +169,8 @@ enum regfield_ids {
>  	TSENS_SW_RST,
>  	SENSOR_EN,
>  	CODE_OR_TEMP,
> +	/* MEASURE_PERIOD */
> +	MAIN_MEASURE_PERIOD,
>  
>  	/* ----- TM ------ */
>  	/* TRDY */

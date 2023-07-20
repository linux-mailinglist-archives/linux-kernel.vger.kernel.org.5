Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7875AA23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGTI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjGTIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:47:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF61BC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:47:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so749748a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689842868; x=1690447668;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0QN1NPFj1LlQOs4d5uteg8v7gKwNlDQxv3OejvGWaA=;
        b=oJRPU2dNQSaUbpSpKLNtUYxHsTiIOTJwoeJZ4txDnD+oLb4fMsoUa2HgUIg5PpdRWz
         klNDGGxs4zoxa0vpQQLH2My30xG0Yv1c84M4phAWHmipsedrFmofYXYr1EzkvIhlCJ2C
         SZ9X2bWb0jcckyLB65KlRhj6X6a3ffG3r6nZsdSbjEWSVlyFrBm9agb0KB839uK9j439
         r/xm5SdgouWZX0NRWcMTbFwBbM7ATn7zGmC7jueYsCxpHXqY+bKFEel5fAj4RLGh30d3
         2dj3lV/3rFAoSue7TJYoNoGd0i2aTTUK2wsXzKmAZgjUNfaBjLsi7cmb5JRwPIaKZ680
         +dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842868; x=1690447668;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0QN1NPFj1LlQOs4d5uteg8v7gKwNlDQxv3OejvGWaA=;
        b=F58MIR9FOTDUH5k6WBMqynShMWVL7/xEng8cgcxQh3lyq67rK+WNoMLrF9zF+Pigy8
         5/Pdmqf+Ds7L7I4xPx54+dbI8eqpDGJL4lyJHKBWIxwdDLzs15tFpkzbosgVFasZUo3V
         tXBfhG+ejXkZCBdiau6PLxGbm++xvfYyFV8rmYdutoY04rUuQO5Z5i7WbmOcOxwFjeQZ
         UwCcG+SSqWawMpO12qEYUaW8dbjij/0CG4x8jy9fc1Jc5fdg11R1aU4BwW7cKgBs0EM0
         X5PJhav/3kwsvLDVx2aJUTt9aI5kwZ/htx6yUJqZEPBoLA1mGUQp7hH9dTxDiteMB6eV
         FBfQ==
X-Gm-Message-State: ABy/qLZRQKa0r+Uu14148+5O/Zx2mTEjjy8UvcQtwa8v9NvwxwMuahFI
        w/iv+DSY9Q449DS3cvNCeY44g29IuH9n5+US22m3aA==
X-Google-Smtp-Source: APBJJlHGHoJQdND6WE1nPLzzmAfLXLubFHktw26Y4A8J28hfav+n5mjNq9DLlkuj0GY4p14I2uL9oA==
X-Received: by 2002:a05:6402:78c:b0:51e:be0:d2ea with SMTP id d12-20020a056402078c00b0051e0be0d2eamr5505438edy.9.1689842868468;
        Thu, 20 Jul 2023 01:47:48 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id v8-20020aa7d808000000b00521d1c34b23sm429426edq.83.2023.07.20.01.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:47:47 -0700 (PDT)
Message-ID: <72bc47d6-3d70-0ddb-897f-bdc9b58684b8@linaro.org>
Date:   Thu, 20 Jul 2023 09:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ASoC: codecs: tx-macro: split widgets per different
 LPASS versions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230717140138.201745-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230717140138.201745-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/2023 15:01, Krzysztof Kozlowski wrote:
> TX macro codec differs slightly between different Qualcomm Low Power
> Audio SubSystem (LPASS) block versions.  In LPASS version 9.2 the
> register responsible for TX SMIC MUXn muxes is different, thus to
> properly support it, the driver needs to register different widgets per
> different LPASS version.
> 
> Prepare for supporting this register difference by refactoring existing
> code:
> 1. Move few widgets (TX SMIC MUXn, TX SWR_ADCn, TX SWR_DMICn) out of
>     common 'tx_macro_dapm_widgets[]' array to a new per-variant specific
>     array 'tx_macro_dapm_widgets_v9[]'.
> 2. Move also related audio routes into new array.
> 3. Store pointers to these variant-specific arrays in new variant-data
>     structure 'tx_macro_data'.
> 4. Add variant-specific widgets and routes in component probe, instead
>     of driver probe.
> 
> The change should have no real impact, except re-shuffling code and
> registering some widgets and audio routes in component probe, instead of
> driver probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
This patch-series is breaking amic functionality on x13s.

We should defer this till we address that.


thanks,
Srini
>   sound/soc/codecs/lpass-macro-common.h |   5 +
>   sound/soc/codecs/lpass-tx-macro.c     | 219 +++++++++++++++++---------
>   2 files changed, 147 insertions(+), 77 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
> index 4eb886565ea3..6376a02b373a 100644
> --- a/sound/soc/codecs/lpass-macro-common.h
> +++ b/sound/soc/codecs/lpass-macro-common.h
> @@ -9,6 +9,11 @@
>   /* NPL clock is expected */
>   #define LPASS_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
>   
> +enum lpass_version {
> +	LPASS_VER_9_0_0,
> +	LPASS_VER_11_0_0,
> +};
> +
>   struct lpass_macro {
>   	struct device *macro_pd;
>   	struct device *dcodec_pd;
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index de978c3d70b7..0da0bbf80eee 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -253,8 +253,18 @@ struct hpf_work {
>   	struct delayed_work dwork;
>   };
>   
> +struct tx_macro_data {
> +	unsigned int flags;
> +	unsigned int ver;
> +	const struct snd_soc_dapm_widget *extra_widgets;
> +	size_t extra_widgets_num;
> +	const struct snd_soc_dapm_route *extra_routes;
> +	size_t extra_routes_num;
> +};
> +
>   struct tx_macro {
>   	struct device *dev;
> +	const struct tx_macro_data *data;
>   	struct snd_soc_component *component;
>   	struct hpf_work tx_hpf_work[NUM_DECIMATORS];
>   	struct tx_mute_work tx_mute_dwork[NUM_DECIMATORS];
> @@ -1235,53 +1245,6 @@ static const struct snd_kcontrol_new tx_dec5_mux = SOC_DAPM_ENUM("tx_dec5", tx_d
>   static const struct snd_kcontrol_new tx_dec6_mux = SOC_DAPM_ENUM("tx_dec6", tx_dec6_enum);
>   static const struct snd_kcontrol_new tx_dec7_mux = SOC_DAPM_ENUM("tx_dec7", tx_dec7_enum);
>   
> -static const char * const smic_mux_text[] = {
> -	"ZERO", "ADC0", "ADC1", "ADC2", "ADC3", "SWR_DMIC0",
> -	"SWR_DMIC1", "SWR_DMIC2", "SWR_DMIC3", "SWR_DMIC4",
> -	"SWR_DMIC5", "SWR_DMIC6", "SWR_DMIC7"
> -};
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic0_enum, CDC_TX_INP_MUX_ADC_MUX0_CFG0,
> -			0, smic_mux_text);
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic1_enum, CDC_TX_INP_MUX_ADC_MUX1_CFG0,
> -			0, smic_mux_text);
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic2_enum, CDC_TX_INP_MUX_ADC_MUX2_CFG0,
> -			0, smic_mux_text);
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic3_enum, CDC_TX_INP_MUX_ADC_MUX3_CFG0,
> -			0, smic_mux_text);
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic4_enum, CDC_TX_INP_MUX_ADC_MUX4_CFG0,
> -			0, smic_mux_text);
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic5_enum, CDC_TX_INP_MUX_ADC_MUX5_CFG0,
> -			0, smic_mux_text);
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic6_enum, CDC_TX_INP_MUX_ADC_MUX6_CFG0,
> -			0, smic_mux_text);
> -
> -static SOC_ENUM_SINGLE_DECL(tx_smic7_enum, CDC_TX_INP_MUX_ADC_MUX7_CFG0,
> -			0, smic_mux_text);
> -
> -static const struct snd_kcontrol_new tx_smic0_mux = SOC_DAPM_ENUM_EXT("tx_smic0", tx_smic0_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -static const struct snd_kcontrol_new tx_smic1_mux = SOC_DAPM_ENUM_EXT("tx_smic1", tx_smic1_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -static const struct snd_kcontrol_new tx_smic2_mux = SOC_DAPM_ENUM_EXT("tx_smic2", tx_smic2_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -static const struct snd_kcontrol_new tx_smic3_mux = SOC_DAPM_ENUM_EXT("tx_smic3", tx_smic3_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -static const struct snd_kcontrol_new tx_smic4_mux = SOC_DAPM_ENUM_EXT("tx_smic4", tx_smic4_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -static const struct snd_kcontrol_new tx_smic5_mux = SOC_DAPM_ENUM_EXT("tx_smic5", tx_smic5_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -static const struct snd_kcontrol_new tx_smic6_mux = SOC_DAPM_ENUM_EXT("tx_smic6", tx_smic6_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -static const struct snd_kcontrol_new tx_smic7_mux = SOC_DAPM_ENUM_EXT("tx_smic7", tx_smic7_enum,
> -			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> -
>   static const char * const dmic_mux_text[] = {
>   	"ZERO", "DMIC0", "DMIC1", "DMIC2", "DMIC3",
>   	"DMIC4", "DMIC5", "DMIC6", "DMIC7"
> @@ -1427,15 +1390,6 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
>   	SND_SOC_DAPM_MIXER("TX_AIF3_CAP Mixer", SND_SOC_NOPM, TX_MACRO_AIF3_CAP, 0,
>   		tx_aif3_cap_mixer, ARRAY_SIZE(tx_aif3_cap_mixer)),
>   
> -	SND_SOC_DAPM_MUX("TX SMIC MUX0", SND_SOC_NOPM, 0, 0, &tx_smic0_mux),
> -	SND_SOC_DAPM_MUX("TX SMIC MUX1", SND_SOC_NOPM, 0, 0, &tx_smic1_mux),
> -	SND_SOC_DAPM_MUX("TX SMIC MUX2", SND_SOC_NOPM, 0, 0, &tx_smic2_mux),
> -	SND_SOC_DAPM_MUX("TX SMIC MUX3", SND_SOC_NOPM, 0, 0, &tx_smic3_mux),
> -	SND_SOC_DAPM_MUX("TX SMIC MUX4", SND_SOC_NOPM, 0, 0, &tx_smic4_mux),
> -	SND_SOC_DAPM_MUX("TX SMIC MUX5", SND_SOC_NOPM, 0, 0, &tx_smic5_mux),
> -	SND_SOC_DAPM_MUX("TX SMIC MUX6", SND_SOC_NOPM, 0, 0, &tx_smic6_mux),
> -	SND_SOC_DAPM_MUX("TX SMIC MUX7", SND_SOC_NOPM, 0, 0, &tx_smic7_mux),
> -
>   	SND_SOC_DAPM_MUX("TX DMIC MUX0", SND_SOC_NOPM, 4, 0, &tx_dmic0_mux),
>   	SND_SOC_DAPM_MUX("TX DMIC MUX1", SND_SOC_NOPM, 4, 0, &tx_dmic1_mux),
>   	SND_SOC_DAPM_MUX("TX DMIC MUX2", SND_SOC_NOPM, 4, 0, &tx_dmic2_mux),
> @@ -1445,18 +1399,6 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
>   	SND_SOC_DAPM_MUX("TX DMIC MUX6", SND_SOC_NOPM, 4, 0, &tx_dmic6_mux),
>   	SND_SOC_DAPM_MUX("TX DMIC MUX7", SND_SOC_NOPM, 4, 0, &tx_dmic7_mux),
>   
> -	SND_SOC_DAPM_INPUT("TX SWR_ADC0"),
> -	SND_SOC_DAPM_INPUT("TX SWR_ADC1"),
> -	SND_SOC_DAPM_INPUT("TX SWR_ADC2"),
> -	SND_SOC_DAPM_INPUT("TX SWR_ADC3"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC0"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC1"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC2"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC3"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC4"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC5"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC6"),
> -	SND_SOC_DAPM_INPUT("TX SWR_DMIC7"),
>   	SND_SOC_DAPM_INPUT("TX DMIC0"),
>   	SND_SOC_DAPM_INPUT("TX DMIC1"),
>   	SND_SOC_DAPM_INPUT("TX DMIC2"),
> @@ -1577,7 +1519,81 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
>   	{"TX DMIC MUX0", "DMIC5", "TX DMIC5"},
>   	{"TX DMIC MUX0", "DMIC6", "TX DMIC6"},
>   	{"TX DMIC MUX0", "DMIC7", "TX DMIC7"},
> +};
>   
> +/* Controls and routes specific to LPASS <= v9.0.0 */
> +static const char * const smic_mux_text_v9[] = {
> +	"ZERO", "ADC0", "ADC1", "ADC2", "ADC3", "SWR_DMIC0",
> +	"SWR_DMIC1", "SWR_DMIC2", "SWR_DMIC3", "SWR_DMIC4",
> +	"SWR_DMIC5", "SWR_DMIC6", "SWR_DMIC7"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic0_enum_v9, CDC_TX_INP_MUX_ADC_MUX0_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic1_enum_v9, CDC_TX_INP_MUX_ADC_MUX1_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic2_enum_v9, CDC_TX_INP_MUX_ADC_MUX2_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic3_enum_v9, CDC_TX_INP_MUX_ADC_MUX3_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic4_enum_v9, CDC_TX_INP_MUX_ADC_MUX4_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic5_enum_v9, CDC_TX_INP_MUX_ADC_MUX5_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic6_enum_v9, CDC_TX_INP_MUX_ADC_MUX6_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static SOC_ENUM_SINGLE_DECL(tx_smic7_enum_v9, CDC_TX_INP_MUX_ADC_MUX7_CFG0,
> +			0, smic_mux_text_v9);
> +
> +static const struct snd_kcontrol_new tx_smic0_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic0", tx_smic0_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +static const struct snd_kcontrol_new tx_smic1_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic1", tx_smic1_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +static const struct snd_kcontrol_new tx_smic2_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic2", tx_smic2_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +static const struct snd_kcontrol_new tx_smic3_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic3", tx_smic3_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +static const struct snd_kcontrol_new tx_smic4_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic4", tx_smic4_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +static const struct snd_kcontrol_new tx_smic5_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic5", tx_smic5_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +static const struct snd_kcontrol_new tx_smic6_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic6", tx_smic6_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +static const struct snd_kcontrol_new tx_smic7_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic7", tx_smic7_enum_v9,
> +			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
> +
> +static const struct snd_soc_dapm_widget tx_macro_dapm_widgets_v9[] = {
> +	SND_SOC_DAPM_MUX("TX SMIC MUX0", SND_SOC_NOPM, 0, 0, &tx_smic0_mux_v9),
> +	SND_SOC_DAPM_MUX("TX SMIC MUX1", SND_SOC_NOPM, 0, 0, &tx_smic1_mux_v9),
> +	SND_SOC_DAPM_MUX("TX SMIC MUX2", SND_SOC_NOPM, 0, 0, &tx_smic2_mux_v9),
> +	SND_SOC_DAPM_MUX("TX SMIC MUX3", SND_SOC_NOPM, 0, 0, &tx_smic3_mux_v9),
> +	SND_SOC_DAPM_MUX("TX SMIC MUX4", SND_SOC_NOPM, 0, 0, &tx_smic4_mux_v9),
> +	SND_SOC_DAPM_MUX("TX SMIC MUX5", SND_SOC_NOPM, 0, 0, &tx_smic5_mux_v9),
> +	SND_SOC_DAPM_MUX("TX SMIC MUX6", SND_SOC_NOPM, 0, 0, &tx_smic6_mux_v9),
> +	SND_SOC_DAPM_MUX("TX SMIC MUX7", SND_SOC_NOPM, 0, 0, &tx_smic7_mux_v9),
> +
> +	SND_SOC_DAPM_INPUT("TX SWR_ADC0"),
> +	SND_SOC_DAPM_INPUT("TX SWR_ADC1"),
> +	SND_SOC_DAPM_INPUT("TX SWR_ADC2"),
> +	SND_SOC_DAPM_INPUT("TX SWR_ADC3"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC0"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC1"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC2"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC3"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC4"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC5"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC6"),
> +	SND_SOC_DAPM_INPUT("TX SWR_DMIC7"),
> +};
> +
> +static const struct snd_soc_dapm_route tx_audio_map_v9[] = {
>   	{"TX DEC0 MUX", "SWR_MIC", "TX SMIC MUX0"},
>   	{"TX SMIC MUX0", NULL, "TX_SWR_CLK"},
>   	{"TX SMIC MUX0", "ADC0", "TX SWR_ADC0"},
> @@ -1823,10 +1839,41 @@ static const struct snd_kcontrol_new tx_macro_snd_controls[] = {
>   		       tx_macro_get_bcs, tx_macro_set_bcs),
>   };
>   
> +static int tx_macro_component_extend(struct snd_soc_component *comp)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(comp);
> +	struct tx_macro *tx = snd_soc_component_get_drvdata(comp);
> +	int ret;
> +
> +	if (tx->data->extra_widgets_num) {
> +		ret = snd_soc_dapm_new_controls(dapm, tx->data->extra_widgets,
> +						tx->data->extra_widgets_num);
> +		if (ret) {
> +			dev_err(tx->dev, "failed to add extra widgets: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (tx->data->extra_routes_num) {
> +		ret = snd_soc_dapm_add_routes(dapm, tx->data->extra_routes,
> +					      tx->data->extra_routes_num);
> +		if (ret) {
> +			dev_err(tx->dev, "failed to add extra routes: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int tx_macro_component_probe(struct snd_soc_component *comp)
>   {
>   	struct tx_macro *tx = snd_soc_component_get_drvdata(comp);
> -	int i;
> +	int i, ret;
> +
> +	ret = tx_macro_component_extend(comp);
> +	if (ret)
> +		return ret;
>   
>   	snd_soc_component_init_regmap(comp, tx->regmap);
>   
> @@ -1954,17 +2001,16 @@ static int tx_macro_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> -	kernel_ulong_t flags;
>   	struct tx_macro *tx;
>   	void __iomem *base;
>   	int ret, reg;
>   
> -	flags = (kernel_ulong_t)device_get_match_data(dev);
> -
>   	tx = devm_kzalloc(dev, sizeof(*tx), GFP_KERNEL);
>   	if (!tx)
>   		return -ENOMEM;
>   
> +	tx->data = device_get_match_data(dev);
> +
>   	tx->macro = devm_clk_get_optional(dev, "macro");
>   	if (IS_ERR(tx->macro))
>   		return PTR_ERR(tx->macro);
> @@ -1977,7 +2023,7 @@ static int tx_macro_probe(struct platform_device *pdev)
>   	if (IS_ERR(tx->mclk))
>   		return PTR_ERR(tx->mclk);
>   
> -	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
> +	if (tx->data->flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
>   		tx->npl = devm_clk_get(dev, "npl");
>   		if (IS_ERR(tx->npl))
>   			return PTR_ERR(tx->npl);
> @@ -2155,21 +2201,40 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
>   	SET_RUNTIME_PM_OPS(tx_macro_runtime_suspend, tx_macro_runtime_resume, NULL)
>   };
>   
> +static const struct tx_macro_data lpass_ver_9 = {
> +	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> +	.ver			= LPASS_VER_9_0_0,
> +	.extra_widgets		= tx_macro_dapm_widgets_v9,
> +	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
> +	.extra_routes		= tx_audio_map_v9,
> +	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
> +};
> +
> +static const struct tx_macro_data lpass_ver_11 = {
> +	.flags			= 0,
> +	.ver			= LPASS_VER_11_0_0,
> +	.extra_widgets		= tx_macro_dapm_widgets_v9,
> +	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
> +	.extra_routes		= tx_audio_map_v9,
> +	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
> +};
> +
>   static const struct of_device_id tx_macro_dt_match[] = {
>   	{
>   		.compatible = "qcom,sc7280-lpass-tx-macro",
> -		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> +		.data = &lpass_ver_9,
>   	}, {
>   		.compatible = "qcom,sm8250-lpass-tx-macro",
> -		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> +		.data = &lpass_ver_9,
>   	}, {
>   		.compatible = "qcom,sm8450-lpass-tx-macro",
> -		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> +		.data = &lpass_ver_9,
>   	}, {
>   		.compatible = "qcom,sm8550-lpass-tx-macro",
> +		.data = &lpass_ver_11,
>   	}, {
>   		.compatible = "qcom,sc8280xp-lpass-tx-macro",
> -		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> +		.data = &lpass_ver_9,
>   	},
>   	{ }
>   };

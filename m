Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763A67FDD08
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjK2Qas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjK2Qap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:30:45 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F610C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:30:50 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9c39b7923so11301fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701275449; x=1701880249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqYU8iwztuDXjDfeokuEzlO5hW0j8v5I0bC84hrmW9g=;
        b=l2Hv/CtRAMoLj1fodd6EEe8If7isLqMIiVyKkU1sAHIjTeZA4yg+SKSJelq4tPIml1
         Cs9JPwAXtKrYjM6SaAB7s6MBJPdL4n/iUnqognqhWh7KrG0khGrj/kEXyGbWWAvow3ji
         PciYR2DCj6rTpk1Bvbdcs9Os/t3H1xh+zURBGWOTTRxmBO2o+xKLvRondsGQJcRG+VJ+
         k3aOWPlrwPX+MxJRQVIsjUxMy89cl3XOeIcOjlcQfJYXR5HUlE0WN8U3fx5/R5Dk5BY5
         x+LdrIHwVeweEPCw7N8XlDeXyDjQIsoilb80gptPqdW78orYy6Uu8KamGQ5rgygC0M9g
         7fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275449; x=1701880249;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TqYU8iwztuDXjDfeokuEzlO5hW0j8v5I0bC84hrmW9g=;
        b=P8S1GCJULg8m1dWUWDfM8wc6wuOw4N4hcwiqqIHaiXfGRRQdFrtKS/xRoACkNTnGgI
         HObtTiFz9gI9tuKtuAMb6+N/IP3EsPGPGsntC4WTr6SPfgzLEV3v4tJgiF28nKTivJGU
         NQymAwzaxZ4H6bjXJB4DAFE2cH185KindfnOUY3Dzsku6FeiqZhZ3xO1w2NSVQqKe1TK
         G9fddfeWW79bu7VwxzueRo3qyJCLlTIAiKgURA+X372dfvYZ2oPnLe2vvwJReidOWkFv
         Vf5EATHkXUexFIrIVCw9AlwlgfvdB7cm9yZPKjVSFb9WWXIz7DbM2snufDzeby0cX9oE
         o8Fw==
X-Gm-Message-State: AOJu0YxurRWeeqrtEbYFbCVGJJqdELODSbCViSKcRHU/w2/rNjQHEyt+
        G/NMGEZszRz81V9MAgjRZRzx2Q==
X-Google-Smtp-Source: AGHT+IG4M7TjuTCHamYuuhPyqfoP5F2bi3uqy6qS1rEVtW3/lTvHjpUJChxo0Wm8gXoM5/Eg9z4qCA==
X-Received: by 2002:a2e:914b:0:b0:2c9:c03d:58c8 with SMTP id q11-20020a2e914b000000b002c9c03d58c8mr1602632ljg.52.1701275448645;
        Wed, 29 Nov 2023 08:30:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c? ([2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040b481222e3sm2781843wmo.41.2023.11.29.08.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:30:48 -0800 (PST)
Message-ID: <89b521d6-e069-4bd5-a24c-87c3bf620796@linaro.org>
Date:   Wed, 29 Nov 2023 17:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/4] pwm: meson: add generic compatible for meson8 to
 sm1
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
 <20231129134004.3642121-5-jbrunet@baylibre.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231129134004.3642121-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 29/11/2023 14:40, Jerome Brunet wrote:
> Introduce a new compatible support in the Amlogic PWM driver.
> 
> The PWM HW is actually the same for all SoCs supported so far.
> A specific compatible is needed only because the clock sources
> of the PWMs are hard-coded in the driver.
> 
> It is better to have the clock source described in DT but this
> changes the bindings so a new compatible must be introduced.
> 
> When all supported platform have migrated to the new compatible,
> support for the legacy ones may be removed from the driver.
> 
> Adding a callback to setup the clock will also make it easier
> to add support for the new PWM HW found in a1, s4, c3 and t7 SoC
> families.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/pwm/pwm-meson.c | 224 ++++++++++++++++++++++++----------------
>   1 file changed, 133 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 5cbd65cae28a..d5d745a651d3 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -95,6 +95,7 @@ struct meson_pwm_channel {
>   
>   struct meson_pwm_data {
>   	const char * const *parent_names;
> +	int (*channels_init)(struct device *dev);
>   };
>   
>   struct meson_pwm {
> @@ -333,95 +334,6 @@ static const struct pwm_ops meson_pwm_ops = {
>   	.get_state = meson_pwm_get_state,
>   };
>   
> -static const char * const pwm_meson8b_parent_names[] = {
> -	"xtal", NULL, "fclk_div4", "fclk_div3"
> -};
> -
> -static const struct meson_pwm_data pwm_meson8b_data = {
> -	.parent_names = pwm_meson8b_parent_names,
> -};
> -
> -/*
> - * Only the 2 first inputs of the GXBB AO PWMs are valid
> - * The last 2 are grounded
> - */
> -static const char * const pwm_gxbb_ao_parent_names[] = {
> -	"xtal", "clk81", NULL, NULL,
> -};
> -
> -static const struct meson_pwm_data pwm_gxbb_ao_data = {
> -	.parent_names = pwm_gxbb_ao_parent_names,
> -};
> -
> -static const char * const pwm_axg_ee_parent_names[] = {
> -	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
> -};
> -
> -static const struct meson_pwm_data pwm_axg_ee_data = {
> -	.parent_names = pwm_axg_ee_parent_names,
> -};
> -
> -static const char * const pwm_axg_ao_parent_names[] = {
> -	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
> -};
> -
> -static const struct meson_pwm_data pwm_axg_ao_data = {
> -	.parent_names = pwm_axg_ao_parent_names,
> -};
> -
> -static const char * const pwm_g12a_ao_ab_parent_names[] = {
> -	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
> -};
> -
> -static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
> -	.parent_names = pwm_g12a_ao_ab_parent_names,
> -};
> -
> -static const char * const pwm_g12a_ao_cd_parent_names[] = {
> -	"xtal", "g12a_ao_clk81", NULL, NULL,
> -};
> -
> -static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
> -	.parent_names = pwm_g12a_ao_cd_parent_names,
> -};
> -
> -static const struct of_device_id meson_pwm_matches[] = {
> -	{
> -		.compatible = "amlogic,meson8b-pwm",
> -		.data = &pwm_meson8b_data
> -	},
> -	{
> -		.compatible = "amlogic,meson-gxbb-pwm",
> -		.data = &pwm_meson8b_data
> -	},
> -	{
> -		.compatible = "amlogic,meson-gxbb-ao-pwm",
> -		.data = &pwm_gxbb_ao_data
> -	},
> -	{
> -		.compatible = "amlogic,meson-axg-ee-pwm",
> -		.data = &pwm_axg_ee_data
> -	},
> -	{
> -		.compatible = "amlogic,meson-axg-ao-pwm",
> -		.data = &pwm_axg_ao_data
> -	},
> -	{
> -		.compatible = "amlogic,meson-g12a-ee-pwm",
> -		.data = &pwm_meson8b_data
> -	},
> -	{
> -		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
> -		.data = &pwm_g12a_ao_ab_data
> -	},
> -	{
> -		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
> -		.data = &pwm_g12a_ao_cd_data
> -	},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> -
>   static int meson_pwm_init_clocks_legacy(struct device *dev,
>   					struct clk_parent_data *mux_parent_data)
>   {
> @@ -528,12 +440,15 @@ static int meson_pwm_init_clocks_legacy(struct device *dev,
>   	return 0;
>   }
>   
> -static int meson_pwm_init_channels(struct device *dev)
> +static int meson_pwm_init_channels_legacy(struct device *dev)
>   {
>   	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
>   	struct meson_pwm *meson = dev_get_drvdata(dev);
>   	int i;
>   
> +	dev_info(dev, "using obsolete compatible, please consider updating dt\n");

I think dev_warn_once would be more appropriate

> +
> +
>   	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
>   		mux_parent_data[i].index = -1;
>   		mux_parent_data[i].name = meson->data->parent_names[i];
> @@ -542,6 +457,133 @@ static int meson_pwm_init_channels(struct device *dev)
>   	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
>   }
>   
> +static int meson_pwm_init_channels_meson8b_v2(struct device *dev)
> +{
> +	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
> +	int i;
> +
> +	/*
> +	 * NOTE: Instead of relying on the hard coded names in the driver
> +	 * as the legacy version, this relies on DT to provide the list of
> +	 * clocks.
> +	 * For once, using input numbers actually makes more sense than names.
> +	 * Also DT requires clock-names to be explicitly ordered, so there is
> +	 * no point bothering with clock names in this case.
> +	 */
> +	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++)
> +		mux_parent_data[i].index = i;
> +
> +	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
> +}
> +
> +static const char * const pwm_meson8b_parent_names[] = {
> +	"xtal", NULL, "fclk_div4", "fclk_div3"
> +};
> +
> +static const struct meson_pwm_data pwm_meson8b_data = {
> +	.parent_names = pwm_meson8b_parent_names,
> +	.channels_init = meson_pwm_init_channels_legacy,
> +};
> +
> +/*
> + * Only the 2 first inputs of the GXBB AO PWMs are valid
> + * The last 2 are grounded
> + */
> +static const char * const pwm_gxbb_ao_parent_names[] = {
> +	"xtal", "clk81", NULL, NULL,
> +};
> +
> +static const struct meson_pwm_data pwm_gxbb_ao_data = {
> +	.parent_names = pwm_gxbb_ao_parent_names,
> +	.channels_init = meson_pwm_init_channels_legacy,
> +};
> +
> +static const char * const pwm_axg_ee_parent_names[] = {
> +	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
> +};
> +
> +static const struct meson_pwm_data pwm_axg_ee_data = {
> +	.parent_names = pwm_axg_ee_parent_names,
> +	.channels_init = meson_pwm_init_channels_legacy,
> +};
> +
> +static const char * const pwm_axg_ao_parent_names[] = {
> +	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
> +};
> +
> +static const struct meson_pwm_data pwm_axg_ao_data = {
> +	.parent_names = pwm_axg_ao_parent_names,
> +	.channels_init = meson_pwm_init_channels_legacy,
> +};
> +
> +static const char * const pwm_g12a_ao_ab_parent_names[] = {
> +	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
> +};
> +
> +static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
> +	.parent_names = pwm_g12a_ao_ab_parent_names,
> +	.channels_init = meson_pwm_init_channels_legacy,
> +};
> +
> +static const char * const pwm_g12a_ao_cd_parent_names[] = {
> +	"xtal", "g12a_ao_clk81", NULL, NULL,
> +};
> +
> +static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
> +	.parent_names = pwm_g12a_ao_cd_parent_names,
> +	.channels_init = meson_pwm_init_channels_legacy,
> +};
> +
> +static const struct meson_pwm_data pwm_meson8_v2_data = {
> +	.channels_init = meson_pwm_init_channels_meson8b_v2,
> +};
> +
> +static const struct of_device_id meson_pwm_matches[] = {
> +	{
> +		.compatible = "amlogic,meson8-pwm-v2",
> +		.data = &pwm_meson8_v2_data
> +	},
> +	/*
> +	 * The following compatibles are obsolete.
> +	 * Support for these may be removed once the related
> +	 * platforms have been updated
> +	 */

Not really, support will be needed until there's DT in the
wild with the old bindings, which is likely forever.
Drop the 2 last lines, only specify they are obsolete, and
perhaps note support for legacy bindings will be kept as
best effort but regressions may happen or something similar.

> +	{
> +		.compatible = "amlogic,meson8b-pwm",
> +		.data = &pwm_meson8b_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-gxbb-pwm",
> +		.data = &pwm_meson8b_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-gxbb-ao-pwm",
> +		.data = &pwm_gxbb_ao_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-ee-pwm",
> +		.data = &pwm_axg_ee_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-ao-pwm",
> +		.data = &pwm_axg_ao_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-g12a-ee-pwm",
> +		.data = &pwm_meson8b_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
> +		.data = &pwm_g12a_ao_ab_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
> +		.data = &pwm_g12a_ao_cd_data
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> +
>   static int meson_pwm_probe(struct platform_device *pdev)
>   {
>   	struct meson_pwm *meson;
> @@ -573,7 +615,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> -	err = meson_pwm_init_channels(&pdev->dev);
> +	err = meson->data->channels_init(&pdev->dev);
>   	if (err < 0)
>   		return err;
>   

Apart the dev_info change and the meson_pwm_init_clocks_legacy rename, it looks fine.

Neil

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0037FDCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjK2Q2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjK2QZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:25:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F584D66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:25:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b54261524so6488115e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701275147; x=1701879947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOEw8yoPt5zNKY7C3DQOMR8tQtPP6+GGJ/QOXTvXVFU=;
        b=xTUl1MKhVKMXAWw2lPmUb7+MGcJaZx5JLjc3/+bLsNZKY/AzXrLQ9Kf8UCknArC1rZ
         NzNtO+bKFhgHY5mpDLYaAOgNFO53KDGMFCaMkaLvngGCFwJURRD8gp9pv1RhgXs3u7DL
         Ac2bCMLcXo3uTYsJFRjd4syFzw6hZIBuDIlmJamcJlKBoJCaj3v5A/KNZ0CEYLB44U+h
         UsDigyV52WiaYzWstqJFotOzMVaAjlaDKWBhF0CGLcNyxfmBdcivIsVOLwXx+cGiAKJ9
         i7Nkylh7r7OCp56+xm/iQMIoZs3NSmotvHLolGNgM2er8eobm+6nxfMXwjbTPIpAtRBn
         Cp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275147; x=1701879947;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mOEw8yoPt5zNKY7C3DQOMR8tQtPP6+GGJ/QOXTvXVFU=;
        b=gQJ2z1pukbf9OeqfrKIdO+DRNNnxPxP/uluXakwsjp4T/XBK61+aFKtkbpozc2Goox
         FY9+Iuw0GJ7PbmcecZ04cgzQh7cLNVnMY12exYQKbYbX1qXQy2Cq1T4f9AUOHT8jpuee
         5CnkpBFZiDXcVDdKt8xJz32djh7JQ9EjGiyFctRZ3zNLMb46l2koAQ2eRQq7OrdTl+lQ
         7d5tNMzTPaisIzHV5tjonpsQSdO3RHxtge0QfoNafvQO/oZo+om09vyPPHub3rL65zQw
         IFmO4rbJg+Rtx5PqTsia5tJuuQ8Z0/HHuYMPyaTwa8GXAYZIjBi/FaCuBeyUp/+4TC2p
         swsQ==
X-Gm-Message-State: AOJu0Yxhu+tPCshyX8npKN13FnkXSchgWGPApcsQb9/fYBDHlOy+8lWY
        VffLkYXwSdxahXXSFolmVKhhSg==
X-Google-Smtp-Source: AGHT+IEk/qK9St0NWK+FJMsNCCBjpf9lub/pl4DvM1I1+NkdoisyQDEU6hBfA9LR8VZTHCATbO6HpQ==
X-Received: by 2002:a05:600c:4f8a:b0:40b:4520:45c9 with SMTP id n10-20020a05600c4f8a00b0040b452045c9mr7464824wmq.36.1701275146554;
        Wed, 29 Nov 2023 08:25:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c? ([2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm2725426wmq.32.2023.11.29.08.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:25:46 -0800 (PST)
Message-ID: <0ed0e573-08c9-4216-ad4c-66cc6563e036@linaro.org>
Date:   Wed, 29 Nov 2023 17:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/4] pwm: meson: prepare addition of new compatible
 types
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
 <20231129134004.3642121-4-jbrunet@baylibre.com>
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
In-Reply-To: <20231129134004.3642121-4-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/11/2023 14:39, Jerome Brunet wrote:
> Clean the amlogic pwm driver to prepare the addition of new pwm compatibles
> * Generalize 4 inputs clock per channel.
>    AO pwm may just get 2 extra NULL entries which actually better
>    describes the reality of the HW.
> * Use driver data to carry the device data and remove pwm_chip from it
> * Stop carrying the internal clock elements with the device data.
>    These are not needed past init.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/pwm/pwm-meson.c | 150 +++++++++++++++++++++++-----------------
>   1 file changed, 87 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 5bea53243ed2..5cbd65cae28a 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -60,7 +60,7 @@
>   #define MISC_A_EN		BIT(0)
>   
>   #define MESON_NUM_PWMS		2
> -#define MESON_MAX_MUX_PARENTS	4
> +#define MESON_NUM_MUX_PARENTS	4
>   
>   static struct meson_pwm_channel_data {
>   	u8		reg_offset;
> @@ -90,19 +90,14 @@ struct meson_pwm_channel {
>   	unsigned int hi;
>   	unsigned int lo;
>   
> -	struct clk_mux mux;
> -	struct clk_divider div;
> -	struct clk_gate gate;
>   	struct clk *clk;
>   };
>   
>   struct meson_pwm_data {
>   	const char * const *parent_names;
> -	unsigned int num_parents;
>   };
>   
>   struct meson_pwm {
> -	struct pwm_chip chip;

It seems you're mixing multiple things in the same patch,
you should split it to implement the pwm_chip migration,
and parent_names/clk init in 2 patches.

>   	const struct meson_pwm_data *data;
>   	struct meson_pwm_channel channels[MESON_NUM_PWMS];
>   	void __iomem *base;
> @@ -115,7 +110,7 @@ struct meson_pwm {
>   
>   static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
>   {
> -	return container_of(chip, struct meson_pwm, chip);
> +	return dev_get_drvdata(chip->dev);
>   }
>   
>   static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -147,6 +142,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   			  const struct pwm_state *state)
>   {
>   	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
> +	struct device *dev = pwm->chip->dev;
>   	unsigned int cnt, duty_cnt;
>   	unsigned long fin_freq;
>   	u64 duty, period, freq;
> @@ -169,19 +165,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   
>   	fin_freq = clk_round_rate(channel->clk, freq);
>   	if (fin_freq == 0) {
> -		dev_err(meson->chip.dev, "invalid source clock frequency\n");
> +		dev_err(dev, "invalid source clock frequency\n");
>   		return -EINVAL;
>   	}
>   
> -	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
> +	dev_dbg(dev, "fin_freq: %lu Hz\n", fin_freq);
>   
>   	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
>   	if (cnt > 0xffff) {
> -		dev_err(meson->chip.dev, "unable to get period cnt\n");
> +		dev_err(dev, "unable to get period cnt\n");
>   		return -EINVAL;
>   	}
>   
> -	dev_dbg(meson->chip.dev, "period=%llu cnt=%u\n", period, cnt);
> +	dev_dbg(dev, "period=%llu cnt=%u\n", period, cnt);
>   
>   	if (duty == period) {
>   		channel->hi = cnt;
> @@ -192,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   	} else {
>   		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
>   
> -		dev_dbg(meson->chip.dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
> +		dev_dbg(dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
>   
>   		channel->hi = duty_cnt;
>   		channel->lo = cnt - duty_cnt;
> @@ -215,7 +211,7 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>   
>   	err = clk_set_rate(channel->clk, channel->rate);
>   	if (err)
> -		dev_err(meson->chip.dev, "setting clock rate failed\n");
> +		dev_err(pwm->chip->dev, "setting clock rate failed\n");
>   
>   	spin_lock_irqsave(&meson->lock, flags);
>   
> @@ -343,7 +339,6 @@ static const char * const pwm_meson8b_parent_names[] = {
>   
>   static const struct meson_pwm_data pwm_meson8b_data = {
>   	.parent_names = pwm_meson8b_parent_names,
> -	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
>   };
>   
>   /*
> @@ -351,12 +346,11 @@ static const struct meson_pwm_data pwm_meson8b_data = {
>    * The last 2 are grounded
>    */
>   static const char * const pwm_gxbb_ao_parent_names[] = {
> -	"xtal", "clk81"
> +	"xtal", "clk81", NULL, NULL,
>   };
>   
>   static const struct meson_pwm_data pwm_gxbb_ao_data = {
>   	.parent_names = pwm_gxbb_ao_parent_names,
> -	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
>   };
>   
>   static const char * const pwm_axg_ee_parent_names[] = {
> @@ -365,7 +359,6 @@ static const char * const pwm_axg_ee_parent_names[] = {
>   
>   static const struct meson_pwm_data pwm_axg_ee_data = {
>   	.parent_names = pwm_axg_ee_parent_names,
> -	.num_parents = ARRAY_SIZE(pwm_axg_ee_parent_names),
>   };
>   
>   static const char * const pwm_axg_ao_parent_names[] = {
> @@ -374,7 +367,6 @@ static const char * const pwm_axg_ao_parent_names[] = {
>   
>   static const struct meson_pwm_data pwm_axg_ao_data = {
>   	.parent_names = pwm_axg_ao_parent_names,
> -	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
>   };
>   
>   static const char * const pwm_g12a_ao_ab_parent_names[] = {
> @@ -383,16 +375,14 @@ static const char * const pwm_g12a_ao_ab_parent_names[] = {
>   
>   static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
>   	.parent_names = pwm_g12a_ao_ab_parent_names,
> -	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_names),
>   };
>   
>   static const char * const pwm_g12a_ao_cd_parent_names[] = {
> -	"xtal", "g12a_ao_clk81",
> +	"xtal", "g12a_ao_clk81", NULL, NULL,
>   };
>   
>   static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>   	.parent_names = pwm_g12a_ao_cd_parent_names,
> -	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
>   };
>   
>   static const struct of_device_id meson_pwm_matches[] = {
> @@ -432,23 +422,25 @@ static const struct of_device_id meson_pwm_matches[] = {
>   };
>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>   
> -static int meson_pwm_init_channels(struct meson_pwm *meson)
> +static int meson_pwm_init_clocks_legacy(struct device *dev,
> +					struct clk_parent_data *mux_parent_data)

It's not yet legacy, the rename should be in the next patch

>   {
> -	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
> -	struct device *dev = meson->chip.dev;
> +	struct meson_pwm *meson = dev_get_drvdata(dev);
>   	unsigned int i;
>   	char name[255];
>   	int err;
>   
> -	for (i = 0; i < meson->data->num_parents; i++) {
> -		mux_parent_data[i].index = -1;
> -		mux_parent_data[i].name = meson->data->parent_names[i];
> -	}
> -
> -	for (i = 0; i < meson->chip.npwm; i++) {
> +	for (i = 0; i < MESON_NUM_PWMS; i++) {
>   		struct meson_pwm_channel *channel = &meson->channels[i];
>   		struct clk_parent_data div_parent = {}, gate_parent = {};
>   		struct clk_init_data init = {};
> +		struct clk_divider *div;
> +		struct clk_gate *gate;
> +		struct clk_mux *mux;
> +
> +		mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +		if (!mux)
> +			return -ENOMEM;
>   
>   		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>   
> @@ -456,69 +448,76 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>   		init.ops = &clk_mux_ops;
>   		init.flags = 0;
>   		init.parent_data = mux_parent_data;
> -		init.num_parents = meson->data->num_parents;
> -
> -		channel->mux.reg = meson->base + REG_MISC_AB;
> -		channel->mux.shift =
> -				meson_pwm_per_channel_data[i].clk_sel_shift;
> -		channel->mux.mask = MISC_CLK_SEL_MASK;
> -		channel->mux.flags = 0;
> -		channel->mux.lock = &meson->lock;
> -		channel->mux.table = NULL;
> -		channel->mux.hw.init = &init;
> -
> -		err = devm_clk_hw_register(dev, &channel->mux.hw);
> +		init.num_parents = MESON_NUM_MUX_PARENTS;
> +
> +		mux->reg = meson->base + REG_MISC_AB;
> +		mux->shift = meson_pwm_per_channel_data[i].clk_sel_shift;
> +		mux->mask = MISC_CLK_SEL_MASK;
> +		mux->flags = 0;
> +		mux->lock = &meson->lock;
> +		mux->table = NULL;
> +		mux->hw.init = &init;
> +
> +		err = devm_clk_hw_register(dev, &mux->hw);
>   		if (err) {
>   			dev_err(dev, "failed to register %s: %d\n", name, err);
>   			return err;
>   		}
>   
> +		div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +		if (!div)
> +			return -ENOMEM;
> +
>   		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
>   
>   		init.name = name;
>   		init.ops = &clk_divider_ops;
>   		init.flags = CLK_SET_RATE_PARENT;
>   		div_parent.index = -1;
> -		div_parent.hw = &channel->mux.hw;
> +		div_parent.hw = &mux->hw;
>   		init.parent_data = &div_parent;
>   		init.num_parents = 1;
>   
> -		channel->div.reg = meson->base + REG_MISC_AB;
> -		channel->div.shift = meson_pwm_per_channel_data[i].clk_div_shift;
> -		channel->div.width = MISC_CLK_DIV_WIDTH;
> -		channel->div.hw.init = &init;
> -		channel->div.flags = 0;
> -		channel->div.lock = &meson->lock;
> +		div->reg = meson->base + REG_MISC_AB;
> +		div->shift = meson_pwm_per_channel_data[i].clk_div_shift;
> +		div->width = MISC_CLK_DIV_WIDTH;
> +		div->hw.init = &init;
> +		div->flags = 0;
> +		div->lock = &meson->lock;
>   
> -		err = devm_clk_hw_register(dev, &channel->div.hw);
> +		err = devm_clk_hw_register(dev, &div->hw);
>   		if (err) {
>   			dev_err(dev, "failed to register %s: %d\n", name, err);
>   			return err;
>   		}
>   
> +		gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
> +		if (!gate)
> +			return -ENOMEM;
> +
>   		snprintf(name, sizeof(name), "%s#gate%u", dev_name(dev), i);
>   
>   		init.name = name;
>   		init.ops = &clk_gate_ops;
>   		init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
>   		gate_parent.index = -1;
> -		gate_parent.hw = &channel->div.hw;
> +		gate_parent.hw = &div->hw;
>   		init.parent_data = &gate_parent;
>   		init.num_parents = 1;
>   
> -		channel->gate.reg = meson->base + REG_MISC_AB;
> -		channel->gate.bit_idx = meson_pwm_per_channel_data[i].clk_en_shift;
> -		channel->gate.hw.init = &init;
> -		channel->gate.flags = 0;
> -		channel->gate.lock = &meson->lock;
> +		gate->reg = meson->base + REG_MISC_AB;
> +		gate->bit_idx = meson_pwm_per_channel_data[i].clk_en_shift;
> +		gate->hw.init = &init;
> +		gate->flags = 0;
> +		gate->lock = &meson->lock;
>   
> -		err = devm_clk_hw_register(dev, &channel->gate.hw);
> +		err = devm_clk_hw_register(dev, &gate->hw);
>   		if (err) {
>   			dev_err(dev, "failed to register %s: %d\n", name, err);
>   			return err;
>   		}
>   
> -		channel->clk = devm_clk_hw_get_clk(dev, &channel->gate.hw, NULL);
> +		channel->clk = devm_clk_hw_get_clk(dev, &gate->hw, NULL);
>   		if (IS_ERR(channel->clk)) {
>   			err = PTR_ERR(channel->clk);
>   			dev_err(dev, "failed to register %s: %d\n", name, err);
> @@ -529,31 +528,56 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>   	return 0;
>   }
>   
> +static int meson_pwm_init_channels(struct device *dev)
> +{
> +	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
> +	struct meson_pwm *meson = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
> +		mux_parent_data[i].index = -1;
> +		mux_parent_data[i].name = meson->data->parent_names[i];
> +	}
> +
> +	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
> +}
> +
>   static int meson_pwm_probe(struct platform_device *pdev)
>   {
>   	struct meson_pwm *meson;
> +	struct pwm_chip *chip;
>   	int err;
>   
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
>   	meson = devm_kzalloc(&pdev->dev, sizeof(*meson), GFP_KERNEL);
>   	if (!meson)
>   		return -ENOMEM;
>   
> +	platform_set_drvdata(pdev, meson);
> +
>   	meson->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(meson->base))
>   		return PTR_ERR(meson->base);
>   
>   	spin_lock_init(&meson->lock);
> -	meson->chip.dev = &pdev->dev;
> -	meson->chip.ops = &meson_pwm_ops;
> -	meson->chip.npwm = MESON_NUM_PWMS;
> +	chip->dev = &pdev->dev;
> +	chip->ops = &meson_pwm_ops;
> +	chip->npwm = MESON_NUM_PWMS;
>   
>   	meson->data = of_device_get_match_data(&pdev->dev);
> +	if (!meson->data) {
> +		dev_err(&pdev->dev, "failed to match device\n");
> +		return -ENODEV;
> +	}
>   
> -	err = meson_pwm_init_channels(meson);
> +	err = meson_pwm_init_channels(&pdev->dev);
>   	if (err < 0)
>   		return err;
>   
> -	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
> +	err = devm_pwmchip_add(&pdev->dev, chip);
>   	if (err < 0) {
>   		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
>   		return err;

Thanks,
Neil

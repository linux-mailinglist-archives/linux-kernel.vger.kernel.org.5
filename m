Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB87FB589
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjK1JWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjK1JWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:22:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F162DB6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:22:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b472f99a0so12959405e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701163339; x=1701768139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mz2c+ASS3OZquLLX75cWPW4TUW8yM1LyWTLijYO874o=;
        b=m9PtQKxlIpyrQCCNJGRG38BkvkJX+4BQWY5MqsGMFzHpWERdZed+1Xvg0S2WdPjEgk
         SkcVYguSW7ZkF0Rfj85+h+J1ZLWEbDEX6+XAXe3i4pFJ0/Xwr8J6jmCizBHVHb+oiaLm
         nTR+pP69CqQW0IY1ivWNW955TLPn/Yl/J5MEAS03y1iwB6LkCmQIs4hrVHxKtpQGw9Df
         1KOOSMxaZLfNbS49kR6fVOWX9joJZ3ZNyPke5IFZ/ZflNFJHCJznD+nhSgF6naimRIxU
         AUBxwv0WZPF3qh4AvxsTOsdGeSNwDlauYwgn7nVfRorSm136T5AdoIjoSLxDAVjl5UdI
         hUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163339; x=1701768139;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mz2c+ASS3OZquLLX75cWPW4TUW8yM1LyWTLijYO874o=;
        b=SEQXraYJourT5ZCaKA+3ZHAkyJ7/vKEXggdFHZ8X//2lrKSiq8rnYX4HCKyZrfIBES
         JT1dHu81qn0TXTi57sEl7A+R045OmQGVyK1DTGXBAaLJQ2SeNjqpMyEvOKFmv+inyUfQ
         AxR+xV73d6i2xXcDpSjqwVagw6NbZuL+kGSDMUFW2xvoBLR8AbFdWuzAZXk21hMTrBNR
         qDNk3S2vtmGIo1i4dgqSKLuKzxnHHSc1L7TXNvS5UlsU4c4bRYLGij0CFL42Ehi/nxij
         0oE/cQRWy1kTJmgtHamB5OVeLr1ejMx9Az32qZAh0Kf0TnJf1wGlIWT0IpH0V4zWZuOr
         mInA==
X-Gm-Message-State: AOJu0Yxf7wRx4hJxv9GOABAv4ozYiBo2oqgiFXE1gzQF8RKiEjt8DLF7
        FgCV2XSAcOlhsXdhXQHgJIlEMg==
X-Google-Smtp-Source: AGHT+IHgMkqBRyczzEKtcIljLygkxW9ky+yfVX3UIszpU6/C7WatNAPwEps8ZvBo3wnDonXjvLCVJA==
X-Received: by 2002:a05:600c:1f93:b0:40b:3dc0:1ff with SMTP id je19-20020a05600c1f9300b0040b3dc001ffmr7766928wmb.6.1701163339322;
        Tue, 28 Nov 2023 01:22:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b0040b37f107c4sm15331106wmo.16.2023.11.28.01.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:22:18 -0800 (PST)
Message-ID: <28b3d468-bd2d-4f24-9362-b43ae84777d0@linaro.org>
Date:   Tue, 28 Nov 2023 10:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/5] ASoC: codecs: Add WCD939x Codec driver
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-5-21d4ad9276de@linaro.org>
 <ad9a7c4b-82f4-4347-b4dd-a394e4ba95f0@linaro.org>
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
In-Reply-To: <ad9a7c4b-82f4-4347-b4dd-a394e4ba95f0@linaro.org>
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

On 25/11/2023 13:07, Konrad Dybcio wrote:
> On 23.11.2023 15:49, Neil Armstrong wrote:

<snip>

>> +
>> +static int wcd939x_io_init(struct snd_soc_component *component)
>> +{
>> +	snd_soc_component_write_field(component, WCD939X_ANA_BIAS,
>> +				      WCD939X_BIAS_ANALOG_BIAS_EN, 1);
> All of these values are BIT()s or 2-4 ORed BIT()s, can you check what they
> mean?
> 
> Same for almost all other snd_soc_component_ write/modify functions

Ack

> 
> [...]
> 
>> +static int wcd939x_tx_swr_ctrl(struct snd_soc_dapm_widget *w,
>> +			       struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>> +	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
>> +	int bank;
>> +	int rate;
>> +
>> +	bank = (wcd939x_swr_get_current_bank(wcd939x->sdw_priv[AIF1_CAP]->sdev)) ? 0 : 1;
>> +	bank = bank ? 0 : 1;
> this is just the return value of wcd939x_swr_get_current_bank NOTed twice

Yep, I also found it wild, will simplify

> 
>> +
>> +	switch (event) {
>> +	case SND_SOC_DAPM_PRE_PMU:
>> +		if (strnstr(w->name, "ADC", sizeof("ADC"))) {
>> +			int i = 0, mode = 0;
>> +
>> +			if (test_bit(WCD_ADC1, &wcd939x->status_mask))
>> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC1]];
>> +			if (test_bit(WCD_ADC2, &wcd939x->status_mask))
>> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC2]];
>> +			if (test_bit(WCD_ADC3, &wcd939x->status_mask))
>> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC3]];
>> +			if (test_bit(WCD_ADC4, &wcd939x->status_mask))
>> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC4]];
>> +
>> +			if (mode != 0) {
>> +				for (i = 0; i < ADC_MODE_ULP2; i++) {
>> +					if (mode & (1 << i)) {
> BIT(i)

Ack

> 
>> +						i++;
>> +						break;
>> +					}
> the immediate break makes it look like you're just looking for the first set
> bit, 1-indexed, and there's functions for that

Indeed, let's use that

> 
>> +				}
>> +			}
>> +			rate = wcd939x_get_clk_rate(i);
>> +			wcd939x_set_swr_clk_rate(component, rate, bank);
>> +			/* Copy clk settings to active bank */
>> +			wcd939x_set_swr_clk_rate(component, rate, !bank);
> This comment is very confusing

It is, not sure if I can clarify it more

> 
> [...]
> 
>> +static void wcd939x_mbhc_get_result_params(struct snd_soc_component *component,
>> +					   s16 *d1_a, u16 noff,
>> +						int32_t *zdet)
> very weird alignment

Will fix

> 
>> +{
>> +	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
>> +	int i;
>> +	int val, val1;
>> +	s16 c1;
>> +	s32 x1, d1;
>> +	s32 denom;
>> +	static const int mincode_param[] = {
> static inside a function means something else than static global
> 
>> +		3277, 1639, 820, 410, 205, 103, 52, 26
>> +	};
> reverse-Christmas-tree

Will fix

> 
>> +
>> +	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MBHC_ZDET, 0x20, 0x20);
>> +	for (i = 0; i < WCD939X_ZDET_NUM_MEASUREMENTS; i++) {
>> +		regmap_read(wcd939x->regmap, WCD939X_ANA_MBHC_RESULT_2, &val);
>> +		if (val & 0x80)
> BIT(7), please name it
Will fix

> 
>> +			break;
>> +	}
>> +	val = val << 0x8;
> << 8 makes more sense

Will fix

> 
>> +	regmap_read(wcd939x->regmap, WCD939X_ANA_MBHC_RESULT_1, &val1);
>> +	val |= val1;
>> +	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MBHC_ZDET, 0x20, 0x00);
> BIT()s
Will fix

> 
>> +	x1 = WCD939X_MBHC_GET_X1(val);
>> +	c1 = WCD939X_MBHC_GET_C1(val);
>> +	/* If ramp is not complete, give additional 5ms */
>> +	if (c1 < 2 && x1)
>> +		usleep_range(5000, 5050);
> udelay, see timers-howto.txt
Will fix

> 
> [...]
> 
>> +static void wcd939x_wcd_mbhc_qfuse_cal(struct snd_soc_component *component,
>> +				       s32 *z_val, int flag_l_r)
>> +{
>> +	s16 q1;
>> +	int q1_cal;
>> +
>> +	q1 = snd_soc_component_read(component, WCD939X_DIGITAL_EFUSE_REG_21 + flag_l_r);
>> +	if (q1 & 0x80)
> BIT
>> +		q1_cal = (10000 - ((q1 & 0x7F) * 10));
> GENMASK
Will fix

> 
>> +	else
>> +		q1_cal = (10000 + (q1 * 10));
>> +	if (q1_cal > 0)
>> +		*z_val = ((*z_val) * 10000) / q1_cal;
>> +}
>> +
>> +static void wcd939x_wcd_mbhc_calc_impedance(struct snd_soc_component *component,
>> +					    u32 *zl, uint32_t *zr)
>> +{
>> +	struct wcd939x_priv *wcd939x = dev_get_drvdata(component->dev);
>> +	s16 reg0, reg1, reg2, reg3, reg4;
>> +	s32 z1l, z1r, z1ls;
>> +	int z_mono, z_diff1, z_diff2;
>> +	bool is_fsm_disable = false;
>> +	struct wcd939x_mbhc_zdet_param zdet_param[] = {
> const
Will fix

> 
>> +		{4, 0, 4, 0x08, 0x14, 0x18}, /* < 32ohm */
>> +		{4, 0, 6, 0x18, 0x60, 0x78}, /* 32ohm < Z < 400ohm */
>> +		{1, 4, 5, 0x18, 0x7C, 0x90}, /* 400ohm < Z < 1200ohm */
>> +		{1, 6, 7, 0x18, 0x7C, 0x90}, /* >1200ohm */
>> +	};
>> +	struct wcd939x_mbhc_zdet_param *zdet_param_ptr = NULL;
>> +	s16 d1_a[][4] = {
> const
Will fix

> 
>> +		{0, 30, 90, 30},
>> +		{0, 30, 30, 6},
>> +		{0, 30, 30, 5},
>> +		{0, 30, 30, 5},
>> +	};
>> +	s16 *d1 = NULL;
> ????
Will fix

> 
> [...]
> 
>> +
>> +	rc = of_property_read_u32(np, "qcom,micbias1-microvolt",  &prop_val);
> similarly to the swr port map, this should be commonized for WCDxxxx

Yes, but where ?

> 
> 
> Konrad

Thanks,
Neil

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0082D78E18E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbjH3Vmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbjH3Vmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:42:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C01BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:42:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so245990a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693431650; x=1694036450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EWxGsOLnd1S0YI2fSd+NkLhQt9gXvMSC02V+aZzkUY=;
        b=Ktt539JRob1PNU9Bdn3znXZ9Fdlo/ntF3lcSdzNGC2zENN617LzycvmpEPB2hufX9L
         MZWTPxCSKrbFmjnpuiJ34rkBw02K/A/wdkOOEL7D9LZVLlHxLddARNXCHFNU/81N1Zb6
         YcrWWTKQg9qKrz1UtNY78T5oyyXwdIAecfy4/KX8WVo3aqWUsbOvKdCdtL433eCL5kU5
         ksIuX2jK/OdB0DOj3oU9exhtXug4gRPnbAVw5gFcg7A142HLPMhXr/rpU2H3XEIAFwn7
         P6uUdBjArga339TFumxV3ewVnredoD2a00xLR1yki6qKRBa05UM7Hk8vC3RU0kftsEQH
         DtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693431650; x=1694036450;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EWxGsOLnd1S0YI2fSd+NkLhQt9gXvMSC02V+aZzkUY=;
        b=e1RoBrB20LmXZ8sRdXWGHTlPa1x8Gyb0/J1VJtfEZhW0DTQ5B/jhc4XQXH7dTpIhho
         s7el72Zi0ZPW9CJ6jNuUinccy81nSR+zkZ23UtYCJQgQhpLGydsA/1Qtfv6wNWMZkJlw
         8bQjzujlKy8v3sh+Zphv6jEZemhxclrJ0Z3HuJ16utXrsfNWnsFFRCDB1/6K56bOVAjx
         LsmqQ2ZnkZI9i70XVDNuqrpyoa4sG/LjRrxibsM6bgHLIJpmRVR7saveV5AwAiCSi7Ln
         80z9tvphrILeD2/eHfqto8HzVevcfocyu7bhA5Wb5AHs52R6ds2MH2WzV51SS276QmaF
         3uCA==
X-Gm-Message-State: AOJu0YzT/wBBrSV1qzR4xaPtvKO2e1Vr7pPoxZwg+jAINjkpFtykaUlC
        rpeBF60IpXgS1Kn115hem+x5C5+mu3n3rKhMnedjbg==
X-Google-Smtp-Source: AGHT+IGfR18dSZBXSqYXGSzoHrNRgDwKf6Nb+DOKZeJcaMS5RT7sCIo9zfZ5tbBrSkGgdK4RGB/CLg==
X-Received: by 2002:a05:6512:159c:b0:4ff:8f76:678c with SMTP id bp28-20020a056512159c00b004ff8f76678cmr165497lfb.1.1693420454740;
        Wed, 30 Aug 2023 11:34:14 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id l12-20020ac24a8c000000b004fe633bfcc7sm2473562lfp.17.2023.08.30.11.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 11:34:14 -0700 (PDT)
Message-ID: <3b6f6285-ec3b-4e12-aa65-d5f61937de6f@linaro.org>
Date:   Wed, 30 Aug 2023 20:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     luca.weiss@fairphone.com, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@quicinc.com
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
 <20230830180600.1865-7-quic_amelende@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230830180600.1865-7-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2023 20:05, Anjelique Melendez wrote:
> In some PMICs like pmi632, the pattern look up table (LUT) and LPG
> configuration can be stored in a single SDAM module instead of LUT
> peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
> Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.
I still fail to understand what benefit this brings.

Is this a "can be used", or "should be used", or maybe "must be used"?

Are there any distinct advantages to using one over the other?
I see some limitations in the code below, but that's not being made
obvious.

This all should be in the commit message, the current one includes
a lot of cryptic names that mean nothing to most people.

[...]

>  
> +static int lpg_sdam_write(struct lpg *lpg, u16 addr, u8 val)
Again, looks like excessive helpers for r/w accessors.

> +{
> +	int rc;
> +
> +	rc = nvmem_device_write(lpg->lpg_chan_nvmem, addr, 1, &val);
> +	if (rc < 0) {
> +		dev_err(lpg->dev, "writing %u to SDAM addr %#x failed, rc=%d\n",
> +			val, addr, rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +#define PBS_SW_TRIG_BIT		BIT(0)
> +
> +static int lpg_clear_pbs_trigger(struct lpg_channel *chan)
> +{
> +	int rc;
> +
> +	clear_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
> +	if (!chan->lpg->pbs_en_bitmap) {
> +		rc = lpg_sdam_write(chan->lpg, SDAM_REG_PBS_SEQ_EN, 0);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lpg_set_pbs_trigger(struct lpg_channel *chan)
> +{
> +	int rc;
> +
> +	if (!chan->lpg->pbs_en_bitmap) {
> +		rc = lpg_sdam_write(chan->lpg, SDAM_REG_PBS_SEQ_EN, PBS_SW_TRIG_BIT);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = qcom_pbs_trigger_event(chan->lpg->pbs_dev, PBS_SW_TRIG_BIT);
> +		if (rc < 0)
> +			return rc;
> +	}
> +	set_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
> +
> +	return 0;
> +}
> +
> +static int lpg_sdam_configure_triggers(struct lpg_channel *chan, bool set_trig)
> +{
> +	int rc;
> +
> +	if (chan->lpg->lut_base)
> +		return 0;
> +
> +	if (set_trig) {
> +		rc = lpg_sdam_write(chan->lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 1);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = lpg_set_pbs_trigger(chan);
> +		if (rc < 0)
> +			return rc;
> +		chan->pattern_set = false;
> +	} else {
> +		rc = lpg_sdam_write(chan->lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 0);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = lpg_clear_pbs_trigger(chan);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
>  {
>  	/* Skip if we don't have a triled block */
> @@ -217,6 +333,41 @@ static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
>  				  mask, enable);
>  }
>  
> +static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *pattern,
> +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> +{
> +	u8 brightness;
> +	u16 addr;
> +	unsigned int idx;
> +	int i, rc;
Reverse-Christmas-tree?

> +
> +	if (len > SDAM_LUT_COUNT_MAX) {
> +		dev_err(lpg->dev, "Pattern length (%zu) exceeds maximum pattern length (%d)\n",
> +			len, SDAM_LUT_COUNT_MAX);
> +		return -EINVAL;
> +	}
> +
> +	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> +					 0, len, 0);
> +	if (idx >= lpg->lut_size)
> +		return -ENOSPC;
> +
> +	for (i = 0; i < len; i++) {
> +		brightness = pattern[i].brightness;
> +		addr = lpg->lut_sdam_base + i + idx;
> +		rc = lpg_sdam_write(lpg, addr, brightness);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	bitmap_set(lpg->lut_bitmap, idx, len);
> +
> +	*lo_idx = idx;
> +	*hi_idx = idx + len - 1;
> +
> +	return 0;
> +}
> +
>  static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
>  			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
>  {
> @@ -463,6 +614,26 @@ static void lpg_apply_pwm_value(struct lpg_channel *chan)
>  #define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
>  #define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
>  
> +static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
> +{
> +	u8 val, conf = 0;
> +	struct lpg *lpg = chan->lpg;
Reverse-Christmas-tree?

> +
> +	if (!chan->ramp_oneshot)
> +		conf |= LPG_PATTERN_CONFIG_REPEAT;
> +
> +	lpg_sdam_write(lpg, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 0);
> +	lpg_sdam_write(lpg, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, conf);
> +
> +	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset, chan->pattern_hi_idx);
> +	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset, chan->pattern_lo_idx);
> +
> +	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
> +	if (val > 0)
> +		val--;
????

that sounds very cryptic.. almost like some sort of a bad fixup
maybe the RAMP_STEP_DURATION should contain that "-1"?

not only that, but val is an unsigned value, so it's always > 0

[...]

> @@ -775,7 +952,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	unsigned int lo_idx;
>  	unsigned int hi_idx;
>  	unsigned int i;
> -	bool ping_pong = true;
> +	bool ping_pong = false;
Why?

This change combined with assigning true below for LUT mode
is a NOP

>  	int ret = -EINVAL;
>  
>  	/* Hardware only support oneshot or indefinite loops */
> @@ -824,7 +1001,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	 * used to stretch the first delay of the pattern and a "high pause"
>  	 * the last one.
>  	 *
> -	 * In order to save space the pattern can be played in "ping pong"
> +	 * In order to save space for the pattern can be played in "ping pong"
>  	 * mode, in which the pattern is first played forward, then "high
>  	 * pause" is applied, then the pattern is played backwards and finally
>  	 * the "low pause" is applied.
> @@ -837,16 +1014,22 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	 * If the specified pattern is a palindrome the ping pong mode is
>  	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
>  	 * last in the programmed pattern) determines the "high pause".
> +	 *
> +	 * NVMEM devices supporting LUT do not support "low pause", "high pause"
> +	 * or "ping pong"
>  	 */
>  
>  	/* Detect palindromes and use "ping pong" to reduce LUT usage */
> -	for (i = 0; i < len / 2; i++) {
> -		brightness_a = pattern[i].brightness;
> -		brightness_b = pattern[len - i - 1].brightness;
> -
> -		if (brightness_a != brightness_b) {
> -			ping_pong = false;
> -			break;
> +	if (lpg->lut_base) {
> +		ping_pong = true;
> +		for (i = 0; i < len / 2; i++) {
> +			brightness_a = pattern[i].brightness;
> +			brightness_b = pattern[len - i - 1].brightness;
> +
> +			if (brightness_a != brightness_b) {
> +				ping_pong = false;
> +				break;
> +			}
>  		}
>  	}
>  
> @@ -860,14 +1043,21 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	 * Validate that all delta_t in the pattern are the same, with the
>  	 * exception of the middle element in case of ping_pong.
>  	 */
> -	delta_t = pattern[1].delta_t;
> -	for (i = 2; i < len; i++) {
> +	if (lpg->lpg_chan_nvmem) {
> +		i = 1;
> +		delta_t = pattern[0].delta_t;
> +	} else {
> +		i = 2;
> +		delta_t = pattern[1].delta_t;
> +	}
Why?

What's the rationale behind this change?

> +
> +	for (; i < len; i++) {
>  		if (pattern[i].delta_t != delta_t) {
>  			/*
>  			 * Allow last entry in the full or shortened pattern to
>  			 * specify hi pause. Reject other variations.
>  			 */
> -			if (i != actual_len - 1)
> +			if (i != actual_len - 1 || lpg->lpg_chan_nvmem)
>  				goto out_free_pattern;
>  		}
>  	}
> @@ -876,12 +1066,19 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	if (delta_t >= BIT(9))
>  		goto out_free_pattern;
>  
> -	/* Find "low pause" and "high pause" in the pattern */
> -	lo_pause = pattern[0].delta_t;
> -	hi_pause = pattern[actual_len - 1].delta_t;
> +	/* Find "low pause" and "high pause" in the pattern if not an NVMEM device*/
missing a space before '*/'
"if not an NVMEM device" -> "in the LUT case"?

Konrad

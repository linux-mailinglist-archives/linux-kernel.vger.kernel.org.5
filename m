Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79F178DD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbjH3Svn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbjH3SUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:20:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C08132
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 11:20:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so228773e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693419623; x=1694024423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51+E8w+DB/gmDcb8ags2q30yQi+hWnstc7Hv59yZB9Q=;
        b=hRzBCXow1+JSLs6KLaq1mWX8T2wDOI9Ydl2K/GFjuQS07h82BajmbFJzHRL7vZsWYb
         UbCinV4Rj4Ens0PctLqzpcB3zwV36M/a27nvvBAeA+ZV8TwxyaRkHddsl5Ap8axU4Laq
         O8vN2Uv24UojgLBZq+bNI9YLaJcN62fFFvoHnJqn4ldX2fC8VlU2fyD5KfMwutCCZu7C
         oR9VA0Dvayay35kNLTmSARPoRCjYI6La2L69oCocxJmwM+sCtahZ20IjagTFL0TYRs+l
         09NBTxgKbd8M4uz8cpwIbtyK70uZEUqVX209DGXc/CM5z1rTL4WSi6f7cSf4qgD8G8HA
         j0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693419623; x=1694024423;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51+E8w+DB/gmDcb8ags2q30yQi+hWnstc7Hv59yZB9Q=;
        b=DmVzLZ5ObVnbSSTduwS1nVk9Cw/6eY5M+KQCsJIgGf52X1H1L2gqqZGqBUcCDtAbJC
         N3OGGOBJwYM02uLcY4kZDoBPVCZ3VYUjNIEXrhA6XwrKIevQeNAP3gsgpxWbYLP+XReh
         n24XK7+Bog4P4dxdxIbf/7rzTlkU9zvEjn95INB+YzFEzdRBaXsJOmZsdwLOqimPu83L
         Nz33a+yhgpst4AOvxw0EQiSlOpHMr52Z3jSeNX9vMPvubYUnDb8s6XsbSD48i3cGLCFI
         ATJNiOREFQYk9STlJtgVjm8u5vlNYkbYhrE8sN59bx3j5vQl0edhwfLIarNPTwft9KkJ
         8dQA==
X-Gm-Message-State: AOJu0YwxggaY4rceKt/AG3OJt/f/0dEi/gXQVppcmNscSyDjunm6cUql
        jZ8MlOoM8c0yIcNwKjtqCOJuNA==
X-Google-Smtp-Source: AGHT+IGEMnFxFzzxLchfMDAjKjH48/ZXeqdd4n7pK1yqBWJF3jWMKxbY0sm0hTHgYgkcusKJEuVa+w==
X-Received: by 2002:a05:6512:541:b0:500:bd75:77d1 with SMTP id h1-20020a056512054100b00500bd7577d1mr2092668lfl.63.1693419623630;
        Wed, 30 Aug 2023 11:20:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id w17-20020ac254b1000000b004fe48d0b639sm2464838lfk.83.2023.08.30.11.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 11:20:23 -0700 (PDT)
Message-ID: <4164dc42-ae7b-449e-82e1-8c5bfa64823d@linaro.org>
Date:   Wed, 30 Aug 2023 20:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] soc: qcom: add QCOM PBS driver
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
 <20230830180600.1865-6-quic_amelende@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230830180600.1865-6-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2023 20:05, Anjelique Melendez wrote:
> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
> driver supports configuring software PBS trigger events through PBS RAM
> on Qualcomm Technologies, Inc (QTI) PMICs.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
[...]

> +static int qcom_pbs_read(struct pbs_dev *pbs, u32 address, u8 *val)
I've seen your answer in v2, but I'm still not convinced about
two things:

1. why are you using bulk APIs with count=1 instead of just
   regmap_write/read?
2. do we expect the accesses to ever fail (realistically), if not
   we don't have to care about the retval and skip the conditional
   error message (1-2 cycles less per invocation)

You insisted on keeping the error messages, but firstly you'll soon
get an angry response from Krzysztof saying register accesses can't
fail (hence making checking the retval useless) and secondly I think
spmi core already spits out some errors on disallowed r/w

If you agree access failures are very edge cases, you can simply
convert all r/w ops to regmap_read/write/modify_bits and pass
pbs->base + reg

> +{
> +	int ret;
> +
> +	address += pbs->base;
> +	ret = regmap_bulk_read(pbs->regmap, address, val, 1);
> +	if (ret)
> +		dev_err(pbs->dev, "Failed to read address=%#x sid=%#x ret=%d\n",
> +			address, to_spmi_device(pbs->dev->parent)->usid, ret);
> +
> +	return ret;
> +}
[...]

> +static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
> +{
> +	int ret, retries = 2000, delay = 1000;
> +	u8 val;
> +
> +	while (retries--) {
> +		ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val == PBS_CLIENT_SCRATCH2_ERROR) {
> +			/* PBS error - clear SCRATCH2 register */
> +			ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
> +			if (ret < 0)
> +				return ret;
> +
> +			dev_err(pbs->dev, "NACK from PBS for bit %u\n", bit_pos);
> +			return -EINVAL;
> +		}
> +
> +		if (val & BIT(bit_pos)) {
> +			dev_dbg(pbs->dev, "PBS sequence for bit %u executed!\n", bit_pos);
> +			return 0;
> +		}
> +
> +		usleep_range(delay, delay + 100);
> +	}
Since the SCRATCH2_ERROR path exits the loop, this can simply be
made into:

regmap_read_poll_timeout

if (SCARTCH2_ERROR)
  do something
  return einval

return etimedout

[...]

> +int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
> +{
> +	u8 val;
> +	u16 bit_pos;
> +	int ret;
Reverse-Christmas-tree?

> +
> +	if (!bitmap) {
> +		dev_err(pbs->dev, "Invalid bitmap passed by client\n");
> +		return -EINVAL;
> +	}
> +
> +	if (IS_ERR_OR_NULL(pbs))
> +		return -EINVAL;
> +
> +	mutex_lock(&pbs->lock);
> +	ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (val == PBS_CLIENT_SCRATCH2_ERROR) {
> +		/* PBS error - clear SCRATCH2 register */
> +		ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
> +		if (ret < 0)
> +			goto out;
> +	}
Probably deserves an error message?

> +
> +	for (bit_pos = 0; bit_pos < 8; bit_pos++) {
> +		if (bitmap & BIT(bit_pos)) {
if (!(bitmap & BIT(bit_pos))
    continue

would save you a level of indentation

Konrad

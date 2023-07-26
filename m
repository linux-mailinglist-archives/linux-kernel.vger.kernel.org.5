Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DFB763B32
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjGZPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjGZPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:36:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F72DA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:36:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so1467014e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690385771; x=1690990571;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+W+dqmHY3oDSoUaAbXjHwkO+njuNaAcS/shrCuC458=;
        b=ewcXk2PXdG1aOg6qArX1EO342l5M19dX0BLwzHZCzO7wpvr5cGN/ecB5JnRyDp5S26
         gafBet5LduTLPF/IZ2ubc4YaMfhO8TJz8pn6Zj9l3vIDUKQKIaOLNA1KdKF7xiTQg2vQ
         4APNbu3QTrQIqDkxv6a6SfTVW9DUvpyiSiFRBJIHK4FIZgYQtWZXtPHfC1BUGbjZMdXu
         B9OOiv6h3S4SuXBp2/7uHKkYHbgqQ8ouTIW1rMdvbmz0XI0ys5po9brQBFXKO2o0NyM6
         EERvsi/eIm+Yr/3VQv5pzN0B9OCvdJvC32yPEP18zhTqjdR9G8s7vWB/L9gIRn0StNM3
         bxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385771; x=1690990571;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+W+dqmHY3oDSoUaAbXjHwkO+njuNaAcS/shrCuC458=;
        b=h9K0nhL5X3T/D4Y+xuljqEFw20UkBubWxd2OdikJeAFnKeGwHIf0szHty1DVSYrnTF
         OxbiS5YKHBr5fzZ5gEjCSaSkgy8Pp/Yc5KCQtN4q2mJJLoFHQLyggn6YwfZ+gPWAA4yB
         PY4wvo5/TD9d4MrEbWcyfgtUS20g/8bJmbXRIb8vLqHpoWXtlMW/8FM22+FxNFjFNoBX
         eFbSJKYIX93hB13nVFQmnS/nmEktYtBaKKXtDLmPgk9DlCbaz+NrwqpmvVVE7ic6o21y
         6/iz6Mr3EQcwx54F1sWa9m6qKmP4Zsmva0pVk7+8jbBcoA9S4DLvJ8xPG8EWcgDJKYFH
         VqsA==
X-Gm-Message-State: ABy/qLaXMJfFC2Mxz7bdaduS8Y8mpCuJPcis2tOMaz/0QcfoJBewBmET
        /++0ghaqa6zI0DdxBn1waEiEqQ==
X-Google-Smtp-Source: APBJJlH3ju/ljQnYzFrocTUuL5yUFlXhlzmd5VWmTIfmjUtDw2OQ1peSH70SIuEgmqApvpDo9O+R7w==
X-Received: by 2002:a05:6512:44d:b0:4f9:596d:c803 with SMTP id y13-20020a056512044d00b004f9596dc803mr1836717lfk.53.1690385771119;
        Wed, 26 Jul 2023 08:36:11 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004fbbef8d4dbsm3368900lfd.121.2023.07.26.08.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:36:10 -0700 (PDT)
Message-ID: <de3b4739-5446-c1ab-571f-a36c4aff5e0f@linaro.org>
Date:   Wed, 26 Jul 2023 17:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] soc: qcom: add QCOM PBS driver
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     luca.weiss@fairphone.com, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-4-quic_amelende@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230725193423.25047-4-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2023 21:34, Anjelique Melendez wrote:
> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
> driver supports configuring software PBS trigger events through PBS RAM
> on Qualcomm Technologies, Inc (QTI) PMICs.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
[...]

> +
> +	u32			base;
> +};
> +
> +static int qcom_pbs_read(struct pbs_dev *pbs, u32 address, u8 *val)
> +{
> +	int ret;
> +
> +	address += pbs->base;
Any reason not to just keep the base address in struct pbs_dev and use
normal regmap r/w helpers?

[...]

> +
> +static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
> +{
> +	u16 retries = 2000, delay = 1000;
> +	int ret;
> +	u8 val;
> +
> +	while (retries--) {
> +		ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val == 0xFF) {
This should be a constant, not a magic value

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
> +			break;
> +		}
> +
> +		usleep_range(delay, delay + 100);
So worst case scenario this will wait for over 2 seconds?

> +	}
> +
> +	if (!retries) {
> +		dev_err(pbs->dev, "Timeout for PBS ACK/NACK for bit %u\n", bit_pos);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
return 0 instead of break above?

> +}
> +
> +/**
> + * qcom_pbs_trigger_event() - Trigger the PBS RAM sequence
> + * @pbs: Pointer to PBS device
> + * @bitmap: bitmap
> + *
> + * This function is used to trigger the PBS RAM sequence to be
> + * executed by the client driver.
> + *
> + * The PBS trigger sequence involves
> + * 1. setting the PBS sequence bit in PBS_CLIENT_SCRATCH1
> + * 2. Initiating the SW PBS trigger
> + * 3. Checking the equivalent bit in PBS_CLIENT_SCRATCH2 for the
> + *    completion of the sequence.
> + * 4. If PBS_CLIENT_SCRATCH2 == 0xFF, the PBS sequence failed to execute
> + *
> + * Returns: 0 on success, < 0 on failure
> + */
> +int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
> +{
> +	u8 val, mask;
> +	u16 bit_pos;
> +	int ret;
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
> +	if (val == 0xFF) {
> +		/* PBS error - clear SCRATCH2 register */
> +		ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	for (bit_pos = 0; bit_pos < 8; bit_pos++) {
> +		if (bitmap & BIT(bit_pos)) {
> +			/*
> +			 * Clear the PBS sequence bit position in
> +			 * PBS_CLIENT_SCRATCH2 mask register.
> +			 */
Don't think the "in the X register" parts are useful.

> +			ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_SCRATCH2, BIT(bit_pos), 0);
> +			if (ret < 0)
> +				goto error;
> +
> +			/*
> +			 * Set the PBS sequence bit position in
> +			 * PBS_CLIENT_SCRATCH1 register.
> +			 */
> +			val = mask = BIT(bit_pos);
You're using mask/val for half the function calls..
Stick with one approach.

[...]

> +struct pbs_dev *get_pbs_client_device(struct device *dev)
> +{
> +	struct device_node *pbs_dev_node;
> +	struct platform_device *pdev;
> +	struct pbs_dev *pbs;
> +
> +	pbs_dev_node = of_parse_phandle(dev->of_node, "qcom,pbs", 0);
> +	if (!pbs_dev_node) {
> +		dev_err(dev, "Missing qcom,pbs property\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	pdev = of_find_device_by_node(pbs_dev_node);
> +	if (!pdev) {
> +		dev_err(dev, "Unable to find PBS dev_node\n");
> +		pbs = ERR_PTR(-EPROBE_DEFER);
> +		goto out;
> +	}
> +
> +	pbs = platform_get_drvdata(pdev);
> +	if (!pbs) {
This check seems unnecessary, the PBS driver would have had to fail
probing if set_drvdata never got called.

Konrad

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A987634A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGZLQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjGZLQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:16:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72C810D4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:16:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992b66e5affso1086593766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690370201; x=1690975001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hx+42rhLxUakB0N7R62IoqPsIZgz3eNSeyOpr/b73UE=;
        b=BDNMnOlka3aRoFnrwvEtaE4M2POUnu2N9gyVc/F0W5F6zvnbe/ZI0uIM2dMDDOb2eg
         5Yv1OwlASIsxGAfAXwL1V9MxipBxeDq6mQCZsGuZWduaDH6TW5aJvFI0IGp8LnQh8Cqu
         iKB/0h2zjPVHaG+c9mPgwm11w3LUFqDtIqhyy0vsBJNkRNSlq1SiXPlvPMU7I1ZDnriM
         4nXkws8AOHVRd2q8fbzowQVBe3mFuqruuAL4x7a5Y6A6LQEZL8+sMAVxe7YS2qDMb2Ff
         SOFISqYyK7NgfAp4vvraLIMn4GtOlFfBUndLts6ZfXG6MmKkzBfvJVXvfLeq3gO7HquV
         e0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370201; x=1690975001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx+42rhLxUakB0N7R62IoqPsIZgz3eNSeyOpr/b73UE=;
        b=CpoY3TJIu1J7VrrcP+c4S7UDjRevGW/ErI2cUkGpJLb4BVdAhKOdLeIjX3HMUVECxF
         m1bfT+jK/dBXW/+PwagbQ6COONyUHJVt6Bmr4O8dmjQF/LepDqDpW1vUQ98TIY6czr6w
         TprnF12/9PzWh6Ud4JFxKuyH2IPVJd2ZDRz8wZYvguxeEtGEXY3jGjX6ZzmOZkrGjnQX
         L7unVkNRZ8r7nBjp4jezurda2LQkwyTHVAMSReN+YQoZhMPoY8tuzriaarNXEEiQSJcr
         R59YGtzIrpDcA4oyqN6rX0JnkHpDYL9uPlDWejJk4znos28wItnMwIlIa32R9Fu7VTpE
         /AWQ==
X-Gm-Message-State: ABy/qLb6tIOOsU3EvWhC+qu/failMf8Cirh1RT4v2Z3lBIKkhU0VGkoI
        Fzg9mXBL/KsbMOxGREYjPjX5Nw==
X-Google-Smtp-Source: APBJJlHyiMXrxVUKIVyU54SdDmvWLUg7maOrfK7QI0HKExQ+dUwhKnDCKxSN8h88OPha5NPGftf/TA==
X-Received: by 2002:a17:906:cc59:b0:993:d7c4:1a78 with SMTP id mm25-20020a170906cc5900b00993d7c41a78mr1528295ejb.10.1690370200956;
        Wed, 26 Jul 2023 04:16:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id jp7-20020a170906f74700b009937dbabbd5sm9430093ejb.220.2023.07.26.04.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:16:36 -0700 (PDT)
Message-ID: <284e464a-85dc-f07b-27f8-fda516ca7b24@linaro.org>
Date:   Wed, 26 Jul 2023 13:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 1/2] regulator: aw37503: add regulator driver for
 AWINIC AW37503
Content-Language: en-US
To:     like@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
References: <20230726081612.586295-1-like@awinic.com>
 <20230726081612.586295-2-like@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726081612.586295-2-like@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 10:16, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
> 
> Add regulator driver for the device AWINIC AW37503 which is single
> inductor - dual output power supply device. AW37503 device is
> designed to support general positive/negative driven applications
> like TFT display panels.
> 

Thank you for your patch. There is something to discuss/improve.


> +
> +static int aw37503_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct aw37503_regulator *chip;
> +	struct regulator_dev *rdev;
> +	struct regmap *regmap;
> +	struct regulator_config config = { };
> +	int id;
> +	int ret;
> +
> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &aw37503_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "regmap init failed: %d\n", ret);
> +		return ret;

return dev_err_probe

> +	}
> +
> +	i2c_set_clientdata(client, chip);
> +	chip->dev = dev;
> +
> +	for (id = 0; id < AW37503_MAX_REGULATORS; ++id) {
> +		config.regmap = regmap;
> +		config.dev = dev;
> +		config.driver_data = chip;
> +
> +		rdev = devm_regulator_register(dev, &aw_regs_desc[id],
> +					       &config);
> +		if (IS_ERR(rdev)) {
> +			ret = PTR_ERR(rdev);
> +			dev_err(dev, "regulator %s register failed: %d\n",
> +				aw_regs_desc[id].name, ret);
> +			return ret;

return dev_err_probe will be easier

> +		}
> +	}
> +	return 0;
> +}
> +
> +static const struct i2c_device_id aw37503_id[] = {
> +	{.name = "aw37503",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, aw37503_id);
> +
> +static const struct of_device_id aw37503_dt_ids[] = {
> +	{.compatible = "awinic,aw37503",},
> +	{ /* Sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, aw37503_dt_ids);
> +
> +static struct i2c_driver aw37503_i2c_driver = {
> +	.driver = {
> +		.name = "aw37503",
> +		.of_match_table = of_match_ptr(aw37503_dt_ids),

Drop of_match_ptr()


Best regards,
Krzysztof


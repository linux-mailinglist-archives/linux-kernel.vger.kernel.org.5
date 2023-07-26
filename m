Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DF764059
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGZUOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGZUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:14:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CC2701
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:13:59 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id OktPq7h8HqvVSOktPq8Ug8; Wed, 26 Jul 2023 22:13:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690402437;
        bh=Qa7TVI44V2nKCppaEfyl+/fHa4yu5cFhIS8b3fken4U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CA/VvfjXbWph3QjMlDHQ2nfL0UZMtcMMOFR1D5kAh2XoZHqHl3z4Yrr4u5TmZUOJL
         grJlnITnUxL+MsbPUOZFnz9BqF2ZVq8M33cgrhXSTgnikx3yNtb1vY0XM0F5Ix5nhy
         kMK4lwLwv5hoSsGSq/0MHcD8xkuFb06vmEY9ozHVXzJKYPN5FrS55Ep994r0ZeWf/U
         CXfZyT4u4UbmwG1fuee9A7mLYMbG1mH7ZJcDtBNGod0l6q1Nkz4r0fdnrQ95NTGQcc
         fgcrFfI5T+/qUUaSGeERTRmv8VYSXM1LL2trF3d6uW1A+ut4KMdJMHmh95nAjNzLBK
         xcTLbmTtyhTjQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Jul 2023 22:13:57 +0200
X-ME-IP: 86.243.2.178
Message-ID: <f4d588e1-18e1-e7e1-e862-e87f9c7d7b9e@wanadoo.fr>
Date:   Wed, 26 Jul 2023 22:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 1/2] regulator: aw37503: add regulator driver for
 AWINIC AW37503
Content-Language: fr
To:     like@awinic.com
Cc:     broonie@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, liangdong@awinic.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        robh+dt@kernel.org, wangweidong.a@awinic.com
References: <20230726081612.586295-1-like@awinic.com>
 <20230726081612.586295-2-like@awinic.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230726081612.586295-2-like@awinic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/07/2023 à 10:16, like-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org a 
écrit :
> From: Alec Li <like-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> 
> Add regulator driver for the device AWINIC AW37503 which is single
> inductor - dual output power supply device. AW37503 device is
> designed to support general positive/negative driven applications
> like TFT display panels.
> 
> AW37503 regulator driver supports to enable/disable and set voltage
> on its output.
> 
> Signed-off-by: Alec Li <like-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>

[...]

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
> +	}
> +
> +	i2c_set_clientdata(client, chip);
> +	chip->dev = dev;
> +
> +	for (id = 0; id < AW37503_MAX_REGULATORS; ++id) {
> +		config.regmap = regmap;
> +		config.dev = dev;
> +		config.driver_data = chip;

I think that these 3 lines could be outside of the loop.

> +
> +		rdev = devm_regulator_register(dev, &aw_regs_desc[id],
> +					       &config);
> +		if (IS_ERR(rdev)) {
> +			ret = PTR_ERR(rdev);
> +			dev_err(dev, "regulator %s register failed: %d\n",
> +				aw_regs_desc[id].name, ret);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}

[...]

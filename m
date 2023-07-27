Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8B764F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjG0JOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjG0JN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D8E4D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:05:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so147860766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690448724; x=1691053524;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iW9hirNYEKfMierQvwKdXZyPpXflE8xyIi19VM2cNcU=;
        b=ghNusUR6ikY1x1z/QQONgYLWZ+y8ANzxGEJ6HRa0r/NNZYeASUM3kctb5lAwqIOE3N
         4pXovCF/zxdicDCM/HilfIb8xJ0kFCAZ5uDwYW7/c7bQlVXkATwjyDBTWs6fMX2HVWMp
         Ww1ewKSgYLRjSa/M/vAtLUQqPqKCmnE4dS8e6CVh/U1dQ535K9nuSqYlhr8MMpcCDOby
         2fyo4Ezj0Htc+To4r2mHQwtYa02raAHcZwe0uhPlDMnHdkHdmws7tnwB0JJ5LH8K3rwF
         TscHl61hJqgqQBE4UNGb31+PvQAQbOx6L1Mqh8TNQTnLo6zPoF09dt64Vf9T2HXMXA0l
         RPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448724; x=1691053524;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW9hirNYEKfMierQvwKdXZyPpXflE8xyIi19VM2cNcU=;
        b=H51xZqoDOY1DL91aQbkxSVWrmYBeENHF9up1n8S2O0bxAqPqxlJVdBZOFbjL0cSp89
         7ATtNTORWS23b8T+kgmjZeYhM/W9R+I/kNLa2gJtLWRWsLoFlmaHTKLgelAsJtRJ0HgD
         XGO46+m3QayfO4Kjt+Fdn+V+/GSBtmH3jx/LxzahMqnaMrcfg1OBAoUKFgxaaaUbsV53
         RdQMTVFU1DG71CwGnB93OGFMSq4VAfHx7o2/ZhM6IHsOQZ9rZWIbvqkNAEfYQZaGGtrO
         XdpAgLtkZYqledU45SpHRAQ7+ZDBapdYloM5lPjtLQbil4yT62rWx5+D+9tqEUs5KYGv
         HnZA==
X-Gm-Message-State: ABy/qLZvPcv5OFQA/Bo2jnSFfpYONoSNkCkmNfGsF1yE4U857gsOZtOl
        R7FUp8PA2EmY6G7aMbTtJNKvMw==
X-Google-Smtp-Source: APBJJlFm0H1uvKPGXj0tSW1ySSNHFRVk6VJWb04XfCsr+sy+uIHG/RCkF4PlpAQZ2IZVT74P5b1EZw==
X-Received: by 2002:a17:907:7f89:b0:993:e85c:4ad6 with SMTP id qk9-20020a1709077f8900b00993e85c4ad6mr1915697ejc.7.1690448724607;
        Thu, 27 Jul 2023 02:05:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u19-20020a056402111300b0050bc4600d38sm401266edv.79.2023.07.27.02.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:05:23 -0700 (PDT)
Message-ID: <28557055-0d63-d449-c675-d365c5b85f93@linaro.org>
Date:   Thu, 27 Jul 2023 11:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] gpio: ds4520: Add ADI DS4520 GPIO Expander Support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727085239.4326-1-okan.sahin@analog.com>
 <20230727085239.4326-3-okan.sahin@analog.com>
 <d3c77a86-f152-cad3-6087-6167656c4c9e@linaro.org>
In-Reply-To: <d3c77a86-f152-cad3-6087-6167656c4c9e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 11:03, Krzysztof Kozlowski wrote:
> On 27/07/2023 10:52, Okan Sahin wrote:
>> The DS4520 is a 9-bit nonvolatile (NV) I/O expander.
>> It offers users a digitally programmable alternative
>> to hardware jumpers and mechanical switches that are
>> being used to control digital logic node.
>>
>> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> 
> ...
> 
>> +static int ds4520_gpio_probe(struct i2c_client *client)
>> +{
>> +	struct gpio_regmap_config config = { };
>> +	struct device *dev = &client->dev;
>> +	struct regmap *regmap;
>> +	u32 ngpio;
>> +	u32 base;
>> +	int ret;
>> +
>> +	ret = device_property_read_u32(dev, "reg", &base);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret,
>> +			  "Missing 'reg' property.\n");
>> +		return -EINVAL;
> 
> Nope.
> 
>> +	}
>> +
>> +	ret = device_property_read_u32(dev, "ngpios", &ngpio);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret,
>> +			  "Missing 'ngpios' property.\n");
>> +		return -EINVAL;
> 
> Nope.
> 
>> +	}
>> +
>> +	regmap = devm_regmap_init_i2c(client, &ds4520_regmap_config);
>> +	if (IS_ERR(regmap)) {
>> +		ret = PTR_ERR(regmap);
>> +		dev_err_probe(dev, ret,
>> +			      "Failed to allocate register map\n");
>> +		return ret;
> 
> That's not correct syntax. What did you receive in previous
> comments/feedback?

Hm, I might be mixing patches, so maybe you never received feedback on
this. Anyway, all these three lines must be one line:

return dev_err_probe()

Previous places should be fixed similar way.

Best regards,
Krzysztof


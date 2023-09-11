Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59AD79A2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjIKFQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIKFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:15:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7251AE;
        Sun, 10 Sep 2023 22:15:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5008d16cc36so6751050e87.2;
        Sun, 10 Sep 2023 22:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694409353; x=1695014153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xXSO1mNrtCurS91ej22fH2JzQkdqZJz5EMO/iglVMo=;
        b=YNDqSvIRbWy8Y1doVaeo59emu0Dt8Xsq1ATolu1rL0oBs43ntFXFdZmua9a9V0rOLc
         /rw1RAqNkd4xQozKXms+MByNTq21XxIFurAuGcZmAbzEXytMnN55mNfnnHGYP+JAu68P
         Qkd7vVKJtSwnrol5mLjIKbbrBZw0ADuUQc7TCmHPiweDzat+xRTeULHl2aJCfJ076Uvx
         jK7bt2BJwYhUJvdqhyYI1guMV5n4rn2J/I/M/zC88U9ILdicO2A3J6aEOM8ZGAVFqHV4
         BV8d4dhxxr8gLn4VIQv3mOWTQeWi+U7wyKPNPXsIECK6+6cWct3vXZao/VWlUAXkSYfN
         E9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694409353; x=1695014153;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xXSO1mNrtCurS91ej22fH2JzQkdqZJz5EMO/iglVMo=;
        b=T8clg0yEBJghgSOTklc2xvyRR5ohrKIqIHyrX2yl/GpvJ+KhVvLKzw5M4M74RW0+PF
         gQTayKmPwFMd7dY6CpdgxOkOPR11DzhT8+eSZRdyLLfoCIxHTy5awOLztrFBzPzjmhFq
         e/U6LII1BRZTxCz8dewpalFcHJgY2ML4FskGH1osTBRoDrVL/BHJjKUBlY/C5j4TsvrB
         fLoWgGyHOGEhXOVQM+CBcyBStSYFaLFjn5ab7NWe4ifFRyY0RWcs7Hh2b//i7w1u6LE2
         KyfQ4BuW9OYK4jm6Qf+jerfjFLQV1Nvv/6ZhxA5usulx0CuDV6b6Yw2Dip2cp4lNmJ9Z
         dkZw==
X-Gm-Message-State: AOJu0YzxxpK7BjyGlPX6fSblK8uxof4UxC2W+rYoKarlloiVicKR8UX6
        j19BrOWC16FYmPesm5ChQJD5/58WST4=
X-Google-Smtp-Source: AGHT+IGO8I1Qvg+29UQ+u4ehq9VfswEVbtP4werFdBe+QXk0tytJT3fmcv1xbHyWzKQmBO7dHKdfpg==
X-Received: by 2002:a05:6512:5d0:b0:4ff:9a75:211e with SMTP id o16-20020a05651205d000b004ff9a75211emr6102872lfo.42.1694409352821;
        Sun, 10 Sep 2023 22:15:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512040900b004fb9536bc99sm1202886lfk.169.2023.09.10.22.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 22:15:52 -0700 (PDT)
Message-ID: <6077edb2-8076-10e8-d34f-70426188a0f0@gmail.com>
Date:   Mon, 11 Sep 2023 08:15:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
 <20230908194509.6a4f4adc@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230908194509.6a4f4adc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 21:45, Jonathan Cameron wrote:
> 
>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
>> +{
>> +	u8 temp_reg[2] __aligned(2);
>> +	__be16 *temp_raw;
>> +	int ret;
>> +	s16 val;
>> +	bool negative;
>> +
>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
>> +			       sizeof(temp_reg));
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (temp_reg[0] & 0x80)
>> +		negative = true;
>> +	else
>> +		negative = false;
>> +
>> +	temp_raw = (__be16 *)&temp_reg[0];
>> +	val = be16_to_cpu(*temp_raw);
>> +
>> +	if (negative) {
>> +		/*
>> +		 * Two's complement. I am not sure if all supported
>> +		 * architectures actually use 2's complement represantation of
> 
> AFAIK they do. Many IIO drivers would be broken if not..

Great. Then I think it means we really can treat the combined value of 
the registers as s16 BE. Should make this much simpler :)

> 
>> +		 * signed ints. If yes, then we could just do the endianes
>> +		 * conversion and say this is the s16 value. However, as I
>> +		 * don't know, and as the conversion is pretty simple. let's
>> +		 * just convert the signed 2's complement to absolute value and
>> +		 * multiply by -1.
>> +		 */
>> +		val = ~val + 1;
>> +		val *= -1;
>> +	}
>> +
>> +	*temp = val;
>> +
>> +	return 0;
>> +}

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


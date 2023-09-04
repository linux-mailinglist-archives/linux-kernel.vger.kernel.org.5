Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6F17917B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351276AbjIDNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjIDNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:02:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3012890
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:02:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so2000847a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693832553; x=1694437353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sP6V8ajHXT6yKSyr1cE3yHGsY7qGhYago0ofT+AYzCU=;
        b=oIPBCOkpynMe4LI3jrgaBTVWEUniZCs3hag/J8B24KzWxfknrl9FCot0wHBkR3C75c
         wXkZBNIW5t44y/61RIZHi0BQFo0GFdLbIKfzOZVSkgR+hnw3ooWceobVq/LQJadHM1q0
         1aMo5tpRJO9M5hXgd6J8UTAjdB+VuCboWFGsRLr91t5ovVWwWkChvNGVQpu2qbiAqSBV
         B3kuoPg08+WCydeUo8zE6tyeOC7xqWnhrgVsH0MC4LO1sLPQpCchyYxV20APAni5qhDx
         fj+X1V46P47WtnBbpnwz/UhvXwJCfs+eSr5FzWYmjN8ZxFGDfeHmBQ7J2pP833nSPAAC
         2PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832553; x=1694437353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP6V8ajHXT6yKSyr1cE3yHGsY7qGhYago0ofT+AYzCU=;
        b=bLPY2mM1w1IisSEiA4iJWDMcOcI4t7eSOVrr65fGIn4o/KvtoB1M33Gj0/5HPQdU+0
         fSssT/Jg3lg5NhvqRj9sChUnq7f3DCJZ5oeQg8oDeSH8LG1nAYvJyquTj14+Xzttl+ni
         9JxcMkJ6RkZSAa2iFNM00c/bP7CFP0wC7dl/GJ+mDuspzUx6cHajK1LsWHHnW7ndALCy
         SGzdXrsXunOrOhdG8pN1yADm0rlbwy7add1fuDJwQGJkW67kOC0E7oBfOMT4GWKjYnUS
         A/QhaJvF0OUbOYEuYLn+mjOPFHmyEJwfxCD7aToeERSyfiM2xePAyGhSRg5OdSEbsgFQ
         7Z3Q==
X-Gm-Message-State: AOJu0Yx+t1B/8IcwadjffwEJ/l4LBFCRkhFBUXOd409m+uVzIYHELQcp
        91SfuvKTka+5dquIjrK/cetDjg==
X-Google-Smtp-Source: AGHT+IEJBeHsLqYueJWcEkffCP4VVC/CZWWv9130Yc9xYYY+tD0WJm6tOAoS2L8e8K1eUs77UXHirg==
X-Received: by 2002:a05:6402:b30:b0:523:4057:fa6e with SMTP id bo16-20020a0564020b3000b005234057fa6emr5866008edb.42.1693832553657;
        Mon, 04 Sep 2023 06:02:33 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id x26-20020aa7d39a000000b005257f2c057fsm5839006edq.33.2023.09.04.06.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 06:02:32 -0700 (PDT)
Message-ID: <0360d279-b535-f3f2-9651-07dff2df2e37@linaro.org>
Date:   Mon, 4 Sep 2023 15:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw87390 amplifier driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     wangweidong.a@awinic.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rdunlap@infradead.org, 13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        yijiangtao@awinic.com, liweilei@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjianming@awinic.com
References: <20230904114621.4457-1-wangweidong.a@awinic.com>
 <20230904114621.4457-4-wangweidong.a@awinic.com>
 <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
 <598febde-429e-4319-98d4-4306a7f8bfe8@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <598febde-429e-4319-98d4-4306a7f8bfe8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 14:30, Mark Brown wrote:
> On Mon, Sep 04, 2023 at 02:17:43PM +0200, Krzysztof Kozlowski wrote:
>> On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:
> 
>>> +	ret = regmap_read(regmap, AW87390_ID_REG, &chip_id);
>>> +	if (ret) {
>>> +		dev_err(&i2c->dev, "%s read chipid error. ret = %d\n", __func__, ret);
>>> +		return ret;
>>> +	}
> 
>>> +	if (chip_id != AW87390_CHIP_ID) {
>>> +		dev_err(&i2c->dev, "unsupported device\n");
> 
>> Why? The compatible tells it cannot be anything else.
> 
> This is very common good practice, as well as validating communication

No, it is neither common nor good. The kernel's job is not to verify the
supplied DTS. Rob also made here a point:

https://lore.kernel.org/all/CAL_Jsq+wcrOjh7+0c=mrg+Qz6dbhOUE-VEeQ4FoWC3Y7ENoyfQ@mail.gmail.com/

> with the device it verifies that the device descrbied in the DT is the
> one that is actually present in the system.  This might create hassle
> down the line if there is a backwards compatible upgrade but that's much
> rarer for this class of hardware than cut'n'pasting of device trees.

Best regards,
Krzysztof


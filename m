Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6886179127D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbjIDHqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245561AbjIDHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:46:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA67128
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:45:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso1418102a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693813557; x=1694418357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oTX6pDWFbsRBZELPps+RqPck8JFOCibC5eerUlD3+Y=;
        b=KHLl7/25PIapidsHyQKEFBKOTxf6bdnVFR8vrJDais5jypdLg+e/+UYYLkQQv2Zifk
         P7zPpsy3PrJdr7kM6UFpIvH/CjuOySZp3oEchwM6280f7lPAei2cPgGfiJ+D8aw2DZXt
         2tm/xveo1hHW5UUj7HyrkGCwn1P2eOQg8X13dMReHQeEWErDZTJkl2tBla71rOGeSTvh
         w/6EQb1bJ9ScBD+vKpqzsyK5ecIJHuD7QwJDtnBkXlNduTbx5PvT/q8OOQIn48ggayKn
         YcYodCOVBQXepTVkAkm/7oQRujHUADw8L4NKNztI/GGJSvvXgDAdzHXO8ccLvUgCzbdR
         RS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813557; x=1694418357;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oTX6pDWFbsRBZELPps+RqPck8JFOCibC5eerUlD3+Y=;
        b=Bf/QZQfcwFzCsRYwWq9VC3xbpg1h9ZqDAm6B0l/HgIRL6nHjUTwUyrORtpyKV/fe3q
         a46ZgzL8vz87XlDFBQIYqb1+k3MumwSvex7dFA2KXn0tXd3KUz3BGEkzmLrlCIQEmDLx
         dDA6A6G+1axXu6vRUURm2rK1+fSucrAjsq/tiu4rd1paX8D1GQZM45qrNaQA+sMKSHC+
         sHlDEgwkH0Zt+wH71Va5k/twNn8zxFnbhgwaZxTG1j4gLAnRuX2INsGH4ChL4iC+8kdT
         bDhJnKYy0sKbKFkY5g4stuqMW/dpeqGQm8VWXHnWuxNbPyQqe2uc5LR6C3Ap+vHnJJl8
         +4JQ==
X-Gm-Message-State: AOJu0YyTkxDi14vQHlVrY/vRVl3/wQgXDw6yacJ9bJTHNH4F/jI9lsQk
        AXCP1yrLz52BykyAi2JWs+T8iel/KQ7k574HlSI=
X-Google-Smtp-Source: AGHT+IEINRbAsvSeWTCzWDCv0GspT0nyL54gbJfmOb7e8zMLCOSHCmSVJ54yK1U9rDxCZlhVy58Klw==
X-Received: by 2002:aa7:df81:0:b0:525:6d6e:ed53 with SMTP id b1-20020aa7df81000000b005256d6eed53mr5951385edy.27.1693813557008;
        Mon, 04 Sep 2023 00:45:57 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id b18-20020a05640202d200b0051dfa2e30b2sm5498533edx.9.2023.09.04.00.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:45:56 -0700 (PDT)
Message-ID: <1f0bf00f-07db-4017-a30b-618d90ce0457@linaro.org>
Date:   Mon, 4 Sep 2023 09:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in main
 pin config register
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230901090224.27770-1-krzysztof.kozlowski@linaro.org>
 <20230901090224.27770-3-krzysztof.kozlowski@linaro.org>
 <08a10dc1-bb8e-48b1-8d86-5ee513835196@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <08a10dc1-bb8e-48b1-8d86-5ee513835196@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 14:28, Konrad Dybcio wrote:
> On 1.09.2023 11:02, Krzysztof Kozlowski wrote:
>> Existing Qualcomm SoCs have the LPASS pin controller slew rate control
>> in separate register, however this will change with upcoming Qualcomm
>> SoCs.  The slew rate will be part of the main register for pin
>> configuration, thus second device IO address space is not needed.
>>
>> Prepare for supporting new SoCs by adding flag customizing the driver
>> behavior for slew rate.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 20 ++++++++++++++------
>>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.h |  7 +++++++
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> index e2df2193a802..40eb58a3a8cd 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> @@ -190,6 +190,7 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
>>  				    const struct lpi_pingroup *g,
>>  				    unsigned int group, unsigned int slew)
>>  {
>> +	void __iomem *reg;
> Aaalmost reverse-Christmas-tree!

I can fix it.

> 
>>  	unsigned long sval;
>>  	int slew_offset;
>>  
>> @@ -203,12 +204,17 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
>>  	if (slew_offset == LPI_NO_SLEW)
>>  		return 0;
>>  
>> +	if (pctrl->data->flags & LPI_FLAG_SLEW_RATE_SAME_REG)
>> +		reg = pctrl->tlmm_base + LPI_TLMM_REG_OFFSET * group + LPI_GPIO_CFG_REG;
>> +	else
>> +		reg = pctrl->slew_base + LPI_SLEW_RATE_CTL_REG;
> Perhaps lpi_gpio_read/write could be used here?
> 
> I guess both ways work though

I was thinking about this, but decided not to in favor of duplicating
"tlmm_base + offset * group ....". It would not make the code easier to
read.


Best regards,
Krzysztof


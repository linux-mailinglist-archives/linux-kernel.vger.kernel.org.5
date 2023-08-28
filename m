Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466C378AE49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjH1K7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjH1K7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:59:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D4CEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:58:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso46278171fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693220326; x=1693825126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/OB7PKo07RgUFZpiehXJXNKqPXLjU99gDHLTVOVii8=;
        b=cJXfrHMJNPS/QKMrTTlE5vfpH974HXftpuSY9uJs9MfVS7vc2mXinUh9ADC2STqq3k
         5WNnPwsOq3rjlCr/JlQZURcjtrH2q2IdRvWytQYT1l+kcjhVAqDM5ELFcurx9w5rEXed
         yaO4gDOcAp5aORCgm32uLrh+lUesOUFQRzDaKjVsy1NqQ269QA0T0ACauz8czEnt/9p+
         I8/VwRP8mVEyupf+HtVu2tm/p+Wfcj9+cRYArd2exPuJqTY77Wc+2o1lElpn93LqLXBd
         6er4vDPQ7rF0zfitvBwtpmn9UkrQVTY79hvkSXx1oOk7iVaG6Ft2xtj95vpS/nTnAHW3
         6tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693220326; x=1693825126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/OB7PKo07RgUFZpiehXJXNKqPXLjU99gDHLTVOVii8=;
        b=RABgIDPp8Ra/wQMcpVbiWN8f+QUw6IZfFdktIf/9mITbmynJw7xvQrc4g8y2hmGUcI
         whPTNcXdPZe6xQAEd/Kx9ud9dsRHOuMW/vTHFTrLri7Job++cWc7/UORAeDnFaTajcE4
         tg6hD+8ifq4bbzn7LK02AmU6DJp+/XhJ1PaIjkLgD4fneeV/81YYMQkY3UCLQ7U6xqZ1
         dLOuAjLmO3iAlwk3Q1KQpJDEjAf3QByrvCaUxSfmMU4PfHpj8Fwzp8ESVqGRhxSyzASW
         Gdn+qrEe138IuomQ0xadakroOk0GeZb8cmtei5cw4ifNjn1fD04spuwpZ/6x8wNP3pNv
         735g==
X-Gm-Message-State: AOJu0YyHWii9eh2eeOu83zQsVcTgcVjO9uRLMFN7zNnicWX/7gURmVth
        B+She6TQ5v6DY/fZe+j0Yr4NdA==
X-Google-Smtp-Source: AGHT+IG/gueuI9Cxw+c3jnrN0MdQrB+kDMkFMyE8XslmGTM4ZZFnIcaUdSesgvMKixU6F+4T33HR+A==
X-Received: by 2002:a2e:81d3:0:b0:2bc:db5a:9545 with SMTP id s19-20020a2e81d3000000b002bcdb5a9545mr11327243ljg.14.1693220326336;
        Mon, 28 Aug 2023 03:58:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id w16-20020a2e9990000000b002b6d7682050sm1698240lji.89.2023.08.28.03.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:58:46 -0700 (PDT)
Message-ID: <cb5194fc-cb66-44a5-8127-a7155f0dade6@linaro.org>
Date:   Mon, 28 Aug 2023 12:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: misc: eud: Fix missing IRQ check in eud_probe()
Content-Language: en-US
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_C40B301A0F71853A540809BE1BB85AB12D07@qq.com>
 <f9df2e02-9fae-4e16-9412-d378ef168903@linaro.org>
 <tencent_D0AA2D25300E0F108559545E899C9B8EDA07@qq.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <tencent_D0AA2D25300E0F108559545E899C9B8EDA07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.2023 16:17, Zhang Shurong wrote:
> 在 2023年8月26日星期六 CST 下午6:49:27，Konrad Dybcio 写道：
>> On 26.08.2023 12:47, Zhang Shurong wrote:
>>> This func misses checking for platform_get_irq()'s call and may passes the
>>> negative error codes to request_irq(), which takes unsigned IRQ #,
>>> causing it to fail with -EINVAL, overriding an original error code.
>>>
>>> Fix this by stop calling request_irq() with invalid IRQ #s.
>>>
>>> Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB
>>> Debugger(EUD)") Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
>>> ---
>>>
>>>  drivers/usb/misc/qcom_eud.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
>>> index 7f371ea1248c..b33c615a2037 100644
>>> --- a/drivers/usb/misc/qcom_eud.c
>>> +++ b/drivers/usb/misc/qcom_eud.c
>>> @@ -204,7 +204,12 @@ static int eud_probe(struct platform_device *pdev)
>>>
>>>  	if (IS_ERR(chip->mode_mgr))
>>>  	
>>>  		return PTR_ERR(chip->mode_mgr);
>>>
>>> -	chip->irq = platform_get_irq(pdev, 0);
>>> +	ret = platform_get_irq(pdev, 0);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	chip->irq = ret;chip->irq = plat..
>>
>> if (chip->irq < 0)
>> 	return chip->irq
>>
>> ?
>>
>> Konrad
> Thank you for your thoughtful response. To clarify, are you suggesting that I 
> replace the usage of `ret` with `chip->irq`? If that is the case, I will 
> proceed with creating a patch for version 2.
Yes please

Konrad

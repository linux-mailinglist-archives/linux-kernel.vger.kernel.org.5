Return-Path: <linux-kernel+bounces-18620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27482601F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75F11C21AA3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EE8495;
	Sat,  6 Jan 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdDSQofk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552B8479
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556fc91aba9so591682a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704554750; x=1705159550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OcjHfgODRNt+KFLJZW+qt8wg+xFuzUGbD/7t6KtlsPc=;
        b=DdDSQofknDd7UUpCZ5h7u7Gyfdc416oilOljBG1Z5TYPCdDdcAMcvMH0WkK/dDUwLs
         74Coa15Dg0+2ITbL5NS8wvjeKDm1YCt1YNNURI2Qb4qmlfm1+McEDxf6aDi5TaRcfXxl
         Yt/1GfR2JsPKiX4pIbig+41swWO80EuG+d/epcOMutUhG2Ig4HYSi4j9oeKsJM0vn+qi
         glgoVmc68Xa3qKvFIkiR0FPBuubWvaP8tgpv8K+0TuG5FtJmoHKcDOawYZMkOaCTsBER
         PNyRIkeiT7z83P46um0ktGBKOu7/umW7aaThTfIEBEBb/M/5pQ4p1KUxCOhh1jXLfhyf
         /Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704554750; x=1705159550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcjHfgODRNt+KFLJZW+qt8wg+xFuzUGbD/7t6KtlsPc=;
        b=hnnuwVbHxgw/6P4QSw47Q17A3F7+UqXl23Zt+/O8EEmoC2uUYN7Q5gODCENmBzeBCI
         1RGukWXWYVTKOOIc1+DWn3KP3Sa5Bvcrijozu5yzcEb7lry8Sa+v/5IXZqvcCBlS24nG
         s1BYpSiZNPFl1IoFpbczSYAbeD6ItRltvCCmB1rZprGI88ze3gQ+01cs0b+ONZcJBKNf
         BLBhqsffAAJFLN/uerb3JsRSb9MwsujwbeGAwW/MGyHHjqKGG8DtOMWJA60d497J/WTg
         s9AtMhP6m1xNK3SUMVtGkG9HDm3SsESG//YRgox9VSZttpVLRP8cfBVcI+6ODF/Plajg
         XirQ==
X-Gm-Message-State: AOJu0YyafZ6Dw2Mx5INq6aBjc2szbELaeBunVArhb9KNCm5Xx0Qr1wsO
	Fv6yha8gtNWoxldkQ4ZIoXFGTtmJ6RbDVw==
X-Google-Smtp-Source: AGHT+IFB0zGz9gSAgm1ISn8yYjF8oEreli2U1lqQx7WM65GroIfSdMClbQh9kAKJ7fNVREJ/zVWMwQ==
X-Received: by 2002:a17:906:80ca:b0:a28:ad2c:f0e4 with SMTP id a10-20020a17090680ca00b00a28ad2cf0e4mr476053ejx.42.1704554749609;
        Sat, 06 Jan 2024 07:25:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id jo21-20020a170906f6d500b00a275637e699sm2050304ejb.166.2024.01.06.07.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 07:25:49 -0800 (PST)
Message-ID: <bbe3bc57-1d5e-42d4-b860-15a27c7c57bd@linaro.org>
Date: Sat, 6 Jan 2024 16:25:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: hfpll: Add QCS404-specific compatible
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
 <20231231-hfpll-yaml-v1-2-359d44a4e194@z3ntu.xyz>
 <588dd6c3-7d2b-48db-b5ea-48a07077dc5d@linaro.org>
 <6706261.DvuYhMxLoT@z3ntu.xyz>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6706261.DvuYhMxLoT@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/01/2024 11:19, Luca Weiss wrote:
> On Dienstag, 2. Jänner 2024 11:41:26 CET Krzysztof Kozlowski wrote:
>> On 31/12/2023 15:48, Luca Weiss wrote:
>>> It doesn't appear that the configuration is for the HFPLL is generic, so
>>
>> That's ok...
>>
>>> add a qcs404-specific compatible and rename the existing struct to
>>
>> but why this is the solution? If the qcom,hfpll compatible was
>> deprecated, but it is not. This commit is contradictory to the bindings.
>>
>>> qcs404.
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>
>>>  drivers/clk/qcom/hfpll.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
>>> index dac27e31ef60..5b12982519be 100644
>>> --- a/drivers/clk/qcom/hfpll.c
>>> +++ b/drivers/clk/qcom/hfpll.c
>>> @@ -14,7 +14,7 @@
>>>
>>>  #include "clk-regmap.h"
>>>  #include "clk-hfpll.h"
>>>
>>> -static const struct hfpll_data hdata = {
>>> +static const struct hfpll_data qcs404 = {
>>>
>>>  	.mode_reg = 0x00,
>>>  	.l_reg = 0x04,
>>>  	.m_reg = 0x08,
>>>
>>> @@ -84,10 +84,12 @@ static const struct hfpll_data msm8976_cci = {
>>>
>>>  };
>>>  
>>>  static const struct of_device_id qcom_hfpll_match_table[] = {
>>>
>>> -	{ .compatible = "qcom,hfpll", .data = &hdata },
>>>
>>>  	{ .compatible = "qcom,msm8976-hfpll-a53", .data = &msm8976_a53 },
>>>  	{ .compatible = "qcom,msm8976-hfpll-a72", .data = &msm8976_a72 },
>>>  	{ .compatible = "qcom,msm8976-hfpll-cci", .data = &msm8976_cci },
>>>
>>> +	{ .compatible = "qcom,qcs404-hfpll", .data = &qcs404 },
>>> +	/* deprecated, use SoC-specific compatible */
>>
>> Why? That's not a deprecated compatible. You now expect to create many
>> unnecessary entries, which is not really needed. This is opposite of
>> what we try to achieve with compatibility lists.
> 
> Just "qcom,hfpll" is not allowed by the bindings.

Okay... sentence is correct but how is it related to the driver?

> The problem is that it's actually unclear to me what "qcom,hfpll" was supposed 
> to be currently. It was added originally for MSM8974 and friends (see git log) 
> but then is currently only used by QCS404 while in QCS404 downstream msm-4.4 
> (I think it was 4.4) I see different driver data than what's here.

I discourage from using generic compatibles, because their meaning is
too often fluid, but if we already have it then: it is supposed to be
whatever driver and bindings defined it when they were added.

> 
> So I wanted to just move what's used here to be qcs404-specific and then in an 
> upcoming patch add a msm8974-specific compatible with different driver data.
> 
> Also wouldn't the "don't extend driver lists when not neccessary" mean using 
> something like "qcom,msm1234-hfpll", "qcom,qcs404-hfpll", "qcom,hfpll" then?

qcs404 and hfpll are the same aren't they? Then why would third
compatible appear?

> That was kind of my idea if some other SoC can reuse e.g. qcs404 data?

If any other SoC wants to reuse qcs404, why that SoC cannot use hfpll?
If hfpll compatible is not correct, it should be deprecated, which is
not happening in this patchset.

Best regards,
Krzysztof



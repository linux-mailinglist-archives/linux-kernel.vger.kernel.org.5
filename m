Return-Path: <linux-kernel+bounces-98656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A356A877D78
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135A91F21E95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF2224D1;
	Mon, 11 Mar 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkoY3XLn"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A717577
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151122; cv=none; b=Dsz7v2v+Eftf1Kto1boirbZFKYwYpgX5wcrHmy6MH5ymyG17yqcFymk6lN4bAZ6Mj5q4b19vqU1hhaeF5uWnf14lFjpywlOLjXHAX3YXg2hl6zgcXEoCl1Tf6TN6Wp2HONj/4mCr+moJ1lO1tToTDLrIz2F7Jh7uax3jPb0pytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151122; c=relaxed/simple;
	bh=TY3TnEPX4g7X7HJBJOL/TEKiCpPtW3OEPenKoVFC+LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/FaygYs/39E7TiGflROtYsQWmQSilhKTrzjc1nsWuw35t1ARWAneBmkOHwsP0Enc0FbNOuS++PEYH2EoyIWMYRp+g7fkQMJNw4QT11UTsJEMafzBYQQubpMNcVdZoL6zHmrt09Z6Hkg1Jcbmek/TMtoNfk2BX0VmQm2S+zd1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkoY3XLn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so575358166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710151119; x=1710755919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OQBrY9eeA5zfIBGBrzakJjpT4YgaOqDAjfJmqLmuwa8=;
        b=bkoY3XLn8zy7ji5zmwfFhdCDC3Ee/RpqoBCpyQyPUk2IZOwKUZoT+1He6IwN77ovjD
         bGe3oOMVjlRuZ9nlqG8YFj0WFzcFKXCDEDQzRWuBDyoL2WzQUgLpaPS+5TOK7hvbpG7t
         RFFPE9RE26nshO12kI2Eddigk9+7QB6D5OMIC6vSxGNG1V16dzZbcBLxpxdSgAFGWR9L
         lNq3Z7Ev/hho8nNxlPCsc8IQ1iJf5/dRbj1z/Z0oh7p2vjuNtowV4QsydJ/bZ7ebj6hM
         9QhYSHaJSHVav2N6a4TS2pJe7eFe8igO+zRjSrWHXqaIen1i3Fb0RN+U50RnLvqX8nOm
         T8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151119; x=1710755919;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQBrY9eeA5zfIBGBrzakJjpT4YgaOqDAjfJmqLmuwa8=;
        b=aTkrmgbcMVEkt8lvCvDNS1LR8mhYRSRg207jaLrWyyGN3Qn0t3r1oVI/OWU+XcMdFM
         j+ZLhapSxMF3OL9PNRJP/trC+6zhbGF9lG0BmllNeCtgCE54YtVYNs0aLjWUV9vqsvLP
         NdGRyAN1Ykb9FLeYGcZpLN8H2jbY7D91QLSmAe3smAYJhBI+1XZLaxGXfOMtH9y6Y+y3
         vDqd9GiUR7JaIv9uwnfRG+hF4yR9sDJzXjR+Ph0oM54u2VXcWU+COYNVAnfundcfuUh2
         WItFYwSWQKjxjBP9CltUQIfMIEV89Fm2cxERznmA+wVkqhz2sGdFjNcmbQr1qHm+Insi
         ffPg==
X-Forwarded-Encrypted: i=1; AJvYcCUGoAAEkE1tsKRyyNs37nJYTQ/hqzcyE47pg3dq7bAZdxusdO1Fl5fu+LrLUetcCOqw4A1Wb3dHhRngQQkIiYPqIRggI85FVcEFnmBz
X-Gm-Message-State: AOJu0YzlwvJEbSYLl3kWXGH/H3UXLmP/HSAADW24A3oWIyvgUj/k8wXb
	dWcsHq1CsBt7aHl6EI83X9ND2j4z5Ae/vn62fG8q/ZQTA9fvyItWnL1YSc9QEhU=
X-Google-Smtp-Source: AGHT+IF7J4/eKSeXsVvlMsCqPmo8v1ci8mscmwtTJYVFbVIMQeW9S9kURyf2hWs9+lrvHZuHOMwDNg==
X-Received: by 2002:a17:906:f9d2:b0:a45:373:d0a with SMTP id lj18-20020a170906f9d200b00a4503730d0amr3970941ejb.32.1710151119411;
        Mon, 11 Mar 2024 02:58:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id rv25-20020a17090710d900b00a455519bcb3sm2699151ejb.55.2024.03.11.02.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:58:38 -0700 (PDT)
Message-ID: <ec81cbb5-30d9-4104-b59d-ae7cd2d90c48@linaro.org>
Date: Mon, 11 Mar 2024 10:58:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Tengfei Fan <quic_tengfan@quicinc.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
 <20240129092512.23602-2-quic_tengfan@quicinc.com>
 <CAL_JsqJfsWaj9OPkvc34rBvx7W_3v9+1kZqNu6QKDsA=iWAA4w@mail.gmail.com>
 <CAL_JsqLbbRFijBXS5CyRm0P4FMY7bR3UUdgXA7xP4Z1oRevnzQ@mail.gmail.com>
 <CACRpkdZ3uhyTnF7YkMk9sOeJJFZ4UPEna7PwpqPeBpWDdAmayA@mail.gmail.com>
 <e828b14c-7a09-479a-bf60-0c16571f133f@quicinc.com>
 <abebde71-ac9f-434b-b48b-6567308a2873@linaro.org>
 <2b512404-bc56-41b8-89aa-dcbb23d7b2bd@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2b512404-bc56-41b8-89aa-dcbb23d7b2bd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 10:43, Tengfei Fan wrote:
>>>>>>
>>>>>> I think you forgot to update the example:
>>>>>>
>>>>>> Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
>>>>>> /example-0/pinctrl@f100000: failed to match any schema with
>>>>>> compatible: ['qcom,sm4450-tlmm']
>>>>>
>>>>> Still a warning in linux-next. Please send a fix.
>>>>
>>>> I understand it as applying 1/2 is the fix so I applied it.
>>>
>>> I will check this warning, and I will fix it.
>>
>> Now? We were all waiting for you to respond here without any effect, so
>> finally I asked Linus to take the patch. In the future, be responsible
>> for your patches and comments happening to them. The same if your
>> applied commit causes issues in the next.
> 
> I will speed up the upstream work of the sm4450.
> Before that, I had been focusing on the work of AIM300.

That's not what I was suggested. I don't care if you work on sm4450,
AIM300 or foo4567. It's about your merged commits and submitted patches.


Best regards,
Krzysztof



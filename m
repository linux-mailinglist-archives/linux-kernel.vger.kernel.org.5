Return-Path: <linux-kernel+bounces-98506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E453877B10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0F5B20B59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F96101EC;
	Mon, 11 Mar 2024 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUMXz7Jn"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548210A26
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139740; cv=none; b=nKy1GgQTmFMloPGwH8r7BurKogTRNbJXSA5W7ib8KlymgRMh6zvM1X/oOdqwjnv6du8X7o00p9gBTXHzxPauWq+pp1+pq9wxzeOtqYetVRGdUQpWgZA2vbU03rW7XWnHp1+WMdgQq3z71FqvN8E9m6pbFJ6vOGTnXZ1cDytPYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139740; c=relaxed/simple;
	bh=ef1ucrmRxImYJi/k/RgFMQzxuIfEGU2EjshfHkpkdf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/KbIgqtn/BQATIOgBdwjzNnPbsLHGEYkeePXhKxAjBGWDNj2LaFWpZ86C4hVcCLhHmhTpoDwHpJhghos7NlLz8xHH8LRP8nK8XyLAyugKUFzd5EobP3lm+OUfXRqmyGKBn/OKwvKPDIaBJYdnVqwg6VTkpnmKsAdnJ1SAR4mSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUMXz7Jn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4627a7233aso87359666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710139736; x=1710744536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1ad8dWnxUViMh9KFUYOIhtKix7ehQ2jSrBRd2b7pag=;
        b=eUMXz7JnbnY2TOuMGEoiGA1oRakIg4w5xx/PwgQZAJkkJ1cK36KNZOxNIlVTBMfRdu
         GTknFQCzxw5v/6JNGU+eYOwaJlEM1iwXZXJoMBUDW07vkXNR+EklnxmevCxPFMYYfZI4
         kpx+eXGytUg037rz4EG82Qgt61vdIN+dG7mKugoKFq1XjmV/ovVSx4mG6xZyJ4+8p1eh
         6qyavWx8ZxBlqSQPYNOd7lVPx/E8kqqZw6UJXEXr47fVfd7sHyD8DM9hh0oUA25+FApF
         ykjHO3brLwpEXTVuaa6oKuJLxKWgNhM+I/whfQn67bEZmds/4NfmWMGmaDrpu9/HQNZb
         sVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710139736; x=1710744536;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1ad8dWnxUViMh9KFUYOIhtKix7ehQ2jSrBRd2b7pag=;
        b=C9YS024Lv6qigyKrwo2ZL0+fVhKPGskUPnx9LMIc2ifW6evgeDsRWOHuCWgIuVVDvG
         OndOqb2BxAiAwxjyjHsVuo+NWE/g6VXWehfpQ252GRb4q52C2hSsA9wV4/qTlAryXQls
         C3NrwItLpSQ6jYJhCvFY8IwM42AbJDeZ8E8xxdtyfVPxpZOBhwoJCoU9tWQlQlyFq7nK
         VD9U/FZap9ImtMbmaZKwa6rVxrGVY3W3y+4z/RFDvk9HQqZK5SwMsxysR8AhUYblT4K7
         /5tXHAX4xpdNlDXvlHcxphrAEMJXkJZfB/NxEa/Pi+42BV6ZAqB02vGPZPfTrguN4jJz
         v+lA==
X-Forwarded-Encrypted: i=1; AJvYcCXif1rzA0SX0L3GkyUo6P39HpDUqHaui3uFcNIGn5OzX+hmGOmh4nGLOKJkViGtoLPxzVV/jGSi1tjpGv7Bccj3JI0K5QKZ5Li0+pNf
X-Gm-Message-State: AOJu0YyGOioEt/OR6TYQ7zHynLZRG8n7JsyiImk0vXFqaGl3f0jYHGJh
	xAJb79z60TW7P73RY86QZY4XLxTIGDkiERySJfxgu3WjS2AfkbnQFVct4dAsWB0=
X-Google-Smtp-Source: AGHT+IE1r5QaKAl2dXYpn/SAM5AzV0urpxk8Y6waPKKyvZewNl1isNNYPk0SKL5kYB4B4vuRNPxYxg==
X-Received: by 2002:a17:906:6a09:b0:a46:5df:ad98 with SMTP id qw9-20020a1709066a0900b00a4605dfad98mr5964383ejc.21.1710139735722;
        Sun, 10 Mar 2024 23:48:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id et8-20020a056402378800b00566a4dec01fsm2619934edb.11.2024.03.10.23.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 23:48:55 -0700 (PDT)
Message-ID: <abebde71-ac9f-434b-b48b-6567308a2873@linaro.org>
Date: Mon, 11 Mar 2024 07:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
Content-Language: en-US
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e828b14c-7a09-479a-bf60-0c16571f133f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/03/2024 03:27, Tengfei Fan wrote:
> 
> 
> On 3/10/2024 7:44 AM, Linus Walleij wrote:
>> On Fri, Mar 8, 2024 at 9:10 PM Rob Herring <robh+dt@kernel.org> wrote:
>>> On Tue, Feb 27, 2024 at 7:37 AM Rob Herring <robh+dt@kernel.org> wrote:
>>>> On Mon, Jan 29, 2024 at 3:25 AM Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>>>>
>>>>> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
>>>>> to match the compatible name in sm4450 pinctrl driver.
>>>>>
>>>>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>>> index bb08ca5a1509..bb675c8ec220 100644
>>>>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>>> @@ -17,7 +17,7 @@ allOf:
>>>>>
>>>>>   properties:
>>>>>     compatible:
>>>>> -    const: qcom,sm4450-pinctrl
>>>>> +    const: qcom,sm4450-tlmm
>>>>
>>>> I think you forgot to update the example:
>>>>
>>>> Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
>>>> /example-0/pinctrl@f100000: failed to match any schema with
>>>> compatible: ['qcom,sm4450-tlmm']
>>>
>>> Still a warning in linux-next. Please send a fix.
>>
>> I understand it as applying 1/2 is the fix so I applied it.
> 
> I will check this warning, and I will fix it.

Now? We were all waiting for you to respond here without any effect, so
finally I asked Linus to take the patch. In the future, be responsible
for your patches and comments happening to them. The same if your
applied commit causes issues in the next.

Best regards,
Krzysztof



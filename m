Return-Path: <linux-kernel+bounces-101174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5603687A366
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94103B215DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4A168CE;
	Wed, 13 Mar 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ylig1VV0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215C15AD9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314590; cv=none; b=IHMsHswYSPm0vO0hd+7cbmbL/zlgos3Uh8d+OKrJVH1Mqk94BTYY1hh++xqxEfYZBoKuzhBOEeukQifTBcodLEe92bSASpOgOWPzD6+FqCzDTQxQj/BXK7MaKRB16amOM0XE0S1RVQhBe1FOMVzfFdaXNNaAXpHYRU1WgSeX3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314590; c=relaxed/simple;
	bh=a/lZwk/pm+Db9fq6QNFpSdI8D384OnTV0btsctyqme4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3Nz+kDx4Uq0imHB6qUEO4O+9HqXSOG8AWmLB8HMtlHaDPMBFGjQpIB7ZIVASGA6umllbMxUOitpxCiyhuKArVsHNthBzWjgZvfO0dc3cyBhB2iVW1SVlhAV20K341+1X4jkJ4xDyR1KxjuDBeqo/TozCUMVlJsJ18NWIii7Npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ylig1VV0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e9dfd343fso384026f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710314587; x=1710919387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFJxyBzgSHYYw573VdktUov73Ozbkis7+JQYEiXOMfs=;
        b=Ylig1VV0VIFf1J0mKhZPmmPXmP5bFo5WWbqNQz/ezoOzs8+PJFSgMbxu3/nXEvk4Eh
         /vn4e3tIRN0ppDbM72ZAEcV82gEKCiB+vTNk/h5/Nl60g9r13JNKdMe4tfFckzahuxoY
         rXdbt1b+ZYE1IY91OHe+Nz30nARviipQIKPhxqNY9uooooyPFVAW2vgTnGCcqOHaZPvK
         AAAdw5QIsF5kQkr7YZPQ4tx+/By1BFGSop9tNBZu9F3nzZ2veAIG8MaCVq8MpitM5GGe
         e7z9fwqL1+9HtYCKj6NZp6IRfKACeMu/lLEUZr2nzS04BjwfC0OSQ6GCWNTv3LvMS6hE
         lALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710314587; x=1710919387;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFJxyBzgSHYYw573VdktUov73Ozbkis7+JQYEiXOMfs=;
        b=L/08y9vDe09YUXo0PDicBJdpOFV+ym0SvpUMObZmOd0LN6OzNOodumFr7y9d7xOcoC
         H6BNVHE82vwlPeXnx8EN6Y+rry5uukxFRtARsTrNYFx8DoLAcwUEcXpb4ZQfoTfLI78E
         8y7Z1PifiqNPgDz8LvzraeBspU7TLghnN3/nASsQkdb9TLVv6QEdBvBKruZi9vgnk6Ev
         mYyPL5w/Kd+HqkcDV4Go3ilezW+OkPBeGgcjfNT64ILymAdsrKrIel5FM9sLVfhK9Z7o
         yxsvFJImaZCnOK7h0jOhLEAYuEpwL7E2egQlh46XzdRuy821A15az6ltajzUh3jEL682
         Ahzg==
X-Forwarded-Encrypted: i=1; AJvYcCUSM2DDt/lEa7zDkIKsNiQZF9C9T26DMHIa5TWQSQy1L65DAsY7fY3jfwaHjTdyvq4yF2mjb6TlP6Xk3eOViy6FqKb/0cgkIeaq+5OV
X-Gm-Message-State: AOJu0YyuxtqJQJO7vgzoqJAERO9cgiu7bmSwBem/Z3rbC0p5QYQ6nWtM
	/OZI7trNFW223hH1p5GQHcEauGaWM/5PqC66CllyCJJdOhdlIuprx0LpJliC/Rg=
X-Google-Smtp-Source: AGHT+IGpI2dtHvNMdj5+2EbljYjvcpQWjcvXLOb188DV4m0Sci5TrAkfnIr9q18P9ZGdhB5Kexyisw==
X-Received: by 2002:a5d:6da2:0:b0:33e:1f6f:6faa with SMTP id u2-20020a5d6da2000000b0033e1f6f6faamr1335335wrs.28.1710314587170;
        Wed, 13 Mar 2024 00:23:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id f15-20020adfdb4f000000b0033e79eca6dfsm10823836wrj.50.2024.03.13.00.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 00:23:06 -0700 (PDT)
Message-ID: <60a0e51f-dc0e-4bbf-8127-f987ac2aae71@linaro.org>
Date: Wed, 13 Mar 2024 08:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, linus.walleij@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240312025807.26075-1-quic_tengfan@quicinc.com>
 <20240312025807.26075-2-quic_tengfan@quicinc.com>
 <0d768f17-22d9-448e-9253-8498b61bf71e@linaro.org>
 <31b02b76-88ff-42d7-a665-18d2661e028c@quicinc.com>
 <6a3b5c9d-6375-457f-83c9-269746c1612a@linaro.org>
 <ef237b3c-8613-4cd8-9391-e4a08d50cc6c@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ef237b3c-8613-4cd8-9391-e4a08d50cc6c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 02:30, Tengfei Fan wrote:
> 
> 
> On 3/12/2024 6:55 PM, Krzysztof Kozlowski wrote:
>> On 12/03/2024 08:47, Tengfei Fan wrote:
>>>
>>>
>>> On 3/12/2024 3:41 PM, Krzysztof Kozlowski wrote:
>>>> On 12/03/2024 03:58, Tengfei Fan wrote:
>>>>> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
>>>>> to match the compatible name in sm4450 pinctrl driver.
>>>>>
>>>>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> Wasn't this applied?
>>>
>>> My test code base on tag: next-20240308, this patch is still not applied.
>>>
>>> In fact, the following dt binding check warning only can be got before
>>> this patch is applied.
>>>
>>
>> Please read all emails in the previous thread. You ignored two emails in
>> the past and apparently one more recent.
> 
> I don't know if you mean I ignored the email which related with "Patch 
> applied" tag from Linus Walleij. If so, the following is the reasion why 
> I still include this patch:

Yep, that's the one. Please do not send patches which were already
applied. It causes unnecessary effort on reviewer and maintainer side.

> 
> I synced the latest upstream code on 03/12/2024, the latest tag is 
> next-20240308, this tag still doesn't include this patch[PATCH v3 1/2].

Happens, considering Linus applied it after 8th of March, I think.

> 
> Dt binding check still get warning if I only send [PATCH v3 2/2] patch 
> to upstream base on next-20240308. so I include this patch[PATCH v3 1/2] 

If you send patch 1+2, dt_binding_check will have exactly the same
result. I don't know about what sort of dt binding check you talk, but
for all cases: you changed nothing by sending these two patches in that
regard. Only noise on the lists.

> in patch series even if this patch have "Patch applied" tag.
> 
> Looking forward to getting your advice if submitting patch series this 
> way is problematic.

Do not send patches which are known to be applied.

Best regards,
Krzysztof



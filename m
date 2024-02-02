Return-Path: <linux-kernel+bounces-49834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA8847039
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3C1B279BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010FC144605;
	Fri,  2 Feb 2024 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPKHFn83"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAD144606
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876694; cv=none; b=L2hPfVy6tf0APoWmTJE0vXx6UX7eJNaFhD+40/h/6+f2MpWpDc9mnfloybPzMZoFBkPsTrHmjw5MywP49bHBhW1l6gu/nIlodSdZZlf8yY9s3bgJVK//PIejd9Zt/Rs+uerTPMZRI0e9yPxA6Nq/tXVTEArLD2emVKHz4nBSHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876694; c=relaxed/simple;
	bh=rltGmC1GHB8pdd1yW+POUFfym+S/IIvIXoyJRo+7+sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBZh1YSDR6q8E/WLoFXVjsVRADAnbF/u8vSKUDSqtkzRryhiiFYHBC7a0zgtdP0RaFSAxkNybH0nx/dcbllMKFyI0wyznoDsLNhWBo42UfYsOB15GI0IpmlC1a6ZwWYRteavjTXBWHbSHUBNmWc6FLEcvRwPYlRF1WMdAUMz/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPKHFn83; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55fd5f67f03so1840115a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706876671; x=1707481471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErGgrSjGcI1gfiIfMa2tifZML8/zJN+4ELwCxdeBffA=;
        b=cPKHFn83x6JoLbdgILZ/b/1+Ge1gumiHtVdzIzdSgWcSTVHR+eR4SOELsH07FLAKrf
         Q1EozdmQKun6Q5f18ja/rfws13f90otNgXHKfhZBAyB6kWxObr9p1QlI2QxCHmkSFvBx
         z+IPeu5MyYcFaSNKDRJK6a7lw3o1GltxFPYrn6uilqtzkOdItNNEQWFrZEjo/goskupZ
         aw53H0cnyDiHXsO3/njK2rhMkOqXSvB3535jUYR7SpuhENBctnH6iaJnTJPt5X1bXhnn
         aUjtUHux6cA+u1tCTci7AYsv0HWCQkbqAdW5GescuQByLiHK7/jzsedNxxa362+F6qNE
         sJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876671; x=1707481471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErGgrSjGcI1gfiIfMa2tifZML8/zJN+4ELwCxdeBffA=;
        b=jgwcketD8UvKA5bWyx48czuWq3V5GeOuiUEhXjqdQnyu/nzxnIz/sNCtOKvZdjnnQp
         /8ckPLURg3VV6GZ9ow32TbGPeB/XHeFpea2ymenmIYk+2rssTUPh9+orcdOGozm08yjq
         UGTA4nU9iSDes6POEAwhzVc46LgpjLW0X3zywFZSqOTYmLs86HA36miFef06ktWDUPV/
         s4f5+dd+sDEbKtlS7gXeo7CDE8TdYEZy7+KCmy/0dNHlA59gyr3ofUdhf+dLLwxfrlP2
         aQ2y3KMySFQGLwK5cBZoomHo/2kuZuNJXfvH+vZbmh9adzsvHJ2qawB68VXVt7s/OToq
         nW5Q==
X-Gm-Message-State: AOJu0YwJRFuAlIZaFfT7jSPW+hV+kmawiOyrO25mfhxSeL8rZt0SN6eC
	dkLTZ+3y7NJ5ao7RYwe4WgMBPee83oHt3hV6hD9fyVorGnVKSWjnBRSROJC5wxA=
X-Google-Smtp-Source: AGHT+IGkUAivELBKUH7eZ/XPBhC8V0yYnbHnxA7mCyMe/gt8hkKH+p4N2XGi6/SzjrhLKvKC57Rd6Q==
X-Received: by 2002:a05:6402:26d2:b0:55f:abe7:8f33 with SMTP id x18-20020a05640226d200b0055fabe78f33mr4543587edd.15.1706876671523;
        Fri, 02 Feb 2024 04:24:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWdx9assdmm8xe6VJIsT8YpCdl7tYAOCJB2bElJ6YSelvW8KflQI6WeEdM8GIIGXhgZ5cifxW42wdCItGSWQr4y/j0zBRw18GYWEM1lyZGvzUzBPCIKsL17QTECRXsTIMfRmT2mP5+6CHd1dUKuhF5tcrwi2l59C4MUcNAQhsQQowHGHAksweeR/ykaHJi3HBuUpgBQd5V5zt3MIPK+f9YPAqwm3lIgplv9+RN+eiFIfgr8+TemaqBhmXnHshlyoqfdT2h4TZJWFIRF
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0055fb4b16f29sm765018edq.21.2024.02.02.04.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 04:24:31 -0800 (PST)
Message-ID: <5713ba6c-9fbe-4b25-bdf9-e7a572baad6a@linaro.org>
Date: Fri, 2 Feb 2024 13:24:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Use GIC-ITS for PCIe0 and PCIe1
Content-Language: en-US
To: neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org>
 <0cf69024-a3e6-4be2-89ce-017ae521721d@linaro.org>
 <6f89dd4f-aae5-4221-9a0a-bebbef862229@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <6f89dd4f-aae5-4221-9a0a-bebbef862229@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2.02.2024 09:03, Neil Armstrong wrote:
> On 01/02/2024 20:59, Konrad Dybcio wrote:
>> On 25.01.2024 17:55, Neil Armstrong wrote:
>>> Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
>>> received from endpoint devices to the CPU using GIC-ITS MSI controller.
>>> Add support for it.
>>>
>>> The GIC-ITS MSI implementation provides an advantage over internal MSI
>>> implementation using Locality-specific Peripheral Interrupts (LPI) that
>>> would allow MSIs to be targeted for each CPU core.
>>>
>>> Like SM8450 & SM8550, the IDs are swapped, but works fine on PCIe0 and PCIe1.
>>>
>>> WiFi PCIe Device on SM8650-QRD using GIC-ITS:
>>> 159:          0          0          0          0          0          0          0          0   ITS-MSI   0 Edge      PCIe PME, aerdrv
>>> 167:          0          4          0          0          0          0          0          0   ITS-MSI 524288 Edge      bhi
>>> 168:          0          0          4          0          0          0          0          0   ITS-MSI 524289 Edge      mhi
>>> 169:          0          0          0         34          0          0          0          0   ITS-MSI 524290 Edge      mhi
>>> 170:          0          0          0          0          3          0          0          0   ITS-MSI 524291 Edge      ce0
>>> 171:          0          0          0          0          0          2          0          0   ITS-MSI 524292 Edge      ce1
>>> 172:          0          0          0          0          0          0        806          0   ITS-MSI 524293 Edge      ce2
>>> 173:          0          0          0          0          0          0          0         76   ITS-MSI 524294 Edge      ce3
>>> 174:          0          0          0          0          0          0          0          0   ITS-MSI 524295 Edge      ce5
>>> 175:          0         13          0          0          0          0          0          0   ITS-MSI 524296 Edge      DP_EXT_IRQ
>>> 176:          0          0          0          0          0          0          0          0   ITS-MSI 524297 Edge      DP_EXT_IRQ
>>
>> Is it by chance that this one never fired?
> 
> Yeah I only associated to an SSID and did a simple iperf, not enough to trigger all MSIs

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


Return-Path: <linux-kernel+bounces-102899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E430387B828
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC11F233A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3976127;
	Thu, 14 Mar 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUu/8GJn"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFE101CF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399545; cv=none; b=pEBGj9Pj0WrH7KD2lI8hCGsmz9IbvGBgz10NyRVQ+a7Z233CSmgoNmtIxVK9KySTIg98rqwPjzVK8NgQRfu6LufHqB/vYKxxgCSA8Z9AaZVV8daph8/z9V89HwSuXoQULapVyLzQFZ0qTOVWYw1aDZ84/6jnj3DdNvysreIslys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399545; c=relaxed/simple;
	bh=lk+FIemgnpehzyK3+vniFLUNk/aaFM13iFrQq0+A8pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6Ih+MLS7f4lVOVryWmphGz7pBFo5X2kaundm/bPAIXwQzEUnxfTqcY4cSgISKFJK63zB21GcIf/BtM5EUSCBXlgt3uv5MfOpJdVv1r0D30wcmZAqsuUlUpHSttf1lhgXbMd5hYzfolnBAEx/r2hzysM+alhpgyz4pKN2MiH07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUu/8GJn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413f4b5171dso556945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710399542; x=1711004342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMlXmtet+lMKP9MwdxiMqK7TmWez6CL4fiFRXib4iA4=;
        b=gUu/8GJne/xpdON8oL1fG68GJ3UgvNsSY4VnBEVORX6iH8kFgYQVsKFz23S2S8e0Ur
         oDFIzCwKHeBbgOC+LSX+TzsWOsX0e/9y+EQcWHkIhwNwK9mMHkLLKgNv4dWXlTaMtu1T
         oQwJ+/D9XPr9UUMwD2pyZyLtzhopn0V3T/iZjkX1ZQ969l8T3JZHCUjr3hVAE1XCWh2k
         qheSuQn9sRWmgoeUooxfF+M2e3NPry02PPItzTdvH5+DNW5Kyc/u9TPLzFtRUVquEYIC
         Ub9d2AQ4tIjqAs1n+g5YmC3RPXWirGR1qWhRqMjVYKGGfr4gDGK+bdlBuaVrZooRrwTC
         KnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399542; x=1711004342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMlXmtet+lMKP9MwdxiMqK7TmWez6CL4fiFRXib4iA4=;
        b=v2nLjQ1U0arz5f5B9MwAY7nUktaRnAFZ3A+nTgZ5nBcvfkAVNAgNln434tP5i1O6ub
         CHJ7L4+HcyuAyKR4gateC4Qv3gZfBLbQTY0lCcUkzLk1d5HRA3uNgLjVNerNLenj62Zf
         dojukTImsB+1rFU5D29kz3gnlVWKM5QvcXULpHTS55y1kqqCHykz28oOpuR6o84w8e/Q
         UuG3oWLcb3qq/aRQEY85onGULkYAI8EHby5OmF0X/3j5HFMtl0hNMgzRdDxCzBPIIseF
         7Run46A0LoVCibXbLOZIDutuJZ3HxyOD0xFJzOKsIi1Ys7T5YwV/0pyTDwIgPJP57vQm
         HYLg==
X-Forwarded-Encrypted: i=1; AJvYcCXQR0LE+vUh6tMkPk8r5Nn5uoCtLIKXQEkBRzopri0x5tw+9JwdKxuaR2HHGFGiuQmsyYgA2UH1lExYetzgQCgwxDLsHaYMLxaNE7DJ
X-Gm-Message-State: AOJu0YxxT/vZDoU8y81Hwuj1pmm3/ux+mKBgSN90MOr0QWl1u6hQdh6V
	GMf4opQxTJc6hX7oIEjWiVtiK84+SxaC/08KMWRYSUbByH2Pi1ETvoSeW8PJGxo=
X-Google-Smtp-Source: AGHT+IGOsBQLhuuoMuHR8m2OSBz2b8kotaUpR3GF/pFWkyT2N1DWRMqNekfNP38jo/iUPW9o1N1r9g==
X-Received: by 2002:a05:600c:c8b:b0:412:ee8b:dead with SMTP id fj11-20020a05600c0c8b00b00412ee8bdeadmr672788wmb.34.1710399541831;
        Wed, 13 Mar 2024 23:59:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b004134540ae3asm1438824wmq.3.2024.03.13.23.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 23:59:01 -0700 (PDT)
Message-ID: <c0e564f1-bfd9-450f-8bce-835837719688@linaro.org>
Date: Thu, 14 Mar 2024 07:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH 3/4] arm64: dts: add support for
 A4 based Amlogic BA400
Content-Language: en-US
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <20240313095311.dxrr7gvt4t3gwoho@CAB-WSD-L081021>
 <74f96887-572d-47eb-bce4-9d61ec51b88d@amlogic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <74f96887-572d-47eb-bce4-9d61ec51b88d@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 06:19, Xianwei Zhao wrote:
>>> +
>>> +             apb@fe000000 {
>>> +                     compatible = "simple-bus";
>>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>>> +                     #address-cells = <2>;
>>> +                     #size-cells = <2>;
>>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>> +
>>> +                     uart_b: serial@7a000 {
>>> +                             compatible = "amlogic,meson-s4-uart",
>>
>> If I'm not wrong, you need to create dt-binding alias for meson-a4-uart
>> and use it as 3rd compatible string.
>>
> On UART module, A4 and A5 SoCs exactly the same as S4. There's no 
> difference.

That's not really the point. You are supposed to always provide SoC
specific compatible in front of the fallback. See writing bindings document.


Best regards,
Krzysztof



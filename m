Return-Path: <linux-kernel+bounces-61523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9E851338
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EF02858FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6522E3CF59;
	Mon, 12 Feb 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8kh5B4y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863443C680
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739708; cv=none; b=ExA72oy3iq3MaaqIlr2wgEAFu9tkKDAcoZad3uIgzqWtzuiQnJqSujHB7s7yCKlYtrdRAy1p0pZCB94lv/7eXqbeL8o01Ejw2oZZg+uunvbw5HTLrN29k8v+7pbSzYbSisJBLlSCCqMyOMsxJQsjmjGrd7UguM+i1Rvj28Q0Ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739708; c=relaxed/simple;
	bh=G/RpwQuFCmSFbsICul5XB6NnsfTiR0OGobJvtsvzI2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yib+VFchKM8kPS/tYXtnxXeDx+ITyhhcMrWXY1SfM+PFbj4TJGeEYzMH+CpRbHWAWQcCCmj+3GL1zO2FnkDWdR6gXE556vAp8nCG8F07Y+mzNm3r/papqtv1M5eg4mlA6JZ2vib9WMQaAXqIFaVMnlpu17MWnZ8hJ+hHEj11u8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8kh5B4y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41166710058so1611015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707739704; x=1708344504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G1t7l9qmGi/Hd8UOFcNwxIiY9XyvUG9RMcV3bH24D8=;
        b=j8kh5B4yqqAXI5WBosfUBksCQV1XgkJ9w9jsOH8WF89IG1X7C0ILRHiwYfE2ErZw7n
         tYsP/9im0fVmU2WZEWVc9Vko/zlBtPJR5Qj7cOfrpYmtA4H0Cl8I+wx7+uGkoocWPorr
         0G7eSuVHpFvbayXfuf69LrgO18pwSF6hor4Xm4MrFNuycFewQ2LsTHFXXz5ZHEqdVVzL
         u+rGe8iZUPMW+5lPtfgThZHHEdUdasqeTYmlMAJkRCIVg0LoLisFjNaIi4UJBd7RxWb+
         IGywsY9hcaEgZIUhDM75uKv1inN2yJ0X8TGTedPYygLgp4W6K25Bia5spTB+9X8yCxrV
         M6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739704; x=1708344504;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G1t7l9qmGi/Hd8UOFcNwxIiY9XyvUG9RMcV3bH24D8=;
        b=n7emqDLdlU6iiW7sWjm2S3NBJQcTzxqSLmkskwKLCl1vc+GcLZbqon4rzLd21c4BdR
         lmjWJje7nucqKzA8UXuOLfd8Sa7oie9QkExhwncbuuKGToAQlcKjB9IIrGXv7GvpVTUF
         ls+UC4z/+2wLKyTlw27HOkCndi5K4K58iYJezDOg3hKGk6cFCZyWaVfXL8stT6yTd5h1
         1N+n+mi7LDV5m3C6nYCsUxZVvjrRB/qXvlJ9dDSf/FFGy85KNOd+ZVaPWqLD2SZtyboY
         x+2weyftthRtGe8oj0q5dw7xL8PBSyOf7o0qYjLEw+6/NAsX5TPifrrjB8bAEIFtqat7
         dpkA==
X-Gm-Message-State: AOJu0Ywb2Uc6MaRcV3sR7W/8GbTcIRKjgGZqtGPBZjkpHa8ig4p68tCw
	klQMEDRKZAxpJ2cB3EZfb7ZMzJeuG9pPc7voBHv/vB4WxeCZqrctBsZmxsZUhEQ=
X-Google-Smtp-Source: AGHT+IEl6G1AQapW7wbS/ikI2aUuKt5YdNVEUHw7ptPSvAFt5fyPApOBSdjDSDlNEqHgNTrpL8sr5Q==
X-Received: by 2002:a05:600c:1547:b0:410:c25d:38fe with SMTP id f7-20020a05600c154700b00410c25d38femr2495380wmg.28.1707739704625;
        Mon, 12 Feb 2024 04:08:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgyPMjnH5p7/RKVEhKq5YFq/NyaBubgIe8MED5tD3HUhUvArELRjZKkztXxcFi5cXLIz/jpJK+++ZAYMXFxXAgWfd7aAYgVp5V6A220H2F0pW6AdfGTDcfbdEm1i6BQ6tHGRrDw/jZXdc68beA2WzX2y0Z1/6LzavkZCNBt/otNFaOOXv2Wwn+ZCNATCN67jjYQOwSGNE3JSdUtLPzGE6Y4b0aUWyMRSeCAAO3VRZ6Ih1Ydzh6OnVL5FEFSgGq9TuRlSKc73NRQjUl2lqUuYDKuqfmiPNR6IKvLw2iqCcWwOKB8yMjJTNQOT0MDpDyvbIdTbVNi3LYXg+y54AKe8lUsOpiHC2lbPuv1FoMqaicizImfwj8qnhX+rDe7ZocJsXK6YjbA3mcw/9EhEV1hfB4O2AUgrR6H2gLL3ECxLv9Z6+DaStgtdqFqsKlaDrqWICOwzdKJQYhJNxU1y7Y5TGjFwalbFLtfWtGkLTfohSaItK0ab4K5F17mvQ=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id bx31-20020a5d5b1f000000b0033b5ee36963sm6711656wrb.23.2024.02.12.04.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 04:08:00 -0800 (PST)
Message-ID: <b6ec1d0e-e35c-4917-871b-049efcb2ea22@linaro.org>
Date: Mon, 12 Feb 2024 13:07:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynos: gs101: add stable i2c aliases for
 gs101-oriole
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240130233700.2287442-1-andre.draszik@linaro.org>
 <170737972037.52344.9107022607101399076.b4-ty@linaro.org>
 <5972b6a4ae8669e2a9e872278b740b182217906b.camel@linaro.org>
 <dce39e15-32a8-482c-8751-af4a133f82d2@linaro.org>
 <c16c1f18a8c6f33a608618d4ccf7d8c8dbb6f88b.camel@linaro.org>
 <67a6564a-00bb-461d-b7eb-ca169df6d251@linaro.org>
 <0ad3082c50e21a74de41ca9908bd53b72e1f1a9c.camel@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0ad3082c50e21a74de41ca9908bd53b72e1f1a9c.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 12:52, André Draszik wrote:
> On Mon, 2024-02-12 at 12:40 +0100, Krzysztof Kozlowski wrote:
>> On 12/02/2024 12:30, André Draszik wrote:
>>> On Mon, 2024-02-12 at 12:18 +0100, Krzysztof Kozlowski wrote:
>>>> I can drop it, but the actual problem is that what if downstream keeps
>>>> changing aliases? They can do it...
>>>
>>> We won't care at that stage, downstream should have no reason to divert from
>>> upstream for numbering at some point in the future.
>>
>> What do you mean by "no reason"? The reason is they can do whatever they
>> want. Some project leader says: "I want this" and they will do it. They
>> won't care about our upstream choice at all.
>>
>> And then what, you change it again?
> 
> As I said above, we won't care if downstream changes again at that stage, so
> no, I wouldn't plan on changing again.

Then I am lost. What stage are you thinking? What differs between now
and let's say 1 month for the GS101 which was released more than three
years ago?

BTW, the aliases I see in downstream DTS (gs101-usi.dtsi) - since
beginning up to Android 14 are:

                hsi2c8 = &hsi2c_8;
                hsi2c9 = &hsi2c_9;
                hsi2c10 = &hsi2c_10;
                hsi2c11 = &hsi2c_11;
                hsi2c12 = &hsi2c_12;

They were set like this in 2020 and never changed afterwards.

Best regards,
Krzysztof



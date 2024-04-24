Return-Path: <linux-kernel+bounces-156555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350328B0478
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53DD1F25A21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94270157A40;
	Wed, 24 Apr 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7b0crVW"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDC156C6B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947870; cv=none; b=SOEAayscuU6SaEj1XVWfoe4T1Spvam9jk9+w53COoibboJNiPQoM1RIwxU/eWskXy25mGZKdMW+JInchcIoE25Fy8amshK8ePuDVLThYLEbU5OfNFIhIWKlEXPM2SysOXY2YGdo4QvyO9mBKl0ttEYKqev66XJj5sFfaiFxM8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947870; c=relaxed/simple;
	bh=eBNMslm0PdQThmrvJQdlDacnyzoprapoNvZMhUQUAT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDNzPk5lXGqPtDAjErLGXmk+AkPSeNse8j9SNEn0EnbDqbheq04+K4G0Uj0ZChphKYHCUK7at2NUl0Mvk0PZ4Cw5StkRGlHkicX8EdIGsPkGXd2NB0jh0EQ6b5MHfL93UET+TNqwgCTzrP/6VSfI/gKdHiUQq2rY+LhVKIIQz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w7b0crVW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso25402325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713947866; x=1714552666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv9PR3rnKBjv55iigpDrI1Do3KF8pk1sW8s6bauxk8E=;
        b=w7b0crVWPOYpL92/HciUjWiiz3oMjRpfe7CgyFBlvfLYHHIqxV+bqqgaDVZ5az08qj
         dIigrtBRtXQjaFcLz/VlPFh9+3GfV4+/qoYsBUNA8uwtBrzD86bBcvWCrYOnOC8aAg2F
         Gc9zb4oZex7Y5MNmZ7MnwUaEDegvEo9u/sPZ2T0K43x0yGtfgVRVSEAmcA6/rbFcbOYx
         114lx1OjWxWko2lBpsbalTascGyGwiyEzN1VDg+FWVDSPqhAfQJstdvJxCAigxb7afVJ
         N1b+39qcNAQrges1WDk2QqVFIbyyToRovLbj9V4lalbCM9q2bNFiGzX6vxlVcL8IHLan
         4XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713947866; x=1714552666;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uv9PR3rnKBjv55iigpDrI1Do3KF8pk1sW8s6bauxk8E=;
        b=ARbXM1JfHWTdIT4g0HVg1lK3XNGf1Su/tQfF4A3XNrQ+1jzUj6D10fFzVYaFJH0R/g
         avDAqW2azDjQSEvZyThH/nFSkgTpsFehZkRCyq6P0UQl+ZodTuu40iRNN4VfD7fELZeb
         fwzZsJQBef935bPujn4Ai4YQRKeIVRvbzie4/0UY99/L4g+522XGNcJgR8u+LNmGQMLC
         zOsSVF4wH3krjUC3z2s7PhpcMuv6VbtYbocrkoRWsRNGwR3pR6IKA6BV22afcaLD6KLi
         1YYpVB3D+nXqmalQLmPswnQxYYlcJsZ/2jqUJLXwldw+o2fViLTiYbHQt9lx125ujv3G
         b+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUMj7/vY+YrNOxY315kmKLg6W99Vr/RJmtwYq88isz8EJsPZ9rop9G04vwUC2ic2Zj+I+pN+EbL1ILy7MWHdxDu5GvVmNRqGG0vwa0b
X-Gm-Message-State: AOJu0Yx0QkDxtzeu0vytZcJChDRh5pC7o7cpE1TxxxIc5L4C71Xuyy7B
	RfbOkx6G/VzJE071lIRC1RTWP4BuH8OE7wbB30OhnNUqzRvSiMzpaSR5Pi+cy0Y=
X-Google-Smtp-Source: AGHT+IGm24kLmIp1QFLMZZeTHUDpUAwdt1K+Vjc6izHPajwBGJPSlXkA+pWXjOFNhQWFw4lS+5PCsg==
X-Received: by 2002:a05:600c:19d4:b0:419:678e:64ce with SMTP id u20-20020a05600c19d400b00419678e64cemr1452460wmq.36.1713947865912;
        Wed, 24 Apr 2024 01:37:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b0041884b79b81sm23005752wmq.1.2024.04.24.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 01:37:45 -0700 (PDT)
Message-ID: <6ce7bc63-1c47-4e3d-a3af-8f229f1c36f7@linaro.org>
Date: Wed, 24 Apr 2024 10:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] arm64: dts: hisilicon: hip05: move non-MMIO node out
 of soc
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
 <171394159880.43787.12383182687947213751.b4-ty@linaro.org>
 <6628B1E9.1050300@hisilicon.com>
 <7adfe10b-cfb6-4242-9520-dd9819bf7f43@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7adfe10b-cfb6-4242-9520-dd9819bf7f43@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 09:23, Krzysztof Kozlowski wrote:
> On 24/04/2024 09:16, Wei Xu wrote:
>> Hi Krzysztof,
>>
>> On 2024/4/24 14:54, Krzysztof Kozlowski wrote:
>>>
>>> On Tue, 02 Apr 2024 21:31:40 +0200, Krzysztof Kozlowski wrote:
>>>> Non-MMIO devices, which are BTW not really part of the SoC, should not
>>>> be within simple-bus, as reported by dtc W=1 warning:
>>>>
>>>>   hip05.dtsi:301.30-305.5: Warning (simple_bus_reg): /soc/refclk200mhz: missing or empty reg/ranges property
>>>>
>>>>
>>>
>>> Almost a month passed, no replies from maintainers about picking it up. Dunno,
>>> looks abandoned, so let me grab this. If anyone else wants to pick it up, let
>>> me know.
>>>
>>
>> Sorry for the late reply!
>> I am applying these patches which are in the following git repo.
>>   https://github.com/hisilicon/linux-hisi/tree/next/dt64
>>
>> And it is fine to me to go through your git tree.
>> Thanks!
> 
> So you picked them up? Why you did not notify anyone? b4 does it almost
> automatically. How anyone can know what is happening with the patches?
> 
> I will drop them from my tree.

One more thing:

Even though you applied these patches few days ago, they are still not
in linux-next (as of next-20240423), which suggests your tree is not in
next.

Please read entire presentation "Beginner Linux kernel maintainer's
toolbox" from LPC 2023 and improve your workflow by:
1. Properly notifying patch status.
2. Being part of the integration tree.
3. ... and more, as explained in above talk.

There is a link to video and slides:
https://lpc.events/event/17/contributions/1498/

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-144580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CA8A4801
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FF42836B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A0317C6D;
	Mon, 15 Apr 2024 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbYZU4oF"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7EC29CA;
	Mon, 15 Apr 2024 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162289; cv=none; b=c4OCiZEWH1XxkQ9vtjQDAVCLG+wQ251cKtUPJmm+3XSg3BP9J/lcz+Tz/MokdIIUhHwM6+ZuPNbwe0T8mk+NUas8C67Yb9eLbMGir4YoKKMMZhzTkyYI6dJyjTiqzbLN9Fq5FoiWmteOVUzw2r3vyHOPOOflAastCwFTg4Y+09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162289; c=relaxed/simple;
	bh=9ybt3H1KuQiMeFLxerqDcife3C1kJWRVy37yfC7vcTY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EAfVbcQyYQtZ0N7SWf9oPRlVTRGkxuIbGPtxXT2LPKJyDoCLQG0JzmVYVPWpo5nyKH8whUp5Z2Hxjf4l8N1GU1gJ+a5VIrcxGZO1keIuKl8fIZPE0sno8T/MOPv1gJry7omgvXYq4U0PA7sOKueAVmEfbntOrko5B+mAbtmtinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbYZU4oF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so3257673e87.2;
        Sun, 14 Apr 2024 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713162286; x=1713767086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWxWn+6WJ0lxmuDHoUFyZCRFehv/jNxy+CdpoGRzTMI=;
        b=FbYZU4oFvi8We0k+mYkRl+HP+U2VgFNMy9CQKTVGyn+kRSsC+gGCEf1pwR+1uWTGks
         ibnHpZnVzmUSczsT/ukcBHPZQST8Rcb3UWyTx6XrQqulcGRVWZqoXFOiGWtMZewTTSqn
         KtPjTsvlKddweFrwjips5BUgJs911wtCcRv4yKX1cZqbcgeDZF6qn1Y/NQPdPAeWsiY+
         EzhXnvNhPus72p6CoO1bLd9LXpIxdXUkEmRrrMmO/hW66sOyWAadq4rzYDSfTzJIvKry
         C6YU03oM6GlnZp6vFCFHs2ganI7OUpQOwHA4l1oF/0/fV+XPtcAJ2gI9y/+J0VJY7IMp
         p+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162286; x=1713767086;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWxWn+6WJ0lxmuDHoUFyZCRFehv/jNxy+CdpoGRzTMI=;
        b=ZNFwnszscJv4iA0lQ/C1x6An2NYrud1FiYjXBe328eCSIAVq2BKuZnRJDBThaeIhkQ
         J+3ImvCV1VmdX1lxW0jteFf0HqPHGUiyT9emfEduPIE3F2dD6W85xOEeWHX/s080BrAI
         WMZkzU2TLqChvNem66kGKz/2XSnNJVpHXcGEDS12VOMA0ollv6855nddhJEucOp4G1iE
         ZwwKKyeONAtYH8srwxrUUi5ApwZk8wxix+ASb3Cq2M8KZh2NRmiOD9dnVQB1kJUsb0Mw
         XZj+hmqNWdKqCYh22+jM1G/Sqfy24UNdiltLdnyg5oFlmrxC2etrY2G/M9JftxO4iV3e
         1oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWezLJxRnt/zC8FR2pBZ9XRlNy+bWppZNGRjV/vREjo4nZNJ9/cxD6IM6JBgNtBajr4eVKqY2fUsdBCbu1K1ofNt8g+kHzGbE85Jnt/lbcgQ9JsPTPat24KhcQcYPN+m2WHFCDkzha5Wfs214sG4V/6HCuUxak1RsmBkXWiPi3+PHV1jsDAlmKm
X-Gm-Message-State: AOJu0YzPrV7C0qGWUzlULp6DHnLoN10dJgBJg+iwbPDM6RK7Qk6c55pj
	X2DTK76TDmpxhrPgu4XyzEgbDjunPzWDDFyQiWKTa3PMd28lmd+0
X-Google-Smtp-Source: AGHT+IEQowzpT2zTQZdVl8OQE+0poRCGri5nhe5MP12UjrqnFWWC2eT16YHYf1ZcEU+WJ+/MD6GGGw==
X-Received: by 2002:a19:6447:0:b0:518:b47e:c360 with SMTP id b7-20020a196447000000b00518b47ec360mr2643459lfj.43.1713162286239;
        Sun, 14 Apr 2024 23:24:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id q12-20020ac2514c000000b00516d0c24008sm1186151lfd.306.2024.04.14.23.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 23:24:45 -0700 (PDT)
Message-ID: <63d3891f-98d3-450f-967b-c72b0516b66b@gmail.com>
Date: Mon, 15 Apr 2024 09:24:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: mfd: bd96801 PMIC core
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Fabio Aiuto <fabio.aiuto@engicam.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <ea49494429528cf8e60fa984ae1f523ddacd850c.1712920132.git.mazziesaccount@gmail.com>
 <b5eeaf10-e011-452b-840a-176c4f62cac4@linaro.org>
 <d3e555c2-e740-4aff-aac7-661877166399@gmail.com>
In-Reply-To: <d3e555c2-e740-4aff-aac7-661877166399@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/24 08:50, Matti Vaittinen wrote:
> Morning Krzysztof,
> 
> Thanks again for the review/help!
> 
> On 4/14/24 00:33, Krzysztof Kozlowski wrote:
>> On 12/04/2024 13:21, Matti Vaittinen wrote
>>> +
>>> +  rohm,hw-timeout-ms:
>>> +    description:
>>> +      Watchdog timeout value(s). First walue is timeout limit. 
>>> Second value is
>>> +      optional value for 'too early' watchdog ping if window timeout 
>>> mode is
>>> +      to be used.
>>
>> Standard property timeout-sec does not work for you? It should allow two
>> items as well.
> 
> I don't think so. We need sub-second units. Furthermore, the timeout-sec 
> (if I understand it correctly) updates the "timeout policy", which tells 
> the expected ping-interval. This can be different from the "HW 
> heart-beat" which tells the HW's ping expectation. Hence the "hw-" prefix.

Oh, I just found out that this is an existing property. The ROHM 
BD9576/BD9573 do aleady use this. It seems I've had some discussion 
about it with Rob/Guenter when adding it. Frightening thing is that I 
didin't remember the discussion or that the property existed at all... 
Well, luckily we have lore :)

https://lore.kernel.org/all/c390476e4279d8b75de53271e9fb8948d8854528.camel@fi.rohmeurope.com/#r

(I don't see the final conclusion in this discussion, it has probably 
been done on some later version of the series).

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~



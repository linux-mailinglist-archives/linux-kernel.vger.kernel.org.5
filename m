Return-Path: <linux-kernel+bounces-72591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0D85B5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5149A2810CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59E5D73A;
	Tue, 20 Feb 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGH1RGBk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFD5C918
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418608; cv=none; b=GRiERxX0KcXGU/myqN1OjsfwjLWHiD7F0kvsDQrjbdEvLbuG1+UGiKsiCJrSQtiO5UiRqWb7b1phmm48DZE8C8QcwpQTp37vUKFobYB8E0HSzSXalglRecSisP5u/xGzbPOGDdcBZ1T+3Rh3LEkEN1YyQd8oLQyAlaS/05lc+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418608; c=relaxed/simple;
	bh=+t4VwbrGo553hvc0/n5wxPqBQt8SYKPxeM/tBSQCuf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFEmnljDmH/Rl2nBv4jG5gVHLOtnIHpfZkN4SZUXSMWSfr+buyYacG7+AsVH7OO2HhhbgWnj3m8DwXi3OLZgXZmOaIgePXiOQM8W0HGmqLCGHziM+cdCqy/87JFfqWjoXo4VRj5qhFaKe/lWW3/MZ5G7APT5ItPMZETLJiRssM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGH1RGBk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4126fda8ef8so1581075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418605; x=1709023405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvOKZ6FnRVaRVe1Ql/pBOvP/3gu5W7cm2XGKLzU0Jes=;
        b=rGH1RGBkCDV5U7Zdv4RsFSN2yLuB2qxBc7tQ8nT/0hniMwCBEDhGNvcHcOtFHONZSP
         yYgll5wnUYFy6ZE1YWtAKAu4ez1xC1zlVYJfGMjVXJBBJjq4u002n8vvWqRCk9Tu8Jl+
         eWpae4SjB08TZ1/dowFz5RBIE3mFbYKUG71QSiTQXx+CRN0RK8QJqvMFURLGuxVbcNDP
         qCYpZJn8CAmRgV0AcD6Da+jCg4kQBnIU7EXwYHfBohP0cEH8U+jhGLSFSrNSmF/956uh
         hokXNngYNsPQmW70wGW7Etd+8Aa9VRA+bdsD3zAtZo0xqH80W8PVfq9R16myUdawRriC
         QHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418605; x=1709023405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvOKZ6FnRVaRVe1Ql/pBOvP/3gu5W7cm2XGKLzU0Jes=;
        b=cGgeJrTjcNbyXD+2p0BSPukaE8ogaZCfMue6qKZy++T+PlCkIgYBA2Blph8X1xRYaT
         xCN+NPauarCpMv9BIkA5ITJY9rbpoV9CVTQ97AUqPRicPfkh0CpleGzWHFLKgSg/Uyki
         32EToizQbYwsBTi7VJ83SvlmTck0FaoX8a+bqvrlDzTjZ9A0TCag4qTsetIQMuD7A49p
         jUxhKVoWY1fAQzASQWEJO3JSieyIHPt/RPpc1AIeW5ThzFD4STLxfySrmdmgAEkQxDjy
         II1L104Yql7olomQPcjYpM7tAxqU/S+jorhvjLgR7dQJAeaVdH2ONKwWGEIvzwGDj09e
         vDsw==
X-Forwarded-Encrypted: i=1; AJvYcCXVFH5ivXE858dTdfPS+8u2EBKSFhnIf62hDxebSqty+RGRnJ1z+T8JcoBk4/8Oyfd1AuCom6V3Nh4w3JTOAxs+KzWN/fuOuSOSYYne
X-Gm-Message-State: AOJu0Yyu3DzNx5MkwRD1Cv/wkSi6KfT/l6Cy27tFQg6HyivQ1e7dKY3j
	xDwGapwMowQFAd1cIK/1KzKnKzdb9X0i2xZY5KQOlK88qtNW2/2DwiBE2c3SuV0=
X-Google-Smtp-Source: AGHT+IHC8cvv39figdqKFr2x/5K8JqNBhDhnjLZkdTYqb0OQnDRB6RKw8IW4o1Opoo/z9ZuQp6+ZCg==
X-Received: by 2002:a05:600c:19cd:b0:411:d273:90e2 with SMTP id u13-20020a05600c19cd00b00411d27390e2mr13071167wmq.3.1708418605430;
        Tue, 20 Feb 2024 00:43:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0040ecdd672fasm14075986wmq.13.2024.02.20.00.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:43:25 -0800 (PST)
Message-ID: <e6fdfb54-aa2c-4c17-a5c2-4d12abf2591c@linaro.org>
Date: Tue, 20 Feb 2024 09:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Content-Language: en-US
To: Dharma.B@microchip.com, lee@kernel.org, sam@ravnborg.org,
 bbrezillon@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, Manikandan.M@microchip.com,
 Conor.Dooley@microchip.com
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 04:34, Dharma.B@microchip.com wrote:
> Hi Krzysztof,
> 
> On 12/02/24 3:53 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 08/02/2024 11:43, Lee Jones wrote:
>>> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
>>>> Convert the atmel,hlcdc binding to DT schema format.
>>>>
>>>> Align clocks and clock-names properties to clearly indicate that the LCD
>>>> controller expects lvds_pll_clk when interfaced with the lvds display. This
>>>> alignment with the specific hardware requirements ensures accurate device tree
>>>> configuration for systems utilizing the HLCDC IP.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
>>>        commit: cb946db1335b599ece363d33966bf653ed0fa58a
>>>
>>
>> Next is still failing.
>>
>> Dharma,
>> You must explain and clearly mark dependencies between patches.
> 
> I sincerely apologize for any confusion caused by the oversight. I have 
> organized the patches according to their dependencies in the patch 

Does it mean that all your other patchsets which contain multiple
patches have dependencies? That would be the meaning of above approach.
Unfortunately that's not good... I'll comment in other places for
individual issues.

Best regards,
Krzysztof



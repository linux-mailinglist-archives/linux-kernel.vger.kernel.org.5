Return-Path: <linux-kernel+bounces-73161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9785BE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E25282570
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77036E2DF;
	Tue, 20 Feb 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl8cS/aH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694AA6BB52;
	Tue, 20 Feb 2024 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438403; cv=none; b=BOSXdeh+/0bzi8MvTQfFs1IxGKWREm6sARBabuPTZr+aAizfX7wpw+b1Db5bormB19vN4Pfi/ZyJS/CYvaPVhOs0gOPO2dDHCRNS+PCiONMlHAgHWKXMyhw20zchbJSECKXPgPsfEpkccrelvUUsTQuOoLrZYUzYEwpXlc58T4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438403; c=relaxed/simple;
	bh=SQNT4WDtM+eSALNkzTuwmjYjyTJuqXjRoXvx/WDfrRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMehircQeQ77QXNCHiJ6y/Ey37DzWh1/USbxFQBSo3uLn+O0H/unJdevU0W6xhH96RvhzaV4VO14ZhDafvSqpFDA9/DFTigOENHrSQwYC81PKkLWD2PtnUAFsc1wqhM5TdMoPDERSO29kRp+IZIeP1lD/iRFGVGu6ys2iIfHgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl8cS/aH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4126fe50a1cso4235005e9.3;
        Tue, 20 Feb 2024 06:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708438395; x=1709043195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNnVm8RBCwAwHWhVSDTx1aqm83kYfI5s0paFuBAL2Kw=;
        b=fl8cS/aHiFtfZiABQXwpYvpELJ3jGzBNHwkY9PmsuiYF0W25ZL2IsAd7lEhLafBG0C
         y0+Vzsqcznu+4308KQNaXs3MwUJN96VVyUxj7uwDzqwtK28hqlIQ5rMwoP69N3+8AOVo
         AyhddS4N0xggOQaTgKe7/IWYBVuJEsD0OtbY30KHPtrA7l6HA+Q9oR+ZLe325lw0AfPo
         PhG4zoTm+sDtZgmL2ctvQsGH2eTq78XLoUtCMynrlKB0uZ2Trw2t+s+ED5q/mUjeEWM0
         xw5BhTzkl7KjZQCwygcoiO05wKh/TKpCmcu6qrq0lZ72l5s5p8rynzDxnoxWmzFlxeNr
         M7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438395; x=1709043195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNnVm8RBCwAwHWhVSDTx1aqm83kYfI5s0paFuBAL2Kw=;
        b=eCvtX4+hD9P//aT0K1ObZ9y3lYwQcsRWYxlrq6YNZtz9omnKtWBg+rohP2i19uqxRO
         L3N0DCZSvC/slgD+mCJ0oZaYPd7BjbJIMUeydQ/emEiL3Iv7z6fktcB0k4zgN9kuQPEQ
         OtcpOnJHxa8kR2COnelrDkeR1OAOISnBLI0A3Ybk66WrxpSRiu0wDx7/Sn8o3XyBwFwC
         AvYrDulJxgwwKvT57Qnoprav1iRRJIPtXfMMgXByK6F0b6Xzz9WG2AfFPn0rT70m8iG1
         hdEyCDqIQCJQVcwiIDKvkUWAp8Rjb20+SOjDy/1gU5L+p7I02k/jxM4/SZa6xHPIyokv
         BCvw==
X-Forwarded-Encrypted: i=1; AJvYcCUsqLl1K7adliHDS5rYGKvX0sgtxcX4yOyhpKFxC9z1VbYzHfFEcrNP2Sr/hWP8w3AzALINQZCmf/Hxepz25Lp54bwSjjdHK/yu8i8DjD9I+6etVQR1dxp7QF0BerFgUUzX6AmxfKnPCIi7y8pZ0BjgzZKG2YDPApdEOMIYMybCZTmDaUO9ddkLzr8fSRm6zladbbIYMLOdA1Wvb0cCtGU=
X-Gm-Message-State: AOJu0YzpLm5PP/S4RYcAdWElwXX5kJAH4oZ2MJXXJre0fDTGVTDbpC5l
	45IZwATcyf8rwhvoQ6PPxioK9l9qbIqM1dBSEAtSgQXVOC6yUHNT
X-Google-Smtp-Source: AGHT+IGGeYl41pus6J2yn4NLncmdAMk5F9pQf8d8ycy037wTgk0pJLMhPCCMaNzBP5893WJgnAe1oQ==
X-Received: by 2002:a05:600c:1e09:b0:412:457f:7094 with SMTP id ay9-20020a05600c1e0900b00412457f7094mr10046336wmb.29.1708438395165;
        Tue, 20 Feb 2024 06:13:15 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id jp5-20020a05600c558500b004126732390asm5840809wmb.37.2024.02.20.06.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 06:13:14 -0800 (PST)
Message-ID: <001d1e99-5d96-44f3-8695-ad2ecee42128@gmail.com>
Date: Tue, 20 Feb 2024 16:13:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/3] iio: adc: ad_sigma_delta: Add optional irq
 selection
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 David Lechner <dlechner@baylibre.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
 <20240220094344.17556-2-mitrutzceclan@gmail.com>
 <ZdSzCe2cw8gL3K-W@smile.fi.intel.com>
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <ZdSzCe2cw8gL3K-W@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/24 16:11, Andy Shevchenko wrote:
> On Tue, Feb 20, 2024 at 11:43:39AM +0200, Dumitru Ceclan wrote:
>> Add optional irq_num attribute to ad_sigma_delta_info structure for
>> selecting the used interrupt line for adc's conversion completion.
> 
> ...
> 
>> +	if (!info->irq_num)
>> +		sigma_delta->irq_num = spi->irq;
>> +	else
>> +		sigma_delta->irq_num = info->irq_num;
> 
> Why not positive check?
> 
Considered that selecting spi->irq is usually the default case, so it
should be the first branch


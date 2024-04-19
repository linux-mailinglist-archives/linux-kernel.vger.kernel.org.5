Return-Path: <linux-kernel+bounces-151024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AEE8AA813
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57E31C2159A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013941078F;
	Fri, 19 Apr 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiLc8h1z"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B49C127;
	Fri, 19 Apr 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505721; cv=none; b=BfeKzIWq4149twAwQ8ifqo1N+IFDdsk7C77E2HE1K3UbIHeDUmq1UispjQNZWaIFu9Tkx77QXc6VLvlKQ79shvXdzEz3i0hDJ9e2PLYqTgJVD4KPaHw4WC5fnFjRq/Dzlk2LWZj1/Qnuk6re0q0Qx9M0Ycwt1HcE41jhcQ8fO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505721; c=relaxed/simple;
	bh=HlnIXS8pM3ffZ/RvmET8aAuoWI2SeR20JxIsTBt/+Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vs1CmzAVDQZDrB2DV6U8SechEkYsYvZjL/5sdNPOLNmzCPvjne4uV6Q9Uh8AGaOqgMfcs5IbgG4Jei1flPDQk0AB690iEyCTZyYI7wRkYMmMQldJGXgsuuFly1UQQIQVRAwF6JbDUOqqEdeVFU9vsqZiPhEGG7ZCk/VWRAFaZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiLc8h1z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso59064e87.1;
        Thu, 18 Apr 2024 22:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713505718; x=1714110518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5c2Rhg4mgS4eH1ovISMs98g6pb/JQ+nRM/lpp4nqnQI=;
        b=EiLc8h1zL8F/SYJBpYGcWFQh7meRFXhhj13YmgxyLW4/zUPxNqaq9zw9adDgE3fhtJ
         4dm3lZUTswYoHP4rwJ1Fx/v2QZxezCXG0yv/C93s7F3OFPw/xBAsBFAWPzVEKrbRAjGZ
         pynHgxpZ1jpbu5atD27jszbvpJCKZdMP7tk5h5nVTtoN2xwX5vueDwXdopAXNHbQev84
         5f009dSxIvkXxkdZVHZKYioDPwvy0+9XPBG7aHlsn53zGHTSPBwuZlAJL/IR1Awq/0vn
         R1gCszbZsgnnabdvrSKj9gOhMVbq9B3jbRs2DIb1xYpEdQKnFuI2ZF0QevveeUBA2pGB
         Jx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713505718; x=1714110518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5c2Rhg4mgS4eH1ovISMs98g6pb/JQ+nRM/lpp4nqnQI=;
        b=W99RZtr54ZMC19n4amb2Ry5DYf11BY81Bg1b5l/UslQNSb3Rlhn4zXRTJnXjEilR5M
         Y7Q+hYjkuGXByXRmpXvE1uk0Nw5wlKtHTlE6eOCZvm7Md3sx81fg/R4iQk5HHKpmNfl7
         SYYVcum24KDumRiZO93OH0ks0r7Exix8HlowmT7sMs7nIbOY7oicca+0jY/a3xE5ULJg
         9RmlQSJElj+nDlwxXe6s/XKmO1rXsLR3SxNpGOAtUpKLP09V8WzveHchraZAgRZrVViR
         wI1rh+ogTkbGP42qQjNdgSQIiRgp09d4e52Pw9ogvE+TyF5ED7o1lxmHOM2Z9WaTYTW0
         ceFA==
X-Forwarded-Encrypted: i=1; AJvYcCXootP+TkbGmY4b3TGJQio20/E7ox6HHQ71k7Jz7/3FuPixUHs13rOEKpi1WVOSEwfMvOwN7FIyshCbAHhMUSbuu3GZrNuYJDmbq/VVwEMt9duuQw1pEaOaew78q+fuz6mcMyoOqnFHF+QabSPpQUuA4WBZp85a6AxfT/6/8JYfzlNU0HEQSv9O
X-Gm-Message-State: AOJu0YzmbGTjgsYZKPgkTSq+HqhBO7Lhb2ihLYOJr/AysAqrgXfpZJnl
	cbYHmKl6w45hqinbcDr+Bh2x56K4SMusjT6aeZbI35U5eVAJBOAY
X-Google-Smtp-Source: AGHT+IEdcyybcHYAP3yMpgWtqA9Atv2L/pwyITTXmjPJPeVnp2PCxQKjGhR1B1FVx+YcDIC48dP3Tg==
X-Received: by 2002:a05:6512:3082:b0:513:30fb:d64 with SMTP id z2-20020a056512308200b0051330fb0d64mr950308lfd.44.1713505717640;
        Thu, 18 Apr 2024 22:48:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id s19-20020a056512215300b00518c1387e6esm550580lfr.64.2024.04.18.22.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 22:48:37 -0700 (PDT)
Message-ID: <8622b4aa-1693-4762-b415-61e1b927efe3@gmail.com>
Date: Fri, 19 Apr 2024 08:48:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: mfd: bd96801 PMIC core
Content-Language: en-US, en-GB
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
 <7541fb24-894a-439e-8f9a-b18f04e06afe@gmail.com>
 <675cd641-7322-43d5-a33a-7f0be48c380c@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <675cd641-7322-43d5-a33a-7f0be48c380c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 20:28, Krzysztof Kozlowski wrote:
> On 15/04/2024 10:28, Matti Vaittinen wrote:
>>>
>>> Missing allOf and $ref to watchdog.yaml
>>
>> Huh. The watchdog.yaml contains:
>>
>> select:
>>     properties:
>>       $nodename:
>>         pattern: "^watchdog(@.*|-([0-9]|[1-9][0-9]+))?$"
>>
>> properties:
>>     $nodename:
>>       pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
>>
>>
>> This means the watchdog _must_ have own sub-node inside the PMIC node,
> 
> Yes, that's a bit of a trouble.

Agree. I'm not 100% sure why this requirement? I guess it is a bit of a 
problem for many MFD devices with a watchdog.

> Then instead maybe just add timeout-sec
> with maxItems: 2.

Nice idea. Thanks for the suggestion, I'll do just that!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~



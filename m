Return-Path: <linux-kernel+bounces-81133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D28670C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F6028945C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDEC2C18F;
	Mon, 26 Feb 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwAwrajB"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFAE1CD39;
	Mon, 26 Feb 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942136; cv=none; b=eo12v/rk2O6HFfwINks6ThpYyaGO/Xp5n0tVd2LY3aNmMMtsQ78E0FrWThsSwG3zLCF9/TIPMQXU/c3ZJ2MVCTqmDGsW8nh+2JZDykD6dSXe08s1bzimiVjkwv69Z/PUTGmpYnKX9uA4Yb5Pmncmqs7Kv5U0zbPQkxS0wYDZCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942136; c=relaxed/simple;
	bh=uqLS03IoInvWNidwN+ZlNlrEZa8bvo2yjHOvhtrlXVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtaX1bEwhWnCKrCkvn43YmhUi+QzjqJljcqQYwg6fMmLpN4T52zc0nQ5IZ6KT3c3FdhW5DrFY4P+bccUaKgs1sUz1m5a4HE7QoRsolvJJS+ShgHxQmflprz2VH+C5A2gMRxt3raXUU5VpzcS0LawRmNVN2asUls3+AIjVM6OK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwAwrajB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d28464c554so17232731fa.3;
        Mon, 26 Feb 2024 02:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708942132; x=1709546932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otUebX+7GsI1tLV4gJo2QwLDS/8XHJF0EtxeLNPIl3I=;
        b=KwAwrajBOxrOw+6MSoYIe2m+jpgrIBqSDBn1u2Qnn35ALTqEE+zmmv+2Da1+QzEN/Q
         GYtnr8PjjyydaiFvN8Qv6q2jaLwdvcLVnNKikFfKy0ZC9f8LiuipcV7Djr78tBk5sBWy
         p/Zb9N4uoyfab36Uy1S+dZYUfqM3nTnv0q5Y5mFIjEvdffoUFo7nFeKW4NVypdZtlu8Z
         ZDcbtLZfgE7nB65DaWd5mzCPk0geSGoEs3lWx12x4DqN0H7QynE+RfFtS/yJkEecgQA4
         7yQQMmUdfxuRu1oQBA/j+wiCSLPo6SJxbVdM+/ANqw9wJk3Z6hrSKu36Q+FTq93EzUAK
         sMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708942132; x=1709546932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otUebX+7GsI1tLV4gJo2QwLDS/8XHJF0EtxeLNPIl3I=;
        b=lyaEJ2ME5/JF5Aw0za9tq1xKrq+fpqEx6BYCVw6ZULBQAidf5nfRRdK9vZA7+wbrBT
         ut9S0D/hkgFvZQc1AoOD2OmUGVwmIrjC+iGqzsRZcVIIE98FV9AFA48Cpc2zTDgq/X+L
         /FdQsZM+pPH4L5Obr38QaB5kDy66+J0mDlqccw2X8uLaUHb2Z5/0XSYJtEikPpv+zEnm
         XxMo+p6n+/PwEYsPKHC7JXgjtIREh8+ZO3QDf53XPFk77qO3zHxZVC0HqNsjzBnQRju4
         l60EmsJ56uqB/IYru686g6o68/hVk8u23E7hdVTz1KNdTvmcOkjNhaz6rr0zBonha0Ji
         kdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1mpJR30KoA4+8FSP6wnosO1QlVz+yNFbDi2nRTlRWslMos1iAsQvBr/gUpx60wMvmaggDjCUfTKLo0aXdc5jYWyrwExIVY7mV9301A/vZgndFAxnsKuo0eYzItMR7H8KvfpCAlwf9gA==
X-Gm-Message-State: AOJu0YwsEH93EA02XnB7GXh53y6MYGH6M8b6tlsk7xJoZhOBaSwrPRMr
	CxKpn52k0C7xEhcAMLud9yH3BmZTMXFCEm/mQ7rdMdHm+Wue7Bnk
X-Google-Smtp-Source: AGHT+IHjaCHb+GrSNwOJOmtyQHnKRbUT3jlBXdZcTX+9xBWhqvsdiapJnnN/0yWuMjY7DqU1gaeVAA==
X-Received: by 2002:a2e:2201:0:b0:2d2:6c74:58d6 with SMTP id i1-20020a2e2201000000b002d26c7458d6mr3597981lji.44.1708942132372;
        Mon, 26 Feb 2024 02:08:52 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id m22-20020a056000175600b0033d1b653e4csm7741794wrf.54.2024.02.26.02.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 02:08:52 -0800 (PST)
Message-ID: <5fdcd8d3-1793-4f82-9e35-a3b2fd18c2e7@gmail.com>
Date: Mon, 26 Feb 2024 11:08:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: convert st,asc to DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240225100336.34122-1-rgallaispou@gmail.com>
 <174b85c4-107b-44ea-af81-4564101aa5ec@linaro.org>
 <4a1504d4-6c64-4385-bb52-43d39a017215@gmail.com>
 <934c476c-dbe6-4266-8821-ed401e63a004@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <934c476c-dbe6-4266-8821-ed401e63a004@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/02/2024 à 09:09, Krzysztof Kozlowski a écrit :
> On 26/02/2024 08:38, Raphaël Gallais-Pou wrote:
>>>> +
>>>> +allOf:
>>>> +  - $ref: serial.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: st,asc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>
>>> This wasn't here before and your commit msg does not explain it.
>>
>> Looking at the device-tree I found that every instance of this device
>> refers to a phandle of a clock.
>>
>> Moreover in the driver of the device, the probe fails if it does not
>> find a clock, hence this addition.
>>
>> cf. drivers/tty/serial/st-asc.c:701
> 
> Commit msg should explain differences from pure conversion and the
> reason behind. Otherwise how can we know why you did it?

Indeed, I will change the commit log.

Regards,
Raphaël
> 
> 
> Best regards,
> Krzysztof
> 


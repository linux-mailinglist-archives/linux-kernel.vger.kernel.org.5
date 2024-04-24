Return-Path: <linux-kernel+bounces-156992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F48B0B53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FAAFB25895
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E91E15D5AF;
	Wed, 24 Apr 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="NNnxgOV+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A015AABA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966028; cv=none; b=jisbLr/PCq7tXzI1VqxHmiYolbINUHH0H9SVsmttMaxpStCd0ab9GDFFRHeq/50vd3iSM4Rl1cKU+IzDWR3w3K+S2Xl4VcOAbMKZAtTUl3b6b7WsUIC3+/H7ds+Mb2MiS9tx6K9H3l0SdT848DFidylshxQZWE5WELFxIZM8nfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966028; c=relaxed/simple;
	bh=I2A//Dk/vBjLl7T5iGDpWDK7BZkYUxkQfGgZDceQaWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaT33LedRj6JYB29jrXman4aF6yhySfvV0oNPvXx4ZJSKn9tESBYgLNr87QFNqRvYUtaKgARzHG3uIM9hj+pqFwfW5+PHy3OQGFgqA5uLjRaMyP7vX0qV2xcU64uHCK8am73JfCl4RBx29zrv7jjfjh8OyrZKvDHZzxP3K0JI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=NNnxgOV+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ee12766586so801168b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713966026; x=1714570826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJTr0pS0+pBhQrdYz+DCxZJiknMJew6US2gBKZp5jg0=;
        b=NNnxgOV+b+upddHwUfn7evO7ClnwTgs3JZ3Q5wzDKWkUV7xA1PMZWwcljvAxsHws3k
         I/upEc1C/4ZmH6y3WuE+V5X0kymi4MX9torosH5D9uQ9kDH5BiC8L/3Axz5bHigmam4C
         GBAYf2Ux3ME8SqRik4Tv9wEpwDxhyCLV+qIzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966026; x=1714570826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJTr0pS0+pBhQrdYz+DCxZJiknMJew6US2gBKZp5jg0=;
        b=vk10QprsNb+5yGRJVT6icm+VFV22EC6w4W1Cc7QOnHQeryOMwFsZGz2gs3Fm9C4QkE
         X0w5T+0pRJ24WP9xgd3ziBXCY0qBizVSnpCpUrNyrLN2oJ+bTXjbuH8D6BMM2zsdcLSC
         5R2yjKlmFg5HqwqEftCWe6IiLf0veUyI+GgMEkdpdFpXCLD59snXtSoMF1UxBBDpZZH0
         6pbvCf5OFCeRmpbmCOSTcamfxEOL4OEqtR2HVfyttR1lXBtDFSp+zJ7RqiBNFQhsg3tF
         lQ1hEoh9iw6KAjZ4Y/v7kn+N1Y2H5yQnH08375O2dM0hrDNvg2o41wl7SAF4ZtknpUhT
         XANA==
X-Forwarded-Encrypted: i=1; AJvYcCVBAlwTlgcu6NuPWLgN/NtCuiXwTF8vjPAhX3YnqZ/Wt01/aolxp0ZVlUCMAz9QN89LAe/y8/rCWISiA6e1FOxyOG/g6ljQz9OZB7Yk
X-Gm-Message-State: AOJu0YwE2R8gl6nS4mIZd643Ugw2kP6ZTuLnML+EC0xzPZ8l6QzCf4P6
	MCfeZUxJ+7oxY0sUIT+CJnqb1qIaXTTcnePqNIaEJ46hBekgKA7E4s2OzIKMCA==
X-Google-Smtp-Source: AGHT+IFIfpJMclSpyaqVixt8fNkXf3bVerhtpzCCQCYHw9tn9Ap8cn8nMs6xRuG89HGr3IACEMEtcw==
X-Received: by 2002:a05:6a00:4f86:b0:6ed:41f4:1886 with SMTP id ld6-20020a056a004f8600b006ed41f41886mr3516900pfb.8.1713966025910;
        Wed, 24 Apr 2024 06:40:25 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm11258888pgd.56.2024.04.24.06.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:40:25 -0700 (PDT)
Message-ID: <854acf89-43a4-42f8-b8ea-8f0c108f3aec@penguintechs.org>
Date: Wed, 24 Apr 2024 06:40:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
Content-Language: en-US
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
 <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
 <0e6bc9af-71f2-46b5-8b92-5da674b44ad7@quicinc.com>
 <a45016e9-1668-40eb-83a1-7a62162e319a@penguintechs.org>
 <97ecc6fc-6b0e-4028-ac06-1952f133bd2a@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <97ecc6fc-6b0e-4028-ac06-1952f133bd2a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 6:36 AM, quic_zijuhu wrote:
> On 4/24/2024 9:31 PM, Wren Turkal wrote:
>> On 4/24/24 6:22 AM, quic_zijuhu wrote:
>>> On 4/24/2024 9:18 PM, Bartosz Golaszewski wrote:
>>>> On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
>>>>>
>>>>> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
>>>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>>>
>>>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth:
>>>>>> hci_qca:
>>>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>>>> power_ctrl_enabled on NULL-pointer returned by
>>>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on
>>>>>> errors.
>>>>>> While at it: also bail-out on error returned when trying to get the
>>>>>> "swctrl" GPIO.
>>>>>>
>>>>>> Reported-by: Wren Turkal<wt@penguintechs.org>
>>>>>> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
>>>>>> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
>>>>>> IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>>>> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>>>>>
>>>>>
>>>>> Like this?
>>>>
>>>> Yes, awesome, thanks.
>>>>
>>>> This is how reviewing works too in the kernel, look at what Krzysztof
>>>> did under v1, he just wrote:
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>>
>>> v1 have obvious something wrong as i pointed and verified.
>>> so i think it is not suitable to attach v1's review-by tag to v2 anyway.
>>
>> @Zijun, your concern is that current DTs may not define the gpio and
>> this will cause the bluetooth not to work?
>>
>> Would that not more appropriately be fixed by machine-specific fixups
>> for the DT?
>>
> for lunched production, it is difficult or not possible to change such
> config.

I am not talking about the DT in the device. I am talking about the 
mechanism the kernel has for applying fixups to DTs.

If a dev builds a new kernel for a dev and finds it not to work, the 
kernel would then have a fixup added, like described here: 
https://docs.kernel.org/devicetree/usage-model.html#platform-identification

> 
>>>
>>>> And mailing list tools will pick it up.
>>>>
>>>> Bartosz
>>>
>>
> 

-- 
You're more amazing than you think!


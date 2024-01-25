Return-Path: <linux-kernel+bounces-38221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC283BCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F9A1F2CD16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C071BC39;
	Thu, 25 Jan 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mE8glqlZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252245C1C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173164; cv=none; b=MlBTYUBj6V073Fn/EqboL1Se86twleY0Ong8NvD1GSn5/cXY8Is71wDWAR5FvtbhOUYK5F1F94Pk7vPkuBaHUGhdnX1odx56z9vLNCcRtoOgi4x7Z3jBGqCQhiTuPRTLpF2xSVOd5NIdekTgir8gU+CTL0Wl+I7bdGPDeQD6Qwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173164; c=relaxed/simple;
	bh=tlx2ckEz/OH8ARX5IfGa/yGe/4FJ1kSmrm3PuJXNAFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHIC0yAx0FWtcg+ZmRKlav29LBQFD9rqWy5skMMsPAn6dL+OEBXs0RkwiWXRR1gPeb5dANCxneklpkfmz2XNOB/cif04gwdfcMPiodHUnzrqcG4zKvVV/A2GGaa7QUKxVRMOQ4FE8yT/RqPQQlxwev2Y0dqlC/Jl1wv6ANWAw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mE8glqlZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a31914e7493so22165566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706173160; x=1706777960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5p74A015/6G4sVWav+jkCsMA3W4osbHKdYXmaTePMgI=;
        b=mE8glqlZF15PXnpqJpCKDRvzS4Z0xFbF5XKwObCqNXtx3Or86HiyFDOFAv8661VmDN
         eYu0bjipW9PYB/rb8iEYF2L8/b400FpZQoTw7p4qvMak8u31VxzRQeoITdwcT4WTLK3P
         8mdc1JvHKdeRqI2QC3tcApO0lTEJerwDkRfTP/R0cM+VJucHVcpTanwqYrZSTuIPOlVr
         dVoohFBE20QZbaE4hemi0wtkiaLX8I+Tv8GbHfnDLxKBl9C9aQGKtrGwOTQlHO/0LqFq
         Tt4b1BHHDGtuMH5Q5tdH4zmnsNj1RzgzSF9Aaf67AWKep6Ygy4Qxho7xJk4obTPzwD2t
         IwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173160; x=1706777960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5p74A015/6G4sVWav+jkCsMA3W4osbHKdYXmaTePMgI=;
        b=Q/ub4WAblpmfEtK6Z7Yjq0wlJHvFSMFN09rfeEFThGkrkhJqDpXnA65m/M6L+cycjg
         M031vNsSzgVzc2L4V4Jy6GhIFp1RwjQjPLu3AawCjIoLoMN5mTOr2S4wIbL5k2kWlDM5
         lP9KV83NgwUyQbjrDNZ1tBAiTcWxAEt4RUqwONZ12iYi7hhmNCDBe58OQn95UQKQP8E5
         eWXssG8C6uvkhs0Z4CR/dw7mEaRTrQ20xGT/z32VVX+t+bOuma5nmXHSwoQxBXrBADOO
         4MXZ9OXb3G2o1MHkVTeWw3lAVDgP1fAeyUyND69FlUFAWZfOHFjvXWv/QRMkvWZ8cMr/
         i3oQ==
X-Gm-Message-State: AOJu0YzJ5ShB56us4BUu/shVaJ9a3YdcMUX7DkLYJ7S921BVNGPYOs8/
	vW5oP2ULaucrPwY109ODKxwwc6CRE7knzMNb3BYIF5+YhhR9CEPAIp1uba3OI0HAhZ18OhHS4s6
	Z
X-Google-Smtp-Source: AGHT+IGqKUDCk+I6oMdp9KhcBiJXA3dZrcl4Po5aSnDqvlSXnfafDFROcN2I8d5qV12NRki7/mtQnQ==
X-Received: by 2002:a17:906:890a:b0:a26:edeb:7635 with SMTP id fr10-20020a170906890a00b00a26edeb7635mr250672ejc.91.1706173160396;
        Thu, 25 Jan 2024 00:59:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id gv21-20020a170906f11500b00a28a66028bcsm794592ejb.91.2024.01.25.00.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:59:19 -0800 (PST)
Message-ID: <a3d24e7d-404e-4c02-99a2-8838ee7028c9@linaro.org>
Date: Thu, 25 Jan 2024 09:59:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
 <CAMRc=MesG1nYSxx0osmQEEXCvs-6B4s4=TFYW5wD8pOXpV+OcQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMRc=MesG1nYSxx0osmQEEXCvs-6B4s4=TFYW5wD8pOXpV+OcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/01/2024 09:36, Bartosz Golaszewski wrote:
> On Thu, Jan 25, 2024 at 9:16 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Add empty stub of gpiod_to_gpio_device() when GPIOLIB is not enabled.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 370232d096e3 ("gpiolib: provide gpiod_to_gpio_device()")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>  include/linux/gpio/driver.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
>> index 9a5c6c76e653..012797e7106d 100644
>> --- a/include/linux/gpio/driver.h
>> +++ b/include/linux/gpio/driver.h
>> @@ -819,6 +819,12 @@ static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
>>         return ERR_PTR(-ENODEV);
>>  }
>>
>> +static inline struct gpio_device *gpiod_to_gpio_device(struct gpio_desc *desc)
>> +{
>> +       WARN_ON(1);
>> +       return ERR_PTR(-ENODEV);
>> +}
>> +
>>  static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
>>                                        unsigned int offset)
>>  {
>> --
>> 2.34.1
>>
> 
> Why is this needed? Users of gpio/driver.h should select GPIOLIB.

The third patch shows you the user which will not select GPIOLIB. Why?
Because there is no hard dependency between one core framework (RESET)
on other core framework (GPIOLIB).

The first two patches are added for the same purpose, even though there
is no need currently.


Best regards,
Krzysztof



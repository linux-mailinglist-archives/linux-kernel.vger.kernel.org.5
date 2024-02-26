Return-Path: <linux-kernel+bounces-81463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D98867648
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9470A1C241C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A4127B61;
	Mon, 26 Feb 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiMLTKYZ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B027126F34
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953485; cv=none; b=baaMLjrmDrSqCUS3hLcStN/Iw/M7pJh7piJkfTOd3m8acd1vnOOIrqd7lUgt6l0DKlBo+VbSh2ikLUi8gmZtyb8fDFimxYUmyFC9tBIvZ3ZGhhd4MojijS3TUKYs7was9V3phojHrQjiCUQfzhsi4KNMW5MU3FJZGkq7FpPVydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953485; c=relaxed/simple;
	bh=lqyq54iuxbpXv8VaMiy8ywiu1AO2bm42rLVAedmCbh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKIfKJqQj/p3XoCObAXSw27sTW57hWnNoHdRU7vrMfSBnAFX+fYAnAnoSbuVn68Y7M7OoMuiN2WYSJxKjWsSlfdb6uBw+F7YdSojLOBQ7qqXzLeSJfuqBkRZdP5a1aNZMyopg+e+zjrhcQEmD6ILD6BpFLZrLvmtIZw0aYBA1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uiMLTKYZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a43037e40dcso211855366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708953482; x=1709558282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRtErTJRQtHI/SD+5G5muWT6HlUCmDLLerzL9VLw1UI=;
        b=uiMLTKYZ8zUUeZ11pGVPWAlAk3MBhGwnGOuIohmqGZd/mpuj3SbdseqcF5VRXHrBFs
         pE2cjcbR2EU0Y2zXlzfyoHKQeePSGRp04GyTJR+XitBG9t4G9AmnHCH1zj19sW9OF47E
         uIvmt9nHJZEuWmZ8GbmwjdousC+8OTpzUpW2obkxjeqO8kbdyvkvNBolkcm2fNsaG51A
         JxZ6ebOfNU0Pf3xFKbIucmb5SS56BHYgTRjVJl5N0IY3SY+ymAn+3Vp/0Yx8VDb/XgGi
         s3k0JgAfyAGqi0AzBhSzqImxEBcSl0bsnIIjt0JuLFZVbJpGqE2+ns2tm1UOG9Q16A2v
         Unew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708953482; x=1709558282;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRtErTJRQtHI/SD+5G5muWT6HlUCmDLLerzL9VLw1UI=;
        b=syXCA3fi2yBLErpIWQ1uKq0lcOyaZ6J45z5XhAhT43KqMwLzsAGXuWE01HtLFDs4wg
         TAdh89eEwEEP8KkPDvhfQXjz4i1bCCzsHFnwqmXh73RMZd4S0rJ5K5bNWL6M8K+wZKjo
         q+VfgcLylkwPT2W7Knd4M61LewlD92ZVSCKC3AsuXOBBWgZBvn8IXh78jNvdbQ6vjdgs
         I9rqnOA3duBxHnNeRtyIhoCKHM2qO2sOYhRa1iFHG9ptzIbqS+1FO9klGqq6VpQAn6XC
         KEB3Bm9KS79JzBqsqllcou4pKuQYLJEJxROKuF4RWXslmSQfrUXZ4QpJQIpoDnAmgqdm
         AdhA==
X-Forwarded-Encrypted: i=1; AJvYcCXg9JoY53cURttEcJ4gJYduXxL9Ee07ox0Zi5wPN3nNOLHMy1WzVpOK5LwGEP8L6hDY+N2VCZCNsykBT1bIEVlLVGpzAHt+klaSA6Se
X-Gm-Message-State: AOJu0YzvFBaL+pzgXaM+S+gFI2Wp2VZylAtD/z7a+azjs51uD0QCwgR1
	vZx78pmfQMIyjSzxXBbSKjrM9dGVvt8xJ9AteS6U1BXQNqaZIRwr0QizhCaU3p0=
X-Google-Smtp-Source: AGHT+IHcCjB8FMzYOYKicgl4ilY+tx7Xz4BgivIIXMtjUaq6WDbM0Ra34o6NQf433FxWFv4YUbfbTA==
X-Received: by 2002:a17:906:6d8b:b0:a3f:dae9:1e88 with SMTP id h11-20020a1709066d8b00b00a3fdae91e88mr4662199ejt.37.1708953481986;
        Mon, 26 Feb 2024 05:18:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709063e0800b00a412d3d509fsm2413787eji.181.2024.02.26.05.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 05:18:01 -0800 (PST)
Message-ID: <29cc9d21-6fb5-40fc-abba-c0913cd175af@linaro.org>
Date: Mon, 26 Feb 2024 14:18:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: add
 spi-max-frequency binding
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, hns@goldelico.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20240221174305.3423039-1-m.felsch@pengutronix.de>
 <91f29265-36fd-4d0e-99b1-61eaada59601@linaro.org>
 <20240226124036.zzj5p7tlubc332r3@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226124036.zzj5p7tlubc332r3@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 13:40, Marco Felsch wrote:
> On 24-02-26, Krzysztof Kozlowski wrote:
>> On 21/02/2024 18:43, Marco Felsch wrote:
>>> Make use of the common spi-peripheral-props.yaml to pull in the common
>>> spi device properties and limit the spi-max-frequency to 10 MHz as this
>>> is the max. frequency if VDDIO >= 1.62V.
>>
>> The example uses i2c, so I would expect to see in commit msg explanation
>> which devices are SPI devices.
> 
> All listed devices can either operate in I2C or in SPI mode.

Such information in commit msg would be enough.

with the changes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



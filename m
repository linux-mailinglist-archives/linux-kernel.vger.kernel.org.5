Return-Path: <linux-kernel+bounces-59073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B584F0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE9B290DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095B657DE;
	Fri,  9 Feb 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyM8r8wx"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F3657B7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463996; cv=none; b=C93GHCsFkR33HN00WvXHMkH8CsInvVcH1imspUruwfWoQRW0Vb43MOWGQ7MdPElEhh+RityB8DtzI46tei0nQEMZ8c4L/6SnDJdQ7Lajtm/BmSTOfXOqrGCZ7nmNPUbhyNMavi9CKxMGz58ymtFrRNUqZ/h5bpfaGemPb18aAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463996; c=relaxed/simple;
	bh=qUgnCv02AqFoVGHUvFtpLza5eVa3gjDOpxMSlXLPB+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0t/UQLIXCbl/bZVWNwXYmugtZREKwDOYdrZ93+l6OdxGxu/7U+ThUA5zq7k6d99K87qj7uZEm91/J/Zy5mldV4lfQCHsJamPq9au6EacIh1f8MmMH7Us3c0ElcszXAXznzMsDUPycHHsXCtWhOxkXJE3MtKv4CEncj9dY0ae9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XyM8r8wx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41059577fc1so5386945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707463993; x=1708068793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whYEWb6AiuOh6o4SV8A9fmTcuk9/RFPwvABeVLePaDQ=;
        b=XyM8r8wxBJpqZWEcISM7oDKflEjNotCaxObLxk48/t/ItmQNACZSDwm3CCxVGtMH8t
         6l5G3N/abRo/K32xxJCjqU2Xf9wk+VBEnsi63PSh9RbmIK0lKd+x1cPASVKRELd2my4n
         IYan56t9hSs8Gb3/nRU8TVZIvV4iiQtaNBgse2RoMn/UHbt7+7kybWhraXKgx3/3Doe4
         5F3bq6RZCYRjh6EeuezRg3q55ygbQTJN02gijNtapjp/ZaaMrKajwyrQ4hb6werO0CEK
         xz1FUYjvAgo6GV3/XBl4jCDpjkASeC6BHnatBWzEs7XoqufH9MBpLE2LGJRPSYo9WiFI
         N8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707463993; x=1708068793;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whYEWb6AiuOh6o4SV8A9fmTcuk9/RFPwvABeVLePaDQ=;
        b=TXL2n6hAV4oJPq0LVvNJU8vQ0rybjZDQwZFTZWBcLL3z0hge7BehnzBY6eIro8srkx
         3TBTwbzdTfr2a2T16xanuuOESUkHdxJV6AgTAAVKHiqod+wdKqwUgnOtafxBlgUJ2D1a
         Fg6tK9FfaRPXmzTjLoONBpi6zVeOleNLJ4cRCC5Tz7WnT1Scr+9VSQIxxwg0zPilCiKD
         l9lW6xmymuJQaiR7drQDpZXve24ZgJpNfyTcn0daq4Txj5DfAgDOOiM3WUyVD6CvAYSp
         kFe6WJL0/yYKvcr1hI2x/7IitPL/Nqsc6EWd0BvmQDE9v6PdNbBlJDEm1O14O7BelXSu
         Gohg==
X-Forwarded-Encrypted: i=1; AJvYcCXXhQ+JFcUvcETLKqMOytU9ZLEiIJEZZb8UXoVr6jkfjzjZXeZYBIoVC816fldskA75TUfwZJAfUbuxw2+cFjKkj+EVikMhaw+avq6A
X-Gm-Message-State: AOJu0YwqpBrONPWMVpN9Eq1uxH5xQkwjOUrgWzP/NyPiRP5xhXz622Es
	L0MqD5qEEJ64xkQT5jP07qYidNfc4X2Y4disCCLouUXS6tmAq7F+T7C3Y1W1ha4=
X-Google-Smtp-Source: AGHT+IHPe77GBlhxi5pXgsU1vl2NwN4n6+q+g7UdUcH7WD6bMOLHoCEubEsD9UD0pOemxDxdXRtD4w==
X-Received: by 2002:a05:600c:601c:b0:410:14f1:7ee6 with SMTP id az28-20020a05600c601c00b0041014f17ee6mr518177wmb.0.1707463992731;
        Thu, 08 Feb 2024 23:33:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkTGDZwpjsI6mz/9aGxYPAO0/aMej+Arqa/qPjRcHR2tn4YP62yR6SmRIPoeey1KO01o4MbSX6qYZrQyJnAbK7IhK3oUFD7YdHeBiW/EnmYFzifnwhpOopXK6kSMMoK5BlfpeK9RJ4Luy9BPpedUNRstuFzFAJL7BiweBfLGS9iLEN3/eYrr4aSUxYcyHBT7b9DNbnDaR3Sl1NF4Y5AB80oYsr5biCxa0v60KUeUlOH5daqBGwbkPwl1yx2pNckdZ1iaU+dvGM4RpoVnVcgM1B4DTTxonvuvc4v2Ornel8JqdMMH3UN2Poi0stIJlUH3rXrpAjjFXTA2jtQIibI3oN+jM+EwgEPa/JXF5I7kv5/GGvsxM+/yr2TDymPNfrDTwN3fAhVAHkD5BM1ge2X68QUT2B676ZCoZuoeKdZY+zesdhBoZkAK91oELkaBNEQUT9hgUR3nP3jeX0g7pAKnpa38oVpvwhkzM1s+bPWsJxgIjF7RX1WUUv/TdzeDdPnIPFQ4RLqWXK8PyxcbhoZds5PXapXQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b0041039d20454sm1664309wmg.41.2024.02.08.23.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 23:33:12 -0800 (PST)
Message-ID: <0a03e639-9998-40b2-95bd-15dc40139509@linaro.org>
Date: Fri, 9 Feb 2024 08:33:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: light: adps9300: Add property
 vdd-supply
Content-Language: en-US
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-3-subhajit.ghosh@tweaklogic.com>
 <dbfde067-50b8-4f86-a098-0fc160114854@linaro.org>
 <84591019-6958-4685-8830-54260aadd26b@tweaklogic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <84591019-6958-4685-8830-54260aadd26b@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 11:40, Subhajit Ghosh wrote:
> Hi Krzysztof,
> 
> On 8/2/24 18:47, Krzysztof Kozlowski wrote:
>> On 06/02/2024 14:00, Subhajit Ghosh wrote:
>>> Add vdd-supply property which is valid and useful for all the
>>> devices in this schema.
>>
>> Why is it useful? How is it useful? DT describes the hardware, not
>> because something is "useful".
> I am adding this property based on a previous review:
> https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/

The property was there already.

> 
> Does the below commit message in this context make sense to you?
> "Add vdd-supply property for all the devices in this schema."

It's still poor. You should say why, e.g. because devices have it.

>>
>>>
>>> this patch depends on patch:
>>> "dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas"
>>
>> This is unrelated and does not make any sense in commit msg. Drop.
> Apologies for the silly questions:
> What does the "Drop" signify? Are you asking me to drop/delete the above
> "...patch depends..." message or does it have any other meaning?

Drop entire paragraph.


Best regards,
Krzysztof



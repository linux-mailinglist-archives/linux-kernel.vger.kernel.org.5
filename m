Return-Path: <linux-kernel+bounces-51602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5A848D1F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287C21F223B1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A95219EB;
	Sun,  4 Feb 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="aetaEVnA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB621A0B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707045847; cv=none; b=W2jHAcbVYPIZBQyFIYn2oCmvFwB8pPfrTIqdoWBnN9HiDfWr8AMrLOKgkX0lzRZobc6k4N2sr3qLNKQT6DyWNC+knXuEKBWt6eEX/JXhFFKmEH/0zRzwKOdMkajRV/Du70+O4XQ/ZsWi0NcrXaeIdGxRHFlVY2DmvOAhQKUDoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707045847; c=relaxed/simple;
	bh=k69QHIy3c0whon+klg8whm71G1FLr9cHgQlsm81/6Cs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nKFgipr3frMt+ipSFxciuoNME2sYP6ByhPBe2MSKaVKMhiBPfe+K9khPo+2TR6gEMRktUMVust21MMuTuZjzUorNdmxJd+3ILDTpjd/4rLii1LDOKHvVXsztM2LwUSRZcDKYk2Q+aV+HkrOQ4ATcg+lR7dDeLRxZoKUyqer07z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=aetaEVnA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d746856d85so25794305ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707045845; x=1707650645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upI2lQPR6KaovO+5qlL0SXpMm1vkdZfsRPpUfyY8fXA=;
        b=aetaEVnAZJ4rGX5b0EZGky7sFnRVY+ocudF2UKMtXR3OmuwByRDMoVxbfXv2aaTNvz
         dUHk/DD12zmNBUyI/DgWE0vKjMYxIs++LikquSXnDZ2fjASpgQpLSkvUnpW3yjTgfJOI
         N8rthAj7b2qwSHsz1cpwmBpk+BUaSR71WvVZG2mMLp0Pmfz6cU+1rmlangkGU+7Ygube
         zbOdoLk8pxb/mFfOCWt/6JdEI45a3Qk/FYs/JDckav1dqrW+Zau9hlMS183VgGxRbizI
         ngqEXVP+d7Nv93ex1sfcIltM3Co+W/EuLIoiyJ+K7LwzvKduv6aJnCgMIg23XTfyDli4
         d7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707045845; x=1707650645;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upI2lQPR6KaovO+5qlL0SXpMm1vkdZfsRPpUfyY8fXA=;
        b=QXyPcr+moF6GLgCjjbGUh/Hniue2TC6+BflIoIjOGWElqSu5j2Un8UuYPf0y73l2jb
         ibhgqbCsV/FlyxX2EwPwOHalvRPJ8rZU4oV+3EcojTn7sueHABkWH95swpl2XcjgmsSd
         hVBqZSg7tee0eaojPkLTwqYTV6S28IqOTpj7+uYYovPN41bnB274au6/H1uDZM2AgZTr
         mgei2Z/vSXpS+Q+4+LG8DD5IeEcGCGNrPR4UDdx+ThatKZ2LJNAjL1xad6tXiU/4hTaw
         S+HaQbcK4aWjWB7C556H7QTTj2+97zXel/PQ3nZWMmgc4XfH8mxQtQqsSUlczJBHRfFJ
         aUpw==
X-Gm-Message-State: AOJu0YyIbTgiFhhzDB/x0eIZ58EwLxkqRNQ5XetVb3s/GspbZpBG59E/
	zJnGmsBxIMnPFqFAgwomiG9IA3vuHihQ/W4Jx1bKkbQh77VUrurHHx9U8iR43/w=
X-Google-Smtp-Source: AGHT+IFmuQI7CLUnfrLJy6zZuHkYpuWiAiKS6MQ0sN/lLK0KrOwrZpD1Il4H1iwShEuZ0sd0RTAg5A==
X-Received: by 2002:a17:903:246:b0:1d6:fe11:2642 with SMTP id j6-20020a170903024600b001d6fe112642mr8079997plh.27.1707045845020;
        Sun, 04 Feb 2024 03:24:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTqifKl9Icy6D6nzs6HH9xWta0N8HAOAPNzVjf4y5AEPT9WWRiVoKT4zQp1z4aj5xo86atTJ6ZNGv+UO0qsfG/gNS1bV69FnVVxW3w7TNYa4JePgTu6PiuZKSwOMv4IzyrOrJj/pcHIZdXdnt8/IK4Qu4nu8k6shSWcz3rE8I+Qz33JeVgKPGWNGCuE4GLICspOzaRjAPjbnJ1BO+/tQ1AI/r+/hikZ10I6WNaZgAvkjZoAgbV2VQyz127jXuy6+n/vlMwC1Kx7f2kVzephknyjV/8Em2e29J+Z0ANhT85oeZQchEptR7BGYthMFz/XTc29TAGe0RlgXc8UoQdm5iICrpr8Aor4qO9O1aERtO4GoC5Sf81FAVY0+pGL5Dl6KECfFaW0YckyRgzQq/p8/JRNJcWNQSSG/m+w3O/e9uCQICLLddxyS6H0bFXhW7/JfVu6Rnq1pjYwDzZ7qbEqTmcSF6CfQLK60pe6wq9N94P3JuN9SEFWf7j2evF1zjfi54j7yw=
Received: from ?IPV6:2403:580d:82f4:0:1e3f:bc28:aa1:4e5b? (2403-580d-82f4-0-1e3f-bc28-aa1-4e5b.ip6.aussiebb.net. [2403:580d:82f4:0:1e3f:bc28:aa1:4e5b])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e20400b001d90a67e10bsm4446733plb.109.2024.02.04.03.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:24:04 -0800 (PST)
Message-ID: <fd404067-bc24-449c-94b4-f59a54c3f532@tweaklogic.com>
Date: Sun, 4 Feb 2024 21:53:55 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <20240121152332.6b15666a@jic23-huawei>
 <757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
In-Reply-To: <757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,
>>
>>> +
>>> +static struct iio_event_spec apds9306_event_spec_als[] = {
>>> +    {
>>> +        .type = IIO_EV_TYPE_THRESH,
>>> +        .dir = IIO_EV_DIR_RISING,
>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>>> +    }, {
>>> +        .type = IIO_EV_TYPE_THRESH,
>>> +        .dir = IIO_EV_DIR_FALLING,
>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>>> +    }, {
>>> +        .type = IIO_EV_TYPE_THRESH,
>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
>>> +    }, {
>>> +        .type = IIO_EV_TYPE_THRESH_ADAPTIVE,
>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
>>> +            BIT(IIO_EV_INFO_ENABLE),
>>> +    }, {
>>> +        .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>
>> What's the intent of this final entry?
>> The type will default to IIO_EV_TYPE_THRESH anyway but if that
>> the intent you should specify it.   There isn't an 'obvious'
>> default for type in the same way there sort of is for dir
>> (as it's either direction).
> Understood, let me experiment and see the ABI difference, if any and get back to you.
> 
This device has two channels - ALS and CLEAR. One interrupt enable option and
one Channel selection option (Clear or ALS). According to our previous discussions:
https://lore.kernel.org/all/20230415183543.6d5e3392@jic23-huawei/
the event_spec was updated to have two interrupt enable attributes - one for CLEAR and
one for ALS. (Intensity channel and Illuminance channel)

If I remove the final entry I am getting only one enable option (intensity channel):
/sys/bus/iio/devices/iio:device0/
|-- events
|   |-- in_intensity_clear_thresh_either_en
|   |-- thresh_adaptive_either_en
|   |-- thresh_adaptive_either_value
|   |-- thresh_adaptive_either_values_available
|   |-- thresh_either_period
|   |-- thresh_either_period_available
|   |-- thresh_falling_value
|   `-- thresh_rising_value

The last entry gives be the following event attributes, enable attributes for both
intensity and illuminance channels:
/sys/bus/iio/devices/iio:device0/
|-- events
|   |-- in_illuminance_thresh_either_en
|   |-- in_intensity_clear_thresh_either_en
|   |-- thresh_adaptive_either_en
|   |-- thresh_adaptive_either_value
|   |-- thresh_adaptive_either_values_available
|   |-- thresh_either_period
|   |-- thresh_either_period_available
|   |-- thresh_falling_value
|   `-- thresh_rising_value

Please let me know if this sounds ok to you.

Regards,
Subhajit Ghosh


Return-Path: <linux-kernel+bounces-18929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897C826551
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B05B21545
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB813AFB;
	Sun,  7 Jan 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltEK5H1/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9213ADF;
	Sun,  7 Jan 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d89446895so6143025e9.0;
        Sun, 07 Jan 2024 09:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704648876; x=1705253676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCTsJarysC77v3ACP/NKhPe2RrrA50cxy1q5t9LuTHM=;
        b=ltEK5H1/IjDbTtHUZ13LZ5ojhcEVgW/pRxXnaXyCD3rMS3o90i4z46Wb+l/YSmvh+n
         eRbSJ1UyRbo8xcIA+/mNu3bj+JjjIF3W3SUfIvAFOsnTbdQyldQQSW9FDRJMftP3I1Mx
         ctCEFymtlmURbCKtPcoFOe4qewj/1rG+YXF2DoR0kzFdt9sjM9rw5CPWvn7EsMk61M85
         1dyJ8fnQ0zSlRcYLFjU1IMJfWBu6hqHwC0WoCJK1qFuvs0RT2gP+wAwuQ6p/XmPMP0B+
         fnClryBDaJs+mvyZzHK4Y+vJ+MQmjc9mvqatTIraa88SH4QHVzx1mJhI9dpkiYAp9x8I
         5aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704648876; x=1705253676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCTsJarysC77v3ACP/NKhPe2RrrA50cxy1q5t9LuTHM=;
        b=JN5RTj4bGs1poT6OF2iGby/gbN7Waf80YvA2Eq4ViXf1fbcmLz40v2/FFxJjDK/7/l
         KFBxQNdE9eFyqVVXqgbDC9gjkw5mBZmvz6gBE/vbMO4eLSehB7SUqot7p/ejvvLfhcyo
         5dlWKv3Zd8s4FCn/PDGBRIK5biKFbaDmcKGoec7bVLKd2zC5otQw5VFMiQ0NHTy7nOHW
         Msb/lfEfZu4a1J1JcGcD4+BE7CScUkbe1/wj7g6oaWr4Hj9HQm+u32ycpZof02ZRLOzD
         wPf8rJ6S1AKt6rmfb8HiF0WVjoiTfLpRh5RZX6fsDs3mrropfB76fxJ4bXwt2kggUhzz
         vyBQ==
X-Gm-Message-State: AOJu0YzFXPqEazqOU7o6M4ldPTbUqKeDVZP5IQon88QvG0OnC8dlM9ek
	j9x9wb05RoKDgUYIA5JMwmQ=
X-Google-Smtp-Source: AGHT+IH7PVY8CzQUeCsJ1nGmDuxwcPDt3KQz68vpwQ6dpfq0z3lR/rhnWbTMxYZ+I3+lhZO8z2NwDw==
X-Received: by 2002:a05:600c:310f:b0:40e:4134:236b with SMTP id g15-20020a05600c310f00b0040e4134236bmr1024379wmo.117.1704648875474;
        Sun, 07 Jan 2024 09:34:35 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:f579:21c9:7f03:46a? (2a02-8389-41cf-e200-f579-21c9-7f03-046a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f579:21c9:7f03:46a])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b0040d79997731sm4484033wmc.0.2024.01.07.09.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 09:34:35 -0800 (PST)
Message-ID: <b842c7c6-9c56-4789-80ed-00b969a35709@gmail.com>
Date: Sun, 7 Jan 2024 18:34:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: light: add support for AMS AS7331
To: Jonathan Cameron <jic23@kernel.org>
Cc: Christian Eggers <ceggers@arri.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
 <20240107155838.376bdd1e@jic23-huawei>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240107155838.376bdd1e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.01.24 16:58, Jonathan Cameron wrote:
> On Wed, 03 Jan 2024 13:08:50 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The AMS AS7331 UV light sensor measures three ultraviolet bands (UVA,
>> UVB and UVC, also known as deep UV or DUV) as well as temperature.
>>
>> This device is practically identical to the AMS AS73211 XYZ True Color
>> sensor that is already supported by the iio subsystem, except for the
>> photodiodes used to aquire the desired light wavelengths.
>>
>> In order to reuse code and reduce maintenance load, this series extends
>> the AS73211 driver to support the AS7331 as well.
>>
>> Note that the UVA and UVB light modifiers have not been merged into the
>> mainline kernel yet, but they are already available in Greg's char-misc
>> git tree which can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>> in the char-misc-next branch.
>>
>> The original device AS73211 supported by the driver could only be tested
>> briefly due to the lack of hardware. Instead, the i2c-stub module has
>> been used to make sure that the driver registers the iio device properly
>> and the attributes exported to sysfs are correct. Some basic register
>> assignments reported the expected intensity scales and in principle
>> nothing else should have been affected by the modifications in the code.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Hi Javier,
> 
> Series applied - but given timing I'll only push this out as testing for
> now as I'll want to rebase the IIO tree on rc1 once available in a couple of
> weeks time.
> 
> Thanks,
> 
> Jonathan
> 
Hi Jonathan,

I am happy with that approach. Some extra time to catch issues before
going live is a good thing anyway.

Thank you and best regards,

Javier Carrasco


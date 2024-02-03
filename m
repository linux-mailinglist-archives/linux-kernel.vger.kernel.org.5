Return-Path: <linux-kernel+bounces-51162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1484873A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F351C22A89
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3725F547;
	Sat,  3 Feb 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUfkNceP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A65F54B;
	Sat,  3 Feb 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975619; cv=none; b=OFU1iU5IlI0Vp0C+sKI2kAtVulj92LEwDC0SPHIFb+XoE1G0wMcc67Q3aFykpLXmIx37hH0SgjyL8A9RE6FSwVrvczNKG69oiE8ofxOi5ZMwW4OEp/6izrlBHMMvxbbcf0LKjRWW20U1jc2DUOJVABGugLihMNeoIw/3CTRZ+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975619; c=relaxed/simple;
	bh=V4qePdpxMdZApQIojvu0zaGw1t4lmxRKgYlqEuXbuJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6NSY8Oym5Ck6IQ5pzDFCkzHkVNhXGugoCh1m9GZ+TDIIlY8D/dSv9F11NMXzpH0GMBoE9icoUejESAftNxQWY6WBMt7sZQ4qVHOXhlyh364NJ0jM7hk3kuYBoU5Fl/zd4FbikC658ArmrzIvB5kAW4cx/HEeeSs55Fj7GCEqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUfkNceP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e80046246so9708385e9.1;
        Sat, 03 Feb 2024 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706975616; x=1707580416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dADcvM1Q++FMJXYvceHm1q1pwEpXncGBHJbJ+0LI+o=;
        b=DUfkNcePIWsRL7RdHHifXGubAYrZSiMEqNSSuu549+dF6l/yP+IYN0P0j7+Vguto96
         FqixPonCEsuZg7aZ4QIttE83UTwlcaj8BLaXeSfY4V5dDc/RbH+WFZMMLG2qbseYJ1bq
         72AjfZEIb5Nr/dm7amkgM9aNxp2QYoew+6eta2outLXZy6wFlrGms4NcU5qH7h1NZJAV
         pI5mbiSR2gxBVzZzovdo1e11n5mTgnqO9YgbRCS8OnKAdow0oF7QmGtiZu6YRNsBOExk
         24RdehY1NKa586Efy9PIfWeh8YaOt26AJMD79VAzd2ShsvoJdwicAGO0blSkjgGDwRRJ
         517Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706975616; x=1707580416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dADcvM1Q++FMJXYvceHm1q1pwEpXncGBHJbJ+0LI+o=;
        b=a1DbXDMDhoRl6L975HXg0UaUFQRT5ErLcSuKegSeu3kulCp5TCdbYGEglD4NW+9AUP
         OjnO2F75uAWNfL8FLDN+Ut3QhdM55YWi7R988de8st62vnjE4oAloYS/VaypZS/SuuGC
         X/OmHt27+L2K33B875JmsXBBOZQqi+q/JDe7iXZv6mcanKYOGW6MZjI4UMXMeVxK5jw/
         mmwQ2r9ZKWFn31kUhIMS3hHvoBMUpDKZ2PAibUShfsR0Qn2KJn6hL7Qo+OYCcSYKI1+j
         VZtOvkb8kUZ8UaAQP3jvtkFIYYlUVL/nQp4t88hQoB67jhN3w6q7x/plkbZeuJAnadt/
         Kfbw==
X-Gm-Message-State: AOJu0Yxun6MT3VLJCLSXmTh9l6ubxkmkO+yxkV40lkWtvaZBxrfi/oLQ
	H/5sxydIlUs6XeWQ6F3VJo23WeXT3GJDDraaMofjAmtZJ9YVEeMo
X-Google-Smtp-Source: AGHT+IHH2x7hJXA4kfaVWqIY4+uREhDuwzkNxWmkfpOT3qqvR5/fvjl0KPmsPtLPMlN3wxuyk5fa6A==
X-Received: by 2002:a05:600c:1c2a:b0:40f:d242:a2d2 with SMTP id j42-20020a05600c1c2a00b0040fd242a2d2mr863350wms.12.1706975615972;
        Sat, 03 Feb 2024 07:53:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVDoOdN+HictDq4hTrzzaobl9rfFxp3/ZLci6IMllOhZ45ClgnOBVmCSBIydGlG7a4u0HVXbdSQ0QVpRxcHD4E1w6ewvlYQuT2RUszV+TC4p3I//fWOKIoBoxW5fpwR/0u1npkE1tiiFM5c6ADpyNj+eUyeg/7GLeO38s9f/ZdLNTxDZi7V3w0wB64=
Received: from ?IPV6:2a02:8389:41cf:e200:f581:7be3:f073:d676? (2a02-8389-41cf-e200-f581-7be3-f073-d676.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f581:7be3:f073:d676])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b0040faf3df118sm3277597wmq.32.2024.02.03.07.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 07:53:35 -0800 (PST)
Message-ID: <871e7e7a-c987-4926-957e-5dfdb46d0740@gmail.com>
Date: Sat, 3 Feb 2024 16:53:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
Content-Language: en-US
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
 <1eb2034f-b1ef-474d-91f6-c562a5768bfd@gmail.com>
 <20240203144205.GA3727@debian>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240203144205.GA3727@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03.02.24 15:42, Dimitri Fedrau wrote:
> Am Sat, Feb 03, 2024 at 10:30:09AM +0100 schrieb Javier Carrasco:
>> Hi Dimitri,
>>
> Hi Javier,
> 
>>> +	/* Supported temperature range is from –40 to 125 degree celsius */
>> Should that not be val < -40?
> yes, you are right. Will fix it.
>>> +	if (val < -45 || val > 125)
>>> +		return -EINVAL;
>>> +
> 
> Best regards,
> Dimitri

When at it, could you please rename the hdc3020_id variable you added to
the probe function? It shadows the i2c_device_id global variable (it is
not used in the probe function, but there is no need to use the exact
same name), and given that it is in the hdc3020_probe function,
mentioning the device name again is kind of redundant. Something like
just "id" or "dev_id" would suffice.

Best regards,
Javier Carrasco


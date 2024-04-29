Return-Path: <linux-kernel+bounces-162391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EF78B5A90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE42B29020
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E8745C3;
	Mon, 29 Apr 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGOwg+kk"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0972E401;
	Mon, 29 Apr 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398566; cv=none; b=V7Lhb2AAe0YLqBx9ZuDMXqIFp9BL9VXWkDQzTR1U7hWVeq/EAkMAiEu/E3hHfRZugOLM/tXlzYqHxaI9jNoejTEHVDhNfqMuKpFz1A+uDE1GEErV4GJde1OXVly0+BY8w4cC790+BOnyNV5pJ8l20r5ZdPLYXI5ChUo6DJIHfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398566; c=relaxed/simple;
	bh=EXfCw3rNz9McvbuzKSk45Zag0zYGIXbsQWF9BEZVsSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ij0rSn01yaZKbAomkZH79cUdWngtvkW8fA8Or04vrlFePG+zuXk+/DkXTRLhC095ur6WTRKFtGBMVnGN16M9q0bCW4ZN1sN9thZXtrlvnhiIZmE8D15DLGLK/ij+UybnD2iOrxWXGq2Fnu72pYUFcqATdNB5BQZVayLSW1YVG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGOwg+kk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c3aa8938so28787625ad.1;
        Mon, 29 Apr 2024 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714398564; x=1715003364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u3kO8pISFRbCEy1Z0kVM5um+gFUTt2cTIlplF0izCEw=;
        b=RGOwg+kksI8vZUwUqvD+Hh8DTlHnRBrdyjfQGrHOO+Dbyld4WhL67YiUF2WcgHa5vG
         lTMnRFvdh0oVptMeBrMx6aFOdV47CGG5S4IzZ29hoMW+XHwBYqPVkYmoQ0eUOQHxRpvn
         pw1QqCOXOMofpUPWoYYkRMv/zcs5gLPvaydbliU2bwnidmljMtN0fmIzmSZ0+ndEVhB+
         b/du92s0EHNRJCb2+/AzV3NfF9xe9Ny7ZmByYBPTlCRFZc1pa4SmSeY4TB3Bjkvzwl6p
         TLWixvxeaSfCY4ycdwKzvnugx1kpUC4hT4jdTC0dXGM3r9+36tDrhqMenbbygQERjaxg
         PLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398564; x=1715003364;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3kO8pISFRbCEy1Z0kVM5um+gFUTt2cTIlplF0izCEw=;
        b=s1FgVc8SMv5czz8aIRcuAjcEDuznZPkEn283Pg+G/QETLnIDdHx0WfpAbnuJmt2qEf
         2OaECSuxDJPEGiI93Z6chMW1hh8fM6CeXADAlT4bjLcOY/O71zdQ2Coqgwmn9cVydhGk
         zoggvAPta1xFKsk4tHJT/F/jLT1GPDIrCUSZgW+RaES7Qj/dnaxUjLsGski8IaEe2DBd
         sX+2sXCkrKpBcg48JCrQZfmY8Sq/+MafhLv0EoTqonzU7UA8pbreeMjF//dVIN3Fg5vx
         AHVIMYU8K/YF9/yagZOBuVdZxQqdwa6N+PZCn/9SP/4I4JhpjN4dyVky1s5LUM6YswmP
         Bglw==
X-Forwarded-Encrypted: i=1; AJvYcCWWkd6rjPGtbWvjlUcv7V6JRC0aPi6grvbxmi/ZP0VEMe2S5R3TFek0a5gEGVW4mPEKH9iIsrbnjn2hLqEr4RFtjXiCDunOiI5/5WZbaEAphZRdjds6LDrGF/ifvUZ7akS+yJa8NCMvlW8=
X-Gm-Message-State: AOJu0YyQGBOOyefVHzjl4lcyN8jIHQ3D/nwdd3gAKVoVqngdRvK2J4JN
	zklE38MVXUo36YvpvsGvwzk6sUdGFg+x6kW+etVt08QvyTKoegL0
X-Google-Smtp-Source: AGHT+IFoSSKDvHHUTs4npSZftxmYk+mCNvZrjZhHpIZ6VlEnbVqSREAVUzJQ+8pFQWr5O8jC7Nw1KQ==
X-Received: by 2002:a17:902:d491:b0:1e4:c09:7f37 with SMTP id c17-20020a170902d49100b001e40c097f37mr12167894plg.54.1714398564475;
        Mon, 29 Apr 2024 06:49:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001e3e0aa9776sm20274770plh.27.2024.04.29.06.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 06:49:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <afb5d43b-14ff-4859-afce-000dbd4bb62e@roeck-us.net>
Date: Mon, 29 Apr 2024 06:49:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hwmon (max6639): Use regmap
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net>
 <CABqG17jveAdxN+tCcPq4hNqWDy1YCJ1z0+kLpM+ect0XEyqBcA@mail.gmail.com>
 <116aeea1-c648-4abe-9ab2-693bf64000fc@roeck-us.net>
 <CABqG17jHYymH02hAH0z-uqk2HjemL_-aLr9EyOUNR=uQ7U_wtA@mail.gmail.com>
 <6d779d5b-b622-4e20-9449-64307b9b9582@roeck-us.net>
 <CABqG17inSB8stBf=ObaYKj4FREpXKWSy=7XXO9O3RhEx_v74vg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17inSB8stBf=ObaYKj4FREpXKWSy=7XXO9O3RhEx_v74vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 01:19, Naresh Solanki wrote:
> Hi Guenter,
> 
> 
> On Sun, 28 Apr 2024 at 22:48, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 4/25/24 02:50, Naresh Solanki wrote:
>> ...
>>> This driver has 27 regmap accesses. Except volatile registers, others are
>>> cached by regmap.
>>> Some function which only access volatile registers will not be able to take
>>> advantage of caching. This is also the case in various other drivers for similar
>>> devices.
>>> Also regmap offers bit handling which makes the code much cleaner.
>>>
>>
>> Maybe I need to make it explicit in documentation. I will not accept regmap
>> conversions unless local caching is dropped. Yes, that means that volatile
>> registers will not be cached. I consider that a positive.
> I agree with you. Regmap conversion wouldn't make sense if local caching
> is present.
> Correct me if I'm wrong, but in this context, local caching points to the
> various variables in max6639_data ?
> i.e.,
>      bool valid;     /* true if following fields are valid */
>      unsigned long last_updated; /* In jiffies */
> 
>      /* Register values sampled regularly */
>      u16 temp[2];        /* Temperature, in 1/8 C, 0..255 C */
>      bool temp_fault[2]; /* Detected temperature diode failure */
>      u8 fan[2];      /* Register value: TACH count for fans >=30 */
>      u8 status;      /* Detected channel alarms and fan failures */
> 
>      /* Register values only written to */
>      u8 pwm[2];      /* Register value: Duty cycle 0..120 */
>      u8 temp_therm[2];   /* THERM Temperature, 0..255 C (->_max) */
>      u8 temp_alert[2];   /* ALERT Temperature, 0..255 C (->_crit) */
>      u8 temp_ot[2];      /* OT Temperature, 0..255 C (->_emergency) */
> 
>      /* Register values initialized only once */
>      u8 ppr;         /* Pulses per rotation 0..3 for 1..4 ppr */
>      u8 rpm_range;       /* Index in above rpm_ranges table */
> 
> Are you asking for removal of all these variables & each read sysfs
> attribute read should access regmap cache directly ?
> 

Mostly yes. Note that "ppr" is only used in max6639_init_client(),
and it is unnecessary to keep it in max6639_data to start with.
rpm_range is ok to keep because it is a calculated initialization value.
The fixed initialization of temp_therm, temp_alert, and temp_ot
is questionable to start with because it overrides bios/rommon
initialization values.

Guenter



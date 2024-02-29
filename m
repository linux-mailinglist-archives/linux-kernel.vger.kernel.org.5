Return-Path: <linux-kernel+bounces-87314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3886D290
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F1F1F214DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BD134415;
	Thu, 29 Feb 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX98Rxra"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE91E526;
	Thu, 29 Feb 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232463; cv=none; b=FEnDS4h0qEWpfi7f6MJaqOOsO1rjLZ5LXBFPtSaepIN+SvRX6IQeV0HsS0MN7hidvxUSsB9kSo+ElhPLyYm0srAv1T+exoEfY7lpNfEBRZljbp69iY9cVu2Gag1PB08deUqRdWgcuk1F23kHlg7DaBox4iM6fj92IHuEjJOjslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232463; c=relaxed/simple;
	bh=jPpWQ+C8qUXkMnHJ3I/VjmsugQR8QEiqG5+XvP6+THI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uxyca3eht95d9XAMeTRrLF8KOs5qLVsospdnuc4xCU+ZChoCSgBAez23RFcoD1b1VG8DdFm3IAq/IeAC16GMDdkBzcWqdEC368zG5VYzCqu5nMBcm56JkRkZCeU4eJ6cibl43VbXHGs5Uuv6tlk3DjrzOw2UhYAefezHg4CeKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX98Rxra; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c78573f31aso59949039f.3;
        Thu, 29 Feb 2024 10:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709232461; x=1709837261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j1d0nF2xt5tcrnod1rGDq/90sF+yX13XOLoLTdEioeA=;
        b=AX98RxralFFjhe5QSu8sT6EO3ygQ+fwEPbgZ9yepBXrlGm6Hg9/Ya1nWqCYpZ9TCRv
         m/6GkBFed2YwVXPKSAPxQmT1Xn2yzJvdevGcH3xVYVDi+chyEVsI83NwqlJE52K7mjRP
         7Ba2qxBUa8Hkv5pV4BpJ98TGoaUpUbB7iLlpEpvAKQ4cofGNJzeUXkRQWH/Eep5gg4DV
         2OxOva5CtHSqoFvDbBGODyEOwZ1FJQFKFDrzdR1n9255y7N5hx0+F4kxS0EEh3iT17h5
         tLULiZqzNIgC2CgIJvlT+qgwU7PIoSkK10HLJ0Nv79sZ0Kaxokq9TVmGr0Gfq2vd4IVA
         29vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232461; x=1709837261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1d0nF2xt5tcrnod1rGDq/90sF+yX13XOLoLTdEioeA=;
        b=Y6pEPP3CVQUC589u6yoEdUFm8YfErcHfQlI86iC/Z28r6FLrhWXFq1lwzvSwIyQZLF
         4JtpREmsv7hKAXTai8jonCEwejKmOrrvOglFrm/IYbBVk02jaBke3AR33vbmB65NQM6o
         ihZpXGbxejv4rYSre7bC3BUaHoAz4ATII+F8vpYUDhTv3oEQI4wYkdQ39qe3JhqFG97O
         1RJnyiXrXetn/Aj0HQy3GiSPqB0r8yJQpbivc9vCev9MVLhrDh0+6WJ5JRSj8ZXUx6+Z
         xbhgWybEdb/7DdwSHibr185PhEz25KbC5aA7ybIyx5jkPkPPDevg77b4TK9ySyZ4Xb1i
         iEvw==
X-Forwarded-Encrypted: i=1; AJvYcCUklnMv0VNEtcmcFRG0fd+E/0pjej+2Y3IhYaBripdUxDeeXgXda0gCqDGkfivZNERdQzvEKw8mCnLG//Uj+J/KBaMiTLiBTWbA3VvDBXQ=
X-Gm-Message-State: AOJu0YyWJ41+CTtUNj+4TBp+IkkIRIF9i+G6qA9NL9FX2NW6uOFeM9Nm
	M088W/0XubBQ6EMDkDBVtvOqzcAlLVp8fz21tmV4izO31WQGH2Mo
X-Google-Smtp-Source: AGHT+IHM1p1LMP0/CSwMec0vhiesBYRRrY3L4xRIiyXwLXoVGpNc3yR4sXwkhciNjfBBPs89O87atA==
X-Received: by 2002:a5e:a903:0:b0:7c7:f0ed:2f43 with SMTP id c3-20020a5ea903000000b007c7f0ed2f43mr3169744iod.15.1709232461187;
        Thu, 29 Feb 2024 10:47:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x22-20020a056638011600b00474988b1a99sm451416jao.37.2024.02.29.10.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 10:47:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <06bf41c9-34b8-4361-a6d9-72afeddae1b4@roeck-us.net>
Date: Thu, 29 Feb 2024 10:47:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Content-Language: en-US
To: Mark Pearson <mpearson@squebb.ca>, David Ober <dober6023@gmail.com>,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 David Ober <dober@lenovo.com>
References: <20230721122931.505957-1-dober6023@gmail.com>
 <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
 <6b0373a2-7750-4d57-8839-95c6fa30c6b8@roeck-us.net>
 <4209014c-1730-4c31-87d8-4192d68bcbc6@app.fastmail.com>
 <6615ab2a-3267-477c-ad1b-a72d5a4244e0@roeck-us.net>
 <412acdd3-6b1f-4c45-966f-c493b6fc3ddf@app.fastmail.com>
 <42a7e7e9-01b0-4d41-8af1-328de90934ef@roeck-us.net>
 <74a39cd0-cee3-49a2-a47b-92a9cf9ca008@app.fastmail.com>
 <45490a63-e46a-4eb3-a55d-2e2642588ccd@app.fastmail.com>
 <6066862c-cad6-4845-8e90-32d4572c7a23@roeck-us.net>
 <6c97c63b-af35-4919-b5a2-a867776be8e9@app.fastmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6c97c63b-af35-4919-b5a2-a867776be8e9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 10:12, Mark Pearson wrote:
[ ... ]

>> Is it necessary to treat this differently than, say,
>> drivers/hwmon/it87.c and drivers/watchdog/it87_wdt.c ?
>> Those work together nicely because most of the address space is
>> separate; access through Super-IO registers
>> is limited enough that it can be shared by using request_muxed_region()
>> in both drivers.
>>
>> I'll have to look deeper into NCT6692D (and NCT6686, for that matter),
>> to see if those require mfd drivers.
>> I'll also need to get the datasheets for those chips and confirm that
>> they really need different watchdog
>> drivers to start with.
>>
> Ack - I'll look at those and see. Quick look at the watchdog driver and it looks possible but I need to check the details more carefully.
> Afraid I can't share the datasheet as I don't have permission to release it. How much of a blocker is that for you?
> 

I do have the datasheet for the NCT6683 EC space. I'll need to check if
it matches the code submitted for the NCT6686 watchdog.

For NCT6692D, I asked Nuvoton if they can share the datasheet.
Given that it is some kind of security controller chip, it may well be
that Lenovo has an NDA with Nuvoton which prevents them from sharing
the datasheet. We'll see.

Undocumented ITE chips are simply not supportable. No matter what, someone
will have to step up as maintainer for those chips.

Guenter



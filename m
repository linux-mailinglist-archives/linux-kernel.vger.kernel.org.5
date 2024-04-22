Return-Path: <linux-kernel+bounces-153682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1158AD19D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C71F21968
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36915359D;
	Mon, 22 Apr 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvPQGwEr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9134153581
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802348; cv=none; b=jaW3a8GQHg0SDR7KxUO+YmleSNqPy0Px4Dykq8AHqajUZOsI9xVb0P5Lb0iskMKTRJkPG0DZ4iU9Ngezb/1DigED5jDLXV+IGbMXaf4ula3pMwaIW4DEaMqPvQTC3wQTbTPc2uSVXUe8YHeJ99n4u8UcpIKJSazb6548oIeQK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802348; c=relaxed/simple;
	bh=pyespoIenYOvwr+vFAWDKTKpySEFKhKzEmeVBB6ayjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7+h+58kMiMA9T1FTz2mjBRWIoSxDlUqEdKQgcqcgnd9vopgZYW62pEqfAqbNKiiCYxllWKBy+LpxsIFHtQhXamJbK3/MnZDo7NPglPkyW1FJfVvem9O9QzFMjPPUo9DdC+z9FnVXOH+ksGbRsYpAn8tidVpatWtkKEHJm4cj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvPQGwEr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so31283075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713802345; x=1714407145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnFFhvINgBkGoeGxt72lLRxIj0jus3I5w0uDFrtanEw=;
        b=gvPQGwErFwllCkbn3pU4ylHAktTYu3QKFDkqJT/+hHGLEgFPUxS/nPxMXCuhS6pILp
         o4z5UHtjnhaT8G9kdcaHEq583d1OgaqoTit0w3t4kzCFF3tq3NyCuZRkIo57EmPIDVcn
         OUzDG5WecjuzyvO6WnpDVU3COv/rNFRiGFS+1rpdYyYPZYcNrDLlweiX8olkJWbDaYR4
         KPUOr1V33UWn+2MxNz96gQWrbw6Ej7qXhXm4eewwxTEiSRAk107q06gVs9NMVa5Q+VEr
         6u/5grM9tzGlrEk76WQROD1v8ToIVdoP50c1jeUP4SFfANIuHmjLsua2vx3tnRAFKKh5
         0SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713802345; x=1714407145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnFFhvINgBkGoeGxt72lLRxIj0jus3I5w0uDFrtanEw=;
        b=lkdT0bi9Ya7CjNezVMkJPWVOnwbbMd6xX74Fi3wwy+s2iGuVBEaLdoOpgbeglxq0bI
         O1ZXuAgkFr1B54DnV22f8zlefLdFtY/ekqao6L6bGUn+tR1z2QXoTDj3MGefo0b3ZNEc
         x/U5nXJ/6Sv79zAxNL+jVw9hoOk315Uw6pIFaAerH2euQf8E5SST/TlVrDeGB2dCB7T9
         ByNj2eT8/U5/b3p+nI1vcJHwK5YXX9Gqrq6YFPlAI/93ud9AyFFpuDsHwcSHGS8A3I6A
         rRWazzQ7nSr84lmYsccS4ItiEbgC5raWbHmExXJldOF4wIHxa3wksCBwwu7Ywio7ZWHi
         aVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2rmRJEgERWpGvmwTXfaV7T0kB4MiS1ZQaGC3Ihk0F9RMdb52wUGMWz3OaURnfKtTkFXKRH0Bd+75KYl+ssFkozm2dAJTmJj/TQCFC
X-Gm-Message-State: AOJu0YwbpeonkJJ+pbbyKgCaSSm9tDuy3/p6msmkhjfLCTQcUMjagRaQ
	4t5f/E7OabXjpiEE4H0+b+OuUO8JxHRvRcGrT6VqEYH6BgjbJU9Rm8SchMMJYzv2/pLRQjtXzLi
	z
X-Google-Smtp-Source: AGHT+IHr5ZN8Vuq2/rI8TUkOzEMqB0i773L+TnbVRnQcQznM1VMn2gKZ7tsYNkoxi+P2H8/Ew24caA==
X-Received: by 2002:a05:600c:1547:b0:418:e08c:817 with SMTP id f7-20020a05600c154700b00418e08c0817mr7012270wmg.32.1713802344362;
        Mon, 22 Apr 2024 09:12:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v3-20020adfa1c3000000b0034b61423d54sm22412wrv.106.2024.04.22.09.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:12:24 -0700 (PDT)
Message-ID: <2acea3c3-5c8f-4f3c-a275-743c3fbfd2e6@linaro.org>
Date: Mon, 22 Apr 2024 18:12:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <4918025.31r3eYUQgx@kreacher>
 <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
 <e8193798-4c02-423a-a9d8-63d29ebd7faa@linaro.org>
 <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/04/2024 17:48, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2024 at 5:34 PM Daniel Lezcano

[ ... ]

>> or we should expect at least the residency to be showed even if the
>> mitigation state is not closed ?
> 
> Well, in fact the device has already been in that state for some time
> and the mitigation can continue for a while.

Yes, but when to update the residency time ?

When we cross a trip point point ?

or

When we read the information ?

The former is what we are currently doing AFAIR and the latter must add 
the delta between the last update and the current time for the current 
state, right ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



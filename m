Return-Path: <linux-kernel+bounces-155706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3618AF5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B87A1C215EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1313E03B;
	Tue, 23 Apr 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o07N9ecy"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE613E034
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895121; cv=none; b=W4M3VU4gwpDa/pKTiFxXNQUCcviJ0UjTNjR6Eh2jgAKUrZFVTjt24LUR37XFF81tWl1CLVdufrsvL/bwisTMom9vbOqYmXBi/F1iPVMZULEqXli1D7aFiDqOS76rzVeHD7IRsVK4mIkDNmXkgvx3gR0HWU0v+xGAojo9oHwAOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895121; c=relaxed/simple;
	bh=dd+JeMwnI5oUS4+G0VV/w8a37ey100fY6+ic7TXAsH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0gZ55O5iT7lGc6FwvS7RdLlcbmtMo6fSlo90au80CWMorLUOrpUBJ/qnvaTxDQ3SMGpI+kMmOQb7ilhAvzMX5ao7XkIrq8WGdr7mF+H8vFVBAFcWeovZYbAvmykhCviyZHsLQjvG2mErTbfZlDFzwuJT5ZFvNCKht1Hb8KLGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o07N9ecy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ac4cd7a1cso6415855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713895118; x=1714499918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgRbrsMGiUIlEz9TTE6qVqcHJ+EG6dlP4R0WOrU0AXI=;
        b=o07N9ecytWgJPZwENySqx8oJIg1gyF8i8Mg99zMwAqSkwXDKp+466GEU7P2bZpY9Ep
         rMmFD4w90zKsK3THE5PQCQ9i23Kr+C3l1cad1+SFwVnwxBn+HDuTusK2CKv4z6wFBmJk
         JGisxbeLKXaYIPKunBXrAt6NTAVQFdpXM2veiOZt2kgy36R47Vk+pRk44IqVckWXpMET
         uCYZss8PN4T0rya7skLrnfrnPvf2O/7DNHaTN21pnLXMy3rPULvFeQYGaRAkXT8sx679
         dvj6fKLNE/SglNdD+RMhlK42G3Ly0V5tkzhej/hsu+CbhqLgfRb5JEj57qs6GyD5T/8M
         ioKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895118; x=1714499918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgRbrsMGiUIlEz9TTE6qVqcHJ+EG6dlP4R0WOrU0AXI=;
        b=BIw8nadjr/BRxnZhJ16zP1XaXMN3zcVlzSlmwpzA8ag8eDYrbQjR9i+WWw/YlbIgtC
         nXPWbBSX7CIXKh7y2y/Ohsd1lbjrI0fEY8QHf/5rgBQFUH+9sSATxI0ZBUM6pN2Fueec
         7gr92z5Ujf5IJjZQwE5ZvVTyyQx9f+eoVIjPKBDJz9TSpYdlOqze/PXdRswzCwHea7w6
         QAqMBNP2280DTq6D9MI2/ZytKs+T0OZpUOqv4iO6FNgBjb/Ev1Fr7/IUmi3nkKDmYWS/
         lNhLpHuR72iN9VdLK8AAkuVgQ+gvVfgYZ7V4BHPnIlhKloY4Jq8gf3YOQ9jzO1BkYnlG
         Wy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEaj5Jn4vXVGnCdE3mhi4DrfIs0yPPkvIxTDyx8YUmQVJhK3KrLz852qwUGYt27Zim81We0EBVrPKyyimB4zFkT/HR84p+m5cbY63+
X-Gm-Message-State: AOJu0YzNl3nd5pc5uXlJOb/KZOe6bQurJD9Qb8UsHjEaptIP5t/3gic1
	Uk8+VZ6DQ4r/pmy4g/e+P3Q4NpGQoZ2moMeeqcrIOLvp6R8ov1pE0jRqIjGbhr81JiGKEsvMGfM
	A
X-Google-Smtp-Source: AGHT+IEg8a5zVa87KQciw+DOQLgzGEJoPscxi47i8ZciqJoIshh+lMq1AzoW5459X2elbie9GPlIUA==
X-Received: by 2002:a05:600c:3143:b0:41a:afe1:6d77 with SMTP id h3-20020a05600c314300b0041aafe16d77mr15647wmo.11.1713895118348;
        Tue, 23 Apr 2024 10:58:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w17-20020a5d6811000000b0034a2ba13588sm14055862wru.42.2024.04.23.10.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:58:37 -0700 (PDT)
Message-ID: <3c169af3-e9c3-47c0-b343-48f699680009@linaro.org>
Date: Tue, 23 Apr 2024 19:58:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/16] thermal: core: Introduce .trip_crossed()
 callback for thermal governors
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2009494.usQuhbGJ8B@kreacher>
 <9f45fd2d-f1de-437f-ae8a-75ad51a5c061@linaro.org>
 <CAJZ5v0ggUSk43LGgXLU08svxtdUDbAvX+4Ca0DNTAH0H85i7Rg@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ggUSk43LGgXLU08svxtdUDbAvX+4Ca0DNTAH0H85i7Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 19:25, Rafael J. Wysocki wrote:
> On Tue, Apr 23, 2024 at 7:14 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/04/2024 18:10, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Introduce a new thermal governor callback called .trip_crossed()
>>> that will be invoked whenever a trip point is crossed by the zone
>>> temperature, either on the way up or on the way down.
>>>
>>> The trip crossing direction information will be passed to it and if
>>> multiple trips are crossed in the same direction during one thermal zone
>>> update, the new callback will be invoked for them in temperature order,
>>> either ascending or descending, depending on the trip crossing
>>> direction.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---

[ ... ]

>>> +             if (governor->trip_crossed)
>>> +                     governor->trip_crossed(tz, &td->trip, true);
>>
>> Is it possible to wrap this into a function ? So we keep the calls at
>> the same level in this block
> 
> I can send a separate patch for this if you want me to.

Yes, sure


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



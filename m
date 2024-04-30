Return-Path: <linux-kernel+bounces-163362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A88B69E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8CBB20FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7E175BD;
	Tue, 30 Apr 2024 05:24:57 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095F5256;
	Tue, 30 Apr 2024 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454697; cv=none; b=Dhfd8+BYpV7afHta9kSj5kSg2+mwciJ3Mz6yaQpC0qrmnbkFcl0AjrNx/05XntQ14ewFA/Ye5gTvGV3RkyA43v3zw51U5rf7gy3C3rrZy2IH/VgiuokKptlHY9Vzlzso9Z5qyQw52MfPmbs0nbG6jwIMImdYXYmMLRKIbuoyEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454697; c=relaxed/simple;
	bh=Q/+tRiuXGN+EdbNSNGuhQr+t4BZW3Yq+oUqUaGly2cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nuff5UEzn4iseYc0MgPQVhqYq59tykVPst8DvJzTdYR18AVEgCF18yd/Ff8yah0nk42je4YQoZ+RKnF0Arx6t7zqIF6Hl40VqDAWy60JHcANTK0Gp6EtXznEqmD4Po06uWT95Oojp27jUm79QCcw+9SF/HeF+hXeuEIq0+KCukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so3115720a12.0;
        Mon, 29 Apr 2024 22:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714454694; x=1715059494;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yqirq+IhVG3Z/zsDGojXFevoBRau6B6rbnsmBlZgt0=;
        b=w56GUUotB8BaVZy4mZ+p+b4GWuPXmB3A0FND/G5vXllWSliznbgbO+04wfRqC3+Ghx
         TVxiK3sNB0tTqJhk9nz6zajSV8XidDhVgJGl0w0Szz14mbVj5kEV1jzc5soDPbhMs24a
         QGlbeHQTnPWUegDUPC1hjO1ddgmOfyEtPprtOHtSdWYH9K31dqGzkbCYK2L6CbR1Pz4m
         fuFinr2TPa2oJ8IxOCaFnpypEhMJak8bT/rDjwVSi9wWrPArV3KibPDPU0jrqTAQEZyi
         8fitubQfxtO+j8DSQ7rgtUT6cFajBTiBXTRGehLMaNy3X1716HC/V19zjz4hlMvl41mI
         3Xyw==
X-Forwarded-Encrypted: i=1; AJvYcCU/48SJh6+TLnpeAyPMJ0etcWpJoR/kN35otUkbecxrMdFlZAYfacyT+p6m9/7OGTUsK8Dhkz/zpjtEpMuqNhN3ETkYIstdXZ10RYOSudFJIR9u15brqVz0j2GKWiz2ywzdnBMor70nYT7QkZB8DcAbTYuKauPIrfQjqn11hWh9I0I7
X-Gm-Message-State: AOJu0YybBdxEiy/dWPYUSelAnkPuGRo8Jz4GOZPXz7opiGgZYG55CwZ3
	YAYdYsE2DLdF99Vf0yGCLPCEc2LvM9u3sUfiJX0aT8l2Q9mupg3J
X-Google-Smtp-Source: AGHT+IFIfQqyWXBK5ybhqL/zWTVvHjI/gredNQj5xv0j8YvW7clXeZWLO5YOWpSnXZicTPFqviVlbw==
X-Received: by 2002:a50:954b:0:b0:56e:10d3:85e3 with SMTP id v11-20020a50954b000000b0056e10d385e3mr10743116eda.13.1714454693472;
        Mon, 29 Apr 2024 22:24:53 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id t20-20020a056402021400b005728a272753sm995540edv.67.2024.04.29.22.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 22:24:53 -0700 (PDT)
Message-ID: <bf313102-e949-41d9-89f3-bff06a43d647@kernel.org>
Date: Tue, 30 Apr 2024 07:24:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when
 using prescaler
To: David Laight <David.Laight@ACULAB.COM>, Hugo Villeneuve
 <hugo@hugovil.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Ringle <jringle@gridpoint.com>
Cc: "ria.freelander@gmail.com" <ria.freelander@gmail.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20240426135937.3810959-1-hugo@hugovil.com>
 <17d2cc58-cf68-430d-9248-25abe4c5b0f0@kernel.org>
 <6ea689ace38d47f285efe026772efcae@AcuMS.aculab.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <6ea689ace38d47f285efe026772efcae@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29. 04. 24, 11:14, David Laight wrote:
> From: Jiri Slaby
>> Sent: 29 April 2024 07:39
> ...
>>> -	u8 prescaler = 0;
>>> +	int prescaler = 1;
>>
>> Ugh, why do you move to signed arithmetics?
> 
> Any arithmetic would always have been signed.
> u8 is promoted to 'signed int' before being used for pretty much anything.

Sorry, what?

C99 §6.3.8.1 states:

If both operands have the same type, then no further conversion is needed.

Otherwise, if both operands have signed integer types or both have 
unsigned integer types, the operand with the type of lesser integer 
conversion rank is converted to the type of the operand with greater rank.

=====

I.e. u8 is converted according to that to ulong in this case. So 
unsigned arithmetic happens.

> 'unsigned int prescaler' might have changed arithmetic to be unsigned.

The same as u8.

> OTOH you probably don't want a u8 - that might require the compiler
> mask an arithmetic result to 8 bits.

Pardon? Not at all.

Am I missing something?

thanks,
-- 
js
suse labs



Return-Path: <linux-kernel+bounces-84146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F386A2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6901286026
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2555E40;
	Tue, 27 Feb 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSmMs0da"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AB55E49
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074464; cv=none; b=gaeaUCxSN1oyWE5S9rqc1V6+jW0NDsJrNM0yatZ7tqv7MMhdZFcZs0wElTyf2XJcJLe0dJs6XObyxgBTl6Zh9ivr344TP/7lKz4Adtzz5uuDcnODEszPc5E8P63ysV/393aoSdCsRmIvRT5vnuvDn5UWYtfMNIEF1D/obcjupHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074464; c=relaxed/simple;
	bh=N6s5EM24N8uwVBdLY6ldG9C2KcTOtR96Pk5bivdRrxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsDw/Zbu18b7dqkg3ykuK4HELkd26QY2Zl3O2miD6RUaDa9ssC6ol1bCerHqwo1KHTPQGuskM3Wv658KEGryWX6z5Z7ggSAzxQnWdsIupnOiLLvuaHmpWqaTd+vFlycYJSYQGZMCRio1KINa9yi+LlIE+DfsflxpuBP0xl3wEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSmMs0da; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c66b093b86so240610a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709074463; x=1709679263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2DNGpzMTJVgXPXUid5ciEjp2iP/gKTG74Iv3lSZDFEw=;
        b=fSmMs0datz0jJkeHiIpz9+CKv3/C5GMHcFXzF2TdPIGY7rTw1OMmFisFIavLJDlzk3
         xu3aNH2jhym27oaPCZAUXDcSxwHXvLvlfEudiBuByrWs5EtvDD6Fu17LHjV+cbdJ8pue
         BHyioyR6BsA4rA6oG1vevQb0r4MdF/29tsc4wd57oZzYtO8ZCXGpaNeYyz+a4qtNyXOS
         j1P5EzbFJL0t5de/I3aZzGLK2k9VOZlw2J66AvHYbO7sQ2jm2wTfN6c+F8rWw/jRYx7h
         vWqA2hGWeoNlAf8PDL4dx4dJeic9B7jvljI7w2Bug/Chf6JNUYpZ0R/H+0aPZm0BIoXf
         Ks+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074463; x=1709679263;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DNGpzMTJVgXPXUid5ciEjp2iP/gKTG74Iv3lSZDFEw=;
        b=kkT2F3FCNvWpAJEWfXhifQexFEIyLD0c0Si7LLSIWOzs12NcAp6shKyihv83Lv6d6S
         BZeNaycimSu+MecpdnhUB0b7dmWm3kr7zSxGs+/aMIlihgqeFvEx9vGYBpzxFuhd6Lh4
         /j02oP8771rI1Bb1mdOBXGpgwDojb/kABXqnv5QEON8O8UCx5ZUqU3vBaVNLLxq9TZt4
         qYCrGbaq/7m0N0Q/SbqA8/KYiIHvF1TLyChEbgESFaddvyZH2NaTscYRzDdns4GBh6i1
         48Ic6iXat7amDWZrSzhKq7M/XcJmyNhEXGThwQ1huis9cU9WkqRfq0Zdm4x7WMb1TGTk
         hETA==
X-Forwarded-Encrypted: i=1; AJvYcCUuGEsEAQ11HjVgMEW7fimBfEV3PDgkACc3tsAfQDOrlPxpwOgYv435I91DVAmQFjuZD8b5TVE03khEh3cStJicCjXwsR7PdvONVW3o
X-Gm-Message-State: AOJu0Yx0bWuad/5T7erSvtYtnAjpVzQhEaknwzH5n1+m9EfEn3PU3hy+
	M/lGnax/bnR4hRJbPp0/XMuCcp1yBl6bgviWSGfSG4JccRa1dSeaddMAasjb
X-Google-Smtp-Source: AGHT+IGXX2BhoWZ6SCxXPH8NT7GN5baXJV0gB6TtbEvc5Bz/mGxOiVGHzCRqfvvjVaqnLCP1wXLDFg==
X-Received: by 2002:a17:90a:983:b0:29a:c992:198e with SMTP id 3-20020a17090a098300b0029ac992198emr973142pjo.15.1709074462484;
        Tue, 27 Feb 2024 14:54:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090b011000b00299e946b9cdsm71952pjz.20.2024.02.27.14.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 14:54:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <06c6f8b8-49ba-4b99-9483-0e4e5364bb1b@roeck-us.net>
Date: Tue, 27 Feb 2024 14:54:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stackinit unit test failures on m68k
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>, Kees Cook <keescook@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
 <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>
 <202402271401.CB43AB2E8@keescook>
 <1278e7aa-135b-0919-340a-788b9be6b5da@linux-m68k.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1278e7aa-135b-0919-340a-788b9be6b5da@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 14:33, Finn Thain wrote:
> 
> On Tue, 27 Feb 2024, Kees Cook wrote:
> 
>>
>> I'll send a patch!
>>
> 
> Or you could just not run the test on m68k. It's said that, "What the eye
> does not see, the heart does not grieve over." Is that not true for bugs?

Yes, that is exactly what I am doing now. Problem "solved".

Guenter



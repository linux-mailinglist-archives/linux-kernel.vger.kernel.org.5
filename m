Return-Path: <linux-kernel+bounces-73737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6551285CA40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889B41C224BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B3151CFF;
	Tue, 20 Feb 2024 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feJvcGfQ"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED0150995
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465692; cv=none; b=tWM7NghFXaOP4TsEZzhM5LLYCtYmJsirPzYYsGE48Rxp34dSWqF96+PdtjwXMbeR+y/JMir9E32QinlqIEa0Ht9NMqzabTFLAKueb7bvecG8oVsCYPSeYXu11YTNs7AB4XjUaTvaf5hAPOH0UCXU3k22mk7xLkCDnCXvHDdcH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465692; c=relaxed/simple;
	bh=0EvuBtAlnKWVpGV1ocm2whvJc9HJAq31wxaqE2+3+cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh9iZg+VAExKUgJxOmQae1C41vnFDLQQsh7/RmryI23UqBPSgShzkLXMqDsULtYyeSrzXp1xtHkO/hSiD3I5WrrycbqPNcuwxutjViizMWE3S78qUxe3oeRk9KOzss+v0XKPEa9Fvyc5Q56fJaoVcKkWlXlSIDMANZvCWBjqps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feJvcGfQ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59fd69bab3bso787389eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708465690; x=1709070490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iHHT8LecSskYgWyLHx6z6eqTK/dqCiveP0KosgAQ1wA=;
        b=feJvcGfQHk2N/PIstr46ciAesmLx0LR1aaouHyA85pb23nNZvd9LSMfWfCaWw5yDT1
         tH4tXGY0qrU0a6eoMuTJ91zf3Udk6JAVJe6qVfhbYi/goEoK7c+Lvh2nU0zkuOPogfvu
         klK6d517VhNVHQuJgN1skil/rv8eeQGomA+0FKXGvNjyf6BNJe8mcPOrPDmaXZ5GOqkX
         kmlCdBp+7H+G/hnxZX+sCkpiWthAQt/pE05Cti+r5N//co0avxs6SYeg76ghVAwxG9YT
         ShVQRPpsCm5492aJT8A+S4Jwij7QcZ1hpq3MomiXOSrOrlaoclZCRvDiNiiyY58oMsAX
         NRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465690; x=1709070490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHHT8LecSskYgWyLHx6z6eqTK/dqCiveP0KosgAQ1wA=;
        b=krJhvSYrVH1ZOqDJR9tvDUxnZXpjvVtmuJSz8NDC1C5rKlqbAyxF/6HsTqR6rkzd6Z
         WsVn5XlEuj3DP8hxzRtMjEnQ6Cr0aSdXpKRZDRN/Q49dfJ+NQAqFP+5M92Jeyz/UrU+2
         +XZ5catXdarhLhw8wyCor5nQWmvfqN23LV8tIpJCR9LorVAzqnWSJauiudv1jEBcKxEh
         lPNTneDy5gm+WBix3+47w7/CpRb+sAKeqWXlheuSKnrTMSiKAgISMcERoSga27YmJH6F
         3oMdDygRtTd6+o7qYr38Sjw1/Rh2hwQejmogmiqoPU9KLmzCb7xXHA4g9slw212T9XQE
         FjEw==
X-Gm-Message-State: AOJu0Yy5uKYwa2RCafwzU/yBiyWkHi/ooGTBaGa/CSqk2KoBpX1U27Y5
	N0GetGo5521EbfoBJt7JHrYjWnMucjzuKWzblTb0EhYXtpvPtb+2
X-Google-Smtp-Source: AGHT+IHl1VS4jKXMjmMjwAia1STQcVJlRJJ0jB7z28WFtq9V+muy+w3hGvJT7kM8JSPaDkrftATjUQ==
X-Received: by 2002:a05:6359:459d:b0:17b:59f9:b691 with SMTP id no29-20020a056359459d00b0017b59f9b691mr156311rwb.1.1708465689667;
        Tue, 20 Feb 2024 13:48:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t20-20020a632254000000b005cfbf96c733sm7150069pgm.30.2024.02.20.13.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:48:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2374eaeb-fa34-44b9-a945-2cd871aacf7b@roeck-us.net>
Date: Tue, 20 Feb 2024 13:48:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.8-rc5
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net>
 <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Actually,

On 2/20/24 11:57, Linus Torvalds wrote:

>> Commit a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test"):
>>
>> +       u64 mm_size, ps = SZ_4K, i, n_pages, total;
>> ...
>> +       n_pages = mm_size / ps;
> 

Turns out it wasn't this code, but

> Now, the __moddi3() is a *bit* more reasonable, because I assume it comes from
> 
>                  int slot = i % 3;
> 

this code. Sorry, I guess I should have spent more time on it.
Just declaring i as int solves the problem. In my case I used
gcc 11.4. I since also tried with gcc 13.1, but that makes
the problem worse. With that, I get

          U __moddi3
          U __umoddi3
          U __umulsidi3

No idea why a single assignment would result in three undefined
symbols, but there we are. This is with xtensa, but I assume
the same is true for other architectures.

Unfortunately, I can not test your attached patch because the
DRM unit tests blow up my qemu test machines.

Guenter



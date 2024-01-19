Return-Path: <linux-kernel+bounces-30938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6383264A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16102285C88
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22624B2F;
	Fri, 19 Jan 2024 09:07:07 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308023748;
	Fri, 19 Jan 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655227; cv=none; b=s4G8NALHM88prmaAIoZgj72nqZpTdak57q6Z5I+ppXyD0SokaYBcfKP94M6QL1DxuhmIfVSmFP6wfoxQOkTBcqwy/WkgPx1s5EZ9Gogq7hnyp8WQMqN491M7Qzg7gPka30XSz1TiY/aPFJJ8K2RSJxPeyz8iZdee5npjoM6Lk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655227; c=relaxed/simple;
	bh=Slv8d7eQKvV+eggMm4UFOE19AueLbGSZmiXhxrd9QK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gonBhCw7eALs4/dcERGezThlzfm0DzNUYdZqxphTahgMuMg3H0/l6MV8HW461e6lTsfIa2eCieTObvDcGXaM9/gWr90X0I9Y+/QLg9q90ZJIXa2/lRrSz+jLx+nvfUlk2V69D5Vu0MPdoCgXqc7mkWSGIcktYRYLthFoeLNXgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso1344095e9.1;
        Fri, 19 Jan 2024 01:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705655224; x=1706260024;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoYThNNS5MoAsIIGpVFVtHuX2O5JRpT/wTmVa+X2uAo=;
        b=AcliPhbTipJinxepqeCJgzCU7EJBfJPB5iMZud0TQxl3ztLA7uH7cVgLozhwTvASBw
         gz3KnuiqeYykXemKeFDybGS08HQ9xwB5yLknK0ZC8r6bPG0pq95ao5vPMHwCdlSdE+Ku
         CVBGp7tQ4A8jLeoBHwHrCsRnmb5nFWAKpElZ2CCl36QEYfJEVnP0nyAIvzPPercxntET
         LrjDFLq9SPgKB+elU5BDHcrN9m51zwhS8ZPcoR0UuC5bA6YgF+0DPjANPklZmW5yhDp7
         TpQNzl6EC38uzSI765gN5Z06KJuwhIHQODsviEI2VDz84ACjP/DNJWzg0KnjuFACQGhD
         2DTg==
X-Gm-Message-State: AOJu0Yxtwm6S5I+677zA4XsWjNoeMzCDoMBDPfA/4cw9WG0jF2cUigk8
	LjmLGKwVNRgGkFQAu87sDBpmJJuHScSH4S3a+KzwGWBk2lQNHL/A
X-Google-Smtp-Source: AGHT+IGCyPMa+NQSKe1KBnX5wxlxmtW4yJlidcrdOIiPxBbLWQeNbx7aj/Pyr9iu1PA92u8+QYQ7Zg==
X-Received: by 2002:a1c:7507:0:b0:40e:437a:1b56 with SMTP id o7-20020a1c7507000000b0040e437a1b56mr330587wmc.143.1705655223557;
        Fri, 19 Jan 2024 01:07:03 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm2223128wru.46.2024.01.19.01.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 01:07:03 -0800 (PST)
Message-ID: <8f3f85d0-866e-4e5a-8177-05c26c08b278@kernel.org>
Date: Fri, 19 Jan 2024 10:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] tty: serial: samsung: shrink port feature flags to
 u8
Content-Language: en-US
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-18-tudor.ambarus@linaro.org>
 <CAPLW+4k091328krLB_KdHyobG-pR--Rt5WaN6c1ccpgdV8ry7Q@mail.gmail.com>
 <76e1dc42-cabe-4925-8aa1-c8f733fb36a2@linaro.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <76e1dc42-cabe-4925-8aa1-c8f733fb36a2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19. 01. 24, 9:56, Tudor Ambarus wrote:
> 
> 
> On 1/16/24 19:03, Sam Protsenko wrote:
>> On Wed, Jan 10, 2024 at 4:25 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>
>>> There's a single flag defined as of now. Shrink the feature flags to u8
>>> and aim for a better memory footprint for ``struct s3c24xx_uart_info``.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> ---
>>>   drivers/tty/serial/samsung_tty.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>>> index 5df2bcebf9fb..598d9fe7a492 100644
>>> --- a/drivers/tty/serial/samsung_tty.c
>>> +++ b/drivers/tty/serial/samsung_tty.c
>>> @@ -90,7 +90,7 @@ struct s3c24xx_uart_info {
>>>
>>>          /* uart port features */
>>>
>>> -       unsigned int            has_divslot:1;
>>> +       u8                      has_divslot:1;
>>
>> But that's already a bit field. Why does it matter which type it is?
>>
> 
> If using unsigned int the bitfied is combined with the previous u8
> fields, whereas if using u8 the bitfield will be independently defined.
> So no benefit in terms of memory footprint, it's just a cosmetic change
> to align the bitfield with the previous u8 fields. Allowing u32 for just
> a bit can be misleading as one would ask itself where are the other
> bits. Between a u32 bitfield and a bool a u8 bitfield seems like a good
> compromise.

Why? What's wrong with bool? bitfields have terrible semantics wrt 
atomic writes for example.

-- 
js
suse labs



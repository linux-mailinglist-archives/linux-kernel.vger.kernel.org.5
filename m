Return-Path: <linux-kernel+bounces-151078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8C8AA8CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2262028155A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38773BBFC;
	Fri, 19 Apr 2024 07:01:30 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D479473;
	Fri, 19 Apr 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510090; cv=none; b=cvV1CD4nhdZj6z6tFnY5hFdUiw6uDlvwHZZ7qi65Yx61d2x3CpMTRoVzea71uj3AfW1NClSns+i7BdyuxPHocihIcjpPc4/cc8Kr9OBYcL/5SmEg1Mw8mgEu0Hk1PKmCsrnQA3aBJr8Bas0IG47ZP1GiSzE5YVaSIjXQt/gpV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510090; c=relaxed/simple;
	bh=sH1bmGiqxkK0mQrxS4tP7f19KIwVvxNpbYcGXlJTqRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsK+pOaIpu21YcVAzdpzk3pSjAx/eGXjBHlWXCTCkAj3y8X3RG1CD3noE+JOKMdCj6TM3cUD5wSDdvkEVdTn99Szj6tJqX6CbkCl+qwUQ4LwBaJB7hZiunECJ/sjd31Qh0j9KqsvSJ8LqZ0GiyIjAzlAnOQasV1qJj2cZB9x0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2da08b07157so20685561fa.1;
        Fri, 19 Apr 2024 00:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510084; x=1714114884;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E/MdAMpPbSlbHO+k6ZK0j1SLtIJtidvuVwVd4MJDGw=;
        b=ccizK8AmLWpip/v5iWbiQU49gkVvk7Z6SB9HqOIYkBkBKUgwTlTn5QrXlLrOMSh5l6
         vU8brALV4zb6BUH657GFoMtoDR6BP2VakW4/UDN/NyuRKdmx/fHYVcuGVdCExLGSVWsq
         LVFHyibm8qZjyc1E++7jdd1Pil5NaiOs0hAb+hUXOt7j76/jz0YOflSvdf0K6Ifg1LNh
         AJIFcalHVFGZ+DVDWcvh9nQpt2bHnZLR05PsNYcjMG3uadMzwthk2nybOJmMYKEF5o0G
         pRUDavwQ8DBhMKeeP5iqRzv4ZzEocTWztpcVyUHszhBjL/wrtkHw9+UoWnazZ++544R/
         GIag==
X-Forwarded-Encrypted: i=1; AJvYcCVbykx8u4++s+2DFURX5Qfm+ORE15rOlSdTCIOEtlhQGtqAtBKUYJzo7+pYWTZAsrlybpzkaqxz19ZiPA0OFrGsH7mjFe7m4OtUOhnO
X-Gm-Message-State: AOJu0YzEkfmyAeWfYkb956lWbMy5YfrPm21xWOvhmlV0UeUUr0ac1ccj
	GGIEjNZwGqBt+5LGMPSsZij2OUtsnoWJqFwoya7Oh9ZMXQ+dZzP0TTwzqQ48
X-Google-Smtp-Source: AGHT+IG/pgr30UMciHlKbZ2mBniQgj5SwevI3RmxjUw6/BwTHbSQnqzxpGN8sHyp1bjkELThiFay+A==
X-Received: by 2002:a2e:97d4:0:b0:2d6:8868:f1a6 with SMTP id m20-20020a2e97d4000000b002d68868f1a6mr807106ljj.43.1713510083993;
        Fri, 19 Apr 2024 00:01:23 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ko18-20020a170907987200b00a5565ee5c24sm1808580ejc.0.2024.04.19.00.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:01:23 -0700 (PDT)
Message-ID: <4a7a1c35-f1f6-4ed3-ad57-d71891220219@kernel.org>
Date: Fri, 19 Apr 2024 09:01:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] serial: exar: remove unneeded parenthesis
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Parker Newman <parker@finest.io>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Parker Newman <pnewman@connecttech.com>
References: <cover.1713452766.git.pnewman@connecttech.com>
 <1dbe1847d92dd34d223c6dc6b5cd0731b78e98e5.1713452766.git.pnewman@connecttech.com>
 <2024041951-paradox-stable-320e@gregkh>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2024041951-paradox-stable-320e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 04. 24, 8:58, Greg Kroah-Hartman wrote:
> On Thu, Apr 18, 2024 at 11:36:30AM -0400, Parker Newman wrote:
>> From: Parker Newman <pnewman@connecttech.com>
>>
>> Remove unneeded parenthesis from several locations.
>>
>> Based on feedback from:
>> Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com
>>
>> Signed-off-by: Parker Newman <pnewman@connecttech.com>
>> ---
>>   drivers/tty/serial/8250/8250_exar.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
>> index 01748ddbf729..10725ad0f3ef 100644
>> --- a/drivers/tty/serial/8250/8250_exar.c
>> +++ b/drivers/tty/serial/8250/8250_exar.c
>> @@ -317,7 +317,7 @@ static inline u8 exar_ee_read_bit(struct exar8250 *priv)
>>
>>   	regb = exar_read_reg(priv, UART_EXAR_REGB);
>>
>> -	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
>> +	return regb & UART_EXAR_REGB_EEDO ? 1 : 0;
> 
> Again, spell out the ? : stuff here please.  Using () isn't the problem :)

Could this in fact be inline bool exar_is_ee_set() (or alike) and return 
that regb & UART_EXAR_REGB_EEDO directly (w/o using ternary at all)?

thanks,
-- 
js
suse labs



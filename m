Return-Path: <linux-kernel+bounces-81632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC06867888
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C266C1C28C99
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD812CD9B;
	Mon, 26 Feb 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilipB5Yx"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59012C81C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957824; cv=none; b=fht0sF+8GgFlnmvl5OmHMamZJMmWqieYNzvW1l4ra5DlEBXLbXNgKYllIIJ/ILXcUBaIDp6lbRhEvOuZ4int+34wOEEtF9Dk+9b7Xg97RYM5WElUi/9pki1l2Mf8czu8Qz4FRzu6sgY0sruK3eihbWFxj8at6aPnB/u9TEgbxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957824; c=relaxed/simple;
	bh=aahv011X+X2bCJWogAZ/p9o524/qNn1McMTkxyr3Rtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn6i43h4Fk7KE1FczJs4f1XL0sp1c5nDgfONSiSkvsL68dYnqMKRYzuNscXTWzc76f5Pd54jYxexxj0OBnT+ca4mU1atgSnrgaReNCZrB/WzlhKUDUdhyezmaUJ0MDYVsM/cLxEOF/9R1BCyWl0C6D5M9XzuiHA9LIUNnubrgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilipB5Yx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4d869b019so1350286b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708957822; x=1709562622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8iQr8HwaNQNOUci9FEjsnMVRNF1lAkHI7cHoltg2ljM=;
        b=ilipB5YxDi9teMnT+HqcoDuxJbWH0djiohg4ShFXoxYoQ2nFiWFKrHsniRuB/3RXua
         WURIc+cRzCpOiJ5kXV8M6Sp087cmoyk2Lf5mDO3UEzWQnmLQ30ZBknmF1Jgjau3EC2Sx
         0Qm0HNxS2LkV6oJaxApRxZ4b8gPTPwiwitWxWZIWrsCzdrxeY54E0RzbCZbaBr5SJWQx
         CqQm3f0wzheDUNFytZvxWBWR595qhSAZfyhzXigStHrf2EVqoJX3jY5Gm/w3g14pMrK1
         74HrxYQB9g1ccxIy0JyJGUYbkcUarustQvztuk+AMWP69zEUcGfDLuUsFJYHz9cf+grJ
         o6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957822; x=1709562622;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iQr8HwaNQNOUci9FEjsnMVRNF1lAkHI7cHoltg2ljM=;
        b=E2RZgQZDrsQ02DoUQOEePzmLPraQrXWrhqkjolLKvFtzkes1yPBQ7Sl0tTOPARrBt9
         MLSfXmT3+7Zs/odvjYzIfG5WtIWwu1Crsfga3hRGO6mwymLXcq6KaY+123gUDptF+8jX
         NMI+GG+qd+OvapBQIvDWnvYJ/+My3hl9PVp6asg6Ck6dvLI2SPzUh6GKH8tWiP46/TY8
         UNEpBllM6RZk4beuvj3Ld3nW0P71MToOeFCSc2mwWyOdG87w8Nk+Jn+HJVoWoeOkf8J5
         SmVyTOeXMYcZ/raMlUVSRC/UZc9W6lwPB4eXo7+q1FSbfNKbPz+B8lQ+x/VcSDZYH1si
         0WDA==
X-Forwarded-Encrypted: i=1; AJvYcCVMvy7b0VvkwDqrbXHCAB9AIfln2mXiteY1aWEYm9slH0rs3fdiBrAWfW5WMc3UUFmUH8bnH9vFjp3ijBgTc4qiqGdb2mNmi9atNYl9
X-Gm-Message-State: AOJu0Yw/sEOhBtcyYh2+QHqTEqyX2tFdOmbU8QveOJzHq1QdWGrvebXU
	9qb6CiFZi8lpieYlUpA7c9aIhnjYFK29zdEQlpDRsj/yrau4wECDdtsxO2vC
X-Google-Smtp-Source: AGHT+IE/jOB64UWBuvL7paVh492qVScfuVVd+meJwV1R/hb3OgfzHSZG6oh0sQGGxby8dzh6SpwmDg==
X-Received: by 2002:a62:61c2:0:b0:6e3:fa52:2f26 with SMTP id v185-20020a6261c2000000b006e3fa522f26mr5390782pfb.8.1708957822269;
        Mon, 26 Feb 2024 06:30:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a402000000b005e45b337b34sm4028346pgf.0.2024.02.26.06.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 06:30:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f5e40f0f-d2e3-4dcf-90a5-3bf65051cce0@roeck-us.net>
Date: Mon, 26 Feb 2024 06:30:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Drop myself as maintainer of TYPEC port
 controller drivers
Content-Language: en-US
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
References: <20240215202039.1982539-1-linux@roeck-us.net>
 <Zdw+oku+pBOOtqnu@kuha.fi.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zdw+oku+pBOOtqnu@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/24 23:32, Heikki Krogerus wrote:
> Hi Guenter,
> 
> On Thu, Feb 15, 2024 at 12:20:39PM -0800, Guenter Roeck wrote:
>> I am no longer involved in Type-C development and not really current on its
>> status and progress. Recently I have been doing more damage than good.
>> It is time to go.
>>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   MAINTAINERS | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 73d898383e51..ae3283f9eceb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22864,9 +22864,8 @@ S:	Maintained
>>   F:	drivers/usb/typec/mux/pi3usb30532.c
>>   
>>   USB TYPEC PORT CONTROLLER DRIVERS
>> -M:	Guenter Roeck <linux@roeck-us.net>
>>   L:	linux-usb@vger.kernel.org
>> -S:	Maintained
>> +S:	Orphan
>>   F:	drivers/usb/typec/tcpm/
>>   
>>   USB UHCI DRIVER
>> -- 
>> 2.39.2
> 
> I'm sorry to respond a bit late, but I wanted to also thank you for
> all the help.
> 

Thanks. Sorry for my recent mess-ups.

Guenter




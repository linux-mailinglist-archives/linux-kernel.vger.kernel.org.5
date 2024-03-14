Return-Path: <linux-kernel+bounces-103731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845187C3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748AEB215E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C3A71750;
	Thu, 14 Mar 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOPomm6z"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8462BB13
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444655; cv=none; b=a4stc6cnCixZet1SFg8XC84YT5nZ7cJKy0fVQyPuYL2/gAwtp5Ajr7O3QEej3HPho3eFVw7cHeQD30ab0+bk6W817UFMqnSRIk5dsN7FxR5Kib7lmM2Cst3H/6Lr0yoiysMTgSTeitQnbCTLKlkmRR/VPtw1D7WSZDIoIFvV+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444655; c=relaxed/simple;
	bh=E7bxNoSXeMPvwqTd/XGotPG6fRmIhcsazNJ5oaVedrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnGEQJApGlKRdcDOspyaBLShxiILtdWnxo14oJoqkQB7pleKKD7zg7Y4k+heCKO7VxB2CkH2Mg36lPGxPs1/dpBuse7Azg2SgG6Fs/5Dm2ueQ5eLGJcdM9aKxnI3OiSh7oXU6zqxzQ7Z7xIOXrBGstd156mJJ3lmTJxdJz16lvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOPomm6z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dddbe47ac1so11228755ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710444653; x=1711049453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mwq/P/ALLFHoh8lUVu+KWgfgfXjUn8IaAQTlYWpuO4=;
        b=DOPomm6zTIgoe3vgFVrr2bWaA3Rb+DiW2m6Vao1GFItV9Jme7E2ShJ592UCAv1HwOQ
         EyEFRg7Xj/jopYOK/p9zeZAGYkILAXkMoOg01tyI1bk5m3zYi4ykwggK+TK4fzXlVK16
         3AsK7rUCt+DCkydvZ4rxqkz+NNJQ3M2Qn1Nsaxjx2EBw/kaMIZau+Chep61GvKHK4meM
         j8SO3yeujcp6A2G4mkH4x/88W06Spvst8vmnoiKUYl+RrRGCDUB3T88nmN3aNmddOiHs
         tagDJlYNbd0R0KtlmlRkQxyvj2FssZYlZXsxbxa5c/0qeiQNcvTeLECdGsOJSa36QL4L
         NbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710444653; x=1711049453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Mwq/P/ALLFHoh8lUVu+KWgfgfXjUn8IaAQTlYWpuO4=;
        b=FVAcg0Desn9BrS9WI+dFa26uXxnIjESPZF7pw8R0B4I1nWFVFme61YsZHKpWu0o1IQ
         1dH7oPW0uS+DvHIuu5ddALknORafLTUOuwHVCM9z139IjidJbqAOjm61+vHfwjKIRc/z
         LO7gxHNld84b93gdH73OdKfebZAnEDxKhEco1JD3oQnY9FUiHGrzll8rRV9QNKi/r5vG
         k3LgvWmarmUE6S4UCzeRdpYhwPtCiLduiL7jPoJydeexImxHC7tk0Ku/yQFCZftCKwiu
         /gR2SXm6g4sSgENTP128XRxGPvc/azgh/zDrnBIRMo/8Rj8kbpy4bdQHl3/cYGucoo0t
         JMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcafm5joPDmH8ypeUSzGjALjYK0ffn0b8rWNZLqFdO+WtU2rIMln7iQFgpKOkZJ6YhoJBNnb3HCps88pjZipJBYGxONjUZoBe7d5Sl
X-Gm-Message-State: AOJu0YzdSkvloY9xV4Ga8ls8UthqVA3Ecd9oalP/UTaHoPPXagjriF47
	TERRymIG1z4UsIR68ydCm4NougXyTLJmxSkaF64Mc953+sOtom/f
X-Google-Smtp-Source: AGHT+IEufxfnOCQYVghY8uO8TnVD0f8o1QFFiJ6gEnkx91MAksBMfGt8VbTTzTLQAfmELfiM5KJpQA==
X-Received: by 2002:a17:902:c948:b0:1dc:b16c:6406 with SMTP id i8-20020a170902c94800b001dcb16c6406mr9491215pla.6.1710444652612;
        Thu, 14 Mar 2024 12:30:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b192-20020a6334c9000000b005bd980cca56sm1090095pga.29.2024.03.14.12.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 12:30:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c34e1c68-254f-489b-925f-0e7906b3a89f@roeck-us.net>
Date: Thu, 14 Mar 2024 12:30:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: time: Add faster unit test with shorter time range
Content-Language: en-US
To: Rae Moar <rmoar@google.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Diaz <daniel.diaz@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240313210124.2858729-1-linux@roeck-us.net>
 <CA+GJov5V5+X9FY7MD1Q+eBeEcJeUjQEuK3Qw8LJ0Oho9KtuXtQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CA+GJov5V5+X9FY7MD1Q+eBeEcJeUjQEuK3Qw8LJ0Oho9KtuXtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/24 12:05, Rae Moar wrote:
> On Wed, Mar 13, 2024 at 5:01 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Commit a547c4ce10bd ("kunit: time: Mark test as slow using test
>> attributes") marked the time unit test as slow. This means it does not
>> run anymore if slow tests are disabled. This reduces test coverage and
>> is thus undesirable. At the same time, the test currently covers a range
>> of 160,000 years, which has limited value.
>>
>> Add additional test case covering a total range of 1,600 years. This test
>> takes less than a second to run even on slow systems while still covering
>> twice the leap year calculation range of 400 years around the center date.
>> This test can run even with slow tests disabled.
> 
> Hello!
> 
> I really like this addition of another time range test. This looks good to me.
> 
> Thanks!
> -Rae
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
>>
>> Cc: Rae Moar <rmoar@google.com>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   kernel/time/time_test.c | 35 +++++++++++++++++++++++++++--------
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
>> index 3e5d422dd15c..15c6f3a5e73c 100644
>> --- a/kernel/time/time_test.c
>> +++ b/kernel/time/time_test.c
>> @@ -47,18 +47,18 @@ static void advance_date(long *year, int *month, int *mday, int *yday)
>>   }
>>
>>   /*
>> - * Checks every day in a 160000 years interval centered at 1970-01-01
>> + * Checks every day in a specified interval centered at 1970-01-01
>>    * against the expected result.
>>    */
>> -static void time64_to_tm_test_date_range(struct kunit *test)
>> +static void time64_to_tm_test_date_range(struct kunit *test, int years)
>>   {
>>          /*
>> -        * 80000 years  = (80000 / 400) * 400 years
>> -        *              = (80000 / 400) * 146097 days
>> -        *              = (80000 / 400) * 146097 * 86400 seconds
>> +        * years        = (years / 400) * 400 years
> 
> This is tiny but if there is another version, I find this comment a
> bit confusing. Could you change this to maybe be "total seconds ="
> instead of "years =" because years is used as a unit on the right side
> of the equation?
> 

Good point. "total seconds" might be just as confusing, though.
How about "total range", "time range", or just "range" ?

Thanks,
Guenter



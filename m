Return-Path: <linux-kernel+bounces-144360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48B8A44FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD5E1F21231
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D432136983;
	Sun, 14 Apr 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9taQmLM"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E345136674
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713125200; cv=none; b=P4Pkty3mIS3SgIwsaO6ugTRUxBRNjFvR+sKhDPL8hgTH3zPGDq03Xpij77QpoytDeKQfM1MjDZt/haPjTaMMGE5b6uI5JE1IykUcgszNqKtHdZhPwIGM4tXgmzlm2MaRoUXFzLJbZ7IjGvweY4Nhb11TrXumgkZbfW+P5DAZksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713125200; c=relaxed/simple;
	bh=hzkgcZA9rBCEReGXZ1BToaXOkkZ7G0AlopjcOW1W828=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRWQleViik3/b4vkXI1KnuAbmImMh+F2XF3x/K2HVO1lOio6aXPWooyb0lndSlhIpGdGW94Z2TenByzEkqWOCcve4JtjgZBNZgfBdrfQ/Tu35MmSBfjjJHa6GvwR7XexpvcaUyfeD8xxwJFwWGqzWlsqXIGExNC1hKVTgv+1Hyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p9taQmLM; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5facf3161so102156539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713125198; x=1713729998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGfHknOus/9GyhBjzld26etB6pXH4O6fe07dtnoZtJ8=;
        b=p9taQmLMAbweGVGw2WbKZCQH+F4zxzErR/7ExCSFyL3BzXCcsikiKLb2/30kj09EV9
         QTysgWThyhDyOxbp4OHO5CQd1EM++jv4Zrd2AkTd6woJketYxe6gve9O5KMSAKvNPoZq
         88ygNnVJ84PSU7OpaI+EHzLGnj8LXwkKtlaYF5M6Fg2gffLoF0FFtX+qIRKf1ZYo3sBT
         FDFOxPkQVXd1wNjHOIEddZmu1Su89+NOsN1xWteFfkAg1MQYMByKvosTduwk+g0h4lhl
         JmVnjR6kQ7q7ulUmR/lECOC3NgoR/DeRSWwPvfMGh8B47wJYnE6uU/PddkG98+RcLxEm
         Lh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713125198; x=1713729998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGfHknOus/9GyhBjzld26etB6pXH4O6fe07dtnoZtJ8=;
        b=IOxmBdXNcCuAoAvLFTRGtGRliBBpV63OxpEALf/EPwT9fIB+wTVsnIBw+z0tCf4+X6
         xNwWl6kPXq4NjrUeHsFQK+KTGsBNwHgUpp7WvnIoFMk//eMD1HqffjNw12e0t1o1WWl3
         6rZJ/cfEsjvLRWmDQ1ud8bnH0RABG1Nfmppmeydnm6nfve+2rUg3w5F6bppZrSGI1tQ+
         Hk5kTz2O8A+jidqSm81zNkALzS53t4kKYycuGrsUv33PfcqFd9ankXI0DbXc5ogouBvT
         NERdiwMm+rcGxALjrp1hEon4OTm1Vm4C9govkybupNSOyUgCjLXYhKzPL8F7AiNLoZ4O
         jK9A==
X-Forwarded-Encrypted: i=1; AJvYcCXuI17xLmJ1PNy+lO7fVY89jbDGun8M/HgemxOWo+H6w/x75LvcMRykK6YSoOYE/tg+1RweWv3Ht55pSLhKw+ePs2p62++6dnD2tMll
X-Gm-Message-State: AOJu0YyHgG4Dj4beDZIPwM/64XRXhWE5bK08gRI05rauFzskkW45MEd7
	kMY20oVjbmXQx34HyyE13NHZsRdYc8UiGckba7ygJXRdJWhj6vUlz3osaRH4rRU=
X-Google-Smtp-Source: AGHT+IFYXBbtD/IOrHO3NdgNVg838YIoDuvznQyBmKua3T+35A6viwq+2YM1ZoNyhKdqyzpbde7pFg==
X-Received: by 2002:a05:6602:3942:b0:7d6:8f9:107f with SMTP id bt2-20020a056602394200b007d608f9107fmr12803844iob.12.1713125198204;
        Sun, 14 Apr 2024 13:06:38 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id v6-20020a056638250600b00482fa014961sm767397jat.138.2024.04.14.13.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 13:06:37 -0700 (PDT)
Message-ID: <ddb55ce5-59ca-4d95-b9a7-196bd583903c@linaro.org>
Date: Sun, 14 Apr 2024 15:06:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alex Elder <elder@linaro.org>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240414170850.148122-1-elder@linaro.org>
 <20240414194835.GA12561@pendragon.ideasonboard.com>
From: Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20240414194835.GA12561@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 2:48 PM, Laurent Pinchart wrote:
> Hi Alex,
> 
> Thank you for the patch.
> 
> On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
>> Several times recently Greg KH has admonished that variants of WARN()
>> should not be used, because when the panic_on_warn kernel option is set,
>> their use can lead to a panic. His reasoning was that the majority of
>> Linux instances (including Android and cloud systems) run with this option
>> enabled. And therefore a condition leading to a warning will frequently
>> cause an undesirable panic.
>>
>> The "coding-style.rst" document says not to worry about this kernel
>> option.  Update it to provide a more nuanced explanation.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>   Documentation/process/coding-style.rst | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index 9c7cf73473943..bce43b01721cb 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -1235,17 +1235,18 @@ example. Again: WARN*() must not be used for a condition that is expected
>>   to trigger easily, for example, by user space actions. pr_warn_once() is a
>>   possible alternative, if you need to notify the user of a problem.
>>   
>> -Do not worry about panic_on_warn users
>> -**************************************
>> +The panic_on_warn kernel option
>> +********************************
>>   
>> -A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
>> -available kernel option, and that many users set this option. This is why
>> -there is a "Do not WARN lightly" writeup, above. However, the existence of
>> -panic_on_warn users is not a valid reason to avoid the judicious use
>> -WARN*(). That is because, whoever enables panic_on_warn has explicitly
>> -asked the kernel to crash if a WARN*() fires, and such users must be
>> -prepared to deal with the consequences of a system that is somewhat more
>> -likely to crash.
>> +Note that ``panic_on_warn`` is an available kernel option. If it is enabled,
>> +a WARN*() call whose condition holds leads to a kernel panic.  Many users
>> +(including Android and many cloud providers) set this option, and this is
>> +why there is a "Do not WARN lightly" writeup, above.
>> +
>> +The existence of this option is not a valid reason to avoid the judicious
>> +use of warnings. There are other options: ``dev_warn*()`` and ``pr_warn*()``
>> +issue warnings but do **not** cause the kernel to crash. Use these if you
>> +want to prevent such panics.
> 
> Those options are not equivalent, they print a single message, which is
> much easier to ignore. WARN() is similar to -Werror in some sense, it
> pushes vendors to fix the warnings. I have used WARN() in the past to
> indicate usage of long-deprecated APIs that we were getting close to
> removing for instance. dev_warn() wouldn't have had the same effect.

Honestly, I feel somewhat the same way--that WARN() has a use
that differs from dev_warn().  E.g., in places where something
"won't happen" (but conceivably could if someone was developing
a future change and violated an assumption).

Nevertheless, if panic_on_warn is used in Android and cloud
scenarios as Greg says, he's right that it affects many, many
systems.  Perhaps it's better to more strongly discourage the
use of that option?

I saw this "don't worry about it" message and felt it at least
ought to be toned down. The broader question of whether WARN()
should generally not be used might need some more discussion.

					-Alex

>>   Use BUILD_BUG_ON() for compile-time assertions
>>   **********************************************
> 



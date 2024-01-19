Return-Path: <linux-kernel+bounces-31109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED75832919
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09B828570B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D464F1EC;
	Fri, 19 Jan 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPl4cSsA"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0504F1E0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664581; cv=none; b=mJhAu3Xsamys1HSQNLBpRofmzU0Jf/f5/O8gXy33t6WowCPJQntPTvJzD81wXbkL7yqAUdc+5HWpx8J6c1UQArN9TVMFPeqlZrvyeR3Uc8IdHywg1qqhAXAcSlk4t+4XH6pWI5fW9Jn6LWqesYkWbTzq6apyE4c9qkEMjAB3fMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664581; c=relaxed/simple;
	bh=puKTQTWVMJIxLcmh/moA3FWN4wosFtK2VPfcC73Sd2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGZcmaqAxLKnRLZOG3LKt7yOze4u5IFQvrnWM8riMvekQkUt+Shewowymn5xfZ7wrgwIDFQf36KTCm8UDxidwG4Mn3RiaaUh8BoLhlMBFqBQRBGOq/PbbEHBwZpTZ7gn45ThRe2beN8b3l+n5pjozD+iq+Mu73+i4KQ3R4XOaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPl4cSsA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-429e6ed0b32so1692401cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705664579; x=1706269379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jebv0xM92fR/L3N7cwyKKHF03mwyuCyd6SEYpSpuNYY=;
        b=nPl4cSsAoaZm1vIf9TLyy5UW+3Ispj6stVf+E8p5Rz9YB80WfGUbNpeX1fFGrpjoiq
         LZWmeRRMrbPzwEq0x3Le2xwCNnz7LmM4Mtd8NsTwg1gYbaV5MAZUX6DJvIEx0f/Wzx7O
         BEvAIJNT1dDx4BDbOnho2a19wAOh5tCGkhsWxVgKB+K/wKRAoYMg2v0yYLLi2QxpjvZu
         OUeMw+S3Ir6mKJNSX1YhL1rIaGyFn128woxnECmWKLiOwfmReLuRvzT+FzKiiXJCczHV
         GFyh/6daMAKzMiyCFScRp4UlD/+iZBttFlXtu++3Nu/pWQ7srP0OIgQFatx7YJBPTZ3Z
         1sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664579; x=1706269379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jebv0xM92fR/L3N7cwyKKHF03mwyuCyd6SEYpSpuNYY=;
        b=OwTUXANf594XaHDTI7W+SLIs+fVnRLMeeuRUy4jPgsV2o0p2FQgsDJQkc6M4/I55Td
         P5YzvJNidVEqUD9JUnSQ6LobkcUYftHVjpua5cO5eqHM4V0nThIoJgjwTjjSKHDTB0Pu
         FoYc6m46DDTyCM9jgEQ/7RlZS3xvNd6vjeNMFfl8Ohi9uy0Wj+wlWimOjnRyVhFSe2qq
         RYwR7WfqX5GE6gZsQqDbfCkDlLUDFlierbaOh7Zy7sx/MnKYs5rC0mmS3Zw+AXW581p/
         sQqA6ai6X0kOpVBibGNaUFN2veenkS5Rsao3LNP0VTgdN2UlBcW9mgzFtmk9bMYBo/Jp
         pPPQ==
X-Gm-Message-State: AOJu0Yz6LDRj18noXjwFLCMlS7K5lxV6JXUDhYoxnv2TqubMOsoypVZo
	v4LmsEXKoZm6NqjuJDapOr/y3/Xn35/9RsbiiV2+BxRDNCyW7/U+KKNc8qZJ/H62JA==
X-Google-Smtp-Source: AGHT+IG6xGQYy4k/R19EzxLIQAVWbyxB5r/NfJnwoBVsxvab+7PPXbRFatvMcLfsQ3+3tfK/Cp/j8w==
X-Received: by 2002:a05:620a:1a16:b0:783:8d1f:8f0 with SMTP id bk22-20020a05620a1a1600b007838d1f08f0mr586339qkb.6.1705664579289;
        Fri, 19 Jan 2024 03:42:59 -0800 (PST)
Received: from [192.168.1.157] (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id w26-20020a05620a095a00b007815b84dbb3sm6003145qkw.49.2024.01.19.03.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 03:42:58 -0800 (PST)
Message-ID: <ab907c56-5d91-482c-8308-fe06c22c7f55@gmail.com>
Date: Fri, 19 Jan 2024 06:42:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rts5208: Add more details to Kconfig help
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240118191703.89535-1-jklott.git@gmail.com>
 <ce1d6680-a7f5-4939-a47c-3079e7136c28@moroto.mountain>
Content-Language: en-US
From: Jacob Lott <jklott.git@gmail.com>
In-Reply-To: <ce1d6680-a7f5-4939-a47c-3079e7136c28@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/19/24 1:34 AM, Dan Carpenter wrote:
> On Thu, Jan 18, 2024 at 02:17:04PM -0500, Jacob Lott wrote:
>> The current help text is short and triggers a
>> warning from checkpatch.pl. This patch adds more
>> details to the help text which should provide better
>> information for whether or not to enable the driver.
>>
>> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
>> ---
>> v2 -> v3: Fixed spacing and newline in text
> The commit message is still not line wrapped correctly at 72-75
> characters.  It should have been:
>
> The current help text is short and triggers a warning from checkpatch.pl.
> This patch adds more details to the help text which should provide better
> information for whether or not to enable the driver.
>
> Or:
>
> The current help text is short and triggers a warning from
> checkpatch.pl. This patch adds more details to the help text which
> should provide better information for whether or not to enable the
> driver.
>
>
>> v1 -> v2: Corrected line spacing based off feedback
>>
>>   drivers/staging/rts5208/Kconfig | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
>> index b864023d3ccb..c4664a26ba3b 100644
>> --- a/drivers/staging/rts5208/Kconfig
>> +++ b/drivers/staging/rts5208/Kconfig
>> @@ -3,7 +3,11 @@ config RTS5208
>>   	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>>   	depends on PCI && SCSI
>>   	help
>> -	  Say Y here to include driver code to support the Realtek
>> -	  PCI-E card reader rts5208/rts5288.
>> +	  Choose Y here to enable support for the Realtek PCI-E card reader
>> +	  RTS5208/5288. This driver facilitates communication between the Linux
>> +	  kernel and the Realtek PCI-E card reader.
>>   
>> -	  If this driver is compiled as a module, it will be named rts5208.
>> +	  If you opt to compile this driver as a module, it will be named rts5208.
>> +	  Selecting N will exclude this driver from the kernel build. Choose option
>> +	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
>> +	  When in doubt, it is generally safe to select N.
>
> In the original code there were three lines of help text.
>
> 1)         Say Y here to include driver code to support the Realtek
> 2)         PCI-E card reader rts5208/rts5288.
> 3)         If this driver is compiled as a module, it will be named rts5208.
>
> The minimum that checkpatch wants is 4 lines.
>
> However, I feel like nothing you're adding here is useful information.
> Some of it is just confusing like, "This driver facilitates
> communication between the Linux kernel and the Realtek PCI-E card
> reader."  That line feels like information, but when you think about it,
> it doesn't actually mean anything.  The second paragraph is just
> repeated information so it's kind of a waste of time.
>
> Don't just obey checkpatch for the sake of obeying, if we can't think
> of anything else useful to say then three lines is enough.
>
> regards,
> dan carpenter
>
Thank you for your feedback. Based off what Dan has said I would agree 
that it is best to leave the information as is.


For the future when talking about line wrapping I've been going based 
off VSCode's row/col count, is this not correct? For reference when 
writing the commit I would use a new line before hitting 72 "col" on 
each row. I ask for the future so I can make better commits.



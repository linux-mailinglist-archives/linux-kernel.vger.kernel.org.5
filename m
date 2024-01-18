Return-Path: <linux-kernel+bounces-30323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9EE831D17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A81F22973
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1E2C18E;
	Thu, 18 Jan 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjz5Tx3i"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2C2942D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593570; cv=none; b=g/IFQioQaa3YREq9Z8U2+0HPoJjQ9htKjpZVnY/DUzq7Swc9wgRZDp2rCyz4odlxqbAg5gyibZLmeFOlSNLEb4CaawTvJdBtMEgnemZnBjki4DIbAbiTSuh5Y0hch+x5eBtJ8DhCle0QX+i2xvO1pAJoeVpBxUbXtRvjFKvJZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593570; c=relaxed/simple;
	bh=KyuQF6HdUNUcfYsWpBtnOXi2wQG6pAAJWoFz724W3SM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=W6j7LRv24vKEXCebvgFeeKgDFn+tOQMh8HVwKLHy5QgUPw0ZrDGvTXIxXZ4FGR/5znu8WoyqKuy+4ERo3msT9TihRJ9qqxbbpiL2qIxnchPHsQIzaG0tfNxuMDYtREmcfiXt5VRFW8yiXGPdvjV38zUb/oKvnmEuwk+Q6wXq7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjz5Tx3i; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dde3884b92so1331529a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705593568; x=1706198368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBRn6TCLCV12Crycew/k4sE3gprwmuYrW7t7WDXXa2A=;
        b=Pjz5Tx3iLKrhwBIF3xRjWQQRh+GKWeCh7XNULU9TnESbw+itkUjUczzxroAedLMhY9
         I8XFATFJNY7OkvK+8xU6xWExu8E8TEFKJhyRfNGM1j2+yAd72K+tL/tBppmbcxzfBjCC
         cnNqjvgv9ob9BiYDH6WC8DdNrOuXTLk414W/kso0esezn/Rs5uv+J+3avnOPWYHAiDV6
         GDCU6s/EqhYBpYwFzffRO7GSda+qUvAoHVnDEdkNeQd78CKnmkcs5LnCxkRMZWUeoGDf
         XQtPaugwqWODcOnTgjhcmFkbSzlOhUdX/aE7nV7z6aRl2H3tChWvxqjs+7vLwiEOwpSL
         AmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593568; x=1706198368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBRn6TCLCV12Crycew/k4sE3gprwmuYrW7t7WDXXa2A=;
        b=s7NXwmkn0OF0LNM4AZ0VJGLZulcIStgzYghMSlKtCPoc7m4C9pqgspD1mWqbJU/t1m
         Mvfhyg5XVH8YGk+vY3/lRuYgei2U/6jWmPB34mg+0oHJsSWRoKJ4SCpqLs2xZdOmnYX+
         Jm/vdtv4md4A8A1sbhOeEd7gNfbKnYLJVm3MRoxOSnn7fgkQh6Km6jX/sDB/Iq7Jliid
         xGI+wFs2S5w+grlh7GjVGoM4jqXD18yh138tk4qRuutQTkBj534UisT9OpBqnnZtvmb0
         atTA2Dqdv5Oz/POalcNRK335772WtqbdMDFpNwm8bJ9WDst8CbUfbpQ1UY2hRbz+2Ya1
         tdAw==
X-Gm-Message-State: AOJu0YxQjlEiizlJgIUjnTroTZJSATzfvfI1kPzP986LD9JTbN2orB+8
	DtWKG5dGh1gzWbxC7LN+BUZIjbRploxhjbjcsv9UkQlUt6sRd+yK
X-Google-Smtp-Source: AGHT+IEheujLvkVmH8aVuFEJih3HAUl1gO7B9MZ1dkdkxkYZGadT/JN13iN+GMeQ2XpIDPeIbQFFqw==
X-Received: by 2002:a05:6820:2b0a:b0:599:3475:64bb with SMTP id dt10-20020a0568202b0a00b00599347564bbmr2121822oob.1.1705593568049;
        Thu, 18 Jan 2024 07:59:28 -0800 (PST)
Received: from [192.168.1.157] (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id 6-20020a05620a04c600b0078324eaba06sm5362399qks.27.2024.01.18.07.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 07:59:27 -0800 (PST)
Message-ID: <e77d766b-1fd0-4135-b343-0c2bea068a6e@gmail.com>
Date: Thu, 18 Jan 2024 10:59:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rts5208: Add more details to Kconfig help
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240118154044.68425-1-jklott.git@gmail.com>
 <2024011854-hardship-undivided-b714@gregkh>
Content-Language: en-US
From: Jacob Lott <jklott.git@gmail.com>
In-Reply-To: <2024011854-hardship-undivided-b714@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/18/24 10:48 AM, Greg KH wrote:
> On Thu, Jan 18, 2024 at 10:40:44AM -0500, Jacob Lott wrote:
>> The current help text is short and triggers a
>> warning from checkpatch.pl.  This patch adds more
>> details to the help text which should provide better information
>> for whether or not to enable the driver.
> Please wrap your lines at 72 columns.
>
>> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
>> ---
>>   drivers/staging/rts5208/Kconfig | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
>> index b864023d3ccb..76a083fbe401 100644
>> --- a/drivers/staging/rts5208/Kconfig
>> +++ b/drivers/staging/rts5208/Kconfig
>> @@ -3,7 +3,11 @@ config RTS5208
>>   	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>>   	depends on PCI && SCSI
>>   	help
>> -	  Say Y here to include driver code to support the Realtek
>> -	  PCI-E card reader rts5208/rts5288.
>> +      Choose Y here to enable support for the Realtek PCI-E card reader RTS5208/5288.
> No tab?  Didn't checkpatch complain about this when you ran it on this
> patch?
>
>> +	  This driver facilitates communication between the Linux kernel and the Realtek
>> +	  PCI-E card reader.
>>   
>> -	  If this driver is compiled as a module, it will be named rts5208.
>> +	  If you opt to compile this driver as a module, it will be named rts5208. Selecting
>> +	  N will exclude this driver from the kernel build. Choose option Y if your system includes
>> +	  the Realtek PCI-E card reader rts5208/rts5288. When in doubt, it is generally safe
>> +	  to select N.
> Wrap your lines properly here at 80 columns.
>
> thanks,
>
> greg k-h
Checkpatch is not pointing out any issues when I run it:

/scripts/checkpatch.pl 
/tmp/0001-staging-rts5208-Add-more-details-to-Kconfig-help.pat
ch
total: 0 errors, 0 warnings, 0 checks, 14 lines checked

/tmp/0001-staging-rts5208-Add-more-details-to-Kconfig-help.patch has no 
obvious style problems and is ready for submission.

Does this indicate I need to set a configuration specifically for the 
checkpatch?


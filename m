Return-Path: <linux-kernel+bounces-93389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D48872EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B1EB23DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C95B67A;
	Wed,  6 Mar 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD/ENoz0"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25664A;
	Wed,  6 Mar 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709707205; cv=none; b=omf0fpVSEzgEakeUsKeIgahv4CL/a4bWg5LXgAGmJTDFfZ+FwxZ4zBDX/ze6hIwDk4/HI7Yumpy6bNJnglDm+Wt9JZyChdTE/kqTbV9Hrzk7vgj5tn/JMBLaCcrteg8vW+W5Bat5T73rLDX5nJNFUaDKqzA5NWBrA/hFxZ2GX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709707205; c=relaxed/simple;
	bh=HISJxbHriH4GTTn+bHyCKPVqp6pdRvCDgIHrPnLT7t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxSqbZwArEN44Q2+MYMuphDSO9J4DxueqPO1QZJe49J7nBTsQKHULRFGJQ1j5gnQdSPyuL1o7XnLIlLIrt2htQe/C/4OJzUQHhOOO7gqbPfCSs05v1W5JX7rYeSLDu2cCncitZ0LWkl1ZXHWwz7Xb30uoqtVhzBZMXjScp5mQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD/ENoz0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so4260765ad.1;
        Tue, 05 Mar 2024 22:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709707203; x=1710312003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4b8KDa+7Y7BtH1fZO/uArrcTNHwrzvt5hC9CF6M2Ko=;
        b=JD/ENoz0PpqOafkxFbc6W+3MQb4MJ1Kjyqng9XQTgul16oae2dNb8nhzJhnMUyLqLF
         ftAMtRZ81PB5f+mBsaI86o+QQe7nYTr3k3WM4QFya2lpsCAv18Z6iKKgc7cInsuyTrx8
         p6KKCAO/QRd6uBLQY+LuzsFKZT86N7SLpojfXHwnnoh934dqpyxxVHsmWxi0WaQIi/HT
         IXPX3XspnwM2z+hjHjfAQ+wWOYes/VUcsnkFDUpSPS1elsUh472FTegUXIoJuh9F7NJG
         q0VXtD+ybZIOMvURJnlMAErEA5YS1YS5h7S8Qs/u+WpsaR763SHg4lFnaMOb95M/KwUK
         jdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709707203; x=1710312003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4b8KDa+7Y7BtH1fZO/uArrcTNHwrzvt5hC9CF6M2Ko=;
        b=hLrh3so1IGRR+B84yfg7ZraBCA7SvHzoWlDyDE7xTmX8uxOJ7zm8fYCv8dIFd3LpZg
         fEwERnifgpw74So3fHtISGEhiyj5Wb89hWgfZCGKVpfKju7g4uJiJvnhL2DHvLSyWUJz
         AcrdQTc/Bh9HiyludaYBRUVC+5Qg39TivUBjvEo3d6oJlDmRcXaAPl7iggJFae8KJQZW
         n6HC7pS1r6u/reROtdl3S2qXTTxYe7SVq+B+wXu7tZVCzYwNC/Hkag9dAMGAWE1ggbQw
         6AIXlVuf3aTDMuDl7AK6KTLvEIVDnSNQG1Li0chRmrgnIqZRm6vaO+UXMWL3mWlz5eHJ
         5BmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgMKquPpEwCNja1sX14oEUd6Fr1gb7u1yq8XQyYq4vhHDxKNoCP0KSQpeja/zKdZRJIccDtZaJcCfA3ajpNEE9icYKI1gXxxzGZyU3
X-Gm-Message-State: AOJu0YzeR/22C1GcopShB5VI2dsiYKLWbX6PDiIinBg6xPoxIjHTqbQX
	+uVCN12fDH5x9gzKaFdDcY8d3blGXLExuO9zoghpAJeyA7Ts/VocavfiLESoGB4=
X-Google-Smtp-Source: AGHT+IHdCoZDM2XlYwpSR1f/Djppwn+lkd8AgNHr57+8d4FaxcCTYW4TEL3z7titTZlR5DVdzRH4Eg==
X-Received: by 2002:a17:902:c946:b0:1dc:f989:3116 with SMTP id i6-20020a170902c94600b001dcf9893116mr4927614pla.18.1709707203462;
        Tue, 05 Mar 2024 22:40:03 -0800 (PST)
Received: from [192.168.1.7] ([61.7.133.192])
        by smtp.googlemail.com with ESMTPSA id z16-20020a170903019000b001d74502d261sm11681281plg.115.2024.03.05.22.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 22:40:03 -0800 (PST)
Message-ID: <160fdf7f-553a-40ed-8493-95a7d31a8b38@gmail.com>
Date: Wed, 6 Mar 2024 13:39:54 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Content-Language: en-US
To: "Bolan Wang(Bolan)" <bolan.wang@fibocom.com>,
 "johan@kernel.org" <johan@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <KL1PR02MB6283EBD2786A3B3E4E373F0389212@KL1PR02MB6283.apcprd02.prod.outlook.com>
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <KL1PR02MB6283EBD2786A3B3E4E373F0389212@KL1PR02MB6283.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-06 13:18, Bolan Wang(Bolan) wrote:
>> If the device with pid 0x01a1 only has an mbim interface as you have indicated then why do you add it to the option serial driver?
> 
> Hi Lars:
>    The pid 0x01a1 may include at, diag ports in different usb modes. Currently, only has the mbim interface.
> 
> thanks
> bolan

Hi Bolan,
so you already know that other versions of the card will have the pid 
0x01a1 and the serial interfaces will be of class ff but you don't
know what those interfaces will be used for?
You shall only add driver support for what you know today and not for 
something that might or might not be implemented in the future.

For the device with pid 0x0115 you have listed an adb interface and adb 
interfaces should not be in the option driver.

thanks
Lars




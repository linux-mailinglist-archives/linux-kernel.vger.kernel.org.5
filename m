Return-Path: <linux-kernel+bounces-93501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F9A8730B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4D0281B58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D03A262;
	Wed,  6 Mar 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcXDCXnI"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF45D730;
	Wed,  6 Mar 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713803; cv=none; b=obPtpQgBXiLSHLOd8XP29y+KOKWB8XoDYLy5r17K+4V9/yEi9VBcPk0tiIn/pApVn8YtXQ9D1RwOptJRqYeFp/Ytxe6yn0XomoaYoRijMJzDK7AYRLWk2CpLZEIZ6xpaEz1XbWKE/TSs1NWPSFBm65ARBjv5MWgCEH7k8D9vIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713803; c=relaxed/simple;
	bh=DjMvANrFgFvNlIdE1sM6AN8+G0NpuxLckY37WzfXlAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upDYAXI9osZBYzlit/6T1uQ5ucG8KXvJdsDSPJ5wZR1AD6eaeDYRweW1hWWrLQ0wIp2b5a9iRBLAv7x6hwkwUouunZDi7bvgnrsNkHC5uRZKr7v2blAGJSYEKbpsvB0sEK9RhGeJuGlJBXrfWs9vYQB1YAaKvVgCLi5jpzHhoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcXDCXnI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so6382652b3a.2;
        Wed, 06 Mar 2024 00:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709713802; x=1710318602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6jJFKSb+rris1ipccPGLL2PjrVECDvGnkU4+GtbfFw=;
        b=lcXDCXnIIknuC8GBu74hpKnR9r7k4U9aHLOIVxBPR3od7wih/wGnvO7VINWFw94dqy
         56NCN1a5WXDgiijIEBF41g2SxFjIYrn5NlqWxSPayT1XX2eDPlohe3uTQXXJ8K8nSvkd
         MwxXnujcPLDaJbueuq9gTsG17XEzswA/+UevFCyu+BQ+zAFKEj1RUGKt0Mnihc7jnZdz
         wLiqaEBcipoSklvkmCsiTpn8niiUyOYcglyzYI/KH3HvEzhGYtca5XFrqOzRaSzxbALY
         EKOmAWFOl5aF0NnV4JLlXcpmV999h21buaGA/iGSd0Lc6tYxOkqWiMdw2TKbSV6fX/Vy
         rCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713802; x=1710318602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6jJFKSb+rris1ipccPGLL2PjrVECDvGnkU4+GtbfFw=;
        b=KnE5bJ2WJk8Yz2Jg8F2dZpbuZX77g2Zn2Q/witGOEHKgOrX1z9TbUJSAZgKfe+WdbV
         KV3kNnp9Vp7dttBiJ3us4u8uD//nymyj13byV1iphcV/nG57fGK32r4InUp+DtPUoeB6
         5KZfu83h5L78ExBbz1IBed5azC/FjNTTXmKZ/2GncGja1PRnVI57i5FVv3sEdzM8yrJb
         kWC4ukvQhZ0/r+kVdyKqU6uHAcfR4QQQ1voqnWX37FJsCSCuMzefbiwkDoIn7Y2Cnlc2
         daMAkN0uMm64ox829OM0kJXrrZvcWN+uNqcuYrNJQ3kvTFMfeAo/isyRo3VVDmPdfizA
         3+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV50kZ2epcHTLPOhKLM1glGIXtHhHZfOF3riD9hysIjYRogiddAL4hTjAg7KghAAi/O8GekohV7FATWYQHQBW/Of1GH2o6hrxOUGnyK
X-Gm-Message-State: AOJu0YxkNEnl+1fOFK8W188Sv7D+r2Qd41D1y6DyxNWokEdBpUvQ1stV
	7I+4scvm+XijaSa+/AYXyfzmQqhLfx/CfEMHYqMRiIuQxXn2iovn
X-Google-Smtp-Source: AGHT+IEUxQN9KsAkJ7POL4yjbqWISpiywQOTZlQQRLmUgtmwOU5W+0e5hOl2U47mWDj0CtEry03Pkg==
X-Received: by 2002:a05:6a00:139e:b0:6e6:31aa:695d with SMTP id t30-20020a056a00139e00b006e631aa695dmr7401339pfg.30.1709713801594;
        Wed, 06 Mar 2024 00:30:01 -0800 (PST)
Received: from [192.168.1.7] ([61.7.133.192])
        by smtp.googlemail.com with ESMTPSA id h10-20020aa79f4a000000b006e647716b6esm1367472pfr.149.2024.03.06.00.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:30:01 -0800 (PST)
Message-ID: <f93317e4-1848-4fa0-85b7-c9a0d303d0fc@gmail.com>
Date: Wed, 6 Mar 2024 15:29:53 +0700
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
References: <KL1PR02MB6283F5203E50CD87F344331689212@KL1PR02MB6283.apcprd02.prod.outlook.com>
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <KL1PR02MB6283F5203E50CD87F344331689212@KL1PR02MB6283.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-06 14:41, Bolan Wang(Bolan) wrote:
>> Hi Bolan,
>> so you already know that other versions of the card will have the pid
>> 0x01a1 and the serial interfaces will be of class ff but you don't know what those interfaces will be used for?
>> You shall only add driver support for what you know today and not for something that might or might not be implemented in the future.
> 
>> For the device with pid 0x0115 you have listed an adb interface and adb interfaces should not be in the option driver.
> 
> Hi Lars:
> 
> Ok, I will remove 0x01a1 from option serial driver. And the adb listed in pid 0x0115 will also be removed.
> Actually adb interface info with pid 0x0115 is: Class_ff&SubClass_42&Prot_01, the option driver will not bind it?
> I will resubmit a new patch, please help review and abandon this.
> 
> thanks
> bolan
> 
> 

The option driver will bind because you have matched only on Class ff 
"{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a1, 0xff) }"
There are other macros that you could possibly use but I can't tell you 
which since you have not shown an usb-device listing for the device.
You can also blacklist an interface (RSV). The option driver source is 
full of examples of macro use and combinations.

thanks
Lars


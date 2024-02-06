Return-Path: <linux-kernel+bounces-55171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E424684B8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7751F236F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5F131E40;
	Tue,  6 Feb 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOmU+uH4"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C81E49B;
	Tue,  6 Feb 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231978; cv=none; b=fLK5jCU2L0YyeJu/clMHclur8xUBrKmb8lvQo2MOKjSD+jZeqPsF49z3SqqCZk9PoW9nh0Bnp66WXm/haBgtgiEvsbiBMEF+bhZhXBXpwhER9vLVCLOK5KGosD2xAG50Lj9luqNx+yEtaqQl4aMzHEubBWEEXG7q96NVoKjCarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231978; c=relaxed/simple;
	bh=kBRmTnlFKuDcjv1bDeOJXyLg0EEU5A1hY8ciVWo6CVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBGRhV4PGRIJLP2Gp2Zk0EmQgVcTqQTl5AVRCdGSuiML/hLk0RnpojFRumYdBqvvVREFwM25hE4kOzwMNHXCym1v2LUHjJnVZLh2VUX69lYyHfZrASfJgdzvMHMzfG24Xzhxjr+0tHlS5Vttsh9RHZX/jbC4V1q4DuTs0YmvXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOmU+uH4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d751bc0c15so49003425ad.2;
        Tue, 06 Feb 2024 07:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707231975; x=1707836775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hS8hWidfhYiRJEp4P93HdMbVzUtN2N+Xaqdfk/tm9Ok=;
        b=aOmU+uH4GkGd4tpe0eLs1XBGC3ycd6FVxkPRTjNqAtDvX/qk0exdhYqivNbvXbOoDL
         ri/3YtO1Tm2ElRdd8lnr13f87SvUBjEGikLUFIrdqaIq53b7eY2YVliMWhk5vrUjw9Ry
         GIPhFZ0HajaskZaNOIHtupF0HNSbMAVd3tseZX7NoQCOwaC+1YjRGyWJitYneWH+eIVG
         UiBv8+rQKlq/N0MNWKao8UZJhzD3cv66zFwE5AMustRfLaHO8hwW17E9kgtJ4Wb/+MD1
         +N8uYIhf6zs0KsbWmwqOlQnFMBszMTmVWQzYoHqAmoWS772sqdrT1wy1oGlwHS+qDSk7
         2feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231975; x=1707836775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hS8hWidfhYiRJEp4P93HdMbVzUtN2N+Xaqdfk/tm9Ok=;
        b=s+haw0s6ndwqR0bedqBrxoHretE/w3ZKESWSy9dpnYyuLnoA1A4Aib7Y5mx+/Qi460
         vCD/3HTCEVsSG2WsF9EJ+YV+CgN9T4hnRFGDBEgkQgdE801pQRU2r+/Xk01nwSIkBwGi
         bHljuGT+EtkCStIqhDE6c2eMRkr/VBVEg3RtE6Yb/2LqOWFwxxra6JNx/QEfPfllYEcv
         g1EBABxF1uEkOkbpooZKa81jou0KWMEcqduStEi0iiyaYN+rwo4ccaMPuKmt39LAzxbi
         DMxFRa9p/y1zolhQP1yV8IVnD9aziySFbFrA5EuabOv5yI/biaAfQxYfKiP3J5sR34A2
         luug==
X-Gm-Message-State: AOJu0YwgBN0f5t3VuV2km+OUNVxUe4CsC0iFkrOdEi7vpUH8U61XpFQ0
	abouP4PMNVJ3MtyWMp/7C2BSOKtiGaOdixbrGtxR2bjbS3CnyLjsx8TdhKGc
X-Google-Smtp-Source: AGHT+IGDhY8wkFE2xncr9HIAyZE6gAuAR+XwMYXaMTsdl1rNGcJZ77gZPRWU6E/2vQxPa78iH7V/+g==
X-Received: by 2002:a17:902:d550:b0:1d9:a148:49c with SMTP id z16-20020a170902d55000b001d9a148049cmr2409179plf.57.1707231975513;
        Tue, 06 Feb 2024 07:06:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3exnnVph2cfxqJwC2kQ/obS/CBdHfAdZW7aFHC+oARM8lH/71yapOuAUB/8yw2V95lMgwlyOUioGPNiRQKXRv6JzZ/GuuGa++7H3tG7MYzkrsy7j3e7X2TDeNZPzZ8bPj/6TB
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lc15-20020a170902fa8f00b001d9a44617b3sm1983774plb.52.2024.02.06.07.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:06:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <993b31e8-feef-4ad7-a3ab-9ee4f8c6d847@roeck-us.net>
Date: Tue, 6 Feb 2024 07:06:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] watchdog: Add kernel-doc for wdt_set_timeout()
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240206093857.62444-1-yang.lee@linux.alibaba.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240206093857.62444-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 01:38, Yang Li wrote:
> The wdt_set_timeout function lacked a complete kernel-doc
> description. This patch adds missing parameter and return
> value descriptions in accordance with kernel-doc standards.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Guenter Roeck <linux@roeckus.net>

> ---
>   drivers/watchdog/it87_wdt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
> index 9297a5891912..3e8c15138edd 100644
> --- a/drivers/watchdog/it87_wdt.c
> +++ b/drivers/watchdog/it87_wdt.c
> @@ -213,12 +213,16 @@ static int wdt_stop(struct watchdog_device *wdd)
>   
>   /**
>    *	wdt_set_timeout - set a new timeout value with watchdog ioctl
> + *	@wdd: pointer to the watchdog_device structure
>    *	@t: timeout value in seconds
>    *
>    *	The hardware device has a 8 or 16 bit watchdog timer (depends on
>    *	chip version) that can be configured to count seconds or minutes.
>    *
>    *	Used within WDIOC_SETTIMEOUT watchdog device ioctl.
> + *
> + *	Return: 0 if the timeout was set successfully, or a negative error code on
> + *	failure.
>    */
>   
>   static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)



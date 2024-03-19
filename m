Return-Path: <linux-kernel+bounces-107619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB587FF36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAE4B25E95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5C823AE;
	Tue, 19 Mar 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE75yvUo"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C081725;
	Tue, 19 Mar 2024 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856714; cv=none; b=sHWduXbDEQxAGsLF07wc1OtjdOWgbKbp4LqnKoIyYZ3XVYDAYLIiYy5T2L9w1PZE9P5SENAq1iXQDDDNBl5csK1mfuyY8nMHRK0vICafyXQM5ud422wUH4QFjJiog6fDwg43qEzZHT1Jfn9oBXCkWafZCY2Y+pjJc4R++PPYxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856714; c=relaxed/simple;
	bh=U9hpVncJzy2lA3W/C1VFV8DykwmuLIUpD9mFaLxoWNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3kcXeXeDDoKgJGEPrfrZJvCeushPzDSIY/TvJoF/L9Xc0/E0l8Lh1mgLSzCwPWkUFLCoxi3zDSHqGbrn5pzN2EQ3vTxkf/MgsXeKCSj8soheOXHMyDU9FgOKHovosx5G1R+fOaap010XOHrqaf3+mB6tCkQ8FMDWyff7x+pGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE75yvUo; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a496fde460so1710795eaf.1;
        Tue, 19 Mar 2024 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710856711; x=1711461511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hs18eHNDInn0iqGJWsnk8ODqQ1LsXwtDyJ+PpnjaiKg=;
        b=ZE75yvUor2DH/JQOcd+2/SZgXiamnl2mhz8eO4XFbQ/q3P7TU1cNFf8reeRL9fFdzA
         biavkHU+9/bkfiKA52XtaLRmtOkO2dy/1gl4enYdjzaMeJ5Y9fbNTvnuTJEkGG+rNa2S
         C8bU+W7bxfddBKfslpFWT9fheE6LNaPYilmM+JGVwZjGL49JYH86zXcabPzBph2DOEqr
         L3K9CPFtR234reMvHYZMTRLfxTffG+Yk1k880EK+yVY+ugP4Yn+oSpeOK3jvXez6dHPu
         KLjafw8BZBaqATQgVXp6MCJrrZwwU/FlcQ5AR9IxEoKcUn3SQc2NSq/5Djfn7AzTbxsJ
         eouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710856711; x=1711461511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hs18eHNDInn0iqGJWsnk8ODqQ1LsXwtDyJ+PpnjaiKg=;
        b=fazS9RNY5zSm99tLhTj+bBePZpQzfHmXzqxN4QkplHgi8sNshiEcGYi0/10ER+c/zb
         Da2ApvjJwWUT4IXg1AjgNk8NhM5pIoomd/0pPBJbqR65LvBuSw1akLqye36na9SxFTyx
         d1GOwMIUqVEsWElZDzVbWIQfCvC29Gdv8PCR4OaRU438ASGSvCjCXHWXxBREbmTkWviJ
         m3JeQ+3BEwM9K/MExJbxW0Xq9p5VMQdFpZ9RTQriIQLFfRmNwQGdVon6ngY2+YafymRB
         mFiiVj0nPvtF31N+8yrySW8TV9W4jfyeffhAgQJ3JTZiTbRvM1FvIOxA50h18ahSEuVI
         HivA==
X-Forwarded-Encrypted: i=1; AJvYcCVPYxy2CUjMSC5q3Ji4YzJDzqNNxHjY08RXRhStj3hhvEqqb8yZnuDUPNQn9l/ci10sjWb+z6kFDWBjy4s5zlFmDdyALMEWfJreDK5gHe7z93wdfblk+yWf4+C8P2MSmDlFHNfI6gnV4ohDpVd1xMr7DhdDCX6zFkGsfZ5ouDyW
X-Gm-Message-State: AOJu0YzsKLox+5ogwC6mvqsN+l+Tn+Y2uZp5YjOGHxLvLeQKjaGxH/MX
	inerxqaaTEvZbhpU6YgUJtWXR9b19Gdh4wus1v3C1P5n3iSAfkA4
X-Google-Smtp-Source: AGHT+IFfqG/DybEXAPLWK+Umu1i/zBwL+CVJ38gwjFMo9hzWC1E36qjCV9wZcPZ28r6LgAweyc8C+Q==
X-Received: by 2002:a05:6871:28f:b0:222:7193:f7cb with SMTP id i15-20020a056871028f00b002227193f7cbmr16694360oae.26.1710856711548;
        Tue, 19 Mar 2024 06:58:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14-20020a63fb0e000000b005cfc1015befsm9060642pgh.89.2024.03.19.06.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 06:58:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b83890e7-f118-4d58-b1d5-cafd2d08f4ca@roeck-us.net>
Date: Tue, 19 Mar 2024 06:58:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: typec: Return size of buffer if pd_set operation
 succeeds
Content-Language: en-US
To: Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, stable@vger.kernel.org
References: <20240319074309.3306579-1-kyletso@google.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240319074309.3306579-1-kyletso@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 00:43, Kyle Tso wrote:
> The attribute writing should return the number of bytes used from the
> buffer on success.
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/class.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 389c7f0b8d93..9610e647a8d4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1310,6 +1310,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
>   {
>   	struct typec_port *port = to_typec_port(dev);
>   	struct usb_power_delivery *pd;
> +	int ret;
>   
>   	if (!port->ops || !port->ops->pd_set)
>   		return -EOPNOTSUPP;
> @@ -1318,7 +1319,11 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
>   	if (!pd)
>   		return -EINVAL;
>   
> -	return port->ops->pd_set(port, pd);
> +	ret = port->ops->pd_set(port, pd);
> +	if (ret)
> +		return ret;
> +
> +	return size;
>   }
>   
>   static ssize_t select_usb_power_delivery_show(struct device *dev,



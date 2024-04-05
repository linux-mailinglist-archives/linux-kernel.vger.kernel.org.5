Return-Path: <linux-kernel+bounces-132532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC4899655
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E26B1C20F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B619C2C69F;
	Fri,  5 Apr 2024 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="F4rmytWg"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400122F0C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301281; cv=none; b=f6b57ztYfYaKG7lnu+dY5RZMNljVhRCxvb3Ot+BUtMLvktrd1UDmmHRrXrRGstPbznVHx965iiytHstAcdJFYUdcD/a/Zos9j5y6InuZ6+zQ/Kq6EObzSaalrRlqlcBq0OjLuvS8WrHyZ63NapC/r/jchPROG3WJ6cftg1olzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301281; c=relaxed/simple;
	bh=SaiKRf3RQbp8FV10MR4XbyWuycnREfYo3jf47AiQHiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4iMcVEl1e7OhxLcwmC4tUqbwvyZD96K2uFIAiQkAMR3pEfJeCmrXEaaP4AfyADQmnW3JmF1v8tbyKFlEmFUZC+ATEnDESa5gICdRSNzqSrYKQ+sf0EBC/nnFkVQMvU9FN7gAx4a17sxS2XlBgiMXkS4P8OZwMMNPt3eSE5n7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=F4rmytWg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e125818649so589647a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1712301278; x=1712906078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9skp/veFntESVv5IBHSeh0fw1XOzAJyP4HZp0g89cM=;
        b=F4rmytWgo6milu2bsaV3MoFR738b7PdQOldSqtJSnokLVD6WG9h3QzVYbt1nqH5YqJ
         E9/w4YutP8rKGE4qP3HBoJSxhDqasAAjLxknPBAYADa2kftYv3viLE3EvXBb9Vj9EzgI
         RX8P9gyrzk9BqhcQkNXY+yurwKkvyjEHQcyjhO6rYjTr8B1UoFAgc93Ow/PAXVgVr6m3
         PVFHZzFCB+AZL3pJCcGkE7H7kjOtvhwR+iLjzdOUjuL7iN77B/E6P4wKFcSLYOrSxSUx
         WJzZvURGaWnC6U+p1Sic1tDD4jkMqTeYlBfhs19GwNL7zNfeZJNcWENjyAD5t/PJnLws
         ZKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301278; x=1712906078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9skp/veFntESVv5IBHSeh0fw1XOzAJyP4HZp0g89cM=;
        b=HjhyZSae0xHCyGF4lCqmNH885Exkq06roYlnWfJIogAZb7cWjGSPzB7IoeUzMAslYh
         KLKhqbVxtFbE3ixmw/k0N9dkJEw5BuvB5ZddaX+upEzkmRG2Qog/38Q2kvPEq6eKlmaM
         tnWoxMgUBMJ+FPXLGSVYaCBKhQnDcrhNfv/4o9AoGzmxdpAlzhHs1AZXiSHUtC7zxc4z
         oBHmtiqns1kkeCmGXm6l/8wLt5JZk+ZVdgylAfhj9/TE9jnEdd9Mg2fAUTKnIiHo3INF
         on2s4iFfaob/cAfYtp9blCIY22miUSlL6EoJOU6BzBP00YzARtBRMPmWHxTsMrR5/a8i
         PaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRZq6Uc8z18IRDO+OoussrjKTMkcg+FYIwjdNre/M2SOX7jRYQVf3iqqsq5+5sLHRSeHalHmAaKNkpNbq+gmWDRna/9wy4sXkOC3xh
X-Gm-Message-State: AOJu0Yysr1EJm22sc/nHpnibAxMubvR9+qlgAF2/f3dzSFSMcSVwCkUT
	KrPvvcXJBhy6rdaAE/5Cs0YOXQBvlJ3KZMnezo4y6Q23Jke0bwfuzXfDb298vGM=
X-Google-Smtp-Source: AGHT+IGja6uppOhisB7znHWGeozcffmJLxLnLmJLpdn9gQKm01/J3UU1NMKfhr8BvFaTqUkqaPpdbw==
X-Received: by 2002:a9d:7dce:0:b0:6e6:b9ed:694b with SMTP id k14-20020a9d7dce000000b006e6b9ed694bmr674113otn.26.1712301278118;
        Fri, 05 Apr 2024 00:14:38 -0700 (PDT)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id n17-20020a635911000000b005dc3fc53f19sm784922pgb.7.2024.04.05.00.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:14:37 -0700 (PDT)
Message-ID: <7a54d993-8aff-472f-8132-85e0ca79ff13@tweaklogic.com>
Date: Fri, 5 Apr 2024 17:44:31 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: Fix off by one in
 apds9306_sampling_freq_get()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <69c5cb83-0209-40ff-a276-a0ae5e81c528@moroto.mountain>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <69c5cb83-0209-40ff-a276-a0ae5e81c528@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 18:01, Dan Carpenter wrote:
> The > comparison needs to be >= to prevent an out of bounds access.
> 
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/iio/light/apds9306.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 4d8490602cd7..49fa6b7d5170 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -635,7 +635,7 @@ static int apds9306_sampling_freq_get(struct apds9306_data *data, int *val,
>   	if (ret)
>   		return ret;
>   
> -	if (repeat_rate_idx > ARRAY_SIZE(apds9306_repeat_rate_freq))
> +	if (repeat_rate_idx >= ARRAY_SIZE(apds9306_repeat_rate_freq))
>   		return -EINVAL;
Good find.

Reviewed-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh
>   
>   	*val = apds9306_repeat_rate_freq[repeat_rate_idx][0];



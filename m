Return-Path: <linux-kernel+bounces-41267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97583EE3A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4C51C21192
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76D2C191;
	Sat, 27 Jan 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPb551Zu"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337AC2942A;
	Sat, 27 Jan 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371715; cv=none; b=go+hWoPWFOCvL/bax9C5+DQuZGRALUqrwdeB3heM44bszgUdKBiZQbLGsqJCqEoVAMpP2OYW6yt6mw9+QZ8VlLnAlJQ5w1YLsUveYid/NyBTe2xFSA6PhjsL2aGDtlL2wWXUME283mXL1/ccuhT/WICG+q3d8+OYAUhp62QejAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371715; c=relaxed/simple;
	bh=C2CeYRkE5RLmEYXES/Fzbtxrwz1n+LP4hgctq8H0Eys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sc7qoCmaEsZA6b2IB9FQyhbn+S3ACxsyKbGab9RZ/qFzHQQST29r8LOHsL6pWWM/CS7DsAEW8cmqf1b/3jTU1saOHzpDWw39ueGWspOAJC2RWSqaRR7FQS/dF2zpPGJTTi994KfsntWyHXC1UmsE/WJDiVXYJzZD0STfeQYLTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPb551Zu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf42ca9bb2so16276801fa.1;
        Sat, 27 Jan 2024 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706371712; x=1706976512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHQuROvmjXF3d/D6baDnYm9M/+MQZ9uBBURjq2PNRBo=;
        b=JPb551Zux5oVkUZlBzcHeriibF71aBZxvBOQ0DWaKnghASynr7jWSPaYhyh/TPhAGP
         7BUyNGowF1Va6eDibqYDPP+QLJBWmg3VvYwowE80/qFQwP0ncSj/F7aHExT/YvrXzIj8
         ge0Hj3NbnPiy7Y7xxpFm9bAV1KkgTH/4Z8XTqgtL76buM5AE3Sa6oeSW+BIiP234HYsd
         cl+XEVqa8g+HX0detaymCLYsK9LHgU4FKvhxrfDfBiC/lbKrLhm+3IwnTVkc2mMIIwKy
         1MBBiXD2BPYVgAybhRRovjgJw4Esqqz5jKHna7yYzGTOiKvI3SkwCeIz6qXYldO21kwB
         TAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706371712; x=1706976512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHQuROvmjXF3d/D6baDnYm9M/+MQZ9uBBURjq2PNRBo=;
        b=TRaXP960gFKM+q0o5p7V1VAf8YDq2pOl+TA99K4KA2iMRaS6nBJUXorDxXOatMGZaW
         Veqs8cd/50n1a9UPVqMQoKoPmtLDUk+fhMJTK91yXTtqVMYWPSC3RwlBMY1WhvOfPwi/
         rzTGx405TrRpDUDWinAsBBURpZ89jsgy57D9LuQ9zMYA1zBMnSqcwtKYVeVKsWwMauDe
         L+QyRwFQDNFM/i+nax2j3bu0IOKN63twEoLQNIsWj2PxswO8zznY9eujM5x0qqJigMJ4
         eyoEvFIV8v9d0lYHvCwie4JSk+csZ8mxl9EY7nKNqiPCOG0W5c3DSVupQZVHd4tUU3Y1
         LCXQ==
X-Gm-Message-State: AOJu0YxNknmHV13KZ/grXgWkltSIEP/k95SvqCGXsD5ohEuVHm9LYZy9
	iN3URRKL4p/DZXL8BEwkEVFSbARcr/jvC2dr5AhqTwnGhy+PiRfR
X-Google-Smtp-Source: AGHT+IETbXuj6G+ZxwwtLZhYzvqvewX1Lt3TweERVApW6Fq9K9Ue7rFKR0LLm9sPAVhm1hOHmkPYWg==
X-Received: by 2002:a05:651c:b8c:b0:2cf:4496:3e29 with SMTP id bg12-20020a05651c0b8c00b002cf44963e29mr1011386ljb.0.1706371711814;
        Sat, 27 Jan 2024 08:08:31 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:4080:59f1:b398:a889? (2a02-8389-41cf-e200-4080-59f1-b398-a889.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4080:59f1:b398:a889])
        by smtp.gmail.com with ESMTPSA id i20-20020a50fc14000000b0055c500158b4sm1758119edr.23.2024.01.27.08.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 08:08:31 -0800 (PST)
Message-ID: <b1cfcc79-d9c4-4edc-bdaf-2080b44e77eb@gmail.com>
Date: Sat, 27 Jan 2024 17:08:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "iio: add modifiers for A and B ultraviolet light"
To: Jonathan Cameron <jic23@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123104305.10881-1-paul@crapouillou.net>
 <0bd3319f-7d63-485b-9b44-d6858c045b37@gmail.com>
 <a6f79ec0025e1862ba170c6a535447dd09e7dfad.camel@crapouillou.net>
 <efdfb611-5ba4-4cd6-a7f0-bd96259cf1a6@gmail.com>
 <20240127155247.00f6aa3b@jic23-huawei>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240127155247.00f6aa3b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27.01.24 16:52, Jonathan Cameron wrote:
> ...
>>> Can you just move these entries to the end of the enum in your new
>>> patch?
>>>   
>>>>
>>>> Thanks and best regards,
>>>> Javier Carrasco  
>>>
>>> Cheers,
>>> -Paul  
>> Sure, I will do it right now.
>>
>> Thank you again and best regards,
>> Javier Carrasco
> 
> Hi Javier,
> 
> If you sent a v2, it didn't reach me or the list.
> 
> Jonathan
> 
> 
Hi Jonathan,

I retrieved the To and CC with b4 and it seems that you were one of
them, but not the iio mailing list, maybe because the modification only
applies to an include. The linux-kernel mailing list was added, though:

https://lore.kernel.org/all/20240123-uva_uvb_fix-v1-1-5b9c25d50d90@gmail.com/T/

Could you apply that patch like that or do you need a RESEND to the
iio-mailing list?

Best regards,
Javier Carrasco


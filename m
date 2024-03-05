Return-Path: <linux-kernel+bounces-93071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5E872A73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05ADF1C226B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A212D207;
	Tue,  5 Mar 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqLaLQm8"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5B45BF1;
	Tue,  5 Mar 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679067; cv=none; b=A6u/vTNwmODSH2gemrevZKbzeep3SmaLrh1shXJgWVLRmqz8dgh+JlirgUFTMsyu9Q5ouIsSpRKJeGJ9miAzDSJGa/uT0u8zIARc6LkXQDwzRWYlj363dWjCiplC4rLnq7oG2rdJYzqk0Z+A9Gk9g/UIKPTAxS0aA5nm6gbRDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679067; c=relaxed/simple;
	bh=IlmA7ZmBJhtoMP9Vra7fNUdyJQlao9zJE3ZYv43qqAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6KxBMixsKb+hhGvhh5eDkVkknbaSLesN0eDo+yvyacXviT6hTLo2SEyYP25MYuwzQmL8mKryWX371Wi1+M7p+n6ugffZdk8ppVv2KBQQIddsscCqkH6tY0zkkMI5Ub33kuOD8MJqbCEg5tpvpln/hFYTGedS6+whT3Jd4ziVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqLaLQm8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7880ea7e2b0so146749785a.0;
        Tue, 05 Mar 2024 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709679064; x=1710283864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0uEJf59f9vnvwnqg6LNGbO20Kct5J1he93WOTJSEyc=;
        b=fqLaLQm8XqXww73fzdzvjUDesREpLzET/sujyGDaPkOEXXMPImqFiWpTX0Gk0+uFyd
         5MQWzeko1S3DTmYjhS2V2eCtGA3JWoLFa2oxkjTaz02+zN8wYxEhK2jPOnwhEDJ1EGXd
         Sfv7LJsg0n0CTOMZZNBLOGeuic/ODj93iEN6Fnp7gcw6B9T+QJZTKvgJ3DqyGNTCJcLF
         mDTJMwUyjDNvvNxYarFYqXPWuVIGqVAO0BvSGB2LLa0e3BKmg1HIeeDyEhai9IRdgy47
         /uWcJLmOhlUVi/SeEQr7r3BRgmrgJ1104QNeUakamuKRWEdRuf/t93LW785a7lylIbyK
         rlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709679064; x=1710283864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0uEJf59f9vnvwnqg6LNGbO20Kct5J1he93WOTJSEyc=;
        b=lK9CtwpZxdVERgDN1w+GePHPnQxxU5uaVdgGV7zMACvMb22ozZi7pCgcdNErQ+3zi6
         fuuLmMPNzt0y820gJSEqhTO3b15VO4VC+kjwAcYTZon/NKW8A8A6jiPbExf54bb+/Xvr
         sAb9lUkTLfbZDQohBkJ6xsF+5np40LcXqEUNlanQEe0XNpoHNssxKC/q2EzXwMfd9bFx
         rte6Qd1nwzTj3Yq+3Ge8ob6FcH+PKC1/fZkQyZzhPQeDrbkrmJpwjkHlnu5qwkVV/6sL
         IWiRJyqnnuDmm15QeLjyYhmekrfwCeCgp7uGGVcySSXDkd1q2fCGua3LF5XK84RBIgnI
         uoAg==
X-Forwarded-Encrypted: i=1; AJvYcCUW4iF51Ic0L0mhQKM+eWL0/99mraNHKWki6bMSprz9+XYklD/Dev+Ml8dTwRJWYOLslqYpbfsWKe53C2/i65+kiKnKiBebQcPN+2Sy0E9MZ/4/LF4H3HY+1V5tmsI/ZZhr8OF+
X-Gm-Message-State: AOJu0YwFitUtDB+cK7CCjdP23U3aZFzecdH+e6sGPBJK0iY18LUl136Z
	ij2Ad9TTU4OtzQo5iBo6ut6EvCnPNFaJVC7L2c9xYh9I9oXjfaZp
X-Google-Smtp-Source: AGHT+IFGh+V+wrlCCKNXrJOo4lahUFxVZ1I2uL0xIS/nMSpZopQyBISdCbmon5yfUuT7kkCi2d9zPA==
X-Received: by 2002:a05:620a:20dc:b0:788:2476:1437 with SMTP id f28-20020a05620a20dc00b0078824761437mr3140284qka.75.1709679064596;
        Tue, 05 Mar 2024 14:51:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05620a12e900b0078820982f68sm3417937qkl.87.2024.03.05.14.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 14:51:04 -0800 (PST)
Message-ID: <cba559a0-61ab-46eb-bcdd-26b69569b9e6@gmail.com>
Date: Tue, 5 Mar 2024 14:50:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240304211556.993132804@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 13:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



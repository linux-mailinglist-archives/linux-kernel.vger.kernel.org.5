Return-Path: <linux-kernel+bounces-164631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2EF8B8060
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BA11F230E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EB194C9E;
	Tue, 30 Apr 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF/xGBcg"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0A194C8B;
	Tue, 30 Apr 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504650; cv=none; b=dzorZ415hp96+fAmpDmDdZida6EzuWMMTuBaePjEfbIqmE/EOIFYhu84oel6dYF1YvgNTj+grhdv90hocKEuEdFa213lwdcHSnPi38OrDuNY6EXLgPiKHKz7DUgLt4bBoUKdkZob6FNLP9ZV7XZdSnlZ0fGn4w6BrJhdzB1J5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504650; c=relaxed/simple;
	bh=P/Ac5nVgg1vSfLOIGOhRby4AXGW7urQjIDX2VEXiexk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwAXdAZoUdNV+3f/PTmA2trQoCPYXdnoLWMv+RW9XQ5qE+OupMLYRjbOpxvzgUgUf00omOQu8vT9xURdRplykJIb9jlshaf5ir0MERttEU8wuL8wJF6quKhIHd87XM4GjmzXnN28ngVUXNI5dJpwkflpeBFA3QSjTAhpnqh/Xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF/xGBcg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4772771a12.1;
        Tue, 30 Apr 2024 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714504649; x=1715109449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTr/n2Zrn/cC95O6zxi8/JOT83ChihXe6hHSdTRi1co=;
        b=TF/xGBcgJUu1PoiZMnYkaYA+srb1zWM8udwjZ2R/b+jKM64toqw7Z1mMs0WBAw8R+k
         yjE5FWhevPRyqzTYBbZxMD5LIPO3SkdT9zGyal9ts1EudNnhCm8BYjoySWsvMz2y3fln
         c3FUJpoDDFNFsERU/q6SdV6HaEGmshaCuL4ZQD3BQpEMFLthieOIbrhY5BcUwWA0BOAf
         K/1Qdzm1Ddgs/9mntpjirjg9zD9dfXSTK3JF6XAfLN7D4BcbnJzqFgreg+kkqAQ+Mx2M
         OOdTMZNPoaijz/exXVj+6XYpdj6OQdqvmyxV+NaeRAxISBrmjp3QI7mxVXNDUTtZrL8n
         /xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714504649; x=1715109449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTr/n2Zrn/cC95O6zxi8/JOT83ChihXe6hHSdTRi1co=;
        b=Tzv6VGXfG6Mhrc9VYLUd90zoXzsrAN8S/0oKGfdN8M3DiGj2x9GwM2nOIuofMKhRt9
         1ciDHs/ODviHZZ8wePn3yY8pFP354ql6Z5VeYvy0M/CNGIYwX2osWF4TGbGg2lxg0mN3
         krVBmIeheMA6v278VkdC7XE8Xn3mmiN2C6Uh3jpruQGtJcytOkZcEuLS8ZJ5ier+oP48
         ZUuVXOahbMjeauUsmagNFqPXHQItyROmTeiWHAqEdvgjHO6Qh4RNoPtzZw3F6Bf4PoyE
         832x1HI6EXzY8yibKq2HAIbQkhKKitwOZ67w9eAXRhLtr27++odmomij+7r5pOpQC1wN
         XlUw==
X-Forwarded-Encrypted: i=1; AJvYcCXhlOLCYHdqIVC5ZuNSybEJT59lMPOgHNtoCoeewMw3eZs3nRRDArajveaM0pKaBhnh1z6BZq3arAtjc0CyrZLJDAjvPKpm4+UmW3FItc55WSRZEhKyZDs0+ddTcqI1Rub6VN8m
X-Gm-Message-State: AOJu0Yxpbs/aTJOfTWy8+t1E7XSYxmSFyxrnP7H2W9Q2iKlYObIOHb+B
	EdyRA5JqDFooKunyyMe1Ch1J3/z1RyXeVSkdHni8fO7enNXbcZ8p
X-Google-Smtp-Source: AGHT+IE9IBMqPoBmU4Bm/t+czjSih8tLANLcH6tDAgW1UPVm2Y+B0KGi327+p9gxFxhgEbEJgSaDaA==
X-Received: by 2002:a05:6a20:1f26:b0:1a7:8610:bb62 with SMTP id dn38-20020a056a201f2600b001a78610bb62mr606015pzb.51.1714504648823;
        Tue, 30 Apr 2024 12:17:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c6-20020a170902d48600b001eb4a71cb58sm7053832plg.114.2024.04.30.12.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:17:28 -0700 (PDT)
Message-ID: <138791fd-4db2-473c-86ab-f8072c14167d@gmail.com>
Date: Tue, 30 Apr 2024 12:17:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103058.010791820@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 03:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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



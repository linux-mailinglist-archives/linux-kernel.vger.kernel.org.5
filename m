Return-Path: <linux-kernel+bounces-141516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8468A1F44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB271283264
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D0D134B0;
	Thu, 11 Apr 2024 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d51Fb0xe"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E62205E1A;
	Thu, 11 Apr 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862818; cv=none; b=uQv5WkQzpzPZ9eqEQxnnRzec77JLRDACcd9uO+4O8imX3tMjStCdpS9PAnnuiCl41oVUCsJjY/951i+O+h5f/dP1t/8TuA1H9uyk6uRQ59sGUc21Ljqn/KldG+yu+Xd1ndIgeScCpqu58v2sAeZAw/WtTd9vW9x6dyXu5PoYpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862818; c=relaxed/simple;
	bh=2CMK8rOtCxGsbTCs/JqTdsujjb7w3Q+fa+8zVF1mOzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDpXSLSZEzVA6oylsL5/poW3uNqHQWrE/f1UcyHy2bVlSJZNtBcbRWVed7NOPmvlAvilF8gDdp/9gsaEEk8sEJj3vyYXO1loAWNROxbsXtTMoFcYlIhJKRxglnucM6AANa5e4v00yU6uwxxyTNMBV5v96G3B/QsLaM4irisSY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d51Fb0xe; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d57bd5781so8593685a.3;
        Thu, 11 Apr 2024 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712862816; x=1713467616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5m3l4Vb8I5/ZGVgXiYeL4TNj6LNEAEO5dE5T/EQin8=;
        b=d51Fb0xeoH/p7T45LmRqvFoSEjev2qqgKl5AKy3qygiRwuyCrokgvVmZKA25rxRYKF
         FgcS+C9+/MjxTH/tWHlD1SeRj/2kLxMky1imXD52C2MCDTc4w1qg/4+5fCH/c8j7ckmp
         TwS0/JhJUydyXf+ySkJ6R0OW4w/I8N+cbXo2J9uxfMrjtDf+/iE+x5tRObI24N5a8LEl
         kDt94as129WKr64heOLG4pd+IWvpI7OobB4Dn2rFtlhNhtcNzRB0rguZ6E2YhdcAT3Do
         9B9AHrnpBmazmkcux9Pa55lZieCmtjQCk8UkjvDt2z7WyPypk2kuz7iym1CK9j5x0KoN
         C9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862816; x=1713467616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5m3l4Vb8I5/ZGVgXiYeL4TNj6LNEAEO5dE5T/EQin8=;
        b=m6a9lId9wP6hXf6d1Hf6sMW4I7pRwtOLumQH90EbO+107ouNn1Rnf/QE9lXjdGd/aT
         yvgBsoWj7Xd15jUBxRVZ9qDFutaRW6lS0q2xWfVPqmWKlUZpGkq67nVeJ6Ik9yzVTtYD
         N0lvVTovtA+m9mmsYHcdMCLovAHkPuHfz4G/a3ZjS8+mLuS8E/UjKaxqP1tccEz0eSD0
         BlCZQvnbA2TAtCZq7TcbhUEhT4yiTU65vcztMQkTxGSMsaHgC1QsS59cZEHL7Jd8mZF6
         KOHF3ClX20x90GSP0PShyUMIwu3lwV40zQf6pD2prKmUrfKXki79cDAy6gIO4hSWoQGa
         7ktw==
X-Forwarded-Encrypted: i=1; AJvYcCV/C9cBI4CYnOdqD327EBlRvn521Al3fyTdbWhYnixgf6YIVGIvkhuC+Q63f3DKzOCQmXwwrPN9zBaUiljMzX9cSALDEXqEehZZX6cOzV8PpX6s7AOb8WVxEJ8LfEvdtvX6hg2r
X-Gm-Message-State: AOJu0YwsgaQctNWqOy6Zzo6sBBz5f9jFCHoTKx//TdJ5R1uQjB3vVZkb
	0fTRW+N753w8eKqX3yVWdWiMJjzQrtPYmMRh/vV3jUnG3o+ZIwZR
X-Google-Smtp-Source: AGHT+IHhe1I2Uq0lLSbvmS5xMIfCfYMrM/FUl/d012CYdm/v+sQx7ZtT7UhmRSO2G843rHQGxzmibw==
X-Received: by 2002:a05:620a:21d9:b0:78d:7368:3c7a with SMTP id h25-20020a05620a21d900b0078d73683c7amr577364qka.35.1712862815843;
        Thu, 11 Apr 2024 12:13:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d15-20020a05620a158f00b0078d54363075sm1387123qkk.40.2024.04.11.12.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:13:35 -0700 (PDT)
Message-ID: <9292ddb9-c316-4418-9244-81cb6a8542e5@gmail.com>
Date: Thu, 11 Apr 2024 12:13:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095407.982258070@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 02:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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



Return-Path: <linux-kernel+bounces-107641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC087FF81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD481C22BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004D81AA3;
	Tue, 19 Mar 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlTdPKcI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F68173D;
	Tue, 19 Mar 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858282; cv=none; b=YUTWrUsBlmakpssFkU8yDGwHllQWccady+IMwwv3q1z1EqJC5etnbD0XizMexRBSMnDbKwjOHPlwX7lIXX0MsO0NHFiyyGJChOc2T6vAYE1qiMvopjpMiSgfkzr7N0sfYYQD/Hw4vZ/0+8DNgh5537azWi35rWqpvbH00+zsG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858282; c=relaxed/simple;
	bh=T5FjlNNpAZt5zFNK+WLkR0q1QolOtNAlNwenUVJXDCI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qOJ/pDvHvSS3KsrhC1UpE6XBME7RajUglXHX1E1UVGDdyi2lPovUPFTi1wph5uATAKvaz02g2q8hm5lg5970K2PRfN+2fGCM8t85mHXxZqGsZeLJnoIqxJkA6raGIX719RJb2GOoRusytfiJe9KxlojPiZTQdSmDIGz7c+2It18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlTdPKcI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e00d1e13a2so16260785ad.0;
        Tue, 19 Mar 2024 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710858280; x=1711463080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6Fx2SUArRlDQMNfIecDPdA6UNmHGoM45TVwDlUr2kGY=;
        b=AlTdPKcIJ3dqLnSzu83e00am+XUFuE0nqmPGK8FuzkwytMRt+l17kFqY+sdUrWEKfM
         Oy1JSQ2fXDOxhG8ikqBxXbhPduQdXonrV5af7PCFZPlAEvk1/aSPUV7DoXkL/fftdI1X
         ayalxPOc5faI5RQbQA9hTqxPiTdF2OOhXdMwOgFrux2nyAV1BUTUlL2oEH9iZaeDdYTo
         kXY79fnCMFYox3qz2LKPVPS6Lf2EN+gkpvR2Bl6LvPT7ude12x4+QYTCD3NOW4xEEZGu
         Z5I9i9v53rq41i1Yqwy157HZMr0h4PRDPuU+KVvrtgLhLBGRBwgPkbDKs7Ox8KoSfnWh
         hytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710858280; x=1711463080;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Fx2SUArRlDQMNfIecDPdA6UNmHGoM45TVwDlUr2kGY=;
        b=lFI1qhlTrH19gwPllktao9WtovwPBYH+gkxh63ENn3bYKMdJ2wepWp/c1zKe83C66M
         1QVaiscsJSumoeT47v8xIGkaw+cq2873wiq3gwizMOhjjtSLQZhYg26eNVDn5P0YG1An
         m35K+MSdgTnqHIS2lKcRcwp0xbx7xIXnHuNjmKI5uZGTQk/QfOtTD1fvdzM39vWXX4wp
         kKdeOLsDr75XZv5QAaEmbJ8nTxk5WDMAvBCytHqmHrxsQEmPQhakYuyk+ggOU3ESPw2P
         BJOQRRU/0UicaS8ElAy+/WiA8+UsgeztD1wmvsL1UNWi4eNd9bfhWVn6rCYxGzYKrASC
         MShQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS6i67xEl5+1CoLRW9EUbRWiIa4x0i2gfpZiSlDRqGywGr4NRHVORR/0uUAH00RYx+6VEDRwSLlJsKgeoLVyoqgSXE2etgo0sSBRzEf3j+YP0j183B/gMMelltWZOl8kEx6RMV
X-Gm-Message-State: AOJu0Yw5gCggAcDowm7so9gkurLyGthZn0YmUleLZHKsAT5R5azB4L4R
	kfR2sr02e4b1VOmbkrz+Jwgt2XT6JfNr0YdKnrRSAvy1qe/0bX6O
X-Google-Smtp-Source: AGHT+IFe5FRP+TAocE+qfBQrGFKwJ/zd7qbdKcnl4hs3/Tdlk89CWLK1mWL6FDVex99nxw1IxCzuVw==
X-Received: by 2002:a17:902:8e85:b0:1dd:a3f7:3d4 with SMTP id bg5-20020a1709028e8500b001dda3f703d4mr11239857plb.54.1710858279837;
        Tue, 19 Mar 2024 07:24:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001dee4bee1acsm4653310plg.224.2024.03.19.07.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 07:24:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ccf81903-b991-459a-9a3a-8d46efd909b8@roeck-us.net>
Date: Tue, 19 Mar 2024 07:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/41] 4.19.310-rc1 review
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org,
 pavel@denx.de
References: <20240313170435.616724-1-sashal@kernel.org>
 <305ed269-b7f0-4ba2-9f63-ea15480fefc0@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <305ed269-b7f0-4ba2-9f63-ea15480fefc0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/24 13:57, Guenter Roeck wrote:
> On 3/13/24 10:03, Sasha Levin wrote:
>>
>> This is the start of the stable review cycle for the 4.19.310 release.
>> There are 41 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri Mar 15 05:04:34 PM UTC 2024.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.309
>> or in the git tree and branch at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
>> and the diffstat can be found below.
>>
>> Thanks,
>> Sasha
>>
>> -------------
>> Pseudo-Shortlog of commits:
>>
>> Arnd Bergmann (1):
>>    y2038: rusage: use __kernel_old_timeval
>>
> 
> Guess this wasn't build tested on alpha, making it unbuildable on v4.19.y.
> 
> Building alpha:defconfig ... failed
> --------------
> Error log:
> arch/alpha/kernel/osf_sys.c: In function '__do_sys_old_adjtimex':
> arch/alpha/kernel/osf_sys.c:1274:43: error: passing argument 2 of 'put_tv_to_tv32' from incompatible pointer type
> 

Following up on this, I now dropped build and boot testing of 'alpha'
targets for v4.19.y.

Guenter



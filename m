Return-Path: <linux-kernel+bounces-141663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE28A2198
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD8A1F23F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED03D969;
	Thu, 11 Apr 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0vCF8T/"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF813BBC3;
	Thu, 11 Apr 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873279; cv=none; b=qcicbeGE20xAKrcnYxL+ujSU3GPfHo6PddWo+337Fdo7deNs7MWAjgz0UZJ6lzYZBnNphHArKMcY0M1njl5Zswu2qqmiroI3rjg1TsS5u3T4N77WENsKgsBmMlLKV+wvw0ZL3l4HMVcJmAYG+Hlal/PqjBrQy0DjEMPUeCx5zS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873279; c=relaxed/simple;
	bh=PWZiYQ74/w0UT+7MjhuPATgOoC3BIwW3cwjpV1VRKWM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cd+TdGw0vEkUkT54WsKET+RtbKRMD8iSUah3APQZNYvOy36RCke3Jxegh6TqFBqWYrAz/Qq7OULKHqnmmOVaK8cqgwMAn8WGNBAvtTSsqLmiTihMZCK+BKUv11Q96IFfO5hgnZPHFG3ZMmhmQc6tDmskn4VHu+kW1qZQKm7Jc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0vCF8T/; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a9df87e7bbso217394eaf.0;
        Thu, 11 Apr 2024 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712873278; x=1713478078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z05V9hjl4isyzgk10gFX2UAfVgP+ufpBEOn2xeP4+k8=;
        b=F0vCF8T/3GIPumQ1RViZ1XNOpPdSfA77oVCUXzgVNFCykX1toEKEW9grb1OQ1bk5uJ
         V1JXKTVT4zfi/gjUx/zwFnXv7TokbFh0jOM0EMLs2lfQ7OUwIiJkwjfTXq1V0y5dVL4V
         FZ6B+HUvswb7f84W1c5v6dS+kk6FXK6P/lBTVlURPhB7bT+/ePrQWUBL6FzQCsLjubJI
         XiZDcK9JclVKNnRa1sf4r4SpecGJL2KSp3EEg2vy4afhOnsPXVvuxClOUWRHoZQhvjkM
         BjBf0vrVD5eDmEZxdIR13heD/qBRYwJNr7IJ7hUJtBYgX7vFibeXxl0tp1/TTKLqjSg8
         4fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873278; x=1713478078;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z05V9hjl4isyzgk10gFX2UAfVgP+ufpBEOn2xeP4+k8=;
        b=LCEUIBbMGxRF3BSyuyJg5gykmBPRLya/NpGapqkXK/jbpVjWGzGFUxCWlVSil5dNEY
         Y3gJ2sBJyhzKU74bXv+3Yn1NUFhprLrB2LEv745ncEi2zVdSV355e70HrjHD0O70BXb6
         qIoHHSaA5mfdFRXA0tbCGaeuIpxToGkklzb1YR1ksSjRuSgijr07DCmrAXluwXn5QASH
         ddEjRDcfpyBHuyOPjmk35o7Oq7aOEll54E/VqLICSJ1l5+1j1WhqlCc0nJOYhi3zW0ln
         UyVYHXDHdO9b6OIj0sJqY7XJ+AMaqfXUnai85pRJBEVoxbznwO0fvOoZ3lSNFDENYXVQ
         Vb0w==
X-Forwarded-Encrypted: i=1; AJvYcCVCi0GulVihSVHM5Qh+Bc4Nf0qAAbCWHexb0pgDrid+XNqnsRM7P0fJ2MOfGqGUlTry6FIYrZp8v6BZKDJpPMH/p0EUTAmIoHDOP5QYtwZGX+rpJSlBemAXWQbbGQWazHAfNZ4F
X-Gm-Message-State: AOJu0YyX2ceUq2DL7zPEr1FNBiXCaEC69U1DKpo1rlqU4sGJHDCq/Jpt
	/zOIgcz+Fw1NrLbe4Mso8gH+zokxybDi8FgnIU3ucmcnuSOG0le0
X-Google-Smtp-Source: AGHT+IFWiubUc9PIA8Vx8GbSjfNdWLO4HJihQAgveeVyU76bMwj19cyMzQXJsyuCa74WY2or4RWXkw==
X-Received: by 2002:a05:6358:90c9:b0:183:ea4b:620 with SMTP id e9-20020a05635890c900b00183ea4b0620mr848080rwe.28.1712873277620;
        Thu, 11 Apr 2024 15:07:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o35-20020a634e63000000b005f072084432sm1552607pgl.38.2024.04.11.15.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 15:07:57 -0700 (PDT)
Message-ID: <d50fef0b-3bb9-4e99-9491-c0d6664492b4@gmail.com>
Date: Thu, 11 Apr 2024 15:07:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095420.903937140@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 02:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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



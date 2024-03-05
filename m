Return-Path: <linux-kernel+bounces-92979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBE8728F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9E02848AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD912B168;
	Tue,  5 Mar 2024 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU0xokt6"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6101758C;
	Tue,  5 Mar 2024 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671909; cv=none; b=hs6HPrnoCxf6eloAIm/1W4SpDY50ezoilrdAzquKfUXWC0z9VtT3NFjYBEHnqVbOdiMsQY0UzYRyHkEssZEm2iiAKtLJi4Uzw8kyCOGvVUg2i0bRDsFGt5StuCCixDuEV1CBt8Q9rIoEBmpwBlfFIztEn3IH1CLTLwJMdND6Wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671909; c=relaxed/simple;
	bh=SjSiPVcEcyD4W6ufsE2+x5JmNWbIASUDZW/T1vteaWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1X3dFwvLBCXMib2aTOVzped5rHr4Qqg6UFsXhj9wgS3AoXnjoKLYEZS8PdNp9Nn4yriOkl693RSuEzJeLx6tgrypcpE9jbUKEmjWxiFWvIbVhut6w75BioK959FalLJ/KSIOflN04gOTmQw1rcu0vh4P2/HDzX6WwWGCRsTz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU0xokt6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2998950e951so3704897a91.2;
        Tue, 05 Mar 2024 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709671907; x=1710276707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnn+qBNjgeLnA7Zdn1ytKrCjMf49ommBffpdqi1uL14=;
        b=kU0xokt6UoFnier7/ZVXswWvplgnhv1jZWawElQc1u3Vn68aYtVWnwEP9UlJqU4XXu
         OXv5UosW6uRBTCDOA3IoWHkJHyYQ9bSR1bT+T9CJycKfNSoTIOjjPTOUhpCmp257Qy1N
         cOzucKbaJcP/x5TI+F2IMEb+ilO+p/+LQzqsgDEMi89sgJ2/D3qSP3o1YO9CWQqJz6ft
         OGbe8TOzdyyjxo8wVF/ij2376r4Dvj8LwdHhZI7wkkXR8J9/GXwmRDUfDdrai4jy7tUf
         A1OngfUIo9qhsnUG6yP69qqAs+w283zcCfsR+Q+Ezi/pV+a1yHmP/DCm1JDtoCHsBgKo
         Sywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709671907; x=1710276707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnn+qBNjgeLnA7Zdn1ytKrCjMf49ommBffpdqi1uL14=;
        b=g/Stgee53wrL/H1grT2qTJVoagCh+hJuvK+BcQWnxBt+L6wH+e4xwMnc1GsqIUCP0C
         z+/Q/UYfbbbfKw01VbxHVgenVtyXnADu+KTBuna4l5L3qu0CJEHQLFGZDlNeby1qI306
         mM8e6WJeOWPRoNAzGYeOVFwgoGNrXI5+Oro5rCnyDhRlhdGFn2PlcjLGDvQtddgPIef7
         AzuTZZT4F3GfCYly5mXUiFa4v3U3oWtjGEusd5ZmY9raemPn1rK88C6atguWn5YnmY+4
         LWkNizIjKiib0GHYxPDXh9U9UrM+ILV3JZ48C5Zxeky/aAF/3CHYJ+MnFPObOIJ4vioZ
         C5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5pbRri/UqremLP1n9jS/+T5rLfsfG7U9LdQ/PJJFccDAdCPaNd7mEW4179LnDAKr1JvvLs73LJlPlabDE2YCqPSCNW0F35OiqTqziSSz1hHVGekbo1ssVg2d6G8ljZOhXFB6A
X-Gm-Message-State: AOJu0YwdYMJi3PlCF8551Cr6jCJ96H6gXpFaUGeEKmFz4d/uoAb7AKFr
	OMjYQ9mqtSzV6r+VFoXOV3jFnGjWN+3J/5eIFK8a0My3AbKrL7Rk
X-Google-Smtp-Source: AGHT+IF3mm4NwyqtTufGOJgmT7DBewSlt5bothb7FXlxENeR6anuCge2sR0DoCkr4rlTwamTf1QdZA==
X-Received: by 2002:a17:90a:dd82:b0:299:489f:a126 with SMTP id l2-20020a17090add8200b00299489fa126mr9619659pjv.41.1709671907174;
        Tue, 05 Mar 2024 12:51:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ep2-20020a17090ae64200b0029932d175c3sm580395pjb.0.2024.03.05.12.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:51:45 -0800 (PST)
Message-ID: <5a8f45b5-3199-433f-bbf5-cfe7c9e77e45@gmail.com>
Date: Tue, 5 Mar 2024 12:51:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/83] 5.15.151-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240305113135.403426564@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240305113135.403426564@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:31:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc2.gz
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



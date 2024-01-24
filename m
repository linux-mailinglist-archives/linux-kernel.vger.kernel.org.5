Return-Path: <linux-kernel+bounces-37426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085E83B099
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9048B30342
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F681AD7;
	Wed, 24 Jan 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewBRwjzL"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E847E78A;
	Wed, 24 Jan 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117237; cv=none; b=noCd8e4JGMdUcJ11xq4RN/vo4e+L2kMMDzzo/ejg9RWsdX+G22bWsaWt+89Oc91dLLGXKLpmcVTqDuJlyaMuIvK6LasFQKecE+/IWcxsVnX1Xb9ul833PH13UXKdrRQ5WTRUehxupwAAMZwomJ2Sly3rZXCOm4466ml9qGalfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117237; c=relaxed/simple;
	bh=6MOAemICKjtElSAV9D/Bfy4WMpwOLClz6TJUWRBoYhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoxeNwSYXAk/Ptje2qs2db7/+QdUYPLXaGiLb1pNTk5g6+hdXVv/DZ5CQmYnKoobotEs3CFwHqjt6Q1DUJs2h1FK/7zXc3iKv8+1Vb+kTCmtxPC+qHV4TFArT021D/m+3MPUDAIJYwyMPqIZq5cgpKapCkfEwNn2Lk+ep1cFc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewBRwjzL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2903498ae21so3267601a91.1;
        Wed, 24 Jan 2024 09:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706117235; x=1706722035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8T0KaX1AdA+aklBNgVQv4mrW58QeobM+4jGoReZEVhs=;
        b=ewBRwjzL2oKQ1DY3WL0OmptZ9wnqw5DwhV3c1PzYJKrKHDWk3EfMgECmenlPiboLEY
         f+TBRIGbHjtrVqJaofVwKcaPbXSh+m1Pa/TGugWvfOhzxwgogl/3RklCXBabMBP1/B1G
         mwiDY45cOXUUlz2i4ma0HpNevBQ6DJxvKK5cGZ70+iP5tk+YBGi70IP7TJCgVqzBKLbO
         Hzx0Vuy86Jx2xAbH3Tlopt+7e4IZBpRnJEj+tZ+LBGGiCYOPI/RP5q5vmxwJzoW3+Kaw
         9XP+ip3fqI5g7SrHFNnT8GMYQpAuWIQnNKbLjF8AsKQ6H6dusBuO6d2suP/GL82pUkEI
         E9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117235; x=1706722035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8T0KaX1AdA+aklBNgVQv4mrW58QeobM+4jGoReZEVhs=;
        b=UtYN7nz1vdl0ECFfr1ChoyXJ5it4Iv/2oN7b5fM6LpHiYSUfojH8OgX1uErk4RyyQY
         5PqlDV13koUG3ETx6Kqag6qgskzqMrPDJW04S5ESpQoMbwg5Z3F04FBlROLZyyL24oU7
         72oj9eTikZx2duKnGMFffvxi8JKTM7t5nfkLpU2fYK5++1lVPx6n03e4RBsI5cZyjCi7
         5sLcH49mH488jiM1Gj5zPB5Q7V/DvUiVlSuYjmUAGgfsIejS5e8dxSWJbMdf0cBdzZAm
         zNnxS00yprNHL4yGRMQkDwGV6LD8jyodcra7UTrBnbh2+N6RED8Gj/D+4/uR+3K28gQX
         Gthw==
X-Gm-Message-State: AOJu0Yw2dlbbAyAlQjFLGnSJTJb3GC3R1R40VKrm9lrgv+G2uctmQwbb
	6uOjYnl5CIowH/n/9fvhVMh8YtqV7ApzwE6fgv24CKwrKh+C9XiF
X-Google-Smtp-Source: AGHT+IH508l0adTi9R0vCI4CDcPTzxgx20rKPZ+JzYtwVUVMT0Kw4JVjmPi5iP92h4H/XEJnSe6gOA==
X-Received: by 2002:a17:90b:4ecc:b0:290:c939:6bab with SMTP id ta12-20020a17090b4ecc00b00290c9396babmr2364008pjb.45.1706117235366;
        Wed, 24 Jan 2024 09:27:15 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id su7-20020a17090b534700b0028d29d837c7sm13895057pjb.36.2024.01.24.09.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:27:14 -0800 (PST)
Message-ID: <5a794dfa-bcf0-4e6f-bcb8-cc09c5a5de2e@gmail.com>
Date: Wed, 24 Jan 2024 09:27:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240123174533.427864181@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.14-rc2.gz
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



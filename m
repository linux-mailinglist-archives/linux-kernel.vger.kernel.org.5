Return-Path: <linux-kernel+bounces-126993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C204894583
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B9F1F21967
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411753364;
	Mon,  1 Apr 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E35VxLZy"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7F524DF;
	Mon,  1 Apr 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000050; cv=none; b=EgeetumiPKQf+q4BSO/cakCkmUXinRGijhNjIFt+kGKDSuPwx+Li0yQwKnZWl7pCLkFQJWksjcrjkKplGx4sSI/AuOdzJxQFKJQS+xt+QtkPVNPlV5UhXUOIG5jHJnqAPVR+PsEQ76KvU3ASeCnHfssZL8TCdaxlzvbbkV5TQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000050; c=relaxed/simple;
	bh=aj0nrVkwljzrKd/TB28KkZj1TBXQPoxF8qMtTI4WX/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WemYsTu1Ckst/K2+a59D4w1WnjtA8sbWM/XdpoCvqLDAOc0rhLKaxiukfzPUWxdTeJ1HdbXNwKBRLftgbmaDuPpFapP1iFkUf55W90QUXsUbTgUbISIXYt7iJVvOvFJIo/tMzRkFdmmLPJt3Q15nWSUyg582QLnwNtlbKZepi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E35VxLZy; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a4f7a648dbso2852753eaf.3;
        Mon, 01 Apr 2024 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000048; x=1712604848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLDV/ht2C0Yhmxp9JcDfzPNyFlnI0fQ6zYIEoeG3/fc=;
        b=E35VxLZylV2pIsIewERIScS94L9xXg3MEu5M4moke+4mkGNten4wv4cWr9D4KqAi0v
         e1OHhJMTnYw3pJuu5bH7Zr/N5YVDsg7pVdyPCkebNUHWgzbeIU3rzljyfPhHwNuoAQAW
         ciX51vJNl0vMkf75UlxNyq8le5+/2Pztyitvv+0zyAL30oyLHRMFHl5Df0upoXNGeVDz
         9FQECQHtkwcrpkRn38RWtJ2qqpoSFzWMu6rc+YzCVMNikpERkw+WkuIS1VGe4So5oLCI
         DfcIevfuX8SE/DtrR+xtG+p61pXDacW4H6Mwtn0wvrky0t3rJ9bQOKZNv/VxiTMBmBMt
         Ij/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000048; x=1712604848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLDV/ht2C0Yhmxp9JcDfzPNyFlnI0fQ6zYIEoeG3/fc=;
        b=R2a+61ZQkUgDmd7GC8GlTrbXQTclCI0n3HIn6UxYtZ1OEe0K5J+CRYGOMw1ODJflpi
         Sbj5bv5e7EcA1PiXa1Q8xoGgSBq4Zh6mXHPMZ0g087b+f+HqnDenZbhkQyjIrpYx+hAZ
         6e4vZII5RJsROIbdKZsBpAF3jTfwQR7mhYhbAYAe6M1uEjRdL8iQspWDvAWLvtMl07mL
         Rc0z5DbRYoyNMmLiaK97mFoZV7mrFb7GqIWohDZ6WpIXb1k7b+mgR4Rjy9gfh1Aoteif
         DaqBL8KR3QnE/PLnuU1FcJaB8+Dhs/YXy6sC3VwpzdBO4JNqf18KYjYpsJ9tGwCTcA5S
         nK3w==
X-Forwarded-Encrypted: i=1; AJvYcCVsSZHZvDQLqFl/a+75rtsagsRcCDgLI387hksPUxMoXO+M7z9gKRConS+KV1Da59j8Ruj5EwHlclOmHtTkb1PYLfIRiz4c0qizduEgkIoRkvEDw5ZLGipz+vm4h6X2VGjUUVMg
X-Gm-Message-State: AOJu0YynStAaLO4rUbYgZ5UmMmi2SBnPsZ3e90J4DHRUdhl4fBkUpXga
	IlQDltzt+O45wPC779OS9/AsfQTCIxtK460Bz6TUsuwMFm5qQzCv
X-Google-Smtp-Source: AGHT+IE3k8RINM6GcRHexQWUs5+L6aBvMDILTRqjzVJLOriiaxe4APNK3WoZMLuuc7QaH/1VNw01jA==
X-Received: by 2002:a05:6359:4c19:b0:181:65b4:f99c with SMTP id kj25-20020a0563594c1900b0018165b4f99cmr13803416rwc.19.1712000047846;
        Mon, 01 Apr 2024 12:34:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t1-20020a63b241000000b005cfc1015befsm8194438pgo.89.2024.04.01.12.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 12:34:06 -0700 (PDT)
Message-ID: <9c62616a-2706-44d1-a4a9-08f150f11c7a@gmail.com>
Date: Mon, 1 Apr 2024 12:34:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152530.237785232@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 08:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.84-rc1.gz
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



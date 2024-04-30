Return-Path: <linux-kernel+bounces-164412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BECF8B7D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B0B2837B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF814179654;
	Tue, 30 Apr 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7np5HCJ"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7A143756;
	Tue, 30 Apr 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495506; cv=none; b=P58h1bKoevXe4UIZE0v50jaYsKrRcbhwDE8U+bc3SFDiuqSui4zeWiFDMKYgfxyPQ5WHppeGBQjGxQzX+b3/S2UgeBgRTbjyMUF9kCKMzZfr17VfwC49EQZc9bjM9INxJAQXUTXgzleL4zsJXmrHoXHJsiphxoCR74FRHPifdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495506; c=relaxed/simple;
	bh=69YzY+oNz0oBhurbxY/U32Ep8blappIwZ3ROTALilHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV0tdgEa6uc10gSM0sZ5l7PTQrbmGhURQorY3M7MsRNGCWTUSCS9TIlt9a94zDgcvFlOGKHtwqjpX7xRyUqAxdewk7bAY+4UPO8i3G4suOLPxCpO4dddHlJc3U2AlJdC+dybxd4CtJa2qUz6SG441sDJw2Dy7sOQlO1IkCBHYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7np5HCJ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43a975fcdb5so16712821cf.0;
        Tue, 30 Apr 2024 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714495504; x=1715100304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NELBX3OSntfqIge688LAqdr7KW7zfbH4yVTfJ/9yBM0=;
        b=I7np5HCJhCMNpaXiK+KUkxgCe61+AQq3aQvh9caf5wwEoMwbRTo6oM+Ym8Fuq9cD+s
         gPTLTZ2V+fJBRy4KSaUYAWSyUuzhNxJO8rX6AfVWqF5i1oC820wH5NFs1o/hbjMHF9Dl
         lTXmvNRjYfMJ9G9KugzxSX3t0o0WU1wHMrCIpMW21Lge5iEZS/JQDMUkEbDzl7vn9hbX
         rvmDk0/Si/A2XO+ODwlUXaW9XcTLTuW5AZcwongjbmohUHWEuTvWMOkpgAffHQZgZkVe
         cRQJV8Qklela6jOrRrwgSnYAdQTYR/LkN5t0FDEjAwmZwJhDGJ/vF3+wSuFockAa2RKH
         kDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495504; x=1715100304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NELBX3OSntfqIge688LAqdr7KW7zfbH4yVTfJ/9yBM0=;
        b=wtL6d6H2viN1FwNUq1MCm2RfYEuPtj2ZsU12QiD2bBKNTHGTgxFOMEsZmPKx2gBKsa
         Giy6HUG/1XJmteDDq+n8F6vuYDIPpMIyITSikIfPoL248HqHxdglEQTAHWGJEQXXhkmh
         +FdSX2CPD0rhm1z/Q/5rV7781/8C2RTLCkgbjwCiAn9F+OOFUzzvrXpNPk4Lv7rUpu0G
         oOW+EEPCDl+Myfv9VeUWjCiGGjKITFDfJ/MckrAOEyzxSfOKPQJcvyngzdrQMp1Z2EQj
         bl9lQ9rkS0GL+vIY8ckeJJzQbJcsOVdBlFUfdPmMlLDh3XR5ygzB0dxOs15zr+4Ka5mR
         eAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOj7XALSNQRMjrMHdCU9IzjQ24QUE2aHhkNtOnh9geijOYByh3n+UWNzntvWxiP+3bCfzQZ3XrS7AgDBmE9DFaav2GlV8VGphtuUQIRCjVUIp4BuQejd/p0CG+L8nUnOilF/ax
X-Gm-Message-State: AOJu0YxbrWW6IIPHTHXVMR3ljSysKaO6+H43usza4B16+IrrS5bgViJX
	9DtwyLN52JF/iEnXH+eHVxKmP0elFeQ0eyvpII0BedOiiNSV8miIfaLbuw==
X-Google-Smtp-Source: AGHT+IHO2tKl6jwReUrfC/rUmUzmIxXqPqCEPnAY+LYFQy06Tz7wjy+uU7qdDtw6UfY7bjt1sCmwrQ==
X-Received: by 2002:ac8:57d5:0:b0:43a:fa90:edb6 with SMTP id w21-20020ac857d5000000b0043afa90edb6mr4111926qta.60.1714495503545;
        Tue, 30 Apr 2024 09:45:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bp19-20020a05622a1b9300b0043c6c361ca4sm296153qtb.77.2024.04.30.09.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:45:02 -0700 (PDT)
Message-ID: <d9c5df85-3af9-4301-8dcd-a2a26c4d8121@gmail.com>
Date: Tue, 30 Apr 2024 09:44:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/106] 5.4.275-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430134021.555330198@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240430134021.555330198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.275 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 13:40:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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



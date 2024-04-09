Return-Path: <linux-kernel+bounces-137494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2F89E2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863991C217A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65B156F5D;
	Tue,  9 Apr 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfzjsuns"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B14156C7A;
	Tue,  9 Apr 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689294; cv=none; b=U2rtbsmCpHAstomQKOJyl/HIXH2vf6uZpL0+5um0l/WLWac/uDk3UJzsJUHiiJ1DAhwNncLxf9b8e4LbFAdXmDHullbNdjnezPvmag5C6kpSUzxOYO7d0ssBVxS4JHbpgqztV2TWJ+RrWgzh8o97+IFRYggMWHx/L6CUFnOkgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689294; c=relaxed/simple;
	bh=EhGuBWVPdQK8VKnXlzCuljD9IuU49Ti00ETnt24k/44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIpceoTaN+w74zM0AKhakxVPT1sfdOFX0Fsf8V2M2eAjvb2wkq/v7fAcZPZspuugCWix+2vGA93tbuxdOuXtyr3/ElngXksUYHiPsuV1BICUlJ/2+jCDINKyuRYxbOAd9hcPpWnAzBY61I+6PMBfbvs6Vh2w4QFrGvtGrn04KYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfzjsuns; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa369179e1so1961479eaf.3;
        Tue, 09 Apr 2024 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689292; x=1713294092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyZTN6gVoSJHHT6RAxRzhdFNsxF/9gYB/Bq8Q2JUTRs=;
        b=kfzjsunsoNHglBJF2Edd4ZLum86ngIcJUgXQM039eCizn/M+n/VfRLj6rpzhiYfK4E
         Erev/Lx3qUg5XqQQePT6lX51aVBW2orwtR1DkppAfxDEVSlgBXKsb/7Mk1Vjq3XNwqYc
         b1tpULGbVvlIOBur8D6PTFt6Wp0gHR39CY9aAWVzA38NzdcVwRneEFblwXr6h8jh79Bz
         g56srkg4yOnggML2tgu6NOYJg71s+NFWOm0D5TeWZadIiZmQBqdIv8COYN4h3m0uMpC4
         P/sokc85URtQdvxGP1tGkHdmX0Ks6HTdv9NPCYS+loLxPJOnpPCLykvEmnKpYUxJmLfz
         0EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689292; x=1713294092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyZTN6gVoSJHHT6RAxRzhdFNsxF/9gYB/Bq8Q2JUTRs=;
        b=gk3KTCpQSg0N7k5DcBq39gNMz1XZypkKUaZRRook/fNOvCE2TXTTSHmwlqxAJYjLhY
         WjFCOOQZpQnpLQMTXSLrJ78HdrlSMMDUqHcnDjDecTHEvaxaV25uFp8Pwu/hMke/8XOe
         GO1VimXV9A0xN60YFcT0c9iVBW5S/CuTPPwjdbRKg23u8qztugt6EKzdJCaDjS84iyjH
         USUXXG1i5zE4u2+2MQiHyUVT7Hn0eKLyV/eYaSjErTC1GYb/L7GLtx0SCySoMHMBEWgA
         lFKg5jXBrWTzWN2r5ZbBzNu5YjTHmbi8t7+LjwsjGkRAvsz86C1hMQVqeHtt9M36TtoZ
         yOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQGrn6Kp6HWLSY/ielge5hrQV8ZcP7v1K8sLOYV4N39YGk+Stq0kLxN5oR0RUbzhcDaO1Ul1tUPKwOp+5mDdUokyQjvaLvD0bvq43fQf2NHtCxIm/ZwVjljdQp3ZrZGsED7nS0
X-Gm-Message-State: AOJu0Yx7jn7MGIpmtwaeAHWZdz1Gh49H7kGE6dzT2VJX8vR/F4pUiF2j
	//DSWD/8i7f7rg6olakqXN7P5h0qbgvDsHJpPg4YrbHpotrMozCJ
X-Google-Smtp-Source: AGHT+IGXEceHQ3ia8cXGq7qrTT29qTSyLJnD1/Tp5AB1LA19tFqRpEuIfFqVqRoPHWdWDkQcyKBF6w==
X-Received: by 2002:a05:6870:972a:b0:21f:a11a:e251 with SMTP id n42-20020a056870972a00b0021fa11ae251mr539900oaq.5.1712689291600;
        Tue, 09 Apr 2024 12:01:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l2-20020a05620a0c0200b0078d349b102dsm4366977qki.92.2024.04.09.12.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:01:30 -0700 (PDT)
Message-ID: <e1390768-7dd4-44d4-bb57-b91cd3d73fdb@gmail.com>
Date: Tue, 9 Apr 2024 12:01:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240409173524.517362803@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240409173524.517362803@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 10:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc3.gz
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



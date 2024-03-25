Return-Path: <linux-kernel+bounces-117776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C1788AF79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C421C313AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C194125BA;
	Mon, 25 Mar 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZjcYO0x"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF11094E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393894; cv=none; b=TbFkSJwgozsZvOw3nlMcoMp3YEw+qbxgzGol9pDQi/I4BIHE4DKqI5E4VYgGqkObz8Nb2uNCMgyV42y/u+/eGV6sGC7/0IbtszPCEYH42CdwCrAaSNSHEb5/4V4Fyykv9GwA4FQhAAZAzOzyYtoNgX4mRgUm9W255JNtrWMiJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393894; c=relaxed/simple;
	bh=Vi8HxAd7A6IWSux/onGa3FeKfLdzruWS6T0+YUExDH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaL5A81cH4XmJFY2XU3v8YxPZJpvTKd5CAJgCAWEmrWNxce8PfzbVWgDPnfYbq7nsV4bGDXfiQPmR54gCvsNjAOMhIejVCByEezROSj2zNuKyRQQxoKOsAMoVPJXC1EHZlVJ3bIay4xXopHvDWn16CTRLSrEdBtrZywKl5GtWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZjcYO0x; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a467dae51dso1564750eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711393892; x=1711998692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSCEfymtsbEAwFlN5wT0NVwopTsLwBAlwphs0JJFdOs=;
        b=WZjcYO0xZiy55qop347jNhuBM8TRXbI/mVtHvOjzPrXFPSO0w7EmpC53G90MDa9eT7
         Hw0APfptOtAb9tullqbYdAJVZKHFnUNrroKGC897hwmT3F9tH14/3ATGJuoL4kVGZeok
         mwaP3TwHvRuvlfab/DofMlYLNLqSWDDfieqtjuZdpriiFK6PaKBxCRPuaSt5oUsVBOX6
         40ROnsJm4vOU+vWgGFcSqmdZIuHqX0tfIrFCgzbfl+zznWqDHDs1agVZ2pKNMxe92UUJ
         3vFgZ28LgMj4BLds00RP1SiLs0RSQOwJ6olujs4U6QZlt8FYVH7pcTViKuYeD8tE+R3l
         SSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393892; x=1711998692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSCEfymtsbEAwFlN5wT0NVwopTsLwBAlwphs0JJFdOs=;
        b=CnLBz7wW4ghaf2uauY4ObJabTu9k3xEEiKE/K9GN6O3Lj4eLGFgO6SzceqIi3EEgZL
         6RPamDkymf3tu67LaWrHE8H47CLjS5WdrJssbGTMeC2xx1COp9sOnmzXKM0cLErkgc2K
         fHAACXkPJzCM3fsOGnsrXnTLjQWYoV++gazEnYfQBAr8WED0h0sSsXqYSnpz+kBIqb5E
         RfirXtqu6dHkY/oKg0sXvk2ZTVW31l+7hAP2aIENinSSxxVEjd3ztT3UI13Zkpj9dvuE
         bM2RwqM+j0cM+xooqyrB8xjYanv4VRDNzTyipnbGZAs9JJf4BV9kz5QaF+KZu2lIZ99Y
         CWBg==
X-Forwarded-Encrypted: i=1; AJvYcCWRy0wss3CU1giO7ZwGhn4A8nfXuhhNSQbrf23awQBV3Gg/qZAcAsXG1IV5fdXkslBN/kUCGA7h5ReTU1j9uDZirKga4yZ3CIetSrTh
X-Gm-Message-State: AOJu0YwEZpLz6xmByFbFsEe73P8aAcd3JX5qIqpKiTZG4ncEtOJGeP9U
	IoXm6M15OwNV+tr/SGH0c2htqHD5BPmR6FibDQ3Icq2iAuP7dg6GWiTLNbWgj68=
X-Google-Smtp-Source: AGHT+IEtMFKcLACXoldlhmST1l3Jk5e+Rl85AcJMkgIfftyNJy10nWG2uhpU31GystsnXBXmygfs6A==
X-Received: by 2002:a05:6820:1b13:b0:5a4:71b3:d090 with SMTP id bv19-20020a0568201b1300b005a471b3d090mr7791853oob.5.1711393892163;
        Mon, 25 Mar 2024 12:11:32 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005a53e6c7209sm941635oob.28.2024.03.25.12.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:11:31 -0700 (PDT)
Message-ID: <1ca89b68-fe6b-4963-a33c-971fd7e1f0e6@linaro.org>
Date: Mon, 25 Mar 2024 13:11:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 stephen.s.brennan@oracle.com
References: <20240325115928.1765766-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 5:59 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We see other warnings here too, on Ar64, Arm32, x86, i386, MIPS, PowerPC, RISC-V, System/390, SuperH, SPARC, ARC, on multiple combinations of toolchain and kernel configs.

-----8<-----
   /builds/linux/kernel/printk/printk.c:261:13: warning: 'panic_in_progress' defined but not used [-Wunused-function]
     261 | static bool panic_in_progress(void)
         |             ^~~~~~~~~~~~~~~~~
----->8-----

Reverting this commit makes the warning disappear:

   commit d3ba3bc06ffa68aac04cf4f102ec882890a16015
   Author: Stephen Brennan <stephen.s.brennan@oracle.com>
   Date:   Wed Feb 2 09:18:18 2022 -0800

       printk: Add panic_in_progress helper
       
       [ Upstream commit 77498617857f68496b360081dde1a492d40c28b2 ]

Here's a reproducer:

   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12 --kconfig tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org



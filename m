Return-Path: <linux-kernel+bounces-118143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F0988B61B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B3AB2ABA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4780606;
	Mon, 25 Mar 2024 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLKiB4vl"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD577F7DF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407115; cv=none; b=AoFjsrjOwtEh1aiei48KZ8aevFMELXaGNvT6uLA3EIhRowuX7Ye2JVOxJBZbxRTYVRIEPDBcCxqHja2fMudILfHx9dWeRIBhrOQ46mplVK0stYio6GolqKTWOUIZlxySJJ3A7q6wtT2eYj8UfzbrutX1hATZ64DHCyMeGz46i34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407115; c=relaxed/simple;
	bh=WKCyn9Jbsg8Ko9Kdx7LpUFQvg5K3h1c4KeT/q4IWC6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l27FXYRmqMeBUg0W9je+IAJZAFihH6+d6TAKd5X/G8H76Pps4OK1ZK4ILWid4dJj+xY9esDYKKZhsKnz9smUBL7RuI015OeFF0jPoZJRhNQym1U6jebE8OAogBlwq2V8JwfY1YtVAcIDtPo2lL0CZfLRyVmG/92yssit4Jbqy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLKiB4vl; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbc649c275so2475482b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711407113; x=1712011913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2QCqoOB2K39Evzy/pSJ0AhYW51cJwfp0a+BuRvX5e0=;
        b=KLKiB4vl2pjbKGnr4OhRTeNsbz8PzgADxTBHk7rsmfjVThFjO/U0zqwdbwzT9MRoD/
         odolEYFckuoH87yeYhQLciAV+kOsIil8XUJGb5QxOgEyTfku1rC/hkzKhLRhkcitcF2z
         8FH1sV+C3C3XSUD/pJDbnXbx9WmHxh+H02zjMNPmeAyXCk1BxPBCXAarqKfK6aMsco33
         SkbTj5KeqaCakvY/CQ3eKuLikriQWGUyoBSDFWX9ZwLFT+y5jfBvHaugqFZjJKrE80at
         0AeQaXPDI/oJG0DI6cB/koM2TfRDVl/rhlt91iEbRYUm4kEdTsu797S+K0JGpCTDXxZD
         PQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711407113; x=1712011913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2QCqoOB2K39Evzy/pSJ0AhYW51cJwfp0a+BuRvX5e0=;
        b=su075Ecz6/TXDhr0Vqk+z/F7hIZiFl3kg8/1ouGi2qW5bjP41B35fxB93XYs3MicRE
         Z+Bd+VtYT3mo+6aVibRs5tvR30Qms6lzMApvZuY7H+usiUNnSh176DvKAIeIGcMb5ACC
         5TY+dcSAn3RDXcul9ORE1McBazZXkqvDoLq+bPiBEVMzFJP5kFE5DjLRlHKBoJFzWK3X
         Vs/OwX1Awg39m3qZwLOiGBfGv0RpHFSzPqJ64yybkhaPTL1TKrq3K+2vvUTsdnLwPeGV
         qFmZr9mbl5qAUtGFwA9h/zpVO+yHCPRAaRj0FdXKahwZSlGgAgDPlL7D/npMQPcvy2mH
         6cEw==
X-Forwarded-Encrypted: i=1; AJvYcCXPdNTsoVUBrd8YfwoOfvi/R4wxRzgg0n1tleDtUUWGln/coBrl/U264CF23jqi2VxmR9ijFjGp0mgL1ztRnDrtUaFipIpIqFjRpRlF
X-Gm-Message-State: AOJu0YyjIb5ANqzZBlqmhOvEy2gtVjJd6rx1kavbmV2eovqehHu5AgD3
	txoeMuBQphwItr1pFRfVObz3JpM2dVSZeAADwa+9t6L9JjCSJvqB0cCaZyt01yI=
X-Google-Smtp-Source: AGHT+IHxNHOECY/eqqrOsQbWhG5lFKuwhRTSfSZF9B9SyDESEookZJmP6YG/jNPPsZ/nRRU0Bo6dFA==
X-Received: by 2002:a05:6808:bc6:b0:3c3:d33b:181f with SMTP id o6-20020a0568080bc600b003c3d33b181fmr2718206oik.17.1711407112769;
        Mon, 25 Mar 2024 15:51:52 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id l5-20020a544505000000b003c3d6e9f15fsm164956oil.24.2024.03.25.15.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:51:52 -0700 (PDT)
Message-ID: <84a54bf1-356a-443a-a463-c0e3b582cd7f@linaro.org>
Date: Mon, 25 Mar 2024 16:51:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/180] 5.4.273-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 abelova@astralinux.ru
References: <20240325115908.1765126-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325115908.1765126-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 5:59 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.4.273 release.
> There are 180 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:07 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.272
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

There is a new warning introduced here, on Arm (64- and 32-bits) with GCC 8, GCC 12, Clang 17:

-----8<-----
   /builds/linux/drivers/cpufreq/brcmstb-avs-cpufreq.c:462:23: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
     462 |         struct private_data *priv = policy->driver_data;
         |                              ^
   1 warning generated.
----->8-----

Bisection points to

   commit 8930178165fac14653ef502321efc3d5ca7c66c4
   Author: Anastasia Belova <abelova@astralinux.ru>
   Date:   Wed Jan 17 10:12:20 2024 +0300

       cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
       
       [ Upstream commit f661017e6d326ee187db24194cabb013d81bc2a6 ]


Reverting that commits makes the warning disappear.

Reproducer:

   tuxmake --runtime podman --target-arch arm64 --toolchain clang-17 --kconfig defconfig LLVM=1 LLVM_IAS=1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org



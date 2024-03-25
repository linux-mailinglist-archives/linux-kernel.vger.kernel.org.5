Return-Path: <linux-kernel+bounces-116606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E688A105
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073C11C3698E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D813B5AB;
	Mon, 25 Mar 2024 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWWcGkPE"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD413B5B2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349741; cv=none; b=M5UZIBkyYH9uyxZ+Flofnp5ndOFNjs8gPwwlIsBGOIGxGqb1fIHHio6uKiKhehxiwOjrra8Hw0BMDpukxvEsnuc45Y75Bxsf3NPStV4vVjtLW5MnSj+I/V6XO12K6Af/jlLYCtnsKLoMis842JHhtcNh2cPjfCEC58HHTbvFY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349741; c=relaxed/simple;
	bh=P88yR3cDMPHKm38QMX7NZsF3Kx4AeNS8yVGMjzkOh0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wd/rDUWozJqoUA8doKyVx2UqKcbbXLNpWeiwv1rj9MULNDr2UOsX424WsCL94X5NXMCZmw5K8E4gaLAUjyPurtx7wOFZ+iHqxP8KfModrUpMsL9ScEXM4ru1/EBsWxW3Kx250ajbt/NaZRODQoA75BxA7kRs3NwE8vCAnC5veag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWWcGkPE; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4b35ff84eso2254387eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711349738; x=1711954538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9vIKugZVU1BuPJl4zZzAha23TIbhoPXcdCsWMyV92I=;
        b=lWWcGkPESv84IHbvRujnYbqtm2Gn88VNIxnWETM91rr50SeawlO+i1gSApqv7rFJuh
         McQZw5AfEUyEqq63ekZ44SRk70/RVnULljQGY4f+J/+RiDw5ZVLpYKWgxb3uaV7Rg492
         LspOk4UGMTy6y/agQjcDwz5x1U3c2+O88dy6bQSuC/D8S7TfGUkKFyWyQ9f4saDR0Oiz
         JOgV47dqlfg1VGJs9UZKIEpsLAdaRVBDiihxCODQN3LZ4jIBFQOkuXdzVOH+yUG37/ds
         jqzw6ed4rDynzR+Y/+3HW42EzkZEXgkHAWAHJH0HjgQ5ECFpHuUXbQYesA6To9UpFlx+
         wFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711349738; x=1711954538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9vIKugZVU1BuPJl4zZzAha23TIbhoPXcdCsWMyV92I=;
        b=vr92Tq+gL3wTChqY/fBLfBzxptLsI3ZQ0B+2UiWUKWH+SuQGaW9c3Sbnr6djsZ0e30
         C+IMYhWahTLi3htzbcJKAUPndixWYCLVYiAeFsqV+j2lEoxfHropzQqK7083txSWz/6/
         igOT6/OSXeqmx5sV1COJtTonEmHZtgoMdcRuSs+HAqSnHD056gmOhGBV9C25hs5J6tl9
         O2OPoQf+NNZqwPAD5kh3wuuISW7HoXeSTsPD8/X23YWfhowJyoNmpqWPeJ1vxqE+OnLD
         mtzrO4IFfeyjMYuuLUwgJsnQtWsT6lKeVkMvsE4ghtej+dbmYj0OJhn3ICD1D4vUCzu6
         6K6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIRiwuI7PH3bd6hDk/6dx26ZsUr5jGw4HFlKUCEuJlkCB6or3LNRKsQCopWsNTIAJmfr1gfMztX/ZQLMqt9dfO+mY02pIlNgPQ8dfc
X-Gm-Message-State: AOJu0YxNHhqDhQdv7duIt/GHsWtLDO/Dck2NLjYAT9pKPuF3LYE7y3ps
	AXf60OQepqwXGl7AkU7iAM21dL2zhVBNdntvBDQqKm6DxvFeuXPF6XeuDOWnfQM=
X-Google-Smtp-Source: AGHT+IEP6gz32x4ekxOJgan0cH9dB/abpFU9xZmOwdhNRdctveKr/d4RFQjjhnocrCR+CBIfwZqlZQ==
X-Received: by 2002:a05:6820:2714:b0:5a4:942a:2a9b with SMTP id db20-20020a056820271400b005a4942a2a9bmr6548963oob.8.1711349738629;
        Sun, 24 Mar 2024 23:55:38 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005a53e6c7209sm712285oob.28.2024.03.24.23.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 23:55:38 -0700 (PDT)
Message-ID: <cd76c1d0-9622-4a05-9e98-51824bec25bc@linaro.org>
Date: Mon, 25 Mar 2024 00:55:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, tzimmermann@suse.de
References: <20240313164640.616049-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 13/03/24 10:45 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.212
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We're seeing regressions while building PowerPC with GCC 8 and 12 with ppc6xx_defconfig:

-----8<-----
   /builds/linux/drivers/macintosh/via-pmu-backlight.c:22:20: error: 'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
      22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from /builds/linux/include/linux/kernel.h:15,
                    from /builds/linux/include/asm-generic/bug.h:20,
                    from /builds/linux/arch/powerpc/include/asm/bug.h:109,
                    from /builds/linux/include/linux/bug.h:5,
                    from /builds/linux/include/linux/thread_info.h:12,
                    from /builds/linux/arch/powerpc/include/asm/ptrace.h:264,
                    from /builds/linux/drivers/macintosh/via-pmu-backlight.c:11:
----->8-----

Bisection points to:

   commit ee550f669e91c4cb0c884f38aa915497bc201585
   Author: Thomas Zimmermann <tzimmermann@suse.de>
   Date:   Wed Mar 6 13:28:20 2024 +0100
       arch/powerpc: Remove <linux/fb.h> from backlight code


Reverting that commit made the build pass again.

Reproducer:

   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12 --kconfig ppc6xx_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org



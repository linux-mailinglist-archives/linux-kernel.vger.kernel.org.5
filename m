Return-Path: <linux-kernel+bounces-16239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5868E823B59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF324B24D48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7711190;
	Thu,  4 Jan 2024 04:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgzlT3pr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8F18640
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dc025dd9a9so87890a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 20:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704341412; x=1704946212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lO3AY8LywVDisOSp6nacwDg6jBR22j29N6tFVkS+6I=;
        b=lgzlT3prnkdbpQIo8P+I84zV6tnllz3WBXKJD4wAhqnVzR65qDu16s+CTkXe7pAJym
         ym8e0nDtgUDtVc+RpW+p4BV3xk4DUzKDaflhqUEBiL/S/7qwXkE5QALpXv4H5amP9daX
         DE0lv/YySf0RTkSKP4rWz//uLViBNK/0PphM6i1M5xR477kReSHNeEJYQOdoKufxPFh0
         uxbqsKLsqWnuPpE90bQGMzgnUfiXQzhA4KGwIH4HWJlhhW08q72FKimFy24kSgrrvyyO
         3pCla/gzD0DOGlczpk/WZnSyHlHigbrS+H0WSTaCQr7cVSITUTRv3hCCX5gR41laHVBX
         8jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704341412; x=1704946212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lO3AY8LywVDisOSp6nacwDg6jBR22j29N6tFVkS+6I=;
        b=UzlF3VaK2d+aVVOhjKX4Tm85M0CgVpzHYKDz5BeqCmdMn5oUJHTh6bAJZ+5RWp7HyD
         ZFNx/vX+dN6XpSGLuGt4ELKYJ3yoKVY2HMLjtCnEm7m8jXLtqXQvpHb4cfzIfZRiKoAB
         PmBPmt0TR2o13Lz6v23KYr972f8l6wmsW/rMZ9ogpda6IDKIDuUh/OsScDS8agEOXUtr
         F6pRtVh/rJ2ydRjoNB278kVwQVGZIltE08LVW/qWIxJRr446wRDSeHa4OzHMh/mpYJ22
         Qz24GJmo2AKj0GwOOAMq2L9Cy6RiafMqbiVao9QCZ78/rFPgn//SWSpmC3dm6vUCxVMg
         MO9A==
X-Gm-Message-State: AOJu0YyiMmA4G5/6dgspuC/Kr03ZcpEcCUBSAh7NoU416rYc1LOoWy92
	W1Yun5WGL9cwxpqqUEevVGuVd4XbzI4z0A==
X-Google-Smtp-Source: AGHT+IG1B1a66RlkeVRyvh7QrPt6k861MhW6+ltNjkShl9fILSeCzwN9SwqlT8GFLH05EEvBMiMgyw==
X-Received: by 2002:a9d:6d0c:0:b0:6db:fee1:f4a8 with SMTP id o12-20020a9d6d0c000000b006dbfee1f4a8mr101682otp.2.1704341411780;
        Wed, 03 Jan 2024 20:10:11 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.99])
        by smtp.gmail.com with ESMTPSA id x45-20020a056830246d00b006dba1ec37ffsm4533050otr.11.2024.01.03.20.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 20:10:11 -0800 (PST)
Message-ID: <99fe3993-51b5-4284-8a22-869764f393d8@linaro.org>
Date: Wed, 3 Jan 2024 22:10:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240103164834.970234661@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 03/01/24 10:55 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing a build regression with x86/GCC-8 and allmodconfig:

-----8<-----
   In file included from /builds/linux/include/linux/string.h:294,
                    from /builds/linux/include/linux/bitmap.h:11,
                    from /builds/linux/include/linux/cpumask.h:12,
                    from /builds/linux/arch/x86/include/asm/paravirt.h:17,
                    from /builds/linux/arch/x86/include/asm/cpuid.h:62,
                    from /builds/linux/arch/x86/include/asm/processor.h:19,
                    from /builds/linux/arch/x86/include/asm/cpufeature.h:5,
                    from /builds/linux/arch/x86/include/asm/thread_info.h:53,
                    from /builds/linux/include/linux/thread_info.h:60,
                    from /builds/linux/include/linux/uio.h:9,
                    from /builds/linux/include/linux/socket.h:8,
                    from /builds/linux/include/uapi/linux/if.h:25,
                    from /builds/linux/net/wireless/nl80211.c:11:
   In function 'nl80211_set_cqm_rssi.isra.44',
       inlined from 'nl80211_set_cqm' at /builds/linux/net/wireless/nl80211.c:13000:10:
   /builds/linux/include/linux/fortify-string.h:57:29: error: '__builtin_memcpy' pointer overflow between offset 36 and size [-1, 9223372036854775807] [-Werror=array-bounds]
    #define __underlying_memcpy __builtin_memcpy
                                ^
   /builds/linux/include/linux/fortify-string.h:648:2: note: in expansion of macro '__underlying_memcpy'
     __underlying_##op(p, q, __fortify_size);   \
     ^~~~~~~~~~~~~
   /builds/linux/include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
    #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
                             ^~~~~~~~~~~~~~~~~~~~
   /builds/linux/net/wireless/nl80211.c:12939:3: note: in expansion of macro 'memcpy'
      memcpy(cqm_config->rssi_thresholds, thresholds,
      ^~~~~~
   cc1: all warnings being treated as errors
   make[5]: *** [/builds/linux/scripts/Makefile.build:243: net/wireless/nl80211.o] Error 1
----->8-----

This is currently being bisected, so there is more to follow.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org



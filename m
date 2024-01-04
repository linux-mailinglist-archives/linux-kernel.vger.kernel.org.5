Return-Path: <linux-kernel+bounces-16305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302A3823C88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0501F2612A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301001DFED;
	Thu,  4 Jan 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCrR9rMg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54D1DFE2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204235d0913so134572fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704352549; x=1704957349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2SmQScyvIuLdY3E1hFWKaRhiC86WTLlAjqHutwpfeQ=;
        b=HCrR9rMg4i+4XQwPdLR2RC9kSODXJQykMjvo18WfW+phQ+MTosBwO9wYhlIxPSQRy6
         EPA24mm8y7DMmnYLtwSv3Qh+zT7bR8tnvZeZZdycIBl/fxLaVQj2/SlnELpVLGBP7v/M
         dCPP/g/M7Jtc0z4Yhs36TBrJfgKZotglrdAI7cMbtLZb/I3XsaJR2o3fqh+o2JZYVtMN
         nWFO6aIG/5dV/nKwnB8C2AiF2u3x4Bbk/Te1ItmrQv3ogQY3OKsZ+DuYqGT48NTNwyGk
         IStLsi8xhMQ1VQqJW4GBBkoWBsUMK0Za1bLQocRhQ3AMnTIi6xasfEN8LKAAnUm4BzYS
         m+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704352549; x=1704957349;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2SmQScyvIuLdY3E1hFWKaRhiC86WTLlAjqHutwpfeQ=;
        b=WwDOucAZ2Ix8A8GWWxJuL+0dAxt1bXUXq1B/v7JcRp1tFpLE6KdxCuylCRlvg0s3nO
         EUJqKryCU1uvPHvddMLi96uSd2MJwppx2jPPp6hWrFSdsmEk389vbUV9IaCK0YAZhxNF
         6dZPiLokG8k9Fw6RchfjUiuzMHxQzdiHiOxFfqTEHJvXui1yxKW/shtlthMAqU4i1Izn
         ajbGOUqU3ZPVnc+9/AIZDq92ySC/UTHcLD3um9+3tfYxtjnRDX31eSJiRi3jj/suf0iv
         3fABBlwLX7aM/hzJTUt336yedtg8Yikr1+3m54bAGHJdQrb9luPrCOz+6e5ykCONuEFF
         wMdA==
X-Gm-Message-State: AOJu0Ywfj5jfL3VLqZaEYsETE2slLZDj2Sb+Cre3/og/5JWuRzHOpgXm
	V22+hK6OFk1DPKavQA6nhj58/Qmlo++Gkw==
X-Google-Smtp-Source: AGHT+IFDtkmc/5Itm2/vrFUrhCZarPV/ONCswJm00ZQe5veImd2aILrozVH3VBmTM9uNWBifaFHrHA==
X-Received: by 2002:a05:6871:e410:b0:203:ef6e:2319 with SMTP id py16-20020a056871e41000b00203ef6e2319mr251670oac.10.1704352548337;
        Wed, 03 Jan 2024 23:15:48 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.99])
        by smtp.gmail.com with ESMTPSA id u11-20020a9d4d8b000000b006d9fb0458cdsm4542214otk.39.2024.01.03.23.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 23:15:48 -0800 (PST)
Message-ID: <32ebe3f1-49b7-4ad3-9ea5-ed2adbbd78da@linaro.org>
Date: Thu, 4 Jan 2024 01:15:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, leo@leolam.fr,
 johannes.berg@intel.com
References: <20240103164834.970234661@linuxfoundation.org>
 <99fe3993-51b5-4284-8a22-869764f393d8@linaro.org>
In-Reply-To: <99fe3993-51b5-4284-8a22-869764f393d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 03/01/24 10:10 p. m., Daniel Díaz wrote:
> Hello!
> 
> On 03/01/24 10:55 a. m., Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.6.10 release.
>> There are 49 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> We're seeing a build regression with x86/GCC-8 and allmodconfig:
> 
> -----8<-----
>    In file included from /builds/linux/include/linux/string.h:294,
>                     from /builds/linux/include/linux/bitmap.h:11,
>                     from /builds/linux/include/linux/cpumask.h:12,
>                     from /builds/linux/arch/x86/include/asm/paravirt.h:17,
>                     from /builds/linux/arch/x86/include/asm/cpuid.h:62,
>                     from /builds/linux/arch/x86/include/asm/processor.h:19,
>                     from /builds/linux/arch/x86/include/asm/cpufeature.h:5,
>                     from /builds/linux/arch/x86/include/asm/thread_info.h:53,
>                     from /builds/linux/include/linux/thread_info.h:60,
>                     from /builds/linux/include/linux/uio.h:9,
>                     from /builds/linux/include/linux/socket.h:8,
>                     from /builds/linux/include/uapi/linux/if.h:25,
>                     from /builds/linux/net/wireless/nl80211.c:11:
>    In function 'nl80211_set_cqm_rssi.isra.44',
>        inlined from 'nl80211_set_cqm' at /builds/linux/net/wireless/nl80211.c:13000:10:
>    /builds/linux/include/linux/fortify-string.h:57:29: error: '__builtin_memcpy' pointer overflow between offset 36 and size [-1, 9223372036854775807] [-Werror=array-bounds]
>     #define __underlying_memcpy __builtin_memcpy
>                                 ^
>    /builds/linux/include/linux/fortify-string.h:648:2: note: in expansion of macro '__underlying_memcpy'
>      __underlying_##op(p, q, __fortify_size);   \
>      ^~~~~~~~~~~~~
>    /builds/linux/include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>     #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
>                              ^~~~~~~~~~~~~~~~~~~~
>    /builds/linux/net/wireless/nl80211.c:12939:3: note: in expansion of macro 'memcpy'
>       memcpy(cqm_config->rssi_thresholds, thresholds,
>       ^~~~~~
>    cc1: all warnings being treated as errors
>    make[5]: *** [/builds/linux/scripts/Makefile.build:243: net/wireless/nl80211.o] Error 1
> ----->8-----
> 
> This is currently being bisected, so there is more to follow.

Bisection pointed to:

   commit 92045aab1bd9bfd73d816e907ea07739c4550b41
   Author: Johannes Berg <johannes.berg@intel.com>
   Date:   Sat Dec 16 05:47:15 2023 +0000

       wifi: cfg80211: fix CQM for non-range use
       
       commit 7e7efdda6adb385fbdfd6f819d76bc68c923c394 upstream.

Reverting that was not possible, so I reverted 47f3694a4259 first ("wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)"), but that was not enough. After reverting both 47f3694a4259 and 92045aab1bd9, the build passed again.

Reproducer:

   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8 --kconfig allmodconfig


Greetings!

Daniel Díaz
daniel.diaz@linaro.org



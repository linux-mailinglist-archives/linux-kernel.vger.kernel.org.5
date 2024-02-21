Return-Path: <linux-kernel+bounces-73910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EF85CD83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A448284F57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D446A4;
	Wed, 21 Feb 2024 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXzK5qb7"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1BA17D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479641; cv=none; b=lZ0/a4ndV5S1cVJ/ApxX/JN9VbFsM7f0mRWx/BKp0TTkEK5lAE32ZR18aE+dRc6quIvNHuHghziF59CooQRWV1vaxgievt7SsHnngqkmYXUjS1+ViIJqZO/ZTV3ZI7hjjS9YeM0BS5tBzSguXSNrq+q9R0jVvi54as0jw7dgnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479641; c=relaxed/simple;
	bh=MHjeNXfg70vZndjn2W8FYoWEeFiRzFLlHm568a5/VKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MLZnQ0UFTgx/iuoGcyWttVKNyDi7wEPrGBRbLBCEo2Wr48JzxJlBlZ0NdBfGwmnKmYqLufro7UlpWm/jiBi6RIue74djRMlm2z72mBb3KQL47dXxQwZHBSp/jt2N6WLwpIOBilxOKTwEwPDHkBWuoKajNagwm0vZBMm/RvvnXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXzK5qb7; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c15d67b83cso1050460b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708479639; x=1709084439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFQJDZxmoMvr6g51d9kMvuqvb/f+3ctrTw6gtvp3hGc=;
        b=OXzK5qb7z1RcVIPgyMAj3266hr/RORujDNCviE/G4XGoJtH8ekuafhrrWqzcKWJeRp
         kTi0TzsG6mlcziFtI7PWnVw/fQuKupGQDnT/7TciGYK5W2Olrh4I98r6Dp4xrFAtQ8li
         sZXIh/TRTRmZ9uKY/rGq0OT2W1fu6YatS6GfFJIRKDA+Tv04Q54eSESuPwYl2uyhHpux
         sKoVyYw50pDOdWGLBdA6BrinhykjTzvG6lcClyoM+pkZwiptJheRk9YNfVUD1oVEg3DF
         C1FwenXKn/gjGQ5qVmt4nkSuaXQxGXWNUZ41n9zCSBqWquAuaGB1dIssm+vnPRpcxJAH
         uEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708479639; x=1709084439;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFQJDZxmoMvr6g51d9kMvuqvb/f+3ctrTw6gtvp3hGc=;
        b=CxhMYFbQyfMWvXmsJvRiup/miZn6urqC09B/XXiGlAjXZk5aC6WuL9KdiDWPgXMqH+
         qVqlJ8qjdZJ/85IfKp/qIVwTbqkgVBMLnlDVa4xIPe3uOhoFdPaqbm1Ma7C/HaEX3aMG
         5icE2159usOTZMkgEOIvqBWbPVbvwaWi4+CN5ritQ+djseqJNamhE0Pn9DD6RhEdEz86
         8k98DDOgrojjds8s9jFbdL7Jtps1EbZlSjAfzUVflGCgU64jtGx3rUqjErioITTsklUN
         euzHZk5cMoZO20bO36mcNyJ0FHiXP2dscqMnGV5u4RlSm4VjhVPhG30X1woc9Xuaum0H
         LZpA==
X-Forwarded-Encrypted: i=1; AJvYcCWvHM8tspYm7Sc6G4+HP5UeC+RuUJjtjYTfLJWrV5Nw5WB14HG41IVjxfYDkAlXKwbxnqJF9pIGFlgHEHnAsi9Y6xo3yA77HDHe2ZiJ
X-Gm-Message-State: AOJu0YzmMX9/pFIVh1gQ3Nt36AkjMS9LhlaihRSw+iJMVZFC1UIWjPgz
	BsXbuFgTsCVyoxTnuOz52ZHolvdrAHySQhCOEUsB+GBwHHkTdJiPALzdD+gBDWk=
X-Google-Smtp-Source: AGHT+IEtmFf0cEi0/mL21f4Jx5A5mi5l/Gl/Dzo0kvoN5f9i1O4XHUPyAD/0vafiZ2SjHgHDua6ylA==
X-Received: by 2002:a05:6808:384f:b0:3c1:4d83:30dd with SMTP id ej15-20020a056808384f00b003c14d8330ddmr15714514oib.13.1708479638926;
        Tue, 20 Feb 2024 17:40:38 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id y16-20020a056808131000b003c046fa43d7sm1363131oiv.19.2024.02.20.17.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 17:40:38 -0800 (PST)
Message-ID: <7e1faa29-a154-41fc-aebc-38d5f355ea90@linaro.org>
Date: Tue, 20 Feb 2024 19:40:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/197] 6.1.79-rc1 review
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 matthias.schiffer@ew.tq-group.com
References: <20240220204841.073267068@linuxfoundation.org>
 <c873370c-c12f-4f03-a722-1ae59743089b@linaro.org>
In-Reply-To: <c873370c-c12f-4f03-a722-1ae59743089b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 20/02/24 7:04 p. m., Daniel Díaz wrote:
> On 20/02/24 2:49 p. m., Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.1.79 release.
>> There are 197 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 22 Feb 2024 20:48:08 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> We see a regression with PowerPC:
> 
> -----8<-----
>    /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S: Assembler messages:
>    /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:124: Error: unrecognized opcode: `sym_func_start_local(setup_g2_le_hid2)'
>    /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:131: Error: unrecognized opcode: `sym_func_end(setup_g2_le_hid2)'
>    make[4]: *** [/builds/linux/scripts/Makefile.build:382: arch/powerpc/kernel/cpu_setup_6xx.o] Error 1
> ----->8-----
> 
> This is seen only on PowerPC with GCC 8, GCC 13, Clang 17, Clang nightly, on:
> * allnoconfig
> * tinyconfig
> * mpc83xx_defconfig
> * ppc6xx_defconfig
> (at least)
> 
> Reproducer:
> 
>    tuxmake \
>      --runtime podman \
>      --target-arch powerpc \
>      --toolchain gcc-8 \
>      --kconfig tinyconfig
> 

Bisection points to:

   commit a65d7a833f486d0c162fdc854d2d5dd2e66ddd95
   Author: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
   Date:   Wed Jan 24 11:38:38 2024 +0100

       powerpc/6xx: set High BAT Enable flag on G2_LE cores
       
       [ Upstream commit a038a3ff8c6582404834852c043dadc73a5b68b4 ]


Reverting that commit makes the build pass again.

Greetings!

Daniel Díaz
daniel.diaz@linaro.org



Return-Path: <linux-kernel+bounces-73894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9B85CD39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD1282A56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F5C20E4;
	Wed, 21 Feb 2024 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Leg9Z+x5"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26421FD7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477502; cv=none; b=eaGQshX9en6XgLtideK3p8tDxwGBEmTbxKw0XFyDikX8AS4nCi54QRAO3EhS7vHhnSuwGiilHPqEGmqPlZAO+v2qfWZ4ZCpgJ+UNybEpHsp5nhGclUR1bPrhxulC9ex0vzJyi45UHQXmRyN3zZylBwGz1BQtoMixMrAjRF86PNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477502; c=relaxed/simple;
	bh=dEEluF2P2gR2xeqyp1Y02BIrtT0tj7h+zfXvTlij9gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3qkPNMGynVX8+zwCIFtv9KQHXHFi62WZRIUem3GY2eB1vjbh8GBKJtOgBY+X+9tczPHIaGWf1wQHc9a/wbZUAANF7gIGOkXVLc1d+bZH7UsapbsJhZPreAv1SNexAw/0D1AKSeHU3a9I9NSPMKBYGKVKkhXWqwpl0Fyl1TFCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Leg9Z+x5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59f7d59d3f1so42979eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708477499; x=1709082299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isNEaG2qmUnKOTH5ZjP/ZpM+OEQOzCRL1IUF9BpRXmM=;
        b=Leg9Z+x5oqTir2SvyVxj7mSbwebw8BOaA7hiDACS16WSINinY+hMRmagw/L7Am+LrL
         utG62EwVME95fX6URhi6MAL48qayFP/XvEVEpkDgdEEJGWM3KV1AXOK7WE0FJsxkffEU
         GESlR4A1t2EcaBp5aGtjJJlxJEHnEHzO3s4++HJ70HRJNUF1n6Q6oeObtjszyC+D0+oz
         LsMcMNJfJODklUolGHe3Xkol+msg4ICqLG7orzDotmh/kv8+24/gKo/aotBtHUNKeenJ
         9Bfj3cMOdoKTpbtdZOuAfbROfiuLZkVIRfb8NqARWhRfVUPv9lHr4NAZbYpg2ASSIOwH
         NJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708477499; x=1709082299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isNEaG2qmUnKOTH5ZjP/ZpM+OEQOzCRL1IUF9BpRXmM=;
        b=qHHPOGK9So1TTiTLMoaloF7FJgUDP95OjnwbKa3PxRzscF9/GIbWWV2b9nSAs1UKIx
         tCkwd1geihtUZpIKW8VzUstQMjqs9bKlOpr4grxhBkJ2ezahYNLG8qurlmc7l2xMkjcJ
         QzyLYqftgHFoZndt+HVW/DdhWSPaVqPXEod8yE287uOZQ2/BLOiloA2Hsx6nF8AENBf2
         jBNfr20wGsWUYzv7p3B7dAyIMwjTD1QYA4m3JIqXFRq2Rrm154qwxOy/+QEzzvwyIX+i
         R8cp6vZ+6SQd08dd2Y+mrbOq7R14N/ODdDAJ5eL5tPBAKxk8uu81MmpWpGqOfS7Gzwlz
         9m1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrNR2UWzH22N2MV9oVMnaXwnwZ2BBHLhsDw68Ad3YEAdUl8Y8GjAVYrLsL09wjNNqjD+8XvsK8fUPlr5zMQYlMPhVH/JPYMbKNY3v0
X-Gm-Message-State: AOJu0Yz3pgYOECMiRcVbCYSKQIosKX/VIeMQCavXdHFwUDZY70UjLmZh
	Lz2L8+YwneqAqiVXw8oM+17A2uD0V6l9YiKv+zoYbe/LbpOC4bP3mbOW9J0AyrQ=
X-Google-Smtp-Source: AGHT+IEPSYsGXwIa99frjjxu55kRc+mJZefx8BZP63xdHJTTQr2I4XQ4GxSUQa3YlEbf6wzp0j0GLw==
X-Received: by 2002:a4a:2b52:0:b0:59c:e5c8:bdc5 with SMTP id y18-20020a4a2b52000000b0059ce5c8bdc5mr15417911ooe.3.1708477498904;
        Tue, 20 Feb 2024 17:04:58 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id z6-20020a4a8086000000b0059a530f54c6sm1639833oof.10.2024.02.20.17.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 17:04:58 -0800 (PST)
Message-ID: <c873370c-c12f-4f03-a722-1ae59743089b@linaro.org>
Date: Tue, 20 Feb 2024 19:04:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/197] 6.1.79-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240220204841.073267068@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 20/02/24 2:49 p. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:48:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see a regression with PowerPC:

-----8<-----
   /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S: Assembler messages:
   /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:124: Error: unrecognized opcode: `sym_func_start_local(setup_g2_le_hid2)'
   /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:131: Error: unrecognized opcode: `sym_func_end(setup_g2_le_hid2)'
   make[4]: *** [/builds/linux/scripts/Makefile.build:382: arch/powerpc/kernel/cpu_setup_6xx.o] Error 1
----->8-----

This is seen only on PowerPC with GCC 8, GCC 13, Clang 17, Clang nightly, on:
* allnoconfig
* tinyconfig
* mpc83xx_defconfig
* ppc6xx_defconfig
(at least)

Reproducer:

   tuxmake \
     --runtime podman \
     --target-arch powerpc \
     --toolchain gcc-8 \
     --kconfig tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org



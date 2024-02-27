Return-Path: <linux-kernel+bounces-83872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F827869FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DF1C28355
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26060524AD;
	Tue, 27 Feb 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYQSLgs3"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C23D988
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060167; cv=none; b=EqNwxpHCspD/Xwa+ko04uEAGCTNSPjffoWYEzcupDjGYQMeRTalDHxrx9nSwgWw8uhwn0e0fynBE7KHfUjHddsFU9gmfnsEW9fTAjQtsroT2xV36bf5Hqw1sR03MGMTDyB1fXFttowL/VZLhksWTnpK14muBUwDYNpiM5xE+tFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060167; c=relaxed/simple;
	bh=xQWxb5jXsREbqkstiB99b2thxnNCWYBgYcHPwz2pFEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uks9+0Cr3GcL4YyoZVAfaoNJPOrjNVuQHKcFAAG00hd5HM2ITtgKs7ngEbbVepNqBZDKIJysKfH96Xv30ZhXZIS465mQY+9KE13mdwIQpJvbab3R98KtkuJu/8PtcP2fyVX36SDURNgEgjjyZ4D8oBCPKtsN/QXqoafyTz3K3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EYQSLgs3; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a09c79bb2dso1111307eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709060164; x=1709664964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDR3qYUWJRNDIU0vAo9kG+/b8kR9evkQt+74AVhMif8=;
        b=EYQSLgs3CD8lJfYq2cf1ooTY/v5FkRDBfFYmsMd3akEsiDsfdmFx1h+Sr++GjguMVa
         3otU7i9DgjJSOlVnt3ASkJ7w7F5MJuVWiFC0OjlKovhUBaLqM65Q38lus0gKf4Jx1agv
         IxH3tdIoVbnUmJVFjFLcr5w1KPt/YDGi+GUaRWXT+NSjaRsqpodtSdr1zG1+Fjea3k/V
         z5gNgljz/kWZQbS6AVA/Pp70DZSOqtT1o8J7vbkZi3B7rgBL0W3Cgbr0iIx90qg4Gyni
         iRUXhQhUvFvB9gzDfUqGOiH1B/mPJdxKvU0+DJSP6jjPX2DN7vTKoDymfTRg8OLkq1e/
         obqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060164; x=1709664964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDR3qYUWJRNDIU0vAo9kG+/b8kR9evkQt+74AVhMif8=;
        b=vM27u0xaGh73tNBRaDygEAUn+TCxX/MH03LK6ncD5lfSmyPKrm2k+cuLDTfogI0Glu
         TxSIorM94Urn3t0Rcnx2GTDYtCn3IiK18FADtYTqCj2N0s/ezWMgX+wB/pAYmiegksIG
         Z9/0jiZ5j4r/ZkJ0PQWC6+7qG3mRw2SB6z7yPzpGvTFX9XeJDc64aKF+0Sk1q4Vp+Mzi
         SHfWbTcIL4zK63/rJdWTowYc95WQ4JPuWCWaJ3FPahUQkNWNmTJff7Gs0/IXpVFrWbNq
         5U58eiae1mwKGkI9PVmKVA3iMIX6Ii/kVreAgSjpamrOGUt3VR0gQlBUd/DYEoFrqZB8
         AFjA==
X-Forwarded-Encrypted: i=1; AJvYcCXH4VAcRlOO5dZzBdR3GTbBFXndaPbzcYbmRcjnveWV+JRPQaYrK7GJmYf28ChBvEyPErRJeYnH8gIg02O+cSix6Uc9xVR8ayN8kdk9
X-Gm-Message-State: AOJu0Yx8qNWKsrjGaHIdcRQQ3vMWBEWFW9ynz5b32MxO6IWpcFdv+dxm
	EVzhUnT5NEe3rL3Hzk4W6I6M5yUei94sU69kpCbxS2UTBMGTohnrltihnOGlZUg=
X-Google-Smtp-Source: AGHT+IGt4SgnRiGwNSpwucUlCj3R/hQl8nk0pTJFwKC1NEk0SmrmixVrN9SOyNmf64JyRRoByt0oMQ==
X-Received: by 2002:a4a:3c07:0:b0:5a0:c53d:3e33 with SMTP id d7-20020a4a3c07000000b005a0c53d3e33mr92457ooa.7.1709060164338;
        Tue, 27 Feb 2024 10:56:04 -0800 (PST)
Received: from [192.168.17.16] ([149.19.169.47])
        by smtp.gmail.com with ESMTPSA id o12-20020a4a384c000000b005a0af4efa0dsm377271oof.21.2024.02.27.10.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:56:03 -0800 (PST)
Message-ID: <0b1b1523-3f26-4ce3-bdeb-4df3c2a8e685@linaro.org>
Date: Tue, 27 Feb 2024 12:56:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, kuniyu@amazon.com
References: <20240227131558.694096204@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 27/02/24 7:26 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.211 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.211-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing new warnings on 32-bits architectures: Arm, i386, PowerPC, RISC-V and System/390:

-----8<-----
   builds/linux/net/ipv4/arp.c: In function 'arp_req_get':
   /builds/linux/include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   /builds/linux/include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   /builds/linux/include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   /builds/linux/include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   /builds/linux/net/ipv4/arp.c:1108:32: note: in expansion of macro 'min'
    1108 |                                min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
         |                                ^~~
----->8-----

Bisection points to:

   commit 5a2d57992eca13530ac79ae287243b3ff6b01128
   Author: Kuniyuki Iwashima <kuniyu@amazon.com>
   Date:   Thu Feb 15 15:05:16 2024 -0800

       arp: Prevent overflow in arp_req_get().
       
       commit a7d6027790acea24446ddd6632d394096c0f4667 upstream.

Tuxmake reproducers:

   tuxmake --runtime podman --target-arch arm     --toolchain gcc-12 --kconfig davinci_all_defconfig
   tuxmake --runtime podman --target-arch i386    --toolchain gcc-12 --kconfig defconfig
   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12 --kconfig maple_defconfig
   tuxmake --runtime podman --target-arch riscv   --toolchain gcc-12 --kconfig defconfig

Reverting the change made the build pass again without warnings.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org



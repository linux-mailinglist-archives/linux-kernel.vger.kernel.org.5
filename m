Return-Path: <linux-kernel+bounces-67327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BCF8569F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDD9B23186
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22913664F;
	Thu, 15 Feb 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRpw0XVh"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1D39FFA;
	Thu, 15 Feb 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015779; cv=none; b=fnWpNqrpXp82vXeBbRMMU9jBOThUlnF4Abx3XilHY1jwXAJM1pI6FvTIdc3qa9h54Rs+ur3sagrVSGoJTFal6QxJ6hy4O/eCzoHqCn8yHu9O3uhvRO5GQQaB8w5l7gPOqEMokiIn/ipb1pztYrvs8D2sDT/2tLKBaEK0JzybFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015779; c=relaxed/simple;
	bh=nDBJprtupek6jtz+xxAg9qE3vBo3ZI3396Tj94+XKjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiPUUDqFL6jKdW+IpijYgpWs2c6fccgUX3L2mixJwlAnxFYyPOx6sa58wmn+xdGQ/TmwVC03gXKHZAdT1EMxnmf7epebfgKRxRZv0QP2hAH2dIwtsC4Kc2wRn1+M/q0F48hRHXKpS/jdh+t75rV0/NTLGd343jtBApSfbk4tUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRpw0XVh; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so650417241.3;
        Thu, 15 Feb 2024 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708015777; x=1708620577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/bbFkvOmHONTA1ff9N/8CU619rdiPvpvqzPbqsPJyy0=;
        b=KRpw0XVh2ZBeJvhgHHLCgfkcVCBaWK6xh7UH52DUvRToPTkyENAr3hy+U1fpkoRgsC
         XkIU0kL0WMl+iVCSfNXjH80tmVLffOJrDTLvQDw6qxJlzNtlVN++mippkLxGxxRUe5ze
         3gvFXfn4/Pty7/9JfELKk4jbrfoLB6dPUAFsylaiYyqx+5XHTTYhjxewgTkgCh7ay5vg
         oiopJ8CNAsW4sg4dEP0nIHEpLa/boUpgnSfiinM18qpooNMy3a2XY1M+iaTBiFLnPwyJ
         4ZPlYzi+Mtju5xIddD+sPCbGyHVEg/JoqHi8d5u7fPRB26OMVgG4Nbd9vKgUDwNu9Xmu
         jPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015777; x=1708620577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bbFkvOmHONTA1ff9N/8CU619rdiPvpvqzPbqsPJyy0=;
        b=lol7Vr8NMD7Ayk5hIe4BCrTZY4R4546SKIHHGPtVDn0QI82EbRPOU930VqD61CFamO
         FpN/x/0Q3BT9dQdSzKeqcXUitNljZbRhoWpCRjaMbf8TgRJDgClXgxGBxdz9oXTWp87k
         JQPX6k/gdEN2WVU9i3n0hWKKqfhYu+SiQDOOc4ymmeUa7BcVjqS1iq+iVnXXHhnTmbzc
         4osqV6Ibtj0gSTMz217ByrIshva5BqmjzjQZ9vP09zkwJbzOtLx7jetJd8PU0nQv6gIw
         0xspQcf7Uk/vAtCsbp1np2+RRMletKMFEVAHojkS0L/M1POl0+iCqHNY1O1i/2671pHq
         m+mg==
X-Forwarded-Encrypted: i=1; AJvYcCW5kKyl7xd2WMZj0558QWxKroenWyy3aO9db/WNU1piZHjUHAA1XQN7cqU5fnltK9/6KSWq61MCfe1VLO9iOE0GD8PVf2eL+psb3oee
X-Gm-Message-State: AOJu0YwlF8EYamdql9edt/s7t9BFEbKoMYHiT1YZ7Xi7WINFR4jniIgP
	swCrqyaU4l3H4Ya/K+xH6YGmgoICpU8NnakkEKbUKfF/Crvw7zhXI+OSu+hz51jL/P7i8h/yGb2
	D/ULJ54lYHXTwqUmLZN/WssfNrFQ=
X-Google-Smtp-Source: AGHT+IFVL8vctjaTh51mhc7/RxZwMTHNMS1gtWZUf4uRKGMewRW1zbnifsv/ppry04OIayZYguikNJJRVZIWLqu6Y14=
X-Received: by 2002:a1f:4b87:0:b0:4c0:29e5:d31f with SMTP id
 y129-20020a1f4b87000000b004c029e5d31fmr2180656vka.2.1708015777272; Thu, 15
 Feb 2024 08:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214142941.551330912@linuxfoundation.org>
In-Reply-To: <20240214142941.551330912@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 15 Feb 2024 08:49:25 -0800
Message-ID: <CAOMdWSKJZFYaD3TT9fk8Cj3GSpK_pyEVrgHaXTik3n8VR7UxzA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.78 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.


Return-Path: <linux-kernel+bounces-66120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19D855743
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783541F2C1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523AA1419B4;
	Wed, 14 Feb 2024 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRz6VTmC"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306F141996;
	Wed, 14 Feb 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953301; cv=none; b=rz/FqHbQ846HLqNcqAWGlFJzjgCY3eWxdbnOnKGgHZuF/vIAXVv1VpRJAeJ6P2sGQ9VmOFUx58/jvdmKydT7Yq//8KXkCy01s3s50cC9yicPCpeWaqMklsHsMEU8JU2w+77E1a/7D2q/HF6nT/9Ltu0w/ueimHMFyPH36DoTRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953301; c=relaxed/simple;
	bh=5h7Y8lbUNLMAQRCOLPW9ArsrBAoUhQhbkWbJuOI5ap8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtNT9ioTIfYG5SztjqvYe7D4yQOnDPU/C3v7fBDDhilrMEHaIgJOxcu/R79XysDLVrqCuuoUAexZWWd+Hrhh7P4hSdrDH5JDsyddE/jMpv9/aUCWLSamtwFdubsmelNTR3IiUxXQJLgGzT4ezCdSiOlVorYOKXj8DPAsPS6GK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRz6VTmC; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso113743241.1;
        Wed, 14 Feb 2024 15:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707953299; x=1708558099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz9FuZCe1t/s/sOzWyWj2VJKhDH3TaEC7G892r1B5/M=;
        b=gRz6VTmCxCMEEou0GCWhXfXomapcjY9fS4PcooXFoMUsi6hGyJIotk6+KU+DCOpjbT
         Yu9ro7N+XfCG7JdPqRqTB2+gKeu+9I+0Ke54uD/Qbq1hBX5iswJHtQxVZw1xqK7Vfb1N
         8zswOSB6wZ8ZEkuJdpbAOatnGod1XmKXpizXvE29L6UMRVGKOAVkOaFyeQEl30Ot/HJG
         opklLS/I1fBRT3arjFBGicxe7fqlgcXvaic3qdfb3r2+Rk1VIY6n2OyrdU+6vue7oolK
         6xIKvYcXxR5nnQKkm0zvUIOyQ66qps608qrXZxhMb7D3gr1OC6NOf1s1sfMMepCUWKcd
         3KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707953299; x=1708558099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tz9FuZCe1t/s/sOzWyWj2VJKhDH3TaEC7G892r1B5/M=;
        b=sY9jxI5Te+gMygyHrSO0yJAkXK+U6pahgaraG4KnQt/owMhHlylNLnMr6jtHaRM9u8
         kXizaQaQDhR34vW0l40J+95A0ZsUSBTb1Dy5dt0dpY/nbe/lSm+R7AGeQgeI3rYjrRfv
         fKqZiManh+p4/r+noyLgtSmv5n+0dovTWRQlQQ8QoGr6plpDw38N2HqgxLU+BUdfpucf
         1LR0xM8UWR+T5LIEYR2uMH4Du7tsQYmNeXKRhzR1TcjR7Mye90ZZdhSHbfWPFacvyUNw
         KAc3e6z7QfJ0fG/lLYA0yN+DKUAh0XtvvwbKy06opT75hLfCnGpbCamMp4i38dgjfUYP
         hYqg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4929Noghjb8y+N34h0Hx6VaTyCp3ElwCv2kqz8pcjxkImieFfIqUDpLj0YjmyHzm74+Q/fcqYIUc6v/Vf1QkIdKTxDg5Iqo2gQvv
X-Gm-Message-State: AOJu0Yxkc/eUTZdQ/INHFxwOv89qHvRPcLVmAmh1jrK9t3oD9Nmh7kRs
	s/IlHB4YoOzzjcfWmYd8oMCavEpk7lWzxOatyxPQIw8WRr+ZDvAmxUvoUFPovOTbJtSr5GZn4Sf
	3HGC3EUuDa4yA7qWLqoJvtCfKJ+M=
X-Google-Smtp-Source: AGHT+IGGaF2GFe2/KikEaqiK30P94DS+IncALzUVkEmkbzsrhehvMIx3y8vq2VpyOfV1iYqslom2UvHXddgzvvjkSO8=
X-Received: by 2002:a1f:6242:0:b0:4c0:24e6:f49d with SMTP id
 w63-20020a1f6242000000b004c024e6f49dmr4185961vkb.1.1707953298928; Wed, 14 Feb
 2024 15:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214142247.920076071@linuxfoundation.org>
In-Reply-To: <20240214142247.920076071@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 14 Feb 2024 15:28:07 -0800
Message-ID: <CAOMdWS+=9Zp=rCJf8X0eXghkhOOwYTzWaEH2Z-8kjMx9w4DrgA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.17-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:22:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


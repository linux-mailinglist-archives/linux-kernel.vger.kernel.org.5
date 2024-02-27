Return-Path: <linux-kernel+bounces-83885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB886869FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4231F2FA31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595250A68;
	Tue, 27 Feb 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU8jpSnZ"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00E14AD20;
	Tue, 27 Feb 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060511; cv=none; b=LAMWdLBtx12h7pzZXrAlVrC+NAqZ9TH6ylZ2PfkFHfPEV0pFgqHjGVUzozQbqyvgw3r2qOkwamkHK43fnpCQ0vAelsmdsPA2WupM4QqInGZrEUeLucV0ceXoWbBBRCBRuVP9rIXNYenT6JDyzZqdG/5GsdShPlpNeEDUbffZb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060511; c=relaxed/simple;
	bh=51jtFFY8/geln0haK5sNAZr/aqnSILVfKwu6u7XLrMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP/a62P0lZnWBRs6z8v9rKt9FRxwHZ1G5mAQDNz2LCkbMsfrxo7AaxFCOw3IGCLIef9IsnHLvqeIBEeLln44kMMh/taeu3PcoV8J3J7SLcGJNGS525QiuctDqn9Ak/laamlfD3smDzAuwKOmfuiIXOxHfujmFvuaa6jcs5qfl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gU8jpSnZ; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so2955143241.3;
        Tue, 27 Feb 2024 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060507; x=1709665307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GXY/6TLcSg2JBPkZ750KSp3lrbwIelE9us8AkMM6UHk=;
        b=gU8jpSnZLFjXyTPQAoH87Xl9oJ11GlVplfmNu12SbocFv2sei2g7BqkLLmt61reH+J
         8Xhek2Bqhp9Dh6/sKSUQWLYsfUXLfMzAAVauvppddAEbQyd3F+1m3XnUpAi0pMiql2mZ
         hjTDt5FftOjWJjT+1jHvC123XIXfDZX+KbArI4URc0d5CZ2/HGSBER8Hn1cHEVM9p/ry
         qWN32p2/XRqSVo92L27SnUE4xqMr8Ci9ixQK6GEUvjPOTBep+maW4z2QquAw6FbjF+9s
         w7C8zcQuwaEDJHXb7BYODyK5cNkCf+XXpIGERZREUrp8AkhjnbmNOpq6utnngDqZ6eZo
         4YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060507; x=1709665307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXY/6TLcSg2JBPkZ750KSp3lrbwIelE9us8AkMM6UHk=;
        b=PBKaEcFEDF0uTFR/vfgXwjYWPlnJ+9jHuRTpigo3i3UdkwHs0nsZw4MpGiTlLdrr+T
         eAUVNRLt+trcQoEVBWS/e0ihntLz0izl1iW7T40Pasfnk7X/9F4eytczjZm2cUHchqeo
         c2b8K1LOs1+vETXOeWya3XOjl7qAEOu5ewaqEfb/n56d9styFw5zw+7cHZgbVACMk1sJ
         tPXho8ralBl8HcRRxRsg4dQXeK/Q5GP2KkI74rAB5LwJJD2cybY6WY7YvlG9+Ix4isB8
         gMQGksZ77OsZPNrC0ujeDfm41GYbOlSgIuEKQGJ8+mSnYMnvlcAYlL5HQIUj643guEn+
         b36A==
X-Forwarded-Encrypted: i=1; AJvYcCXkKFr2ilXH5xOFo1oscrrjakYfFwo7UsAxNxTxtU7rMKEI6Z6SBI8hwuhQSlA0cqcKxZuFWuKHHzPwYMBBEFaGLvDI7IT+l8XPt2jL
X-Gm-Message-State: AOJu0YxXXvnLpZg7uavktupYjJ2UoZEOFcq5V1ikMHFQAySJY3IWYW24
	rLb2T08UBJq77h26qJIS8pFLDmQqv5iuJjVtdWlHBWLZzw+Lu1sRb2+86MD+tFBc8BROJN6otlr
	qHJ77Y+zmkYanE8CYPCXhNOKDaMY=
X-Google-Smtp-Source: AGHT+IFV6iRsZ58o/juvLumMNk6BhV1RC5rufpp/W8VxtAPU8kXRzSrpeZUNR9qwG0WgCSCniOJ+FoNzA/ZI0rxHhMQ=
X-Received: by 2002:a1f:d704:0:b0:4d1:34a1:c896 with SMTP id
 o4-20020a1fd704000000b004d134a1c896mr7413620vkg.8.1709060507358; Tue, 27 Feb
 2024 11:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131630.636392135@linuxfoundation.org>
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 27 Feb 2024 11:01:33 -0800
Message-ID: <CAOMdWSJyXm3+3nunLTNdAhoQX2qqj3Ftszi6LpN-Uj_yyK8G9g@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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


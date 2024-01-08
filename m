Return-Path: <linux-kernel+bounces-20001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFBB827812
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2992285422
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A554F91;
	Mon,  8 Jan 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXhYikmK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBA54F85;
	Mon,  8 Jan 2024 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7cd42bc09adso606151241.2;
        Mon, 08 Jan 2024 11:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704740550; x=1705345350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i6abKjHrQB2M3iEvyThch0ew2ujiuN7TwHMLgZSiAGw=;
        b=KXhYikmKdUow0TClfQxzD0HP3VGvWEgLyHsURCbeJOCX2jSPV32MB2P5YVcacCOSAA
         7cWkd10y/S18NcLNY9CC0LHnUpRfqpUb/Wi5+gxrU23QEDq6LJ3ByccqldrWKBY9dpZM
         kO/x8Z6d33N8IWAliVHpcjtxWa+elvR88gZ6GDhmb9VHFVK+VLAxxPcaphGANaMWGHmM
         s/HXOlnepuHWBh9y627d5FuBf4UIvRXuzVutE4QxWZD863GJIA7VIzazKAg1NCVULYQH
         gu6tc3WB4HsqiogNcieeaKmwQU9uIgkaqMuKItcRA3l2U0kgqWbJEgXz4xRZ57ZhCAn6
         fCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740550; x=1705345350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6abKjHrQB2M3iEvyThch0ew2ujiuN7TwHMLgZSiAGw=;
        b=imzeWw1o8D8ohIADFnkg1FF1K130RGwyKFbySHPMDNjhuQYrTtEBnFYelxuIfutj7Y
         oFKCHmZbY6XwtjkBe06FXddZJu4/9n/kkDete+mG8g2VvKVXHaVPbLSZsaptcDJRQQmj
         BJDHDUcZD2xZcfyPvIN2CU09TltKZuxFLqX4pgUUSmzcqcqxzCzzQwPp7p97Cxzmzgck
         y6pHh2Mzuun6RaaEUpz7Bez9ggeUgib00fRmAbClytHHc4JeFIMXZs6DBy1zrdw3X2jI
         4SshvMegvEoVgJG0IdeMKFjEq3qa6tvvpT5Fl6gidCbTz6zoTbGbcDzo8TLL1J2/PF3q
         pvYA==
X-Gm-Message-State: AOJu0Yy3pI747JkgogUrTCm0uKX9iSLXv69JqixJwoyCV2PK17aBF9v2
	+PL/MwJPZl3DzWMWBWrvBziNESZeoJnBOJ7zo5U=
X-Google-Smtp-Source: AGHT+IFZ1oroFQ9FrqNxPzcXlCCnla9b5liu5pflOjp0/Ol/BjcIbkeCD8sMeSlMGrotbUouwpW/5I/1St5MfZUJ1D0=
X-Received: by 2002:a05:6122:589:b0:4b7:97b9:527d with SMTP id
 i9-20020a056122058900b004b797b9527dmr1351897vko.26.1704740550525; Mon, 08 Jan
 2024 11:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108150602.976232871@linuxfoundation.org>
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 8 Jan 2024 11:02:19 -0800
Message-ID: <CAOMdWSJei7UHccSGRcUD-A8uoKz-nGdpogVk5bOU6=3cHJ5s-w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.11-rc1.gz
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


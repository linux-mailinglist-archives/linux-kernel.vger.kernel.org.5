Return-Path: <linux-kernel+bounces-53028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74810849FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CB91C222FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772553C46F;
	Mon,  5 Feb 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePYJ5/Uh"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9F36123;
	Mon,  5 Feb 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151236; cv=none; b=ssK3oXfQ9fGZ7rqYq3LCmi3ld/8WgouylQ8lUzPCTRPX920r96S/QqS74sebZLmjquAvonWY3A8UbTnLdUJQIndV11jG6rKcdyXCT+x4lLaxAH1BJWLWSqWmxR+Qg3YPWBYPKp/RA/VDyTVFd+6MsYb50FF8DJJ5jlaW2BzZrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151236; c=relaxed/simple;
	bh=ary512A6BfTSJQxaZq8dpsFJkve0is15pesW2o9sbOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Riv9YNy7ltmDr2AFSY2g5rQp4LukcbbixS/HK12w8pvzggRPoDNGNFqp86VaGD15p0r8jFvqaoVFElhlfR+E1tV0JWGLNsDn6We1aJ5CstaIHfQleNU1CPL8Ox+V0X/KmXFvr4RYRKn6zeR30eTLsSct0MOl86800tH1EadDX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePYJ5/Uh; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2a78c49d1so1916177241.0;
        Mon, 05 Feb 2024 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151234; x=1707756034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0f/X+Bpl57XsTrknK+4uXaivkt+xwyCd4mmJCtIejiM=;
        b=ePYJ5/Uh+P13E1QEpHFk22ulYAYtW+tbiz1RFrBwxzfNbkyv6GPrOBvPZ0M308pKzt
         ZaQ4Ef/LYVTdNCPWwXBDj18XTO9NTTknd8+TdCPtgySSkZ7wXjisn1VJlIWXdNrN6AD2
         JOP1b7I01+NmNEupnLoDMk8HOFTzm9SCuKU7f6GKRqE1bGT0KomuUcFZaVGwMQOKNrar
         vs88VpS2qUuhJ70F2/HSTQ7Fv4BEsUba6rQ67ZOaRCcYVjUlitkBUtB7VryLmQuh+Tiu
         9DaOgCAMVR1vyRFuA7yMdLdNxsUDbLwWmPMxeAiJYPVw5VbfZMYKagWLCGqPHr3/R8Cf
         lIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151234; x=1707756034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0f/X+Bpl57XsTrknK+4uXaivkt+xwyCd4mmJCtIejiM=;
        b=w4sQRQElKM6kh+3k+IhWE+b8JWz3fgWRQMsZc7VGyHLbSEOf+fga+oy/xi1U6ZXsvJ
         nhGJtJne1uxG3E/D9SZAPhyBrvQt5igNL+q5s6iVyTTSx8tS6Ho3vSyDu+EKVLR8PKjZ
         L3pWF05Kqjpc93RTvoFCJKXz2tGuC9XycpuJrSJPZpDAKDAeoVy91YZddwDVV6RbdxlH
         xDBAcn+ySNzDX9hFI3ObBL2fbGHsR/UmP0uZCMtHMOoInX4VVoPCR80zoflOlaCeHB8d
         ZINlrqTASBlXgCBzbus0IhQH6zPffxsPCQaco+PcgexQXi8C3/nwRMmnICbBF52wCC7Q
         /6cw==
X-Gm-Message-State: AOJu0YxusIQlaG2c6GzSu8GFUU4+PzaDotaqr467iID5VKIcdv6AnpLr
	LlDYWTXsnXyFIu4DbMHnjSr90PZ5fZUJBKk/mWa2cpd5J/OsEJ8jLXMoSlFqIQ7fQgIqiTo0/Sf
	LIztzaJJhE+oB1CjC9NXLleLgkUk=
X-Google-Smtp-Source: AGHT+IHCWnn1ZmXqR/KTVDYIdL/mIfnCd2sufWbS3uvury9Hap2qV49xHkO5y9vmWqzP5fKSi+OO+EuP2cx8AkCmVmU=
X-Received: by 2002:a05:6102:50a6:b0:46d:2f69:c772 with SMTP id
 bl38-20020a05610250a600b0046d2f69c772mr236851vsb.11.1707151234080; Mon, 05
 Feb 2024 08:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174810.768708706@linuxfoundation.org>
In-Reply-To: <20240203174810.768708706@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 5 Feb 2024 08:40:22 -0800
Message-ID: <CAOMdWS+9caKLFejS3mmhg1p09PcRgMTBep5waxhjEv50TPrbbQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.16 release.
> There are 326 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc2.gz
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


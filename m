Return-Path: <linux-kernel+bounces-26445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CECF82E0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BFA1C2214B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D818E10;
	Mon, 15 Jan 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9+AkzJY"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8419477;
	Mon, 15 Jan 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d250629e25so84749241.1;
        Mon, 15 Jan 2024 11:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348081; x=1705952881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhSzSqpM4RD5lUwEkRLdlmlmzOc+rc60P8bLEmJ2fEE=;
        b=V9+AkzJYJJ9rlQ+mJE1qNVvUk7XuXFsOOAgAX/HiNFlOUiV+Ek4Dv/XNGlIknb+AJQ
         wIdLgSg/JpmPuBjLRbhytvsviK70RB8uG8IvVKOjXo1Epb4sYIeuegsN2zS3IRBshX89
         D1YKn6aTCxWlE56I2cbR3VP1DQqenkyUNUwgLUL2xN67kWRwcuunmBhFX7c3s5Is7GJS
         QhQbQZevbUGaPfKXvLtNqIucXoTv6PyoT2lMWZFMxCGcnQB6XegtAcLJXKw77zkVgE/x
         gfLEYPCqfuixakr1zVXkV3SuvZI/VZrbDEDGg1RydM6FtEHGb/6mR/z8AG5tyMQfxElM
         xajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348081; x=1705952881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhSzSqpM4RD5lUwEkRLdlmlmzOc+rc60P8bLEmJ2fEE=;
        b=JjxlV2kjfvLV93mHkWs1ua4JavCta+HhhpAFDS6tfCGOIZ9XL1iOmiWRSufrlKuc1E
         YnyccuMGZEGAwNQ2ZvP1QQQ6ln4C49CILjjPq+hAP/vxUdrEYeLpSbKN+yOd5S5TA9J5
         UAlaxRnO6FqQovCI/6/KsgOjXFDDTxJcLcUQClio1QcIQtE5YCBe4Ji1P2Jci51vPeWg
         XIKHKJOL8AhUTPtWDTcaqZddN03gxuRMO1XClrtBuaLKMdY8N0kYV5TIJahPg90s/SmF
         PcxKz2/TfUJkGQNWx83k4Yq/G6ruH7JhoZHi1l5hJOQ3uB1FXZcFfh8FxMpnCKQzDSiw
         wHcw==
X-Gm-Message-State: AOJu0YyJKvmPggFzaZ3B6wIov3wZw+VOLNpTm5s/5D1sntja8ayx4hor
	ydix5mlklitgZmbWZ6I7sAm67FOqSt36y8pUB5g=
X-Google-Smtp-Source: AGHT+IGgktmkY/M5xIKuehYQ1+S8h1tKJGay4wHBQL9/hhSxWWiM3b6eHLdMrGu4BkK+MZ4cFH175/FqXrWreNJNF9E=
X-Received: by 2002:a67:c786:0:b0:468:17fc:f4ae with SMTP id
 t6-20020a67c786000000b0046817fcf4aemr4170295vsk.6.1705348080161; Mon, 15 Jan
 2024 11:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094206.930684111@linuxfoundation.org>
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 15 Jan 2024 11:47:48 -0800
Message-ID: <CAOMdWSLA4SYN_HvJoAAgGdR_KSeeqc5Zyy-JiLcQyM9inPh3vQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/43] 5.10.208-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.10.208 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.208-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


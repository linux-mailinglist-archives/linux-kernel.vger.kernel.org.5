Return-Path: <linux-kernel+bounces-26441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE082E0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0111C220A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2A18E10;
	Mon, 15 Jan 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMhh/RnL"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E818E0A;
	Mon, 15 Jan 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7ce55932330so1502992241.0;
        Mon, 15 Jan 2024 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705347967; x=1705952767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JIbfkPiR6M/kmxy2zdTQeSRuTcxVNa/RonwKaeglhrM=;
        b=fMhh/RnLXHu/2bf4FgU7zzTgfVX6S/1wel1rybPltnMy/99WDDflfyW/e/ZId/9bRl
         M28JIdeGSDgb6Dr7Z4ByS1JzF6YVGoJLNflu/aOEueoPXrjcJepYaXJgoLh65HRGLWzu
         exLqaTPSTiDrDo3tfm4/xrb1QMDe7CyoTujsaGPNcMB8OCqBvHlB4WjbRETJtrNyfCDZ
         aIsKPeLBi15bcF5DwWpYAbwqGE+Jm7KQT/2lh15k09h1fUZtTOgWs2nIrh0WVDjuwsEe
         FuxfnofVNLzlxGsQBcSip5kMasaLKAMlG8sFxcBXGszKZOUflA67mc9UWfal7MotJvOU
         j8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705347967; x=1705952767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIbfkPiR6M/kmxy2zdTQeSRuTcxVNa/RonwKaeglhrM=;
        b=lsiqqicZ1uroea1otK7z6Cn6AgYuznKs+aTRr0a+XNPXkXMQ2+9Th95uS6ZCsd0pHh
         +KnzbwCfNQ+lwcYlFZKgHqOggAQ4iUEi4dg01N+nZb/Qg44mKnIqMvX9sjlte8070i9w
         fXdmKCSutcBC2EBrOPmRM6iZlyBE5MJX/x0BYERtfjM3lN9KMHxRA3qjomrTuxgD1exL
         wk2boLAVa4xOnOuvl3rnV0eSixKm2czCQKcWnQk9fic9st2ZM8ZRKNMgTjA2cdWUV0O5
         4/pn7ox409Madd2cpdPCvOcqBCsVKKC5mG+nld6b54VzA3ZKbpifkZfLYBPU+8UjmUZP
         HWUQ==
X-Gm-Message-State: AOJu0YzBnpVPHwwR8n11OUdrr1T98bRaJupv8TLKfg0ySw/xsnCCJtlY
	BWjygKc/pzMhjhrhCmDar1dqmDZDTWlniw5x/O0=
X-Google-Smtp-Source: AGHT+IHb/CMeHORAxtWRRGn6N6ab3r/Xv6z27ogqUBsIkqEjTTznz/OGBR8VGl4EHxuhi1bPGgPVvqr2Q7B/LJ6CMLY=
X-Received: by 2002:a67:c78b:0:b0:467:cb07:fd1 with SMTP id
 t11-20020a67c78b000000b00467cb070fd1mr2273871vsk.11.1705347967413; Mon, 15
 Jan 2024 11:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094204.275569789@linuxfoundation.org>
In-Reply-To: <20240113094204.275569789@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 15 Jan 2024 11:45:56 -0800
Message-ID: <CAOMdWSLBK0FsWn+4BmRxrE=FC=E212NcaA2jkhEekmP51iWThg@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/1] 6.6.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.12 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.12-rc1.gz
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


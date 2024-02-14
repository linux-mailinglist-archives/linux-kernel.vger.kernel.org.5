Return-Path: <linux-kernel+bounces-66121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA90855746
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA8828175B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3851419B4;
	Wed, 14 Feb 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETTwTVmR"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C21419A2;
	Wed, 14 Feb 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953345; cv=none; b=YragCjwRbrkJR1X13J3mhuEIa5hAi2Wz3AdaMVOnJeEXyO1b251HHZ0cx7Tqs7062qdBW6M9BhrhwwgEl1edB8Ub/cmwLQHni6gK4alZKEoEL7Z48d15gMmqnQNGpJd0IolPdi31tMU2kpNuph481G8APz+8WOIENwCLZpJU1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953345; c=relaxed/simple;
	bh=BEBtdBAQ82qgro7oQ40alHsa4IgeFXi1oEys5wUUXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEy/wDGMBHqFPop0N+E2rl/Hz6SwCdqUR2Nn5qvqTFnvY6ko4MmucUW0ScN3uvNPPMcMcDOZtWeWAcSYhBp8j6g0WSZbIAiHoGwaSZM0MwRnVaHdUuWuAf1ufCO/5ht9odCHO+Hoy1Y4K3zdFmQHNm2CE+z6duhh9ClDevq+GTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETTwTVmR; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b7fc7642fcso104826e0c.0;
        Wed, 14 Feb 2024 15:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707953343; x=1708558143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E83E1MDKa/f33TdondzwW5NbSuDEHrLaLNf31UAm4Rs=;
        b=ETTwTVmRcyMq7ab+xB2+ZatPC4NcaH67PZOmZflXnwedkFYKHLJl+Ime3Z3wEGtaBz
         de1+PIlwAFYwvdBR0UbkAC5ncD7P0+cJd97ueUusEXaq3IK4xVvFSCdUw/fWtUNvMjVl
         i2HGGWqG1MF3AGfScLFLxWstd18eg9e2lQJOd0IwPD4UsWpJRDGjejte2qKCHXjmsuVs
         WkagZakhcEuA2swDwfcMAnRuj4YlNdtQZj95BuvpfJUqyK3XowSD5g89s4iGvPnLpYP4
         HH0Vg1VfnVx8KsTu9SLiiIvoVptH8rEiWiPBdnec6NeW7Tst98JeIEX+14OVRmF/4+/n
         wAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707953343; x=1708558143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E83E1MDKa/f33TdondzwW5NbSuDEHrLaLNf31UAm4Rs=;
        b=sHkQK4ZTLIoEFoDRxESFdIFYRgfZc0jtikiBOOFcM4OgmTLWU4oOVxgN7gbl4hnW8i
         5X9wqCNPg/58Umbk0JUgNKhL9IAImK0pRAVIlfujO02z0RoWo8VdswtbwgPq9YcbXChM
         AQAnQojcDFqmPkbttrpRlmlVHTVseCcb4piCt6w7PCcyUGrXUVLtJbrih6RlPuUOSlsM
         9Nm46mv82Sdsw2WleBrihiMNLtyp2ZuVQKxzXxqfBdf/M424C2PdVbaqe9/EaCD9BBV8
         azJ2CpIcmw99yJuMW892le73Pnv26okaA7+jDMAyd18FAZSgiocOAwZRTL/Rx204Pz1/
         aMfg==
X-Forwarded-Encrypted: i=1; AJvYcCWYhmgv+b8+F6/mnsE7ExbVHJ9bX0EAz+uVQktJvrcp2TCzEBtVdr5UsmKHmEiCuVs9ve6ONVlxE9SIge2vJg5P4tZMqljGqLoDX6F2
X-Gm-Message-State: AOJu0Yy1W15riqNpRYg+3ygtEElZC6iVTon7QmwvzBVc8ZhFMCpJZxXd
	phNuf7dXfEHt0cxkj1xUpFAMQH5PV0UWDVZvAD43Q6jjNqU9HLFKQFcxBlAa+gEUsU2jhsWeDjQ
	SYAOlhYIZn8+DP23n2CZsamtE85E=
X-Google-Smtp-Source: AGHT+IHOq8H1GgxWOoqURhfY3+8v+bMEWaDhUgVAURIbQ63g3Y/IBAO/dIydTqstdJR3uqe0kAbNRcbuyd/FVBPIeXA=
X-Received: by 2002:a1f:c787:0:b0:4c0:292d:193d with SMTP id
 x129-20020a1fc787000000b004c0292d193dmr4350500vkf.12.1707953342994; Wed, 14
 Feb 2024 15:29:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214142244.209814342@linuxfoundation.org>
In-Reply-To: <20240214142244.209814342@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 14 Feb 2024 15:28:51 -0800
Message-ID: <CAOMdWSKVpgCzitkFCr6NjfmWq=SAfyMhfAOKzRw3hyVbA+riqw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:22:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc2.gz
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


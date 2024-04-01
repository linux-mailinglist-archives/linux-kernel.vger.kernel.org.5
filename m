Return-Path: <linux-kernel+bounces-126972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CFB89452A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9EC1C218A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F8851C33;
	Mon,  1 Apr 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5qtZlPH"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFB42056
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998249; cv=none; b=VBEzTIOzzIEqwMi0t5JLsH+/JsVFuffAfM+rsboxDlGKD17pyKbEoETj1/cMjP+EnLGY/rJn5hSKeohO2XZj+Bu6LWhLuWjt1JJS+2mg9yy6mAa9kB32MScb07uVnl/Vzgm/YADBFbpo0fBeC3isLf+7pA2/bebqnQfZ3g6TB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998249; c=relaxed/simple;
	bh=7YFzwRTLlPh301ibtaPdumqzzLLM37WL5MqJHvPd2iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gk5ZAfFHtEHAR3MCcM1yI0y8M1C6LJ/pEIP/N+no1C7Sy5XkY3cZcnvbR1uKKp0nYPag9ZxyWNElmwGjN6LCJYlWlpF+wA/LuObHeNpuMOrKtLqzCQSTKK2nWKPq+IXhlAknbKxT4OWHgDk/aBiKLRWLRVgG8VSox4KAz5F5OZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5qtZlPH; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e67d42422aso2831959a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711998247; x=1712603047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yYvO3v5OtgUEtXlnG8GDoLjAfRWwq7ns796AeG3oL58=;
        b=O5qtZlPHOp4AmQ5Y2htq66war88e8OgBqeZOfLNrtdgfKOMqCgUhT2qilNVD9nyunu
         JkIm3BRQJocPasSLG2OAHC22SAHlI15qzi9nSJuQ5PAQ89rKLp3Nh6yPhAOG9zFYIuty
         g18GAQ7XyE+i5U7VyDj4EmOktv7JFe8c4yG+wK5086JnRbWUno94dFais2kY34j7+PWo
         ZDMb2f1t19bOhzCfuYLO8TWqfgvq4LFnDp6NsyAAslmhJZysGchAnwJaVMGj26bZXCBn
         59mQIRszhatCHWvuwPMe3OT56KZMcf4Gyv2anzZNRwL8S64qnJkU626Xd+SbmBeZgRSe
         gprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998247; x=1712603047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYvO3v5OtgUEtXlnG8GDoLjAfRWwq7ns796AeG3oL58=;
        b=vsdkSuFjijIjMlojr4OzdADTEJGIpImxeV8AP/LSCdnmdOJ3uK2IWus/AAp4GIg8l8
         pSwSM1uhaIUgxz194LGVbRoXq6WjmkXg0wUSRg4QM2aY5oNiyB73WmwpzLLYMkx6nxie
         P+s2qClgspeI2Uvhhic0/BsVYuFZ22D0LQwI0qTdRZ/Ygt7VJPK5qP+cKtRpPxmDnoEz
         talexkkxAS/pGXOOg8LdAC8TZzOemPraPJ8IfUQySbyg0go48XXlqJaCXx/qVoiXqzf3
         0OvT1UUzFouee1S1USCj8Kbe6KzyANxsGJgJAefwlafqxtNLmQgwbCb7IlOSV4eYOqc+
         xHgA==
X-Forwarded-Encrypted: i=1; AJvYcCU3RfaOrRnsBVV66/YCdM7kSqqS+2nzLFSHbmT57IgSyFr3NzQr5HoOjUmU1jdcf6flLl57CqQ59tc8a0QCSs8P2ZzkyOMzp4WQa6L8
X-Gm-Message-State: AOJu0Yzd4bQddHlHblAhHN2QbhOjIeEk3NrOGGkPl/2+b9HnGEQt532t
	HqB9c6NEsqIyyGpwDLiAaoyZCXQ4a70GZqb0OBFGBjgDj9zDehgqbYvlx8cWmR4T21nzu6BYT5N
	UheyO0/DolE8UwKMhrICczPtD3Wk2vcHoIx/tCQ==
X-Google-Smtp-Source: AGHT+IFZnjA9wbTE9xX1zGLihZXyUphLjo+EmppgipT7ou4wJ7gElQqC1DGtC8501AbmNk8APlrrdsleR3G66uawajg=
X-Received: by 2002:a05:6808:2114:b0:3c4:ea03:81b with SMTP id
 r20-20020a056808211400b003c4ea03081bmr4330021oiw.2.1711998246673; Mon, 01 Apr
 2024 12:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152549.131030308@linuxfoundation.org>
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 00:33:55 +0530
Message-ID: <CA+G9fYs5MZaPV+tTukfUbJtdztQMExfixo=ZwbBr1A6Oga+OLQ@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 21:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following kernel warnings have been noticed on qemu-x86_64 while running LTP
cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
6.8.3-rc1.

We have started bi-secting this issue.
Always reproduced.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
------------[ cut here ]------------
[   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
sg_remove_sfp_usercontext+0x145/0x150
[   36.609445] Modules linked in:
[   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
[   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   36.612872] Workqueue: events sg_remove_sfp_usercontext
[   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150

<trim>

[   36.621539] Call Trace:
[   36.621953]  <TASK>
[   36.622444]  ? show_regs+0x69/0x80
[   36.622819]  ? __warn+0x8d/0x150
[   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
[   36.623558]  ? report_bug+0x171/0x1a0
[   36.623881]  ? handle_bug+0x42/0x80
[   36.624070]  ? exc_invalid_op+0x1c/0x70
[   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
[   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
[   36.625408]  process_one_work+0x141/0x300
[   36.625769]  worker_thread+0x2f6/0x430
[   36.626073]  ? __pfx_worker_thread+0x10/0x10
[   36.626529]  kthread+0x105/0x140
[   36.626778]  ? __pfx_kthread+0x10/0x10
[   36.627059]  ret_from_fork+0x41/0x60
[   36.627441]  ? __pfx_kthread+0x10/0x10
[   36.627735]  ret_from_fork_asm+0x1b/0x30
[   36.628293]  </TASK>
[   36.628604] ---[ end trace 0000000000000000 ]---
ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked

Suspecting commit:
-----
scsi: sg: Avoid sg device teardown race
commit 27f58c04a8f438078583041468ec60597841284d upstream.

 + WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);

Steps to reproduce:
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2eVWFlAeOUepfeFVkrOXFYNNAqI/reproducer

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.23-397-g75a2533b74d0/testrun/23255318/suite/log-parser-test/tests/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2eVTitwVMagaiWhs5T2iKH390D5


--
Linaro LKFT
https://lkft.linaro.org


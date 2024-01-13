Return-Path: <linux-kernel+bounces-25287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFB82CCC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D03B2241E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A6121110;
	Sat, 13 Jan 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="JD2jHngr"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1917BDB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28be8ebcdc1so5105546a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1705151111; x=1705755911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVWV8K+dnjde8ezML8ji89qBWwS6fczbNmk79i42bNY=;
        b=JD2jHngrZEP+9WCPxwxHXNz/5U49z3QfxM1k5FA1NDK4fGAMhcamfAQLyRyk4p9Cg4
         EJzjjjVMaGH/6Re7DTTqN5JVrgjLAISVAmAMQGV3pPfNbpmbIqe+wGD5DVy/rhQCFHus
         sHnNLQdt39o3uGc1zqKwavodrGBUAhsol9wwILpyH8mLAs7SzGQ9MXM8G5psiZUo2jiW
         q4Ja+yFrjouxcMNjsFnZx+tWBVldd66JaRdG/aBEtq0bRCCXadR8erRxzAR/QlvoNgno
         c9s7ZKgMIY5I70U5Mv045wyTNaOl20Dg9wFSG99IjmfBSmPNwEYsxhy4q4Nn7TJxAeeJ
         9tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705151111; x=1705755911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVWV8K+dnjde8ezML8ji89qBWwS6fczbNmk79i42bNY=;
        b=cPgcYtDN7o1C4Jstj6RqC+8pBct3OTqGjIyeUYgGNx1fYwP5hN46VHmu2Kf6e9+wTU
         /0fsJKoOR27YVVQJyZwYO5VIbHYo+DoaHQ+F5pMtaLcNKOC+cfI7+Q/hz1+WBeah6XH2
         hh+JrYFackOUhU5zInv2ffJTuAfOL3j6zs93pOIvZOI7pxkWKddV689tU54gc/YQEh6M
         eqoldKkBu1+ror+gDshEk/SZABEO8L0vXNtAXjes8cTyH1IDM11pSdtMtXwrTEH929gJ
         exao05uXDHmgY+xLzWPnRgNRkjTivGZ/fdrRwAn34G8zswZkBGNDbZUQr9rxzEvcGdkc
         wlKg==
X-Gm-Message-State: AOJu0YxxURSE5Gq0kfBtZYlvtqQFBaefnmgLF1AkAapSeCQ/wwpm7FRG
	SxoOr6VNPrlcM+ikq/xSnyPeNdE8k/6VP0J//OXVxNYKyAzluQ==
X-Google-Smtp-Source: AGHT+IFfzaMt3kAshqB5gY9Yv2YAX/gQFYbf/6z/CSB06VZEWh9ZAzNRcb/hS+uXfH+mr0UYhZL0C7MdZiNjDrP2NrA=
X-Received: by 2002:a17:90a:3946:b0:28c:ae1:9965 with SMTP id
 n6-20020a17090a394600b0028c0ae19965mr1783552pjf.44.1705151111284; Sat, 13 Jan
 2024 05:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094204.275569789@linuxfoundation.org>
In-Reply-To: <20240113094204.275569789@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 13 Jan 2024 22:05:00 +0900
Message-ID: <CAKL4bV5T_a-GXi1KE0gj=2JQB_JmxnA1b2FuPMjxDy8jGND4hQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/1] 6.6.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Jan 13, 2024 at 7:02=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.12 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.12-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.12-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Sat Jan 13 21:45:47 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


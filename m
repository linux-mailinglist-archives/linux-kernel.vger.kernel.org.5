Return-Path: <linux-kernel+bounces-51320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89170848966
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DDA1F2439F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D613AE9;
	Sat,  3 Feb 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="g1zG+LoA"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D0134AE
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707001119; cv=none; b=cTUANNN356u8e3vOulHxuV9mDZadBSUml5/OVvm7wFVqG6X0WYbnAzQwM8I7XFv6UBDRmteNrcoS+ncT6sCSAARzAt1bydayiPU/YfuYJBFs9Ju0BjArsu8jXfZXY5QizYK0hYJ7Qrail7rPapxSR9uVSrVG2vpDMuXxoLHEcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707001119; c=relaxed/simple;
	bh=9XCEwNXOtd3gfH5JnXX1Mn8plFmt8A7TjyEul2rhlno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYFjI2E80cCE9ZgwmtYp/f0PhpArmZxNcbFOvpLLiKCtc43qS0YCrIdRBz1Gaa7nzKkwsL5l5NXK6gT5MnMY+Zvl1al1BaZ+53cI3ZrkdMK9dQ01w660SvUoA4BL3rhuGpPdMfbNX3PmWS5SCZSD7ueHLCn6h5fr1Xw3gy5O8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=g1zG+LoA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29080973530so2663720a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 14:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1707001116; x=1707605916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzRLggOhgGcyJP2PFv5GAw1K1ynDOSTnUjo1ML5xufE=;
        b=g1zG+LoA+n3NIlme6qiQwbthBJIMiCXGmjaZSlsimS6PQ3ab1X95lp6Dn1FrrT5Rva
         4SNhlxKGTnurs1la/wHFO3CfPxXGJ634T2pPzLqz+hw76y0N7ldpUqDLNlTtHFvJqK36
         TZaXezVCW1qeamwP3LlyL1nKCBEUIOdL6hYXYF3k4PhUaQHaQNfxZZ8ZlDRl3ITOYmbv
         U54+a4DBTCRtDTMokC+43b5mh4oalnRBGKWxOoHc23XraTUFtgsTgwu/wL0GPSBFqU3R
         zykFzDcj91U3dliIODLtAyHA5fudZCjsju9sC8hq0iwtifOAqho/4zXx20MkZZ4JgJNX
         jsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707001116; x=1707605916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzRLggOhgGcyJP2PFv5GAw1K1ynDOSTnUjo1ML5xufE=;
        b=tBAg0+RlsxThfBaokOaOIniVENVl7YAgFvU8FkBfFQNPAfU90GcjpuYnBD0ZfX1MZV
         Za8Rs84U/TSSvGiX/2fFwJ0wQmDhz+swZIufiiYDANz9XNHZOYJvQAHaJ/d38NQ8eeCG
         vk9AhWz8rfuIgGlVlX4psc5oStdtfrJFsNV9j0QXskxOuO3wGSJ6r3TnEAPR3DVfHuMN
         iPh4H+ccm+h5FeOQDEbmu6bBWxRVuQg7Z07t/7NWZ2RVGiEAlN2XOi6c5egdLNlp5oPH
         2JOp6s00y30duoJ9zcrswta9Re7ymofQ7rIqXh/XZvpN6myKxWOXcayI+wmPMaTELWe4
         iqdg==
X-Gm-Message-State: AOJu0Yxv6RDjQW8DQ0rtr8NmdZ7bFuiqaRHkb1DqXV4gX4FXD9Y3EWny
	s8rEScdrv2h1WAGtm/wEwZA/khxZ+eBV2xNcczuJQPkbGXwm0DYYhe56SxCVP2Ni+Xmm6AzJqjA
	l4RTUR6zh3CgXx75XuytcSEy9dhZUZPwsWTxRuA==
X-Google-Smtp-Source: AGHT+IHWWixaZzUEfvpK6e39qOuHLzQpqN8E7hRV7h68UZHwCnqjdYRWOopQDCpbqGA2fe+IlNtUWZ8LSX2Bstq1xmc=
X-Received: by 2002:a17:90a:eb0f:b0:296:6eeb:ca2b with SMTP id
 j15-20020a17090aeb0f00b002966eebca2bmr1543366pjz.26.1707001116163; Sat, 03
 Feb 2024 14:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174810.768708706@linuxfoundation.org>
In-Reply-To: <20240203174810.768708706@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 4 Feb 2024 07:58:25 +0900
Message-ID: <CAKL4bV7e9d6Q7KXpWMrvRvMfD0EkthH4NKSg-LtrvgpWm5yvuw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
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

On Sun, Feb 4, 2024 at 2:53=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 326 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.16-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.16-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.16-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Sun Feb  4 05:25:23 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


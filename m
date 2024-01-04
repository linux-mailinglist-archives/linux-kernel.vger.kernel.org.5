Return-Path: <linux-kernel+bounces-16202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A701823A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF1AB2413C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000AA4432;
	Thu,  4 Jan 2024 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="d0w4vMVG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2D5221
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso20694a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1704335083; x=1704939883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB51INjXiZAvQxQW5xjKyr7zrTy19sHnvauwLTdnqrA=;
        b=d0w4vMVG08p1dV98jqDXPZUiqsyaQ8XfdwuS2/pKJR6lntQMOAlLOFIsanJDf8dXSd
         xodzRrwWJhqMuJUMgeSZaPylfcH/HVDDxCLY/tJtyRxNdi9g8/3cg8YhizoHeBaiaGE8
         OTLGhn1zct7aXb/d5BSsyVVZhmaeERhu+LRC7shEiCV+sdd0LWIhG3fgfEwkLZqVQr1w
         g21TBQdt0oHePuumDO+y+rKBZ8KsPaS2EniSmCCspZdyzWHOBPjbMf1mBtJQHYxAJAbL
         cC+Rdu7nTazIRkbD8GCTvs6JRsfIKiBNhbShl+9R/nFwPGV99sDqysuM6wwIdAovcGaK
         uSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335083; x=1704939883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB51INjXiZAvQxQW5xjKyr7zrTy19sHnvauwLTdnqrA=;
        b=t7/sDsiJCjkHDP+jZ/7FT7ZjRaflBRc6tswdDm0+Sozpz6qY9Qwor/NN0Eq7YCoAyM
         X6G4H33LVtwJ/qE7I6/mEEyUjYIRMsLCHGjx3kiuZ0pQ7qTTUCX5zZXi/wORht75tDFH
         dcw5n3B2gHWu1AetSbLU8sKDMt+8z6VzH/3Q7KDTPqlqUS/sTY4YJXGraaKnX6/fmLTw
         G3WBhu30oAaBxklWZBr40NNMI76VDJZ8OvxhPVu+DdG6dY/yw5Csf+S3st99ZS48O/Na
         WVoRE77tAII4LmK1SrJLvJpphhsOhtkrAADY7DjxmRgqFwsjcbNNa6pjuUjclVCkyYAL
         mKBQ==
X-Gm-Message-State: AOJu0YxFy9CzYl0PBROLCaI9eeDTXF3AMspPpuWmaP2+4GruYMY+klo7
	vRvYph3xl3usPO0Aki9hCBV0+FuYKiaVX3d+kwlY9GFoS2CrwQ==
X-Google-Smtp-Source: AGHT+IHwcnvw7WqGDCzzJmUK7XaNnwQlpCfti485n1GWpO3JJeg96VGxHxoTNad+Uelm7salPKt03E1s/Ox2oTQfsl4=
X-Received: by 2002:a17:90a:ad08:b0:28c:2614:2caa with SMTP id
 r8-20020a17090aad0800b0028c26142caamr12231pjq.17.1704335083230; Wed, 03 Jan
 2024 18:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164834.970234661@linuxfoundation.org>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 4 Jan 2024 11:24:32 +0900
Message-ID: <CAKL4bV7uOrnCVjKQp7rZ-KBtpV7sxpxHMc_6B0b3QiiHcrM+YA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
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

On Thu, Jan 4, 2024 at 2:13=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.10-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Thu Jan  4 11:03:04 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


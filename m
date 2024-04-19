Return-Path: <linux-kernel+bounces-151687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573288AB20A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D5028155D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79356131BD8;
	Fri, 19 Apr 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ7ySSWl"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859F1E893
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541006; cv=none; b=tSHPiqN7genz2sm6ROZuZL6KdSo10OZJeA3Irr7UlNEM2+U7PSulT216IaTq1zbeow8e/5jZmlm+brKLVxHa2vWVnZNfFwX0uBBGeA399E0hcmvXhU4N7mG7pnt9q6o4toQPYwwZvvxbBx+Rd7JR896ij0FJAHwhZ0c8nOHJn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541006; c=relaxed/simple;
	bh=lfG20oqzf+WgdkIHChtaZcLJdG8DTLeewCgNNyYkvEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5dEDiNA2L+9cVcrS/QSSpa2pVcHr7GFv1eh4c88bcmCegXXGOVj8yx8ac1FfNdTfWwS2DKlUi0pLHXqRvaD2UHzaXFg/Hk2qblcWfW7EBMR6T2CHWOcJEYBiKpWLZH6uAM3mlCP96ZsK5p8BWAb8ZiDRDBV3Bg+/Re3o6d1stQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJ7ySSWl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso1707156a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541005; x=1714145805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6e7j2WSWs9sC+Ur3lef8hum6RjzipP7Zn2prRaEpPs=;
        b=eJ7ySSWl56uVJ8wNhFnAEqvhpvDC8zK49EQHh+jQ0wdh5sZO4GHx+KcbeXf+Y2cFU3
         Ek9MfgxLV5iAVdNVrSPLOi/nxP28VJGVZmzdsaepU5tLfYRGIqzCqTxv4083PQBdL4by
         PlEypXCe/N7X1IZs1ceaLM7KXY7rado0Zxom9UUdP1DZUpw0QuZPjLKMCsCW2ZUWSXd/
         LeIHMzQ7GnaJU7LTjBPLMq9ah1lzJSiHgs41q1NDAG5bIrrSUk0t1Q9NCYxxdiYvzEfq
         dqCvalhxh5Dm1J0coU2q2lM6lyfjmqhOx6m6jcau/BBR9tlNsxpamFMqga4ymyrDjQd4
         7yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541005; x=1714145805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6e7j2WSWs9sC+Ur3lef8hum6RjzipP7Zn2prRaEpPs=;
        b=GdXK/zC94f/+LzBVYfdhPcw0g/QIzFbh2LOIBkvVQH8EfMyYRCcz+U9KgTHinukLoh
         csj1nZWTMxSWN4HUQwcOjgHsqf1u3IvxsXCz1tB6tgptY20VKQ6UlupTegoMdQN8PYQw
         8T4RaZzIHJ2GQudBkUr57Us/BF9FNz1dEKK9uPZ0pxo27TPYZWZI7a3o+aMqibmuHgGN
         f2FofuNEfirUdNL/2MrbiJC2zQfkQkGqfYHCQgWv35awyzlhjTNgpREn1TDARND0XEyP
         OVlEB67hQUcSe1iSEOEWP+fKpTREEfSNGwGFbZRCgOlPQ77EKyxG8j8vzPsUDIp08A+D
         nDHA==
X-Forwarded-Encrypted: i=1; AJvYcCXN7zZUPwskh9rgCzlY7n7a7qe76o/F0s1W4rk7kphhL3OvyHCMenN9esqoqUBdS4mXA4Tc1q+nO5JqmgOGaHKk6l4EFygLJMicPVHF
X-Gm-Message-State: AOJu0YzlynzT7x0Ro81oKaINMfqAOYMD8hTKfD4e92utUigINak3UPWT
	oEBrDi9v26QoF9Ru8I+cBZg/6hxtEaw5Jt3GxiWQo4jYFRu86t669s52sJWB7HLQtG+tayHoON/
	Y1JZVdsakY0W/MstCBD0vjD49mOM=
X-Google-Smtp-Source: AGHT+IHDtLS42hpyEP9uSJwLpq3epQxCgl+pjLxCfyMyr2PiLzXmGhsYXFFccicMl8yIiaaMiKpyNlk+AC+MFBmqn8c=
X-Received: by 2002:a17:90b:804:b0:2ab:87c3:d12c with SMTP id
 bk4-20020a17090b080400b002ab87c3d12cmr2546212pjb.2.1713541004691; Fri, 19 Apr
 2024 08:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419021847.16585-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240419021847.16585-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Apr 2024 11:36:32 -0400
Message-ID: <CADnq5_NnC2ziUe8wwXKpw1yQf9phx36Gb3hm0gRhURZNp0Mo+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate dcn32/dcn32_clk_mgr.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

And applied.  Thanks!

Alex

On Thu, Apr 18, 2024 at 10:37=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c: dcn32/dcn=
32_clk_mgr.h is included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8789
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> index 7eecb3403f74..d7bbb0891398 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> @@ -41,7 +41,6 @@
>  #include "dcn/dcn_3_2_0_offset.h"
>  #include "dcn/dcn_3_2_0_sh_mask.h"
>
> -#include "dcn32/dcn32_clk_mgr.h"
>  #include "dml/dcn32/dcn32_fpu.h"
>
>  #define DCN_BASE__INST0_SEG1                       0x000000C0
> --
> 2.20.1.7.g153144c
>


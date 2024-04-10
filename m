Return-Path: <linux-kernel+bounces-139017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8FC89FD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAC21C21839
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9609B17B51F;
	Wed, 10 Apr 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzFZmXX7"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33517B507;
	Wed, 10 Apr 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768135; cv=none; b=JhhPFtDeiZqi/0hnQbFYqz+T55orxV1Am5TE8gPF3YCNzGh34TUcndq5p1btC0ZVl7Y9r1MfbwBd8fOG+TVCV2hX7/feisoJWWuog5B7WpAgvc8nCQyhSiGHsUc79beF7/Lw9cH57w/QbOU/w9OT4wBTYa2Dcw3l8iW2WlFHIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768135; c=relaxed/simple;
	bh=9FGLAozPYT08B8QqzbTuZsQRhIqrVv2OVR0opnaqJZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YO4itairy+9RSEWMrBPITQQkXZHrNsiLrZGBtwl7yUvqEVXp6pspKLuYcXzFfYI03h/BUsUv5amAbm4Ria9VTQ2dVA217ag58/phMhX93UFxBwasb3/thneQrojRGRTAT5ozOElt5gyy+V/JWAkNUEZlHxdUAUNXuEhXj5JS/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzFZmXX7; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4daa2b076beso2098662e0c.1;
        Wed, 10 Apr 2024 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712768133; x=1713372933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mlhnPVBkd849gBpPLB7C+8g6xLIg9ro6ZK3Rrk9CvkI=;
        b=FzFZmXX7hO8t4EAXxtSk/uzJZYwI86BRg744IOujqlFRd0PG3h41DQV4At/P+YJ9bA
         4Ce1ef8mRZKdJS2S39UlMMQqDVneIZ5HoGttN6mBKAlIpPxABVA84JR37STm8mNWhrs7
         uZ7YBCnZC3b1oFsLQVGq/0/681Aa/QCFyNK4TvSdP7yeBRpMugBJ0jhk4SbMSkEfkZUN
         d4zW+0KhdTMxw4AmWQvitLxUmBzlK9BhLr/dH5M5oC4r48RxMkj4ke4dwovx5zas0NFp
         oDLj0fZnVILF5/by7bO3kVGW/2SrRc3Nwoo2HktpZHkvlY24OoMhw1IOeez+kmXOQOLo
         kTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768133; x=1713372933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlhnPVBkd849gBpPLB7C+8g6xLIg9ro6ZK3Rrk9CvkI=;
        b=BiY0dEn500Q6HaA8TtYq+9vkNKcGEPTc5AFcKCRl7eKHy2uqAUQulluWaLoOpsYq3s
         aqCnOuKbUa66iMwtL6rDnieqMoUbGQjDs932M3RsAIYebSH17fdW52aRT0bja49hZ0OV
         Rn8wj0lUVpad1V7ZOeX+VQeFql5GMskxAWULXcd4qHQDsAgnHy1M/nH8QIWHt05xyDsk
         SLS4hpM2NkdCVMXvMERwahhKVHy3slOx0gM9F7s+l2k/KjyxccXwxmwC0gnAkXejTLia
         R0t3dXzK6d6u9Ht0AL23JQEYVmUfU9RuOZIUROwjDuWnAfJOYg+PjcH34FSq4fhZ183X
         f2jw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Btb6PFMxD2aqEtFT+Bsp4mKuMi1oRieleCIEVYhnJ5o8m/P6kP96GMXzrqj2UGPWSMRhgC2ZbXz2pFsXlFpR4SgbuyK3KWM3jQWg
X-Gm-Message-State: AOJu0Yxg6U8IYdabe0/sd36aB+wPdSvHYFMTp/quD3CmShSMD1VBiFE4
	tpxYKRO4g4TmlG5BmlbeD5Orf2wfcFzKkJN02RUC6INai8G2r5G9zoKZ07YdcU2pzFuhwkcJsrc
	SEMvu4ME4ODZlMbh9hdA/XsNvTrY=
X-Google-Smtp-Source: AGHT+IF9pAel7nMAX3I9Rg1aEgBOzdta8G8E3m1sAmDZh3iIQ1Ev1SSmSrFgHdlnLugMYPfW11kKhWz88gCHEs7dau0=
X-Received: by 2002:a05:6122:8cc:b0:4da:a94e:269c with SMTP id
 12-20020a05612208cc00b004daa94e269cmr3401326vkg.16.1712768133288; Wed, 10 Apr
 2024 09:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173543.596615037@linuxfoundation.org>
In-Reply-To: <20240409173543.596615037@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 10 Apr 2024 09:55:21 -0700
Message-ID: <CAOMdWSLF=Xo=raUUfD27MZgTzpMZ==zp0D1fGfjGsfcP66=kcw@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/280] 6.8.5-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.8.5 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


Return-Path: <linux-kernel+bounces-65072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C7854778
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F188B24FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF518638;
	Wed, 14 Feb 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="IBfGFdZi"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD91B964
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907435; cv=none; b=T70PT0rKOeOzwY4yxdO0sgIKAnPg2Eo0YmpQYV4MilnfoZHFcPn/QvnTdgf6bdy+HAcpuv05GiVBWGDsnOhX1WlBT+lrUOKSVAt7rI5src7FCTQTBNePCBVQwQ5iu3GPrszlulYH3An3dzjV1/kfTzc31yGIbAWzrxfAGogdgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907435; c=relaxed/simple;
	bh=a8YEg1E55UuynaTEvvoea8h2L4h+1Nibf4RxcjpEfD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1pnczGUDGH0KRMkvZoyCkn09FnLLtqVnx21sxMrvHv+0xbVdyNYi/SUzdCC/hP9RnTAk8K2AP6wwvRRuJ3/FsJQgXRMqt9QEX6GcpM3C717DAKo51DIHhxshznDThLqKzsg9E3Imv/3rZOrTE6jSHEVV7/0H3LHo+hSbHyjgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=IBfGFdZi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d11c55d7f2so3758891fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1707907432; x=1708512232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R58F2rwTQFTBG9lBUJ+1oSCw6gGEYpe2zfusW2rUTHA=;
        b=IBfGFdZiAPnF88VE+oPUaoBqA3pvA6hlchzPNy4C6vJ4DLmS3aNIIWIKKr5+skgw1p
         V81JBg4PvHAoC7nPtuWZ9x4XbCZN0/eI9eDkSn/AL6gUyPr95gxA7viWw5d/B0Gcjqzo
         WJbJW+oj8uQ2BBCagIMyCmNMN3G4ae/LTvKNaH7V8q7raUosxleSuH4VvlrB43kXi4FS
         ciZgspVOloQd2pwvI0NqFDM8+ojYVER1Xy4EyleT8t9HUFrMFbYHZUeeUJ+Bz07QPbCV
         Pv1tLBWPijl4L2PsyREP8lb7V5/f5oITvCNro8oxJwLfwXvmfC5se2nJoDOTDc4D0HQj
         XWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707907432; x=1708512232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R58F2rwTQFTBG9lBUJ+1oSCw6gGEYpe2zfusW2rUTHA=;
        b=rIJjqAP5XfJcxIHWKDm2APE91ePbWo80ahhfzyxGLH7oAlokcDfl4dsOZ5CwA/rxpK
         bMDOkKIZYlsivNwq6mqPVFJCcsK5U8IsdJxEIurHHhWW6BOupa8WvxAUUwzYa9KZyDwz
         Z2xVGzDehwoEGxXkdr9E+v8DnR4Z5BNGLB3Q0e2iWxomNzuSWgXf63kR4jMX9d76YmBB
         15g0AHzWz8yw9q8g7vfV7axtJo9nyBXnwcqjOPQ/RC6UNx+wxJwPBg6fVEb6UExK0YO7
         k/mP9Xdoz/+oVOZeEO9U4j3aL6hKgy0fZsG4EInGOMMOOgIeOucVm/hkQfv5J+h4pFIv
         K+UA==
X-Forwarded-Encrypted: i=1; AJvYcCVThJ+z5zpwOKE0LlIZwkzBd+CzQZCZrza/6rEBMTIkBSobtj2kSx3fnHuJhXqTuIfy7qqrjanvRp7I3hjKtwihgXAalGUR3RlY/7BV
X-Gm-Message-State: AOJu0YyIBICPErIaWkST/OIPH8Yr4romcG8YlQDl88/IkHuDKJfbsAL+
	J5VH3Oq8mXdTnqZ21Ll74vLn3mT5eVRXD0rbWyVgF2R1ON/HsDwAEgFC2YL+YKzcLzlEjh5Mx/v
	MDMcFpdMW+U1XM/GUgepGBLQeDWilaOFqN4BSAg==
X-Google-Smtp-Source: AGHT+IHQZnUwzBf0N85Ucz7ROvmIBymqrgYpKyTIfawNtwOmMMJ5P+XT7mwQx8Qm/x33GUgxEAZN4qv2PSdXBiI07ak=
X-Received: by 2002:a2e:a4ae:0:b0:2d0:b758:93a5 with SMTP id
 g14-20020a2ea4ae000000b002d0b75893a5mr1554451ljm.18.1707907431744; Wed, 14
 Feb 2024 02:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213171852.948844634@linuxfoundation.org>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 14 Feb 2024 19:43:40 +0900
Message-ID: <CAKL4bV4HnafwMHihUmGJdjM5koNiLPHPuDhFC=c6SzF=Ns2J8g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
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

On Wed, Feb 14, 2024 at 2:27=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.17-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.17-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Feb 14 18:48:07 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


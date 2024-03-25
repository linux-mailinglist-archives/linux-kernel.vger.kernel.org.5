Return-Path: <linux-kernel+bounces-116627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209E88A171
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174321F37BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BC14D2BF;
	Mon, 25 Mar 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vz9d9D50"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4B18AFD4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354637; cv=none; b=gFcmPgl2sjZbtG+a3AL5smcSbWPSjQpxJB8nt4aTpjjWFaie+1sz1l+L9cKLUyBpIwmBxF7eC+QIjv4L9n1X/oehUlwXfjNy5TeWduRkQ08r8C8a09IJ3FejpK7erjy3F6v+NVIIk6VsjNHaU26MuIZWgpPYkQCbJFHznM0z1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354637; c=relaxed/simple;
	bh=Cdc2lgu11HCTc3NOvQt4Wx11RtkZGRvsRmErAIMTOtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BspLGAZ1Xpj0FU8MNef8TrGRXft7SwcqBapV/T73CwOOZx4A1qLduhn6O2lHlZKzk+kXf+OgWz7Y7cKciZkQcN935n3+ApybHDG5LhHwyeOg/BSbxmRVqTsgkKCMVwXAebeEjBySWYF9gmEo35MV/KOVG3gAYCEtiefhiTkYTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vz9d9D50; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e101b8fed9so524226241.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711354634; x=1711959434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut2Z7NylC1ZjYh0t1gpTkNMYaB0PuQ5lzXOkX20arzk=;
        b=Vz9d9D509wJCjCcxF/b5OBrp4xTbEoTG3WTyVB32zgG2/i0AQPBnohnwSl7iN35geP
         CuoIPfk5XMKtw3xz3WwVdvusNrQtDzeGhGnWh4ps2/Azdw/wYwzHO/e8qO9sC16ciGbb
         BAmmldagosLTULCeEj06LCHyhVVVgZrLa+w298T6qyXCD2MVF4i3ocothKW1KpIM7MKu
         ZPaJNWkcchmR18ZzBQSJfGl4IXaqjxf2VY1xtx4Rh4QlX8baF13hoVziHesrEH+MHWBm
         tpW+qtxC35IwFIWw8qecthk75V5IWeh20tRBzEt64nvNmDKsLpkzHs/t/RNMCJL5B8aP
         mT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711354634; x=1711959434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut2Z7NylC1ZjYh0t1gpTkNMYaB0PuQ5lzXOkX20arzk=;
        b=BsIWLELM9uqEr7np3bYaLLriBDnOmGMw5rGtbiCcLatYccITfL5Vxonmi7QYsRoeUx
         o+kFKozjvu3TrQ+omXKuSA/RPdfCNZTgBux2t4IcTCdpsUhZOisdVg4FJDax95/qCAiT
         8IEvEmFpF49E3C8I4iZCpNVFHQQ1pfBjmbhpyn+ChSurDJDi8VxnqNQohRW4H0XmX2Bw
         XNiRgegODGJ14+h5S+7OCqqgYuq1v5BNT5ozc9QIHR8N+a3QUK/SRKszy+P4O6AxNmTl
         aohpzob4QAqI2JEQgRjL7ZsPfSHEey6IAdGUcSKJmwaTcNIEdvPdQBXMwj2Sv4NmK76K
         EfeA==
X-Gm-Message-State: AOJu0YyxO/toEO7jQsfNzrmmMl9dl6Y2z/jIJ8UUPHZvwvbxk/6jqVQ1
	gK9xr5l4yi0kTSw4/V94t/7hk/HpdDjDfkisE00zNEP+1R0v8Z4HYfgWTIV1m5ZtfF1fpiMeOGx
	6U9Y/XkwnBAoclLDYXcRF2vcRHWzDniuBDvHd7w==
X-Google-Smtp-Source: AGHT+IHY0fAqHGBuW15a+0qMrjktrDhlfxmxsDUXlC9QCdnmnXZsac9XicGScXZlK0/6xd6Eba/2rMRPS4c5hleF/5Y=
X-Received: by 2002:a05:6102:34ec:b0:476:de63:c6de with SMTP id
 bi12-20020a05610234ec00b00476de63c6demr4404256vsb.24.1711354634277; Mon, 25
 Mar 2024 01:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324234027.1354210-1-sashal@kernel.org>
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 13:47:02 +0530
Message-ID: <CA+G9fYu33d-SfUuHcyxJQZdPXARYjBVUaqbTBc+5k9HZYFjUqg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/238] 5.10.214-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	=?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 at 05:10, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.10.214 release.
> There are 238 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:40:23 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.10.y&id2=3Dv5.10.213
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

We're seeing regressions while building PowerPC with GCC 8 and 12 with
 ppc6xx_defconfig.

> Thomas Zimmermann (1):
>   arch/powerpc: Remove <linux/fb.h> from backlight code

-----8<-----
   /builds/linux/drivers/macintosh/via-pmu-backlight.c:22:20: error:
'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
      22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from /builds/linux/include/linux/kernel.h:15,
                    from /builds/linux/include/asm-generic/bug.h:20,
                    from /builds/linux/arch/powerpc/include/asm/bug.h:109,
                    from /builds/linux/include/linux/bug.h:5,
                    from /builds/linux/include/linux/thread_info.h:12,
                    from /builds/linux/arch/powerpc/include/asm/ptrace.h:26=
4,
                    from /builds/linux/drivers/macintosh/via-pmu-backlight.=
c:11:
----->8-----

Bisection points to:

   commit ee550f669e91c4cb0c884f38aa915497bc201585
   Author: Thomas Zimmermann <tzimmermann@suse.de>
   Date:   Wed Mar 6 13:28:20 2024 +0100
       arch/powerpc: Remove <linux/fb.h> from backlight code


Reverting that commit made the build pass again.

Reproducer:

   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12
--kconfig ppc6xx_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org


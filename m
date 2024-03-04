Return-Path: <linux-kernel+bounces-90761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82711870497
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E00286A89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4345BE6;
	Mon,  4 Mar 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWExFihy"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEDBE4C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564152; cv=none; b=c+0yU4hIRR+dpTHYqDE77Vv2nvhPxL3/tcYFiRrOEbZpApucwoA7kVgX/BoCJl7NMyAJS5LpbVSeey9j4HaBHzc+wEntGWH1DS551V+IV1IDGyAuNJit1+dRkwziNAEJbwcj9qkaKrLPaYmfYcctP9A3i+rhgxMcsfvMJW3plFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564152; c=relaxed/simple;
	bh=em9YUjFkpzeno/gvQM325mN/Zt68LM+X3qfM17oePbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhpQEwaTO36uf7S0b95xugKIf10seY4ENsshUeypgONz8DyVcTowOOMCqwEEsr0F/K7/XbQcaTyC51i9k4j87+Gorb2JEmkTIWWcw9avGjP0JBzntfiCbxBQs3dEjPlfDy3C2wNnA7QKjvSTRiPQtLV8BuiSnXQaGi0rWn/Oejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yWExFihy; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7db26980225so715934241.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709564149; x=1710168949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AWTkZgsoLpPKdOGgcn1hzOrRfxw8EPkwi9BIWs11TSI=;
        b=yWExFihyoc93KBaHOuofUoWwWQaah7fGF/nim+U2eB7kKKNvp4cleKrVHiCZZRYSy2
         X3/75o9Hft/DNBEXAbkViqFUgdu5kAGrwVpbmSn3Jg7p6Jb2b9A/dHJfE2Dfnh7jTkVI
         ukdBgfYvDqUQlVhGatTYjQnd5RRk4HX6Q7vVVKU2DcBBXyI5QUhuOQsGsCF3FQm2ooId
         QSBVJ08lVxvr0a8Jo3RNSeE88D/AFfUMSjZ4BQLsCm8K7/0GE8LKKFzZ+lTMBfmRJLRN
         S/MTDkdj93qp5jeRPTWpGMfTcSfDN170kqYKbJXL+e4JLVw+xGk+hGVZEOTASgswfzLv
         jm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564149; x=1710168949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWTkZgsoLpPKdOGgcn1hzOrRfxw8EPkwi9BIWs11TSI=;
        b=RZLOYxwPUE+LaPffpXMK45Xdltja0Sg6pZxLWcpSe6g895j3O3Jhw+Ppp1mYFBlZgS
         bSsl+ivPXzetSBgQefS7EuhcJuJU8/KBJDd8rHa5T3IKtnSAx+gjFMcVbqbDczuHI6kh
         RUUrIskObAlw6Ofx95buVGx22DSryPT3s7jJuX1awbqYu5S6jCFsUdTkhadTP/dRbadC
         v09Fj2WDbxt9g8EP8m18kcpwAH7TjBbUMnEhz9c2eJEsn9xW6sxLoEOLUELdY67toGsu
         KGloZJwoPxQk6cJJrORp9qPVAvpe8l8jwGrFva4yXBQTo+Ou+McbfOdbfsyeMbx+rYa7
         xz3g==
X-Forwarded-Encrypted: i=1; AJvYcCXtN34Msqq6/k7/HFd8cnkDst08qKAu7h30SbBNfvnIPNZv4I5BUk/lP7jnyQ3GC+VESR/4p+fY6c5+ZjboK8t5pugEFPcTlb5yqrxH
X-Gm-Message-State: AOJu0YzzLDOu0Zs6kiID94NflTgmVp/paY0Mj3KYoDdxl33xVFtawb0R
	rS7+C9qf12bA0oXF7xNMgNK2iXCGXW2oiUTEyiyIVFezHqhfd6GhzjKokxzspwgc0y70fN8uQKd
	2ZaE+KN78kYq4b7LhXmSP2yrDNUvjeC8ikI4TV5aGqL1mpkKhpLE=
X-Google-Smtp-Source: AGHT+IG934W8fniwCAisOtWNbw/y515juXyLVnR2Fiu+gO0N2Ek8hxZbk2Rv0Vp8Lo6V1b7KKlvuokOu6sTWZN3xv2A=
X-Received: by 2002:a05:6102:2927:b0:472:d517:24cf with SMTP id
 cz39-20020a056102292700b00472d51724cfmr879625vsb.15.1709564149443; Mon, 04
 Mar 2024 06:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
 <20240304095512.742348-1-jani.nikula@intel.com> <87bk7u5n9h.fsf@intel.com>
In-Reply-To: <87bk7u5n9h.fsf@intel.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Mar 2024 20:25:38 +0530
Message-ID: <CA+G9fYtQobCEno5oRgqPzhHrjff4zMki=9fWwJ1NPtKeKQ+aUg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
To: Jani Nikula <jani.nikula@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jani and Benjamin,

On Mon, 4 Mar 2024 at 15:31, Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Mon, 04 Mar 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> > Removal of the backlight include from fb.h uncovered an implicit
> > dependency in powerpc asm/backlight.h. Add the explicit include.
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Closes: https://lore.kernel.org/r/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com
> > Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >
> > ---
> >
> > Not even compile tested!
>
> Naresh, please try this patch!

Thanks for the proposed fix patch.

Steps to reproduce:

# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig ppc6xx_defconfig --kconfig-add CONFIG_PMAC_BACKLIGHT=y
config debugkernel dtbs kernel modules xipkernel

# Applying patch set
Applying: fbdev/chipsfb: Include <linux/backlight.h>

The reported build regression is fixed but build failed with below errors.

My two cents,

I should have copied the full build error log in the morning.

Few more build errors on powerpc builds,
------------------
drivers/macintosh/via-pmu-backlight.c: In function
'__pmu_backlight_update_status':
drivers/macintosh/via-pmu-backlight.c:74:21: error: implicit
declaration of function 'backlight_get_brightness'; did you mean
'pmu_backlight_get_level_brightness'?
[-Werror=implicit-function-declaration]
   74 |         int level = backlight_get_brightness(bd);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
      |                     pmu_backlight_get_level_brightness
drivers/macintosh/via-pmu-backlight.c: At top level:
drivers/macintosh/via-pmu-backlight.c:108:21: error: variable
'pmu_backlight_data' has initializer but incomplete type
  108 | static const struct backlight_ops pmu_backlight_data = {
      |                     ^~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:109:10: error: 'const struct
backlight_ops' has no member named 'update_status'
  109 |         .update_status  = pmu_backlight_update_status,
      |          ^~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:109:27: warning: excess elements
in struct initializer
  109 |         .update_status  = pmu_backlight_update_status,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:109:27: note: (near
initialization for 'pmu_backlight_data')
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_init':
drivers/macintosh/via-pmu-backlight.c:136:37: error: storage size of
'props' isn't known
  136 |         struct backlight_properties props;
      |                                     ^~~~~
drivers/macintosh/via-pmu-backlight.c:154:34: error: invalid
application of 'sizeof' to incomplete type 'struct
backlight_properties'
  154 |         memset(&props, 0, sizeof(struct backlight_properties));
      |                                  ^~~~~~
drivers/macintosh/via-pmu-backlight.c:155:22: error:
'BACKLIGHT_PLATFORM' undeclared (first use in this function)
  155 |         props.type = BACKLIGHT_PLATFORM;
      |                      ^~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:155:22: note: each undeclared
identifier is reported only once for each function it appears in
drivers/macintosh/via-pmu-backlight.c:157:14: error: implicit
declaration of function 'backlight_device_register'; did you mean
'root_device_register'? [-Werror=implicit-function-declaration]
  157 |         bd = backlight_device_register(name, NULL, NULL,
&pmu_backlight_data,
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~
      |              root_device_register
drivers/macintosh/via-pmu-backlight.c:166:19: error: invalid use of
undefined type 'struct backlight_device'
  166 |         level = bd->props.max_brightness;
      |                   ^~
drivers/macintosh/via-pmu-backlight.c:176:35: error: invalid use of
undefined type 'struct backlight_device'
  176 |                                 bd->props.max_brightness / 15);
      |                                   ^~
drivers/macintosh/via-pmu-backlight.c:179:11: error: invalid use of
undefined type 'struct backlight_device'
  179 |         bd->props.brightness = level;
      |           ^~
drivers/macintosh/via-pmu-backlight.c:180:11: error: invalid use of
undefined type 'struct backlight_device'
  180 |         bd->props.power = FB_BLANK_UNBLANK;
      |           ^~
drivers/macintosh/via-pmu-backlight.c:181:9: error: implicit
declaration of function 'backlight_update_status'; did you mean
'pmu_backlight_update_status'? [-Werror=implicit-function-declaration]
  181 |         backlight_update_status(bd);
      |         ^~~~~~~~~~~~~~~~~~~~~~~
      |         pmu_backlight_update_status
drivers/macintosh/via-pmu-backlight.c:136:37: warning: unused variable
'props' [-Wunused-variable]
  136 |         struct backlight_properties props;
      |                                     ^~~~~
drivers/macintosh/via-pmu-backlight.c: At top level:
drivers/macintosh/via-pmu-backlight.c:108:35: error: storage size of
'pmu_backlight_data' isn't known
  108 | static const struct backlight_ops pmu_backlight_data = {
      |                                   ^~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:108:35: error: storage size of
'pmu_backlight_data' isn't known
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244:
drivers/macintosh/via-pmu-backlight.o] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>



> Michael, if this is fine by you, ack to merge via the drm subsystem
> along with the regressing commit?
>
> BR,
> Jani.
>
> > ---
> >  arch/powerpc/include/asm/backlight.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/include/asm/backlight.h b/arch/powerpc/include/asm/backlight.h
> > index 1b5eab62ed04..275d5bb9aa04 100644
> > --- a/arch/powerpc/include/asm/backlight.h
> > +++ b/arch/powerpc/include/asm/backlight.h
> > @@ -10,6 +10,7 @@
> >  #define __ASM_POWERPC_BACKLIGHT_H
> >  #ifdef __KERNEL__
> >
> > +#include <linux/backlight.h>
> >  #include <linux/fb.h>
> >  #include <linux/mutex.h>
>
> --
> Jani Nikula, Intel

--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-kernel+bounces-6812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD3819DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2B1C2241F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D2321360;
	Wed, 20 Dec 2023 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svf6PlCL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADA21356
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5940ff752beso121319eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071422; x=1703676222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGSNWkw+c2ahRiQtvGQvOgHzADZ0JXbLjHdO1qBBAyk=;
        b=svf6PlCLWwM4g7ssg2G9aMKUTqsqB1HzMCAE5pPQLWAgkVhZeCwea/8zdxT0QVv7uY
         G7+MqmcufZWqDSY4LV0z0lDOTTvUU6B7NsFgVnwjeZSOqK4W2X0k86PvCF30rxk955CR
         C4uEuufe3lhGGt+z7hn17IGh/Y0fAsGEVi59Xe91PSXeuM4yu2QGYz4WbVcqf0s42jGs
         eZwkRz10gEoHZAHE9I5szSTeHd+4JKASTDTVcaX4sEifVVpzgHRrHbJY1w3kmVFCeHbI
         IUhq36IFOzgwk1Zg9UZE7TbxOjODCWKRYET8GF1VSF4sru8PD0k7z15Lmo3lDZK/rBPk
         96QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071422; x=1703676222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGSNWkw+c2ahRiQtvGQvOgHzADZ0JXbLjHdO1qBBAyk=;
        b=MRmEBGyWzCp1b8klJ6OfUDUXHc7fLVGaj0sF+s/O89Q1UEQHqLOJNWlfGDAYionCsG
         5qL4rhoItIcIqjfgscEg31ccbKq3wJXAD92Zrpi0MUGT3cxg57WNWbNAN8BSXTP/5t9t
         jKJ97m9znAxn5bERWJcmbFg569+g3Kf8cxv6pAHmL78AhZLyMu/G6PK17JooKf1NLoYt
         OFmwb8wabr3Y12xNXWJ9kVC2KCPOVhUVQs2k8j18hWkrB8CAbeanhgbAo9eeoyuz0QZ6
         mvQ4DvDMqcZKU2TmitEbt4LUKKaM8k8FgnwjXuY+FcRhAS+fEMk8938LUHBETFT+0x+h
         RpjQ==
X-Gm-Message-State: AOJu0Yxx3gD4CXUoItDZsa9xBjjuouxeNBg4dymhSXtTGr26LjcDuUQu
	SZhCedQRdXSpKpfyMWJtyP2Xo+a/Av5YhxgHuR4rfQ==
X-Google-Smtp-Source: AGHT+IE4kJPxysEjDN1T6CCZTzDaHjjNNxoNgmPKSPVKwrazuOl+5EB0conrXCT7ZIBnAiTtmITMDx/f6TOOwLRZDhs=
X-Received: by 2002:a05:6830:11a:b0:6d8:17d9:308a with SMTP id
 i26-20020a056830011a00b006d817d9308amr15625047otp.26.1703071421719; Wed, 20
 Dec 2023 03:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-lockdep_warning-v1-1-8137b2510ed5@bootlin.com>
In-Reply-To: <20231215-lockdep_warning-v1-1-8137b2510ed5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:23:30 +0100
Message-ID: <CACRpkdYVg47zfPgZFcPyXjTX-p_o-HFALBh1FaDOgmDaomypew@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91-pio4: use dedicated lock class for IRQ
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:35=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:

> Trying to suspend to RAM on SAMA5D27 EVK leads to the following lockdep
> warning:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  6.7.0-rc5-wt+ #532 Not tainted
>  --------------------------------------------
>  sh/92 is trying to acquire lock:
>  c3cf306c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe=
8/0x100
>
>  but task is already holding lock:
>  c3d7c46c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe=
8/0x100
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&irq_desc_lock_class);
>    lock(&irq_desc_lock_class);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  6 locks held by sh/92:
>   #0: c3aa0258 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0xd8/0x178
>   #1: c4c2df44 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x138/=
0x284
>   #2: c32684a0 (kn->active){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x148/=
0x284
>   #3: c232b6d4 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend+0x13=
c/0x4e8
>   #4: c387b088 (&dev->mutex){....}-{3:3}, at: __device_suspend+0x1e8/0x91=
c
>   #5: c3d7c46c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_loc=
k+0xe8/0x100
>
>  stack backtrace:
>  CPU: 0 PID: 92 Comm: sh Not tainted 6.7.0-rc5-wt+ #532
>  Hardware name: Atmel SAMA5
>   unwind_backtrace from show_stack+0x18/0x1c
>   show_stack from dump_stack_lvl+0x34/0x48
>   dump_stack_lvl from __lock_acquire+0x19ec/0x3a0c
>   __lock_acquire from lock_acquire.part.0+0x124/0x2d0
>   lock_acquire.part.0 from _raw_spin_lock_irqsave+0x5c/0x78
>   _raw_spin_lock_irqsave from __irq_get_desc_lock+0xe8/0x100
>   __irq_get_desc_lock from irq_set_irq_wake+0xa8/0x204
>   irq_set_irq_wake from atmel_gpio_irq_set_wake+0x58/0xb4
>   atmel_gpio_irq_set_wake from irq_set_irq_wake+0x100/0x204
>   irq_set_irq_wake from gpio_keys_suspend+0xec/0x2b8
>   gpio_keys_suspend from dpm_run_callback+0xe4/0x248
>   dpm_run_callback from __device_suspend+0x234/0x91c
>   __device_suspend from dpm_suspend+0x224/0x43c
>   dpm_suspend from dpm_suspend_start+0x9c/0xa8
>   dpm_suspend_start from suspend_devices_and_enter+0x1e0/0xa84
>   suspend_devices_and_enter from pm_suspend+0x460/0x4e8
>   pm_suspend from state_store+0x78/0xe4
>   state_store from kernfs_fop_write_iter+0x1a0/0x284
>   kernfs_fop_write_iter from vfs_write+0x38c/0x6f4
>   vfs_write from ksys_write+0xd8/0x178
>   ksys_write from ret_fast_syscall+0x0/0x1c
>  Exception stack(0xc52b3fa8 to 0xc52b3ff0)
>  3fa0:                   00000004 005a0ae8 00000001 005a0ae8 00000004 000=
00001
>  3fc0: 00000004 005a0ae8 00000001 00000004 00000004 b6c616c0 00000020 005=
9d190
>  3fe0: 00000004 b6c61678 aec5a041 aebf1a26
>
> This warning is raised because pinctrl-at91-pio4 uses chained IRQ. Whenev=
er
> a wake up source configures an IRQ through irq_set_irq_wake, it will
> lock the corresponding IRQ desc, and then call irq_set_irq_wake on "paren=
t"
> IRQ which will do the same on its own IRQ desc, but since those two locks
> share the same class, lockdep reports this as an issue.
>
> Fix lockdep false positive by setting a different class for parent and
> children IRQ
>
> Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller=
")
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

This is a serious bug, what do the PIO4 maintainers say?

Yours,
Linus Walleij


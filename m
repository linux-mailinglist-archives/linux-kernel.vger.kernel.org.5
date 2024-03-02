Return-Path: <linux-kernel+bounces-89479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B686F0E4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DA71F21E96
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C67618C08;
	Sat,  2 Mar 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMOfG5Rp"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906C29AB;
	Sat,  2 Mar 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394126; cv=none; b=Pb2f2krbY72tT/e0MKye6xQ9Gg4iHN/JVbMHnaekr2tOiOedVX5/nTTzb3uSVl6a7Y3x77Iv8IGxx+/3t+XQm4kfjUGjW+eOpA8zVFqughy59aW4+uDqzHru/KVUYhR2WJK5aolaZ2lu2SIOI8Ir9CB4E+u13pHUZMfdsp7DNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394126; c=relaxed/simple;
	bh=Vg0+NRsFIWYNeq3/Y14CGJlm6ANmz7j0y8mB3zB10Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlpAJKOhFlIgjgvBwbrOwIuT5K9JTdzmqHL9sI0GeV9fNjzKtin1yLfLSNC2644tia2ixIQN6tVDEuOVrUBzdjaVejtJvuRiL5HXzZoX9Q8w/PqxuyoKxm3IioTFDk5FrshQrHw5/HkBp9esniTT+zG9HCr55vYTNhjdAdi5HVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMOfG5Rp; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21f0c82e97fso1795330fac.2;
        Sat, 02 Mar 2024 07:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709394124; x=1709998924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LzCpnhGEH0mn0/NF9dJmvWd3SERdejuejaFsItX1rnU=;
        b=PMOfG5Rp5UdE9iAyhD5r6i8yUGolV8HGUOAJcJULQAKW4bzZf4XYQNU9PTnmb6tVjW
         NNL7iyubKKL5pJRXrxBMTcqi590u3Ymad5DvV1xo+7fl1/2mfphdaR/GamNqqEe6jeCD
         MzBXpiqG9TYdAYzqvkkxczH4fJrIfPmFnE6izU6JhVU6hxNRlLRXakz4Y5uD3K2tkR4K
         DiT4JUPUsOmxXZCAgI+2z2/BhLBb2Ej6rRXcuIoH06/S6eQI6rScS6mMxrxvX+5ZxZKg
         D7PIjKCbMqYt2ukaB20KtV4n0MaH016At/Zb0U3nztXjusKfZsz3PvphF5KKylMmqD2s
         HlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394124; x=1709998924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzCpnhGEH0mn0/NF9dJmvWd3SERdejuejaFsItX1rnU=;
        b=QRzUd+Pix/JhPBNmQS+HVdWAOJ1T0JtxRWmSMN08u0RyOm0NI5CC3b7uifKAmqbvPj
         lZFPdK5w88xBrwTjXzxsirV+/tOnCTblPp7EvVCAO7McY/Tof9Vli6/UUN9cKVWSC56d
         cLiM2nJDwEhDGWP+pyoWFKzj9qD+tLaVochPOA+PLtqzydBRINM2FPVOSs6R4UEyXEkz
         HWnGe2CwQx8zlyiwwg3euJCty6CJF3Jx0u9KBTfTFoAPvZeLTLqtdUNrwIkYv1ecvIRn
         SSAL5uaSqszzhzBMF9Z9+1b6alqdEKu1Ei+y46dtH23HOjFC5jnsOFf3aYZq1FrrQiEO
         WX2g==
X-Forwarded-Encrypted: i=1; AJvYcCWcxXHaZ0PJb9G+A+I877Vg1g4INmgudqt4m/Q0EAwAMQazy2m3n35tGnKDQp9z1jRttcS9IUUxWLYOTNI7LRij/s8IbHb+jStSwThj4mNhpHmixYk6smY5dXtaErwF5nHKV4WiGQRRDAMZP+7AdoZRmZ68SehF1DbV4L8bnuF+kv0OkvyHFvbzjqg=
X-Gm-Message-State: AOJu0YxNtFBnI35GvVzOHD957EI/qjSJFvmsYjobZJgCURuHiOK1MmZt
	fiMHMC7oJMUvKtLwjNBzYOglhmCOAsEWspANrViQjWNIdS0y2jcybAxgxJb76cpuw7Hicze01vI
	H1uLvlb+ZEkrBFEOC/RX1hShqAA7Ys5s9
X-Google-Smtp-Source: AGHT+IFOyLUGj5njldof2Kjx3MpNztLCDh4BskGy5JZiPRXjanr3DeP4NYYaguyNpTzzI6L8Bn7MKpE4vNcxua4KW5g=
X-Received: by 2002:a05:6870:830d:b0:21e:5f83:e698 with SMTP id
 p13-20020a056870830d00b0021e5f83e698mr4957415oae.52.1709394124410; Sat, 02
 Mar 2024 07:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-3-linux.amoon@gmail.com>
 <f989a532-a77e-4324-902b-968b12134f15@rowland.harvard.edu>
In-Reply-To: <f989a532-a77e-4324-902b-968b12134f15@rowland.harvard.edu>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 2 Mar 2024 21:11:49 +0530
Message-ID: <CANAwSgT5cvfwQmv6SbMoKoNA1vHYEpbhvc+6rfaMr-36bHnLUQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] usb: ehci-exynos: Switch from CONFIG_PM guards to pm_ptr()
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alan,

On Sat, 2 Mar 2024 at 01:58, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Mar 02, 2024 at 01:08:09AM +0530, Anand Moon wrote:
> > Use the new PM macros for the suspend and resume functions to be
> > automatically dropped by the compiler when CONFIG_PM are disabled,
> > without having to use #ifdef guards. If CONFIG_PM unused,
> > they will simply be discarded by the compiler.
> >
> > Use RUNTIME_PM_OPS runtime macro for suspend/resume function.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/usb/host/ehci-exynos.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> > index 05aa3d9c2a3b..4676f45655cd 100644
> > --- a/drivers/usb/host/ehci-exynos.c
> > +++ b/drivers/usb/host/ehci-exynos.c
> > @@ -234,7 +234,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
> >       usb_put_hcd(hcd);
> >  }
> >
> > -#ifdef CONFIG_PM
> >  static int exynos_ehci_suspend(struct device *dev)
> >  {
> >       struct usb_hcd *hcd = dev_get_drvdata(dev);
> > @@ -268,14 +267,9 @@ static int exynos_ehci_resume(struct device *dev)
> >       ehci_resume(hcd, false);
> >       return 0;
> >  }
> > -#else
> > -#define exynos_ehci_suspend  NULL
> > -#define exynos_ehci_resume   NULL
> > -#endif
>
> Doesn't this now generate warnings about functions being defined but not
> used when you build with CONFIG_PM disabled?
>
Yes I have tried compile the kernel with disable CONFIG_PM=n and
CONFIG_PM_SLEEP=n
But it's getting selected  by default.

Also compiled with W=1 and found no warning with these patches.
To be safe I will add __maybe_unused to suspend / resume functions in
the next version.

diff --git a/arch/arm/configs/exynos_defconfig
b/arch/arm/configs/exynos_defconfig
index c98d5ff8a1ed..e96f5c3bf8c1 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -29,8 +29,10 @@ CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_PM_DEBUG=y
-CONFIG_PM_ADVANCED_DEBUG=y
+# CONFIG_PM_SLEEP is not set
+# CONFIG_PM is not set
+# CONFIG_PM_DEBUG is not set
+# CONFIG_PM_ADVANCED_DEBUG is not set
 CONFIG_ENERGY_MODEL=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y

> Alan Stern

Thanks

-Anand


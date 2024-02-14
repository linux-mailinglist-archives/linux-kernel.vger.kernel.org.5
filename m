Return-Path: <linux-kernel+bounces-65457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4F854D57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDC31F29A04
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BE5D91D;
	Wed, 14 Feb 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="3FN5jaXx"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A45D756
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925827; cv=none; b=ufBufW3DfedgteD1zNQOZoenAIIXHn47AkFeK2yGDgUfDEoKxkFEU8DbbLrMrqx5x51lHs8W2pDWjbbdaq44FkRjWH5kvHhHjPNjwMRCnRqAUV8gu2tZ/mkxkPwVgaVmUtVgvMFOwLCT9futWQUY41R/i00OEXVFlczErDhMj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925827; c=relaxed/simple;
	bh=3ixfx9hvHowkdPW052W2BTLyOZIPcGFLydpr9ppzU6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibWCN4fO7r2DIYQymLqDhRvGTd4eZQGKBoiINzAzluZQn5uIesSae6DAbqBtJNIuZo46/HITPkSI/GQuEwJUe4hZm4rtQHPnvjv1Nn47ypsNpON8JresgNV3iQktL/gqUDEAqw87O0MaPP4f8TwDKHeuZrOSRiZFIDpZFqDmLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=3FN5jaXx; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36426ae1c5eso3912785ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1707925825; x=1708530625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSlVGbEelZs1+mCJGuJE5TbiYr0MAiLjyMJwC22PtNU=;
        b=3FN5jaXxmOUuARuGbkAUOBRUrTUQBEbCJpSW6jE5Yor5+pG74A3QLo0dAodUMc4VnX
         sFBGbwnzRqckIaTDnOL2ovj4OfwJZfhcC/izj+oyCtB3O1AKnfBEwoF5bgeF/8J9vgrv
         nVO0TZ4/bknWSzncZ3m3Kt7nG9CHRRoKj7Zwm+UK6xGdGVSXR5pcM/9tvK+UbAQfPIH7
         Pxf1wQurgOXXxFbxfpLhJ2sbOR+7n5GZdoXN2UdB68KrtE+fHK6p5kZCfMz2ttULqogj
         9BNwZ4aom/Mk4Xgj+d8hw7rSMVX5pZVEVY8nBelbzuED7oP97L5QtEUDCVmYtR2CgBZ1
         LlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925825; x=1708530625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSlVGbEelZs1+mCJGuJE5TbiYr0MAiLjyMJwC22PtNU=;
        b=wf4OigJ00Wfby1yDoQJl3HuL/LvNZdSs/hCRCygFZfD3p13YlwlUnDBnHbe36YfCMR
         iF0yOCTSoQ20HPYfj0QHjkG/IcJf3RlbtnFtZv0ymF4q0PUi1sCzXFfN/SEaGB9XthAr
         QCNxZyTRmiRy5gP9hSQQACsELOq6RP/pJ13mrs9p+EioPW6iR4JOoK6K1Sa1IeM3SLea
         QVRzvuewmTIMk0uj7hop4W7PbY/Ah5jZfme6SXd70uOp6g8ECq7QsSoa/C9TQHQek+HV
         QY4LK1o1ZqBfJMTg/zfCyz9Ax/XkLyEa88KN2zYhYHMhm5/+4ng3RBpBceL4h1OlMbvG
         pHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJWtZOnAkEKcXZlcXju840OazQpOt4FGmY52HW5V+1kl6HvFdzw6PsGJ4n7uEUwRRIOfgPqbalhYNot+HEAHE4618ueR/bJ8TQlpAO
X-Gm-Message-State: AOJu0YwbIL+jMAlKcuNZ8xjC02RKFKmwC2ActVMpebuC9aN4zcg2DGl/
	IAOZ+6OnnwHnDnfm9xkg6E4IQJ2EAkJcme3P3cafNA/MP9kOGAxBrgZ3Gu8D9yKBiXyHIvWM1lm
	zuL135mtXc7ghq4000V7EOmDBzjt5zTSIgIwUKw==
X-Google-Smtp-Source: AGHT+IEg1mjBag5fQq6IiYnFAmtRUKSsf1C8M5YPUMlpqUwiUYtvbiinLPu7A8tR+cYW+rVJo79k/QL1npQnEykKim4=
X-Received: by 2002:a92:ca89:0:b0:363:d9eb:dae2 with SMTP id
 t9-20020a92ca89000000b00363d9ebdae2mr2993529ilo.13.1707925825474; Wed, 14 Feb
 2024 07:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214153429.16484-2-palmer@rivosinc.com>
In-Reply-To: <20240214153429.16484-2-palmer@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 14 Feb 2024 21:20:13 +0530
Message-ID: <CAAhSdy3Tf=9jD1Cd11RjwKyDFPA_gHTqxMXSJ3HwANFFnR-8dA@mail.gmail.com>
Subject: Re: [PATCH] tty: hvc: Don't enable the RISC-V SBI console by default
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, 
	jirislaby@kernel.org, Atish Patra <atishp@rivosinc.com>, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:06=E2=80=AFPM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The new SBI console has the same problem as the old one: there's only
> one shared backing hardware and no synchronization, so the two drivers
> end up stepping on each other.  This was the same issue the old SBI-0.1
> console drivers had, but that was disabled by default when SBI-0.1 was.
>
> So just mark the new driver as nonportable.
>
> Reported-by: Emil Renner Berthing <kernel@esmil.dk>
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI drive=
r")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

LTGM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/tty/hvc/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 6e05c5c7bca1..c2a4e88b328f 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -108,13 +108,15 @@ config HVC_DCC_SERIALIZE_SMP
>
>  config HVC_RISCV_SBI
>         bool "RISC-V SBI console support"
> -       depends on RISCV_SBI
> +       depends on RISCV_SBI && NONPORTABLE
>         select HVC_DRIVER
>         help
>           This enables support for console output via RISC-V SBI calls, w=
hich
> -         is normally used only during boot to output printk.
> +         is normally used only during boot to output printk.  This drive=
r
> +         conflicts with real console drivers and should not be enabled o=
n
> +         systems that directly access the console.
>
> -         If you don't know what do to here, say Y.
> +         If you don't know what do to here, say N.
>
>  config HVCS
>         tristate "IBM Hypervisor Virtual Console Server support"
> --
> 2.43.0
>
>


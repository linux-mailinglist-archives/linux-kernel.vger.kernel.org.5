Return-Path: <linux-kernel+bounces-121387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583688E74A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6AE1F2C878
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131D15B97D;
	Wed, 27 Mar 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKHr4LUf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FA15B961;
	Wed, 27 Mar 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547227; cv=none; b=Jco140NsvPvpyb9rDfBePwi+ikEMzCnJA86q8d+pBpnSZ9aTmc7hbIMJK87VGxtxc8Ct5zktKFKnR1RHAKXjGc9OtwvslhTa1JvSurDJFPRoZPN1EgX969ZIYAuS7JqAYSdJ2q67qpnszwfGBL1qe9Ti+MiiwhhQTmErE6wkgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547227; c=relaxed/simple;
	bh=1eB8oXfA/ZkwLQuDw2m7qbWkGH3gt/447Jo6EbXy3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyWTF803Ij7xm/FuJlE6uBcfpE3yaswEXKV6f7BaTEkf0rYfoftIw3vw3iorceTXriIG1AJEGs8b+oRoqWyXweqpqrQ79REwiS1yZs9fCPBmfbbaxSvGwazSMCr44nzkQJuv4NVd9WXhz0Xp0J6uCGLfgMHNLcYew2RRG7fGkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKHr4LUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4354C433F1;
	Wed, 27 Mar 2024 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711547226;
	bh=1eB8oXfA/ZkwLQuDw2m7qbWkGH3gt/447Jo6EbXy3GA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dKHr4LUf21jdENlRjDOMss3RjPG5WC0PZ8DxYBKyhGbQFgSZscTSmGh1Rk5v5ORbT
	 +TYUUUCU4WJ3exBeKD4OxuIw5aGObuZAPm8B/c5zIVeUZ7uhhICRP44CBW12nTnXJl
	 Tik46vI47piaBm8w4/3AdnVaF7S/5CH4goYJjGcm14Bygk42rtfNOsiMbd1XpQ6cIx
	 H5a9JVpyBEiEpVViL62GZFQy//W8a+1FTLHx/Sk/MfGPNtjrq4gJ6evN+5OcGTovfS
	 cKY4HcL82kuj9DzpYpOBpIAWsfxrHLjwob3em5tQR1G4SsRpH/uAVCF0+hauhMW1lg
	 x40uoQeQ8RVDA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d24a727f78so76834741fa.0;
        Wed, 27 Mar 2024 06:47:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZsKN+oFOmyqjVrWVFGf7lKP9NBc0QH0iK+0LQx31pSllsqvWu6EK4cYFgSM3pMZ1Ry0bxtJpdahgviZKb5V24TW99tvH5XMfBZDVC
X-Gm-Message-State: AOJu0Yz8R6SdUOjGs5bJLXxxPa3Tbwta4ntV/9Y2MdwQxsyi0fzkwvVd
	IOYaQzn79Ylhgk5urNNG3VPmqbwvoD4NGTj3Ms+7XAE5Nwi0jtiTRXVDCtRfoGSyd8WuchRzsCn
	j/A+IwWSRwO1LBiuGjSSHMtCDZ6Y=
X-Google-Smtp-Source: AGHT+IHtpzTO6RedN1MRU921u58m6lNsoX3kibUtvcdxoL65sg3A5LV+wJng8cc6Rf2gGLE0cC6dcwNLd0Pyt2lc8M0=
X-Received: by 2002:a19:7707:0:b0:513:a73f:c0ed with SMTP id
 s7-20020a197707000000b00513a73fc0edmr4008623lfc.51.1711547225320; Wed, 27 Mar
 2024 06:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120643.2824712-1-sashal@kernel.org>
In-Reply-To: <20240327120643.2824712-1-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 27 Mar 2024 15:46:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>
Message-ID: <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>
Subject: Re: FAILED: Patch "x86/efistub: Call mixed mode boot services on the
 firmware's stack" failed to apply to 6.8-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 14:06, Sasha Levin <sashal@kernel.org> wrote:
>
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>

This applies fine on top of 6.8.2, 6.7.11 and 6.6.23.

On 6.1.83, it gave me a warning

  Auto-merging arch/x86/boot/compressed/efi_mixed.S

but the change still applied without problems.

Not sure what is going on here .....


> ------------------ original commit in Linus's tree ------------------
>
> From cefcd4fe2e3aaf792c14c9e56dab89e3d7a65d02 Mon Sep 17 00:00:00 2001
> From: Ard Biesheuvel <ardb@kernel.org>
> Date: Fri, 22 Mar 2024 17:03:58 +0200
> Subject: [PATCH] x86/efistub: Call mixed mode boot services on the firmware's
>  stack
>
> Normally, the EFI stub calls into the EFI boot services using the stack
> that was live when the stub was entered. According to the UEFI spec,
> this stack needs to be at least 128k in size - this might seem large but
> all asynchronous processing and event handling in EFI runs from the same
> stack and so quite a lot of space may be used in practice.
>
> In mixed mode, the situation is a bit different: the bootloader calls
> the 32-bit EFI stub entry point, which calls the decompressor's 32-bit
> entry point, where the boot stack is set up, using a fixed allocation
> of 16k. This stack is still in use when the EFI stub is started in
> 64-bit mode, and so all calls back into the EFI firmware will be using
> the decompressor's limited boot stack.
>
> Due to the placement of the boot stack right after the boot heap, any
> stack overruns have gone unnoticed. However, commit
>
>   5c4feadb0011983b ("x86/decompressor: Move global symbol references to C code")
>
> moved the definition of the boot heap into C code, and now the boot
> stack is placed right at the base of BSS, where any overruns will
> corrupt the end of the .data section.
>
> While it would be possible to work around this by increasing the size of
> the boot stack, doing so would affect all x86 systems, and mixed mode
> systems are a tiny (and shrinking) fraction of the x86 installed base.
>
> So instead, record the firmware stack pointer value when entering from
> the 32-bit firmware, and switch to this stack every time a EFI boot
> service call is made.
>
> Cc: <stable@kernel.org> # v6.1+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/efi_mixed.S | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
> index f4e22ef774ab6..719e939050cbf 100644
> --- a/arch/x86/boot/compressed/efi_mixed.S
> +++ b/arch/x86/boot/compressed/efi_mixed.S
> @@ -49,6 +49,11 @@ SYM_FUNC_START(startup_64_mixed_mode)
>         lea     efi32_boot_args(%rip), %rdx
>         mov     0(%rdx), %edi
>         mov     4(%rdx), %esi
> +
> +       /* Switch to the firmware's stack */
> +       movl    efi32_boot_sp(%rip), %esp
> +       andl    $~7, %esp
> +
>  #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
>         mov     8(%rdx), %edx           // saved bootparams pointer
>         test    %edx, %edx
> @@ -254,6 +259,9 @@ SYM_FUNC_START_LOCAL(efi32_entry)
>         /* Store firmware IDT descriptor */
>         sidtl   (efi32_boot_idt - 1b)(%ebx)
>
> +       /* Store firmware stack pointer */
> +       movl    %esp, (efi32_boot_sp - 1b)(%ebx)
> +
>         /* Store boot arguments */
>         leal    (efi32_boot_args - 1b)(%ebx), %ebx
>         movl    %ecx, 0(%ebx)
> @@ -318,5 +326,6 @@ SYM_DATA_END(efi32_boot_idt)
>
>  SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
>  SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
> +SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
>  SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
>  SYM_DATA(efi_is64, .byte 1)
> --
> 2.43.0
>
>
>
>


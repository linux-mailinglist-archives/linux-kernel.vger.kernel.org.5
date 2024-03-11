Return-Path: <linux-kernel+bounces-98539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDE877BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECDC281D42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B611CA0;
	Mon, 11 Mar 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKrG7jAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F34846F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145834; cv=none; b=hnb5z7/PbW9aHPWlgTtuXUhyhm+h3ACJDM91V2t53shf6t/+zWHW5iTEr2jg7IRDPefGQjZ3I96xjdUKyfWkrVvMTIb32KjHaT1IlSlq/i7AM0Lqo1PGGmDRFL3Y2m0s8EsSPCiIffranVpzAqCDSmDimUf11xrRKQ67IyDTRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145834; c=relaxed/simple;
	bh=Er7u94lEpOjZccaFLo8IEx4UWBeOB3xvtiaJHH5y0kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdvxTg4FaZsLm9XCvq9dtnLZv4uxyGm5fxWQ+mkqEIdkUI1D61N2eoA+nVl4yIiZwmkt74L6OzUYgaZ1kxM+mD5gcRQYX2k203Fk5x1RiT22f3QpUTanIVz6dDi3POJPQRSLkvO8ryxg0ZW/eM9BlfAhxiznxcg6GihpbGZS5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKrG7jAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA651C433B1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710145833;
	bh=Er7u94lEpOjZccaFLo8IEx4UWBeOB3xvtiaJHH5y0kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DKrG7jAR3P55e9l6jgt9O54meqHayrCq+IQ2eoU62+DiT30w6Z/x99POp8UBCjRpz
	 nAu+ps5ITd5TDtKIzs/7L/iFSphhMAr02ROTmGahTbZKArBPPOUW9GG3onsQIYU7o7
	 MGrun8GNK1vE5IpQP0txVCPVKt3bCBJPTp8OYV/qlRLhlah/waApNSR6tvbK09wnlF
	 yCSFPHS8kV8CTWQbyVG5dkuBW0fUCDhgCLXhMvkmRTM9GITv7e/VPQx7dk/TjEd9+D
	 T6g/kH/pGkh/ondcOpWYSR0pspTcD9ZxhL+PRKUeSoV8iO/Znpw6Mn8GTGhxq3YyjT
	 L+3wRQYWP5ePg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so4660905a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:30:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLXvq1z6v4WIi+AWzrXJMMjfUSIOLA8c9FPJy10P24peXaRoq/
	Z4wWlvJr0a/G/dD23zBwABC9W+DMyifY8YH8ax+dl8deUAcAxIKv7NwAvaYuF19NjtDhS+4Ucqk
	EJAGjajpy5Z9Yf55y4XVPFYjx9HA=
X-Google-Smtp-Source: AGHT+IGD+aDotYFoArTsKtHpncg5YCd2NNMm+WJKWQ1gs9/zzlwEd53qNb/yIsFJYQWDyWJaSXUefHx/+VztyLOvHHA=
X-Received: by 2002:a50:c90d:0:b0:567:e0eb:c9d1 with SMTP id
 o13-20020a50c90d000000b00567e0ebc9d1mr3892576edh.36.1710145832109; Mon, 11
 Mar 2024 01:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310112129.376134-1-shorne@gmail.com>
In-Reply-To: <20240310112129.376134-1-shorne@gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 11 Mar 2024 16:30:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTQejVrTE5P+snObx=+hV9Chzfk4h6i73Mm9g3b4BU7uQ@mail.gmail.com>
Message-ID: <CAJF2gTTQejVrTE5P+snObx=+hV9Chzfk4h6i73Mm9g3b4BU7uQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Remove unused asm/signal.h file
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 7:21=E2=80=AFPM Stafford Horne <shorne@gmail.com> w=
rote:
>
> When riscv moved to common entry the definition and usage of
> do_work_pending was removed.  This unused header file remains.
>
> Remove the header file as it is not used.
>
> I have tested compiling the kernel with this patch applied and saw no
> issues.  Noticed when auditing how different ports handle signals
> related to saving FPU state.
>
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/riscv/include/asm/signal.h | 12 ------------
>  1 file changed, 12 deletions(-)
>  delete mode 100644 arch/riscv/include/asm/signal.h
>
> diff --git a/arch/riscv/include/asm/signal.h b/arch/riscv/include/asm/sig=
nal.h
> deleted file mode 100644
> index 956ae0a01bad..000000000000
> --- a/arch/riscv/include/asm/signal.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -#ifndef __ASM_SIGNAL_H
> -#define __ASM_SIGNAL_H
> -
> -#include <uapi/asm/signal.h>
> -#include <uapi/asm/ptrace.h>
> -
> -asmlinkage __visible
> -void do_work_pending(struct pt_regs *regs, unsigned long thread_info_fla=
gs);
No more calling in arch/riscv for do_work_pending.

> -
> -#endif
> --
> 2.41.0
>
LGTM, Thx.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren


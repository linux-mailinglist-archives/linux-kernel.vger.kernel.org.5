Return-Path: <linux-kernel+bounces-35399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4B83905F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFE01C22542
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66C5F555;
	Tue, 23 Jan 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHnCLute"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E35F544;
	Tue, 23 Jan 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017492; cv=none; b=hU/7r4SyjcnXlVMniQTHRWmv1U+vUgqvVoWAAuxDHJTF7PXCD+xy0eR6dJIirhaUq9Gnwl+2a0f3kHapBewJcWS7mFbMUceMguqG8Xrs9Vf8nGRqybJ9MF2DxxqKd/Z9yEhDtXHaYmwpWu3bxquJce3lA5LX4iVW7iOvg0sMJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017492; c=relaxed/simple;
	bh=Qn5tSbzj2r3ltCpstoKo0Sn6ZzFWrGV7o6xX7Xc7q8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIWFXhWnd0kNFhpRi/E9bqJS/FXasYsnazEffetqv5gaACwqrNscp74hx35rzGpcoP3MsGEvqox8Hv4GgZp1SLbNC7GYcYbaLCKU1EVI4zKKE93/dIdPnDrEXD0+Any+xELiqXaZDrAEyjhV97VqyoKb/LbbK/g3dMmRKd4of6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHnCLute; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D484AC43394;
	Tue, 23 Jan 2024 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706017491;
	bh=Qn5tSbzj2r3ltCpstoKo0Sn6ZzFWrGV7o6xX7Xc7q8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QHnCLute2mIzLgVlrsjqwDjLrEQjkGbq6JSyg2KMTCI5xZ3wjAeGuCqcZqmUnFDRp
	 bTo/y7AgHBdxBMiEivS2Z2UE+gIz2inia5Ax9b2NfTNXxO5+9R/1pKssLjo5484rNd
	 zNv/F10/BdCAUsnBzzGiSmmLsQDnbGum5QFf28iZJ8ZwTPHFMXN29zKBdngf6aBCyg
	 7MzmjYZovglLnuYMAd91Od+qFn5uZjaed3Q7LNEFZttAA6W5+FjZizZf6wOONG06vq
	 7dOEPfb0kWp5nOwkn+ajzHNNzGhykgTUK40KtZbih1PeAyBPAlfFq5SZPw9CxMbYAm
	 tRuFIEjM5uegQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so5791342e87.1;
        Tue, 23 Jan 2024 05:44:50 -0800 (PST)
X-Gm-Message-State: AOJu0Yxilp8nK8RmaH+hvKc8FZ4XeIDBEMORrHKMriYTeICxMowtHxUz
	3QfYyYHnFdJ4YJ4g9OHEY7Cr5NRiU2+zunmKb0CX1YorGThPBUKbaOEbw2NVWkP4cwixQLPoaNy
	wvJB2wOhPHm9t+EhwUSrCkqbf3H0=
X-Google-Smtp-Source: AGHT+IFU+U1tNqgQMigNgyQBxdrSb28MX8UQaysV1ygiyaTX2KsR6NjU7OcVghU/XB8veeTukID+xCO4PX3jviAIdrM=
X-Received: by 2002:a05:6512:130c:b0:50e:4ebe:ca46 with SMTP id
 x12-20020a056512130c00b0050e4ebeca46mr2801944lfu.78.1706017489085; Tue, 23
 Jan 2024 05:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123011238.work.301-kees@kernel.org>
In-Reply-To: <20240123011238.work.301-kees@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Jan 2024 14:44:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGDqPEBO1jm3FqN2dLPPTDL+xdW9mNCUV16bfJ+AtmS-Q@mail.gmail.com>
Message-ID: <CAMj1kXGDqPEBO1jm3FqN2dLPPTDL+xdW9mNCUV16bfJ+AtmS-Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: fault: Implement copy_from_kernel_nofault_allowed()
To: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, 
	Wang Kefeng <wangkefeng.wang@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Hugh Dickins <hughd@google.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 02:12, Kees Cook <keescook@chromium.org> wrote:
>
> Under PAN emulation when dumping backtraces from things like the
> LKDTM EXEC_USERSPACE test[1], a double fault (which would hang a CPU)
> would happen because of dump_instr() attempting to read a userspace
> address. Make sure copy_from_kernel_nofault() does not attempt this
> any more.
>
> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/all/202401181125.D48DCB4C@keescook/ [1]
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/mm/fault.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index e804432e905e..bc5b959b6f90 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -25,6 +25,13 @@
>
>  #include "fault.h"
>
> +bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
> +{
> +       unsigned long addr = (unsigned long)unsafe_src;
> +
> +       return addr >= TASK_SIZE && ULONG_MAX - addr >= size;
> +}
> +
>  #ifdef CONFIG_MMU
>
>  /*
> --
> 2.34.1
>


Return-Path: <linux-kernel+bounces-17079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E11824808
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671001F21940
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8A28DD1;
	Thu,  4 Jan 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TR5s+GfB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636E28DC3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so728855f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704392144; x=1704996944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5baGaSmFbgB509j+N50+gyL+8haTd8NMoSNMBKXbuw=;
        b=TR5s+GfBlfqYJTFipy3pgaUbK785xUJlnp1LC0wYXUEOE0jkHYXSoPfWUuT8FAfXZN
         ns9MthBy345//phshVBv/a5XaItsSUevtJaNG8YbkvL2yOfG+8YP3fsF68LAX57CGu8A
         EqxSKzWL+0qADvLh+I5uLsdHxnt47A20FZDrPYkUZKQw1DUhNvrSVPNfdp8l5VjTYiZB
         3nMZBjREF4HLs7S7iXiwZGwcyZkEwMrnUQExe+i2/jCEzhZpZXiKwIy49Wa1SkI9yifN
         LYx3F//ENyyqABj+9I08ZtCnDwKOnOuOfXPLxR3OP6xgaEtgrB6h52HvcQNt9PhB7JYS
         kpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392144; x=1704996944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5baGaSmFbgB509j+N50+gyL+8haTd8NMoSNMBKXbuw=;
        b=EulgLMSF6CDTrsPZhPkN8QsD3UpMrbEA/rIfUsbh9q/Tzsd+P06SzBe0JY9ULLQvOo
         /7A7RVE4LRP6Fp7kVH9Xz9mkKDNBoUavq4f87Y8VDw43FhEUEUsCCL0+s2Flv6pZ608u
         nTA/kLpgEQpUzqVPJdP27Dw363MhzwOOL4U8pAKdQd9idgETalwBBT1NBM54n5MtUXX6
         TJyIJ0fPXFdTs8qjNfWKLsEuSN/OOP+7RxPSeiYdIiTWyteuoVxlbZ0fEoMrZebXXRQ5
         qHG0qxjVueoH/UuphkoF03Df6v9kGNFRwzMXsEKXUC/WBw4gxpQ8KlFi/CD5tqDlt3/4
         ygYA==
X-Gm-Message-State: AOJu0YzndTVjrHxVa3EQAKcg6neekuCmsvHNXndcwfBMUW7xqmlqzwUl
	8wa2kIX192IDqm5MVYvSiXxInnHIjhBPMqqdMjSluxQFtIGh
X-Google-Smtp-Source: AGHT+IGjQWwD0JSRtgSRb/LA8Uebru4laIwL3Y2REbANo4weMZGfUoaVCdM5RXpKn+q6mRcbIAQMieMfH0ca8grrRWY=
X-Received: by 2002:adf:e7c1:0:b0:336:7745:f63b with SMTP id
 e1-20020adfe7c1000000b003367745f63bmr744619wrn.101.1704392144150; Thu, 04 Jan
 2024 10:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-vdso32setup-v1-1-1737147bc6ed@google.com>
In-Reply-To: <20240104-vdso32setup-v1-1-1737147bc6ed@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 4 Jan 2024 10:15:29 -0800
Message-ID: <CAKwvOd=KR_fUXF3jVJgW6a9x0++2f1aS99PxHa+ZfHDUNemykQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: shrink vdso/vdso32-setup.i via IWYU
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:51=E2=80=AFAM Tanzir Hasan <tanzirh@google.com> wr=
ote:
>
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list, changing indirect includes to direct includes. IWYU is
> implemented using the IWYUScripts github repository which is a tool that
> is currently undergoing development. These changes seek to improve build
> times.
>
> This change to vdso/vdso32-setup.c resulted in a preprocessed size of
> vdso/vdso32-setup.i from 44009 lines to 18572 lines (-58%) for the x86
> defconfig.
>
> ---
>
>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

^ Your signed off by tag is "below the fold" (`---`), so it will not
be retained when applied. (Bad)

If you're using b4 to send patches, let's triple check whether you're
putting your SOB on the "meta" commit (probably what's going wrong) as
opposed to the commit itself (good).  Why don't you check that and
then send me a v2 privately, so I can help you check?

> ---
>  arch/x86/entry/vdso/vdso32-setup.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vds=
o32-setup.c
> index 76e4e74f35b5..8dbe022589a6 100644
> --- a/arch/x86/entry/vdso/vdso32-setup.c
> +++ b/arch/x86/entry/vdso/vdso32-setup.c
> @@ -8,13 +8,11 @@
>   */
>
>  #include <linux/init.h>
> -#include <linux/smp.h>
> -#include <linux/kernel.h>
> -#include <linux/mm_types.h>
> -#include <linux/elf.h>
> +#include <linux/kstrtox.h>
> +#include <linux/printk.h>
> +#include <linux/stddef.h>
>
> -#include <asm/processor.h>
> -#include <asm/vdso.h>
> +#include <asm/cache.h>
>
>  #ifdef CONFIG_COMPAT_VDSO
>  #define VDSO_DEFAULT   0
>
> ---
> base-commit: f5837722ffecbbedf1b1dbab072a063565f0dad1
> change-id: 20231228-vdso32setup-8e336d60ac3e
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>


--=20
Thanks,
~Nick Desaulniers


Return-Path: <linux-kernel+bounces-20204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09051827BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA13A2851FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E735674A;
	Mon,  8 Jan 2024 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUoQqLEI"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4A56477
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b7f6caf047so114506739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 15:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704758336; x=1705363136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObA/eXYbt6idfVHwSN4bUljXYXLTz1y+bHEReIJxmHE=;
        b=cUoQqLEIEaXqYQL5qFxIDtg24HTT+IvfsoAgNRLtcpCQn2V8BDRiY4ay7hbS5MyJeV
         G7zRUDnHigc5CLYUF/BEvh/bwk8kaifq7TYcVdZKMOvBDC2H/YIraMoA4cvcIXZVAZrM
         /0xGeCooRLATaRaC1g7Y37UpDFRkReJ5gNWbF5jOTOkfWX9tOWxcC/YKxMJi/CSOOVk3
         Ibic+I8WiYDSyTzOBaKbYQX83jezRYihdqLkDHSJCtVNbnEhTjIYAhzFTQpPV6ciuw5N
         x/aEbdG9G6imcUFg/FkVpHvX/MWB5O8UQxu2lTFOVJ3TlYPvBhQQRBs914nIBo0kYINF
         G/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704758336; x=1705363136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObA/eXYbt6idfVHwSN4bUljXYXLTz1y+bHEReIJxmHE=;
        b=CZslHDQYVLRcOf/jS7oFdMaoakhaflMMid24n1kjMhmBTeA41WxsA6B9jg/wUbNkBi
         dzHVsfuskltfBYu3sFGV+bRP1czJpnHAathZFn7XGX4LQGe+YMaq0pWFyg3hEp3+AACi
         eLMoltRaR5OV2NKeYjQSz8cMr11D8DmBeWbZZuvv05gw7VM4H340YncoatpKcVDqd8Io
         hgcoxt3GdwUwu8GWaE3ViAAnFR7vqehP0PLaPt6V31KhwDoN2T/T6f8NV9UNsm5xWKAf
         qzvQ9g6L1pkhs4mzi0fiGJmULzM8rn+QCXH5jOf6B6KjsbKuE3xTYWh/8Jx8xOaZ1U08
         GhCw==
X-Gm-Message-State: AOJu0YyGIRxwaBVlEqxHkrl7XpteARY5XXaKJH1a/Y70cwvYDXlH0cq7
	CrBDUqmvTXkYl/Oakoa+/ROg4djrS8Q2
X-Google-Smtp-Source: AGHT+IElD9Pe8MZ1BprwQKAQjjoAq7V7oak9UVEHRe+Q+NPnBBN6QXom+KkS5lvsds+ICbRr7dmp0g==
X-Received: by 2002:a5d:93da:0:b0:7b7:4c36:f295 with SMTP id j26-20020a5d93da000000b007b74c36f295mr5914042ioo.40.1704758335905;
        Mon, 08 Jan 2024 15:58:55 -0800 (PST)
Received: from google.com (212.165.232.35.bc.googleusercontent.com. [35.232.165.212])
        by smtp.gmail.com with ESMTPSA id m16-20020a6bea10000000b007bec3bff350sm201687ioc.16.2024.01.08.15.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 15:58:54 -0800 (PST)
Date: Mon, 8 Jan 2024 23:58:52 +0000
From: Justin Stitt <justinstitt@google.com>
To: Tanzir Hasan <tanzhasanwork@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Nick Desaulniers <nnn@google.com>,
	linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] x86/vdso: shrink vdso/vdso32-setup.i via IWYU
Message-ID: <20240108235852.3jejew4auwq6q6vg@google.com>
References: <20240104-vdso32setup-v2-1-dc9b76c7d06f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-vdso32setup-v2-1-dc9b76c7d06f@google.com>

Hi,

On Thu, Jan 04, 2024 at 08:46:25PM +0000, Tanzir Hasan wrote:
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
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
> Changes in v2:
> - Fixed messed up signed-off-by tag
> - Link to v1: https://lore.kernel.org/r/20240104-vdso32setup-v1-1-1737147bc6ed@google.com
> ---

I built 10 x86_64 randconfigs with KCONFIG_SEEDs:
1: 0xF411D996
2: 0x47DADF74
3: 0x431DBDD9
4: 0xC411E812
5: 0x308B62A0
6: 0xD91AA814
7: 0x11DF23E8
8: 0x629EBA88
9: 0x4B88CEC8
10: 0xED145212

They all built just fine.

Tested-by: Justin Stitt <justinstitt@google.com>

As for the semantics of this patch, dropping a giant header like
kernel.h seems great and the rest of the includes are reasonable. For
that,

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  arch/x86/entry/vdso/vdso32-setup.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
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
>  #define VDSO_DEFAULT	0
>
> ---
> base-commit: f5837722ffecbbedf1b1dbab072a063565f0dad1
> change-id: 20231228-vdso32setup-8e336d60ac3e
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>
Thanks
Justin


Return-Path: <linux-kernel+bounces-153669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E38AD16E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3381F21EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25468153582;
	Mon, 22 Apr 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3OP/BYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657591534E2;
	Mon, 22 Apr 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801754; cv=none; b=d23KIbqXBf/ZAnRsjBJI1iWiEnGESHKeArLuhwCFVlHUgdxxiSGfq7Yd46TcQNUIAqH0jq8bdCED2d453ZR1vYo2l5lZpRjWjZWRLfEQNcxwL00eMuR/mX7sDO4aE+lVm8sJgdO6cHGm4Loc0sYoOMWAtEZiw7CXxWghf/vrXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801754; c=relaxed/simple;
	bh=kKEgwTQB6MqW0mu0bWbxcpzTqMyAS35I7Efi1ILhfsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkfVODL7vnbhEB/i+6PBZJ7tydq16Y/FgIFkBf1A9lgJp8eYBpuB3BZuYnozuwNgomBEai+IPrIKlnnpj3/BDMZEW/olmtJ34o7/PpgBL/Vh84KzQ+SbOnTdwd8pkb7MbD1qeXhB2wStV1qbxd0mhMn+eS9y/3YFNbzVa6V7IC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3OP/BYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D32C113CC;
	Mon, 22 Apr 2024 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713801754;
	bh=kKEgwTQB6MqW0mu0bWbxcpzTqMyAS35I7Efi1ILhfsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o3OP/BYsZRigokLjxaTOJ6S0laERho7w/857iL496omGhqU82zk9SZuT5ZMRM5OeA
	 V+m5/F51fkyDmH45SYrbvx11IaXxS2bDdmA9iMORBpXmM+sbGS7XmuPMrmCxNlbXHu
	 Si64KIfdIDBaWnBkeR2nzvz2kPvsBQQGniTjC8G58db+JHxTUl7XGVK6dnemXvEpzK
	 At5ZiZzvXEM6aoRp3tMgvQIQwbZnvn4RlKMFPOypi8IAlyvTOwRlmQ3rM2ZJ0/eRcT
	 +1kbEm+ar/mqD1R6/Kyr1GENUUG8svwWE6oI3GJ+6xJca1bT8L+qaYfs7Kz6Tw4dI1
	 qmh6qjePhMfRQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ddc2ea2091so7882461fa.1;
        Mon, 22 Apr 2024 09:02:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmRucXeB5AYvGbF7ffcC5OM+1MRVLVwhZaAWJZq4noEAu0MB3itif/ZGnc+EO5kXCB4o3mu8fgYS+qyvSHbyD3Yp7wCnXiaerV50BY
X-Gm-Message-State: AOJu0YzKgEr+s3uPj24bOkd800okdOsZrZYRueOMKnEjRu6IStWST3si
	tNdTlgX0FJYGlf2tflGhCSvs8NReOTYUMDVx5mgDMuCKuXXfh9RL+uhp5Emx/RLv4BT/pbFbZek
	cBKJa1bRawkcyyU+SDA/f297Wxo4=
X-Google-Smtp-Source: AGHT+IHDq9Z81k6Aj8+jp9AQz65iOG39NbBSMlAfx5XqULn0UDopCkcP9FoMzvYkmZnGFTnFstV6f4q1IPSQ/81hk5U=
X-Received: by 2002:a2e:b8d0:0:b0:2dc:de74:dfd6 with SMTP id
 s16-20020a2eb8d0000000b002dcde74dfd6mr7640386ljp.10.1713801751709; Mon, 22
 Apr 2024 09:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
In-Reply-To: <20240422060556.1226848-1-liuyuntao12@huawei.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 23 Apr 2024 01:01:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgkt6t6UEB+_q15KJb2STVL6oqUo3mFM8EzumFH+-mYw@mail.gmail.com>
Message-ID: <CAK7LNAQgkt6t6UEB+_q15KJb2STVL6oqUo3mFM8EzumFH+-mYw@mail.gmail.com>
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, nathan@kernel.org, 
	nicolas@fjasle.eu, peterz@infradead.org, jpoimboe@kernel.org, 
	leitao@debian.org, petr.pavlu@suse.com, richard.weiyang@gmail.com, 
	ruanjinjie@huawei.com, ndesaulniers@google.com, jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:41=E2=80=AFPM Yuntao Liu <liuyuntao12@huawei.com>=
 wrote:
>
> The current x86 architecture does not yet support the
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. x86 is widely used in
> embedded scenarios, and enabling this feature would be beneficial for
> reducing the size of the kernel image.
>
> In order to make this work, we keep the necessary tables by annotating
> them with KEEP, also it requires further changes to linker script to KEEP
> some tables and wildcard compiler generated sections into the right place=
.
>
> Enabling CONFIG_UNWINDER_ORC or CONFIG_MITIGATION_RETPOLINE will enable
> the objtool's --orc and --retpoline parameters, which will alter the
> layout of the binary file, thereby preventing gc-sections from functionin=
g
> properly. Therefore, HAVE_LD_DEAD_CODE_DATA_ELIMINATION should only be
> selected when they are not enabled.
>
> Enabling CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT will use vmlinux.o
> instead of performing the slow LTO link again. This can also prevent
> gc-sections from functioning properly. Therefore, using this optimization
> when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
>
> The size comparison of zImage is as follows:
> x86_def_defconfig  i386_defconfig    tinyconfig
> 10892288           10826240          607232          no dce
> 10748928           10719744          529408          dce
> 1.3%               0.98%             12.8%           shrink
>
> When using smaller config file, there is a significant reduction in the
> size of the zImage.
> ---

> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 7862a8101747..7287b5a9f17d 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -60,7 +60,7 @@ vmlinux_link()
>         # skip output file argument
>         shift
>
> -       if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IB=
T; then
> +       if [ is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_=
IBT ] && [ ! is_enabled CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ]; then
>                 # Use vmlinux.o instead of performing the slow LTO link a=
gain.
>                 objs=3Dvmlinux.o
>                 libs=3D
> --


This is wrong.
You should not put is_enabled inside [ ... ]

(is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT) && !
is_enabled CONFIG_LD_DEAD_CODE_DATA_ELIMINATION

is still weird.


When CONFIG_LTO_CLANG=3Dy and CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy,
the result of LTO will be discarded.


--=20
Best Regards
Masahiro Yamada


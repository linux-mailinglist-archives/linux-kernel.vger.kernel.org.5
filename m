Return-Path: <linux-kernel+bounces-54283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CF84AD40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC89C2858D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F0745FC;
	Tue,  6 Feb 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpaNt8F1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2387745E9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192281; cv=none; b=cp2O1Vvrr8LfR1SX+VyUL114AmG8BpZqTgkcPqAmomil90pLnYKxaUsfLL1ZC8o0wZ9MyYwdNCFgJIodRuhhgJ2YA0kkk63pgOX92ZyETkBD3A2TYveb346vKhE+uYMd0udaobPIlyqnm1IGuZQJn7YOJ5opxTS+QfUw81mkpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192281; c=relaxed/simple;
	bh=QB4co5VX6LHEF8xcu+WpfHx2D3ls/uMchzpoaBkY2l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEg6glYTOu4WJVCOkJ6ZDYWkLZOffHR+rB03YeqjA8mwhmvGaSIXqK5qZk7m7cP34raousA1hpuyJMuF8aGf5nuyqvAlVisdwBoWFyLRA1RQxnzSqj1svX1xX+UzA6cnVxVsVhlQYARjqBJ6kfweo76+kMpuqH5gSTGhWDZ8kZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpaNt8F1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B909BC43394
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707192280;
	bh=QB4co5VX6LHEF8xcu+WpfHx2D3ls/uMchzpoaBkY2l8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rpaNt8F1Xj9RQ8YlD4Sl+s0iaaFbObS4cgLH+qOEP3A3ecWIHPTfOPbxWO8RrHY2c
	 5UcbcWVP63Mkn3CLQE4RBcE5thH4goKA3pZnT691FMhrTMJ2QNIwA4gtRpBbBMGYrC
	 srcxPFFC1DYS8FBJ7WPiSBsJSlnk3D65JXISAXn//KH++5QDEq4WMkAaSagXjRtgQV
	 uhObiXeWW3Ia9sywauVCRLX1m5ZPBMUVf18WG0qKWfO/XH3J6oKhJG5/WvHK0U5Fv9
	 gcylpc+viuCLFf/oFkQ286dek/6krbfnyZqDK/erQG7w7Sebuf5v56u8kz13zVNrtt
	 WnR9o1oq86qQg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51124d86022so7966402e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:04:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yy6T4RcJSL4wF0QL8W6IQuPcQVNzPzu7oP5e3htNs7moiyeJAsd
	llPfgJi9SoRpL9wdC4//NB1YrNG11bhP1FO1dIpaMLd13XYhKvyu1hj/Sb0AQP1aPEgshTzsH7I
	wAFzcBGWUM7OBT8CWaW47W0UgtuY=
X-Google-Smtp-Source: AGHT+IHd+d3QCMam+P2PbpL3IPI/u5TV77/KBqWOy6VgPu4ULjUb0IugR+c87/qmZz9O7urGrMG2iUi+AGtOLKI5A0c=
X-Received: by 2002:a19:f610:0:b0:511:49b4:ed6b with SMTP id
 x16-20020a19f610000000b0051149b4ed6bmr657707lfe.34.1707192278945; Mon, 05 Feb
 2024 20:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204134946.62509-1-masahiroy@kernel.org>
In-Reply-To: <20240204134946.62509-1-masahiroy@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 6 Feb 2024 12:04:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5HvqBk0O4M2MVh+qzP39oc22x3RXbwydiN+q_u32xbSA@mail.gmail.com>
Message-ID: <CAAhV-H5HvqBk0O4M2MVh+qzP39oc22x3RXbwydiN+q_u32xbSA@mail.gmail.com>
Subject: Re: [PATCH] loongarch: select HAVE_ARCH_SECCOMP to use the common
 SECCOMP menu
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	YiFei Zhu <yifeifz2@illinois.edu>, Kees Cook <keescook@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Huacai

On Sun, Feb 4, 2024 at 9:49=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> LoongArch missed the refactoring made by commit 282a181b1a0d ("seccomp:
> Move config option SECCOMP to arch/Kconfig") because LoongArch was not
> mainlined at that time.
>
> The 'depends on PROC_FS' statement is stale as described in that commit.
> Select HAVE_ARCH_SECCOMP, and remove the duplicated config entry.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/loongarch/Kconfig | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 64e9a01c7f36..929f68926b34 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -100,6 +100,7 @@ config LOONGARCH
>         select HAVE_ARCH_KFENCE
>         select HAVE_ARCH_KGDB if PERF_EVENTS
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> +       select HAVE_ARCH_SECCOMP
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> @@ -633,23 +634,6 @@ config RANDOMIZE_BASE_MAX_OFFSET
>
>           This is limited by the size of the lower address memory, 256MB.
>
> -config SECCOMP
> -       bool "Enable seccomp to safely compute untrusted bytecode"
> -       depends on PROC_FS
> -       default y
> -       help
> -         This kernel feature is useful for number crunching applications
> -         that may need to compute untrusted bytecode during their
> -         execution. By using pipes or other transports made available to
> -         the process as file descriptors supporting the read/write
> -         syscalls, it's possible to isolate those applications in
> -         their own address space using seccomp. Once seccomp is
> -         enabled via /proc/<pid>/seccomp, it cannot be disabled
> -         and the task is only allowed to execute a few safe syscalls
> -         defined by each seccomp mode.
> -
> -         If unsure, say Y. Only embedded should say N here.
> -
>  endmenu
>
>  config ARCH_SELECT_MEMORY_MODEL
> --
> 2.40.1
>


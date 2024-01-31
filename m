Return-Path: <linux-kernel+bounces-45805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3484366B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ACC1F24D34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA03E47A;
	Wed, 31 Jan 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+jb6c12"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E73DBBF;
	Wed, 31 Jan 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706681148; cv=none; b=hUAc6wR5a/t1o7B+DMTaSja7RfvTWTE05fX4b//o5OQCQg/+5DeiNRv6Ivqz0HD8CSe8AwY9O9sEJu4GP2WHXBbUdzrrhlxk0m1pp5dzX6Is/sWFG4vBlV5u++VE7ZAuuKMNGH+yc8CnxftBUku+YsPuPz3aqnYM3dHlYw5ov5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706681148; c=relaxed/simple;
	bh=qus462gm4W7HacMHht7FDIF1aPdFbq/jFvbVSl4ZG8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaYpMBNu0we8zLq5AeKVZ8BhVMBI0LqIuDcLp4f9jGMK0Y1oejZhI0rrADbe/9P7mJMafhud+cMA4aCat/J0tVmmjsRZSLkhG9L6AR1sUnKMqmun27F7wnxRrvnE+AKOqR8XTtvsQyYrfArJnlP9fGv2Lw7EPKIKlKiKKPczmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+jb6c12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAECCC433B2;
	Wed, 31 Jan 2024 06:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706681148;
	bh=qus462gm4W7HacMHht7FDIF1aPdFbq/jFvbVSl4ZG8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g+jb6c12d8VOgjf8jz/8K4lzJEZxQSdnJIr7gq+QvsjdRHksCVvWm+HE19kxYVM8j
	 FAXWYfTNGf23ZWAg/fgjuKKkTWteW7PVFzazDRL0mAqhC6lvW/w5jhAjDF1yobzpvQ
	 A8yFSwMGMNu0l0ec6XzZnWhcMyNDRTfrFv5M1SEEV61OirpTQ9H/nxIzJM1PRev80n
	 1oEHKUBVA1gGQI7o49x/gb/TuTfwKTag8V4TEm5T1WjNwoa4QwWnS8CDkVEB7I/BKo
	 K49+jyZkkcVFrdZytXIoS1dE04978gpZsUUhk56pL6+wTyzOdQRN/81MRLRMFJ1Sn5
	 +wuSCBswmhiNg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so2814435a12.0;
        Tue, 30 Jan 2024 22:05:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yy1kvUz3fpKc6Mwhgo8LDkIJ3XmIH8LBHO7hzWL57h21ozZGpMR
	1G0k/jouZ9pqzGrhMjB5YcQdH6u/5q3L1wKrx/58KibAFWZrZ6vN4vRAll9yBZ9n2nR1mbhqsSS
	uGJ8i/0Dd62VfV+EmkMcdG1ad2cw=
X-Google-Smtp-Source: AGHT+IHMP57lqu49Bz1sgO3SY3xP1kdDdaLTG3RNWidC2zC0yg6vGI/LuqCrtHmyUQcj/kmKEjoPIECKS/K5l2qxrD0=
X-Received: by 2002:a05:6402:ca3:b0:55f:6b5a:6310 with SMTP id
 cn3-20020a0564020ca300b0055f6b5a6310mr302635edb.33.1706681146230; Tue, 30 Jan
 2024 22:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130233140.work.887-kees@kernel.org>
In-Reply-To: <20240130233140.work.887-kees@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 31 Jan 2024 14:05:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H524mSc5SgiwVF3aATFkrp0_xo2W7-5sXk0nXyN+rBzrA@mail.gmail.com>
Message-ID: <CAAhV-H524mSc5SgiwVF3aATFkrp0_xo2W7-5sXk0nXyN+rBzrA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vDSO: Disable UBSAN instrumentation
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, WANG Xuerui <kernel@xen0n.name>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Fangrui Song <maskray@google.com>, loongarch@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Qing Zhang <zhangqing@loongson.cn>, 
	Feiyang Chen <chenfeiyang@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Huacai

On Wed, Jan 31, 2024 at 7:31=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> The vDSO executes in userspace, so the kernel's UBSAN should not
> instrument it. Solves these kind of build errors:
>
>   loongarch64-linux-ld: arch/loongarch/vdso/vgettimeofday.o: in function =
`vdso_shift_ns':
>   lib/vdso/gettimeofday.c:23:(.text+0x3f8): undefined reference to `__ubs=
an_handle_shift_out_of_bounds'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401310530.lZHCj1Zl-lkp@i=
ntel.com/
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Fangrui Song <maskray@google.com>
> Cc: loongarch@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/loongarch/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index c74c9921304f..f597cd08a96b 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -2,6 +2,7 @@
>  # Objects to go into the VDSO.
>
>  KASAN_SANITIZE :=3D n
> +UBSAN_SANITIZE :=3D n
>  KCOV_INSTRUMENT :=3D n
>
>  # Include the generic Makefile to check the built vdso.
> --
> 2.34.1
>


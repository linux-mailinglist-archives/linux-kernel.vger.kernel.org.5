Return-Path: <linux-kernel+bounces-73087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AA85BD66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D323D1C21326
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43866A35F;
	Tue, 20 Feb 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLArZT+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1AE6A352;
	Tue, 20 Feb 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436416; cv=none; b=d++mkchmLJ4puqaGtgy1fOfOdpxYDG8utNPN4EoPvrX5rOHrZ2zA/IoqFGO91r/CFrh9SzJkuNNo0eDSvObd4UmY3krWc4afNb3vD9kY4q44JoaMmkoYSfz2yrIloQPOH7VV2we3f6kN6m6hH5M/ZYiGUZHbCurdIu2S+k7wbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436416; c=relaxed/simple;
	bh=JDJQNjVw0veG1VaCbbXgYBFSju4HC6XVDS/PqNxBn1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amprxO7RUNPQv7fzMDmyx5qQKMVRTfj04sIbqeGIUh/+j1MMy+TXAnU+t7rSRx0k7KYpEk7J3eEz1IPHwTIVePMN34ldxVjm5AOkHe3Oute/DjXPPHwMK29Zt4bJhpNligYT98Na3lroFJoZt4+w6Ul3+vSyNZo+QsRNHl1nTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLArZT+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DB3C433F1;
	Tue, 20 Feb 2024 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708436415;
	bh=JDJQNjVw0veG1VaCbbXgYBFSju4HC6XVDS/PqNxBn1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rLArZT+qc+TFAcJdTODc0UbjE8Ongzr4+cb0ZJxf2TN1Ka+D5pZJFuHPrzb0pc9dO
	 6UyOwJABmhW7fuWo0gNNceBhgT/q5UuWm4M3mZQGdHAPtNy9z6Vlm1IUSJ1Drn+mm0
	 S9NfiPcK4NMifLJTfTTLms7lik6lkhByCWG41uXYRVK5H5SKfxE84OwSzstJQZp0BZ
	 fA+m303Ekn9A+Pr4cWI6n6HFPlx05lwCzceXLp4LuUpBDN8cxSVn2l6vDbFCw8HbnZ
	 DDynf9AOAm2wy3CHk7t/y6w/BwXeuTSZ2k5RTD2tnAKC9u2npE55UerLmvb3LoGQbJ
	 95UXpH1wXk2ZA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512be87a0f3so1780276e87.3;
        Tue, 20 Feb 2024 05:40:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5dCYik3k6C9COKWfHSSBgcq8zGeuTPtDShDi5yCeJ9HodRiqp8nN46RtRAUIOHa9vcAYciFS4GS5myQ4XJ3d+QNZnMq207+8OZlz6TDPMT+bx3tw5Zk8BvTyFmQubQFgp0+da/jmAExL0
X-Gm-Message-State: AOJu0YxYN+z/9TnmYC34zBi8srGC0jJ9+4q6DrLSBrNLk/dn0jz1n5eQ
	nA67RHb1K83b3K0YQh2gTrNFK4LiySBaknHXkg7STasR8tEAKYkz1iY3i7X9Q0kVx/19fmpakwG
	b/uz6nawKjZpUxRX3dw2xRwHLkAo=
X-Google-Smtp-Source: AGHT+IGEDbJeXcckbzMiYZMx6O2WQYB/vnGFoZGu8Zv15CobuFxWqNDt17JsTSLOmf2HHpo6+Xodu81aQL1nhwKl4TM=
X-Received: by 2002:ac2:505c:0:b0:512:a59d:27b3 with SMTP id
 a28-20020ac2505c000000b00512a59d27b3mr5068137lfm.14.1708436413895; Tue, 20
 Feb 2024 05:40:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215151642.8970-1-petr.pavlu@suse.com>
In-Reply-To: <20240215151642.8970-1-petr.pavlu@suse.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 20 Feb 2024 22:39:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=knGxd9ZRo37CaKTvjcc28bqNasx+XuqbV3S+XV=HtQ@mail.gmail.com>
Message-ID: <CAK7LNAS=knGxd9ZRo37CaKTvjcc28bqNasx+XuqbV3S+XV=HtQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: nathan@kernel.org, nicolas@fjasle.eu, mark.rutland@arm.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:16=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
>
> GCC recently added option -fmin-function-alignment, which should appear
> in GCC 14. Unlike -falign-functions, this option causes all functions to
> be aligned at the specified value, including the cold ones.
>
> Detect availability of -fmin-function-alignment and use it instead of
> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
> and make the workarounds for the broken function alignment conditional
> on this setting.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---

[snip]

> index dfb963d2f862..5a6fed4ad3df 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1920,7 +1920,10 @@ EXPORT_SYMBOL(thread_group_exited);
>   *
>   * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D88345#c11
>   */
> -__weak __function_aligned void abort(void)
> +#ifndef CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> +__function_aligned
> +#endif
> +__weak void abort(void)
>  {
>         BUG();





__function_aligned is conditionally defined in
include/linux/compiler_types.h, and then it is
conditionally used in kernel/exit.c

This is unreadable.




You may want to move CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
to include/linux/compiler_types.h, as this is more
aligned with what you did for __cold.



if !defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) && \
               CONFIG_FUNCTION_ALIGNMENT > 0
#define __function_aligned       __aligned(CONFIG_FUNCTION_ALIGNMENT)
#else
#define __function_aligned
#endif





However, an even more elegant approach is to unify
the two #ifdef blocks because __cold and __function_aligned
are related to each other.



#if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || \
                 (CONFIG_FUNCTION_ALIGNMENT =3D=3D 0)
#define __cold                 __attribute__((__cold__))
#define __function_aligned
#else
#define __cold
#define __function_aligned     __aligned(CONFIG_FUNCTION_ALIGNMENT)
#endif









--
Best Regards
Masahiro Yamada


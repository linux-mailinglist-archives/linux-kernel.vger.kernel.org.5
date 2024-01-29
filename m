Return-Path: <linux-kernel+bounces-43379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C068412EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB891F240FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7B101CF;
	Mon, 29 Jan 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zfeerdiw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9412D044
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554827; cv=none; b=psGfRTIvU5bJO1gUhzROIVEho1pVV1EJ1DZfsByeXT2ce31Djkf92oud7UNuumTq1fiKCfNH54CbOQh1q8B87OxtugnkFwfV0OlEQValRVqATWwXsvAE0Mf/u79+bNMI+u56dCDc9KWL7VDNE3DxDGeom4afAPJ9R6n/vB32WdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554827; c=relaxed/simple;
	bh=ssMtgarRnRs+LWFQuEr18d3XaNBa10XeJKStTgVMzZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URTzA1aKOUdeyGvnVphWRixbJSkrCE+3ItBcKoB3ZyBVFUpOQUl9SiveJ8Resqdh8F25LSOnfVSLH83V9ZLjp35D7duxeZcgnPn5X6fzboYEwKQIBarDN2mQ9tmu1ku4Fszlq/7Zv2nFz2G14/Db0r9t9XU6ihmt5htOUgPSzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zfeerdiw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ef9382752so7855e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706554810; x=1707159610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYJPquRBqD9Q7jzpQNCrCFu5Gx3v6qV+tI8wEy5zyow=;
        b=ZfeerdiwfxWViMskYXJhB+YweyCBokktAl4Zyr9iMcfE7BpBFSGXKdo1O0zSn1V9gv
         ufODj1TKQLdH4T7l2Lll6fPA+bmKijB930YahEfHDIqJnB/24Nt+96Id7kywbe/eJ2Q1
         M3xvL0T/xWV/Fjk8g8e+/ADMXDPeg0ZqXjCU1fz788w0mpdXlyuBgN76hTkCgsrg8TY+
         y6K85VlVkiWgTSm1HjrX9p0RN3RewVKeiG1+2yXqh9Cg+jpwyHieHEa1aJU/gqmsCXUe
         v0lkDrm+jh3jw8aWyuEgvLtrv3I3DA1E3VxraSdXbLPeVc7LI/0rn7UD2BehOkkGQRyf
         Enjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554810; x=1707159610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYJPquRBqD9Q7jzpQNCrCFu5Gx3v6qV+tI8wEy5zyow=;
        b=ZciO3GZJmq1ZQ4LEFggz2bh/Tt4kgrzDhB9zTdZhJMQYceJNxYTSbBLMRN6iWAANNj
         YATt1elvyT6Mub0wG3AnEIaTcrVCQ5J9HIqndxigTgfzhgfyYR+0g3MOVnTicAkr6L4l
         J4uu2G5Fg/xrw8UomuOa9JioZtmkmh4s5l7yrQhKZ8Qs1OhEIprxPcmTY/MvDjFFv9DU
         M4AAOi1XROP5/gbpgPT6lta+FdV+KccSRUdNr1F7NRydtN5zldCkM3yJ95bl/GKkey6u
         B+O7U7Fy0Y5usApeXSxmwFf3PVW9ZQYaXLazUGzbzD33PYiP75fvTcOvl3OGHw58njxc
         Pi1A==
X-Gm-Message-State: AOJu0Yz37uzTO9lWIrxRy745NQMnnOe5p9Q+RdvbDb0LlB4Fg/cKaueM
	d/8QetUGI5hSxz5HVtcWpf3CjyuEQwQAtq7jj0IrTURtrWqNAyNu3b5jvtAajRjQKF5Dk75Z8PW
	4r/D1+ZMT31SoEJzzm71bkb+VF18rxSuruT2v
X-Google-Smtp-Source: AGHT+IEFMiDR4T+Az5QhHWjBGq7ivQjiq8VZP7xtdBES4S/LvDRFYd/o733yPgW6mWJ0oHxcB5Iolmk0/4LYRKcEnzI=
X-Received: by 2002:a05:600c:c12:b0:40d:839b:7844 with SMTP id
 fm18-20020a05600c0c1200b0040d839b7844mr14670wmb.6.1706554809639; Mon, 29 Jan
 2024 11:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129175033.work.813-kees@kernel.org> <20240129180046.3774731-1-keescook@chromium.org>
In-Reply-To: <20240129180046.3774731-1-keescook@chromium.org>
From: Fangrui Song <maskray@google.com>
Date: Mon, 29 Jan 2024 10:59:55 -0800
Message-ID: <CAFP8O3LhmXqqKKf1fOw1_0zGYOyN7ivm2yYSQJqSQr_megOq8Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] ubsan: Use Clang's -fsanitize-trap=undefined option
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Andrey Konovalov <andreyknvl@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:00=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> Clang changed the way it enables UBSan trapping mode. Update the Makefile
> logic to discover it.
>
> Suggested-by: Fangrui Song <maskray@google.com>
> Link: https://lore.kernel.org/lkml/CAFP8O3JivZh+AAV7N90Nk7U2BHRNST6MRP0zH=
tfQ-Vj0m4+pDA@mail.gmail.com/
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/Makefile.ubsan | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 4749865c1b2c..7cf42231042b 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -10,6 +10,6 @@ ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)         +=3D -fsa=
nitize=3Dinteger-divide-by-zero
>  ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)       +=3D -fsanitize=3Dunreach=
able
>  ubsan-cflags-$(CONFIG_UBSAN_BOOL)              +=3D -fsanitize=3Dbool
>  ubsan-cflags-$(CONFIG_UBSAN_ENUM)              +=3D -fsanitize=3Denum
> -ubsan-cflags-$(CONFIG_UBSAN_TRAP)              +=3D -fsanitize-undefined=
-trap-on-error
> +ubsan-cflags-$(CONFIG_UBSAN_TRAP)              +=3D $(call cc-option,-fs=
anitize-trap=3Dundefined,-fsanitize-undefined-trap-on-error)
>
>  export CFLAGS_UBSAN :=3D $(ubsan-cflags-y)
> --
> 2.34.1

Thanks for the patch. Clang has had -fsanitize-trap=3D since 2015.
GCC added -fsanitize-trap=3Dundefined in 2022
(https://gcc.gnu.org/git/gitweb.cgi?p=3Dgcc.git;h=3D2c7cfc7b418564 ;
milestone: 13.1), so we cannot use -fsanitize-trap=3Dundefined
unconditionally.

Reviewed-by: Fangrui Song <maskray@google.com>




--
=E5=AE=8B=E6=96=B9=E7=9D=BF


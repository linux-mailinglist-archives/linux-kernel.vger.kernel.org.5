Return-Path: <linux-kernel+bounces-45602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728FB8432E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD99283F43
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6921C10;
	Wed, 31 Jan 2024 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORPIN/01"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77A1847;
	Wed, 31 Jan 2024 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665291; cv=none; b=L7IZna9ouPCDRikdZvYW8Ce5H0YdHEhk8CqZghKzeCa8uDnqPdB/kh3Lqe0f+dnM2vZSwfI9MF5vYAzV+j0R5C8/S+gahUIHBlM+kVc2HTF1QoeHQpcndfhKrOEkflGgrGf5OhvKXeIwOSbg1Y7ebQyzQSV55/UtODPXIRb170Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665291; c=relaxed/simple;
	bh=s2q/XP1WetLeroFk3R7W7uZsANPWW7LyR1MeMbcuRMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7hCcNU8cW7/kO99E/hLstYXi/poSuY9zDtJkoDLSF70DNw1CvrV5NZkHst2PstuRjm480VrYZmCJucWrXmxVjs6ZzhXWeyyxennQ6dcIXPyu+JcbsqzgJfVQqUqUDbW7GMjJU+hmgy6Pax0K/lzMKYMR6RFI4s7qr+lMg816f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORPIN/01; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40faff092a2so6961095e9.2;
        Tue, 30 Jan 2024 17:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706665288; x=1707270088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEaTVDXL37CSW2vPa/3HTeNYNfZ2XgwdCI+3Zyh7Jz8=;
        b=ORPIN/01nHTqVF4me14O3+iu6hGDhZF9Cj9kurnkLcYFdvizeabSCitA7DR/7FDCuz
         DF1kUJay2G9J/NEmof1T/nhbANq9ziM2De8FyohVwruu+eZKbtA/AjnkPlDohGi4W4tJ
         JKw4PEpSX2cxyInpKN0acDDiGg6LErKuCXTLcF1iYq5NKGeeiPXlXPRFUrvOGjosKYi5
         G/H6okXNGu+Py6NyMjCmPhCOb0L4V4FSu6mEwoHUa0n8HSe6f7xlZzPf9fRB38A9HHDS
         Rm5K9K2g+5g/o3Esgsqo5VIsNnscDktpp0JHnNH0BNOOpzHMo6zrGfjhvEFFa2NDmAo+
         5b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706665288; x=1707270088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEaTVDXL37CSW2vPa/3HTeNYNfZ2XgwdCI+3Zyh7Jz8=;
        b=p0uxcz38esoxnPGZ8SypnDD89uah4ybORhYPjlb/rHAx8nX9ilSw0hrhp/PkCt9u0L
         QHaTJk+xHR3ZaUTMlrkNq5fhYNWC06+IOhFnQmXDTZ4KaGlNZMKzULqFJpNc9wAkov84
         Cnb5ewMsr/onDUbJRcAwdDMR4w2DKoYXowgg6HTYbqUJ99poJJHQN0RxO1MIOidxWnbw
         2GbV8zD4KP0JGvd/jUubrWzKv0Lop8GJHonob7VXrTU8BDnYX1xI2jB1SgnmhLBPA8gf
         LF6f+wmUn/du0poJgirUtIhK+sfaNhVTpRElJ/2alcl/uejH5CdSdHpk9ESWG8EItpyj
         AY3Q==
X-Gm-Message-State: AOJu0YzBaqaLldHkVXl7He9UhznGaUM49rQ2EMhMCoEttfS/IR4/RCsz
	SY40l2Mr/xEBXESeCD0KZYHPeBL0YcoNUZAK+auhevfqIt8/1A3fwSwpz7TcKhgTiVwWXdTPdKe
	kbL50JhxZhlekIBrLQTwgiP5iAS0=
X-Google-Smtp-Source: AGHT+IFqEKhqxzLHUDw5MyG5vVUB0SUnbAgCc7NBuVfyINugPI68SgxmQT0sctcO//au6cYZFgsyDPOaY0eVHxMk7eA=
X-Received: by 2002:a05:600c:1c9b:b0:40e:f702:a304 with SMTP id
 k27-20020a05600c1c9b00b0040ef702a304mr137855wms.32.1706665287518; Tue, 30 Jan
 2024 17:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130234634.work.003-kees@kernel.org>
In-Reply-To: <20240130234634.work.003-kees@kernel.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 31 Jan 2024 02:41:16 +0100
Message-ID: <CA+fCnZeDWQsd8xJdDhZbZBuyUaS6_WkFgZo5B4Pfjtkom_w1QQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add UBSAN section
To: Kees Cook <keescook@chromium.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Marco Elver <elver@google.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:46=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> The kernel hardening efforts have continued to depend more and more
> heavily on UBSAN, so make an actual MAINTAINERS entry for it.
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Hi! I figured since I've been carrying UBSAN changes more and more lately=
,
> I would just make an actual entry in MAINTAINERS. Are you all interested
> in being listed as reviewers? Or would you want to be M: instead?
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..19b8802b2f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22471,6 +22471,22 @@ F:     Documentation/block/ublk.rst
>  F:     drivers/block/ublk_drv.c
>  F:     include/uapi/linux/ublk_cmd.h
>
> +UBSAN
> +M:     Kees Cook <keescook@chromium.org>
> +R:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
> +R:     Marco Elver <elver@google.com>
> +R:     Andrey Konovalov <andreyknvl@gmail.com>
> +L:     linux-hardening@vger.kernel.org
> +S:     Supported
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git =
for-next/hardening
> +F:     Documentation/dev-tools/ubsan.rst
> +F:     include/linux/ubsan.h
> +F:     lib/Kconfig.ubsan
> +F:     lib/test_ubsan.c
> +F:     lib/ubsan.c
> +F:     scripts/Makefile.ubsan
> +K:     \bARCH_HAS_UBSAN\b
> +
>  UCLINUX (M68KNOMMU AND COLDFIRE)
>  M:     Greg Ungerer <gerg@linux-m68k.org>
>  L:     linux-m68k@lists.linux-m68k.org
> --
> 2.34.1
>

Hi Kees,

Perhaps, it also makes sense to add the kasan-dev@googlegroups.com
list. It's used for all other Sanitizers.

Otherwise, looks good to me:

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!


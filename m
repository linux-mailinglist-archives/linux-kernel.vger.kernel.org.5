Return-Path: <linux-kernel+bounces-153720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0CB8AD20E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463F91F219FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76191155307;
	Mon, 22 Apr 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO6Xenic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C922097;
	Mon, 22 Apr 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803890; cv=none; b=ebrrfXyp4vmo5mYVOVC9hot1kxqRhJ6USkqhjZjyo6xB2UNfTdb1OL/5sgBkTC+nA2BNrGnpgP4J+p5IiU2457PskE3aX4SvIy4K36WlVh1SqvVrEJGGE6re9wS5Mps4RYPnqd8otOy/1Bb2nZ81bzLQmAuN/vs6jueN9UrHV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803890; c=relaxed/simple;
	bh=ssx5UDjpCxTUBJ2Pn9JTZgLzwtkb9G1ovSgmjLI78xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoGT8UpO0JiuRky/27Y+TKRgsV5pEAgCQWUAEWRCISEs7EFHbnvHuFSicv5burUCvGOYgt7ZkPC8aNeYymuZmZ96/WnVeAzwe4y6/QPHDqOMAfztTRRTrWYIRtkzwVGHKZqeu2vqFZ9aodUNYZnvfIGB3zLa9H/pVB52vaebzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO6Xenic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8988BC116B1;
	Mon, 22 Apr 2024 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713803890;
	bh=ssx5UDjpCxTUBJ2Pn9JTZgLzwtkb9G1ovSgmjLI78xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kO6XenicmHo5BivlXeEdq297G1T1xnH5iOaEUWTxPzsZ2gWEjCqsgChyO39mUSK4s
	 gMngxAYh0KedEj49YHxnQRkPeK1JGBfrdaTaanokFfM1uyqal5PYaVtK94XydN4Vjt
	 AgDy4qA6PY1aFJMImVQ9U+Wey9yfmswDVazogfpXTyD68OZoinxSh9KklypQXFLuuF
	 1u+gZ+el4Mv6onhnpBeDT32zqi8Lp+fa9meSiphXDrC9EqAF1D0281+mM+jrLhP1d5
	 ZTwHc5CJzIbSPU9FPyutLViml0BKoouytfnaFqCc9tohUS+kxgFf31f2itATLAn9I5
	 OqzbAfsCu/HNA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5acf5723325so1087540eaf.0;
        Mon, 22 Apr 2024 09:38:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRUligxYJA7RooF+NHGzkvbYG6UmbthaSuMjbNGVq0Fzjqxi70wvS2x2T8vPsRbtjivLuG7XGu7HvfPLxQgQrMpvabxegmkGPMI9PT4XIqshhP65ZmqmcN04U6kzTtvjJOlROBKTw9nQ==
X-Gm-Message-State: AOJu0YxUYHILUyMyrsm2lunrGiV+fg23iQi0nGclOMwDNNvAKiN2iJrB
	kHb1meNR+KbgkHZsR7pRIs9hM2SSlNc7rTCjd1eI3tHs7RLNGommINpcJETpL+tn6Py+CfJEEeM
	cLBY2P0rWz4DUXAc9eAA8oy/+oEo=
X-Google-Smtp-Source: AGHT+IEE6hp65ZJsRNlLkywyfmRwFbUtU8Rw0UFlOCmqaTRtVPXQSuICvrsJSRiBNh6xTDKa0IGmRp6vGGPSYRYTUOo=
X-Received: by 2002:a4a:de19:0:b0:5a7:db56:915c with SMTP id
 y25-20020a4ade19000000b005a7db56915cmr11906608oot.1.1713803889882; Mon, 22
 Apr 2024 09:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:37:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqt6+1AvDWb0BYw0z9burVQfdkOF1qUGzRRuPmvq4qQg@mail.gmail.com>
Message-ID: <CAJZ5v0hqt6+1AvDWb0BYw0z9burVQfdkOF1qUGzRRuPmvq4qQg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Declare acpi_blacklisted() only if CONFIG_X86 is enabled
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 8:33=E2=80=AFAM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> The function acpi_blacklisted() is defined only when CONFIG_X86 is
> enabled. So to keep it consistent, protect its declaration with
> CONFIG_X86.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>  include/linux/acpi.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..3ad6bed9eb4f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -421,7 +421,9 @@ extern char *wmi_get_acpi_device_uid(const char *guid=
);
>
>  extern char acpi_video_backlight_string[];
>  extern long acpi_is_video_device(acpi_handle handle);
> +#ifdef CONFIG_X86
>  extern int acpi_blacklisted(void);
> +#endif
>  extern void acpi_osi_setup(char *str);
>  extern bool acpi_osi_is_win8(void);
>
> --

Applied (as 6.10 material), but it looks to me like this declaration
could be moved away from this header file at all, as the function is
only used in one place in arch-x86 code.

Thanks!


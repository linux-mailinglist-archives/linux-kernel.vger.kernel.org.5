Return-Path: <linux-kernel+bounces-52653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B4849AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8DE1F255BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79CE24B4A;
	Mon,  5 Feb 2024 12:47:25 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5B48787;
	Mon,  5 Feb 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137245; cv=none; b=CmvW7c+Wx0z1KcAw96A8CnpMAwSEfwzOiZ5PKguaP4zDm1NqWbcj0Ibd7BAu2rtShVFaJZf6zVe5YgsiQLR5PVkdezFkDsjSExluIiFAnpyhyE3HXdw+CdvdnxznqTDiV60TmHbYmForQ7fR06BIGBcoChrAGYUEruYR9YRLZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137245; c=relaxed/simple;
	bh=v1KF4ZicArZ15k+k1CVSoy4y3ifGY0KbGb6jOYXQVMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3/6t0RCki1hjV0H2Bek4NRM3mmvo9NQesmuBbLh+iUdFMyDEWvy0kd1XKaZ9/AoISZsdf4xXIjvxKPZiYy3G3r2os0hGWlMKTKAdYjQEHdCee4vey+L9Cm7xAb4UqK/W/06WNTaBfjjk0gb4WMqPFFbBuw/l6eitKwZvpjH0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-604123a7499so42705017b3.3;
        Mon, 05 Feb 2024 04:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137241; x=1707742041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ4uShXGXfh9Kf8BCJj+oy4yCIeGo5AwZyFiWoh8Epg=;
        b=ZCqxohf1ZbVe6vGmQFtm7XzA+4BYC5cbggFw8u0cKO0h0f+FvjLsYhG6VsFGO13ifS
         ddOzHyhtQ+1Clv8ocKHy0I/lWowG0SyRn6tavR0AXmQXCymXmw5hUgDLDXoyfsKvyekL
         yPR/NktKw64qJa7iOC7jOEuhmddbbpGX2j0e5UK52kvTU7GPlSw7jXTyenk6qdRBukfz
         i5CvlH1t7I5sA7aS9bW73hLciemtfH9RPN7a7RSD+Jld5Bi+93npK0uPL5TNHW57Z8FG
         Ol5P4Am68MFiKHsGNvx2VfDCBccDMIF0yh23JFHhOxOSyduZENnV3aspNJMcvmxOP0M2
         +rHA==
X-Gm-Message-State: AOJu0YxgzN1NyqW0jPcK8WP1InJKBqc4uxK75LjMiT281gpsoi2Hnriw
	qZzf0iWkuyzgfW1C2DciZp5LIJoS/Z7aNqMiSeAh2R9SSZI9f9Xoe/JG4PrFEDA=
X-Google-Smtp-Source: AGHT+IG7bcqBvnRBRUNTQqbZOEcfJkjmkgAdym9e35FAxr0U0k1uXFLrf69JceNY7bn5P+n9V89qHA==
X-Received: by 2002:a81:8341:0:b0:604:4f5:f258 with SMTP id t62-20020a818341000000b0060404f5f258mr10286700ywf.25.1707137241009;
        Mon, 05 Feb 2024 04:47:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW0wQk/gcGGsuafSRLCI9YatI3qSmcR+WtgMF9dp2KUs3Hq7rruuXd8NFRiX+LjHisPJnPqeHBjeZyAxd3f7AvIC/JsgERpHU9B9aWR2KBeiQwqtHkW92H4G4mJzX9qVsb529ZTOucMJofkukM9
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id fu10-20020a05690c368a00b005ffa141d9f4sm1907577ywb.18.2024.02.05.04.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:47:20 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6f6d10ea9so2415822276.2;
        Mon, 05 Feb 2024 04:47:20 -0800 (PST)
X-Received: by 2002:a05:6902:547:b0:dc6:c6b1:b10c with SMTP id
 z7-20020a056902054700b00dc6c6b1b10cmr8530106ybs.45.1707137240297; Mon, 05 Feb
 2024 04:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-2-keescook@chromium.org>
In-Reply-To: <20240205123525.1379299-2-keescook@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 13:47:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
Message-ID: <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] string: Allow 2-argument strscpy()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Mon, Feb 5, 2024 at 1:37=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> Using sizeof(dst) for the "size" argument in strscpy() is the
> overwhelmingly common case. Instead of requiring this everywhere, allow a
> 2-argument version to be used that will use the sizeof() internally. Ther=
e
> are other functions in the kernel with optional arguments[1], so this
> isn't unprecedented, and improves readability. Update and relocate the
> kern-doc for strscpy() too.
>
> Adjust ARCH=3Dum build to notice the changed export name, as it doesn't
> do full header includes for the string helpers.
>
> This could additionally let us save a few hundred lines of code:
>  1177 files changed, 2455 insertions(+), 3026 deletions(-)
> with a treewide cleanup using Coccinelle:
>
> @needless_arg@
> expression DST, SRC;
> @@
>
>         strscpy(DST, SRC
> -, sizeof(DST)
>         )
>
> Link: https://elixir.bootlin.com/linux/v6.7/source/include/linux/pci.h#L1=
517 [1]
> Reviewed-by: Justin Stitt <justinstitt@google.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/include/linux/string.h
> +++ b/include/linux/string.h

> +/*
> + * The 2 argument style can only be used when dst is an array with a
> + * known size.
> + */
> +#define __strscpy0(dst, src, ...)      \
> +       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> +#define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)

(dst), (src), (size) etc.


> +
> +/**
> + * strscpy - Copy a C-string into a sized buffer
> + * @dst: Where to copy the string to
> + * @src: Where to copy the string from
> + * @...: Size of destination buffer (optional)
> + *
> + * Copy the source string @src, or as much of it as fits, into the
> + * destination @dst buffer. The behavior is undefined if the string
> + * buffers overlap. The destination @dst buffer is always NUL terminated=
,
> + * unless it's zero-sized.
> + *
> + * The size argument @... is only required when @dst is not an array, or
> + * when the copy needs to be smaller than sizeof(@dst).
> + *
> + * Preferred to strncpy() since it always returns a valid string, and
> + * doesn't unnecessarily force the tail of the destination buffer to be
> + * zero padded. If padding is desired please use strscpy_pad().
> + *
> + * Returns the number of characters copied in @dst (not including the
> + * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
> + * truncated.
> + */
> +#define strscpy(dst, src, ...) \
> +       CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_AR=
GS__)

Likewise

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


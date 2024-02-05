Return-Path: <linux-kernel+bounces-52657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F3849B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68341C210C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48F1CAAB;
	Mon,  5 Feb 2024 12:50:32 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5E1CA89;
	Mon,  5 Feb 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137432; cv=none; b=PkrGN+jveWfO++QUNl3HE6aaMjOdZ0NAHnG21DoFmdeYPpUp+GHuu2O8B35zzt5pzzayG6yfoUGXHY+5fz1SDiUGmeUaekKPE/5G4+3EuXH45kdvMiVbxAchsPlsn3+7E3LWShP6HrTxRABEkofhyyDiKMCzVoO2TC7kBfLgMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137432; c=relaxed/simple;
	bh=hLZGntYcVISpE2zLtXc1B9aqkcHgRJES4wU+pnDSbxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n42K2CHZwepvA/acb+BSIqBQJ83G+dnpvbBsWZ32kd1iqNOLmkngWdUbgMM6K6V3YaA6+Z2JUpGr5KbwTpc8uHo3ElQ4xu4Yju9pvXqIRwFgWnDqRAJxj05jfiyAPZDpInoXMAXr2Sy54ooOHZqx+h+LsKh81muqbC8TFbH/6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60403c28ff6so48665637b3.1;
        Mon, 05 Feb 2024 04:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137427; x=1707742227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U77xr3ZrDFcspY+RoHrYoDiB+2qyXayQOG7MFvZlIZo=;
        b=xCp16zNgYbv8J2kLUm0/5n8m9XXBFbluRzLGZyJkYWKZYFaqLsXZhnWmm4Wk8wQpzR
         xNsOHrodYC9nN9XLyEXqIAK9xWMl+eMr/JuI+epQbRlivRGY/AugXE6/nppl88pQVX9p
         vgGgbKVxcvf0Z7u2d3F/2bN44wp+nUc1xXom0z2pZzX3Zgj9uwGty9uQv056z+jlSiKD
         qete0AUtT3tHjq1y7kqezALG2pnn23R+TNLrFiG68SesWbQzzp25ixOpZMDU/IsURF3R
         5aC0Ys5lOvoZxwYQ15FqcL9egwisE3e+ctDwngoBDgctAvzUmAcaIJjqKMj+oB4z+mwl
         hgQw==
X-Gm-Message-State: AOJu0YxwdVz1UkSQ1X4KUD0o0TKJ/ZM2hHvAA93idSgATUP11TZ0W+Lr
	cZOPJhymKtHjCWbWrqCf4bFyjmrmDYCZr09nrDpvP9FpGxqhjlzzVdgdSFWP0cU=
X-Google-Smtp-Source: AGHT+IFKH6m4lbbUsxSnqYSI2hudjFwUfFDhhJsqkno+e0xLdH6ejw8JV/wEuJaGBpOBWlD7mHOTWg==
X-Received: by 2002:a81:9851:0:b0:604:9bf:45c1 with SMTP id p78-20020a819851000000b0060409bf45c1mr15819241ywg.8.1707137427335;
        Mon, 05 Feb 2024 04:50:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJx8ujAiiQyQqwkDHeAUQBCKYNIE2z/n0bOUzEkrV76KmJgp0eRbtcLt30Kp96bRsFPAl7RHDqAZ/FZ/U76s9zzYekmqwh3jbpsKTD4t+qqGTWTzv9vnGwqMStnBbhOI+cRY2yre6ntZqMlfIe
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id fv8-20020a05690c370800b006046471cff8sm354555ywb.79.2024.02.05.04.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:50:26 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6002317a427so37563017b3.2;
        Mon, 05 Feb 2024 04:50:26 -0800 (PST)
X-Received: by 2002:a05:6902:34e:b0:dc6:b9f4:a4c2 with SMTP id
 e14-20020a056902034e00b00dc6b9f4a4c2mr14515950ybs.57.1707137426212; Mon, 05
 Feb 2024 04:50:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-4-keescook@chromium.org>
In-Reply-To: <20240205123525.1379299-4-keescook@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 13:50:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWOKEYvGKRUmii5CqtaM-RAM_4SZC5gds=00+KUYyu+MA@mail.gmail.com>
Message-ID: <CAMuHMdWOKEYvGKRUmii5CqtaM-RAM_4SZC5gds=00+KUYyu+MA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] um: Convert strscpy() usage to 2-argument style
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, 
	Justin Stitt <justinstitt@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Mon, Feb 5, 2024 at 1:36=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> The ARCH=3Dum build has its own idea about strscpy()'s definition. Adjust
> the callers to remove the redundant sizeof() arguments ahead of treewide
> changes, since it needs a manual adjustment for the newly named
> sized_strscpy() export.
>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-um@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/arch/um/include/shared/user.h
> +++ b/arch/um/include/shared/user.h
> @@ -52,7 +52,7 @@ static inline int printk(const char *fmt, ...)
>  extern int in_aton(char *str);
>  extern size_t strlcat(char *, const char *, size_t);
>  extern size_t sized_strscpy(char *, const char *, size_t);
> -#define strscpy(dst, src, size)        sized_strscpy(dst, src, size)
> +#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))

(dst), (src)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


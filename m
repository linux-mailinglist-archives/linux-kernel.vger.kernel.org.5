Return-Path: <linux-kernel+bounces-84639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD786A95D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488D51F28958
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1925621;
	Wed, 28 Feb 2024 07:58:20 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC725601;
	Wed, 28 Feb 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107100; cv=none; b=EI7DTSTpTnlSQhFnqCfinDRBFvGaH79IRoeLTsemT/N7aKJH1RkuFSD5PjmGDuodOgKPMdn7Lxh2fwO60AiFz/ECbYIglgSJPHkA3UE5BAclFkwnyoLHvjDwwBYsD/h5f4aLK2oco5PpCGGtIaURMt6f3yWv6mvtANxxdoLQzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107100; c=relaxed/simple;
	bh=trymZ7YQNfoxgQzjdvi4FBNN10bDU2cFwmLnp4I3YnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnqXXClQH56xSeue+STQcafTKU5LL4PLxB1Aq8D+3KJeUQPIZKQ5+N7tGQSxZUCnpgLediYoQoVU6L6eSib+u3NZgoTfxBhhGgtXEp3oKKqOw+BFwxq71Nei2a/BG0ws0cCm207mHJY8+KKaAOGMfv2Qu9Yh6+3vHVMUg4lgadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so5296354276.2;
        Tue, 27 Feb 2024 23:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107096; x=1709711896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsKMJK12uTn8rSKE4dhgJsLuGznZe3oJnJWzo8HLoJA=;
        b=LnAHl/kKGsdiCzXQNOavXeyjrwEs+nAOMzpSWT5Mg6oNdPKBsFjNnIigDS2MQB2UP9
         7CsoSpEkWmuXwKe0xLhfu9mGTu7uznuDMpBYBHoS5xKxFBt3B7OZFtSwDCujXTucxpJq
         JEMCn7ilBBOwoK3+y16R7ocDiPJu+0SvSMGXiVXkjiS4+kyW+cH+6DrXVXA0bJJX7ORJ
         nPPetvDlLQXGWsZkj83mMgULE+omwD/EtmAcwxkYT0jv0NmtoCYTtKZwp4wa9rABzqG7
         ILb9yVqBRF9zxVLnt+E3DEnqZEAIBkh0R+ud1fL5dA6eB782lSlNVCNJcKddjzdBS2Ys
         UOXA==
X-Forwarded-Encrypted: i=1; AJvYcCXgENUK0+wMeh6PsS1ENA24N7cPyYSDZYOi8RYzpG9I9xZqHeW+x1OcvoNYty2Ad9ht8rGBUZ4oUzIiFWzfweQ5d9j9kVXPy5dbqZNoMcZ9OSor/WsRRgNLDxqB+/4V5QtoLBtp5O5yMx8As+na
X-Gm-Message-State: AOJu0YxDf8B+6VouX+AzxTZXz2zQ1y3NphqkhJildI34+jJltRcJCYmJ
	l08EG+BofnJGSrUNak34E/vAcGvT8hJ1Vb6cJPERKL0shTrLKHNgU84XE/njaeTlww==
X-Google-Smtp-Source: AGHT+IH8LGJvHXvyjQkPJVRzBEFNdKxQuC8ac+hjllyf/NUu/GdjH4io5hAfsRKpFAShx5r2dTtV6w==
X-Received: by 2002:a05:6902:4cc:b0:dc6:9daf:35c7 with SMTP id v12-20020a05690204cc00b00dc69daf35c7mr1645671ybs.28.1709107096489;
        Tue, 27 Feb 2024 23:58:16 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id y14-20020a25860e000000b00dcdac51bad9sm1798102ybk.49.2024.02.27.23.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:58:15 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso5423695276.3;
        Tue, 27 Feb 2024 23:58:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPK4RkC5mUxPA3US4vgOoSzEn4dRj3PEnuEC4r8iwDvxVUyZUToaSzGmXny1QkBAsBN5uh6CIBDTS688/6pR3vZtfN3U3+Wm1SCqn+m/4XY9uLBQzzemzZqrC2oSS2u5Ov/sRu0mzmCheADVrL
X-Received: by 2002:a25:aaee:0:b0:dcd:407d:52e5 with SMTP id
 t101-20020a25aaee000000b00dcd407d52e5mr1799682ybi.29.1709107095484; Tue, 27
 Feb 2024 23:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227224653.work.603-kees@kernel.org>
In-Reply-To: <20240227224653.work.603-kees@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 08:58:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVMsbVPmcztWCDaorLSvwtLfWz-QVuA=vLFfX_iTdARcA@mail.gmail.com>
Message-ID: <CAMuHMdVMsbVPmcztWCDaorLSvwtLfWz-QVuA=vLFfX_iTdARcA@mail.gmail.com>
Subject: Re: [PATCH] lib: stackinit: Adjust target string to 8 bytes for m68k
To: Kees Cook <keescook@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Tue, Feb 27, 2024 at 11:47=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
> For reasons I cannot understand, m68k moves the start of the stack frame
> for consecutive calls to the same function if the function's test
> variable is larger than 8 bytes. This was only happening for the char
> array test (obviously), so adjust the length of the string for m68k
> only. I want the array size to be longer than "unsigned long" for every
> given architecture, so the other remain unchanged.
>
> Additionally adjust the error message to be a bit more clear about
> what's happened, and move the KUNIT check outside of the consecutive
> calls to minimize what happens between them.

Thanks for your patch!

> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65=
@roeck-us.net/

Do reports have an expiration date? ;-)
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/r/CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFY=
AL4TzvstFg@mail.gmail.com
Closes: https://lore.kernel.org/r/CAMuHMdW6N40+0gGQ+LSrN64Mo4A0-ELAm0pR3gWQ=
0mNanyBuUQ@mail.gmail.com

> Signed-off-by: Kees Cook <keescook@chromium.org>

Finally all parts of this test are passing on m68k, great!
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

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


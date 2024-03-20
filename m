Return-Path: <linux-kernel+bounces-108738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B16880F63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC22B2231A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7B73D0A3;
	Wed, 20 Mar 2024 10:12:27 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3253BB55;
	Wed, 20 Mar 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929546; cv=none; b=f02O683vYPNx0BEFBpTJ1gYBE33C3ZC4FN3+MCfGkGJaEfx/6xfFMBYdWC90TZgLhMPDKx9UTbmUoalLst6r4NAkmrPj86PRpz6chnoM0fncP0PBZkmBmNhd4qMT7543x9ofDWOko2f+XUbFVxRaD10MmPDjlY2Cq86EmZPTlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929546; c=relaxed/simple;
	bh=VcS92yfIZWQiU6DLOdkW1GLNdpstssB+lwJUNBrM/Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueuuHGcNmzjGH4A+hiSMPc3aQM13K92U/swP2RUx2MVwwK7sr4nNTy2aqNqiGNgbjX8Uz8RYTwXukEpySle+WcyLyqTnq5S9VtyB6CDkYtLrQPeSQbW5MiAWE5123Nx678yTXLCf0J9XHNEkLODIpmjyEHGCWB9tzGWCRIIa+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so6426013276.2;
        Wed, 20 Mar 2024 03:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929543; x=1711534343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/TVf8JbKlIsPFjDw8k2PXMgINwKJNNEI5WzM7hT5rA=;
        b=FG7u8esl3RT/IqhJybPFp0XFKyPtq+wo42Tr8543I/ZDnIVmnEdJxXD/eiBkUG8w41
         U7LKC55ybO9qKAN6VOAh263NUvX+Gmc9X2pc5rif7+BoPjZE5JZZnXXMUiXhuzgRdLO/
         5CKW+TtrTQmBO9ZlUL5Z3OqSsQeSvykVnVN3o4YNuxqcrWsjaC8ZpKt2QBC7P7YqXRUn
         p6EOdBvpQROZ2cTHvXLHGqdZfxaTFQYvFSkV7VpnURi3uBVYapqKA9XlgPoldjP7OfEl
         cf5BnRAhTCKOKMShFObpO8ILS+KZSIhxuPmIUo0fgJlSy/oKHHI/gBW2QBM+UEqXMTkr
         DFJg==
X-Forwarded-Encrypted: i=1; AJvYcCVRR69SYaCII7CTeILeQA+J6iSB4jjTZ6HTFNyBEoFzJDdx9nhKcubEDuQnY17KbOUq3+j8iu7T2XLT4i0rt+G6wfDbnK5Smb9VhGHLL8G8vWFdjI3Ft6CqK9wChBrq4ZMHN6NKcwZUSF5Og2B2M7MCXMRgdWXWKEL/+3FnNKiXXQVLssVI4cQfbVKv
X-Gm-Message-State: AOJu0Yw5fknkqOsC4VN1p2oHkXiSlBUJG2vyTo+EC2n4n9Mp2e5r2+8q
	nuDLrDzIzghFwe7wUlcK+808LZCutqqsMxdvxr1JBwIkvU46eSWm7YpxCZS9Ww0=
X-Google-Smtp-Source: AGHT+IGDyqV6z8Btd/sBdbDVtqlZH3oNJi7wduUdeaBUxHuMuPKXmi+/ygWqHjKIfakg3l2NdMIGQA==
X-Received: by 2002:a25:a302:0:b0:dcf:9018:67 with SMTP id d2-20020a25a302000000b00dcf90180067mr15403461ybi.42.1710929543138;
        Wed, 20 Mar 2024 03:12:23 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id y23-20020a25ad17000000b00dcd56356c80sm1995205ybi.47.2024.03.20.03.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:12:22 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6098a20ab22so60283217b3.2;
        Wed, 20 Mar 2024 03:12:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV46WZA4FYEZedJAg3GbqF8utOFcThzGNw5mNB30Tai0XljU9sWZ342PiRsrwZxi3hBKc/gmzmwVdPnSw4wTQp3KiUCGN+63BADIz2xOykHp/Rzi0J6ZcM5TCYk8B2r/+MH+lIDwvLoCGhT6VoKZqzIObEFuWvb8IPI06PmRqlYCeOhyhkWQVFMnDO2
X-Received: by 2002:a81:dd06:0:b0:610:bc71:43ab with SMTP id
 e6-20020a81dd06000000b00610bc7143abmr9487139ywn.44.1710929542478; Wed, 20 Mar
 2024 03:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318143149.2468349-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240318143149.2468349-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 11:12:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwK6CRZyRMuS1mw7EXEb-fqtWOAdG6HmX-v+HTvhPV5g@mail.gmail.com>
Message-ID: <CAMuHMdVwK6CRZyRMuS1mw7EXEb-fqtWOAdG6HmX-v+HTvhPV5g@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: rzg2l: Execute atomically the
 interrupt configuration
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 3:31=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Lockdep detects a possible deadlock as listed below. This is because it
> detects the IA55 interrupt controller .irq_eoi() API is called from
> interrupt context while configuration-specific API (e.g., .irq_enable())
> could be called from process context on resume path (by calling
> rzg2l_gpio_irq_restore()). To avoid this, protect the call of
> rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestore()=
.
> With this the same approach that is available in __setup_irq() is mimicke=
d
> to pinctrl IRQ resume function.
>
> Below is the lockdep report:

[...]

> Fixes: 254203f9a94c ("pinctrl: renesas: rzg2l: Add suspend/resume support=
")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - used raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore()

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.10.

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


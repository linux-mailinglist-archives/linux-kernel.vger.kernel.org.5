Return-Path: <linux-kernel+bounces-44364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CDC8420EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DFA1C265FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD1657C0;
	Tue, 30 Jan 2024 10:14:25 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B4657BC;
	Tue, 30 Jan 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609660; cv=none; b=SF9T2TVmkhxptDrfQ3uKynl1/uzStpSXkQ4OoeAE2mu5yUaWcqG9qW4xaCoT+o8yZdzckYyuDD9ebByXlB0NZd4K0yScz30u8CES/3MiuoYT8j2glBsDU3wa9kLvzZ4lhgIrTAtHrEqFDgd1mnvHTdnz4b03AAvdlpsy8duJ//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609660; c=relaxed/simple;
	bh=0p+Z1IAS+0bfXxsX6EFfFq3pCuHgzmTrGO2D1IR92ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csgFSj162DpQAhvzkvgzVG3dGUjFbyD5ScB01lXF1qsNw4V/S83O2WUco/7TJNSLujPS7mw/GA07EMx1g1hh7rO9kDGjDIHkIp33xQ2ehjciJz1LsNOnWJwIWahyVczSA13YEkVnPLu5A9ElhhCuLWnyEcm6uPG5ncp08qniSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6933a46efso1378983276.0;
        Tue, 30 Jan 2024 02:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609657; x=1707214457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Gu3jMAydPMH9OZkWS6/YdPAkAQjZBus+ODe9FhclmQ=;
        b=fZhqieVrNh2i0lP/DStBqU66LNd2b4y2K5tTXKbLZT2xXek3eHEh5sklGNsx8B4B0S
         JmhEM5aOpPf5xu56zJcQetBnWW8C3H2KTpteaNMEagoYiCET5/jm1Q9QMTRTdh4+52rf
         cRkD3TTOAPBhF4BagKcE5OePRQz8QyKgpKuxX9A3ngfyuWACutemvuHfRBFIGdkaHilK
         OWj6SqJHnM0/gBmJrUstNpFuEx671Svk0LbeFWl6n1DweK1mwlL5FXxT3igS3sK4MXkg
         ZJt1RA59Vu2bMmFOCF0ThELYp4I5XRHMPF3Xd2mY3lPFzgx91xWbYOSvACMhYkg9vnb9
         U/AQ==
X-Gm-Message-State: AOJu0YxrlRRsunCOhkFzzJ/YxKdQpNvfaV8gYs3Yszz8j/Tk5jQv1eHi
	57hRsKzxU6zl4NmgvmWRzAOUacmE3Mgzjm1DIBdWgwJ9+1Y4lx96KLs0QgOoc8g=
X-Google-Smtp-Source: AGHT+IGSNmTk4D/LdXaDL3Mmn3DRGJPlr38+TPB+QJQhQ6UEqBv2yQahTrpvHStp2oLmUAST2Kuibg==
X-Received: by 2002:a25:f507:0:b0:dc2:66ab:4bc0 with SMTP id a7-20020a25f507000000b00dc266ab4bc0mr4075120ybe.36.1706609657230;
        Tue, 30 Jan 2024 02:14:17 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id y9-20020a2586c9000000b00dc228b22cd5sm2787044ybm.41.2024.01.30.02.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:14:17 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6001449a2beso26526747b3.3;
        Tue, 30 Jan 2024 02:14:17 -0800 (PST)
X-Received: by 2002:a0d:ead2:0:b0:5ff:82fc:9686 with SMTP id
 t201-20020a0dead2000000b005ff82fc9686mr5762820ywe.3.1706609656855; Tue, 30
 Jan 2024 02:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 11:14:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMeHCCiAkNyJMHTGUSTqewt=AWPUy+beA_kR26vcS8_Q@mail.gmail.com>
Message-ID: <CAMuHMdUMeHCCiAkNyJMHTGUSTqewt=AWPUy+beA_kR26vcS8_Q@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: avoid integer overflow in constants
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Jan 30, 2024 at 10:42=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> cppcheck rightfully warned:
>
>  drivers/spi/spi-sh-msiof.c:792:28: warning: Signed integer overflow for =
expression '7<<29'. [integerOverflow]
>  sh_msiof_write(p, SIFCTR, SIFCTR_TFWM_1 | SIFCTR_RFWM_1);
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -136,14 +136,14 @@ struct sh_msiof_spi_priv {
>
>  /* SIFCTR */
>  #define SIFCTR_TFWM_MASK       GENMASK(31, 29) /* Transmit FIFO Watermar=
k */
> -#define SIFCTR_TFWM_64         (0 << 29)       /*  Transfer Request when=
 64 empty stages */
> -#define SIFCTR_TFWM_32         (1 << 29)       /*  Transfer Request when=
 32 empty stages */
> -#define SIFCTR_TFWM_24         (2 << 29)       /*  Transfer Request when=
 24 empty stages */
> -#define SIFCTR_TFWM_16         (3 << 29)       /*  Transfer Request when=
 16 empty stages */
> -#define SIFCTR_TFWM_12         (4 << 29)       /*  Transfer Request when=
 12 empty stages */
> -#define SIFCTR_TFWM_8          (5 << 29)       /*  Transfer Request when=
 8 empty stages */
> -#define SIFCTR_TFWM_4          (6 << 29)       /*  Transfer Request when=
 4 empty stages */
> -#define SIFCTR_TFWM_1          (7 << 29)       /*  Transfer Request when=
 1 empty stage */
> +#define SIFCTR_TFWM_64         (0UL << 29)     /*  Transfer Request when=
 64 empty stages */
> +#define SIFCTR_TFWM_32         (1UL << 29)     /*  Transfer Request when=
 32 empty stages */
> +#define SIFCTR_TFWM_24         (2UL << 29)     /*  Transfer Request when=
 24 empty stages */
> +#define SIFCTR_TFWM_16         (3UL << 29)     /*  Transfer Request when=
 16 empty stages */
> +#define SIFCTR_TFWM_12         (4UL << 29)     /*  Transfer Request when=
 12 empty stages */
> +#define SIFCTR_TFWM_8          (5UL << 29)     /*  Transfer Request when=
 8 empty stages */
> +#define SIFCTR_TFWM_4          (6UL << 29)     /*  Transfer Request when=
 4 empty stages */
> +#define SIFCTR_TFWM_1          (7UL << 29)     /*  Transfer Request when=
 1 empty stage */
>  #define SIFCTR_TFUA_MASK       GENMASK(26, 20) /* Transmit FIFO Usable A=
rea */
>  #define SIFCTR_TFUA_SHIFT      20
>  #define SIFCTR_TFUA(i)         ((i) << SIFCTR_TFUA_SHIFT)

There is a similar issue with the SIFCTR_RFWM_* definitions below,
but these don't trigger, as no data is shifted into the sign bit.

What about unifying the individual SIFCTR_?FWM_[0-9]* definitions
into SIFCTR_xFWM_[0-9]* instead, and using the bitfield helpers in its
sole user?

-        sh_msiof_write(p, SIFCTR, SIFCTR_TFWM_1 | SIFCTR_RFWM_1);
+        sh_msiof_write(p, SIFCTR,
+                       FIELD_PREP(SIFCTR_TFWM_MASK, SIFCTR_xFWM_1) |
+                       FIELD_PREP(SIFCTR_RFWM_MASK, SIFCTR_xFWM_1);

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


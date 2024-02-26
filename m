Return-Path: <linux-kernel+bounces-81804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1E867A42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA3E295077
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65D12C7F1;
	Mon, 26 Feb 2024 15:28:36 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F112BE93;
	Mon, 26 Feb 2024 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961315; cv=none; b=faE3Yu1BxLOXL20pXZm/b49BeDnMNwRNFlIvdCuk6z/a0nyeRo9yISoShqzteIDpxrubyfTYe6S6Cs+HcGmd+kTPsUTaQrruXEq1BeCEwYzzZBnsYGn4orJ55ZMQz/OPYrprGmb8kPmf/9u02GLhhmCzYvmkv+E9aFYBrbAH4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961315; c=relaxed/simple;
	bh=BThJKSHnuKeKiefQoxFWcqNFZUdvTAm2fnN/DgNzB68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuIWok6+anPrz7xZPeIt9+t0P3Bm7jjqZegvZAaqs3lBRVTEmbV1Ybt48DKf7SfoZIiNBKfQUYmosBz3GWNT0IpsxUtrxtOWlV2Ds3m8fFs4IF3+4CxRdmxIcuczmnTNOW0ojSRQoBjx4ecL3nCTLMYtxq9AiCNPDrZE25ts+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6089b64f4eeso31806377b3.2;
        Mon, 26 Feb 2024 07:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961312; x=1709566112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8Ir+4ow5lfDeG0ZqJs1S0yjDRpk74TkiTjLDeq+i98=;
        b=chCS8vpBVAftHsNMvEIYBaOPgE8juASqSMdJ+RCohnAzLqRhtAWGpUR52l7kRlVv8H
         YK1NKKpUXR928tUrYOTDe72qSja87xGHez5HvEftA/eUo0xkbw92Mo7H+D0BsH8TvUV9
         D5N27eM42sd64tZmK7kW7M2BzWj4EuY0GonfzBLbBrOh8YBFHL6VGiVs1bh6F/Tz87Is
         8V5SsbyXStFUv5GnLtGW993NWyo4LxhuKCZFTlotv+/6Grx4pt47zB7SN/MwKyQm4jNz
         xpVCNHqweMAT3za8z/kJZtfz1sMjAedD4ywl7stFL0EOuKwR/HaJ5nQUI8D6Vb9BnDz3
         pdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMVDi4qWH3u5+rqCKpwXg3Jdj3E3JbufQmhCPg+irIdTrtqaWONGauSNt355SUWfJg+A/vo0/J/rz5n8L1hi050DSzhBQBmQJT2tSmhBkvGeXxxtyzEbmJLB93P2u4tQnE4wMc4Di+Zw==
X-Gm-Message-State: AOJu0Yw+wIn67lvW1MGfs6zaGDhKSIf4tr1949pps8s/LJSoXQ4YUdaX
	rg9FCXv4AEJwLwxwM6iboqifBX380T4+sqNENIPtuHBwGSN1irKOH5A3otGjyzQ=
X-Google-Smtp-Source: AGHT+IHlvZWwJySxD8dXW6Oz+b/EHpNllb+rxYDOZulwjahGSybKLs0G7NjXpYadk0ur9/3uTq8elg==
X-Received: by 2002:a81:4147:0:b0:608:b73c:d0c8 with SMTP id f7-20020a814147000000b00608b73cd0c8mr6863178ywk.17.1708961312505;
        Mon, 26 Feb 2024 07:28:32 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id n124-20020a817282000000b00607c9160c22sm1230685ywc.119.2024.02.26.07.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:28:32 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so3413065276.0;
        Mon, 26 Feb 2024 07:28:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRHADW3VBjVzLBFvG5HSHhCFLBxikLnCaYw2GS/ta9BiNdECsEdCQxs0ICLEEb/LoNMAh//ncSXRGEbV0QbHBuQFDtPzy0kUlsFlDOUCvM1XOV5Et0WVfy+QTfZ4Yxu7T23OdM5jQMsg==
X-Received: by 2002:a25:640f:0:b0:dcd:2aa3:d744 with SMTP id
 y15-20020a25640f000000b00dcd2aa3d744mr4744441ybb.17.1708961311899; Mon, 26
 Feb 2024 07:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com> <20240219170337.2161754-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240219170337.2161754-2-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 16:28:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVv==58uen8nukLDB9ADCvJJFYTb2bZSAcFKQ0wUmqL9w@mail.gmail.com>
Message-ID: <CAMuHMdVv==58uen8nukLDB9ADCvJJFYTb2bZSAcFKQ0wUmqL9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] auxdisplay: linedisp: Group display drivers together
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 19, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> For better usability group the display drivers together in Kconfig
> and Makefile. With this we will have the following sections:
>   - Character LCD
>   - Samsung KS0108 LCD controller
>   - Single character line display
>   - Character LCD with non-conforming interface
>
> While at it, drop redundant 'default n' entries.
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig

> +#
> +# Single character line display section
> +#
> +config LINEDISP
> +       tristate "Character line display core support" if COMPILE_TEST
> +       help
> +         This is the core support for single-line character displays, to=
 be
> +         selected by drivers that use it.
> +
> +config IMG_ASCII_LCD
> +       tristate "Imagination Technologies ASCII LCD Display"
> +       depends on HAS_IOMEM
> +       default y if MIPS_MALTA
> +       select MFD_SYSCON
> +       select LINEDISP
> +       help
> +         Enable this to support the simple ASCII LCD displays found on
> +         development boards such as the MIPS Boston, MIPS Malta & MIPS S=
EAD3
> +         from Imagination Technologies.
> +
> +config HT16K33
> +       tristate "Holtek Ht16K33 LED controller with keyscan"

HT16K33 also supports dot-matrix displays using fbdev...
Yes, categorizing is difficult.

> --- a/drivers/auxdisplay/Makefile
> +++ b/drivers/auxdisplay/Makefile
> @@ -5,12 +5,15 @@
>
>  obj-$(CONFIG_CHARLCD)          +=3D charlcd.o
>  obj-$(CONFIG_HD44780_COMMON)   +=3D hd44780_common.o
> -obj-$(CONFIG_ARM_CHARLCD)      +=3D arm-charlcd.o
> +obj-$(CONFIG_HD44780)          +=3D hd44780.o
> +obj-$(CONFIG_LCD2S)            +=3D lcd2s.o
> +obj-$(CONFIG_PARPORT_PANEL)    +=3D panel.o
> +
>  obj-$(CONFIG_KS0108)           +=3D ks0108.o
>  obj-$(CONFIG_CFAG12864B)       +=3D cfag12864b.o cfag12864bfb.o
> -obj-$(CONFIG_IMG_ASCII_LCD)    +=3D img-ascii-lcd.o
> -obj-$(CONFIG_HD44780)          +=3D hd44780.o
> -obj-$(CONFIG_HT16K33)          +=3D ht16k33.o
> -obj-$(CONFIG_PARPORT_PANEL)    +=3D panel.o
> -obj-$(CONFIG_LCD2S)            +=3D lcd2s.o
> +
>  obj-$(CONFIG_LINEDISP)         +=3D line-display.o
> +obj-$(CONFIG_IMG_ASCII_LCD)    +=3D img-ascii-lcd.o
> +obj-$(CONFIG_HT16K33)          +=3D ht16k33.o
> +
> +obj-$(CONFIG_ARM_CHARLCD)      +=3D arm-charlcd.o

I still think these should be sorted alphabetically.

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


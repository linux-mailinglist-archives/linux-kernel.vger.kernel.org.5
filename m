Return-Path: <linux-kernel+bounces-68687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3737857E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2390D1C250C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE54812C54F;
	Fri, 16 Feb 2024 14:01:59 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AFE12C528;
	Fri, 16 Feb 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092119; cv=none; b=FdLystb934/hDhLiHWDqUQXp8RoYEo1HXTG80wAqNMyMamoFhL5nODw2ilOmO99OrrR6OZQAijHKFfGU6xEi5hOJbySZ/0y6YgueYbhHDg4jT4VAUpzZKib8GkXesjLVlIOFmNmGG0mYvf6TzKZJZp3f97lolYk8seTWpcLrPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092119; c=relaxed/simple;
	bh=ioNPgs4X6o405lCujBCduKtsaBUk3vp6xoV7Cks8r6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFVRSIEaRyW5mKj8D3kXS1mVuCOzFXw09XNy4wPgFhzGvGuphvcCnhJzSDLlHN7XZTI+xHcrHAIop1mTfNMBWIEz7Mhk0mZkxSWX/wXSImEdJvDeAazvBHRrfPY3yhujynvvq8gxtk/d0TRq28852C8c/XaNt7VdltMfmwJG3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607fbb1ae38so6718167b3.3;
        Fri, 16 Feb 2024 06:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092114; x=1708696914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOaw5LTfRS/Q6ec8RSqJC8wq4dxjMLwYAJ+OKRO1F48=;
        b=d4QGEyRp0cZSwjXPdJqXk6tvnnlSKDynVrC/FpIiHuGq3f396SOkgHhQp+N5taSId6
         7f2aBP2KZM3uRvFhA7g/soP0D3wZJDJVVLUydRRPBj+iHKAQo0wjKCaRCnQJqI9FBf/i
         UwvXOFM70hy6w9PHZRUM1jRXGPzdJeGuRLNPFgl2sLQCILrmP+saUCB0l2Q8o8NurszB
         Z5h47TXRQgCJAWgmTuM4agE7mEyL/bC48gLKApy45GYz77XiEvueBzlKhdZtVsAVy8Bs
         z9wJOvI7Fsu/OnF9LerbYDVKvo1gPf/ARHUihnlvMRWpH8rjGigTmJSVhsUsY+utWM2a
         ZzZA==
X-Forwarded-Encrypted: i=1; AJvYcCXWd/unUsXxltZGEn9gXaXnCPsQ3L3xhdASQUrakwYKc7HYNf+yrmrxsQ2g4g7fbhU2zLN9/1QlbPpGzkFJ8wnUOBtxpdzLkaZPnv6R8rvonQ4hlzf7wVaRFceXVLt/de4Mvvd2pFcCbmhP4w6Rzm2Och6oRAD5tJ5mkom5AsEByCCjXIncX6nhI3PxQyEbMSvBQt0u5K+rbz/8OgEPjLRxkfarebZw
X-Gm-Message-State: AOJu0Yx5/LTlkSoHKq63XaPuLe8YNL2jcEJ/69AxFsOyBmHsov2vuWts
	KWshsOJp4uTBYci636MBXyeQ5m/YkSwxrx5pqnyKBNnay30xJm5fE7qh5W/sC3o=
X-Google-Smtp-Source: AGHT+IGc6mN5pO0JJoCfdDeGlyJBRVvC84/9SIMHQ46OUuzn/NQ+pLIlNfQLiwQKs+LxBrn6EwCNCA==
X-Received: by 2002:a81:b603:0:b0:607:ec66:36bd with SMTP id u3-20020a81b603000000b00607ec6636bdmr3885509ywh.18.1708092113870;
        Fri, 16 Feb 2024 06:01:53 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id n28-20020a81af1c000000b00607fab8965esm278633ywh.32.2024.02.16.06.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:01:52 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1932578276.2;
        Fri, 16 Feb 2024 06:01:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoR6N4/T06CvwTvta/WM9/y0qnsz8hM7HuYL2k1jn2S+b/z+6/ioHslaMHZ7HkuSqWWbErkBAWziM/GiyvHxB/K6EOwXBviQgfe+kg8zqAv1G23ccc0qCa0ekb4+ufwC2RJapsoZS074w+RPksItBqR1ST7cGNUyJ2RdQzCSy+ZKEcAPzvWXfDbMEcjzZan4TKG1xRUXIfGKPMHKt2xqX/fu/qeqqg
X-Received: by 2002:a05:6902:2501:b0:dc6:d7b6:cce9 with SMTP id
 dt1-20020a056902250100b00dc6d7b6cce9mr5776726ybb.57.1708092112512; Fri, 16
 Feb 2024 06:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:01:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCB3GQxGPxG35rebN2yrKYBnZDzORaEEOuZb3aMgrf6g@mail.gmail.com>
Message-ID: <CAMuHMdUCB3GQxGPxG35rebN2yrKYBnZDzORaEEOuZb3aMgrf6g@mail.gmail.com>
Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:43=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/include/dt-bindings/clock/r9a07g043-cpg.h
> +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
> @@ -200,5 +200,53 @@
>  #define R9A07G043_AX45MP_CORE0_RESETN  78      /* RZ/Five Only */
>  #define R9A07G043_IAX45_RESETN         79      /* RZ/Five Only */
>
> +/* Power domain IDs. */
> +#define R9A07G043_PD_ALWAYS_ON         0
> +#define R9A07G043_PD_GIC               1

As this file is shared between RZ/G2UL and RZ/Five, R9A07G043_PD_GIC
needs an "/* RZ/G2UL Only */" comment

> +#define R9A07G043_PD_IA55              2
> +#define R9A07G043_PD_MHU               3
> +#define R9A07G043_PD_CORESIGHT         4
> +#define R9A07G043_PD_SYC               5

Likewise for the four above.

> +#define R9A07G043_PD_DMAC              6
> +#define R9A07G043_PD_GTM0              7
> +#define R9A07G043_PD_GTM1              8
> +#define R9A07G043_PD_GTM2              9
> +#define R9A07G043_PD_MTU               10
> +#define R9A07G043_PD_POE3              11
> +#define R9A07G043_PD_WDT0              12
> +#define R9A07G043_PD_SPI               13
> +#define R9A07G043_PD_SDHI0             14
> +#define R9A07G043_PD_SDHI1             15
> +#define R9A07G043_PD_ISU               16
> +#define R9A07G043_PD_CRU               17
> +#define R9A07G043_PD_LCDC              18

Likewise for the three above.

> +#define R9A07G043_PD_SSI0              19
> +#define R9A07G043_PD_SSI1              20
> +#define R9A07G043_PD_SSI2              21
> +#define R9A07G043_PD_SSI3              22
> +#define R9A07G043_PD_SRC               23
> +#define R9A07G043_PD_USB0              24
> +#define R9A07G043_PD_USB1              25
> +#define R9A07G043_PD_USB_PHY           26
> +#define R9A07G043_PD_ETHER0            27
> +#define R9A07G043_PD_ETHER1            28
> +#define R9A07G043_PD_I2C0              29
> +#define R9A07G043_PD_I2C1              30
> +#define R9A07G043_PD_I2C2              31
> +#define R9A07G043_PD_I2C3              32
> +#define R9A07G043_PD_SCIF0             33
> +#define R9A07G043_PD_SCIF1             34
> +#define R9A07G043_PD_SCIF2             35
> +#define R9A07G043_PD_SCIF3             36
> +#define R9A07G043_PD_SCIF4             37
> +#define R9A07G043_PD_SCI0              38
> +#define R9A07G043_PD_SCI1              39
> +#define R9A07G043_PD_IRDA              40
> +#define R9A07G043_PD_RSPI0             41
> +#define R9A07G043_PD_RSPI1             42
> +#define R9A07G043_PD_RSPI2             43
> +#define R9A07G043_PD_CANFD             44
> +#define R9A07G043_PD_ADC               45
> +#define R9A07G043_PD_TSU               46
>
>  #endif /* __DT_BINDINGS_CLOCK_R9A07G043_CPG_H__ */

In addition, you need definitions for the modules that are only
present on RZ/Five, e.g.

    #define R9A07G043_PD_PLIC               47    /* RZ/Five Only */

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


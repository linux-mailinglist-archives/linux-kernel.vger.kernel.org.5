Return-Path: <linux-kernel+bounces-55111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957784B7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE1F1F21553
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6C132490;
	Tue,  6 Feb 2024 14:27:33 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460D73195;
	Tue,  6 Feb 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229653; cv=none; b=labVn+Y00e3wId66gMFBtARhlXNoIZRkuiLOo1WQmcaSdRtOUaNBvsk845iEET6/cdkRnjPurIJgWW39+GlbVokjdzFVI3omqjCnV0xP8qDfitoYEZ6c/WKhWJWNFKZEJBa1mjCqeZ12Zy8o+rnRX0V8+a5J3pJb7TuUKMIzysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229653; c=relaxed/simple;
	bh=jgY+TWgYdfR9MKXCotYSOZivElxKp66BrEYaXSOeXyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdSfjoGlDELDR6rrcF8i9nm7U9B5UUCLrkm3UYAvWRhGyZdrPlxR7hf737LaBX4JaVDqycJ8Y9X0iQIj84h/le7kpU2OR4g2/bJyiVZv+KFaymyVCx+XCSpZqb3Qb0edHu7ZF4rO3V5hXJRgy6eGDsOLqhsqRtgZuoiHv2oCi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-604713c4ee5so13652927b3.0;
        Tue, 06 Feb 2024 06:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229649; x=1707834449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMuL3cMWnvFZf6VJykIvule1zvnpxfniwQC+Rdv3zpU=;
        b=T7Yg1at0aLNumPR34lTQeul44RGrYfSTczY2IwKmQMZvq4l6L3M++e3SmeUzXAUoCW
         uoSdRuP9+lhZYqJGjLnZPrEmuLMQjljDGH5v2ebdv8ef2Ou50xlQfsUIN76TlUaoOKAo
         m8mv9r0+GbjbUGrnMDrKld/Nb9CT8mjsGzSY2uhINwTGAlhuA5WFGjVZYthJBohBVNJ8
         +nP/oFa1V4BwMO1IYHWmFNVZlWX7/XxObmJwakQ0Yp1TNJz8scJOhnRrG5qg97ban7z+
         S5c/FBICnnxkz/QWYkP+SLeD7M+HbbMgqdv9MfRXc6Z/VyjbTJDFF1+4jQbWW0/QzDJq
         fVIw==
X-Gm-Message-State: AOJu0Yy35kTBy4NySlUVOA6qnxASsOsswk4Zoww2LkzXjwSNYpMI6/6Q
	cLgDLI6Qo1WKnZ/jO3N8f/YsEQ62gqsdEindza/WckKOiubLhDZXiVGrXIFWCP0=
X-Google-Smtp-Source: AGHT+IFnWLMlXiNnm03DdTsh/55xX4ggJylVN4xOxWPyv/zbMGm3WdH1LbMfqVMz8SomQ1SlfpXxzA==
X-Received: by 2002:a81:f110:0:b0:5f0:cbce:669f with SMTP id h16-20020a81f110000000b005f0cbce669fmr1910341ywm.22.1707229649304;
        Tue, 06 Feb 2024 06:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgGFsNQe65pPCBvwU4bpPpqGYFMEx1EvBqyggD4/Dx8XEmZR+F9Dxa/Uf8Pv9t2uPjHu6haODBbgsYlv3DxiHJVQCGZOWwJ//+W9BV8c/hen6fuEwlEsGU0jaOxZD/phfLCrTg
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05690c34c300b005ff9d3ca38fsm492103ywb.1.2024.02.06.06.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:27:29 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60412f65124so52125877b3.3;
        Tue, 06 Feb 2024 06:27:28 -0800 (PST)
X-Received: by 2002:a81:b1c9:0:b0:603:d3f1:1c2b with SMTP id
 p192-20020a81b1c9000000b00603d3f11c2bmr1698533ywh.24.1707229648647; Tue, 06
 Feb 2024 06:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115202104.14077-1-lnimi@hotmail.com> <PH7PR03MB7064D0D56ED3A26B0F93CC12A06C2@PH7PR03MB7064.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB7064D0D56ED3A26B0F93CC12A06C2@PH7PR03MB7064.namprd03.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 15:27:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=G0eYTf+n9Bv+Bwke4W8isRrh-B6zHD1=hD8yksxedw@mail.gmail.com>
Message-ID: <CAMuHMdU=G0eYTf+n9Bv+Bwke4W8isRrh-B6zHD1=hD8yksxedw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Min,

On Mon, Jan 15, 2024 at 9:22=E2=80=AFPM Min Li <lnimi@hotmail.com> wrote:
> From: Min Li <min.li.xe@renesas.com>
>
> The RENESAS FemtoClock3 Wireless is a high-performance jitter attenuator,
> frequency translator, and clock synthesizer. The device is comprised of 3
> digital PLLs (DPLL) to track CLKIN inputs and three independent low phase
> noise fractional output dividers (FOD) that output low phase noise clocks=
.
>
> FemtoClock3 supports one Time Synchronization (Time Sync) channel to enab=
le
> an external processor to control the phase and frequency of the Time Sync
> channel and to take phase measurements using the TDC. Intended applicatio=
ns
> are synchronization using the precision time protocol (PTP) and
> synchronization with 0.5 Hz and 1 Hz signals from GNSS.
>
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Thanks for your patch, which is now commit 1ddfecafabf71e0e ("ptp:
add FemtoClock3 Wireless as ptp hardware clock") in net-next/main.

> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -155,6 +155,18 @@ config PTP_1588_CLOCK_IDTCM
>           To compile this driver as a module, choose M here: the module
>           will be called ptp_clockmatrix.
>
> +config PTP_1588_CLOCK_FC3W
> +       tristate "RENESAS FemtoClock3 Wireless as PTP clock"
> +       depends on PTP_1588_CLOCK && I2C

This driver does not seem to use any direct i2c functionality (it
does use regmap), so presumably it should depend on something else
(see below) instead?

> +       default n

"default n" is the default.

> +       help
> +         This driver adds support for using Renesas FemtoClock3 Wireless
> +         as a PTP clock. This clock is only useful if your time stamping
> +         MAC is connected to the RENESAS chip.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called ptp_fc3.
> +
>  config PTP_1588_CLOCK_MOCK
>         tristate "Mock-up PTP clock"
>         depends on PTP_1588_CLOCK

> --- /dev/null
> +++ b/drivers/ptp/ptp_fc3.c

> +static struct platform_driver idtfc3_driver =3D {
> +       .driver =3D {
> +               .name =3D "rc38xxx-phc",
> +       },
> +       .probe =3D idtfc3_probe,
> +       .remove =3D idtfc3_remove,
> +};

Who is supposed to instantiate this platform device?
I couldn't find anything in-tree or on lore.kernel.org.
Presumably that driver should be a dependency for the
PTP_1588_CLOCK_FC3W config symbol.

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


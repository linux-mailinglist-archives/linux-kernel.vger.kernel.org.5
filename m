Return-Path: <linux-kernel+bounces-44390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FEF84216A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5231C2385F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453D657DD;
	Tue, 30 Jan 2024 10:36:32 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFF360AE;
	Tue, 30 Jan 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610991; cv=none; b=uTHDgiaiAENU8qMoHlZ/pDijKWIu/loBHc3iojXkycrAshLWjGI/q+/LT2TrPCuC/isjg8rRZs94gpBIuSgBbHYlLsq2VFAkQROZy1tAPQXmO/XkMuhKdu1BCNDgWt011r789R1Os5Q6RLukMJg6z8VxP7fraLJ/et1+t3FsH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610991; c=relaxed/simple;
	bh=1VEZsTwp9W5LxTMM5zFoUdxDncCyBRFtLz8ybVOricc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DitmvX2n8ILRqt1NM6glWem+rIDsVHF1/WUWr7kyWUf2VlW9RLzpiDrkNi5Zqkr/732kQ5BcBrYi3Q4Sj6kBgYvxMW/R1dmCN1Gu8zo/ViH+3JZdye6Q5wDkTiTom4mO0kjEFi7s82agswXwFRT9KCQb/okhtDsOVehVuBSPtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5edfcba97e3so42235207b3.2;
        Tue, 30 Jan 2024 02:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610989; x=1707215789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0zKEeIH6XGdGj+q5gmx2XiQOnw1KXquglVBPd+xyto=;
        b=aYsnIpO0j8Fu0c8hMGLMxprwsqBhu+4/LtbKaNvy47RjmJ1Epvg0Ota+xDtCC8S1m7
         3Eq2DOHqKEqcR2aRuLOfgYeeEyDaTfVTX7tQZA+qPSCVd2suAsOJkgpkxsb9Js6djxzV
         pM5G7azD04s4ofm21DMGVR1e46HcWGDRYzidnpPZVJQyRINWUlrX57eWToCPuyUpoLZ3
         4PPv6QYkzSh9I8hL9FK8pmgHMd3BzztBCsYI+seNbiBzS4XF7/mblmwF/0eRzuO00qbo
         8CE1lA8Mb97Vp3rmEctYb3Ix/rfNsOPaarTEX6/StE00YhcfAvbs4j1JxqJTkSKKXgKa
         +x9w==
X-Gm-Message-State: AOJu0Ywk3Ofz3vDr9elSYv0uz48htbmSjaicnQkwnXRGF16q4EP0onpm
	lM6jU5w/I58DJm0Ib5HEUhNJcsjCAB3dvayd7xiSoBye5U5s9KI2N5kVe3Sg/FM=
X-Google-Smtp-Source: AGHT+IHVZtyGo2xht6Yj5/6d/jNkjtUKKD/9RnpugLSoG3UCzH6h/ZnhTdy6CKc2twT2R3ARlgzEXg==
X-Received: by 2002:a81:bc54:0:b0:602:ab11:4264 with SMTP id b20-20020a81bc54000000b00602ab114264mr5716847ywl.43.1706610988934;
        Tue, 30 Jan 2024 02:36:28 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id fr3-20020a05690c358300b0060033cc4fb0sm3088864ywb.13.2024.01.30.02.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:36:28 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6029e069e08so50158837b3.0;
        Tue, 30 Jan 2024 02:36:28 -0800 (PST)
X-Received: by 2002:a81:e207:0:b0:5e9:fa4a:fd56 with SMTP id
 p7-20020a81e207000000b005e9fa4afd56mr5491349ywl.13.1706610987546; Tue, 30 Jan
 2024 02:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129135556.63466-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129135556.63466-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 11:36:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-x94pcJ7UwYH_SUcFc_k0CiNckqxEX=_QCi+Ad9adJw@mail.gmail.com>
Message-ID: <CAMuHMdV-x94pcJ7UwYH_SUcFc_k0CiNckqxEX=_QCi+Ad9adJw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Currently we assume all the port pins are sequential ie always PX_0 to
> PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pins P19_1 t=
o
> P28_5 which have holes in them, for example only one pin on port19 is
> available and that is P19_1 and not P19_0. So to handle such cases
> include pinmap for each port which would indicate the pin availability
> on each port. As the pincount can be calculated based on pinmap drop this
> from RZG2L_GPIO_PORT_PACK() macro.
>
> Previously we had a max of 7 pins on each port but on RZ/Five Port-20
> has 8 pins, so move the single pin configuration to BIT(63).
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.9.

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


Return-Path: <linux-kernel+bounces-116711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 443FE88ABBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723F1BC40E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29E153BF4;
	Mon, 25 Mar 2024 10:28:08 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E3156886;
	Mon, 25 Mar 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356228; cv=none; b=WnbAOqZ9aTF73KuwYosTU+4VqOgRpPjcoub0OiTLjVLXAaRdJputEFIZQ4uWAH+0FXRa07vra2ygGaYvR1PThxyffypY4QBb4blhlcYd/IFlGoO2D/I1XedCJCaaGRqXHk3LUcui21ulh1Iugr39AfKKdv0ZC7jWj0YmmM8qzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356228; c=relaxed/simple;
	bh=hcxg4In4aK2uslPZ2l3j/imsw9p/42fA3ITh/yE+w40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sdt5BLYczjyle8HuMo6wHCGk6vCoElaOWOCslC9b/SlliY0cR8PKCytbhnflFaT3wz7lbKx08Nn8OBhcGc8+VS60v7OyGV8s5Rtkdj86ZbQXpnXDSW0L+vHgsnTso7W9ZIVUM9sjhyWn0Ut/s3lHRmu75idRmyZDE/q77X1AWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61149e50602so7363337b3.0;
        Mon, 25 Mar 2024 01:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711356225; x=1711961025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChuSgVYGVBf5BrY9y1MgsrXyLyHWL1icjbpaJ35NYnU=;
        b=wFQmJTOlQU4L2QJR2RBpAPSBFfLYYcsiSa7yVEGracaneA0SsjEVkjBsAaBYPEt8wy
         Mb8G/VS1ZDR69ZUWD+7MOivHQoL5ORufkE4PNrcSCmPCs5DB3+AHhybnAJCfWAhVHKCF
         15Do61pRHSiwpGUYbVZhX4OYcWBW/xE3PDXlgZ9I+mid2NahC1+8a1BY+GJ3uRzI6eT8
         E82bIiWKmf8YXF5baysXrV3X//CXNdFsxdBNO4GlcdT1ZfV7puqfzb6D2xEPEcWw/1Mh
         I2xXgI6SS8ozjOcOGetaZfPNIrrXYKDPnabU6WoEi/6N2JZMIrLUQ2I6yVVj4FPGYequ
         djLw==
X-Forwarded-Encrypted: i=1; AJvYcCWsJ5eDMmbkJ/wRTigcEtXPtXex8FWLFo9qwIXZZCbIeghGFTO+f0hJZSm0HebT7eHTcLFdyNUdcs5kX1BJ/Xurpgbcg9uD3a00xvw/W5WNhhnNDWxmklRI6VBKEkjDt7W+x2OgiJ9kh6g=
X-Gm-Message-State: AOJu0YzrSq/eqpLiY1y/gntTY+FhF8zObAB7i/1yGp3yeSQmS6rulRWG
	NkP5p8D0yeSx+cOjZ2P1NCIfER3SiMjk8C94xq/p+M7VxZjpFPmJpQjGS/TOMOE=
X-Google-Smtp-Source: AGHT+IHX/d0PCCB3xpz7d90wwLNQ/zZqtXcuLMyLgTpTDJh7/2lbd6aJn80oJYR7CWp3CZsSibfkuA==
X-Received: by 2002:a05:690c:610f:b0:610:e891:838c with SMTP id hi15-20020a05690c610f00b00610e891838cmr3162495ywb.7.1711356224199;
        Mon, 25 Mar 2024 01:43:44 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id v141-20020a814893000000b0060a109ae2b2sm959230ywa.26.2024.03.25.01.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 01:43:44 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3133376276.1;
        Mon, 25 Mar 2024 01:43:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUY8vlUl8Wd5rFweNWKFzzddpWkA9mrx1LV8i1fHjYOShpS90Giv2G4eLuhnSROuXdrE2eZHGRliY9mH9TZGlokdeuxeDu+J3ASb0Edxxtn3gf4lj2wGHdoI088sVH/7yXmLteC5Gp3JOw=
X-Received: by 2002:a25:6cc3:0:b0:dcb:b072:82d8 with SMTP id
 h186-20020a256cc3000000b00dcbb07282d8mr2843159ybc.15.1711356223761; Mon, 25
 Mar 2024 01:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324233458.1352854-1-sashal@kernel.org> <20240324233458.1352854-111-sashal@kernel.org>
In-Reply-To: <20240324233458.1352854-111-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Mar 2024 09:43:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUK0YYELTN=JQDtGuYg03Em6c7kskpqUR0Y6NbNuR7hfQ@mail.gmail.com>
Message-ID: <CAMuHMdUK0YYELTN=JQDtGuYg03Em6c7kskpqUR0Y6NbNuR7hfQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 110/317] arm64: dts: renesas: r8a779a0: Update to
 R-Car Gen4 compatible values
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Mon, Mar 25, 2024 at 12:36=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> [ Upstream commit a1721bbbdb5c6687d157f8b8714bba837f6028ac ]
>
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence update the compatible properties in various device nodes
> to include family-specific compatible values for R-Car Gen4 instead of
> R-Car Gen3:
>   - DMAC,
>   - (H)SCIF,
>   - I2C,
>   - IPMMU,
>   - WDT.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Link: https://lore.kernel.org/r/73cea9d5e1a6639422c67e4df4285042e31c9fd5.=
1651497071.git.geert+renesas@glider.be
> Stable-dep-of: 0c51912331f8 ("arm64: dts: renesas: r8a779a0: Correct avb[=
01] reg sizes")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 24 +++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/=
dts/renesas/r8a779a0.dtsi
> index 26899fb768a73..c7d1b79692c11 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> @@ -583,7 +583,7 @@ hscif3: serial@e66a0000 {
>
>                 avb0: ethernet@e6800000 {
>                         compatible =3D "renesas,etheravb-r8a779a0",
> -                                    "renesas,etheravb-rcar-gen3";
> +                                    "renesas,etheravb-rcar-gen4";

This change will break Ethernet, as the Renesas EtherAVB driver in
v5.15.x does not handle "renesas,etheravb-rcar-gen4" yet.

That can be fixed by also backporting commit 949f252a8594a860
("net: ravb: Add R-Car Gen4 support") in v6.1.

>                         reg =3D <0 0xe6800000 0 0x800>;
>                         interrupts =3D <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,

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


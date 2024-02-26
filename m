Return-Path: <linux-kernel+bounces-81516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9088676F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758F328F915
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C812A168;
	Mon, 26 Feb 2024 13:42:00 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F276128839;
	Mon, 26 Feb 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954920; cv=none; b=AXJHQ7fbzc03/M8g+0ZBtHU2fwIqnGfIWQQ/1h3MkOOgP+R5Hl8Ylh3ybLnfrnal+tsTnStnxobKlRTuA7veDrKLlZwi4ddm/84+1ZmRZCVZZ/FiWdb/u88iZ0h6q26d90rKyD+xj88F+e2vtbwDx+W+ib1crjrVWMuZQXKteaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954920; c=relaxed/simple;
	bh=uf4G1LQtE+of00JBn2elTsV8rbTDZ2t6XSM35puzMBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shEyiBZlkg8GSJgKvNMu4qDCbRMq/Rpm88m2Sqw/QTtAA5tTfH1Tsw/RUEA+XGxW/CrQ40l4gCE1XklmX7Lm9/ax35gsh0cYTIpxDF3SBaaXNCmtbXJaVFtW3gvKMx+4ZBymOuiOmNS0A9Gt3t6phw0xmAfa+K0pFW0Bw5FP8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso3249752276.2;
        Mon, 26 Feb 2024 05:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954916; x=1709559716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOqgtv4IqErN2hXEaQAp3E0TLQstXToESwKXSzCVbV0=;
        b=taHCDHxd/ldJ8Hj3HmymEqAq5r0R6iBu5E36uVvXkyTbaqeAmVYdWxKasEeAXGlGQm
         0soTkccC5gJOeY+CHJlJ9kV1hVuatx4ENdxw0A0exhIbQ7o0tua57UqLVAKtwDpC1ypj
         tcKUDdcLwla7lhe2TZ/jtfZYhFZt1MiVqyJFILkkr3wj/Hri9aR1fF3NuLjmipYTiNqZ
         BWc40VxOGC1wiI4mfD2NP+7KQa8VNQYsq3xyb0a7UFdZdrlXMukZXdC4VcLxlhzC6adm
         uuxlA5t/0Ox9dtEkmXBD4F+z7QbYvVlsMrwVJidV73iO2prTH5HUCTYgulUvxRBpdDUk
         1bEg==
X-Forwarded-Encrypted: i=1; AJvYcCU5tkBao5GSZz6ifB8cdVsjoJ/rs4Mizoz3i7UPYoEd75I6V9XcFybOQ91NEH3rOsqRjEhB9s55308ep7SFvmIHBXOhLhgf3PtuSW2xg62Klw5K2d370eDnM7QMuAV3PVlEF2764l8LoOssLf1tMIel5/p9CCRxCAQeb6Qa6e1LM1Bo0EHQZkQkbXcR
X-Gm-Message-State: AOJu0YxtGqObbLhQJr6FSZ/Z9CeF61SOlXMu/oGdKBJCIG6URyyMczpi
	qvXnZ4e/Q5piolny3P3xa7vN70CrBDhg4dqbhLIBuGhMmx1JjUBc5un1V++o6QE=
X-Google-Smtp-Source: AGHT+IE+rYqLeZ6bxu/lNYvBqjVLEwDToJomctgoAxCc+HNSWVu+u3FfeX8yD+N+gcBZ7jYb5S/KJQ==
X-Received: by 2002:a25:8402:0:b0:dcf:2b44:f38d with SMTP id u2-20020a258402000000b00dcf2b44f38dmr4696830ybk.49.1708954916180;
        Mon, 26 Feb 2024 05:41:56 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id s16-20020a25aa10000000b00dcd3487c8f5sm956814ybi.12.2024.02.26.05.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 05:41:55 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607c5679842so30471357b3.2;
        Mon, 26 Feb 2024 05:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3JsSlVGTtkewnLTlWhTI6/Itk4ShLcAhSAPC0n5wWoMhqqPN56Nivm024b9Swy+09B2z66MYhkSub8O5mw/ChgevGCqiJstnETjR2EB+dwzL52bD39lEFr95R9dS/kzHeF4u/Ykztph00O8IQZ/Aq8iG1rT7lNWzbRB+a0ElhHhdf7SK/Uvzb7sdj
X-Received: by 2002:a25:ad17:0:b0:dbe:9f4a:6bb0 with SMTP id
 y23-20020a25ad17000000b00dbe9f4a6bb0mr4308468ybi.56.1708954914960; Mon, 26
 Feb 2024 05:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240219160912.1206647-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240219160912.1206647-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 14:41:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV3eVTek9sYwXbqu98ta8wx197GMc-k3q1RZRb8ar=jFg@mail.gmail.com>
Message-ID: <CAMuHMdV3eVTek9sYwXbqu98ta8wx197GMc-k3q1RZRb8ar=jFg@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: renesas: Document Renesas RZ/V2H{P}
 System Controller
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

Thanks for your patch!

On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add DT binding documentation for System Controller (SYS) found on
> RZ/V2H{P} ("R9A09G057") SoC's.

RZ/V2H(P)

>
> SYS block contains the SYS_LSI_DEVID register which can be used to
> retrieve SoC version information.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys=
yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2H{P} System Controller (SYS)
> +
> +maintainers:
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description:
> +  The RZ/V2H{P} SYS (System Controller) controls the overall

RZ/V2H(P)

> +  configuration of the LSI and supports the following functions,
> +  - Trust zone control
> +  - Extend access by specific masters to address beyond 4GB space
> +  - GBETH configuration
> +  - Control of settings and states of SRAM/PCIe/CM33/CA55/CR8/xSPI/ADC/T=
SU
> +  - LSI version
> +  - WDT stop control
> +  - General registers
> +
> +properties:
> +  compatible:
> +    const: renesas,r9a09g057-sys
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Clock from external oscillator

Isn't this SYS_0_PCLK inside the CPG?

> +
> +  resets:
> +    items:
> +      - description: SYS_0_PRESETN reset signal
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    extal_clk: extal-clk {
> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <24000000>;
> +    };
> +
> +    sys: system-controller@10430000 {
> +        compatible =3D "renesas,r9a09g057-sys";
> +        reg =3D <0x10430000 0x10000>;
> +        clocks =3D <&extal_clk>;

clocks =3D <&cpg 1>;

(I guess it will be 1 ;-)

> +        resets =3D <&cpg 1>;
> +    };

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


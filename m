Return-Path: <linux-kernel+bounces-149841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F35F8A969D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FF81C20A17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABBA15B548;
	Thu, 18 Apr 2024 09:48:48 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D23158DDB;
	Thu, 18 Apr 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433728; cv=none; b=YfDtc16kOMWy1Zz2jJ2Ayyq9rhHpMIhaJwQYKaPuIPFpGhugNFT7b69bVPCwsW9pq9YBcy1KNdfoICjEXM95jVbQremTHEgsroN3ncDZ5MGcJpuUPqXuu9V6TGjQiLZdXabTkwEDjRtQlKcrBXkjAzIacQ0Ry1xiK04m/RAzVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433728; c=relaxed/simple;
	bh=PEOWO+h84aSSaWcYR4A17PM7pMO6FnB+JgsozNRA7A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDwa+oOzwLWQsHWJXOwVJuU/h8aW5xN/oWmn/T0DIgUl1unWNQA0ZOypPc8OLNxp3amt5+VZysa9OB3wrH0V9M+RWivA7QLjpOqQJjaifQtex6+Kwr8uGuSXDzCPI0aW2+LHnrBAZUzQ7LRyik0VN0HpWWayzVJLxOoW9Z4Apj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6181d032bf9so5788697b3.3;
        Thu, 18 Apr 2024 02:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433722; x=1714038522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/U/1iMAXF9+rfXboPMqFLH5Q8RXvLu8gC+6FrBKyQ0=;
        b=SfSZXZL+Zj7xqckhyYwqdwwpcJM8SEXKSDNa+wvqTwwSF27xex3bhGew1H61/Vk0XG
         J1ojBv7yJuG857XNDpHbURpVwx3UoTTu0vDhWzfbRq6UPpEg1CBxkdO2YvqjIyVDAk9O
         0j6qkzt0gTb82HY7chmzt755QEc1HrwlzMzVXO97euAql5Io9PC4UvwEjn+oCYI2QSoV
         P0t/mzf2aVmN35N2JoK8sILhc6a6zph0/ZPlBNv4Xns3c6O1RWuPECcdoqgaW/IH69Jt
         BkOlYoKDCdhARA6E2Zi/KSNenYVKYZiPR3YI9HNyoarMew+4mBIlnR+t2y3oSJOnl7tQ
         YNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBHxE2gaK7rsc7BSxSdvyp+P0aRtj+HV+0fMtRODBdYlIEVbAtrrF5wMrIf/itPl/c++nZYh2sIo/tocq4EIy9b2MF7XwBAF7+B5qhK2Xr4RsfBsVz4oUcm/tss9OVPLzYHRf989xqnh+ZjnULgYYS/F3BZflfcyup4eqn20Hfu3INpqcvuprmFwG1Fpm/ljXQESMdoMZLON0mEADVZ+zUKVOS
X-Gm-Message-State: AOJu0YyyfdJGY05QrbC3zbdfbgR0JfdphYYk9+iNkUb4U5Hws3tJf04t
	z3dEr8rRciNM02WxSY/KmBdWXwu3dgoS5jCM+6DbleZmDBcClSHs8HeiwBNtrck=
X-Google-Smtp-Source: AGHT+IEiJ/WnBa9inzvhbhXQB+2jpI5qh5RDXIdFCf1cQ5JNFBC0LCjiTewnLeLsQswc8tCIpOQZPQ==
X-Received: by 2002:a05:690c:368e:b0:618:8a27:6150 with SMTP id fu14-20020a05690c368e00b006188a276150mr2157297ywb.24.1713433722484;
        Thu, 18 Apr 2024 02:48:42 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id id8-20020a05690c680800b0061adccb38ecsm263514ywb.10.2024.04.18.02.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:48:41 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-617e6c873f3so6295327b3.2;
        Thu, 18 Apr 2024 02:48:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBkNAEDecr/0Ur8X20cuCZ1zwo53vsVh6DvwBlGZpBfpsvM7Xr2ZdewjCXbjs/8VGSJDnqMtWSmOupeZCT8nGco6X+lqlkzW0tr0tU0nEnVEwQIuTbOGbf47desZFvMUpPNhdJeJ47RtPFiXS9I3+vA+GpUAJN1PUfGvkMAyBrvizmYdkMc7wAnXHBAG4PuI+PYnn8FbsZFdv8Xrj1YGkn1adH
X-Received: by 2002:a05:690c:d18:b0:61a:af67:1cfd with SMTP id
 cn24-20020a05690c0d1800b0061aaf671cfdmr2156849ywb.5.1713433720901; Thu, 18
 Apr 2024 02:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com> <20240415-rzn1-gmac1-v3-5-ab12f2c4401d@bootlin.com>
In-Reply-To: <20240415-rzn1-gmac1-v3-5-ab12f2c4401d@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 11:48:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVWEMSR6vKSPdXRbf5_dqBWsM+Z2PV46DBmwHAoBNv_5w@mail.gmail.com>
Message-ID: <CAMuHMdVWEMSR6vKSPdXRbf5_dqBWsM+Z2PV46DBmwHAoBNv_5w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] ARM: dts: r9a06g032: describe GMAC1
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Romain,

On Mon, Apr 15, 2024 at 11:18=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>
> The r9a06g032 SoC of the RZ/N1 family features two GMAC devices named
> GMAC1/2, that are based on Synopsys cores. GMAC1 is connected to a
> RGMII/RMII converter that is already described in this device tree.
>
> Signed-off-by: "Cl=C3=A9ment L=C3=A9ger" <clement.leger@bootlin.com>
> [rgantois: commit log]
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> @@ -316,6 +316,25 @@ dma1: dma-controller@40105000 {
>                         data-width =3D <8>;
>                 };
>
> +               gmac1: ethernet@44000000 {
> +                       compatible =3D "renesas,r9a06g032-gmac", "renesas=
,rzn1-gmac", "snps,dwmac";
> +                       reg =3D <0x44000000 0x2000>;
> +                       interrupt-parent =3D <&gic>;

The surrounding "soc" node already specifies the interrupt parent,
so there is no need to repeat that. I could fix that while applying
to renesas-devel for v6.10, but it looks like there will be a v4 for
the rest of the series anyway?

The rest LGTM, so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +                       interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names =3D "macirq", "eth_wake_irq", "et=
h_lpi";
> +                       clocks =3D <&sysctrl R9A06G032_HCLK_GMAC0>;
> +                       clock-names =3D "stmmaceth";
> +                       power-domains =3D <&sysctrl>;
> +                       snps,multicast-filter-bins =3D <256>;
> +                       snps,perfect-filter-entries =3D <128>;
> +                       tx-fifo-depth =3D <2048>;
> +                       rx-fifo-depth =3D <4096>;
> +                       pcs-handle =3D <&mii_conv1>;
> +                       status =3D "disabled";
> +               };
> +
>                 gmac2: ethernet@44002000 {
>                         compatible =3D "renesas,r9a06g032-gmac", "renesas=
,rzn1-gmac", "snps,dwmac";
>                         reg =3D <0x44002000 0x2000>;
>

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


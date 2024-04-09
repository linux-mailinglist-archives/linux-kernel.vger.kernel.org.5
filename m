Return-Path: <linux-kernel+bounces-137225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F2189DF81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FF5B31B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F913AD01;
	Tue,  9 Apr 2024 15:28:18 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96113541F;
	Tue,  9 Apr 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676497; cv=none; b=ifc71VwP9uofLxvHBrQzQDiHgrDTfmxmf98JLtv3NUt/2Woovj6LsBB6eMYTNVzVVZFlidK9A/oeMWR2fLm2+f7V++5ULMfuPxwMu3y9mo8o+h2KOGeA/TAeYRS9GTLTBrr5DWM8LzrZxmau0RDJn5YDiIX/PKHHFiM6X9EIiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676497; c=relaxed/simple;
	bh=5CBoTmLG4y7e/KRyazSSY1LYpq2J5NObpY/pXkbyRWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dX78Y257OvBpAqjQpbuzPUn7IRQjU+Gfqkpt0MGMXwlCVsLGDJdQ6z0YeyJ4sgAgI+Fzv/fLVut8xh2TRKUvJYSUzrP3P+RdM3usedXCFEzsi+w/3TCEf2Yr8JjiSldOwjVRREPPfJuA3xxBmOv7oG15i+xmXwV5kYC+je14mV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-617ddc988f5so45721007b3.2;
        Tue, 09 Apr 2024 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676493; x=1713281293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9fHLaOg0xQHrvlM1IV1UTtnZ4u0DmXFhb6dRTtO4eE=;
        b=TSAgnPt+H85F7Om0hUUhfEv+n9CNj7eugrFT1uTkf/7nLZRWnQ6UCs/kMQzfuhdxjL
         XMy5Qri4yV5gZYeFHDrzYAYb7kzG/EapSX9jo91oLZYOfY2WvbbPxiAVPTLc3Nw3Ga6s
         umq5Wv+CHuIWefh3DmPyb4NKFcyQWt1WqxqCO9py3zrkG4w2sGe5D2LluxuUtuA1gIRC
         SZir9sEABstTkvOSQij6msr8G4pGr9zwZL6Dh22LaJovdt0lm8FyW6Iyd9oNAiUQZRos
         Ht1UPBlHqTkHInziqavmmfGBYckL8zA6YIgluDYIVhOSYBza5tPYDIIOCqHWODoYnFrg
         K2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVhWKcOpKHsSyjaMdfcym8qov+V5l9VvdB57cC8obQXUXL19s2D5BaPQsyyj5wvkWmh1r3hAPfZHD3i7/IYEcFJ0VKhiQOsRI6ORZGQwRnRc+LPWPRxoDHVPHMNsANxmMMKgudD6StHY5VF5RyghdBmmWXcCGiDVWe3E1purju2r7hSc1/39sPozjuowWLxwJpuW2F9ZtonHW1UxQkZ3v59uvEF
X-Gm-Message-State: AOJu0Yy8gTuKAHRs3VSr6FJJ2uvjKXNnF0AX3MSPGOzfpjAZ0zeBAPTR
	Ie0ScHNzhUzNnVV76EMDA+DrJwtD/k1FkSyD9db+qiviW4UD450uPERBL3ITqOk=
X-Google-Smtp-Source: AGHT+IGEdiWWT0vLFsfDZbjn7QIX2MQqmNy+Wk/VC1Hli3HWTQZo8BsD8oiAyaxT0pIEAgpjhIex/A==
X-Received: by 2002:a81:7b85:0:b0:615:1dee:6b0e with SMTP id w127-20020a817b85000000b006151dee6b0emr11379477ywc.39.1712676491686;
        Tue, 09 Apr 2024 08:28:11 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id jx4-20020a05690c380400b00615bd0701c7sm2206364ywb.118.2024.04.09.08.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:28:11 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso6157781276.0;
        Tue, 09 Apr 2024 08:28:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk8AV9QMHJtuhhi7TayLP5vDD2j7F+AQI0+C5m8FgMfIqPIrsCZCgvWsmI2XZ1M/4vbDq/F0OTeyMxQRkd6XoqhEjYoHFuy4Yo0nsAZh/UfpPA2vBnrwxGFejEovwY3JIucM7V7kqBq3gJE9oO78mD+f1MaRBIETrcG2IL84RRFQJweOxvAq/amNE54z1IZBD0mJI2P2TyK4+SvCCT/nNrZhxQ
X-Received: by 2002:a25:a249:0:b0:dcc:56b6:6606 with SMTP id
 b67-20020a25a249000000b00dcc56b66606mr69104ybi.40.1712676490322; Tue, 09 Apr
 2024 08:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com> <20240409-rzn1-gmac1-v2-4-79ca45f2fc79@bootlin.com>
In-Reply-To: <20240409-rzn1-gmac1-v2-4-79ca45f2fc79@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Apr 2024 17:27:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-F8LXWx=Ras4f+Dt_r485HKjRDLydDXZsnZBW8HJzxw@mail.gmail.com>
Message-ID: <CAMuHMdX-F8LXWx=Ras4f+Dt_r485HKjRDLydDXZsnZBW8HJzxw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] net: stmmac: add support for RZ/N1 GMAC
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

On Tue, Apr 9, 2024 at 11:21=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>
> Add support for the Renesas RZ/N1 GMAC. This support can make use of a
> custom RZ/N1 PCS which is fetched by parsing the pcs-handle device tree
> property.
>
> Signed-off-by: "Cl=C3=A9ment L=C3=A9ger" <clement.leger@bootlin.com>
> Co-developed-by: Romain Gantois <romain.gantois@bootlin.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Thanks for your patch!

> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -142,6 +142,18 @@ config DWMAC_ROCKCHIP
>           This selects the Rockchip RK3288 SoC glue layer support for
>           the stmmac device driver.
>
> +config DWMAC_RZN1
> +       tristate "Renesas RZ/N1 dwmac support"
> +       default ARCH_RZN1

Why default to enabled?

> +       depends on OF && (ARCH_RZN1 || COMPILE_TEST)
> +       select PCS_RZN1_MIIC
> +       help
> +         Support for Ethernet controller on Renesas RZ/N1 SoC family.
> +
> +         This selects the Renesas RZ/N1 SoC glue layer support for
> +         the stmmac device driver. This support can make use of a custom=
 MII
> +         converter PCS device.
> +
>  config DWMAC_SOCFPGA
>         tristate "SOCFPGA dwmac support"
>         default ARCH_INTEL_SOCFPGA

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


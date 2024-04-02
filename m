Return-Path: <linux-kernel+bounces-128071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA198955AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2226283A03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D71272D9;
	Tue,  2 Apr 2024 13:43:20 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED883CD8;
	Tue,  2 Apr 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065399; cv=none; b=TD27JDC956vEKAYx0CAHVLnsp/WyRpRlRSLlQpZJasuDZKrH0welxuGv+ISx2NK80sYSO9dyJGgUXaCQ7PZQ+FyxnVxd7NO1ARigdshBT9zSz1qtp2u01U+utu70diS+kT/gF8JOqCDP1JbSNaLAAYTYvwDegy8JNgbSFD4zXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065399; c=relaxed/simple;
	bh=Bgs/DM8+2fxPQwsVMUWClMrsmnaC2kMFq4hy3uSBZrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXue29yPOSLMDSoOT7s8hZkgvUOh4KB0KyyMc69/DClTdjxgiDYfGlgwK5+brS0smBZtbWx17gM6y6LpiRWBa6ehQKx/Rf2EuT5YiIp3vPfb6M+ZN3LQlJPgVTszrjzg6VrRZfW+KilTETS/8wPkJa91dTBj8YVxUo5wrkwroPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61149e50602so35429347b3.0;
        Tue, 02 Apr 2024 06:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065394; x=1712670194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtPJLQoZZ3Deaa6exFS7kU96LFRYdL8NjqNyc0/RmVs=;
        b=ZkrIDG81VslIeVKi6afJ7JPLA8EfhT9iNyW8k7l1BEWlFRM+pSq29/iA9sCf2q92Ja
         Te0cD4PN0uXqzEze+lnAWHrMF/TuN0D1bGCu9VcwaX+RoLMVzJmF3XEhK2IIVz2WEvut
         UJ8KS4E27zdDMRVpggPnd4bY+pdZ3HFmwRr7R8iKLLyg4Tj6/4ZyDnsWax5kGXaCK8yN
         WrgQWp+C8q7k2Ynabi2BZ+M9Lv3vsQs4gP39dJSvez/CvGTKojq1iCdHI+8G0QHfmzGI
         Fs5Cu/va1kAWa/I282KjfsBmjFWKJZinrofXbJXrXtkdT5pPoQomfGzJcqANr1sJENy6
         OPDw==
X-Forwarded-Encrypted: i=1; AJvYcCVGOlQcs4Lb7ZQmL7bYpRDeVPc1Es+n03N0edztksin8nWu8W+Daero512gaTOSHhXs9cTmFsbknjUqHUPzfJ+CU5zlr8yGyuxypX7fkIZurJhHbXVKHWbUqPzi4jUCfpd5zM06WtIG1ufA8IpDGoTVGxLClZh6aNEMyodIiSjAqvMrXGqBs4ohOypRascpss498BSg9JoQfMfa8wxZ9CoieZsj
X-Gm-Message-State: AOJu0YyixYCOFyhwcgriyDRUxJxWpeMtXX+5qoeOnBvx8s16KG6ZQc1d
	i0CECu0JCNBTQ8BKkXEHI4nP0mgAuATTLd3h7dzDKECnxavgA1/LbsrNQMlgHNQ=
X-Google-Smtp-Source: AGHT+IHs7HQdkY8u5xVfbQ5/IepyjmnrVrVR9viLtZdzS/XlLXuLS6uhVpg7tnGgU+C/daoCsHcxYg==
X-Received: by 2002:a0d:db10:0:b0:615:e10:691c with SMTP id d16-20020a0ddb10000000b006150e10691cmr2417254ywe.1.1712065394296;
        Tue, 02 Apr 2024 06:43:14 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id d4-20020a81e904000000b00609f4170662sm2772263ywm.54.2024.04.02.06.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 06:43:13 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3772485276.1;
        Tue, 02 Apr 2024 06:43:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/ocIvbr8wVVPIagQurji9Gh5t1yNbzXnvBunKKPQb8WuKSyd3iFbw/lM4N+BUAJ+TMaBgbalESki8vcTh8Rk1Em1IxPW/Al58vWOQryHky58xLgR2n5vwJS3ASgUmNv3M0W8hSw39HxpIaw5Sbj5ZRf6E9UoDVAWwmV/2RrxKP89zhY/Mgitsla49swAswY7ub0NHEjY3TPVE+PafhRsDCiP9
X-Received: by 2002:a25:f912:0:b0:dc7:494e:ff33 with SMTP id
 q18-20020a25f912000000b00dc7494eff33mr7752167ybe.7.1712065392498; Tue, 02 Apr
 2024 06:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-rzn1-gmac1-v1-0-5be2b2894d8c@bootlin.com> <20240402-rzn1-gmac1-v1-1-5be2b2894d8c@bootlin.com>
In-Reply-To: <20240402-rzn1-gmac1-v1-1-5be2b2894d8c@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Apr 2024 15:43:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=Hbv8Qiyf=Ot_kHTbfPo0yk+NkutS80uC6cuAWYMsyg@mail.gmail.com>
Message-ID: <CAMuHMdW=Hbv8Qiyf=Ot_kHTbfPo0yk+NkutS80uC6cuAWYMsyg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: renesas,rzn1-gmac:
 Document RZ/N1 GMAC support
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

On Tue, Apr 2, 2024 at 2:36=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>
> The RZ/N1 series of MPUs feature up to two Gigabit Ethernet controllers.
> These controllers are based on Synopsys IPs. They can be connected to
> RZ/N1 RGMII/RMII converters.
>
> Add a binding that describes these GMAC devices.
>
> Signed-off-by: "Cl=C3=A9ment L=C3=A9ger" <clement.leger@bootlin.com>
> [rgantois: commit log]
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml

> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ethernet@44000000 {
> +      compatible =3D "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snp=
s,dwmac";
> +      reg =3D <0x44000000 0x2000>;
> +      interrupt-parent =3D <&gic>;

There is no need to use interrupt-parent in examples.

> +      interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names =3D "macirq", "eth_wake_irq", "eth_lpi";
> +      clock-names =3D "stmmaceth";
> +      clocks =3D <&sysctrl R9A06G032_HCLK_GMAC0>;

If you want this to be a real example, you should add power-domains.

> +      snps,multicast-filter-bins =3D <256>;
> +      snps,perfect-filter-entries =3D <128>;
> +      tx-fifo-depth =3D <2048>;
> +      rx-fifo-depth =3D <4096>;
> +      pcs-handle =3D <&mii_conv1>;
> +      phy-mode =3D "mii";
> +    };

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


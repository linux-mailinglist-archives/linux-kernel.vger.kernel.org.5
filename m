Return-Path: <linux-kernel+bounces-24714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BE82C131
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189BB1F245D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3C6D1C1;
	Fri, 12 Jan 2024 13:55:53 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE854747;
	Fri, 12 Jan 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e734251f48so51365657b3.1;
        Fri, 12 Jan 2024 05:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705067749; x=1705672549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGC/g2xK3NLCm39yP+e6r0PYYA1RCJNgKN4yfeuv1jg=;
        b=j464jAxDojn+mpXZ8DF+0zxFhFgq2Fz7Btb3Td37lyyBNc4b8xkWpjihox/ClQ5N05
         MfYx4nHRB2eikvVsagt7HSA6k4Wvcp8pmD8CcSuhmb21Xjd4GuQ5kZsDefg+T9PCQCzW
         v3B6sHZMY99BU+28//x9yrmErQB27bf48npNneOWCCz1qjbhmp/RFARByyIDgFhBuIxE
         e8yBfTxc/p0/LbCaSf8d3ugCKBHC3W8BVyq+cdHkmibeiSijgjZWRbFUE7AQJwhNyCQy
         iTYZyARJXGfQ9+qj+yIzeVPh9JK/E04oxMu14AqfuNkXPz5Vi6GO5GoW/M0nlzqjpKlz
         T7EQ==
X-Gm-Message-State: AOJu0YzHAp6avRtMlUBZxlj46PBV0ERIDzbxLizyqH3ZCPNN5boqaENE
	Ttjiqh0j67raZyudHCnNoPW2IbcXZu0AKw==
X-Google-Smtp-Source: AGHT+IGi1dBhWOyIkyhYxPs19Jgh4+Mqa0q+fC5Sry7mDnl0KRNeAhVDlVuKH1WYpyeFATALIuFDeA==
X-Received: by 2002:a81:a188:0:b0:5e7:6f9c:38fe with SMTP id y130-20020a81a188000000b005e76f9c38femr1363891ywg.46.1705067749663;
        Fri, 12 Jan 2024 05:55:49 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x203-20020a81a0d4000000b00583b144fe51sm1345771ywg.118.2024.01.12.05.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 05:55:49 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed179f0faso5183234276.1;
        Fri, 12 Jan 2024 05:55:49 -0800 (PST)
X-Received: by 2002:a25:2e0c:0:b0:dbd:c783:c456 with SMTP id
 u12-20020a252e0c000000b00dbdc783c456mr515265ybu.0.1705067749329; Fri, 12 Jan
 2024 05:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227130810.2744550-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231227130810.2744550-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2024 14:55:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnsJfOtZPpr+_MRNkx-bSXrCm8Hy_j6Gy58WnGn_kaMA@mail.gmail.com>
Message-ID: <CAMuHMdVnsJfOtZPpr+_MRNkx-bSXrCm8Hy_j6Gy58WnGn_kaMA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg3s-smarc: Add gpio keys
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Wed, Dec 27, 2023 at 2:08=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ SMARC Carrier II board has 3 user buttons called USER_SW1, USER_SW2,
> USER_SW3. Add a DT node in device tree to propertly instantiate the
> gpio-keys driver for these buttons.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> @@ -6,6 +6,7 @@
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
>
>  / {
> @@ -14,6 +15,37 @@ aliases {
>                 mmc1 =3D &sdhi1;
>         };
>
> +       keys {

Do you mind if I s/keys/keypad/ while applying? ...

> +               compatible =3D "gpio-keys";
> +
> +               key-1 {
> +                       interrupts =3D <RZG2L_GPIO(18, 0) IRQ_TYPE_EDGE_F=
ALLING>;

Oh, the horror of interrupt controllers that don't support generating
interrupts on both edges...

> +                       interrupt-parent =3D <&pinctrl>;

.. and move these one level up, to avoid duplication?

> +                       linux,code =3D <KEY_1>;
> +                       label =3D "USER_SW1";
> +                       wakeup-source;
> +                       debounce-interval =3D <20>;
> +               };
> +
> +               key-2 {
> +                       interrupts =3D <RZG2L_GPIO(0, 1) IRQ_TYPE_EDGE_FA=
LLING>;
> +                       interrupt-parent =3D <&pinctrl>;
> +                       linux,code =3D <KEY_2>;
> +                       label =3D "USER_SW2";
> +                       wakeup-source;
> +                       debounce-interval =3D <20>;
> +               };
> +
> +               key-3 {
> +                       interrupts =3D <RZG2L_GPIO(0, 3) IRQ_TYPE_EDGE_FA=
LLING>;
> +                       interrupt-parent =3D <&pinctrl>;
> +                       linux,code =3D <KEY_3>;
> +                       label =3D "USER_SW3";
> +                       wakeup-source;
> +                       debounce-interval =3D <20>;
> +               };
> +       };
> +
>         vcc_sdhi1: regulator-vcc-sdhi1 {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "SDHI1 Vcc";

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9, with the above fixed.

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


Return-Path: <linux-kernel+bounces-44389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723E0842162
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231522887BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293826167F;
	Tue, 30 Jan 2024 10:36:01 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39664CB5C;
	Tue, 30 Jan 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610960; cv=none; b=et8Xv2jlHGxJLX7k1BGxpzm1TGs8ID1bCxln0IN+TSSRcTwpZ1JPGTDvIw5Tu5pQQPk4wfJUXd86ssfLIbuidIq03XANcL0OCaNyNYK76pd9FKHcNNAwU1w8rR5fCvWTOnaPrf94DKIWH33/66eicOkhpDffA8itiCDKjqg6iq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610960; c=relaxed/simple;
	bh=vu98Ow8o+WlmXPUNQ2emf58lo4+54/kVDsI9A48tKaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUqdM/vDLed8iWgmTqvYBrISlnk+K9LAlqlwX4Vu11IYg0sHM6k6hS2CZojojNDvc8MTGt1nDYgWzqHu7Diw0FuqJxj9CrDOjwBQohXuijLnlxllHX3bHgQDQMV1vjya7PEkhEw29cuuv0m/HccHH3jW7Re2oA1FZ5HEGKY5ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-602cf7dfeb1so36175537b3.0;
        Tue, 30 Jan 2024 02:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610958; x=1707215758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WN4By9g1R8VONEj0WkCZM2w34ceTM0wwvtPvj+64KfA=;
        b=JjD2VOwo5CdOWdORh7XKPaBPRPe4rcL6wQtMuWs1R0GqVqHk0uTH5mL8UGcKEH6jCy
         FRLiy9z7sVYKGNtHud76ebaxTRRIRsozXu7R5tUenNqQjr6+//mNMif3e9Mr5SiaAMrV
         b1xAIwsVFsyTdauLsiGt8PQ4Y6djxPRRIrZy7ySwJmYuVxMsj69LPOEcL5fJGtrMbMyQ
         nwBPPxP5hsI2ozneKwqaF52AMOQl6E9BH1jdhQ66NsSnBkt5mtm8uthbCahfY5K7CHSZ
         P23d8NMMWMcTtskGlfs/2PvaJaXv9CGHYQjVuFnc1+R9+hR/gSD9P2qqWuqRUlDvpq/p
         C0ig==
X-Gm-Message-State: AOJu0Yz1pS0SSXk+Nse05XVj7+LQMj6/b70xyc5lJM2gDReWRItaEL1T
	5t/zzpW6/YySo3MS+g2Xxfcg39Kq2u9ihXMmCbIqXuaqE3bK2kDV+LR9+8kOcG4=
X-Google-Smtp-Source: AGHT+IENQebvKie75RdRFdNt/7v6tZ1m52BP9ZMds9Tf522MK0ZbEi242IHCm5DMadF+lJaAg2pmoA==
X-Received: by 2002:a81:b048:0:b0:602:cd56:ef9a with SMTP id x8-20020a81b048000000b00602cd56ef9amr5358781ywk.36.1706610957684;
        Tue, 30 Jan 2024 02:35:57 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id ck26-20020a05690c0b9a00b005ffd1bf706fsm3081298ywb.96.2024.01.30.02.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:35:57 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-602cf7dfeb1so36175407b3.0;
        Tue, 30 Jan 2024 02:35:57 -0800 (PST)
X-Received: by 2002:a81:bd50:0:b0:602:9dd4:d717 with SMTP id
 n16-20020a81bd50000000b006029dd4d717mr5032538ywk.49.1706610957362; Tue, 30
 Jan 2024 02:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129135556.63466-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129135556.63466-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 11:35:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbPooCMqyKjTh+uJgAqh=az0+DOQAJYKQ7cuBrxyV1-w@mail.gmail.com>
Message-ID: <CAMuHMdWbPooCMqyKjTh+uJgAqh=az0+DOQAJYKQ7cuBrxyV1-w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] pinctrl: renesas: rzg2l: Improve code for readability
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

Hi Prabhakar,

On Mon, Jan 29, 2024 at 2:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> As the RZ/G2L pinctrl driver is extensively utilized by numerous SoCs and
> has experienced substantial growth, enhance code readability by
> incorporating FIELD_PREP_CONST/FIELD_GET macros wherever necessary.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.9.

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c

> @@ -90,14 +93,18 @@
>   * (b * 8) and f is the pin configuration capabilities supported.
>   */
>  #define RZG2L_SINGLE_PIN               BIT(31)
> +#define RZG2L_SINGLE_PIN_INDEX_MASK    GENMASK(30, 24)
> +#define RZG2L_SINGLE_PIN_BITS_MASK     GENMASK(22, 20)
> +
>  #define RZG2L_SINGLE_PIN_PACK(p, b, f) (RZG2L_SINGLE_PIN | \
> -                                        ((p) << 24) | ((b) << 20) | (f))
> -#define RZG2L_SINGLE_PIN_GET_BIT(x)    (((x) & GENMASK(22, 20)) >> 20)
> +                                        FIELD_PREP_CONST(RZG2L_SINGLE_PI=
N_INDEX_MASK, (p)) | \
> +                                        FIELD_PREP_CONST(RZG2L_SINGLE_PI=
N_BITS_MASK, (b)) | \
> +                                        FIELD_PREP_CONST(PIN_CFG_MASK, (=
f)))
>
> -#define RZG2L_PIN_CFG_TO_CAPS(cfg)             ((cfg) & GENMASK(19, 0))
> +#define RZG2L_PIN_CFG_TO_CAPS(cfg)             ((cfg) & PIN_CFG_MASK)

Do you mind if I drop RZG2L_PIN_CFG_TO_CAPS() and replace its two
users by FIELD_GET(PIN_CFG_MASK, *pin_data) while applying?

>  #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)      ((cfg) & RZG2L_SINGLE_PIN=
 ? \
> -                                               (((cfg) & GENMASK(30, 24)=
) >> 24) : \
> -                                               (((cfg) & GENMASK(26, 20)=
) >> 20))
> +                                                FIELD_GET(RZG2L_SINGLE_P=
IN_INDEX_MASK, (cfg)) : \
> +                                                FIELD_GET(PIN_CFG_PIN_RE=
G_MASK, (cfg)))
>
>  #define P(off)                 (0x0000 + (off))
>  #define PM(off)                        (0x0100 + (off) * 2)

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


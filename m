Return-Path: <linux-kernel+bounces-24856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3482C384
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C21F21BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA4974E15;
	Fri, 12 Jan 2024 16:20:54 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53D745CD;
	Fri, 12 Jan 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f3da7ba2bfso68077987b3.3;
        Fri, 12 Jan 2024 08:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076451; x=1705681251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cpwkfjYe1zF94sQukQ8o3Koi2YLeB3fY8FqoXNE21c=;
        b=uGUCM9YbXy9m+xstVPQFrJXqMG2wZQ+3pACpus8qw4jhq9IMEIXG5CHt4HouG0GY+3
         rsvirF6JDz4+LpLGb++UxWqBpdBqF9+2ioue0zUaSLoGlDgVi1zszXt9ZIRESJjxI6HO
         Eq63I61SgEI7UMcyA80o0/WUWqN7/QUuBU0OQdS6FyPLXJGig/8Qjn+T9WAPiYqWwDi2
         Et99FFCl2XB65crSYWWaomYrhA6B7hK2p2fOEDr2iIa7w5DIPvPn9nILaNiiBLH3O/Ch
         K5OjNG02ddo5w39fxRRHcev6DxCfy3tE5wf8bgLSJK76b6HZEHXz1rAFUeN9qvWN8t87
         4bQw==
X-Gm-Message-State: AOJu0Yzqs6wsMFERWU/kcfJgQrEJ4oAB+0suaVcKGopkLNMaICcnFwzu
	tS7XOvvrRhL9+kp9epwANEPpCPmQ0a5aMQ==
X-Google-Smtp-Source: AGHT+IG7Dgz/aNlBMZeIRpYwmKvZqYxUjK3D6zzq0oyomm6WGwhsSphdtu5Q/cRiIipOExiuY7CiFw==
X-Received: by 2002:a05:690c:f8e:b0:5e8:2eac:d77b with SMTP id df14-20020a05690c0f8e00b005e82eacd77bmr1811764ywb.9.1705076451242;
        Fri, 12 Jan 2024 08:20:51 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u80-20020a818453000000b005e7467eaa43sm1459526ywf.32.2024.01.12.08.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:20:51 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso69925147b3.1;
        Fri, 12 Jan 2024 08:20:51 -0800 (PST)
X-Received: by 2002:a05:690c:b08:b0:5ee:381a:3b33 with SMTP id
 cj8-20020a05690c0b0800b005ee381a3b33mr1571767ywb.94.1705076450821; Fri, 12
 Jan 2024 08:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227130810.2744550-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVnsJfOtZPpr+_MRNkx-bSXrCm8Hy_j6Gy58WnGn_kaMA@mail.gmail.com> <30608a28-b1e3-4ad3-aad5-1033eb8adc6f@tuxon.dev>
In-Reply-To: <30608a28-b1e3-4ad3-aad5-1033eb8adc6f@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2024 17:20:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXokhEEARUSSY_x74A0eRGpeJ2Y30neMP57fnjRJ7HQeg@mail.gmail.com>
Message-ID: <CAMuHMdXokhEEARUSSY_x74A0eRGpeJ2Y30neMP57fnjRJ7HQeg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg3s-smarc: Add gpio keys
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Fri, Jan 12, 2024 at 4:38=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 12.01.2024 15:55, Geert Uytterhoeven wrote:
> > On Wed, Dec 27, 2023 at 2:08=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> RZ SMARC Carrier II board has 3 user buttons called USER_SW1, USER_SW2=
,
> >> USER_SW3. Add a DT node in device tree to propertly instantiate the
> >> gpio-keys driver for these buttons.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> >> @@ -14,6 +15,37 @@ aliases {
> >>                 mmc1 =3D &sdhi1;
> >>         };
> >>
> >> +       keys {
> >
> > Do you mind if I s/keys/keypad/ while applying? ...
>
> Is not actually a keypad... there are 3 buttons in a corner of the board.=
.
>
> I see only 2 entries in arm64 and arm DTS directory following this patter=
n
> for gpio-keys compatible node:
>
>  arch/arm/boot/dts/renesas/r8a7779-marzen.dts
>  arch/arm/boot/dts/renesas/r8a7779-marzen.dts
>
> But if you prefer it like this, I have nothing against.
>
> Just asking, do you have a particular reason for naming it like this?

See the discussion in [1], and the resulting patch[2], which added the
(so far) single user in arch/arm/boot/dts/renesas/r8a7779-marzen.dts

[1] https://lore.kernel.org/all/20231023144134.1881973-1-geert+renesas@glid=
er.be
[2] https://lore.kernel.org/all/eec1ccfb75c6215428609fdcaf3a37c75fe1fc87.16=
98228163.git.geert+renesas@glider.be
>
> >> +                       interrupt-parent =3D <&pinctrl>;
> >
> > ... and move these one level up, to avoid duplication?
>
> Moving it just near compatible will make the schema validation to fail wi=
th
> this (driver is working, though):
>
> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: keys:
> 'interrupt-parent' does not match any of the regexes:
> '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]=
+-(button|event|key|switch))$',
> 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.ya=
ml#

Oops, I had completely forgotten r8a7779-marzen.dts triggers this, too...
Let's keep it for now.

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


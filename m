Return-Path: <linux-kernel+bounces-68718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB751857EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8259A1F21F28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673F12CDA8;
	Fri, 16 Feb 2024 14:11:26 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376612D74F;
	Fri, 16 Feb 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092686; cv=none; b=lPeefDcIJGzIjipG3MZj9WQbDRfpcM2k1EPG1t1MVjihenxuQU0fmAW2KIVrCkDVOSm5c6RnuTVh9NzZPlx/m/tE4uhGaKICLo6ClL3VvvvHZjO6WvMqCOGcp7rhViXVtneB10fLXXwTIQXVqvyV67edxgTPWlhgzCbdOC8o2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092686; c=relaxed/simple;
	bh=6fW4bZTExT57+omxawRI0Je+VWBz4e0M9Fy7QMI9JSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiJ9Qvi4wCOAXJj2dv16k+B9ZSmEV6kENw3TZsvJHnJktwY/to7Q32CAy9kqrAkRlbokO45nzCD2vGKkdCt1NCB5xD5Cl3DdN0RqkEpSTSaK/pAE8Kto1z0gBJDcz85MBez/b8ekPE6EO7KZnZgFO2p2lnM3V3WUmf/7IXUXQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607dec82853so15918177b3.3;
        Fri, 16 Feb 2024 06:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092682; x=1708697482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhKX/Qgrm7Zf7JKAIxtMZgwZqvuWek0AD+yFUOpkk1I=;
        b=F21qZ4L815pdt/IQ82pfJuatw761MbTBxIepaC3RJBbHvWWbzgpDmVLErmBt9PyyUP
         Ezr25ob9hWyQya4nsfLos9ezMAjRGIbQrzSuVIThrW31iLzxopEmphLZDwenJp5Hr9VF
         o4KlI4wMjd+ObQgYFA/4bJZkV8+QmUAYFDKXNtVPBFaUqHV0ugHOz8LrD8n93tP9kjFa
         p4ijG3ZFhCNEQ+W/4lStcHgejT7Napck2UKUGva8Zy3nAy9fX+Qo9TimR/qyXmnBoY7Y
         9kip+nSrZejO83AK+6vyqrxZn/39IH9uxGbX/ogD6RQFaT4PPsQga4HVSqWI6WSkAmGE
         ftEg==
X-Forwarded-Encrypted: i=1; AJvYcCW/h9Oo5IDnSGPFhrihDlUN5gUA4cpGECX1Aa6AXP9/ff8bXb9wCXdN0ujsbT7TY5ZKJ96Dkidta24ugRCGfufY6Gx66miKR4QotDPRhPJ0F04+miiEOP1vYPk4nNSgqcpzMCbCHrcPVsIiY8rP11wlX59wA1jFZ7gyPEwROsIGE99UmqgHN+Rai1a8x/51G/DGG1wzEGPQnHWsw1AaLd+R4buvmqZc
X-Gm-Message-State: AOJu0YyWKEki229nliwYV2u0gZoyLeOzB1nWdRyQjUz3NAWzpbGJomaE
	dY0d77ES0VohVZqCeiT+wkoi5f1m7+uKC4lJo7Ty/d91oV/gDcQAZxlMzhBNlNE=
X-Google-Smtp-Source: AGHT+IFPxUen8nvi5O7HRuL3uresvE8DV69AC/OnDfxrW3DhmYeDlR9QUqMlmFA4GsaN+UT+l2kbgg==
X-Received: by 2002:a81:9945:0:b0:607:d9fb:5144 with SMTP id q66-20020a819945000000b00607d9fb5144mr4222330ywg.13.1708092682187;
        Fri, 16 Feb 2024 06:11:22 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id l37-20020a81ad25000000b00607fba01268sm257138ywh.50.2024.02.16.06.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:11:21 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607dec82853so15917637b3.3;
        Fri, 16 Feb 2024 06:11:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVu3OIveL1HhEA+4K4aCwAMg+yPNLRMeoJKlLvc4bf+Y6aVQZSYGZ84qWLmRg0YI8VFLu5j713hPtgII8Z464BMQORUq262x1LEwR/mSkIA763hv3X+Zbkig93vjwAilTHZKyf9iKaZso0126ZfRSiKSEPQx7dYjvtBiXAGNowVqupPDFlKD+UNZdM4mGoDz22S5bxG3aRPJTdSD0/r36Rg2HfKMQ3U
X-Received: by 2002:a0d:d7d2:0:b0:607:90a5:dc1d with SMTP id
 z201-20020a0dd7d2000000b0060790a5dc1dmr4365288ywd.17.1708092681385; Fri, 16
 Feb 2024 06:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-14-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-14-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:11:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW63y2NcdcMsZC4gnP5u6rHSumGB5oEAvzY9ZH4u=Oqkw@mail.gmail.com>
Message-ID: <CAMuHMdW63y2NcdcMsZC4gnP5u6rHSumGB5oEAvzY9ZH4u=Oqkw@mail.gmail.com>
Subject: Re: [PATCH 13/17] arm64: dts: renesas: r9a07g043: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Update CPG #power-domain-cells =3D <1> and move all the IPs to be part of=
 the
> always on power domain as the driver has been modified to support multipl=
e
> power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -138,7 +138,7 @@ mtu3: timer@10001200 {
>                                           "tgia8", "tgib8", "tgic8", "tgi=
d8",
>                                           "tciv8", "tciu8";
>                         clocks =3D <&cpg CPG_MOD R9A07G043_MTU_X_MCK_MTU3=
>;
> -                       power-domains =3D <&cpg>;
> +                       power-domains =3D <&cpg R9A07G043_PD_ALWAYS_ON>;

This should be R9A07G043_PD_MTU, but that domain is not yet supported
by the driver.  Instead of adding incorrect hardware descriptions,
I'd rather defer this until all domains are handled by the driver.

>                         resets =3D <&cpg R9A07G043_MTU_X_PRESET_MTU3>;
>                         #pwm-cells =3D <2>;
>                         status =3D "disabled";

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


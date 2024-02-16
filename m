Return-Path: <linux-kernel+bounces-68721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC05857F00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8681F26C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9412CDBB;
	Fri, 16 Feb 2024 14:11:57 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800712A17B;
	Fri, 16 Feb 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092716; cv=none; b=aEFT3IFlMsxVauRDqirbTkMbhRg8Q/jQM6KQ1a2Lv/laGLljyd0un5pZlRrDG+4Nm5+AcB3+4/2aGXOoIHoYES62CvVZvHub548c+YgfjGNFADQ1ieG8FyLVoaXerj8A1OhSKp72+6OKmZZowjIg4kM7jACvY9CojVPpMmJqI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092716; c=relaxed/simple;
	bh=ZlaFYuhHeGTwAD7dc+dOUmGN2x2vdBItaGODlzTu3ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBuB3dPRsxJApqHcaOjVuCYfhT+vEe7YiNWwJQ3NNahPcAg99bl8/tTZHHV9YghKNPKyogzl9fOa+MkS3tjH/T/jpzSaoq+zUYfa1IcadWqZKuuFimeNzeR2gIUOnkPYm/ex6CYSnPrUOJEvFnv82iXXOOmWj4IKz4K23euO68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607fbb1ae38so6842837b3.3;
        Fri, 16 Feb 2024 06:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092712; x=1708697512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqGO92Q0ogoosij/1rf7SWylqz3srKBwNAJl+a8awB0=;
        b=s70WfXn+I65YwpI910aEep7JRYwyW3J8tsdWvCP7YCTbKiPoPbO24j4fjiJMEQxQGM
         6SwnwKEcSHocxyl08M+Jw1TNoTSug0T9roXl90bqFBARPslzJJctYQCQwmi7T0poTkeE
         qAUIlhkY3N8RsbQVRTHT2KkfelBdXnYfExH6Z6C4gXpbCkS4RXOH4o03OLEzU6Rjz8ye
         u4+MMZRPuuXx7QYbhO1qPOp6lgkq1qZHaBzU/vp4vua9mMGSqDeGpFy+BuKaIIqZrQ1N
         RKJfXANX7WL8qf+H2qhCBUr8wO073t1adfox/XQHnTmIIzABJ/zEQ4JQdyu6ybc5rp9q
         fg8g==
X-Forwarded-Encrypted: i=1; AJvYcCUROye+XRwgE6m7ERMwkUd+bcPdcOZZskCcosPOac5NbQnDZafGHJh/uFEWCp+11nn7sZARkjyGXZa12Qi22XlSwrs0mIpvXoNEcGFKdoC8MlLLTQFAHrTU/OBY2vVE26iBgWtUDsktfyvjRq76zNdd9+tflUiUB39cwUE/Ok2kt7w0aRyRTD2HeHocWqU+2j/DWprk84fA6Dd2o3Vgea/RyN4dVt1e
X-Gm-Message-State: AOJu0YzBNKVZa+mx9wpu06qAvkmDUobDGNOsdTKEOyMbY0M0n9a15YZ9
	7gPGWvhIg7nfhODK5wGqDv2awGXAe3YI3dpL5Srp5kHxYPYdWGmf6ELQ9KUy1qI=
X-Google-Smtp-Source: AGHT+IGMXI61eXB44IetCodTziQ78odLm7PnMXVLFz2hFt5sWZ8G5uZTy0s8KEmhHCdjtFflbXQM7A==
X-Received: by 2002:a81:60c2:0:b0:5ff:42f2:ef75 with SMTP id u185-20020a8160c2000000b005ff42f2ef75mr5951412ywb.16.1708092712204;
        Fri, 16 Feb 2024 06:11:52 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id t75-20020a81834e000000b00607a75ae26csm357890ywf.17.2024.02.16.06.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:11:51 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607fbb1ae38so6842037b3.3;
        Fri, 16 Feb 2024 06:11:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmKMSEsAffjPNiw6jps3r1m6yRd6weovireTkm1FOmRI65TYR02D8602rivASUxMf4wpIHoAGq0J+YM/U8iRYW++B4fVBEJS/NICq3yzyyTLeyrJ23KmoEzWHSkLJzd5VcXwtsMmsDAuw9WNQbk5PRJhY1HmwBKtOKg9CiPosiuW30elqGRJ+gqEeaLeqaE9FTTewHCgBGcucSFl06NfjCkdNruP8D
X-Received: by 2002:a81:7b41:0:b0:607:7e16:347a with SMTP id
 w62-20020a817b41000000b006077e16347amr5563931ywc.42.1708092711263; Fri, 16
 Feb 2024 06:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-16-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-16-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:11:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbp2mvFyjyr9+qmuAiSip33OaVnxR-hatOtzAjTYtycg@mail.gmail.com>
Message-ID: <CAMuHMdXbp2mvFyjyr9+qmuAiSip33OaVnxR-hatOtzAjTYtycg@mail.gmail.com>
Subject: Re: [PATCH 15/17] arm64: dts: renesas: r9a07g054: Update
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

> --- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
> @@ -238,7 +238,7 @@ mtu3: timer@10001200 {
>                                           "tgia8", "tgib8", "tgic8", "tgi=
d8",
>                                           "tciv8", "tciu8";
>                         clocks =3D <&cpg CPG_MOD R9A07G054_MTU_X_MCK_MTU3=
>;
> -                       power-domains =3D <&cpg>;
> +                       power-domains =3D <&cpg R9A07G054_PD_ALWAYS_ON>;

This should be R9A07G054_PD_MTU, but that domain is not yet supported
by the driver.  Instead of adding incorrect hardware descriptions,
I'd rather defer this until all domains are handled by the driver.

>                         resets =3D <&cpg R9A07G054_MTU_X_PRESET_MTU3>;
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


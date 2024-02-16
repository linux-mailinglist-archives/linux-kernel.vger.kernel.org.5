Return-Path: <linux-kernel+bounces-68691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF08857E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFD81C25331
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFD112AAD9;
	Fri, 16 Feb 2024 14:03:02 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4C12C528;
	Fri, 16 Feb 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092181; cv=none; b=JJ8lUWfb3WWkEM0GXwk/2hfmeF7R4PsninpGDu3PyaFe3eJbzoIZs119NLEHcPv6WYHSc0NPDs4W9s4HQw7lCoN5ZTjgYcktOFbCL792/VUuaJMDDUCx4Wtu7/x7NfrXmyL5YhHTmxrgq2lSSccg9+gjpA6rK5sM6J/JF+TMyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092181; c=relaxed/simple;
	bh=r0wqvtGHWVY8ejQHJfmPC3+7EEVi5665H2D7ClFrS1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmblMOZdcr/SyqC1BDmXqYbYc/7DFz7R2KN86YEk1WTgqUivzDehDG6bPY7oXpi5csRLXN3jZSaj9AkK3RGosthu57Lso6WH9yOpnqVtRegvSpgJ/ubtFilUTjplHYkpvx1rnGJIw46R8F3CC1jT0BjI/XD3re+QDvzomGZnSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607eefeea90so10214047b3.1;
        Fri, 16 Feb 2024 06:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092178; x=1708696978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYIkHfrtyBzrh6C/58ppcoahvJUtd8BAYczbWxm3cHM=;
        b=Fuu3MDvgxgsPPTjqNm8TKXMrxeZ3nmP+IJHLC8uymvJ3a5b4ssATxTW+iFwMk97MpG
         hRTynEZoWhI+0NNznTWDtIJgZceCpV6ueZhQ2Rdd3p3z3rFh0eqL7iRdDgo0TAXpMs1W
         2lUN5fjXO1C0zL1WcQfjkMtYqjawZ30AAQix6Ux2awSFcxpcgNFgidacbvRw6iqI3428
         wlyo0+py8XJfCoBYGR/nB2cntvZuW0D49kl+YIQ3Ynmqn0ZwfabuhCRMoM3Lopv+poGe
         rR6ViS0AeYUrHn8Fy0y4VwfNkFaOkh8o6okKMejYMD50S+c/I6hh4imVOELwqcdHwqd+
         MC8g==
X-Forwarded-Encrypted: i=1; AJvYcCUXTDVdrWaA5Gqxwjfbw3nBGJs/88jd/Ktn1RqolRcdrXDDhUiRGAFNmalw7cjbRA2qzSJWnoXHa8PxgaAzUsbBPwNPIVB8uATCi6nzzEgMr1w8ANZSxi7JIFCAVtmHE9Lo2YJZP4pOxXYXA+vC8/oeqgT6Xsl73oDJKk2p5Oo2oxtEZ5cXVTDaFD6ir9fGjtm/3B7jA3nGNKFjIg7GH/f1k8hIj4Kl
X-Gm-Message-State: AOJu0Ywwq5r4Xcdv0NpF9PXmdGxJ7P37xHxQ/C+F19CGL4bzMHHle2BQ
	+Fx6vhvZsO1YzclrdCViceBrJ6h/4YE6ZKLTJwFQW4FKQR5Hh+lU9hG76u0gHpM=
X-Google-Smtp-Source: AGHT+IHxnZzlkSe9gnRhW8vIJkIBfraDoA7vUo8jckegxs/GkA0/4F3E0szK5D3tZ4d+dEyKHLXkmQ==
X-Received: by 2002:a0d:ccd4:0:b0:604:df56:29d5 with SMTP id o203-20020a0dccd4000000b00604df5629d5mr3506988ywd.2.1708092178014;
        Fri, 16 Feb 2024 06:02:58 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id l37-20020a81ad25000000b00607fba01268sm254245ywh.50.2024.02.16.06.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:02:57 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6077444cb51so22790137b3.1;
        Fri, 16 Feb 2024 06:02:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbSTeoSH4xOZ6vdoDSaVptcgDWjkfVkQUj/Jc4nQiCRd/bp/NJqNidpseQxOTzPQUk3vYD5ygFR2AUMPfZqizWrQBTFEfHdjFTN5xCkijjTev8+HQCdeySu88ExTfO/nPtR4e/2QCQKaUVTzLyEaJAhfN8frFtu/EiBG+zXJotAk2nNahgZvR/gvEYd6Qtc+hqZ74cnkzO9abXIl8GxhK0izk22ydp
X-Received: by 2002:a0d:ca12:0:b0:604:8433:5834 with SMTP id
 m18-20020a0dca12000000b0060484335834mr3367318ywd.9.1708092177370; Fri, 16 Feb
 2024 06:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:02:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV5+tP7+z0_SUfd0vnRao-LwU8uN61Yq59OjUL_ZztujQ@mail.gmail.com>
Message-ID: <CAMuHMdV5+tP7+z0_SUfd0vnRao-LwU8uN61Yq59OjUL_ZztujQ@mail.gmail.com>
Subject: Re: [PATCH 03/17] dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
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

On Thu, Feb 8, 2024 at 1:43=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add power domain IDs for RZ/V2L (R9A07G054) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

I was a bit surprised to see no new definitions for the RZ/V2L blocks
that are not present on RZ/G2L (e.g. DRP), but the documentation agrees.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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


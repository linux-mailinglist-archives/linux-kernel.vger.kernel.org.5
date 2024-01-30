Return-Path: <linux-kernel+bounces-44397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793ED842181
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A311C243CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73385664B3;
	Tue, 30 Jan 2024 10:37:17 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536860DCB;
	Tue, 30 Jan 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611037; cv=none; b=PA2uCgC3wsJ9wRHfTFq3qDbVFAw/pgveI4KXuyHmXnv06RgtQz+iTTP/XZENp8+2NeEn5M4Oycqyvd68KduIiHo3+h8AM4VmHeO+Aikmz+K+X+0EotP5Q65F7vLDyUXph0SZzthsDF35I2M/D4+WURMMGKV7TNTFfgbMmaNGBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611037; c=relaxed/simple;
	bh=o4SIw1MsOZqjCHoG26s43p+YhsuNKyDrb6bLrGJ9cmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2fEgsHsI0XPiSZoK91eXchXr75a/1oBaMmX60nlOQecDkSb0nTYI7tKFOYyQfd8JqqKmnWXEc6nFNKOwjlcXBzukt2PJ/1TIHvUMzCZjdoZhCLILu9Xt/NdgCrANaMWGuu9Xw2QqTOMY0sMHn4Zi7rK7tJq1xHfVe79GaoLjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-603f3946f0eso3025997b3.1;
        Tue, 30 Jan 2024 02:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611034; x=1707215834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19lEWnW+fTM5E0eE3+Mc9J8ZaYPIteOuYV4JI4QwkRc=;
        b=MsIEdaego12Pw8zRpOQz8hcxTD54Bz4Cf9PJ71ygXOQypiyyrVl/K3Jcvv+0msCI89
         KaHceNyg8mJv1M3jGdQ+aWKgPBpHGN/0JwbQJNiUdWjInFI9uSk5oRm+6xP95TJGkGUF
         QSL8Ikop8gRh9yvQIPFByd6BvwSJjwXj1uLak989INpF/EF11nzVtJOhNgvP1yZWl3jv
         G6G/DD3Iia/T4/GwDCpWYFg81bTzqji7nhc/VR7mEecP52zXr2Vhs653BdHQaPAZkb2Z
         frMMe/DlNhMh8gXMSxKnWykU2oSmFjzMNn2YLuC8eYdHv67bm1cxRr/svYO4CSdroMMv
         WwOA==
X-Gm-Message-State: AOJu0YwbtrPupZFl3y2OYlkFLXe+LxYGQs46swYxj4eYv3csXaHk6HDp
	Qh9jISQBs1//M4CRGqzRAYk6ChZ/NcCXSM2NSj3Ic3k8dXwkxRdfZQW1/5EJMnU=
X-Google-Smtp-Source: AGHT+IF6/kKek6TdOLehOY/dpiVEKa0eU4Mi84wA2NgnL5glgRM4Ti7GecYkpX3svzY8ZYAvpunMfw==
X-Received: by 2002:a0d:f4c3:0:b0:5ff:55f6:7537 with SMTP id d186-20020a0df4c3000000b005ff55f67537mr5898108ywf.5.1706611034460;
        Tue, 30 Jan 2024 02:37:14 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id q131-20020a819989000000b00600392410ffsm3148549ywg.73.2024.01.30.02.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:37:14 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff7ec8772dso39741307b3.0;
        Tue, 30 Jan 2024 02:37:14 -0800 (PST)
X-Received: by 2002:a05:690c:3508:b0:5ed:a4e8:510 with SMTP id
 fq8-20020a05690c350800b005eda4e80510mr7143838ywb.14.1706611033979; Tue, 30
 Jan 2024 02:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129135556.63466-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129135556.63466-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 11:37:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9XEPQGxtVVT46H8QskFOAcYYjE3qve21EaBcTCpRAMg@mail.gmail.com>
Message-ID: <CAMuHMdX9XEPQGxtVVT46H8QskFOAcYYjE3qve21EaBcTCpRAMg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
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

On Mon, Jan 29, 2024 at 2:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add the missing port pins P19 to P28 for RZ/Five SoC. These additional
> pins provide expanded capabilities and are exclusive to the RZ/Five SoC.
>
> Couple of port pins have different configuration and are not identical fo=
r
> the complete port so introduce struct rzg2l_variable_pin_cfg to handle
> such cases and introduce the PIN_CFG_VARIABLE macro. The actual pin confi=
g
> is then assigned in rzg2l_pinctrl_get_variable_pin_cfg().
>
> Add an additional check in rzg2l_gpio_get_gpioint() to only allow GPIO pi=
ns
> which support interrupt facility.
>
> While at define RZG2L_GPIO_PORT_PACK() using RZG2L_GPIO_PORT_SPARSE_PACK(=
).
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.9.

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


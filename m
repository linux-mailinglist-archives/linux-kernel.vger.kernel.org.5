Return-Path: <linux-kernel+bounces-61955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669785191C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22528281BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07013D55A;
	Mon, 12 Feb 2024 16:28:19 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85363D556;
	Mon, 12 Feb 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755299; cv=none; b=u2Qxj4ON2kNX8zUiCsv08OBArzcDc+Nllkv99lPy5X8N+QGAEIiyz4xao8JgIjOsMlnMqlORj97+j5GgYcQQ/0u+rbGQrJj82RX4J5+Pd54WPvyB+loI+e9eji2nPSk/AtTLKZuLF5nbol5Ie3cUTCwJ5WBWzZjHvj6byk5OIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755299; c=relaxed/simple;
	bh=FwSmj40KHI9q4fP0jEOfUy7Iegfc7L/g/89ztN2HV0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/DtBX20avp/Q3bKYe4OcKkGyxi3f+Zb0cWTa2aIphSxr4/N1t/sfaLDjPIIuqBn6rgmrlX/K0n6r7H5rDJIlImt7tloxyHJuf6/2BPIOMdcAWcwhUHaepTSC7LGHetCmeV5xo52SoYWEeilf/imgzRsWXVDbn2eA6dmUEGeVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60491cb9571so31337867b3.0;
        Mon, 12 Feb 2024 08:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755295; x=1708360095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA6Gogw1d1PUCHDqcxvzd0ivtdZaDl7Z3Y82qi5GOdE=;
        b=eKmvbTUwFUPYYgVBDVTtf1jsdmnMkquzSvVYjfU/F3p8FoAhDHeLx00EqWRLhViR7J
         RHRabZ/MorObhZF2VUwCkiYOvf02Lh5Sp2vqYoKbyVWVPwsy9DM9S1bnsfx0JHuBmQkl
         IThWsJ/OGdGpxTwcOf4gMYLWaKDVOr/T1aCHoikZmhmLj8WvYFU6SS4K77P7j3dw+Tae
         6fURIqjsEWkViM3OHlOCfxxIZC7Mt4GcpqgFGtoFDUVnEL0SjfrSIYuUoJLYpZ2c5H0H
         gsiwQEFx1ez4qUyhKn5HQFYW0D9fOZJk9gzH2Te7xxffhw2cUjG7FVkIVqztxRHy1Y2l
         OfNA==
X-Gm-Message-State: AOJu0Yx9C6siF6d0SoJNPIJrnvD8+ftVmbKTLzOyeot2AfaAnYhyr5CK
	dxZPdv+9oQg0txdG143x5LNw/1/pETpC7P9qPflsUSPApwgI+Hez0Himy3UFyag=
X-Google-Smtp-Source: AGHT+IGUXPfRYHHM5FcgUqy0FUNP/D2oM+JodZmXzWKB7D3GDSGU+i63EyPgufqZ/EPi4GtNvwC7XA==
X-Received: by 2002:a81:7704:0:b0:604:3e1c:3d7d with SMTP id s4-20020a817704000000b006043e1c3d7dmr5608719ywc.31.1707755295468;
        Mon, 12 Feb 2024 08:28:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsB0Iu2NCw04S0/nQy8S6qkgX94SeXgOehlZQSV0TmVWQWq+XgUPJJ5Q5cDtdqpLS/SGoPjpHc1Os+pc1mve3fkGf2qkUqO1cY/jlGM6QZFvGhtejl2CdLJ5in0Lkr0rXQefsYWpF7ksFh3Mr2nkN+SxOmrIUvnGc40XwWwXGXOsY7BHIQ+d1tDYzD
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t5-20020a81c245000000b005ff9bb7fa40sm1211840ywg.34.2024.02.12.08.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:28:15 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc75c2c3574so2220969276.0;
        Mon, 12 Feb 2024 08:28:14 -0800 (PST)
X-Received: by 2002:a25:2943:0:b0:dc2:399b:6451 with SMTP id
 p64-20020a252943000000b00dc2399b6451mr4668660ybp.62.1707755294574; Mon, 12
 Feb 2024 08:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240205144421.51195-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240205144421.51195-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 17:28:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXhNC7oq2ywbg7zMYGdYqE66ik9NsMCoT3c1XFX=i=nSQ@mail.gmail.com>
Message-ID: <CAMuHMdXhNC7oq2ywbg7zMYGdYqE66ik9NsMCoT3c1XFX=i=nSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: renesas: rz-g2l-family: Add missing
 interrupts from IRQC IP block
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:44=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The IRQC IP block supports Bus error and ECCRAM interrupts for RZ/G2L and
> alike SoC's (listed below). Update the IRQC node with the missing
> interrupts, and additionally, include the 'interrupt-names' property in
> the IRQC node so that driver can parse the interrupts based on the name.
>
> - R9A07G043U              - RZ/G2UL
> - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
> - R9A07G054               - RZ/V2L
>
> Fixes: 5edc51af5b30 ("arm64: dts: renesas: r9a07g044: Add IRQC node")
> Fixes: 48ab6eddd8bb ("arm64: dts: renesas: r9a07g043u: Add IRQC node")
> Fixes: 379478ab09e0 ("arm64: dts: renesas: r9a07g054: Add IRQC node")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

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


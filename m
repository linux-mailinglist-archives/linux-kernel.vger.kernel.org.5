Return-Path: <linux-kernel+bounces-84638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC386A959
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FDF1C25C65
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F14A28DCA;
	Wed, 28 Feb 2024 07:55:00 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074E25579;
	Wed, 28 Feb 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106900; cv=none; b=Tcn6rP1lU/dNZU3aQdW6c5TiL2BwF1IOX3uzoKRnMzOjVBZI1Q4LtKoCE8/4No3ses8RYO0Z3W4zhJK5RAcpQ6IMq4G/NpvIMC50YkLLMEd06/Jk1GHkl6iapGKALzSk62QiulE068mrGzABc/a1r5QCRsMTrDBcAZgJPQJuqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106900; c=relaxed/simple;
	bh=k3PFtWy/PHzxl2DxuJbIoHpjDS4J4NRERx2D4xtaZ/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC745Kg8dDI1YhguwR52ZoBu0vZoDKrp1syhAS7LcnU4XHWTVd3jhWIxG9T/Wb/CZnu5wrUgAeoInc5PP9TllVEwkFBd+PUVIOnZ3It0X7oFdbRpvALooiqCtH+wLaTTIiSyzsyLKXh2uIn+HSemyvB/vIfHX9ANZcNTbfIMMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607e54b6cf5so4293317b3.0;
        Tue, 27 Feb 2024 23:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106896; x=1709711696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dan9EEJFFN2NY2BJhmO3YKkWCzZTBjLI4vE6yLCQhC4=;
        b=KPYL2D5EiMgIkUpWKvIJ8j74Njr7DRacsJPdApLbkuuTs5cNseiPPKVEhoyB27Rh/j
         UFrItF18YlOoDDib+vPFE1f/KsbW6kDc0kH2XUYDJpIvYQv+OLACYzQv7XBXquDflQ/E
         Jim+sL1aQmlfcE7E0wqLOHD2nYu1+e6iwXw1BPzwmw215z5vagkbQEsvYRyf0IgTue+h
         WJk6fNNfZRT0RSS5RXM0pW9jAh2pRz89J/mkQ4uBEMI2XsjINWbFnhm/ZY/eIUataPYZ
         HCHJzFxSylKfmsrGq8Sir8YnTLpbiuM3bqXzXADHOvlg76mB4VMZrxXxh/CnIgzlJ/4o
         QSIg==
X-Forwarded-Encrypted: i=1; AJvYcCW1jlKepU9cVVydE19lo0kO3TwPzTwKTOJkJT4LGxAz2bAPaOxNEoGoowT6ozrX4pLObF/mrWybH85iwgnLgcsKtpN7MNMbEp19PwPyg0167jgM4OaBSTx3mPvUbdTzLnmIQ/YQAvIOMoKHWcjmchJIcf+GBOoU1j5l4LTXZsjKH1J+UxT5UTxVeeWx
X-Gm-Message-State: AOJu0Yx/NZ8CbhvDGZu+xkqW09c25xA0bs8UwsX+JHa4gp3oLik1/Dwz
	+KAV3/rE8/LhWshCf5A0qbbKfkqSbU1iYMprmg1XqP9Qe/0Set10k75iB6ANLUAVZQ==
X-Google-Smtp-Source: AGHT+IFx4E2CORoj73bbBkbQrqOuCoZW+r0MklMUab8Hbb1wSaM//wQBQqV/kktfbc72VqK10jqlhg==
X-Received: by 2002:a81:aa53:0:b0:609:38c2:3137 with SMTP id z19-20020a81aa53000000b0060938c23137mr1225419ywk.12.1709106896088;
        Tue, 27 Feb 2024 23:54:56 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id x19-20020a81a013000000b006077cd5fc5csm2283241ywg.11.2024.02.27.23.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:54:55 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so606638276.0;
        Tue, 27 Feb 2024 23:54:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEgbGins2hPnBqD31Gn++eQVFmYqXTicY3MNk+b+vGeoRW5nby9019sJoVR/IzCSyYfKRUiro+KxzbOqCqfUtpOPAKW4mU2XhkPvHfRu8nJ6WCczW8WxARaboLMeoYZhy+raO69X8TLChz1T4I3KC0LaEDnqCfw6o2UFlUqvPwmrO0+QWQQgykaBGF
X-Received: by 2002:a25:bdd4:0:b0:dcb:b072:82d8 with SMTP id
 g20-20020a25bdd4000000b00dcbb07282d8mr1190572ybk.15.1709106895346; Tue, 27
 Feb 2024 23:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227220930.213703-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240227220930.213703-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 08:54:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVKAfOznxXKb9QTZFpPpkcVk6O2aWxhkEL=ADPZcxx5uw@mail.gmail.com>
Message-ID: <CAMuHMdVKAfOznxXKb9QTZFpPpkcVk6O2aWxhkEL=ADPZcxx5uw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: renesas-soc: Add pattern for gray-hawk
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Tue, Feb 27, 2024 at 11:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add pattern for Renesas Gray Hawk Single board (based on R-Car V4M SoC)
> to fix the below dtbs_check issue:
>
> arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dtb: /: compatible:=
0: 'anyOf' conditional failed, one must be fixed:
> 4695 'renesas,gray-hawk-single' does not match '^renesas,(emev2|r(7s|8a|9=
a)[a-z0-9]+|rcar|rmobile|rz[a-z0-9]*|sh(7[a-z0-9]+)?|mobile)-[a-z0-9-]+$'
> 4696 'renesas,gray-hawk-single' does not match '^renesas,(condor|falcon|g=
r-peach|salvator|sk-rz|smar(c(2)?)?|spider|white-hawk)(.*)?$'
> 4697 'renesas,gray-hawk-single' does not match '^renesas,(can|cpg|dmac|du=
|(g)?ether(avb)?|gpio|hscif|(r)?i[i2]c|imr|intc|ipmmu|irqc|jpu|mmcif|msiof|=
mtu2|pci(e)?|pfc|pwm|[rq]spi|rcar_sound|sata|scif[ab]*|sdhi|thermal|tmu|tpu=
|usb(2|hs)?|vin|xhci)-[a-z0-9-]+$'
> 4698 'renesas,gray-hawk-single' does not match '^renesas,(d|s)?bsc(3)?-(r=
8a73a4|r8a7740|sh73a0)$'
> 4699 'renesas,gray-hawk-single' does not match '^renesas,em-(gio|sti|uart=
)$'
> 4700 'renesas,gray-hawk-single' does not match '^renesas,fsi2-(r8a7740|sh=
73a0)$'
> 4701 'renesas,gray-hawk-single' does not match '^renesas,hspi-r8a777[89]$=
'
> 4702 'renesas,gray-hawk-single' does not match '^renesas,sysc-(r8a73a4|r8=
a7740|rmobile|sh73a0)$'
> 4703 'renesas,gray-hawk-single' is not one of ['renesas,imr-lx4', 'renesa=
s,mtu2-r7s72100']
> 4704 'renesas,gray-hawk-single' is not one of ['renesas,smp-sram']
> 4705 'renesas,gray-hawk-single' does not match '^(?!renesas,.+-.+).+$'
> 4706 from schema $id: http://devicetree.org/schemas/soc/renesas/renesas-s=
oc.yaml#
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

I wonder how I managed to miss that?

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


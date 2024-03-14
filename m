Return-Path: <linux-kernel+bounces-103010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E212F87B9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B4C1C21265
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826996CDA1;
	Thu, 14 Mar 2024 08:51:41 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF036BB50;
	Thu, 14 Mar 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406301; cv=none; b=kX1nyTdQAeQIBBEy3omFsBVhS/BYUtr7XdSAdZrbtc4jJBK4quAdP7jzC2AWItGgULyoqgAGA6fcCT7hMrApNT+qWGqxL47WgL/vV+pt5YmRTZBt6Nk6Q3EE/2QXoTRMfWKgJdxZuzJiiQnU4uBvMlgTzEs3TtZXVk92xkHI2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406301; c=relaxed/simple;
	bh=P7Ik2T6eOKGJQ8UNDv3pkbwaaLfaS8Lw/66XvFCQSg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA4Gb48HWmEk0zLhuKiiVQ/cgQykRXkpp3SbN/tqKQbXD1a53apPzbqf1LR4wpzYmm1ny9X/gtE6Bgf6gmBiq7aogc4nVq7hHOrQYqQYgJbvGhRH5elSrwu2R1/Xf0mVdIlp21Mxydj62n/nx37d3zQrpRMQfsc7HkEiNcN5yiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609f24f447cso8611677b3.2;
        Thu, 14 Mar 2024 01:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710406298; x=1711011098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ULFHXDuigi1AqlFawPWkMS5gLCIeFanRuYVFCogxVU=;
        b=qpjigTnhrD+SMeOQQ5fOBYFKUnHJTI9UFo2BWNNkwLupiV8Gm/l3SetK2Uf7/VKZJR
         2bky+xQo0t4XvZtWsUfvn9lOtw50ODlZNCAsFJR2TvGZWGS61Et1kLSaMfRelT2MrIhl
         RO47xWLp0wyOFID3f8jmLiuzp7Bq+rSbbH5hVVBkkNSb7JiHzIaH4y8XDYIi3LDvELd4
         kUZskN09Ylikw/r6kmbHLs4DVwT3rmA/HR/VbEW7WyY5FR1nnxfXhYHRPVr+U5YtgdA9
         fj5UBhGBkNWNEQpceTJqs1qSrG4EHLDERJXNtRqjqMehvFVgc7dFbvVvHs6aHM13hO4X
         xDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmtO+wHUpbRgbXUXmFDppgtZrppC3cgW5f5f4tm/P9pfKwj1Aia2mGTTo4UloZ3V1L9kvZYO0KCdfZNpzQUYu7LQf5CpK2BS3UpNDNij6fyUsMa4KCFtuK/OFWqkdk32iNPy6xBN31yO2BpKjTQsKHL2VQhtAEC0YkEr3jWD5c96lkGg+nvl1ur7tXl8vyIrVZrR57DA53mBlF9EvETFpu0XokYqk0w==
X-Gm-Message-State: AOJu0Yx/6M2tU/FwG+TrBz8UczBZODtUIA0KMuXN+ymn1/CHtJfk1JG1
	7WHIHhQ3qH9ASgbW7G9hZWKXtO0bRilOOn01UBGPesFKDnj9pvz+6f0vt0j1SIU=
X-Google-Smtp-Source: AGHT+IGPVhapKf2RbqkoEa6RWd3h1CEpweFn3WEGqxWuy2RxpUZvTHTdE8qWtQpsa4RvvcWNWHTrsA==
X-Received: by 2002:a0d:f0c3:0:b0:60c:caf2:323d with SMTP id z186-20020a0df0c3000000b0060ccaf2323dmr63455ywe.17.1710406298209;
        Thu, 14 Mar 2024 01:51:38 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id ce1-20020a05690c098100b00609fc2bd948sm183527ywb.79.2024.03.14.01.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 01:51:37 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so643943276.0;
        Thu, 14 Mar 2024 01:51:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWk+4huGhf5SowtnS2ppnK0x5jGxhOJ91bh+KjNsa0MSVaMwAUInqlYHZdWQYMFQzDbYsI2+kRN2cWtSHYU0aEf1Q072RmV0JOxdaulNgkyDO44SnpDxg/LkFiZ/2VujEHPydIEfyn6J7/fAxzOIoK0Q/eGxHe5Yv8j8mVs4oJjr22w4WAxv1rntu9B6bqUclx/jumF5E+o4LSmedf8mgMKzuqfCLPlMQ==
X-Received: by 2002:a25:4cc2:0:b0:dc8:5e26:f501 with SMTP id
 z185-20020a254cc2000000b00dc85e26f501mr988352yba.61.1710406297778; Thu, 14
 Mar 2024 01:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313083828.5048-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240313083828.5048-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 09:51:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRQTi6jpgKasZiO3_SW7oUy-FX2ocKw5OoOAvE89SpEg@mail.gmail.com>
Message-ID: <CAMuHMdVRQTi6jpgKasZiO3_SW7oUy-FX2ocKw5OoOAvE89SpEg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow
 'input' and 'output-enable' properties
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:39=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On the RZ/G3S SMARC platform, the 'input' property is utilized in gpio-ho=
g
> nodes, and the 'output-enable' property is used for ETH0/1 TXC pins. Upda=
te
> the binding documentation to include these properties, addressing the
> following dtbs_check warnings:
>
> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: key=
-1-gpio-hog: 'anyOf' conditional failed, one must be fixed:
>         'input' does not match any of the regexes: 'pinctrl-[0-9]+'
>         True is not of type 'object'
>         [[144, 1]] is not of type 'object'
>         ['key-1-gpio-irq'] is not of type 'object'
>         from schema $id: http://devicetree.org/schemas/pinctrl/renesas,rz=
g2l-pinctrl.yaml#
>
> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: eth=
0: 'anyOf' conditional failed, one must be fixed:
>         'mux', 'tx_ctl', 'txc' do not match any of the regexes: 'pinctrl-=
[0-9]+'
>         'output-enable' does not match any of the regexes: 'pinctrl-[0-9]=
+'
>         from schema $id: http://devicetree.org/schemas/pinctrl/renesas,rz=
g2l-pinctrl.yaml#
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.10, with the warning messages
trimmed.

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


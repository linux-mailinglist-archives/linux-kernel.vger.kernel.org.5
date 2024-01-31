Return-Path: <linux-kernel+bounces-46531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C08440FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3321F21E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095280BFD;
	Wed, 31 Jan 2024 13:49:10 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2F80BEB;
	Wed, 31 Jan 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708950; cv=none; b=A9TEduigxM/prNuK5mrtGd12FRbelgLQZnFfi+nciplOSbdcfGIknYIXfuhyGJwATvJClSOI9u9ZjpO8SQzoFCjhN62zI02r8iBTY/xluQFF80tGkufnwCfWpEHkB4WwEGuCaeg2JziPJ6YilnqveAXO4XM7hkMfM01LNrLw3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708950; c=relaxed/simple;
	bh=hlUiJpbmsFIl51mQNh8n1F9H2msowy0VY9i5HEcVVOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om6dvSXfrVszdBAzL29V4jWUGJOTeWBUxZjlpAs8HKkbLZZ/5bkgzjwMFogeeRt6Em0fQJAmsDS0Me6yPPjJfm0bJY+/UD97lUPbsF/HG5nBK7PisOJPFG5EB7fkt0f1ZAXMqhUNw8EisiZQaBP1ugE9idqpSBJRHX+WWccSy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-602c714bdbeso7909587b3.1;
        Wed, 31 Jan 2024 05:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708946; x=1707313746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPLw/LWplp7+P1Gs+5HHE9GJRqlCVuyyfFXDuI3BijA=;
        b=KW7ecGe0R/bLrjyHO5q7OGSFxJfr/9y3fY2riKik4E0N4aQDaYSxOe+/AovzsKmQjQ
         QjeaURF/Gw1oMZHqYfWCfcW+j+doIJpgcBW+VY+0MR1rv+/5qKbLNDzZiBaFMguANblN
         9wwm7TjJYeMvulKHdDtkdVG9rOAMlf37sQppyt1MOqDfDteaBFDhsa0xizNmbl57xLr0
         aA5RO604G50MA8sk8MsfInG/YtS34510IhOsyS3HFIzQqS5Km4gVBJ6r4Qc+kIpCnDAs
         +lYEBppGXgozmK30DQxquZvPRq2CStT0z0MxUxBQqP4YUqMsshmZxJrHrLVNj6gjLYd3
         CNVQ==
X-Gm-Message-State: AOJu0Yw905aHwjei+6TkKa7SvKI8nzx1d/0aUi5PjEHsHdortYhi60g1
	/mSysWhSIHcDdDn99sgvyutFdHRtIya0VfWD6oGCPJRXQaxDKEe9OE6Ysvk0YB0=
X-Google-Smtp-Source: AGHT+IFWIlKBcusd+yKlYlPzR0XGKSSone6jaxEcH1W/jMJsCa2Cfae7oQrm3QCFzOdlyD1pxhWCGQ==
X-Received: by 2002:a81:4510:0:b0:604:1693:dbf8 with SMTP id s16-20020a814510000000b006041693dbf8mr152380ywa.25.1706708946305;
        Wed, 31 Jan 2024 05:49:06 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id be15-20020a05690c008f00b00603cb3e8f5fsm2427286ywb.103.2024.01.31.05.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 05:49:06 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6029b5946f5so6614357b3.1;
        Wed, 31 Jan 2024 05:49:05 -0800 (PST)
X-Received: by 2002:a0d:eac5:0:b0:604:9ef:3045 with SMTP id
 t188-20020a0deac5000000b0060409ef3045mr1069160ywe.31.1706708945557; Wed, 31
 Jan 2024 05:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129135556.63466-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUiiQpw5UH8s748oqaH5BuFqDy=feWxdsEPJ4jaHRzkyA@mail.gmail.com>
In-Reply-To: <CAMuHMdUiiQpw5UH8s748oqaH5BuFqDy=feWxdsEPJ4jaHRzkyA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 Jan 2024 14:48:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWe1_51wxrvhrPN4HVdsZNLep_Qz2ianW0cPXxJ6ECEfw@mail.gmail.com>
Message-ID: <CAMuHMdWe1_51wxrvhrPN4HVdsZNLep_Qz2ianW0cPXxJ6ECEfw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] riscv: dts: renesas: r9a07g043f: Update
 gpio-ranges property
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

On Tue, Jan 30, 2024 at 11:38=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Jan 29, 2024 at 2:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On RZ/Five we have additional pins compared to the RZ/G2UL SoC so updat=
e
> > the gpio-ranges property in RZ/Five SoC DTSI.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-pinctrl for v6.10, as this has a hard
> dependency on the pin control patches.

It's worse: the pin control patches without the DT patch breaks, soo.
So I have no choice but merging patch 3/4 and 4/4.

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


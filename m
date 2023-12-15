Return-Path: <linux-kernel+bounces-1556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328681500A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35B1288FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCE73FB21;
	Fri, 15 Dec 2023 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I21cfapc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393A4184E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 16A173F2C3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702667589;
	bh=A1KQCHoagGRE/Fri7ZMPinskZZrpSG0JKrmQZH3FV6g=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=I21cfapcDH5NZ15eHsUBj8KHhiujqxDSFDDPjeHoUwtVnJxbck4wKZQjuAtu++Lgq
	 y67WVxbQgtN7F58ruyKNu8TkgJbEdcMGl1iboDOdaGKNvGF005bQuic2JvABjrBoHS
	 gwM2qGmVu/LF6glnaqLlPBJXryBWBiChKONJWhdAfiHcDK5YZj62rqavuYdoERcMBq
	 dCPvV6bMgMwzbOevjzSR/gjUTLUJnQugvptGFi0CHXXTFlTT3q294TNrkXmkp10f16
	 RUAjgE3fwp56mLIGgvxuxYg3oiU5n36+2+tuj1RrqUshZi2W4AOZt8FP2HGWgZhKSs
	 4C/jB7DMl3C2A==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-425927c274aso15547011cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667588; x=1703272388;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1KQCHoagGRE/Fri7ZMPinskZZrpSG0JKrmQZH3FV6g=;
        b=FoZDaN3P16IwHWGcl9SqIbjTyPRP8f7+QKuUbuzA+RkGec4cJ87VvZdMdRUKJlKkGr
         imLgtxTi6SIbKZXPakszc/BLNH/pdTHxnUHHhgXtkctKi0VV4N2zThgRE8zKyXLJ4NlK
         iJ5OU++q2J1pPqKnHvBiteQ4l0E6XpeHMV0wB2Ffe8vyVU3ZQQ8OTwfQ8xx3uQNhKcQe
         CWeahcdhAqdrAf6n3oUCgwq1ZSDrjdJtcjHou9lueFiR9cFzZArbYOM0gf1DYXrNDqe7
         s13OmkOyplspzHB2UWFlnZgwR54Z1XDkPf1aw6DAEhCbjBowj9ZMTeg0rGLmkZyCZDzH
         AkDQ==
X-Gm-Message-State: AOJu0Ywd5zi3+ERe1r647IrNLKIOqywKifl/nIqTWKBXK5rLMdoPTC6k
	FGh5+F+4a+jrcxPJskPfjZnsO7DQZ7VYsTjBJnaNTo2LHnFm8Hz+OfFAQJozB5Y0KSUI+IGxUvl
	c7xgeSgpqM/EjoVpvI7PkqTrcpkfwqbG+09q9+7IHlMF0ovVy08HA/xuAUw==
X-Received: by 2002:ac8:5909:0:b0:425:78fc:446d with SMTP id 9-20020ac85909000000b0042578fc446dmr16222548qty.29.1702667588057;
        Fri, 15 Dec 2023 11:13:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ33pMMGoaNI9twd5osVzgTSarT/cVWUeo35du2j8Q7yxXEdTqukpbqrobo5IDN+bItJEQlbp48Xge01CaYl4=
X-Received: by 2002:ac8:5909:0:b0:425:78fc:446d with SMTP id
 9-20020ac85909000000b0042578fc446dmr16222525qty.29.1702667587843; Fri, 15 Dec
 2023 11:13:07 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Dec 2023 11:13:07 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAMuHMdXwRZRvLPh3JBShQy4hRHq=2fQJmcYjTyQhKZmtBPaOuw@mail.gmail.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
 <20231213-jester-rendering-dd876ef8e8ac@spud> <CAMuHMdXwRZRvLPh3JBShQy4hRHq=2fQJmcYjTyQhKZmtBPaOuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 15 Dec 2023 11:13:07 -0800
Message-ID: <CAJM55Z85_qR8bpZwjEgz-fmC=WCZEJYHk5d=1bGfDE+oVMN7Fw@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 0/8] Add JH7100 errata and update device tree
To: Geert Uytterhoeven <geert@linux-m68k.org>, Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven wrote:
> Hi Conor,
>
> On Wed, Dec 13, 2023 at 4:43=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > On Thu, 30 Nov 2023 16:19:24 +0100, Emil Renner Berthing wrote:
> > > Now that the driver for the SiFive cache controller supports manual
> > > flushing as non-standard cache operations[1] we can add an errata opt=
ion
> > > for the StarFive JH7100 SoC and update the device tree with the cache
> > > controller, dedicated DMA pool and add MMC nodes for the SD-card and
> > > wifi.
> > >
> > > This series needs the following commit in [1] to work properly:
> > >
> > > [...]
> >
> > Applied to riscv-cache-for-next, thanks!
> >
> > [1/8] riscv: errata: Add StarFive JH7100 errata
> >       https://git.kernel.org/conor/c/64fc984a8a54
>
> That's the one which also needs depends on !DMA_DIRECT_REMAP?

Yes, thanks. I sent a fix now:
https://lore.kernel.org/linux-riscv/20231215190909.3722757-1-emil.renner.be=
rthing@canonical.com/

/Emil


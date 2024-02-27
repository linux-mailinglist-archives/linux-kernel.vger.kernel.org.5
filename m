Return-Path: <linux-kernel+bounces-82837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981B868A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554BB2843FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E200456741;
	Tue, 27 Feb 2024 08:03:55 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0C55E71;
	Tue, 27 Feb 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021035; cv=none; b=sK9efYX8grCiokDkCoC1c8fEf7ZeBmLS5KJncXM+16lTBd26sUXI89s/2zLzesRGmOL9F0yH/AXUbeML6tWlKfYPfSQa1JY7wcfpnhrQh7cT5W/SnDo/8mk7TTYuCy52Ny08SwXt2TQXLsJj6VUoNIvgeVcUUwq6pDarcAjoSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021035; c=relaxed/simple;
	bh=rA/l59NHKrfz29HAgJL30l47apBr5WPA1NMx/skzYm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPGFdnVSHdYZrxsBIruW/ogZbJqSa8OCvQdTGA6zXvtdlgwsD0bvUAdIDWeA3mxryS21iG7U79Cac9TuvSR6MCQP2FA90mGwJ5IHSIULjOOCr5F4N2oEktQsV2xwUpI1xSm+4Q1ei8aWQXvIW+iLaQ43djf13tVkZTCvJO1/nQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6091e12b01fso11381457b3.2;
        Tue, 27 Feb 2024 00:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021032; x=1709625832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roGG6meVs6CKhA34aRUxJBf/ohtansRAwEpLm9XFiUw=;
        b=RTM5vk+5C6263II6WNw1gjNAoEFi6ml7rMXvi77pqfyu9TxSVsMFIwJodtHluvx7cQ
         qUXgloGDWKWdgjciw7Gr5dGa+AveSRTBVZyDcAG4vZmJL2vQbshFzEs6XINUwXavE4ab
         YIty/SX6spD2YVHy+C1EFCs1aS0bOYguzr5gX5jWoY7xKR+0f98qPlFMwhnAsZYn1opg
         9KRLoauSCXold4InD8w/ephscvPc6FmFwgCm2oAsUckba/B3oSbc4mqDrmmu1i+qLeJv
         aoadkmKp/+gG0Zl3JeCeJQ9cT9ezQmRR36CDr+in9fL8HFiNzpjvwgOsVHkgd+xbbkFi
         AhSg==
X-Forwarded-Encrypted: i=1; AJvYcCUv/piSb7nYuMU8TRor3IAb5YG2Uj07IvqNsPTGUBcumexlLtpL4q4SOxdFJlXUOM0ZBs1UnUrn5sJj4eF3Z4R0W4chfjIL/PRIEDvn6TlEOoAn+uYVs42HvTlajipEseDp2YMFWWKNc2PpvWAtvv15c2xZLWYtLFy2Vlz5K4szix073WR52W0RHE/U
X-Gm-Message-State: AOJu0YwrAJwoLBisJ4dBYKEXMQ4cmkJBKBdHgjP2/8hkDa1TlW/xB/pX
	jccUgcyBbaBdMBMXA+AVLtUzUfhGrmOBn4Ruf6nxZnBLZn94PWOPI9Jkr287+xk=
X-Google-Smtp-Source: AGHT+IFo8EmmoXEfuqgBnRoMERdb+uwGlF8KhvoX7ta/E2R7yQhzO5guFvoWxZz4NxQsuqJ0l5R7bA==
X-Received: by 2002:a0d:d848:0:b0:609:2c0e:7afc with SMTP id a69-20020a0dd848000000b006092c0e7afcmr482799ywe.20.1709021032208;
        Tue, 27 Feb 2024 00:03:52 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id a11-20020a81bb4b000000b00608a5d25dc1sm1605439ywl.77.2024.02.27.00.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:03:51 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-608ed07bdc5so20548907b3.3;
        Tue, 27 Feb 2024 00:03:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNM2hsmI5sijqebl9fjuXZgkBlt12B05o05bQV1SINPvYAgA+//XFRxJ00QWHnV5bt2zXviQsE1p/GIaCwjkIoMtvYTte6VB05r6OOH2+TZ+7FEoZ2dahK1BYTZuiP1YaTpjrhyOfI5WPnoREHF6Qr4y0nwWF8CfLzEbyyNRyW/cYRqUgvvD/zCtz1
X-Received: by 2002:a25:8109:0:b0:dc7:4367:2527 with SMTP id
 o9-20020a258109000000b00dc743672527mr1373085ybk.49.1709021031575; Tue, 27 Feb
 2024 00:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-2-aford173@gmail.com>
 <CAMuHMdWhtu7nuBpC=TSY6rMaReJNgYok535xXotDyKJDT1_Mzw@mail.gmail.com>
In-Reply-To: <CAMuHMdWhtu7nuBpC=TSY6rMaReJNgYok535xXotDyKJDT1_Mzw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:03:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW1wH+oqKRjxCTVAjYuyphV2ysrNyqC7DKchiivRzGn2Q@mail.gmail.com>
Message-ID: <CAMuHMdW1wH+oqKRjxCTVAjYuyphV2ysrNyqC7DKchiivRzGn2Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: gpu: powervr-rogue: Add PowerVR support
 for some Renesas GPUs
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Adam,
>
> On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> > Update the binding to add support for various Renesas SoC's with PowerV=
R
> > Rogue GX6250 and GX6650 GPUs.  These devices only need one clock, so up=
date
> > the table to indicate such like what was done for the ti,am62-gpu.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > @@ -14,6 +14,11 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - renesas,r8a774a1-gpu
>
> I would add a comment like this:
>
>     - renesas,r8a774a1-gpu # PowerVR Series 6XT GX6650 on RZ/G2M

After reading [1], s/Series 6XT/Series6XT/g.

[1] "[PATCH 00/11] Device tree support for Imagination Series5 GPU"
    https://lore.kernel.org/all/20240109171950.31010-1-afd@ti.com/

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


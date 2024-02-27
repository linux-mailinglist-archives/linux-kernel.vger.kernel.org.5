Return-Path: <linux-kernel+bounces-82850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F175868A93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707C31C20FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335856465;
	Tue, 27 Feb 2024 08:11:57 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96C55E71;
	Tue, 27 Feb 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021516; cv=none; b=LxvNSptPJNvzQlIY2Y6nM5YcZ4qCLgxL39owO+BDOrn78OgEmlGYu8LzHUr50EI+t34ZVDfGTENeLaO1rJrVOdWbgixeuGvqW0E9ADTORns2r7xcKsdjh5fnWc02xOVdjepZLn3LKY6QiuHt21YXRoqssOYH+j1dDIc083+Dj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021516; c=relaxed/simple;
	bh=dN1JmYbJVIyuytoHJe2d5HX5NwMbVW1iypbJEoDjFBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FB4PkdRONTROOQVYxtTrGHK7No67WKp3cnVG1vNjqE0/zufAKiO4wfUFHExVsz1NUmS1rh5c5EBoPsEqDWjpRI/vB86es9KrbHinEPJZWDyV1fR+gvbxTA1ayCDFTCbnGhdwzlTLN/5HMvQJD79Qg4lkG4L6VVpIE2hd8wxZ9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607eefeea90so38099937b3.1;
        Tue, 27 Feb 2024 00:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021514; x=1709626314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AOv9TtJDkUWmDznfDiDn5CRStO2mF8xqBgjOgsX5QA=;
        b=oAJ5ruMYNbhvsxry86MUBeKBLNhW3jc/0YxpJkuQY0XRtcD8BAOzAexq4CaAPCf9yI
         HX1lSEtEk95gCwrURK+twGvze8o5QTczBcdPBS8wwe4j2ZgeMZ5NCCvHGpu370Dfo/20
         RiiVI6ZgdqMZZXAybgUJsbc38eGoMsjFpz9lEzVUlZcQiF6EPiVmuvIW1Eigk+pBLmxT
         E4szQb7eKqIxf8EspjApxVaBEbLV6Yf9ZvMbybcNJe0jooOC42mP8tKEe20nR5//9XKc
         RL6mBrFSflm1ck9dAuY65DHnLjkfPWZIhbXVIsUgtzJ9BkLW61HqCD4J9+V6uk6qoJAW
         D7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeLFXIF9Mm9ug/YwmSTEP3lcbgu2nPD9o1WMEyx+233G9qGDTPCIXqaEGHNLLGjZU27phx0+63Kf7fyTS4d+TBC+6LnDc5ON8Claps7c98+/S8lyPVQr6bR4dd3C7EscbidMfQjrXzKrBUfYLSnFhJWIQZkCWhOksBxYFcpdnJHIa+bVfWXTKswhUY
X-Gm-Message-State: AOJu0Yya0c8H7pbw74LsMERP+PVYjQPxvYE+9DREOR3gAUalGYgRhPLY
	s3v/6rh6iAUjdrbYVY/V56BChWMgSAC4Zb8eUtPDq7M7IdUzXijVyzsZGSkuqQ4=
X-Google-Smtp-Source: AGHT+IFqC5hFzL7Y1SDry30fLhLrlLbyLZqb4l9XywPROCMmI89iOGhjXAuYjnYLVerceeshM7Ds6w==
X-Received: by 2002:a81:a08f:0:b0:608:c73e:c6e2 with SMTP id x137-20020a81a08f000000b00608c73ec6e2mr782206ywg.6.1709021513776;
        Tue, 27 Feb 2024 00:11:53 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x124-20020a814a82000000b0060894d466ffsm1652474ywa.121.2024.02.27.00.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:11:52 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so3224889276.0;
        Tue, 27 Feb 2024 00:11:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKYbVHhGo2K//VsYSmisfUYo75rcRYgErjpKWbVWc6kWW/LvvQEmFSlxtIOkb2ciZVEP/cqjCA+6d1JYc6gt1Doqaz41Gfm7AmFkv1AO4USpkB+KD/tHtluqmu+tkwC+bmtmDTOaLj/Gzgw5Q3htWGvJQfcvy6e6VyktybCGa2uDrkyNM+K7gng1/C
X-Received: by 2002:a25:642:0:b0:dc7:4265:1e92 with SMTP id
 63-20020a250642000000b00dc742651e92mr908405ybg.23.1709021512717; Tue, 27 Feb
 2024 00:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-5-aford173@gmail.com>
In-Reply-To: <20240227034539.193573-5-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:11:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWNQ=_NHPybAhhLJJCytT4y583ROY-meuLyKPN8_Qa1HA@mail.gmail.com>
Message-ID: <CAMuHMdWNQ=_NHPybAhhLJJCytT4y583ROY-meuLyKPN8_Qa1HA@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: renesas: r8a77951: Enable GPU
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adam,

Thanks for your patch!

On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
> The GPU on the R-Car H3 is a Rogue GX6650 which uses firmware
> rogue_4.46.6.61_v1.fw available from Imagination.

s/61/62/

>
> When enumerated, it appears as:
> powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.46.6.62_v1.fw
> powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)

Do you have a different build number?

On Salvator-XS with R-Car H3 ES2.0:

    powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.46.6.62_v1.=
fw
    powervr fd000000.gpu: [drm] FW version v1.0 (build 6538781 OS)
    [drm] Initialized powervr 1.0.0 20230904 for fd000000.gpu on minor 1

>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> @@ -2771,6 +2771,16 @@ gic: interrupt-controller@f1010000 {
>                         resets =3D <&cpg 408>;
>                 };
>
> +               gpu: gpu@fd000000 {
> +                       compatible =3D "renesas,r8a77951-gpu", "img,img-a=
xe";

renesas,r8a7795-gpu

> +                       reg =3D <0 0xfd000000 0 0x20000>;
> +                       clocks =3D <&cpg CPG_MOD 112>;
> +                       clock-names =3D "core";
> +                       interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +                       power-domains =3D <&sysc R8A7795_PD_3DG_E>;
> +                       resets =3D <&cpg 112>;
> +               };
> +
>                 pciec0: pcie@fe000000 {
>                         compatible =3D "renesas,pcie-r8a7795",
>                                      "renesas,pcie-rcar-gen3";

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


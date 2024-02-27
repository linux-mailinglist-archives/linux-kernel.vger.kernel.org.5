Return-Path: <linux-kernel+bounces-82823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326D868A22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0361F2343B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7455E7A;
	Tue, 27 Feb 2024 07:48:44 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E854F94;
	Tue, 27 Feb 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020124; cv=none; b=BVTRcCUyDuMie4mYNH8JbtLn8+kqAH9IgU6L43Y13jCaDgr7VGC4lEgbsXiWtdbjZX49xjaiK4Xsvhu/cOtfkDFuKIuNU2an088yldW5RwsASq4cT+fI318jfPALkmpoHAwcrIrfCNF9K5d6jd923NorsWIJO8GtxWUU2ow9s8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020124; c=relaxed/simple;
	bh=SKoDHvVTEieR+3z9r2hL+t8bvKzHV2P8+kbsG2tzazI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syRjMvteErLcYm4nFZGlU4/xXb8g0NlroiKO33N1UmHO/WFj79Gqe1PusLhLpeo2jmm8u7x2xQo4NkgJKtgblvWJjYvhzbZKp3W/Uslr34GCrI48biqgmltovmrA8xcW5BlBc2Nz9xvnghwlg2R5sI3tKrDP2hyEmWAjCcdHk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-608cf2e08f9so33687167b3.0;
        Mon, 26 Feb 2024 23:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020121; x=1709624921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7zeR6KIY0a3dHEE7lZQueJuol6VZXvoVJ6gHmowZD8=;
        b=qFfXDS2bbfhDJg2ONIbIc/lSbuSaCKNT8Rbiq6gZenOtPNNeh93RWQSBD36EII9Mxd
         q3vk0BYoUf9s4lncgqeB5CYrMsWLSdzeHrrnoqIqO+gBpGbKLDee4CEpj1DNNHFQQKwi
         7MVhbIrdIclCpp2Sg/uAR/OeqRrPoFw0Y9vcYQv+wn+HbRcUHn1rj+XUH5iEWG3KVM8P
         yPaBeJ+JBQtBrOW5imVnP2p7w9lsQ1GWlrwXaR9172DIq6fBk1FnxS8NORCXtIampbV4
         JVYXBJlCe7ZkwrEGnFDQl0HTjZGJ0fkoNvSTvbMwFGpFLBMjeARDuVQPBySK6fswnCsq
         EIBg==
X-Forwarded-Encrypted: i=1; AJvYcCWDm4DkMh7u/rrL6RAqvjFbi70lvsPsw7ZFpWml0gpE3u5vbLJNYLHYGVPPduFhqM+Oqu/ysPPa3sTHe930BG6dqJ6IDLRjCK5XJAnlNZV7DUIp7mHtcyXUat359lSD5alxdpsOWEaOCoHh5A0o2eOFmGpf61+x30vRwONVf2tKzMdnPsmX+3VcsGVA
X-Gm-Message-State: AOJu0Yy5vNhaM/FosrdLNtMDdYFYAppVQoe1Ss1v+cOIqAWYLGzf1Hok
	XlUAYmJIFwZKvt6QVGtZuJnNsRWe7zyoubHncZ937/CYMbLzjkhz3j6LfeQAbQs=
X-Google-Smtp-Source: AGHT+IEck1hpo4UcskddjeVyhjKatVdPklc6fFLiiHgxiuy/jDJX2dnOYaYMUsWlfejj6LaoPuNJOg==
X-Received: by 2002:a81:5751:0:b0:608:8f31:244f with SMTP id l78-20020a815751000000b006088f31244fmr1198501ywb.51.1709020120829;
        Mon, 26 Feb 2024 23:48:40 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id t11-20020a81ce0b000000b00608e03f3d68sm1438845ywi.7.2024.02.26.23.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:48:40 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso4004938276.3;
        Mon, 26 Feb 2024 23:48:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9vW6Qn61O/T/wDX6dRmyJd/9IS6LIQ6ycHQv28z8kH8M/6+hI+5+ERB4PwG0gdYj3FoIO4HxYG2cjqbLg2596BZpk2WayRVaUvsl91s7Wsgs2sHgCkk3FBg9kKexd04jJlWqhj94e8UBjpjwBZixKQyTXQ/Ggd/UJg4KpFHGMlV5V7DSfviY0gnOZ
X-Received: by 2002:a25:8706:0:b0:dcd:a9ad:7d64 with SMTP id
 a6-20020a258706000000b00dcda9ad7d64mr1462178ybl.48.1709020120180; Mon, 26 Feb
 2024 23:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-2-aford173@gmail.com>
In-Reply-To: <20240227034539.193573-2-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 08:48:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWhtu7nuBpC=TSY6rMaReJNgYok535xXotDyKJDT1_Mzw@mail.gmail.com>
Message-ID: <CAMuHMdWhtu7nuBpC=TSY6rMaReJNgYok535xXotDyKJDT1_Mzw@mail.gmail.com>
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

Hi Adam,

On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
> Update the binding to add support for various Renesas SoC's with PowerVR
> Rogue GX6250 and GX6650 GPUs.  These devices only need one clock, so upda=
te
> the table to indicate such like what was done for the ti,am62-gpu.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -14,6 +14,11 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r8a774a1-gpu

I would add a comment like this:

    - renesas,r8a774a1-gpu # PowerVR Series 6XT GX6650 on RZ/G2M

> +          - renesas,r8a774e1-gpu

    .. # PowerVR Series 6XT GX6650 on RZ/G2H

> +          - renesas,r8a77951-gpu

    ... # PowerVR Series 6XT GX6650 on R-Car H3 ES2.0+

> +          - renesas,r8a77960-gpu

    ... # PowerVR Series 6XT GX6250 on R-Car M3-W

> +          - renesas,r8a77961-gpu

    ... # PowerVR Series 6XT GX6250 on R-Car M3-W+

>            - ti,am62-gpu
>        - const: img,img-axe # IMG AXE GPU model/revision is fully discove=
rable
>
> @@ -51,7 +56,13 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: ti,am62-gpu
> +            enum:
> +              - ti,am62-gpu
> +              - renesas,r8a774a1-gpu
> +              - renesas,r8a774e1-gpu
> +              - renesas,r8a77951-gpu
> +              - renesas,r8a77960-gpu
> +              - renesas,r8a77961-gpu

Please preserve alphabetical sort order.

>      then:
>        properties:
>          clocks:
> --
> 2.43.0

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


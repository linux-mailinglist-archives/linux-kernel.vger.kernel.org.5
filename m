Return-Path: <linux-kernel+bounces-95173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3D874A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A72286E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067AA83A1D;
	Thu,  7 Mar 2024 08:58:38 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0482D7A;
	Thu,  7 Mar 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801917; cv=none; b=DcJj2MoT0Gauz0wrHq2FYry/GEBVO2AAmCP8jpwHF0JGcKGKOpJJXLaohv8fzI0oimbv5Y+k4sAf22nZ9GvRBwyiuZx6wn4xBMCG3sXghaaPgUN2AQTXhsKvnp1ijBMrNMryZtkSObdmWN6dO0n8X9VVE21+l6nHK2AENcbimXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801917; c=relaxed/simple;
	bh=+oiVEdG9b2XuStWqMFk9KRco76DNKJfWP/ntPUBoLOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM6FrrkH4yuGlTDM9x51nGY7/fyllhb+cifko+LeYUuNxd93TGv2mSFAqk3eu4UHEU3Bjxrih78I5859BvGQXicrn3Psz6XcYKxOxUzgAuf+G6rcwioUaFlxJzFUaYE9azNTvjD6YEZ+LHmTLpReTCmh70q/YWc02FU0KFvM4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6098ba9959aso7090867b3.2;
        Thu, 07 Mar 2024 00:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801913; x=1710406713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jn5dxvQybAgLdJsYDY294tghTuyvSzt1guRy78x0Iu4=;
        b=GRWN5jDUxW7BdbQfel+krA1hpTHw9ph0QYhSlGLCuWVRq/oNiFQNbRG5GeW0WrX8nF
         yYUUIWsI+kY/CGimKLvZKsDKwJEZVrNf5YTGn8dANYHMZgUJ2WFFpJqMTzT/UL2/MOfr
         fcQUZ76af8we8PE2qQD0g3OZU6ixX0XTyLea5YBEOO12rYE4bjIGbIzhyK3p9BYwvgQ0
         G0zqe3MuFZYHeLTCVjgM/yW84hqRvB7s8eAnQrj+jefvPDwtoyYzOw0uBZtFcUgjbEe2
         XB0Gjbpi81+n2n+hVwa/9Jcu+YHE/4sxT78WNfbUK5jyXPyGE7XqNInL6rYS5ssL2O1D
         2aCw==
X-Forwarded-Encrypted: i=1; AJvYcCWe4y+Lpc4mnJqjoSiMJk9uv1C1hP4E7AkomR+estWnAk43a0yeRm3xPjG3dCfX8Eq26JcbsUYsaACeWHTqy8UvE+l7IkjnY6HEn4gL4u4wJTw40QeBVOjFkuFOEe9dWQm3PG5pj88QAG4iRLh2/84FPSKVb2WgpDKaF4waJ0xJizKYxWC9vECcdpqvnRDrKMOh/frug/Zk9GvR7HElxSDTknajLce8ZIlL
X-Gm-Message-State: AOJu0YyWfsEmkR5IyDU0jmDBqP3mqZHOYhRSqw4Y5rB5mApZZzWeahjs
	Twp3rtHpbSz6r1dzwjpVnuH2PcdGuB1z61WPYLk8GP3DLY07/yD5whsr99Ssssk=
X-Google-Smtp-Source: AGHT+IFzuo4h7857zle3kZbOxTq9bdIy+FRpvbRqlQGkH55w8OCprhGIPZPjt0z4R8AA9K+MZGmwrA==
X-Received: by 2002:a0d:efc3:0:b0:608:8a6b:b213 with SMTP id y186-20020a0defc3000000b006088a6bb213mr17831923ywe.33.1709801913598;
        Thu, 07 Mar 2024 00:58:33 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id r79-20020a819a52000000b006049c16b843sm4088542ywg.145.2024.03.07.00.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:58:33 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f060cbafso4614657b3.0;
        Thu, 07 Mar 2024 00:58:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5fEMiGF5L+bZpytGdMeJpN8OjhpVP28JE903Xut49PccBB8AuWAqe6sMHOkOn0OeMUplMrasIhytdch6XgczFA2+FuHT7+t/TNvjXbLsixf9Jy8kceORKyOmFmPKbBEjrLu0p6jBbgYpS6KPjpHOO0+5iC1MafdtzeMJVJReFI3faZfr9987HqHt/F+c11NM6Vmg1tk4OkEHrW66j0hMGiWsULgraZGu1
X-Received: by 2002:a05:690c:398:b0:609:3c37:a624 with SMTP id
 bh24-20020a05690c039800b006093c37a624mr20123653ywb.35.1709801912626; Thu, 07
 Mar 2024 00:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306231007.13622-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240306231007.13622-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240306231007.13622-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 09:58:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQcyrwTCTukhLFiaawDgbKwZWcWCO7bc1FfFS-t=kcqg@mail.gmail.com>
Message-ID: <CAMuHMdVQcyrwTCTukhLFiaawDgbKwZWcWCO7bc1FfFS-t=kcqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, Mar 7, 2024 at 12:11=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This commit adds support to validate the 'interrupts' and 'interrupt-name=
s'
> properties for every supported SoC. This ensures proper handling and
> configuration of interrupt-related properties across supported platforms.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -82,38 +82,6 @@ properties:
>    reg:
>      maxItems: 1
>
> -  interrupts:
> -    oneOf:
> -      - items:
> -          - description: A combined interrupt
> -      - items:
> -          - description: Error interrupt
> -          - description: Receive buffer full interrupt
> -          - description: Transmit buffer empty interrupt
> -          - description: Break interrupt
> -      - items:
> -          - description: Error interrupt
> -          - description: Receive buffer full interrupt
> -          - description: Transmit buffer empty interrupt
> -          - description: Break interrupt
> -          - description: Data Ready interrupt
> -          - description: Transmit End interrupt

As the above three groups are increasing supersets, you can just use
a single "items" listing all 6 interrupts, and describe the first one
as "Error interrupt or single combined interrupt".  After that, the
SoC-specific logic at the end just needs to specify the appropriate
minItems/maxItems.

> -
> -  interrupt-names:
> -    oneOf:
> -      - items:
> -          - const: eri
> -          - const: rxi
> -          - const: txi
> -          - const: bri
> -      - items:
> -          - const: eri
> -          - const: rxi
> -          - const: txi
> -          - const: bri
> -          - const: dri
> -          - const: tei

Likewise, with "interrupt-names: false" below for the ones that don't
need it.

> -
>    clocks:
>      minItems: 1
>      maxItems: 4
> @@ -173,6 +141,91 @@ allOf:
>        required:
>          - resets
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,scif-r8a7742
> +              - renesas,scif-r8a7743
> +              - renesas,scif-r8a7744
> +              - renesas,scif-r8a7745
> +              - renesas,scif-r8a77470
> +              - renesas,scif-r8a774a1
> +              - renesas,scif-r8a774b1
> +              - renesas,scif-r8a774c0
> +              - renesas,scif-r8a774e1
> +              - renesas,scif-r8a7778
> +              - renesas,scif-r8a7779
> +              - renesas,scif-r8a7790
> +              - renesas,scif-r8a7791
> +              - renesas,scif-r8a7792
> +              - renesas,scif-r8a7793
> +              - renesas,scif-r8a7794
> +              - renesas,scif-r8a7795
> +              - renesas,scif-r8a7796
> +              - renesas,scif-r8a77961
> +              - renesas,scif-r8a77965
> +              - renesas,scif-r8a77970
> +              - renesas,scif-r8a77980
> +              - renesas,scif-r8a77990
> +              - renesas,scif-r8a77995
> +              - renesas,scif-r8a779a0
> +              - renesas,scif-r8a779f0
> +              - renesas,scif-r8a779g0

Please simplify using family-specific names:
  - renesas,rcar-gen1-scif
  - renesas,rcar-gen2-scif
  - renesas,rcar-gen3-scif
  - renesas,rcar-gen4-scif

> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: A combined interrupt

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


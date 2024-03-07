Return-Path: <linux-kernel+bounces-95610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30F187502A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BEF1C24665
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC4F12EBED;
	Thu,  7 Mar 2024 13:35:31 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB812EBD7;
	Thu,  7 Mar 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818531; cv=none; b=cOPxVIkE+YGQTovKLP66mY8+softXQzfVRfNx8hc0yw/fDepOtptD+PWSVQmdVXy14HkSWLdWVnr+ld+yOZ04krPADkBoccWKP+3MrUdT0rbgLN5rtywKOPE6r+5ylAvjYawhgg/1abccwWjju+lKOuEHrNWoJzz7rPyVBiUTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818531; c=relaxed/simple;
	bh=aWB4bkGl3SzCR1pdF+VfhPOyhNRPA4wkeK3Q5H9cmPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNrZT1CoPMAk/n9qXt0JDBImfs4aTvBG+svXaG0oC/nGp2Tl2yM+q5uJ4I5h1DCyu59XFbyUlRrbvvpP8smF71JzHzZBrX96KNCY1IoZRdsyygK08NlMvMes85dgTBQRQfEjQ28G5MoGhzsXbrMz4B/Z1dSCN1mp3fkuOPc/INU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso864781276.0;
        Thu, 07 Mar 2024 05:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818528; x=1710423328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M82aLwITIdvRH9rbK4Grnml+csUrRgich9S+9BrPQj0=;
        b=Ms7ME2LIgwqcwFoyXOS2vCK1/I5KBLlzF9hpwY3T0kESPDrN/aeNpH+Xik1HsIRNAD
         kTVOIH8pewWBenAJjSI0y76VunYXwicunyZfMWg/gZPz+N/Xy28AWBJqX+N5zcMYO+hB
         JqJUyYUcicerrn6izKPE3uuOXVjQOolUeZcwePEb3Z4DHXO9F/mslcm7WDC1h126/71G
         QovDvDh94DMZkNhc+WPCIpHc+c63my+KK8wR9d07N74QF3l/hiaM3Pt/vgptyrmZ70EE
         4UaR6CRvzr71AAb4/5UmmHZ4t1EI8w6EUa6rTDnjBKZnAo+S3TQLRrEkWNO2uv5QPfUe
         SJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2YMYRwdpChlKLHhe8WbosGJ4cA8kqH2VU21Jd3Bvh57R8bLP07ifJlE4JGvWkkn34BIvnfdHGACnFvlWDhhbPSFy+SYLi/9jK7xGyVZ8EJBJyU+FoO5K++U1KvOhsbP9AWY6Ak1lki0scfO3Tf3XUW04heBbBMFdO5/ezDEaQD8cW2seMmApmvxa17CTdzpADAZRJS+NfDG6agloNQwClsWCwLc0k5Xxb
X-Gm-Message-State: AOJu0Ywf3INTL2KiM7hpD7iyMc92HjUsEO3JNPUsa+cVEaTOIfU021rW
	fCgHc7dnKRTbfjAv5n+jZtW0pUe3qe7DXthp9IZZmORIRUEZLtmPMxn5x5ELmqs=
X-Google-Smtp-Source: AGHT+IHYANxiWhvLOsprzRXUbBwwI3vrR7oxUbl8IOtAzzNH3fOyWETfQuV5iwhoKSVanocu53HuSg==
X-Received: by 2002:a5b:44e:0:b0:dcc:67a7:430 with SMTP id s14-20020a5b044e000000b00dcc67a70430mr14452431ybp.15.1709818527574;
        Thu, 07 Mar 2024 05:35:27 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u9-20020a250949000000b00dce0f2db9acsm3497578ybm.34.2024.03.07.05.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:35:26 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso635024276.1;
        Thu, 07 Mar 2024 05:35:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7JMQEKzXmJPRTBFRpHFcVVgZXFRQbPegClywvUA/jdzR23WadsIXgpNjUBYieFOSpyY2h/o4k9hBBB5q53s/jNHORWase5xm56HMMHUBGrC4FV2aO6aZeL+/rfxkyUc/tLiMCP3KEvBtOfRLnuRTTOHYZWxNGo4AlqGr+VoGKW2QzHRxED4z372f0mQugW5xsAwrWBpSSXxPcYpW6adtYPRF0yHgzqVGm
X-Received: by 2002:a25:3355:0:b0:dc6:aed5:718a with SMTP id
 z82-20020a253355000000b00dc6aed5718amr15888780ybz.26.1709818525934; Thu, 07
 Mar 2024 05:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114731.34953-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240307114731.34953-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 14:35:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVi7ageQMmZYqCZJnCX79SBW=FGEHTMv7fZWRGmw4WwJg@mail.gmail.com>
Message-ID: <CAMuHMdVi7ageQMmZYqCZJnCX79SBW=FGEHTMv7fZWRGmw4WwJg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
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

On Thu, Mar 7, 2024 at 12:48=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC ha=
s
> three additional interrupts: one for Tx end/Rx ready and the other two fo=
r
> Rx and Tx buffer full, which are edge-triggered.
>
> No driver changes are required as generic compatible string
> "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v1->v2
> * Added validation to check interrupts and interrupt-names count

Thanks for the update!

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -77,6 +77,7 @@ properties:
>                - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
>                - renesas,scif-r9a07g054      # RZ/V2L
>                - renesas,scif-r9a08g045      # RZ/G3S
> +              - renesas,scif-r9a09g057      # RZ/V2H(P)
>            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
>
>    reg:
> @@ -91,6 +92,9 @@ properties:
>        - description: Break interrupt
>        - description: Data Ready interrupt
>        - description: Transmit End interrupt
> +      - description: Transmit End/Data Ready interrupt
> +      - description: Receive buffer full interrupt (EDGE trigger)
> +      - description: Transmit buffer empty interrupt (EDGE trigger)
>
>    interrupt-names:
>      minItems: 4
> @@ -101,6 +105,9 @@ properties:
>        - const: bri
>        - const: dri
>        - const: tei
> +      - const: teidri

As the documentation calls this interrupt "ub1_tei_dri_n", I think
"tei-dri" would be a better name.

> +      - const: rxi-edge
> +      - const: txi-edge

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


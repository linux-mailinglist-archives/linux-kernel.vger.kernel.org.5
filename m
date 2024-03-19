Return-Path: <linux-kernel+bounces-107530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A4B87FDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647B8282AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326075A783;
	Tue, 19 Mar 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEcjNzpD"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11481E4BF;
	Tue, 19 Mar 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852321; cv=none; b=LZQhPLjzShHu2ufKfDXx7xSQvwgYbgP4Kjce4sZ9XLJkoJyyx+pv+BIUBjZoqr7NDYvIjqkkms9FDhBPNvI1hhdWlnLFOLI+JOgLK5VyWd41kakSe273jdiktmkS480lnnCSCR5sDxQH3Mc1ht3ZrAAPizgoJPs195ztHHeC3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852321; c=relaxed/simple;
	bh=uWH0Ro9XG24lVXLdz6QSPi6hJo+xcnq6ND5qoTb1ScA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/VH34Sc2G+jUvqUCt3ciDtKeoLjhOz9Umkvk/y9VlIqIJV5B/rp20In7+EOsYmbpE/eRaGqvfXjqDFE72JyPeDAyfVCb4EpYl513Kju/NgOV4dRAfVF/ac30HdVcXcxT5vQEYv2TPIBBLMsXpRAE9zx+q58xVh7stwC/scJSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEcjNzpD; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d43ec959f8so737075e0c.1;
        Tue, 19 Mar 2024 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710852319; x=1711457119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TRN0nj5y7SM6+DeA2Go5q4zExBuxT8jctOtKQOcJuY=;
        b=CEcjNzpDuoCDvu3jojFnVFfdr5Udc3J+HRtHHnFclA/cXX7/szS6xntCEqHFUVIwBl
         HHH7kZ5/wxdeV3DZt+N5sl0tMOHCtCEQbQ4WwkUuk58uj034ZMT/FURvTPjfQ6iwiQtu
         dCFpLzpq4T9F8aZJf8mAk95etDFln3Ef2LPEQAgPi/bHH0lDMogTWLLaJ97XuYSW8Tpx
         NpwyQnXa1nfxMrrqExaRCAnfKzyGspAVv5zOOocH+zxfD+Gc+ntbf/wWyzrwCuoRz5+T
         /vMcFsYgAC/1o9iqtLmEx0V1nB+w2mDWXxDIjI99VdS/XNQ+N+J2dzr/Ws7ihuCgge0U
         xc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710852319; x=1711457119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TRN0nj5y7SM6+DeA2Go5q4zExBuxT8jctOtKQOcJuY=;
        b=lqH4C8/pf4du083JhtIBqeH/iCPSup/0LbmNDx/4IwSgobaWP4y3tLJvLvUJ96PX/G
         oDLFKvLLm0OUbS8KU0++xcfUFtxb/STadMO42raeJh+tnd85zyTUNxD1L5i+45r13JcP
         diRLMEzdRevlO0AiWNej70bfkyj8kNA1uy6LAvKhfAotc+fxRhdgDDXiV6gP1KtFZds2
         wFa2ypb6gXi29WGeavH5Blcw7lOyciEycKv3xncwbbOXustOJ5qHdGZwrMQdnlIhei3u
         cnZvPDhZgHmCfqyvDPFqg1gZhfCaqNs9FZcb/IrRCZuLHL+1iysmLVwujXhjlIDOyNJw
         lEoA==
X-Forwarded-Encrypted: i=1; AJvYcCXeDCMeySLJkdl0brAjQnI4tkzmBJ8TcZGyIUX+alKDi4oUaIhA339fmFCiF8iuJzPPLNkOMTyDYI9BvHYWwhsQdc3LRxJB7dbEW5J6LtcDKSzBKGNKe7O9fNK8wNJBy9LIv6LgbWmP/7ZmmXVSrAV7q/tEzunnqjBHJpviB35qqgRJ1VuFnxRfSAa9nlXpHJJor4Xmld5B/gXX4UpnQRz6pJKLfK1gJvFy
X-Gm-Message-State: AOJu0YxlO3teRAl7dj3Kcv+50BSIN7YPF6471RD/pIYIE1skW+8GgpLq
	cHdOJ4f2gLRLEahPTp2KQ6+ScZ4mT2G5pzm61/WcAWG/xmzs9osMK0eLOAjnmusMLeMI/dNabL9
	bb0EkbE5gQyGP/j2CEWfuJtkFcFM=
X-Google-Smtp-Source: AGHT+IHJPomT7sP53nJXawvVpaRjsxhtKM+VCNrfHI9UzyYiM4vfyEEMa1IExYYbYGUknB+IHNYSLNsGYwi7YIZgbFk=
X-Received: by 2002:a05:6122:690:b0:4c0:9ec7:b324 with SMTP id
 n16-20020a056122069000b004c09ec7b324mr10279107vkq.0.1710852318689; Tue, 19
 Mar 2024 05:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318172102.45549-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <db13e305-adc4-4990-b9ec-b1cdcdad4406@linaro.org> <010e4742-438f-413f-811f-a033ec104832@linaro.org>
In-Reply-To: <010e4742-438f-413f-811f-a033ec104832@linaro.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 Mar 2024 12:43:53 +0000
Message-ID: <CA+V-a8txP39HJJrJcNqCUgw2NkdA3uSvBrbdSzw0bN6r5LpNaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Mar 19, 2024 at 6:22=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/03/2024 07:19, Krzysztof Kozlowski wrote:
> > On 18/03/2024 18:21, Prabhakar wrote:
> >> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>
> >> Add support to validate the 'interrupts' and 'interrupt-names' propert=
ies
> >> for every supported SoC. This ensures proper handling and configuratio=
n of
> >> interrupt-related properties across supported platforms.
> >>
> >> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> ---
> >> v2->v3
> >> - Listed interrupts and interrupt-names for every SoC in if check
> >> ---
> >>  .../bindings/serial/renesas,scif.yaml         | 95 ++++++++++++------=
-
> >>  1 file changed, 63 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yam=
l b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >> index af72c3420453..53f18e9810fd 100644
> >> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >> @@ -82,38 +82,6 @@ properties:
> >>    reg:
> >>      maxItems: 1
> >>
> >> -  interrupts:
> >
> > I don't understand what is happening with this patchset. Interrupts mus=
t
> > stay here. Where did you receive any different feedback?
>
> Look how it is done:
> https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bin=
dings/ufs/qcom,ufs.yaml#L44
>
Thanks for the pointer, as the above binding doesn't have any
description items as compared to our case, to clarify I have updated
the binding is below. Is this the correct approach?

option #1
---------------
  interrupts:
    minItems: 1
    maxItems: 6

 interrupt-names:
    minItems: 4
    maxItems: 6

  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,rcar-gen1-scif
              - renesas,rcar-gen2-scif
              - renesas,rcar-gen3-scif
              - renesas,rcar-gen4-scif
    then:
      properties:
        interrupts:
          items:
            - description: Single combined interrupt

        interrupt-names: false

  - if:
      properties:
        compatible:
          contains:
            const: renesas,scif-r7s72100
    then:
      properties:
        interrupts:
          items:
            - description: Error interrupt
            - description: Receive buffer full interrupt
            - description: Transmit buffer empty interrupt
            - description: Break interrupt

        interrupt-names:
          items:
            - const: eri
            - const: rxi
            - const: txi
            - const: bri
  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,scif-r7s9210
              - renesas,scif-r9a07g044
    then:
      properties:
        interrupts:
          items:
            - description: Error interrupt
            - description: Receive buffer full interrupt
            - description: Transmit buffer empty interrupt
            - description: Break interrupt
            - description: Data Ready interrupt
            - description: Transmit End interrupt

        interrupt-names:
          items:
            - const: eri
            - const: rxi
            - const: txi
            - const: bri
            - const: dri
            - const: tei

Cheers,
Prabhakar


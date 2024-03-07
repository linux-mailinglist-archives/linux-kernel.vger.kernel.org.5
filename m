Return-Path: <linux-kernel+bounces-95297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE77D874BE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747BB286042
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421908529C;
	Thu,  7 Mar 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAMxW1zg"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEF83CAE;
	Thu,  7 Mar 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805864; cv=none; b=folEbozIwFh7MWp2Te/nf19gULQU75J+roR0YNgkP3pmzYPLLQO1tHGCFdDj8yVnfi+jG3udigKVVY8f1frgx4h7HWN/V3fJ7oboOsglwiFh7nr4/1aLQm8zORL3LMwwpLcCauRSZf6+XOi1Pllpbmfx8vtN17AnC1r00F0/ZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805864; c=relaxed/simple;
	bh=iCkldeipvQOIgZslWygbPiAdWKmL3QMKJVqnBUCaJgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZB/g/qrkP6TMW6dX2PeCDlPzIHvzzTs4Ru3i2Iibp2VVga1I+ixG2QKxYBFeLU8EIBuSgysS7WF9QAuDLtHK/WHkyJFdk0Q9FqWLjAcmQQ5kNCqB0y5lkDUZmkuA8sb6uxnOOqYJs9PZnL02/wwQocSqW7hI+ansSL4IDrd/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAMxW1zg; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d332d0db9cso72773e0c.3;
        Thu, 07 Mar 2024 02:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709805862; x=1710410662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWung4S3LQUYquWoqIN1pFg5TBe+xxRcnHe+DZPUK4I=;
        b=PAMxW1zgOHLGfoEd15KExzFr1xIKXWHxon5Z5mR9Gh+HlRgLf+KbglDst8jFRGSRm1
         UypTg81gdGY+Jvj/rI6OUeo0A1p6vzP6edgb47RENcDzeWJfJaQoM9WKtkJXCcMS6T5Q
         +Ewko7ZfQaaMlbQOLcjWDXBj9lDcqdw7JxwwNcJBRQ/c50LVSO5NF4VkUfDdASzYt2Xv
         xXSVjx53R9T7SQkaRqjtjG8oRs4o+oHKYW/Hl/iIiSTw6+w0cjFD2xk3I8wDdonvZM30
         bX2AZutKivzBQ46BiLiFGmFHzlnLX7lqxUa5fWBXbPJ0L54ejZ19r/sDkY0hvT0JxEGH
         AQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805862; x=1710410662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWung4S3LQUYquWoqIN1pFg5TBe+xxRcnHe+DZPUK4I=;
        b=sFdMeVs/D4AWbRdoQrsFm8P3Qi7O6SHOdpklDEgyOT8VCv6jyUjabQjxubtj9TmKeM
         zHcHnmkCCv2WndN69Sp/kLxmy4v2GspQEI/in214XiQMBRPrnIdx5AMV9kaGSwUow8Si
         l5iFa2dlUqVMa91tjJ2Xu57x/2V+eoRA259f+ypKSF4Dnmfif1Om4dEPQmpm+6SsOZhr
         iWyw7djzmP+3mnqeEEKoq9OwTsZQqZFF1paNtT7b5ge6DwwP5U/c55Id3dXbvh6D35RK
         5kn771ewJmmW0zJhw3lRvlkWdR9iMBrALYPnTjrMRoYd7KQaaFB70+ZeOhN40KDCxVrw
         PiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0viitFfH0Bmadl/oiifUIabUgia+eQ+SiRyUJTUBOWnq6KuqTWaG/MB5E/UmztvzPxwkQ79LXqWorAtkRGzpSV9H3rIHM0PTtae4xlLibADSgcLv/ToGKWrZ6HiZjbr0pHeGJAvWQ1XMdE84fKJBydP78Dw/lXYFBph2Q0EiharUCzSnf8izPOZjec/xKuJ3LdNqLSQ1THep91R+WXDJltQ8etmy4MtCF
X-Gm-Message-State: AOJu0YwYtcPjuY5MRiz16L1blMs4+2dMgLS01kiY3HXrvr3CYuNBL0Tc
	zvp9vOnVRcJZcuKmRpB3ZiBblDBgrfG7F4SsMBPgqw6Ss0TvA3fh6PIfrB4oZo3D4LgBD053BR5
	lh5XK5hlEYyZ+588Cv1X4v2sjRlk=
X-Google-Smtp-Source: AGHT+IHvRc3VC+D3ufvw9SI/LIPn3a2nBCWlUPuQ15pdNjsolhLr8jKUha05lO9Ya8FnROJ/wt2FBciPR617sF04dCU=
X-Received: by 2002:a05:6122:2018:b0:4cd:b718:4b08 with SMTP id
 l24-20020a056122201800b004cdb7184b08mr8157351vkd.11.1709805861784; Thu, 07
 Mar 2024 02:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306231007.13622-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240306231007.13622-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVQcyrwTCTukhLFiaawDgbKwZWcWCO7bc1FfFS-t=kcqg@mail.gmail.com>
In-Reply-To: <CAMuHMdVQcyrwTCTukhLFiaawDgbKwZWcWCO7bc1FfFS-t=kcqg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 Mar 2024 10:03:15 +0000
Message-ID: <CA+V-a8v=zMW4oW+fH1nX70fEXP=f9BhWDYgxMy_LpuXvVG5wow@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

Thank you for the review.

On Thu, Mar 7, 2024 at 8:58=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Mar 7, 2024 at 12:11=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This commit adds support to validate the 'interrupts' and 'interrupt-na=
mes'
> > properties for every supported SoC. This ensures proper handling and
> > configuration of interrupt-related properties across supported platform=
s.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -82,38 +82,6 @@ properties:
> >    reg:
> >      maxItems: 1
> >
> > -  interrupts:
> > -    oneOf:
> > -      - items:
> > -          - description: A combined interrupt
> > -      - items:
> > -          - description: Error interrupt
> > -          - description: Receive buffer full interrupt
> > -          - description: Transmit buffer empty interrupt
> > -          - description: Break interrupt
> > -      - items:
> > -          - description: Error interrupt
> > -          - description: Receive buffer full interrupt
> > -          - description: Transmit buffer empty interrupt
> > -          - description: Break interrupt
> > -          - description: Data Ready interrupt
> > -          - description: Transmit End interrupt
>
> As the above three groups are increasing supersets, you can just use
> a single "items" listing all 6 interrupts, and describe the first one
> as "Error interrupt or single combined interrupt".  After that, the
> SoC-specific logic at the end just needs to specify the appropriate
> minItems/maxItems.
>
Agreed, I will do that.

> > -
> > -  interrupt-names:
> > -    oneOf:
> > -      - items:
> > -          - const: eri
> > -          - const: rxi
> > -          - const: txi
> > -          - const: bri
> > -      - items:
> > -          - const: eri
> > -          - const: rxi
> > -          - const: txi
> > -          - const: bri
> > -          - const: dri
> > -          - const: tei
>
> Likewise, with "interrupt-names: false" below for the ones that don't
> need it.
>
Agreed.

> > -
> >    clocks:
> >      minItems: 1
> >      maxItems: 4
> > @@ -173,6 +141,91 @@ allOf:
> >        required:
> >          - resets
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,scif-r8a7742
> > +              - renesas,scif-r8a7743
> > +              - renesas,scif-r8a7744
> > +              - renesas,scif-r8a7745
> > +              - renesas,scif-r8a77470
> > +              - renesas,scif-r8a774a1
> > +              - renesas,scif-r8a774b1
> > +              - renesas,scif-r8a774c0
> > +              - renesas,scif-r8a774e1
> > +              - renesas,scif-r8a7778
> > +              - renesas,scif-r8a7779
> > +              - renesas,scif-r8a7790
> > +              - renesas,scif-r8a7791
> > +              - renesas,scif-r8a7792
> > +              - renesas,scif-r8a7793
> > +              - renesas,scif-r8a7794
> > +              - renesas,scif-r8a7795
> > +              - renesas,scif-r8a7796
> > +              - renesas,scif-r8a77961
> > +              - renesas,scif-r8a77965
> > +              - renesas,scif-r8a77970
> > +              - renesas,scif-r8a77980
> > +              - renesas,scif-r8a77990
> > +              - renesas,scif-r8a77995
> > +              - renesas,scif-r8a779a0
> > +              - renesas,scif-r8a779f0
> > +              - renesas,scif-r8a779g0
>
> Please simplify using family-specific names:
>   - renesas,rcar-gen1-scif
>   - renesas,rcar-gen2-scif
>   - renesas,rcar-gen3-scif
>   - renesas,rcar-gen4-scif
>
Yep, that makes sense.

Cheers,
Prabhakar


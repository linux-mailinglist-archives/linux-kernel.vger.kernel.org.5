Return-Path: <linux-kernel+bounces-158955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131478B2752
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FEC1C241A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8FD14EC55;
	Thu, 25 Apr 2024 17:11:34 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607E14EC44;
	Thu, 25 Apr 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065094; cv=none; b=iR/+peHALLnuMQLbV+CRGZuhdTXy8i0+pENWclcGLXpqLVmI1sJ2Rzj5YVhodH/e/0z/1EL607Kv093qKrkIwOt6XAjW6Qz81nQarduJ4p+koCQVOvzZrG3AK2BhpQfMh8cZhYOI3rBu84z9EtQvarowY/gpwvznWMh69ZPPURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065094; c=relaxed/simple;
	bh=/ZZJ5dz0J/wesEssyoep7KtF9+Y3JDVVqC4thZF7R1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9KhRP3/kYv4SZEiVNHNAN1n4P0iweRVz/4vtuT/ZWLV9FvFi2AIKZCsOACeMm840ojHctuEyrDZ9Bve3xhIFhIV8AcP3WxYNjDZs3hqewThLlwWLx1TdH+juuqKLgmkoYMwnWGERNkR9kZT91yqU4UUSo500isSmaCFigthwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6164d7a02d2so14789947b3.3;
        Thu, 25 Apr 2024 10:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065090; x=1714669890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgCSDQ05EYWH1Axl0jxdSLHbjqm9MhNQY8JA68iKsT8=;
        b=vZfCb1E1KvTaTJBNpfFsIbn8yZjKQ9fpQwHbuYbWG03c3Da8auyjLwvF+DeEXmt1NF
         fwF/joYRFZK+cfQCABsuqcEoZS2D8Kx9JGUbELmDVDn6GEcwek25sfwx9EkVEa1weo9a
         6m1u2M5OnYJLbre+zrXnqNkuD1sl2GBDe5b0umnReKhNxHqPBxJLprLaJmITjes14aLj
         cONgl2NBbzXkHGgaD7kGF7Ol410MNfFw79NDIr+mwVOBUHQoPOqzPYuETYzmWENfUOwp
         Yha5MQpeqExG8zEkffl0q3QQBQv9u6gTKzDfBbyTBxe2GR7DXwNHmmops4zV5HUuPccU
         rLpA==
X-Forwarded-Encrypted: i=1; AJvYcCVN/NpnPwIBILLKoRjo/S4V2qSJHPZ6lbjFNDXhaSkVbWFOhYMMWHvmF27QGNDj54ynXbnlxPzqrapcNNmD+B9oVipe7kZRpMMnjoijvNLXFjDqdM7kgrrgI0tTJ9b9FQD1EKZJizbyZiWnREVREQYtukyzjhZT7k94Yy1RtzRfyl6M4Ejalvh3aJ8+gczjcrbMkdYDh1wkmIzInBNuEFuXdM6DPjL/
X-Gm-Message-State: AOJu0Yxgi/SY338vpDDJtph5VmjAtXp8k05lV3hx2fC6dAPb+qoGyh3v
	j4rmzdxI112KXYD8CxN7pA0r29yCofU+5ijy9OLiNXBgXsA957WeqMi8wGZ9
X-Google-Smtp-Source: AGHT+IHdxhRM1FFGt0DaDC1sce6bEtzJWJgDD5SD8xZszeeKNNi+i8n6mbRvwniGWU8gTJpCNWR6XA==
X-Received: by 2002:a25:81d1:0:b0:de5:568a:9a9 with SMTP id n17-20020a2581d1000000b00de5568a09a9mr282456ybm.38.1714065090145;
        Thu, 25 Apr 2024 10:11:30 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id m3-20020a252603000000b00de55b3bde0csm1406672ybm.42.2024.04.25.10.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 10:11:29 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de596c078c2so776318276.0;
        Thu, 25 Apr 2024 10:11:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXi/CcJ3eOYoEbXwLX+WRdAN6dikI6wcOriubgLKu/U0F9LCcf5p/SVDmLksuwkK2fnsA/o1lXtFktFjTTxRMk7vMdXFQsIxjHjxY+YRz4Msb7xj9rn6dF3jUJYj0JCHBbOkMLhh5HVWIdcV/6nlv7gs7v1EHEAwry9kZv8Ng3YbEzJuFfi2MVB3/EtlVicyqN1/SluP9p881l/78fqMIyfwObRcula
X-Received: by 2002:a25:c70a:0:b0:de5:852f:6afe with SMTP id
 w10-20020a25c70a000000b00de5852f6afemr297083ybe.30.1714065089010; Thu, 25 Apr
 2024 10:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240423182428.704159-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <7a3d4b8a-e89e-499e-92b7-9f63fbc84011@kernel.org> <CA+V-a8uz0OrsM1AxqtpeHB0f1+F6aEqHGp_t3_OPhh0ZqJ26HQ@mail.gmail.com>
In-Reply-To: <CA+V-a8uz0OrsM1AxqtpeHB0f1+F6aEqHGp_t3_OPhh0ZqJ26HQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Apr 2024 19:11:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=CTUQNm6OZN0Ck-nXKme8vZ2Ld2rDxHfQZkP2VdnNeQ@mail.gmail.com>
Message-ID: <CAMuHMdV=CTUQNm6OZN0Ck-nXKme8vZ2Ld2rDxHfQZkP2VdnNeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: renesas,sdhi: Group single const
 value items into an enum list
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, Apr 25, 2024 at 5:44=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Apr 24, 2024 at 6:42=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> > On 23/04/2024 20:24, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Group single const value items into an enum list.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v1->v2
> > > - Updated commit message
> > > - Grouped single const value items into an enum list.
> > > ---
> > >  .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 +++++++---------=
--
> > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml =
b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > index 29f2400247eb..2bf90095742b 100644
> > > --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > @@ -13,15 +13,13 @@ properties:
> > >    compatible:
> > >      oneOf:
> > >        - items:
> > > -          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
> > > -      - items:
> > > -          - const: renesas,sdhi-r7s72100 # RZ/A1H
> > > -      - items:
> > > -          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
> > > -      - items:
> > > -          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
> > > -      - items:
> > > -          - const: renesas,sdhi-r8a7740 # R-Mobile A1
> > > +          - enum:
> >
> > You wanted to drop the items, but I still see it here.
> >
> Ah, I missed that.
>
> > > +              - renesas,sdhi-sh73a0  # R-Mobile APE6
> > > +              - renesas,sdhi-r7s72100 # RZ/A1H
> > > +              - renesas,sdhi-r7s9210 # SH-Mobile AG5
> > > +              - renesas,sdhi-r8a73a4 # R-Mobile APE6
> > > +              - renesas,sdhi-r8a7740 # R-Mobile A1
> > > +              - renesas,sdhi-mmc-r8a77470 # RZ/G1C
> >
> > Keep list alphabetically ordered.
> >
> This list is sorted based on SoC, I will sort it  alphabetically.
>
> Geert is that OK with you?

Usually we sort alphabetically by compatible value.

(FTR, sh73a0 is sometimes called r8a73a0).

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


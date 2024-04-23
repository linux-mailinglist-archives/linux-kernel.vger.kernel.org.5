Return-Path: <linux-kernel+bounces-154982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9342F8AE3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4412D286066
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECBA7FBCF;
	Tue, 23 Apr 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP1JvZTZ"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318167E573;
	Tue, 23 Apr 2024 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871649; cv=none; b=GVa6QjWFANBBuAZ0uhvRGtcYHiP5DAPT8spWIctkD7Mf992u8elYwijWuvfJON3tdjuNFzczGZf4051d0bMgSuE9tvKEX3M/Kg5eVBW9tFChumX2NHbBOm1iLtWRWytJ2dBLjk9vstTRICMkl/XqpZ32A+PwrYbY/1PdnoLDNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871649; c=relaxed/simple;
	bh=RXjI0rE/2Bz7aU5n8VbUuaFd1Y6UY+NP4eppUyr6WG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVBuwtE05S5mjp9QQNiYCJO8OogG86be8+h7AmpszreD5CtPfrPReiehwPlSS75EkBMQ5kmW+N7JwFyxvmt2y6PAA9diTufMKG1nGcHysUvJfdeOgmzJIBf8A084uJp0PK76T4S18aZCFPMhLspOPMnRomGOSX3IWejbn6uBr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP1JvZTZ; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4dcbf770c24so2865355e0c.1;
        Tue, 23 Apr 2024 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713871647; x=1714476447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fXVEYwcrN6pIHZeASeinQCONCWFuoO/BqgRK0XIVrE=;
        b=IP1JvZTZ6OF58FNjIL6W8KGA4hXNX24CiPLUwHUBlKqf1LbqB6B6ygqeJfCO7J2cwK
         JpdWstI3V6T0MoRgvWTjoLrvCISspAmaU2BSJ4VyXBG0d72uBjEpd11LCRWJrDp3v/LA
         k8GQRpTU7nHvkBwjkVVMv0mvACLRcW7jzeilopE6LmVteCMUI3pmfH+LskLRbg0fZ52h
         X35ncqUmGMs7z0eLMmHgB+TV+lMfT8J/+ID8wwaNlA4VCz6PtpGgXsio28YiGg5haycg
         2eEyGGu6g3RWTTwri5ib5jpv9baGXn8DZtLM/4lEHVDIrutzrYqcBY+E+94vbeK3ia4X
         iLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871647; x=1714476447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fXVEYwcrN6pIHZeASeinQCONCWFuoO/BqgRK0XIVrE=;
        b=v1l2eHXLVjNNNb/9xZq9ZyFwqyTKjHY4rGOgGoOnSlQPu0YSXIYrFvLDA7i6jJ6c5W
         zzOtwZw+TApJ5wPiVXBcEv5Tk3ACwCnKSGJow7pVR+lTwiUxt1zaOoOk/jGGcY1rQNTg
         pWRn39HmBBXlTQmS/WqKcUG/1sOmEkywrzCgqU66XB9H/puzEOqWGUSev+RV0FkeZlXO
         cFJjXWmqVYM+pfibaxNBht2tTdv6dCIDGQqbTDziljcHnJ96jwFcJFabnrag9T3lKnfZ
         t3IDhGKin3FThmK1gRSmjXG6lsV268JYU5Gp7EZCxH2FZCp9+dByH5fqR5Wg4w31T8/X
         mDWg==
X-Forwarded-Encrypted: i=1; AJvYcCUrbADHlgO+0DTaXwaKiVYM0eoTltav8uvJA1vRwCyi/7+lSoJFhL7NBzFiA+vTH9s9bga+MFFMV/60uqpDJacvsD1o7pJO29b64z+KmKvnvVfyf8wX5UAifl3zKC8jOn9kRgZzL3hWmuTdqmbusBB0J8LMGlk4TJPsBKYYDhs4RlXLG3F+M24J2eZ8oyR/M65SMR2mNDISLLIFyyODQTq/IzDYc8u/
X-Gm-Message-State: AOJu0YxVg7MGN8pJu+W3iU5am3CR5GSIuWLHzk6bo+CFUJWQF7z4Tec4
	3s70jzTOasvVX2/5/U7QQaacCb3HEO2HjYMwptFcHRXOuAOWlBL2RiQ7r+v93mcNvF+iRiDSJcQ
	TXUxmyEmLODUQjzCFN77I2ZPuDMc=
X-Google-Smtp-Source: AGHT+IEJ3YDW07lTxjloRNMEO4SRdGN1iz21J8b16q//J8FH3OjnhcGXWzQ5yHk0Wb/3+b0zKw3Ipv4gFZb+3y7JY90=
X-Received: by 2002:a05:6122:410a:b0:4da:ae51:b755 with SMTP id
 ce10-20020a056122410a00b004daae51b755mr4960853vkb.3.1713871646754; Tue, 23
 Apr 2024 04:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240422213006.505576-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2b422e9f-bd80-4c57-a3e1-8b463b25c834@kernel.org> <CA+V-a8s1xDT7sGMpz_n45v9QzhpWUdJv9eXmUJoxPaJ69MiY7A@mail.gmail.com>
 <4c6d6957-3813-46d3-88de-ee64241bbe6f@kernel.org>
In-Reply-To: <4c6d6957-3813-46d3-88de-ee64241bbe6f@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 23 Apr 2024 12:26:50 +0100
Message-ID: <CA+V-a8s2pahd23jhkYdxJ_j8SxADaYf4QxOwO1_3jmCr9MzuFw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mmc: renesas,sdhi: Drop 'items' keyword
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 23/04/2024 09:21, Lad, Prabhakar wrote:
> > Hi Krzysztof,
> >
> > Thank you for the review.
> >
> > On Tue, Apr 23, 2024 at 7:29=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 22/04/2024 23:30, Prabhakar wrote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Drop 'items' keyword from compatible list which have single const val=
ue.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >>> ---
> >>>  .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 ++++++----------=
--
> >>>  1 file changed, 6 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml =
b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> >>> index 29f2400247eb..90c8b1b727a8 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> >>> @@ -12,16 +12,11 @@ maintainers:
> >>>  properties:
> >>>    compatible:
> >>>      oneOf:
> >>> -      - items:
> >>> -          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
> >>> -      - items:
> >>> -          - const: renesas,sdhi-r7s72100 # RZ/A1H
> >>> -      - items:
> >>> -          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
> >>> -      - items:
> >>> -          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
> >>> -      - items:
> >>> -          - const: renesas,sdhi-r8a7740 # R-Mobile A1
> >>> +      - const: renesas,sdhi-sh73a0  # R-Mobile APE6
> >>> +      - const: renesas,sdhi-r7s72100 # RZ/A1H
> >>> +      - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
> >>> +      - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
> >>> +      - const: renesas,sdhi-r8a7740 # R-Mobile A1
> >>
> >> That's just an enum.
> >>
> > Are you suggesting to group them into a single enum instead...?
>
> Yes. That's preferred form, easier to read, because it clearly documents
> that binding enumerates.
>
Agreed.

> But just in case you start changing all const to enums: don't. Comment
> is for this patch, since you already want to touch these things.
>
Indeed.

Cheers,
Prabhakar


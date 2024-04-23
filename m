Return-Path: <linux-kernel+bounces-154596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DAA8ADE21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588242833F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B51A1CAA2;
	Tue, 23 Apr 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6m3P02R"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D845BE6;
	Tue, 23 Apr 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856908; cv=none; b=iIynaCi5vtAaqPeS0BJj7YMPy3MVEL5ijazIhemEnlFnLhuqHIM81m+fPt0B1DHiXp9+/a3DV2hBGLHH8AFMXBZ2I9RKVLgEyjVGuXrRW09ryrtDcnHqrubJ46vnK0CqcpzeRexdIuHUfk0X7ixURXidsw0G/b6YmDpdqRIKYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856908; c=relaxed/simple;
	bh=DZwvJBUuMA47kEE0aDP5oilaNQckPgJ5T7HKSFYvLKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOdk+BYCQAaWBTrtH+yqYr8CYaBA9ej6wWDskmdYU1GgwVn8942Qe+OTyGsLEVaD3IfhvypusUVnYAgmzb31Fh+NT47S1yG55fVEJbWr6vr6gHpAF3FynBPt6GYJXMjJBrf8Let4YRMwCuE3nDdz9ClYqJRwLMgWpifHHp+aT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6m3P02R; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4daa8e14afbso1536908e0c.3;
        Tue, 23 Apr 2024 00:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856906; x=1714461706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGcido0Tu+sqPBnY3rW0RLBhQu5+ta+3ZIsULRMIDXI=;
        b=E6m3P02R9Yh9Nwzh9FkZQD1Nra36wlp0e2WTtJYdTw+rr8uMJCFh3BqCvsbWNxQole
         dD1cLWRMAer09b54JkMKP2PR2rqQszQVWkWOt2+IwtddCxxlQfeQBWBV697nMvIgEBwx
         dcH4vj5ZkvtK/h6Gesh7FB7Rpz4pzempgPgQoAx1do6WaGvcaJAoytCTfwtHyiujuGHq
         orDRjJ5wGyvL4sE0SO7QlOd35kJbU9N+dy9sYGiHJikUL/yD9mt1x6avC95Ue5uITbbN
         9roC4LCqBM1F0qAsYB1USB1KEOyBYOSv071E9vTHncgeYqdSB6O1rA2KNWnNkmOhAbNH
         LyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856906; x=1714461706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGcido0Tu+sqPBnY3rW0RLBhQu5+ta+3ZIsULRMIDXI=;
        b=B+LG4SfL/tt66Ze7HmyfD9kOtgEE7r/4vq/ckyi9JYIsWV5YgSRlJ463ohUQm8wb3T
         H8LF9xOQDNWqw2l3nWpvn/HoM7Pf0nQ+YWNWoQmCZgerSRMRp8bifsEantUQgF1+9tFR
         UFhXUBXCJ5elGqqSsC0O1J1e7eCRTADzkF+RE51i5JY7E4XT3ktMMfPz7eQv8swd/ojJ
         PraIVvmz1bUmbaKnm536xqAjz4X6lMFPyTqM0CSRHMBHZj6a6zFjeb0S0raKAhKZ2p0m
         0PXhLyjMF8vNKZWAwmqki5NHZa+YYNuSUlN5acYFPUZFYCu7oH6r6wsKNn49MMkMH4+R
         vvfw==
X-Forwarded-Encrypted: i=1; AJvYcCUJBjC8fpRq1JeGaVUziIw0bFNyEW2yaV8MzUNg/Cg6XcdXW1AgcktJo0tnNr2GX2zhKLg/RwNQK+gDWXhWq75A9FrdED0IPe01ymEqp2WEII3kEwIaudgTNLDi0+ZD2TNrC4nmskd1v0bAHnT4EbMPQHpZUoKLJNZlEYuW7ffJZPodSNXhpLG7qRuwjnMguAjFcIYYaLTaZAis1O17UqbAhGCtguwU
X-Gm-Message-State: AOJu0Yx8TC6ZE8k1IwaA7KHFt53aOTE/4j3V6wdmM55MYpe3RiRkdRMs
	YSnyab01KD1V5whXmHnR2bOlfWHNO0adN28YGPZc9UcehcwnEvwMjeSBMvDtgpQ+dsuCmOiC1Zy
	ZPHG+XkkJnmSUn/PU0EzFW7XZRMw=
X-Google-Smtp-Source: AGHT+IEyHdKoSjSmv5SMk26d8PY4/GPGiTFy/VyKs/OO8cHM21g6iqyz3G7fRKdiqOyBXWm0NB+BCIqWy8c5R5GLtyU=
X-Received: by 2002:a05:6122:ca5:b0:4da:e777:a8e6 with SMTP id
 ba37-20020a0561220ca500b004dae777a8e6mr14730429vkb.14.1713856905886; Tue, 23
 Apr 2024 00:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240422213006.505576-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <2b422e9f-bd80-4c57-a3e1-8b463b25c834@kernel.org>
In-Reply-To: <2b422e9f-bd80-4c57-a3e1-8b463b25c834@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 23 Apr 2024 08:21:10 +0100
Message-ID: <CA+V-a8s1xDT7sGMpz_n45v9QzhpWUdJv9eXmUJoxPaJ69MiY7A@mail.gmail.com>
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

Hi Krzysztof,

Thank you for the review.

On Tue, Apr 23, 2024 at 7:29=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 22/04/2024 23:30, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Drop 'items' keyword from compatible list which have single const value=
.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/=
Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > index 29f2400247eb..90c8b1b727a8 100644
> > --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > @@ -12,16 +12,11 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > -      - items:
> > -          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
> > -      - items:
> > -          - const: renesas,sdhi-r7s72100 # RZ/A1H
> > -      - items:
> > -          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
> > -      - items:
> > -          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
> > -      - items:
> > -          - const: renesas,sdhi-r8a7740 # R-Mobile A1
> > +      - const: renesas,sdhi-sh73a0  # R-Mobile APE6
> > +      - const: renesas,sdhi-r7s72100 # RZ/A1H
> > +      - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
> > +      - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
> > +      - const: renesas,sdhi-r8a7740 # R-Mobile A1
>
> That's just an enum.
>
Are you suggesting to group them into a single enum instead...?

> >        - items:
> >            - enum:
> >                - renesas,sdhi-r8a7778 # R-Car M1
> > @@ -40,8 +35,7 @@ properties:
> >                - renesas,sdhi-r8a7793  # R-Car M2-N
> >                - renesas,sdhi-r8a7794  # R-Car E2
> >            - const: renesas,rcar-gen2-sdhi # R-Car Gen2 and RZ/G1
> > -      - items:
> > -          - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
> > +      - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
>
> This as well
.. including this?

Cheers,
Prabhakar


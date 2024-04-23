Return-Path: <linux-kernel+bounces-154593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5668ADE12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5541F21E29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C445C04;
	Tue, 23 Apr 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O44fFuwH"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B91C698;
	Tue, 23 Apr 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856502; cv=none; b=UUuvOYljAN+O1LiCnkkpN+pMuD/be/yQcIdxUzVYXRLq2+f1bUW5ZoEL4Tld2h7UgJAaDYQp8ZTFBF6686/Aor8c0IU2z9u43b2DQDJ5iOvK0i/0a+eT1I/J4dIP2CaSH0vzuGi0KrKWF4Pq5E2wqdBNMKn2CD1oO4huwSiLQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856502; c=relaxed/simple;
	bh=SAa79N3zmflGnQeD33LUpSd5fXemsU8/iuUnxoJqVTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3PIYHkugzsTkxCWDGJ/S/J1aAzJM5OQPDSIbN7SWiCHHDoj6CCsPIybh3PUE1fmEeTZ/igssOEpL/bFtpR5ni2ZV6P4Sdm4vZeyMFPl/rRp5dwd56yZ2nBo55FeCCl896y0FMUNVn+DsjxJLWuSzTdu74maSunWcyJFP2g7SR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O44fFuwH; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dabc6f141bso1591749e0c.2;
        Tue, 23 Apr 2024 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856500; x=1714461300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPlf4sOb4CBsDRYESTX7kE1ZTTzyJO4yMjeLXkXUgN8=;
        b=O44fFuwHM9zFMHsQTIueCN5W+IF3khCmH7j5l5sWhagz64UGW8R6E7d/DmCK5MerG9
         s27VkWJe1liyuQvkEFPPC1C5O4T6uoYxtSAymetBSjEwgIkH+rNvkAq1uRhQ/JGNOosU
         R8ZoixYlpTidv9iTsAuRS3Tl36FLtossQtF6BxCMrtddIF3NjtbrvmG9kmKJK8Ua2CmL
         qiOg/lzos2fx9oaKhpLIfLNU7+AX2175MdRz8Vh3GkxBul/y9JtWAub/B3qNLGx3wJvW
         9M0PuqwWvrAMVQaP2J1py1UzWNaVrovj5qXDdewu8fVUkn7PbYHZ1CGLvWHg4bTeQLFQ
         EwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856500; x=1714461300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPlf4sOb4CBsDRYESTX7kE1ZTTzyJO4yMjeLXkXUgN8=;
        b=es1IVoPWcqflTAvrqWPl9bJWIp0bnP2huE5+3Vw9zknRYdaRZ3td3eEEHGtHS4eVv9
         IPBMi1/20b+1umZvgkPDewvb7/nN12J8ic7zHR68sZVha1tZJd1X7dychNVFu10V5LTo
         5KWkdr0Ou1obnU2t5b6oTF+L24JMG8krk4njvInjOtBtXWbBwxc+QTpwlS1APVfZgbaW
         LZ7BB9zoqrS8kfWnjjJhRr1XYWpVvG3ePgR+dFM3Ozy/foUhYE+mC1Cd81iAaGKgB//7
         uAMV0cYgOw0EkrcU0CeEbdd2oikr5Ey23Xn+N4mXnwzDRku9pSBG0eUdn1dDDOTrorKE
         x5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLZKMaqZMylO+/iV0TxfrpPDLg3aMa4W1OJTVQ5CbXlUwCuxGaRF6JKmB//G7ey1ZZwWLUqaQ0k8K6XEo6U2rD9BORpsgKPlKWWHBT7ONZ4b0QmfUg/Nuze+GwM5G16/Vx9cEzBA8f7yVHQkpszSJ0SK4vPry/ccxXfLn9pOjsr01Y0AKia5r6RWmmP9d4dZP2cCjGooKUCPZeFw1twb9AWBjTTO/Z
X-Gm-Message-State: AOJu0YxU3ev1ZVhN6HTudY/3HQZV0uoeGr6YZoKnp9R8zvVU5tWoQaiF
	lQBzHHOVsKP9o0SfUCytu72dtd+yVqzcPbglM7yJY8zzxaWlholxMySsP3BLmh0ID3NiF0srUgA
	bULb94K/xyGVRRCp36U/ZhgccQrY=
X-Google-Smtp-Source: AGHT+IG8ZUio4LPu06SBjZreFIXyWMaD1iYd6cnHYOwhyih1/+qoLF2ra0CEOIxRH1k1P/gYFs3rb7ZNUL0IanUUE8w=
X-Received: by 2002:a05:6122:d9a:b0:4d8:9541:41a0 with SMTP id
 bc26-20020a0561220d9a00b004d8954141a0mr13909673vkb.12.1713856500137; Tue, 23
 Apr 2024 00:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW3YQMUOe9pP6TLjWTTkS-UNmzz21eqgW0nMQ4SUkwxGA@mail.gmail.com>
In-Reply-To: <CAMuHMdW3YQMUOe9pP6TLjWTTkS-UNmzz21eqgW0nMQ4SUkwxGA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 23 Apr 2024 08:14:24 +0100
Message-ID: <CA+V-a8u+ekfh2Vtv7QttfGxM_GU-nSnAkGYSNrPuqBO=AnWwuA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Update compat strings for SD/MMC nodes on RZ/{G2L
 (family), G3S, V2M} SoCs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Apr 23, 2024 at 7:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Apr 22, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > - RZ/G2UL and RZ/Five ("r9a07g043")
> > - RZ/G2L(C) ("r9a07g044")
> > - RZ/V2L ("r9a07g054")
> > - RZ/G3S ("r9a08g045")
> > - RZ/V2M ("r9a09g011")
> >
> > The SD/MMC Interface in the above listed SoCs is not identical to that =
of
> > R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
> > Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.
> > 'renesas,rzg2l-sdhi' is introduced as a generic compatible string for t=
he
> > above SoCs where fixed_addr_mode and hs400_disabled quirks will be appl=
ied.
>
> Thanks for your series!
>
> > Lad Prabhakar (6):
> >   dt-bindings: mmc: renesas,sdhi: Drop 'items' keyword
> >   dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
> >   mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S,
> >     and RZ/V2M SoCs
> >   arm64: dts: renesas: r9a09g011: Update fallback string for SDHI nodes
> >   arm64: dts: renesas: rzg2l-family: Update fallback string for SDHI
> >     nodes
> >   arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes
>
> The DTS patches have a hard dependency on the driver changes, right?
> So they cannot be applied in parallel.
>
Agreed, I sent them together to make the DT bot happy for the dtbs
checks. While sending a v2 Ill split them up.

Cheers,
Prabhakar


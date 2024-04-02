Return-Path: <linux-kernel+bounces-127590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF204894E11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9691C22328
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61E051C4A;
	Tue,  2 Apr 2024 08:57:58 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB51755A;
	Tue,  2 Apr 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048278; cv=none; b=i4aURAQLj3qVGPZJjZr8H9pvIdidQanLZeAHn2LbQHWp7QaWVrRNrF8EXgHAaNvxzah4tIPS8eGWEWl0sjPcHNF7Gq4mAw4wFN4nJwV+rGOAWJWNv4C3olHwyhHDtH0EvZ05ZKvPced3QDvZ+k+ALqURtdbaK4C2BU0nJHwEmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048278; c=relaxed/simple;
	bh=4mGyip3A2vxVFiIMykn/ckhzlQc9ZJ9gaeuHR/O/fZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FojOsJwOw199AYJAfM0mWLtZvS48/fuFc0vHDEnMJCMhz6V/Zsikvs3cNtZ7YGrEyocNSW4CQZkktfNxoDw1z7zKQES9HscMIcfk9CuDHGDEvvQcQKMFuBtqeih6saKkTfamswnOmdgghkLhQ5U4babX4uP5gMBFhvOHryPlLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4679269276.1;
        Tue, 02 Apr 2024 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048274; x=1712653074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVhWIofaeGGyMSfZkv2tkxmuwwN8jEo36pNRCgIT+Ys=;
        b=ObOhPGt8GfG/i3NRtnPqde2CXyJeWx/eyHo/TYmzGWK55NL7IL3wxC3vSIdr931noa
         iTI3iJ2pOzFeJ8pmDe5lkG5HxW+MZLzO0eUZBfEMcxAb8ZJkUclZ67bNGKaBqdk6clYK
         kSADdoBz/gvGm59kgjk/YA7O/TjUuPQ7UqDXal7T85Vmc8JloWH6m2ecHH0kw0D8w3Uf
         RTNo5CWasW1e8jiqXMTnmyaLtDUaHm8Zbc9tMx+KtYBvn6d1+UlM9zmWVHbJ3WN+VaR7
         S1vGRhMjXxvFUOhyyQ3V4cWSOksJ+gF5DGQictLbFL1p6ohhEkMGpzZHPFoBnhYin/OT
         v0EA==
X-Forwarded-Encrypted: i=1; AJvYcCXuB7rrlB3gNodQ1sVsvasHDeDXkbF0GacSCTyeAnLcsX5ISxTkQUto+Z7L2a4Xj1eBhmrKY83VQky5lhFruFqeILErlIZd
X-Gm-Message-State: AOJu0YxTJkb34vxKv0eJqYeHWTaMs0O5BgbSSDOaxYIBk7QA1WKDFs3a
	ZiAb0tvE0+lrSicGxOD/dYswDrEx60UjtVplW65kSi1hp9tDlhKzqO4Hpmd5fYE=
X-Google-Smtp-Source: AGHT+IEbgoiD9Uu1JaAjRsoE9MbIs5GzOHUG3wheIAsp2wKPthdyM/m5DBYTJyIRgXbL5j+Qy/GYuQ==
X-Received: by 2002:a5b:b91:0:b0:dd0:467:2e48 with SMTP id l17-20020a5b0b91000000b00dd004672e48mr9645824ybq.40.1712048274460;
        Tue, 02 Apr 2024 01:57:54 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id m3-20020a255803000000b00dcd25ce965esm2440779ybb.41.2024.04.02.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:57:54 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4679252276.1;
        Tue, 02 Apr 2024 01:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeMlcabTQARu1weLQD4DTgF5b8MLpZKDgJ3q/fCOE7Q+emTlIKiXpJ3ZBTOqSgcvQ7h//7fwm9ud6+X/FEaaCTIbvE9uAP
X-Received: by 2002:a25:5f0a:0:b0:dd9:20d6:fd2 with SMTP id
 t10-20020a255f0a000000b00dd920d60fd2mr8002219ybb.27.1712048273931; Tue, 02
 Apr 2024 01:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324233458.1352854-1-sashal@kernel.org> <20240324233458.1352854-111-sashal@kernel.org>
In-Reply-To: <20240324233458.1352854-111-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Apr 2024 10:57:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9yQsq15Lc_uqULw4LXAzrKwOZe+KCGLrCkiFG9kuVnw@mail.gmail.com>
Message-ID: <CAMuHMdW9yQsq15Lc_uqULw4LXAzrKwOZe+KCGLrCkiFG9kuVnw@mail.gmail.com>
Subject: Re: [PATCH 5.15 110/317] arm64: dts: renesas: r8a779a0: Update to
 R-Car Gen4 compatible values
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

Looks like I missed some things in my previous review...

On Mon, Mar 25, 2024 at 12:36=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> [ Upstream commit a1721bbbdb5c6687d157f8b8714bba837f6028ac ]

This is not the corresponding upstream commit for this commit
(a022251c2f950cd2 in v5.15.153).
It should be a1ca409cc050166a9e8ed183c1d4192f511cf6a2.
How could that happen? Interestingly, the backport in v6.1.83
(efab55e16c55c637) does have the correct upstream commit.

> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence update the compatible properties in various device nodes
> to include family-specific compatible values for R-Car Gen4 instead of
> R-Car Gen3:
>   - DMAC,
>   - (H)SCIF,
>   - I2C,
>   - IPMMU,
>   - WDT.

Likewise, the description should be:

    Despite the name, R-Car V3U is the first member of the R-Car Gen4
    family.  Hence update the compatible properties in various device nodes
    to include family-specific compatible values for R-Car Gen4 instead of
    R-Car Gen3:
      - EtherAVB,
      - MSIOF.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Likewise, bogus tag never given...

> Link: https://lore.kernel.org/r/73cea9d5e1a6639422c67e4df4285042e31c9fd5.=
1651497071.git.geert+renesas@glider.be

and a wrong link.

> Stable-dep-of: 0c51912331f8 ("arm64: dts: renesas: r8a779a0: Correct avb[=
01] reg sizes")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi

> @@ -935,7 +935,7 @@ scif4: serial@e6c40000 {
>
>                 msiof0: spi@e6e90000 {
>                         compatible =3D "renesas,msiof-r8a779a0",
> -                                    "renesas,rcar-gen3-msiof";
> +                                    "renesas,rcar-gen4-msiof";

The Renesas MSIOF driver in v5.15.153 does not handle
"renesas,rcar-gen4-msiof" yet.  Please backport commit ea9d001550abaf2f
("spi: sh-msiof: add generic Gen4 binding") in v6.1 to fix that.

>                         reg =3D <0 0xe6e90000 0 0x0064>;
>                         interrupts =3D <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks =3D <&cpg CPG_MOD 618>;

Thanks!

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


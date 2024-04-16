Return-Path: <linux-kernel+bounces-147031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681C8A6E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D74228442C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6A512AAE6;
	Tue, 16 Apr 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3Ozc4xE"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7E130E44
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278035; cv=none; b=iB1oKi3mmbLmjxkNO0DNpieLcA4UHO/ZzwBsF/f5tDVAsi7BzCkiFIO0o9TZH8LPNdMXqotGWhevnRAISUHb4ziaO4i5NYZGVtDP+yF69yJwmtNkSMcEorMGoWa8cCjKs0IZS3UJ8mUj5GDp9h6ItItdDBvnPFvy+3VJdGb1UNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278035; c=relaxed/simple;
	bh=fa/DxXobOZz7ufW7MMuUoP20SVnc4eYC7N+Ri1bZCxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht7gcjBYMDXa/BHKviykC7XPgEPhYKkcVHvCJDF46IPvIIMuVcrjk3tDaiANXJFX9Hj/N7LbHupoQKxNAjrFltxEZHm/zvvJvgg+WpwQQZpXI/qeTGu5q7FpaqLlakO9zdbSu82rVJnz48qsYMztsM3tlaTEkL8/2e+0JT69zhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O3Ozc4xE; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5acda019ae6so91731eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713278032; x=1713882832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFOshnHZVt7eovShCJGYyqtlZeqxkfrMezoV0SJga2Y=;
        b=O3Ozc4xEHpxgmskS84RsU9Q3nK8B3K2qGrNsfkwExS8BBeFMzik9aFry3RgPkEY5Ai
         PBGazbn6NvBuYyP1Wj2YOFhhZPrEesQtERJsT4jiy0fFb3QXszUBOcRoVTI3NPvQzzxS
         vZsjBPiDTsqhHVjxMBmxDDldDvJKEzlBG8ytezSQFWR40Ua27tWntCAjreH0a525WvOJ
         5UOo2GfHcdKxgTj9MDCZUAJAMBk5ZrBXTDZLF9u41Vik+KeUPXTSXtiFDVbdcNqcLO9B
         O0+ybgBN1I22hHF9ESMhO1u5vm71gj5MzGC0GDdbeCxQzeZ1McY2/N3eGo4rlWq1dWaS
         gwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278032; x=1713882832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFOshnHZVt7eovShCJGYyqtlZeqxkfrMezoV0SJga2Y=;
        b=EOZ2El5FXsmnLhbc3axO874yg4XuD0/N/7MRDSa/OwAgbnMgsAPhuu5/wJgE5XJjLZ
         eX/QDziCcTSkKhA4UjE+DAisxcuZuXCSfN/TXpX33Fwgb1RqqgavW2ysN7qNm3KUJqMX
         wUhtXAArlYOF0DZ3SHoeI+w3UZ4JT5RO/NUfgTahRWzhH4y9zP+QcYIFBa+yWQVIwdbk
         7sEhCdrNSd0Z5wyFmpz0tut7o8X5OOgp1tZodATlKVFkpeSsPvNNE72lO+N69mJHs0kL
         UPSJ7zaMlec5QtxNE7FBpkYn9pduOX/M4t7MjoNXDAIL3AFnccRd/7pdPkm6Saq8Xhmy
         XIVw==
X-Forwarded-Encrypted: i=1; AJvYcCX0q3BTicp8KchRR9J/Jm1y7OoGyXa5GRgU6bW8ejY2RP/hkqHxphOiCYlrf6C/n8ceW8kQnAAIc97zV9gPbY7UmcaSZeks3keTmFln
X-Gm-Message-State: AOJu0YwpJivk/QHdYxXPWhiOXRXis8MTSEYUaTERj92GkQrEcRlOlo9v
	18jU75LwpNY9OT9jbuKj1U+U7s9MHk96wcedSOMmSoqYjGzdlQ/5VHZnP/eJTwpekRPI/t1XW6U
	fdgLzYaaldY/sONx0i0q8Tn4kXnhyPtlZUV6upPcEnuGmKkIMKdY=
X-Google-Smtp-Source: AGHT+IEhzO0EWt8vnjX98wzr993MD/IhGn+sVx3cYjsgq4VouGSkc835TnH2i1adzvBUpJ7lxv2taDV6TczYCuSnil4=
X-Received: by 2002:a05:6820:408a:b0:5ac:5c3b:a9b7 with SMTP id
 fi10-20020a056820408a00b005ac5c3ba9b7mr12436630oob.0.1713278032316; Tue, 16
 Apr 2024 07:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122559.898930-1-peter.griffin@linaro.org>
 <20240404122559.898930-6-peter.griffin@linaro.org> <391a874522a4141b4bc7f0314a9e50d27142123a.camel@linaro.org>
 <CADrjBPqwLt6gzwMpkZvxp5sC-owdDYUN91F0-nV2NvEzek_v9g@mail.gmail.com> <fd7fe44ecbd99358bac583df3cc8192e250e758b.camel@linaro.org>
In-Reply-To: <fd7fe44ecbd99358bac583df3cc8192e250e758b.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 16 Apr 2024 15:33:40 +0100
Message-ID: <CADrjBPpJ2AEYZhg1s1jd00UqH=R+sGUzpWyW-aQs95_Rbm0=CQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
	linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Tue, 16 Apr 2024 at 13:21, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Hi Pete,
>
> On Tue, 2024-04-16 at 12:56 +0100, Peter Griffin wrote:
> > Hi Andr=C3=A9,
> >
> > Thanks for the review.
> >
> > On Fri, 5 Apr 2024 at 08:38, Andr=C3=A9 Draszik <andre.draszik@linaro.o=
rg> wrote:
> > >
> > > On Thu, 2024-04-04 at 13:25 +0100, Peter Griffin wrote:
> > > > Enable the cmu_hsi2 clock management unit. It feeds some of
> > > > the high speed interfaces such as PCIe and UFS.
> > > >
> > > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/ar=
m64/boot/dts/exynos/google/gs101.dtsi
> > > > index eddb6b326fde..38ac4fb1397e 100644
> > > > --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> > > > +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> > > > @@ -1253,6 +1253,18 @@ pinctrl_hsi1: pinctrl@11840000 {
> > > >                       interrupts =3D <GIC_SPI 471 IRQ_TYPE_LEVEL_HI=
GH 0>;
> > > >               };
> > > >
> > > > +             cmu_hsi2: clock-controller@14400000 {
> > > > +                     compatible =3D "google,gs101-cmu-hsi2";
> > > > +                     reg =3D <0x14400000 0x4000>;
> > > > +                     #clock-cells =3D <1>;
> > > > +                     clocks =3D <&ext_24_5m>,
> > > > +                              <&cmu_top CLK_DOUT_CMU_HSI2_BUS>,
> > > > +                              <&cmu_top CLK_DOUT_CMU_HSI2_PCIE>,
> > > > +                              <&cmu_top CLK_DOUT_CMU_HSI2_UFS_EMBD=
>,
> > > > +                              <&cmu_top CLK_DOUT_CMU_HSI2_MMC_CARD=
>;
> > > > +                     clock-names =3D "oscclk", "bus", "pcie", "ufs=
_embd", "mmc_card";
> > > > +             };
> > >
> > > This doesn't build because you didn't add the clock ids in the bindin=
g patch.
> >
> > These clock IDs are for cmu_top, not cmu_hsi2.
>
> Right. I replied to the wrong patch. Sorry for that. It is patch 7 that
> uses clock ids that are only added in patch 8. The clock ids from patch 8
> in include/dt-bindings/clock/google,gs101.h should be added in patch 1
> instead.

Ah I see, thanks for the clarification. I'll fix that in v2.

Thanks,

Pete


Return-Path: <linux-kernel+bounces-43123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D586840BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE2C1F2500E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29813156972;
	Mon, 29 Jan 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GetVDMWW"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4D15696E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546084; cv=none; b=fV1RmHRS8U4mt3EeATCWQWnCWAGIS94pBmHLCWVVcVQ680RMNMs7JUf2dIjNhR4WwMCRWxBb+yBcY89FPC1fg3CRnCr4FJfTaXwDhkCmklq84EFr6mVF0GdZqKPflPulILg0NBVIExjnMzDvCFiOFEg1f+cMv+ONa/KYjplmf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546084; c=relaxed/simple;
	bh=DZ1/Lt2XeZ8N7ZlRDPICU0NnPsl3dsLafwpn46RvGsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBguv/Tt/Msv24UCq3QHWKBDDdeNkIfhrpmQh4FYqlXC1PJScblETFQ0ikjGS9FePUeu/xX7FGrXAnTX+Hr+0a6wTLHBUtQFPT0LcfkDDQc5/G1xrZ+Xe7VqFzyN3ulHN7PvV6+ohatsz5kMKfL0eejkhlAYzbBThEuDsBcqe/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GetVDMWW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a27b97ea0so732360eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706546082; x=1707150882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIE7MVnsGMDWWJrtfQ2GIjZCJnpM7Y+nioDW77prozg=;
        b=GetVDMWWac3Myi7B/L6aXI85rR/cpKqDsVnCPV5rvsnxh6FMhAIMUbjjhR4/FXXv8K
         ePtEDYfVl8sCTkdyNP76OSPKNISYorDC7ZTx4mQdX+/aCpUfKTfMsHVnFY0pywPRABUG
         c3TERWTW+GpHndnNkYz7UdDkyKDByeIZAvf74wddrlidV4LXJCNp/6b3wXUB/5jWbusE
         e3PWPOJDnQIdvoi69SUzlMIt2niFtEA2RsYAa3kd6msIqY5QUmc65GFx4N6lnhSApM6N
         GR9Qoxbr/I9xox/d3BTBd1hJZkjK96mGsDE9KLpbuu/Bf4cvqRos4LwoN/Asm+p+PLsX
         aedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706546082; x=1707150882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIE7MVnsGMDWWJrtfQ2GIjZCJnpM7Y+nioDW77prozg=;
        b=j70gwKlErLRoykalCCIQBCP3mEy1pDPyT4hqxLnQYrBE1AqQJCRtRT6pk31ncPI/GU
         x18dThLtfIFIM4hxG6/V7QutNvDeOkyO8OiqunAb+tkVaEUeOaGEPg9uZEXo5ycSO+rM
         kKKRffh3VyVTDtmBNOh78KUTjKiN/KnAzykUgcfXkXQepW2sDnjSsPHJV/SlbFHx0fY2
         Iug2gjhcFpULJkU+Tp1qfIWPuXrHno/teeeCWurqpf7eRJzzIjurgCdZAbUlqYJqAdZR
         mAe47YCyJjAs9ii/mkVAMs4Ru1oeu0/TbcGdt0hio7hAK4xVypM1H+4ei0ugKfCBY2Yd
         tQkw==
X-Gm-Message-State: AOJu0Yx1yzXX01BHz4cIWrspWClkY50mcGMeAasYvIpePIK9cQWOo/gL
	yAkKiBDFqDUic/NQGh+SdF2xdlG5rRqkJEHPeoevFvmISVtJo78OQV937H66pmXKlCgWyb4qV6I
	5K/sjxvIUTSDHH1dhOq/nTMWKn+GtrsVXSWOTEw==
X-Google-Smtp-Source: AGHT+IFR/lXrslAYvsfTLAD59PjcNkwmdU+1xJqBt3z10O3k3Fc8WFZF6p/UfVn3P1FSriG+2FEnUFiu5ahNzgsRcG8=
X-Received: by 2002:a05:6358:90c:b0:178:652e:5e32 with SMTP id
 r12-20020a056358090c00b00178652e5e32mr5573155rwi.62.1706546081900; Mon, 29
 Jan 2024 08:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org>
 <20240127001926.495769-7-andre.draszik@linaro.org> <CAPLW+4m4G+-zFLGr6Bp-73-mERCofxDiD7F=2fd_Wq+18iTs9g@mail.gmail.com>
 <0d3236e90604e82a609d205c6fbb56fd882ecfbb.camel@linaro.org>
In-Reply-To: <0d3236e90604e82a609d205c6fbb56fd882ecfbb.camel@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 29 Jan 2024 10:34:30 -0600
Message-ID: <CAPLW+4nk7hStr=g4vt+iztOr6bqbtJFVDLZ37BfFh4POazgjJA@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: exynos: gs101: enable i2c bus 12 on gs101-oriole
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, alim.akhtar@samsung.com, 
	s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:40=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Hi Sam,
>
> On Fri, 2024-01-26 at 20:58 -0600, Sam Protsenko wrote:
> > On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.drasz=
ik@linaro.org> wrote:
> > >
> > > This bus has various USB-related devices attached to it.
> > >
> > > [...]
> > >
> > > +&hsi2c_12 {
> > > +       status =3D "okay";
> >
> > But there are no bus clients declared here? A bit of explanation about
> > how this bus is being currently used would be nice to have (in commit
> > message); e.g. maybe it's used in user space somehow, etc. Because
> > otherwise it doesn't have much sense to enable the bus with no users.
>
> As per the commit message, there are devices, but:
> * most or all don't have an upstream driver at this stage
> * it does make sense to enable the bus, as enabling it allows working on
>   the drivers for the devices that are attached to this bus
>

Then can you please add the corresponding TODO comment on top of the
code you added in this patch? And perhaps also describe which devices
you have on the bus in commit message.

> Cheers,
> Andre'
>


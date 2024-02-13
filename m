Return-Path: <linux-kernel+bounces-63601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60581853211
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1F9B20DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD62856465;
	Tue, 13 Feb 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="k5WiWRy0"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921555E70;
	Tue, 13 Feb 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831406; cv=none; b=lvzUmsCSakQPcJ8Kfx0JVgUSLhBn4Wa2H4aUuLWp0WMm2FI5pUiTKLSOZhIl89v0UfqYIzGcdj/movSq+/I35Zn3a44T+wGgmPO9NDOvTY2lRAKsB4IEo9A69krsoUMKciF4jecRZaSthFXqVC9z0VKeKESrgN9bLse3TJm3XlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831406; c=relaxed/simple;
	bh=mjTZ1TQrSFe8LDnKFWgz0FauMtLusLC+oCe1Q0r3aw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK3iSvwvkXTUglsA4/ml3g/8RUFWsVKxNy9T6q+URTBSwwptIhwNXkv+VXxvSngjXgNx5RxaYox5dgMJlqB6gOibrK03RHgKOfcDxL+jy1ZZM6V1p33UqNJl8HDEOobnHLLLAxz/WiigUDmf2xdU2tMRqtaFn3wPBnVHTEvXTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=k5WiWRy0; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 95EF4604A1;
	Tue, 13 Feb 2024 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707831403;
	bh=mjTZ1TQrSFe8LDnKFWgz0FauMtLusLC+oCe1Q0r3aw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5WiWRy0R3Rmurel7+6LyuchnxN5J1AmcbxoO41Fz1XjABun9aX4AMuiEIqRZBAkY
	 8hLurdeLOdnkHIWWFJU/e6VHi32JWD72uPRycUKo2bAUyy1DJ1lKMGNT3iYcmOXltJ
	 rAASaWjDZEHdMidSPIwTyBYxSqjFZFZ0Eie5kV9jIrnWXmJlXzgrXxpRHiHIK1BBzn
	 4fJa3Qp7iKk4P0w7U51f7R/R5c1nolRbRkbcWRD5HF1y5GrgadzEuz6ZNNPaiQCxsf
	 4Pl5/7UcAgFH3DzDu55fY4HV/2N2xizKXvL0DdHx9Wklf7VOfBLQhnlOs8HyiPLQQC
	 pGVpB5xvsORxQ==
Date: Tue, 13 Feb 2024 15:36:22 +0200
From: Tony Lindgren <tony@atomide.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, aford@beaconembedded.com,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: omap3: Migrate hsmmc driver to sdhci driver
Message-ID: <20240213133622.GJ52537@atomide.com>
References: <20240213124146.202391-1-aford173@gmail.com>
 <20240213125618.GG52537@atomide.com>
 <20240213130208.GI52537@atomide.com>
 <CAHCN7xLmTEk0439XTuRPG7SSdH=4YiMTmrSXmfTkpC2bo_kNGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLmTEk0439XTuRPG7SSdH=4YiMTmrSXmfTkpC2bo_kNGw@mail.gmail.com>

* Adam Ford <aford173@gmail.com> [240213 13:29]:
> On Tue, Feb 13, 2024 at 7:02 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Tony Lindgren <tony@atomide.com> [240213 12:56]:
> > > * Adam Ford <aford173@gmail.com> [240213 12:41]:
> > > > The sdhci driver has been around for several years, and it supports
> > > > the OMAP3 family.  Instead of using the older driver, let's finally
> > > > migrate to the newer one.
> > >
> > > I think we also should do these to avoid incomplete conversion:
> > >
> > > - ti,dual-volt property can be dropped
> > >
> > > - ti,non-removable should become non-removable
> 
> I'll do a more comprehensive search for these flags.  When I did my
> testing on the AM3517, I didn't notice these, but I see now that
> others might.  I'll do a multi-patch series to first address the
> multi-block, then  omap3-ldp.dts, then migrate the omap3.dtsi to the
> new driver while dropping the flags, and lastly update the individual
> boards accordingly.  I just have one question below.

OK sounds good to me :)

> > > - ti,omap3-pre-es3-hsmmc probably should not be needed with sdhci
> >
> > Hmm actually we may need to set SDHCI_QUIRK_NO_MULTIBLOCK for
> > compatible ti,omap3-pre-es3-hsmmc.
> 
> Should I update the driver and binding to add  ti,omap3-pre-es3-sdhci
> to set that flag, or should we create a boolean (maybe
> 'ti,sdhci-no-multiblock') to the device tree options for that driver?

Probably best to set up some sdhci generic property for it that then
sets SDHCI_QUIRK_NO_MULTIBLOCK.

Regards,

Tony


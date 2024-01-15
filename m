Return-Path: <linux-kernel+bounces-25835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895582D685
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA301C2132D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBACEAFB;
	Mon, 15 Jan 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bTLW0FQI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB60E568;
	Mon, 15 Jan 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705312715;
	bh=sucihfcuI+IzjO4bvrC1r8rLwyzhexN3edyT2mt02b4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bTLW0FQIF7NFjoo2zaXsdWlnkfgNUSisiP53Pk+n23M7RsSAk11W7A9k8Gy6FJ3GX
	 /sAhEGwZF8pdCJQy5T9SYJjobyO4wDJkAIKDixVccRx2xdRJyVunvz5KSZGZFwgPvW
	 F7vKsxbJXVmF3nS05AAcXaUrqSBT0IR0JaSdNZyMdWPO+3vDPXnCS83BjLp/8LteQ1
	 ALntvNSnNa9AsnHgqovNynjchS+06bnou0tz/uii/CCogo0dEKHO3y1mc/YJJUMd1+
	 PXfMZx/6eed0mHUPQdTSTuV/SwADh4YluYpZaWj0kwUoCU816QDQNwQXEJBUuVDAgK
	 VYRazVdn3Uf0A==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9799C37811CD;
	Mon, 15 Jan 2024 09:58:35 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 23BA59FB0C71; Mon, 15 Jan 2024 10:58:35 +0100 (CET)
Message-ID: <d55d9b13a93c49c86dba097bdf8a36ebdd90c837.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use the builtin
 mdio bus
From: Sjoerd Simons <sjoerd@collabora.com>
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@kernel.org>,
  kernel@collabora.com, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 15 Jan 2024 10:58:34 +0100
In-Reply-To: <20240112142537.axjy5risfe5lpnqc@quintet>
References: <20240112124505.2054212-1-sjoerd@collabora.com>
	 <20240112135000.b54xz3boeua7y2jf@music>
	 <2ce27ed917b9bd569ee4a7f87b3d9b78d07cecbd.camel@collabora.com>
	 <20240112142537.axjy5risfe5lpnqc@quintet>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-12 at 08:25 -0600, Nishanth Menon wrote:
> On 15:20-20240112, Sjoerd Simons wrote:
> > On Fri, 2024-01-12 at 07:50 -0600, Nishanth Menon wrote:
> > > On 13:44-20240112, Sjoerd Simons wrote:
> > > > The beagleplay dts was using a bit-bang gpio mdio bus as a
> > > > work-
> > > > around
> > > > for errata i2329. However since commit d04807b80691 ("net:
> > > > ethernet: ti:
> > > > davinci_mdio: Add workaround for errata i2329") the mdio driver
> > > > itself
> > > > already takes care of this errata for effected silicon, which
> > > > landed
> > > > well before the beagleplay dts. So i suspect the reason for the
> > > > workaround in upstream was simply due to copying the vendor
> > > > dts.
> > > >=20
> > > > Switch the dts to the ti,cpsw-mdio instead so it described the
> > > > actual
> > > > hardware and is consistent with other AM625 based boards
> > > >=20
> > > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > >=20
> > > > ---
> > >=20
> > > We have had issues with the ethernet integration previously (also
> > > why
> > > ethernet in u-boot is not yet functional on beagleplay[1]).
> > >=20
> > > https://openbeagle.org/beagleplay/beagleplay/-/issues/101
> > >=20
> > > we should probably do a 1000 boot nfs test or something to ensure
> > > this
> > > doesn't introduce regressions (I recollect mdio wasn't stable on
> > > beagleplay) and switching to bitbang driver stopped all
> > > complains.
> >=20
> > I can do a longer test with that over the weekend sure; For
> > reference
> > I'm seeing issues in u-boot as well on initial probe with these
> > changes, but i've not seen the same on the linux side.
> >=20
> > Do you remember with what kernel versions users saw the mdio
> > instabilities? I wonder if that was a version with the commit
> > mentioned
> > that includes the errata fix for the mdio driver.
> >=20
>=20
> we were on TI 5.10 kernel (the image that went into production) and
> it
> did have errata fix (I am not sure if it is similar or same as what
> finally went into upstream now).. I have started an automated
> multiple
> boot test on my end as well..
>=20
> The signature as I recollect was spurious link Down and Up logs
> (though the cable is not physically disconnected).. been a bit of
> time.. so my memory on exact signature might be vague.

For reference over the weekend our test infra did over 1600 boots with
an NFS root fs (see [0] for an example job) without a single boot
failure. So with the upstream kernel this seems pretty solid.


0: https://staging.lava.collabora.dev/scheduler/job/572063


--=20
Sjoerd Simons
Collabora Ltd.


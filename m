Return-Path: <linux-kernel+bounces-142166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9B38A2865
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17A2287DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDB94D9F0;
	Fri, 12 Apr 2024 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wBZqaEaU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AD94D5A5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907719; cv=none; b=l+PXI3uh8augpbB7cSmzUOftSiTbw8RFVUMhNOy+uUuEJdC5nC+Bs/DoHvgkzAFiFSl2XoBAeGk3NWOXgQ0MU0ulQjPlrpe8d/DEWkp3Os/uakH9cPUE/3LiE8bY22qNv18vjxMbDGPeobWtCyUh0Ib3ekcEA162En2WZderP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907719; c=relaxed/simple;
	bh=vRauUdjmEXaNb3aJ9t3FYkcm7oavR/ToqvPX7bbz4uw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9RJ2KfdUQNqJtmLDMXhtbY6tDD68DpmVcR2RgtiZ7OfXFFP4TFOSSXSx4WPxy/QipdaKkbdsjDP3IkSzHg9xBpz57kEpxId5wATV6iHLVjaXAKBPM6rZjCMS7sdiUIW3dul7jS9u3dOuP/cCKAo72oskvpOy5xtQYcwUvGjHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wBZqaEaU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712907716; x=1744443716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vRauUdjmEXaNb3aJ9t3FYkcm7oavR/ToqvPX7bbz4uw=;
  b=wBZqaEaUbJMnsVsy3++tOZQjlioV6g2rEU5pfuINxF22EjjdeBUsuRtG
   zU34U2SAXHDPE3uwJ/68ehPWmvMH0gdqSlkZZiz53nHvkZ3JQ7TqT9FYA
   94EIj89EbXmXV+eycRxCptPXxsbbzJHmBf5nL3EqafpNcFlb0VzNK1Aie
   hYin9gbXw/gEPfRIS+jc4cl+z92MhSt7VheciH0i3WgHVIvgZqU+JlDrv
   wVmjCe1ROzEphHZWT3LHOKdpdJXoHbCRepaTYh1ycbWo0UD7YzESUtHbS
   ij7iipFEPAeKm/ugB8yDppHdARm6yrHM+kurfhg1uY/zji5HDX1x2HvvF
   w==;
X-CSE-ConnectionGUID: E4sSRy7HTmSlkU9T5OWDeg==
X-CSE-MsgGUID: KFqPtSAzSbOvrsO8JAXZEw==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="20655805"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 00:41:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 00:41:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 00:41:37 -0700
Date: Fri, 12 Apr 2024 08:40:46 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: <conor@kernel.org>, <ajones@ventanamicro.com>, <anup@brainfault.org>,
	<aou@eecs.berkeley.edu>, <atishp@atishpatra.org>, <dqfext@gmail.com>,
	<guoren@kernel.org>, <heiko@sntech.de>, <inochiama@outlook.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <mark.rutland@arm.com>,
	<palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <will@kernel.org>
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID: <20240412-ivy-excitable-b740ff80c0d1@wendy>
References: <20240314-pep-announcer-2d7f10ff8b65@spud>
 <tencent_49E156C63C84E435E6F16509D6699339520A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YcE8yn2YH89m/k/Y"
Content-Disposition: inline
In-Reply-To: <tencent_49E156C63C84E435E6F16509D6699339520A@qq.com>

--YcE8yn2YH89m/k/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:27:28PM +0800, Yangyu Chen wrote:
> >> IMHO, it may be better to use a new DT property like "riscv,cpu-errata=
" or
> >> "<vendor>,cpu-errata". It can achieve almost everything like using pse=
udo
> >> isa. And the only cost I think is a small amount code to parse this.
> >=20
> > I suppose we could do that, but accounting for vendor specifics was one
> > of the goals for the property I only just added and that I am suggesting
> > to use here.
>=20
> I think there is a simpler way to do that. We use T-Head PMU by default
> for All T-Head CPUs (from mvendor id). Then, to test there is sscofpmf in
> the ISA string being probed by the kernel. If yes, then use scofpmf.
> Otherwise, use T-Head PMU.

I am strongly opposed to doing something like this. Firstly, making it
unconditional is a time-bomb as if T-Head ever ship something without
support then we'll be broken on that platform and have to return to
conditional behaviour. Secondly, we are taking agency away from
hypervisors etc that may not want a guest to use the PMU.

Cheers,
Conor.

--YcE8yn2YH89m/k/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhjlaAAKCRB4tDGHoIJi
0vdsAP9wMESP3pjIW4X/gjaZdmF9qSoS1iPGX2xdeWah9RffBAD+J5sImHAkYWje
UrhSTPIfH7O2esfADX2481ITlcF4LwY=
=eWjq
-----END PGP SIGNATURE-----

--YcE8yn2YH89m/k/Y--


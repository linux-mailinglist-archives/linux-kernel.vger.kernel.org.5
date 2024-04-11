Return-Path: <linux-kernel+bounces-140250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796118A102C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0A1F2A6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4C145323;
	Thu, 11 Apr 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qnR0lz6c"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9914600E;
	Thu, 11 Apr 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831456; cv=none; b=OzS74lzhynEwYX2fFhOLfiBPZnYAf7hChAv9BgH8IW4C9jGkTsmUgoSVMFUyR+Mq6ziIXuIoVYloaQ426KINh118OhSd0ogMFr7ClBq8IoxOxYgBDzwa2QWksk7KIcELedFwaKnRb3Ra/T4i8CvJJClFGqghn4+5DbUsnkpk+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831456; c=relaxed/simple;
	bh=wRis+jvLiwfcvURS3pt9dGRgB6cIii2qwGUUMZpjF6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiafAL3cVqGJHw2JOtIUSfapg0DeUqh1ORoA3++8TBTuU8A1Kfkm2v3kIGdaEkEibz2l/4poY7Iu5xS9yACRucF/0FcK0MuzkOAbYhsh9l2PYTyKVeaTe5BfbRUNYLcdsWr4uqj0gKmJUIgUE8BnF3Xc8/xceIgrzFqN9+owsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qnR0lz6c; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712831454; x=1744367454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wRis+jvLiwfcvURS3pt9dGRgB6cIii2qwGUUMZpjF6g=;
  b=qnR0lz6cQJ0dslC09SxcEDakX3mqJKiW5FwYmT2jjz6D0jYEDUMRjrfS
   n6SNolNt/C33IWIhEV96zynEUI6+7S+GFPAL+10wwydTzkewiSH9mxCuN
   8KlPS291FgLnVdFWpPu6NlX7CagiVXzS/K/RF+21ODo/onap/LiCanEkQ
   ZW2hEgb2cV4QdDa4gc7KCvd/e5J+q1o2kzaLif3DMVF0Z5TyaNIwMeMh8
   2eprMGyBnk1AcdbLDBslZRlB88br9BzXAVPhRm+66NFh2c7jxRd/l6gin
   WA4RZ1hz23pIF4qOLxRUobsFqTfpfpgS0o+YC5QhqYOBMWSTduzvmxkRG
   g==;
X-CSE-ConnectionGUID: 0of7XxqXRZujtHuEzDEvOw==
X-CSE-MsgGUID: 5pyW+N2xTlub9U791V2XWA==
X-IronPort-AV: E=Sophos;i="6.07,193,1708412400"; 
   d="asc'?scan'208";a="251346984"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:30:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 03:30:44 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Apr 2024 03:30:41 -0700
Date: Thu, 11 Apr 2024 11:29:51 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: Sia Jee Heng <jeeheng.sia@starfivetech.com>, <aou@eecs.berkeley.edu>,
	<conor@kernel.org>, <emil.renner.berthing@canonical.com>,
	<hal.feng@starfivetech.com>, <kernel@esmil.dk>,
	<krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
	<p.zabel@pengutronix.de>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
	<robh+dt@kernel.org>, <xingyu.wu@starfivetech.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<leyfoon.tan@starfivetech.com>
Subject: Re: [RFC v3 00/16] Basic clock and reset support for StarFive JH8100
 RISC-V SoC
Message-ID: <20240411-euphemism-ended-706f23d4a5ca@wendy>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
 <a83130157adf70f6f58f4d2e6b9d25db.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lisQmnqROX183EFJ"
Content-Disposition: inline
In-Reply-To: <a83130157adf70f6f58f4d2e6b9d25db.sboyd@kernel.org>

--lisQmnqROX183EFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:40:09AM -0700, Stephen Boyd wrote:
> Quoting Sia Jee Heng (2024-01-10 05:31:12)
> > This patch series enabled basic clock & reset support for StarFive
> > JH8100 SoC.
> >=20
> > This patch series depends on the Initial device tree support for
> > StarFive JH8100 SoC patch series which can be found at [1].
> >=20
> > As it is recommended to refrain from merging fundamental patches like
> > Device Tree, Clock & Reset, and PINCTRL tested on FPGA/Emulator, into t=
he
> > RISC-V Mainline, this patch series has been renamed to "RFC" patches. Y=
et,
> > thanks to the reviewers who have reviewed the patches at [2]. The chang=
es
> > are captured below.
>=20
> I don't think that's what should be happening. Instead, clk patches
> should be sent to clk maintainers, reset patches to reset maintainers,
> pinctrl patches to pinctrl maintainers, etc. The DTS can be sent later
> when it's no longer an FPGA/Emulator? Right now I'm ignoring this series
> because it's tagged as an RFC.

Since this comes back to something I said, what I didn't want to happen
was a bunch of pinctrl/clock/reset dt-binding headers that getting merged
(and therefore exported to other projects) and then have those change
later on when the chip was taped out. I don't really care if the drivers
themselves get merged. If the JH8100 is being taped out soon (or already
has been internally) and there's unlikely to be any changes, there's not
really a reason to block the binding headers any more.


--lisQmnqROX183EFJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhe7ngAKCRB4tDGHoIJi
0oN8AQDJCMKWJWymNQyrXdSAIbIQWmLkJXGtohqPQ27J6cA5rQD9FaZ3m59i+b/i
qcLnFDJe8daHP7ulI/YtwBRLJ+WBHAs=
=Bkv+
-----END PGP SIGNATURE-----

--lisQmnqROX183EFJ--


Return-Path: <linux-kernel+bounces-83009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F4868CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C35A1C22927
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA764137C42;
	Tue, 27 Feb 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fosvEXlF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF356458
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028567; cv=none; b=rvvPYHcglFYI+J0c871LfOLtMDSHQfIWEwd/WzMUqhEsF3ybtjialMo1Yhnwt1zQdxfx8fdNmf0GobuxxqasSlvSjZIa4mzvjrPRFw1PKO8iSFXB/IZNdR0ULKgGEcgmvkt87jPbUc1q2rk797MWGPE9+xB/XWeEmbLP56p8sFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028567; c=relaxed/simple;
	bh=hvfreTcuHcxoFQ0KJA1kYkXp7+c+Esbac0GIM/2ZX8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPERYWwGuEKrrNkNxJiz8AehBGK/nqi7s0Q0cVjktQ7+gZUSa/eqBuKz1l9Zk4W91k1+HkO8Pk8h6WVeKg3AL0XuSvgy41IT3ozF4aodMn9uRyGlhD5tC6DAipT23DmfJPcnSYnxD0bUNZIv2Evo6Iu323TEpS6ko0Qy/P0Osvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fosvEXlF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709028565; x=1740564565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hvfreTcuHcxoFQ0KJA1kYkXp7+c+Esbac0GIM/2ZX8c=;
  b=fosvEXlFRK/w4olJPqWPtAhw9b9rEgKIk82+70bleO2gjIESV2Y4VJJX
   2/JNNyp2Tw42zamVYM5XbxXhyMC8+41RE5lkcRPYjqxc4mFLY/knxaHAs
   loMG5iEI3to4j5wpP5wnD/EMrtOvs7M5f6+YOXNLnpZ/ngISDjuZX6IfY
   X6GWMiLNhxSYioWKWhgXRZPGcUkVFJEIxrWgtIx06G96Ff1FSVOuQqVPJ
   GiJOMH8KEArtCCv/2r08GXZpDPzZ3cCDWdwBGOkhM/mql/qGlgzE/p0f8
   rR4AvFUW7/1R6myoVmmAD6/Rt1jyKcbq+oV0+YOoKuNzYFfYtooI5I5aq
   g==;
X-CSE-ConnectionGUID: SBLw0WqLRt+rblbhvO8YGw==
X-CSE-MsgGUID: z7auoLxmSJeEZY5hePRAFg==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="184152299"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 03:09:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:09:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 03:09:00 -0700
Date: Tue, 27 Feb 2024 10:08:18 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Greentime Hu <greentime.hu@sifive.com>,
	<linux-riscv@lists.infradead.org>, Green Wan <green.wan@sifive.com>, Albert
 Ou <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update SiFive driver maintainers
Message-ID: <20240227-serrated-oyster-552459d0fd5b@wendy>
References: <20240215234941.1663791-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SBC0JjNyRNyQOcrm"
Content-Disposition: inline
In-Reply-To: <20240215234941.1663791-1-samuel.holland@sifive.com>

--SBC0JjNyRNyQOcrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Palmer,

On Thu, Feb 15, 2024 at 03:49:11PM -0800, Samuel Holland wrote:
> Add myself as a maintainer for the various SiFive drivers, since I have
> been performing cleanup activity on these drivers and reviewing patches
> to them for a while now. Remove Palmer as a maintainer, as he is focused
> on overall RISC-V architecture support.
>=20
> Collapse some duplicate entries into the main SiFive drivers entry:
>  - Conor is already maintainer of standalone cache drivers as a whole,
>    and these files are also covered by the "sifive" file name regex.
>  - Paul's git tree has not been updated since 2018, and all file names
>    matching the "fu540" pattern also match the "sifive" pattern.
>  - Green has not been active on the LKML for a couple of years.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Can you take this please?

Thanks,
Conor.

--SBC0JjNyRNyQOcrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd20kQAKCRB4tDGHoIJi
0rJpAQDmB+X3sH1dX2qB3MVFD0cMSzwbYZyArsjbCPMjRzjZ/gEAh6EQ75gAuT1R
TSHM+vKfGb5UkWJtMQTn+gzQUlFHIQ8=
=dCM9
-----END PGP SIGNATURE-----

--SBC0JjNyRNyQOcrm--


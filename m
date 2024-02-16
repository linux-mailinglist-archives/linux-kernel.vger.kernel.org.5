Return-Path: <linux-kernel+bounces-68343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFDD857901
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2371C2246C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643F1CD23;
	Fri, 16 Feb 2024 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kzsImYzU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119401CA9E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076300; cv=none; b=Wl+qUG9nyFhElqkypb4LvWOOqdE6cneve4Uwa7jWIhgOrYIYHPOZZJu3njSnqVArK/oOh6i0eJcKPWhzkU1Bo9xUIPP7GiFfi+Vw2KsyXY18SWXSnsy2f7xdb95E/vSdaRDlAGRKkXkW4ZIOLSh0dmqEYa2f0Ym1QmFdhzs7gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076300; c=relaxed/simple;
	bh=YztRVAMrWM4QMn+3khyc9Qi6zHLT7tuCgUnaeHsjBWA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXv9cAWqDG+0CejLidkg/JdiBwAwdwxLJ1ct50IuRDVUsEZKcebpqSo5Qc0x9M0Z6d00L/MtnSojDMINuTBE6Pjq9gy1eRJrmbiOTTPGwN7GFzHXdw4lXTUG1u3hi3yodUhwNIIt5kENa1D0zkVLy8IxKO3DdtYEfpXxA7oxB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kzsImYzU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708076299; x=1739612299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YztRVAMrWM4QMn+3khyc9Qi6zHLT7tuCgUnaeHsjBWA=;
  b=kzsImYzUbBZoYiwXC+9uy0pp1ZuZk/d9GIdSdbtUNdSQNZd0fT3WXEej
   0dIftEaEeDM02t4G2Bnk6UWEFNvdiVziMFEUic4HLK0hFuuiO9y7mhMAY
   tesxCYOF43VtetgGl9F6X03EbmFVREzaBS0NrUC/IMlrSdfFfNaZa6kcH
   l8Vqy0cBE2pPNOSB1HqKiJDe46EZbk9nNa02pVo4SNfIaDqRQEiGrAcg3
   0unVnNhGKiYcwQCeIslJtxvyIutR6GIbs+JjT1EEymDw3LG5tYcFeKFBp
   DkNnjOOct8UWQMEivyxrxrxlnnl4B5TX2O0d+nWAY25jgl1w+R0RGEVLr
   Q==;
X-CSE-ConnectionGUID: Z3dkU+2hRsuPUT2NteERjg==
X-CSE-MsgGUID: 2bUyP5NgQWuU9FhmhwOPQA==
X-IronPort-AV: E=Sophos;i="6.06,164,1705388400"; 
   d="asc'?scan'208";a="16346714"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2024 02:38:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 02:38:07 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 02:38:05 -0700
Date: Fri, 16 Feb 2024 09:37:24 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Greentime Hu <greentime.hu@sifive.com>,
	<linux-riscv@lists.infradead.org>, Green Wan <green.wan@sifive.com>, Albert
 Ou <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update SiFive driver maintainers
Message-ID: <20240216-exit-pointer-43dc427bf4df@wendy>
References: <20240215234941.1663791-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mYkzGwyutxXcaTiN"
Content-Disposition: inline
In-Reply-To: <20240215234941.1663791-1-samuel.holland@sifive.com>

--mYkzGwyutxXcaTiN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 03:49:11PM -0800, Samuel Holland wrote:
> Add myself as a maintainer for the various SiFive drivers, since I have
> been performing cleanup activity on these drivers and reviewing patches
> to them for a while now. Remove Palmer as a maintainer, as he is focused
> on overall RISC-V architecture support.
>=20
> Collapse some duplicate entries into the main SiFive drivers entry:
>  - Conor is already maintainer of standalone cache drivers as a whole,
>    and these files are also covered by the "sifive" file name regex.

And the binding isn't affected since I get all binding patches anyway.

>  - Paul's git tree has not been updated since 2018, and all file names
>    matching the "fu540" pattern also match the "sifive" pattern.
>  - Green has not been active on the LKML for a couple of years.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for doing this :)

Cheers,
Conor.

--mYkzGwyutxXcaTiN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc8s1AAKCRB4tDGHoIJi
0s1nAQCTZODj0RTvd44DM0Y7k+8LPG3mmMncetbaGsTQ8IvxWwEAqbfS75MldlXS
KFexxnGBuPQaptsVig9ZWd2+H8Ei0AM=
=Zecr
-----END PGP SIGNATURE-----

--mYkzGwyutxXcaTiN--


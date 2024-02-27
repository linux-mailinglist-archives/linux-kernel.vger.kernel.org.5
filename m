Return-Path: <linux-kernel+bounces-83205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E117F869034
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9736E1F21D56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9A145330;
	Tue, 27 Feb 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DboDdjeu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25F13B2A5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036080; cv=none; b=ot4J4nW6bPQRu0/pnx9S/VkxSXx4duRT1nVpt4ZYV7D2Dyy0RxijHRlopDBjsHGFqzvKFFIJ70ACyIu7+RG3J721Dxu0lmXW3sBFNUe+B3AZRQDgfRmP+TohTKYh0JW2OaCPaqn+I2r5uaVMPLtPzSvdgQeDtmYJrR6NDxt17Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036080; c=relaxed/simple;
	bh=fSrXRCpTEpQRkMIDKSjqJaiu1Qp1gr1z2GJ9vNCAs4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpUrYid9/7cmxr5crch56ln9KklkJlqgAhd7rFhuSz3B2xWq/NgXQfr/K9LIw/QyqwTulBB4iM/5vmRIGp3TSDovtawW4rdZgXyzT/1mE0dYviOeAlpfLX1khs3bkmYLzC+9cjdYuPNi7VNZtxbrfjFPdcc9amgR316KcFfx9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DboDdjeu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709036078; x=1740572078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fSrXRCpTEpQRkMIDKSjqJaiu1Qp1gr1z2GJ9vNCAs4U=;
  b=DboDdjeuC6RiJ6vEbzJGatvgfWYtudz2SgZ64FtuvTPArPUYRl02oE2k
   vs5ug0WTNtWHhCJMqLfNMBOyBvJyc8IbLJR+J7rcvbBTquQvKQmKHgEGv
   mz7R2v8Wg161vvjm2T/4xv//vESICe2FV9SooOxcrDmRatiHfEMVkoXye
   W3uUl7is+J//exSdhUKP7QWHjgyfi7p7FoAYQDcoyk8ro1bOyn5r8MGFa
   eKyF6y0DOzE7ztdQ0ZxnX++FPzCJH74s+4DmhUGbf1KmZ8Z5IWvFB52Pg
   PiIWlPnptLoksuSBb0vwncHIi5EnQ+IQhD8GvbzNiYGcjWL1PBkHUj/Vg
   w==;
X-CSE-ConnectionGUID: EC6mGCUkTgeb01x5BvwdWA==
X-CSE-MsgGUID: AaXkTeu7TIif8MCz6FcBNA==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="16882459"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 05:14:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 05:14:28 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 05:14:28 -0700
Date: Tue, 27 Feb 2024 12:13:45 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] riscv: 64-bit NOMMU fixes and enhancements
Message-ID: <20240227-footage-porridge-949a43ee8ecb@wendy>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CO1sGIa2Mft349oV"
Content-Disposition: inline
In-Reply-To: <20240227003630.3634533-1-samuel.holland@sifive.com>

--CO1sGIa2Mft349oV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 04:34:45PM -0800, Samuel Holland wrote:
> This series aims to improve support for NOMMU, specifically by making it
> easier to test NOMMU kernels in QEMU and on various widely-available
> hardware (errata permitting). After all, everything supports Svbare...
>=20
> After applying this series, a NOMMU kernel based on defconfig (changing
> only the three options below*) boots to userspace on QEMU when passed as
> -kernel.
>=20
>   # CONFIG_RISCV_M_MODE is not set
>   # CONFIG_MMU is not set
>   CONFIG_NONPORTABLE=3Dy
>=20
> *if you are using LLD, you must also disable BPF_SYSCALL and KALLSYMS,
> because LLD bails on out-of-range references to undefined weak symbols.

That's not new to these patches though, right? IIRC that's an existing
issue.

Cheers,
Conor.

>=20
>=20
> Samuel Holland (4):
>   riscv: Fix TASK_SIZE on 64-bit NOMMU
>   riscv: Fix loading 64-bit NOMMU kernels past the start of RAM
>   riscv: Remove MMU dependency from Zbb and Zicboz
>   riscv: Allow NOMMU kernels to run in S-mode
>=20
>  arch/riscv/Kconfig               | 17 ++++++++++-------
>  arch/riscv/include/asm/page.h    |  2 +-
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  arch/riscv/mm/init.c             |  2 +-
>  4 files changed, 13 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--CO1sGIa2Mft349oV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3R+QAKCRB4tDGHoIJi
0n0qAP4husn7Rq5mjuLx/yxtyV7nKMyhO3tT1JDLr71TEIcUmAD/a+xbAGs6K7dA
FvSbJPEadfhLnQI2kFIU0j/68ieDFwM=
=prhB
-----END PGP SIGNATURE-----

--CO1sGIa2Mft349oV--


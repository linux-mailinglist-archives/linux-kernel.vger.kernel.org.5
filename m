Return-Path: <linux-kernel+bounces-93968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFD68737A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5C0286CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E012D743;
	Wed,  6 Mar 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B1Unxr3x"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3885D12D1FC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731298; cv=none; b=uPLPAjeorzVkfBvFXpxFgDnRsILXEAONwHDY+4F9G9JaqEWbId5feIlfMacR5sEVOL9LY1JRVkd0HJoBTHoGdOyMLP7uffZh+B78gGjLS1QHjajcv+A/uoZ/c+orP3U503v8Tbvh85F5TyHFS3pVSZu7Qz0FslpXwQLq0Iu4oiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731298; c=relaxed/simple;
	bh=x6saRHVg0VfK1dnvwUWzELfx+mRt+YMbrULENEEZOVE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+x9hmqmza3MLpsdSBgzFur9pnDuPiuLeKUqHFNXIOnswQpckolZ+/EjDBkX/uFSiJkH0/w3SjWCyBNl3TXIqitzySagFxy+LMFcfs8FYM9nKg8TmqyXqwR47Ho2R4bNFk93kMr8dMZKauCL+3CRWWTBrQcw6vl2+dt3wViNE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B1Unxr3x; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709731296; x=1741267296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x6saRHVg0VfK1dnvwUWzELfx+mRt+YMbrULENEEZOVE=;
  b=B1Unxr3xXjDV5DhfWfZnKy6D7Qju88Q/LT77u6dVZuaCNwgAivVA+4tg
   O682kneFWX9vXFzKLDDWkRshR26O4UNtLQ0yqZJZRGC46/nRfz/hHNCW9
   YknOSXYSGTh8FBCyHGoDK0lRYEktqHzY19jKnEiJmh9gCVCIdyBjp3WHa
   zOXsXVFSTinqG5x1oJxBd33mYLU42qUuJeb5QYPN7QP0V+y5HEaCIrSZU
   ASJ5aXdcWmVIS3U1HRYSr6sKfXRoEFdVVaZqTFQ9WGG71uAZ6d93uB/jL
   PN9O8Es2s4XBWJ8lbhD9BHRIiaLwFftqQlM7qUyFpbMvQqdCTXENrfi8O
   A==;
X-CSE-ConnectionGUID: MbkuSMWuTa2dMHhEfXhTsQ==
X-CSE-MsgGUID: 7mh+FgpZTSy/sDRKCR9T0A==
X-IronPort-AV: E=Sophos;i="6.06,208,1705388400"; 
   d="asc'?scan'208";a="184556607"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 06:21:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 06:20:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 6 Mar 2024 06:20:21 -0700
Date: Wed, 6 Mar 2024 13:19:37 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang
	<jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Eric Biggers
	<ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr
	<lohr85@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] riscv: Decouple emulated unaligned accesses from
 access speed
Message-ID: <20240306-tactless-decathlon-b0df16517b1b@wendy>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
 <20240301-disable_misaligned_probe_config-v6-3-612ebd69f430@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0+iLppiDSyfXGqPN"
Content-Disposition: inline
In-Reply-To: <20240301-disable_misaligned_probe_config-v6-3-612ebd69f430@rivosinc.com>

--0+iLppiDSyfXGqPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 05:45:34PM -0800, Charlie Jenkins wrote:

> -void unaligned_emulation_finish(void)
> +bool check_unaligned_access_emulated_all_cpus(void)
>  {
>  	int cpu;
> =20
> -	/*
> -	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
> -	 * accesses emulated since tasks requesting such control can run on any
> -	 * CPU.
> -	 */

Why was this comment removed? This patch doesn't change the situations
in which PR_UNALIGN is allowed, right?

> -	for_each_online_cpu(cpu) {
> -		if (per_cpu(misaligned_access_speed, cpu) !=3D
> -					RISCV_HWPROBE_MISALIGNED_EMULATED) {
> -			return;
> -		}
> -	}
> +	for_each_online_cpu(cpu)
> +		if (check_unaligned_access_emulated(cpu))
> +			return false;
> +
>  	unaligned_ctl =3D true;
> +	return true;
>  }


--0+iLppiDSyfXGqPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZehtaQAKCRB4tDGHoIJi
0nqQAP9qDs9BXRRIcemNZkKQPjQ7O1zObSc+rYvFSFXl5n2dCgD+LIqa+Incg/HH
X0NiaSTSjXLgY8Y3hcOJ/2aMZ1V8dQA=
=VVCG
-----END PGP SIGNATURE-----

--0+iLppiDSyfXGqPN--


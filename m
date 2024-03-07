Return-Path: <linux-kernel+bounces-95129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74149874989
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D6028247B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0065633E6;
	Thu,  7 Mar 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ni1iXQ5g"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F956447
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799943; cv=none; b=BOmbAWV/boFXOXbDfnDfGqRWIE69Pzp+N7WRff4rJhO80BwbyOtJcDeXGRbC2hWM+P4yT+e2Nw6AOGZ1DY8tinRWn8ajYCx3SzoOGjqhR/0TYJc5abGS4yAQt46yKVzE6TScjUxte9vzkmGeZzCAsuez/JhS35TkuLQ2RpBGPmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799943; c=relaxed/simple;
	bh=enCse7dbdQXNzTOxJ1nbIU4FpLfhxhz5LWnaFVXaicE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khHQ4bBJDXLqtWbjkVm+RqacFCuM+YzEjY28/4uu89fvlN8SvF+ZvuU4b5k7n5ggH9XzDQHw6vHDEa+92Zb4wtkxWVU3nfQxByedSE73yXpQfWDy9ac1WMdxiJjKp8AKX4UBbwuhJXiFD7T9MgJR58crHJq7774J2wkddMdJ9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ni1iXQ5g; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709799941; x=1741335941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=enCse7dbdQXNzTOxJ1nbIU4FpLfhxhz5LWnaFVXaicE=;
  b=Ni1iXQ5guegWf+m/xnRo98cHaT1chKVhLq/QxCpM55G5mc3329b3E5uw
   QKYKX2Q/kFozDXsmxTKZgK0tp3U4hFvGYlFt91iPCZm3VlQ2ZcJoYb+/6
   SCHCX7Cp+1ZWXISfuD2kiczYigJ/SGsz1k3fIsSnjQZlCxhwRnQUiqH7R
   FAR+QbEbh5ZuXuDDYE1Eh5SgijIZaKYP2roJForlbujIqaSUVDXBYmsPA
   r7ExOxgBxvNlbyhYqBngsMagB7SOTD+hQmEh+9MOWGXjijz4TXRXyPzja
   lx9+NW6v+mnUd95YjxuIyZOeMnUULxG9cg7yymM2guqTs7GTnYe9bIiNP
   g==;
X-CSE-ConnectionGUID: kAZEeyzJTe2x8LD+/3TGaw==
X-CSE-MsgGUID: sdgDN0UeSoumQpAx3OOG4Q==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="asc'?scan'208";a="18986441"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 01:25:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 01:25:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Mar 2024 01:25:21 -0700
Date: Thu, 7 Mar 2024 08:24:37 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang
	<jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Eric Biggers
	<ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr
	<lohr85@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] riscv: Set unaligned access speed at compile time
Message-ID: <20240307-defraud-antonym-407fc29261d1@wendy>
References: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
 <20240306-disable_misaligned_probe_config-v7-4-6c90419e7a96@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iUWIDEsf5AaiYg6s"
Content-Disposition: inline
In-Reply-To: <20240306-disable_misaligned_probe_config-v7-4-6c90419e7a96@rivosinc.com>

--iUWIDEsf5AaiYg6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2024 at 12:00:04PM -0800, Charlie Jenkins wrote:
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS))
> +		if (unaligned_ctl_available())
> +			return RISCV_HWPROBE_MISALIGNED_EMULATED;
> +		else
> +			return RISCV_HWPROBE_MISALIGNED_SLOW;
> +	else if (IS_ENABLED(CONFIG_RISCV_SLOW_UNALIGNED_ACCESS))
> +		return RISCV_HWPROBE_MISALIGNED_SLOW;
> +	else if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
> +		return RISCV_HWPROBE_MISALIGNED_FAST;
> +}
> +#endif

Isn't this just
static u64 hwprobe_misaligned(const struct cpumask *cpus)
{
	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
		return RISCV_HWPROBE_MISALIGNED_FAST;

	if (IS_ENABLED(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS) && unaligned_ctl_available())
		return RISCV_HWPROBE_MISALIGNED_EMULATED;

	return RISCV_HWPROBE_MISALIGNED_SLOW;

}
?
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

The kconfig stuff looks ~good to me, I wanted to make one comment about
the wording of a sentence I wrote being pretty meh, but I think it's
time to let go there...


Cheers,
Conor.

--iUWIDEsf5AaiYg6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZel5xQAKCRB4tDGHoIJi
0pPlAPwKe8nxyNXBCUxArQriqoMFYmNKeb0YDkPKt4MH66EXlAD7BfOP6iDRPpa/
qDkpTdHvENUdrS09wUiH9vE93smHeww=
=xXdV
-----END PGP SIGNATURE-----

--iUWIDEsf5AaiYg6s--


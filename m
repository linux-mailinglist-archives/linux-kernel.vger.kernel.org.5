Return-Path: <linux-kernel+bounces-48220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74D8458B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C742928BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D745336A;
	Thu,  1 Feb 2024 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UX5pg4vN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25253366
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793548; cv=none; b=ELvFnQgGdKv9u1yXUDmum1lv6IfNDgl2d7LYBU9DydspAX1AkAr7I18mX0iHRMyAUp+McHNlA7fmx4P1HmnkfO5mGEEFWD6FxnMsqW3Xv6N7jMKpivlPxKIsp62NXw5c+djq6usYYdo8ovWwaf2fMVs+HBCCqCbjQqnavauo7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793548; c=relaxed/simple;
	bh=Jn+xPN0GPUw3/463SkJJ8PbiXcmQAnj17oz7Lj+qSyk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrmSnQrlfvUSBou9H8u8K1NEZHIg+e07lX8Txy6TcWifAWgoWAYw7l7yNtb+y7UM5uOefbxhwWaDEKO2csM9iZHSszLHV286cxmRVehWEbfaKneJo38iz7QC/jOMgk+XD14YVYeKcbMuaPqwwVV1YBuAIloQt0p0DHjohC/iLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UX5pg4vN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706793546; x=1738329546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jn+xPN0GPUw3/463SkJJ8PbiXcmQAnj17oz7Lj+qSyk=;
  b=UX5pg4vNgydFoahyN4mJ3b/HYelbz211ggrbBsA/TvmVahgNsKB5lhG7
   dVDaUzpQRDTXUJ7yL/IJzWdZq5QFwP1leCPyWN0biJfjoc393cA6LeVJI
   u3YTjnn+ezWO95mauVrqanGXPQs5LLjoFGJy5Oljyoqy5b7gcMVKtrgY2
   zmoHREVfeA7jbOqBHMt61HHZGik2u+vnLCK/Rm8qMn+dIn9iuis3OwOki
   rdu81cGD03B2BPsDzsid9DyzHVZM5sPDqljdSCPHu3aANkPK+i+oREqbl
   5w3QHLObDtmHghzmcye4s0nVA3rt3FNjvMZzYmIbh4wbQlLH8nUz+jywF
   w==;
X-CSE-ConnectionGUID: uEqx+vOgQfai2o2FgVbElQ==
X-CSE-MsgGUID: IPF+MlIWSpqLnzUSxccXDg==
X-IronPort-AV: E=Sophos;i="6.05,234,1701154800"; 
   d="asc'?scan'208";a="16123786"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 06:19:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:18:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 1 Feb 2024 06:18:33 -0700
Date: Thu, 1 Feb 2024 13:17:54 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Ghiti <alex@ghiti.fr>
CC: Zong Li <zong.li@sifive.com>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
Message-ID: <20240201-glacier-sheep-049045564f7d@wendy>
References: <20231205085959.32177-1-zong.li@sifive.com>
 <139cdbd6-73d9-4452-94ce-825689b7c0c8@ghiti.fr>
 <CANXhq0oA7LsKev+5gZCtNzCJ64RVOyimM1yQnY0kqs22VE6S4A@mail.gmail.com>
 <4bf64df4-43a4-4207-b7d5-ff07adb98193@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HYeRZY6h66DPo2M8"
Content-Disposition: inline
In-Reply-To: <4bf64df4-43a4-4207-b7d5-ff07adb98193@ghiti.fr>

--HYeRZY6h66DPo2M8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 11:07:48AM +0100, Alexandre Ghiti wrote:

> 5cb0080f1bfd was introduced in v5.11, so that will make the backport poss=
ible up to 5.15, I guess that's ok, nobody will ever use a riscv kernel tha=
t old (?).
>=20
> So I'd add the Fixes tag I proposed above, and let the backport fail for =
< 5.15. @Conor any opinion?

The stable kernels are 5.10 and 5.15, so there's no kernels that matter
which have the bad commit and are < 5.15.




--HYeRZY6h66DPo2M8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbuaAgAKCRB4tDGHoIJi
0qfLAP4koWDuVPDcVXYFtHVrzdhF1eAsAsPdz/1TZGZe7aSkrAD9EOXqNsc82ZRJ
95s2w9tShScq7Dv46eJxemyXBKHqywE=
=BEJH
-----END PGP SIGNATURE-----

--HYeRZY6h66DPo2M8--


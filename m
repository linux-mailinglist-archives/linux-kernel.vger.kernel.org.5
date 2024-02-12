Return-Path: <linux-kernel+bounces-61181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EAB850E73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EECD28508D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238B17583;
	Mon, 12 Feb 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DBTaBUVw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7A14F75
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724847; cv=none; b=rjz92Uks/KVA3EssiN8581Ix+gqhS3E7CszfuZOd8oqU7zATTfvWFajVb4fE//KObTT5l41wXbMv18E3catzTMV5907so8QSFuUtc4hNdRoxW2BLvV9z4asp0Tcl9KbP+uOW0tx3GXrTgFJmecDfasxm8rt8LhEorRkS7T/4Foo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724847; c=relaxed/simple;
	bh=7hH3HoelP79fA4EAxydxPVb1FLMbOKAgQjwJa4s2m3A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk8TSDTyWPqiawbhTyLqcNfzCUsijSQL/LnJBGIl2jlQo+yK5g/vq25u7jf/5kjIXRtLtVUh+gQkoMLp+B3ty3lB66gGBhY1F4FGFEtfnDa8bN+V1Gd4yYIyBxT+L+SmHhm9uqLNaEwa7lemO8KtxFFxXBqLpBuFAbPEc/yrkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DBTaBUVw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707724844; x=1739260844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7hH3HoelP79fA4EAxydxPVb1FLMbOKAgQjwJa4s2m3A=;
  b=DBTaBUVwG0uk4ZlMgYPR5dtHOWDMkL+Y6KfxZWVQCRswPs3l1fT27ZX7
   F7Pw7XPD2++J+z+/23JZ16qaVZM1Q9I1ALavtoNNK3mdh+IckhZamBAPq
   qlUUJvrCIzMbQppA5kse3NuRzm20Nih4wlhY4JD3vo8/0sGeo1eSPb+nG
   9b/xDk8e0habK1lkLB7KRpgHvkClXsVrQC9VBybkYPlwQIyy8b2e+6nui
   tJN64nm87X2MnPmL8majNWERg0/RSGbVVqEJ0G8xSQmKdnipJcVdL5UX9
   tIFAPPcFB4icfpKQrzHTHfKIMswt03w30dgxfTQeKrqxvvoIQdFAPGZTL
   Q==;
X-CSE-ConnectionGUID: j3L9bk1uS4yWcLk3T9PAMA==
X-CSE-MsgGUID: RWmzpzmsTxGGlYSqjesXwQ==
X-IronPort-AV: E=Sophos;i="6.05,262,1701154800"; 
   d="asc'?scan'208";a="17510501"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 01:00:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 01:00:17 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 12 Feb 2024 01:00:16 -0700
Date: Mon, 12 Feb 2024 07:59:36 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@kernel.org>
Subject: Re: [PATCH -fixes 2/2] riscv: Save/restore envcfg CSR during CPU
 suspend
Message-ID: <20240212-sneezing-lifter-d7d390f764e1@wendy>
References: <20240212022642.1968739-1-samuel.holland@sifive.com>
 <20240212022642.1968739-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L/yK4/dJDBsDnoeq"
Content-Disposition: inline
In-Reply-To: <20240212022642.1968739-2-samuel.holland@sifive.com>

--L/yK4/dJDBsDnoeq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 06:26:15PM -0800, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
>=20
> Because the [ms]envcfg CSR is part of the base RISC-V privileged ISA
> specification, it cannot be detected from the ISA string. However, most
> existing hardware is too old to implement this CSR. As a result, it must
> be probed at runtime.
>=20
> Extend the logic for the Zicsr ISA extension to probe for the presence
> of specific CSRs. Since the CSR number is encoded as an immediate value
> within the csrr instruction, a switch case is necessary for any CSR that
> must be probed this way. Use the exception table to handle the illegal
> instruction exception raised when the CSR is not implemented.
>=20
> Cc: stable@kernel.org
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

On nommu:

  /build/tmp.RcQwFfgWA4/arch/riscv/kernel/cpufeature.c:967:21: error: expec=
ted ':' or ')' before '_ASM_EXTABLE'
  /build/tmp.RcQwFfgWA4/arch/riscv/kernel/cpufeature.c:967:34: error: inval=
id suffix "b" on integer constant
  /build/tmp.RcQwFfgWA4/arch/riscv/kernel/cpufeature.c:967:38: error: inval=
id suffix "b" on integer constant

https://patchwork.kernel.org/project/linux-riscv/patch/20240212022642.19687=
39-2-samuel.holland@sifive.com/

Cheers,
Conor.

--L/yK4/dJDBsDnoeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcnP2QAKCRB4tDGHoIJi
0hjAAQCt4j31pCTvptmmA76wZTddnhiSMe01Y8CWQitdGCpgAQEA7HxAbB32HLnX
2BntqCYs/siyDbQdgmD9km29tULQKAQ=
=22Gm
-----END PGP SIGNATURE-----

--L/yK4/dJDBsDnoeq--


Return-Path: <linux-kernel+bounces-127987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B853F89541B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E851C1C21929
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350082891;
	Tue,  2 Apr 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JWkWYYef"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575F7F7E2;
	Tue,  2 Apr 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062686; cv=none; b=q8qaCkxoxPzqtRyljZDzOAwXAMiZsZqhni01/rCWp2+PamiZickhj/mqnO7bw2HM/LXq+iiFHH7UFEJ5VK99pc8m0zqZx5ijuUTrTqkG9x4QX5P6DDFduY4Fp/r2x/6g4CrdmQUQpoT9cnZ4kjq7cDMEpfp9uNKSykjx6iKd7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062686; c=relaxed/simple;
	bh=c20jtcTiYnJN5GOdRZ4xqI6F2kAuoMdLDYhAs+FZuTY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyD59FGldRMXm/CDbhTEDWbG9j1G7Bo/HQvJDTDYM6HgSfNzeYC1O5FwYDcyBRspYLhaIDHhFyAvicisbj5gFmoO//Taq8nzDMRiFJMl9Vw0a4+Q6nuKOK8S5ojIv3jFvV6E13fXieUCZ+mntZcNfu+hTJqSIqGBW5N5GmkBjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JWkWYYef; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712062684; x=1743598684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c20jtcTiYnJN5GOdRZ4xqI6F2kAuoMdLDYhAs+FZuTY=;
  b=JWkWYYefDc6cPmq7W2xheq8RpBNjrnR/JhZmwT1xe0V3bn9qFl2nh9yh
   gqYoGTcwBAykFyP6b2AekJjM5pzkwBPLtLHVn510NGTMtaG7yxBtXjkW4
   Ot+3MWaD9z158ybinU21m9M80kHU3ZBQLihrqAp3UGYJPy4Zr+un+aZxl
   NQsET9B9dYhgeAAiOeIGbs0lPvRK/KEccs8y7yqDzYf2Caaj9W/wzlRB4
   31fsJwVIZZvzUltjVTriPUhkwoE3dlgIqWL0Cl+70qKG9D9W/nrYxzpBG
   MTUkZ0aCy9EquNzndgDElB/EI6gZMD/iW40DyDsTxqhvm8r5pX7XgntjY
   A==;
X-CSE-ConnectionGUID: zJdH45BwRNCwIlgxGwnvJQ==
X-CSE-MsgGUID: mLaRUhSLTyS3tu+hCvVbgA==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="asc'?scan'208";a="19161140"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 05:58:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 05:57:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 2 Apr 2024 05:57:28 -0700
Date: Tue, 2 Apr 2024 13:56:40 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Yangyu Chen <cyy@cyyself.name>, <linux-riscv@lists.infradead.org>, Conor
 Dooley <conor@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-gpio@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] pinctrl: k210: Deprecate SOC_CANAAN and use
 SOC_CANAAN_K210
Message-ID: <20240402-automatic-radial-7bc7dc342987@wendy>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_6D10A9C63E3E0F412EED33477B5CDB98C207@qq.com>
 <CACRpkdY1wpGM7M5QV5rN0M6JMN_yugQJ7CEtnQjzsheD5AT23A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mWQUdRed7U+WvCby"
Content-Disposition: inline
In-Reply-To: <CACRpkdY1wpGM7M5QV5rN0M6JMN_yugQJ7CEtnQjzsheD5AT23A@mail.gmail.com>

--mWQUdRed7U+WvCby
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 02:31:36PM +0200, Linus Walleij wrote:
> On Sat, Mar 23, 2024 at 1:13=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> wr=
ote:
>=20
> > Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> > SoCs is already on the mailing list [2,3,4], we remove the use of
> > SOC_CANAAN and introduced SOC_CANAAN_K210 for K210-specific drivers,
> >
> > Thus, we replace its drivers depends on SOC_CANAAN_K210 and default sel=
ect
> > when it has the symbol SOC_CANAAN_K210.
> >
> > [1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@k=
ernel.org/
> > [2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7e=
d0a@spud/
> > [3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c4=
6bb29@spud/
> > [4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb86=
55a4d@spud/
> >
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Is this patch something I can just apply to the pinctrl tree?

The new symbol doesn't exist in the pinctrl tree, so the driver will
cease to be compilable. Yangyu sent a standalone version of these symbol
changes:
https://lore.kernel.org/all/tencent_DB11214C8D0D7C48829ADA128E7BB8F13108@qq=
=2Ecom/
That whole series needs to go through one tree though, for the same reason.

If your ack transfers to that (identical patch) I can take the whole lot
via the soc tree for v6.10.

--mWQUdRed7U+WvCby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgwAiAAKCRB4tDGHoIJi
0vAXAQCeH+Yhvgq6/ASIgmTJPZ4FUkxGBC6xwyyibvKsGIjFQwD/cR8dZLkzZWnx
k50eNNnRBJ2KI81TqZySRvwHsgO/bA8=
=QFi9
-----END PGP SIGNATURE-----

--mWQUdRed7U+WvCby--


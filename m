Return-Path: <linux-kernel+bounces-82894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8C9868B63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FEE287452
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713B136670;
	Tue, 27 Feb 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1UT8AN/A"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF757BAE7;
	Tue, 27 Feb 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024109; cv=none; b=pHKzFIdHBQyxsIDKh1bMVbgx5g/T6DWrnsWGqdRE8GaY2QG0In1pe9h9YXsGZ2ia/CJKbbc9bXNDQYYPR2WtDzQ195dzAI8C+/zn+feefqL8zJMYTsMqxiy8CPHYTSCwrA4LjBgOYlkKyBwLOWZVofk0dw0FgYDRWvpR7Fl04LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024109; c=relaxed/simple;
	bh=WoJYGL2TCnkr2w1VlrLBVfG92mEtbt6KEliQlVa4KHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISDZx+QJiBnj8CtVVKrxtI4FanTIsc8SB1Da2HcqYo2MI4PWPmPTtyniOrE1GOsPNQkRt+iWQedZYJOKYdJ1B9fvGyaTZgSZDCPIXY2X3YVs00B611svbIaiYv6iMrxgNQiT6P+L9i8rFt8fNaYI/1mwYR6Dj0jqd+/2UsdH6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1UT8AN/A; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709024108; x=1740560108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WoJYGL2TCnkr2w1VlrLBVfG92mEtbt6KEliQlVa4KHQ=;
  b=1UT8AN/AnsMhR7Nwq6MSV7adnExMBihos/+JW3t8FDl5u3Kpg092vPxR
   oINp5VWK7v7U4uJJ6gYJ0hMn1ayEdIru7aQ59Lm9UPqL3zQ27HKiZ+Omv
   nkVUClQhaoak/Do/isO7SFD9s91jcMUiVohQTDO6Vh0vBC9UR2YXMEPco
   QO0ifMOJ4Lli0gj2XIhU9xgmEAjZ8ELrrpeFuTm7hNpvF2WwWnXe7g/zt
   pPNm1jx5eIjB202krE79MBP1/MIz7zpxQ1ix2kdDIT7GbJHacfBhq/fI8
   7kOBYBK/2ZN2V7o3MGgXrxCXVFv4xorsHviotOFJq22KOEY68lBue90ba
   g==;
X-CSE-ConnectionGUID: qD79kU+kQWmT4/4KcnQg6g==
X-CSE-MsgGUID: cXEwV6uyTb+fwDN6W0wmcg==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="16875102"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 01:55:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 01:54:46 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 01:54:43 -0700
Date: Tue, 27 Feb 2024 08:54:01 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: JiSheng Teoh <jisheng.teoh@starfivetech.com>
CC: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Leyfoon
 Tan <leyfoon.tan@starfivetech.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
	Albert Ou <aou@eecs.berkeley.edu>, Paul Walmsley <paul.walmsley@sifive.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Xingyu Wu
	<xingyu.wu@starfivetech.com>, Guenter Roeck <linux@roeck-us.net>, Wim Van
 Sebroeck <wim@linux-watchdog.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: watchdog: starfive,jh7100-wdt: Add
 compatible for JH8100
Message-ID: <20240227-arrange-theft-021133800c24@wendy>
References: <20231221084358.3458713-1-jisheng.teoh@starfivetech.com>
 <20231221084358.3458713-2-jisheng.teoh@starfivetech.com>
 <170319257135.88357.1722653226891421278.robh@kernel.org>
 <ZQ0PR01MB11603A15E27E344ADA11AC43EB59A@ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/NNhPt6yL350ZtX"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB11603A15E27E344ADA11AC43EB59A@ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn>

--5/NNhPt6yL350ZtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:57:43AM +0000, JiSheng Teoh wrote:
> > On Thu, 21 Dec 2023 16:43:57 +0800, Ji Sheng Teoh wrote:
> > > Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> > > watchdog.
> > > Since JH8100 watchdog only has 1 reset signal, update binding document
> > > to support one reset for "starfive,jh8100-wdt" compatible.
> > >
> > > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > > ---
> > >  .../watchdog/starfive,jh7100-wdt.yaml         | 40 ++++++++++++++---=
--
> > >  1 file changed, 31 insertions(+), 9 deletions(-)
> > >
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> Hi Conor, since this patch is reviewed, could you help to pick this
> dt-bindings patch for riscv-dt-for-next branch?

Ideally I would not and it would go via the watchdog tree.

Failing that, I'd rather Rob take it.

Thanks,
Conor.

--5/NNhPt6yL350ZtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd2jGwAKCRB4tDGHoIJi
0o02AQDUgzrn6JnUOaFQ4y/ICrPh1DIxb6FFKMBBGx82o4xb8QEA2JRBmceCzOh8
/YRRWMvcMwl2ARgGcFNuZBE0hbOttgU=
=x9oX
-----END PGP SIGNATURE-----

--5/NNhPt6yL350ZtX--


Return-Path: <linux-kernel+bounces-27183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0E82EBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC58BB23224
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F312B9F;
	Tue, 16 Jan 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zFvONMzi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B212B72;
	Tue, 16 Jan 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705397816; x=1736933816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=39czfNO5V3xKHsrOqpHy7us5tDzGWkwldLuCUN58kKA=;
  b=zFvONMzioGIA+x0+I+x0ETuSXMlxNCLJGPWwl3ja0XYWnPGX9WsCEhIQ
   Lr5nFIpHnyiuqbeFIK9fOAgjG+m/qlKOF9iQ2fMGZXu88ocZ3q+dhlN0p
   op3lSDkmhU30gWlzkUKeNG2witgwhAqc/s6G79+QJCzKFoRhxVB53WM39
   U2AcTye4HEPbbyVGR1YYduziRucFOioOephH/nr/Lfgqjf/A66Wiiem5S
   Mwo3FCtioqTbdNVSXHwtpNVmIioKMN4+ayrxB7sy3A+7dRMAKXJFhy5Cm
   FpCQFR/auT6z5OsZY/Me4G/LcQhL6PuQenMJu9GvW0HBunXZK7oQim4cu
   A==;
X-CSE-ConnectionGUID: KLJlNhuBSmyPaf0y5pvXTg==
X-CSE-MsgGUID: VqOrt//kSvysy5D/p/zs3A==
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="asc'?scan'208";a="245528620"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 02:36:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 02:36:54 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jan 2024 02:36:50 -0700
Date: Tue, 16 Jan 2024 09:36:14 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Devarsh Thakkar <devarsht@ti.com>
CC: Conor Dooley <conor@kernel.org>, <jyri.sarha@iki.fi>,
	<tomi.valkeinen@ideasonboard.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <praneeth@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>, <kristo@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add support for
 common1 region
Message-ID: <20240116-unrobed-cornflake-b19d4c8eb6f6@wendy>
References: <20240115125716.560363-1-devarsht@ti.com>
 <20240115125716.560363-2-devarsht@ti.com>
 <20240115-craftsman-capricorn-d2930678c222@spud>
 <060358d6-ade1-b84e-4550-e2ae34a6d53c@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+rwc3dPPDb7jGZPT"
Content-Disposition: inline
In-Reply-To: <060358d6-ade1-b84e-4550-e2ae34a6d53c@ti.com>

--+rwc3dPPDb7jGZPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:43:25PM +0530, Devarsh Thakkar wrote:
> Hi Conor,
>=20
> Thanks for the review.
>=20
> On 15/01/24 21:47, Conor Dooley wrote:
> > On Mon, Jan 15, 2024 at 06:27:15PM +0530, Devarsh Thakkar wrote:
> >> TI keystone display subsystem present in AM65 and other SoCs such as A=
M62
> >=20
> > Do all 3 SoCs supported by this binding (am625 am62a7 am65x) have this
> > common1 register? If not, you should limit it the platforms that do have
> > it.
> >=20
>=20
> Yes all 3 SoCs supported by binding have common1 register space supported.

Okay, thanks.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--+rwc3dPPDb7jGZPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaZODgAKCRB4tDGHoIJi
0k/9AP4h3OJM2KbUAQ+lhul093KnPwadGv739cJyQuGQqMMkCwD/Q9dlnqTU0P80
HKKE2LC1Hw/uyuPyVRQw1kceYE1gFgQ=
=Y0Rt
-----END PGP SIGNATURE-----

--+rwc3dPPDb7jGZPT--


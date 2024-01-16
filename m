Return-Path: <linux-kernel+bounces-27191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A782EBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99EF9B239B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA61B7FB;
	Tue, 16 Jan 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U5/p7CIM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044512B61;
	Tue, 16 Jan 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705397981; x=1736933981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WaSp1uecU8Hv9kjMQc6rHJ1yWydbl1s07fCkpBLmJ8Q=;
  b=U5/p7CIM6Aury65295PJ/RHT8c2AEFRNdly7Nsm/bEAyVnHWzHEkCQuQ
   h9/Vb1ceoMJt42UErn3OBHzzduDQ286bcfSCojUef2U8oJDU3Rlsp0BU2
   O5TzQu1KaboeBqtX7tcqeDDXo3AzSEUy5fUoSiFCq8yRHoosX4FPSwGN1
   Z6QEU9gMzKBzEusmStayG6r3qPKq2I/DImpMFLZnobEC6YP1zBzSkj5nS
   JMMdpcJZ2qINZz2TdBguYDh0lYNZyZHjDXHWYA6SEBxdcNWc4j9r0LLBx
   RWVAAYZiC/DmjkXKXn4tcQps1PzInjEsyCSkAuDCa4G4xml63wfpjCMUO
   Q==;
X-CSE-ConnectionGUID: dZKgwdjESgmVmHbCstXmxQ==
X-CSE-MsgGUID: aeEHy09nT/KGdnPjW7vHHw==
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="asc'?scan'208";a="14820304"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 02:39:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 02:39:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jan 2024 02:39:15 -0700
Date: Tue, 16 Jan 2024 09:38:39 +0000
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
Subject: Re: [DO NOT MERGE PATCH 2/2] arm64: dts: ti: Add common1 register
 space for AM62x and AM65x SoCs
Message-ID: <20240116-spending-famished-5a5e407d02bb@wendy>
References: <20240115125716.560363-1-devarsht@ti.com>
 <20240115125716.560363-3-devarsht@ti.com>
 <20240115-penpal-pluck-d156ccf21b2f@spud>
 <4c5cb4ed-96a3-7bd8-f660-2a3bb041ca09@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BC6FFMzhPnkn64Jt"
Content-Disposition: inline
In-Reply-To: <4c5cb4ed-96a3-7bd8-f660-2a3bb041ca09@ti.com>

--BC6FFMzhPnkn64Jt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:48:53PM +0530, Devarsh Thakkar wrote:
> Hi Conor,
>=20
> Thanks for the review.
>=20
> On 15/01/24 21:44, Conor Dooley wrote:
> > On Mon, Jan 15, 2024 at 06:27:16PM +0530, Devarsh Thakkar wrote:
> >> This adds common1 register space for AM62x and AM65x SoC's which are u=
sing
> >> TI's Keystone display hardware and supporting it as described in
> >> Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml.
> >>
> >> This region is documented in respective Technical Reference Manuals [1=
].
> >>
> >> [1]:
> >> AM62x TRM:
> >> https://www.ti.com/lit/pdf/spruiv7 (Section 14.8.9.1 DSS Registers)
> >>
> >> AM65x TRM:
> >> https://www.ti.com/lit/pdf/spruid7 (Section 12.6.5 DSS Registers)
> >>
> >> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> >> ---
> >=20
> > "[DO NOT MERGE PATCH 2/2]" but no rationale here as to why this cannot
> > be merged? What's the problem with it?
> >=20
>=20
> No problem as such from my point of view, but this is the process I follow
> since maintainer trees for device-tree file and bindings are different. I
> generally mark a [DO NOT MERGE] tag for device-tree file patches until bi=
nding
> patch gets merged so that the device-tree patches don't get applied by mi=
stake
> if binding patch has some pending comments.
>=20
> Once binding patch gets merged, I re-send the device-tree file patches ag=
ain
> to respective list.

I see. Please note this in your patches, under the --- line, in the
future to avoid confusion.

--BC6FFMzhPnkn64Jt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaZOnwAKCRB4tDGHoIJi
0rJvAP4y1i7FM56Lm+nbXDP54G7/zOyfStQD6i7K+5HRE0TukAD/WY69qtoMG6kG
+p/19kPAUGbuxQCH4HeYpl6fP6cBcgU=
=Hg35
-----END PGP SIGNATURE-----

--BC6FFMzhPnkn64Jt--


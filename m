Return-Path: <linux-kernel+bounces-50159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60619847510
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB59282E16
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99C1487D2;
	Fri,  2 Feb 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF0hXx/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A6148303;
	Fri,  2 Feb 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891962; cv=none; b=Om+Br2yAHzuT2AxVBxKkdbO1J8RAkLhA0/wtU691FSaB/kxgn7o0Ce/ZUWfpGFg7ggItu6xtXi0ITRX3+Lx4SZ/TckBIhSKOVzjwbYa/qeKb6cnpgSfQb4EF65evDJLGRIm2stwaWeFHz+bK8fr7xOw5Cpx+leQIf0bmJH9PGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891962; c=relaxed/simple;
	bh=C93aK6BQwczn2Qf4d1EaU4y+6e3vbrVFjIg108ozk1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUJ5xyKl0cky+gRV0cUUSFsHwPYaPLnnxizxl01Gqk1ea44+16x9UgD+kqomQkc8A/z+Z7RLFY+EVSVI4WKb3za7D8RHDBihq2l4aK+CUgLGHFacTxaxIBBaz8GQo9GmgpZwvjNI/4Mz4Ffz22Nfqmfyny+RxJFKyc43a1HR9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF0hXx/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEBDC433C7;
	Fri,  2 Feb 2024 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891961;
	bh=C93aK6BQwczn2Qf4d1EaU4y+6e3vbrVFjIg108ozk1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FF0hXx/OF2XOg4bls2j9LIIkMD7T7StzYycyRMzWJFzy6j4LsVnG3RtNfmaGDd/sT
	 f/O0g8tOFs5lJUv0y7g9aAV8qHoCvOU+kx/9KmQvCls17yBOpopouuTvJzLwyoXtga
	 pClNPBh9LV9Ug6DQ3i2y3DL8CHS1DlMy/m7u6uiw3ANYKY2Ti17eaN9ijXIy+IBP+Z
	 4owhpO25cTp+Yq83hc9wixId0OGpXDCDKvtwKVxd88PDHPCNKnznJgXO/xh4nWWoJ4
	 87VxY8fw2w6T2XHGne70xH8dRXVkfZEQT442hoGrnhc3ueBVlAefELNj0uczSKiEKJ
	 v8AfJI4j13tkQ==
Date: Fri, 2 Feb 2024 16:39:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Bin Liu <b-liu@ti.com>,
	nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240202-hunchback-tapestry-16b1bcf16452@spud>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
 <20240201-clad-unopposed-ccfdfe53b770@spud>
 <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>
 <20240202-unzip-whacky-bb2f151c618b@wendy>
 <dc3c93dc-74d9-4b1c-a771-3ee6f67b5dcc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nAiiSYjdnr/gaelo"
Content-Disposition: inline
In-Reply-To: <dc3c93dc-74d9-4b1c-a771-3ee6f67b5dcc@kernel.org>


--nAiiSYjdnr/gaelo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 12:13:22PM +0200, Roger Quadros wrote:
>=20
>=20
> On 02/02/2024 11:53, Conor Dooley wrote:
> > On Fri, Feb 02, 2024 at 11:36:55AM +0200, Roger Quadros wrote:
> >>
> >>
> >> On 01/02/2024 21:13, Conor Dooley wrote:
> >>> On Thu, Feb 01, 2024 at 12:35:22PM -0600, Bin Liu wrote:
> >>>> On Thu, Feb 01, 2024 at 06:18:05PM +0000, Conor Dooley wrote:
> >>>>> On Thu, Feb 01, 2024 at 06:15:20PM +0000, Conor Dooley wrote:
> >>>>>> On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
> >>>>>>> So far this was not required but due to the newly identified
> >>>>>>> Errata i2409 [1] we need to poke this register space.
> >>>>>>>
> >>>>>>> [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> >>>>>>>
> >>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >>>>>>
> >>>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >>>>>
> >>>>> Actually, where is the user for this that actually pokes the regist=
er
> >>>>> space?
> >>
> >> https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/
> >>
> >>>>> You're adding another register region, so I went to check how you w=
ere
> >>>>> handling that in drivers, but there's no driver patch.
> >>>>
> >>>> See Roger's another patch set 'Add workaround for Errata i2409' post=
ed
> >>>> on 16th.
> >>>
> >>> This patch should be with that series, not with these dts patches.
> >>>
> >>
> >> Why not? There should be no dependency between DTS and driver implemen=
tation.
> >>
> >> As DTS and driver will be merged by separate maintainers I thought it
> >> would be easier for maintainers this way.
> >=20
> > dts and driver might be merged by different people, but dt-bindings and
> > drivers are merged by the same people. This is a bindings patch, not a
>=20
> If we do that then I get a bunch of dtbs_check warnings
>=20
> dwc3-usb@f900000: reg: [[0, 261095424, 0, 2048], [0, 261128192, 0, 1024]]=
 is too long

I don't know what your platform maintainers view is, but to me it is fine
as long as linux-next is clean.

--nAiiSYjdnr/gaelo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0atAAKCRB4tDGHoIJi
0nBQAQCicJ91INCex20f2549WHuW6zf1gYNYwN/ECqpQDaEkigD/e+eqROf+RPcx
loBomq/me8ZT/g8POwlA++gvut3+4w0=
=wkAY
-----END PGP SIGNATURE-----

--nAiiSYjdnr/gaelo--


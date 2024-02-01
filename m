Return-Path: <linux-kernel+bounces-48746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C238460B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C83B26405
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF085274;
	Thu,  1 Feb 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+/GgLFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767CB85266;
	Thu,  1 Feb 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814815; cv=none; b=V9LNyVrX3OYKmOPCafIGDO5juAe7sexqcsJvGdYVun1bO55+kzrz77DEV+UN9p5z3ybR61Wxew1yvRjSHgYOBi69gGPaREQ71NG9gidUKOOl/YyIqhC+qAJTbUhH73tZ0nTutCu7aPfQG9S5yEzBD3RfAX17ewcQ78znWtnZYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814815; c=relaxed/simple;
	bh=LiHs4Gdh0sIyzXOIEs/VTJSvcskWCGWwAGEJNOWo6W0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f75YO0Xvf0IW/a5/bwK6vS+58aFD9NO717XuKl0z75p72716/9akq0IRDSfMrzLveny38R7V5ESN5TbxjV/xvT+XS0oR4NW2KAv+rg3l5AX1yO7ROGHs1sV3sLbH8Oz4urWHy+Yy1uPKTGdVRsRirpFcRoEtWnegCCE6Uo8V/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+/GgLFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DEDC433C7;
	Thu,  1 Feb 2024 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706814815;
	bh=LiHs4Gdh0sIyzXOIEs/VTJSvcskWCGWwAGEJNOWo6W0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=X+/GgLFD2Vo0KXcprOT0+cVUc/aYvK2PwDMMUeMBWMugWai4xbgL/33rKBXScA1FG
	 Pi+BzU0MEJ7rUm0A6aeDuVn6aK/IWcyTfxuMwq5TEsBImWwNoF83F5Jw3BX8yPFqVN
	 ujRECQRg5OLdaXbnBgxBGLr9H7mZ4pkdF6k/GC121oMvKHUw3Za1d+bNtzDyTYvZWi
	 w1ZcABgc/qGsWMHfeyaIrHXWE5bKmXoaAeDT1eBjiHd0SZhm4bHSPKgEiBsrI7JUfg
	 RFPtuzTl5tDx6WjqaIvsmNkPNFa++3RdO9W9oGe6Q3nEpGmIaNZW1q5gApDc2+7dSg
	 VYDIkvkzIXyHQ==
Date: Thu, 1 Feb 2024 19:13:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Bin Liu <b-liu@ti.com>, Roger Quadros <rogerq@kernel.org>, nm@ti.com,
	vigneshr@ti.com, afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
	r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240201-clad-unopposed-ccfdfe53b770@spud>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RMKs8DUGoEquL9Bx"
Content-Disposition: inline
In-Reply-To: <20240201183522.ssj553rwefr2wuqi@iaqt7>


--RMKs8DUGoEquL9Bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 12:35:22PM -0600, Bin Liu wrote:
> On Thu, Feb 01, 2024 at 06:18:05PM +0000, Conor Dooley wrote:
> > On Thu, Feb 01, 2024 at 06:15:20PM +0000, Conor Dooley wrote:
> > > On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
> > > > So far this was not required but due to the newly identified
> > > > Errata i2409 [1] we need to poke this register space.
> > > >=20
> > > > [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> > > >=20
> > > > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > >=20
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Actually, where is the user for this that actually pokes the register
> > space?
> > You're adding another register region, so I went to check how you were
> > handling that in drivers, but there's no driver patch.
>=20
> See Roger's another patch set 'Add workaround for Errata i2409' posted
> on 16th.

This patch should be with that series, not with these dts patches.

Thanks,
Conor.

--RMKs8DUGoEquL9Bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvtWAAKCRB4tDGHoIJi
0s0KAQD9ImLQGvGN1YJ8FfZ+Dr0vqipzgTnaOER39dkZPxdVPwEA/G8/K5nuCQvB
zSqKP49Nih6m4xUSbM7LTze+UQCJIQU=
=vSXn
-----END PGP SIGNATURE-----

--RMKs8DUGoEquL9Bx--


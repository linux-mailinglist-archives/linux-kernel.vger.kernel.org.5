Return-Path: <linux-kernel+bounces-105416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784187DD95
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC76CB20C80
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F81BDE2;
	Sun, 17 Mar 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6gr8tFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CA1C680;
	Sun, 17 Mar 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687169; cv=none; b=tohhXcMHAzYlm87MjEzvqwZ/zGhXA/0JLcBY18LyXgnVZz30DiVY5WKS1RMLRmR+ic0FFDCBriwrlrWvT+0ctxozeMIrrxGSj61cTSSsiEomRd5JivP/1TQl4UY1BoYpAJdWFnhgCxORO2sa0q+AfPGwtS5DZa0KE6lx5XaIIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687169; c=relaxed/simple;
	bh=s89tZtC6mktj6Ii5rq9MBZ3IjgBpGHd8y4TIiYjhd/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ4xPYDK2+v4YWzkJ7Vz/VId71DUkIrbEsHTmmHYh54TrjiojldqLD3W78JMXLCzrTbPDhZP0NKqfFyA3vlhT2RQV8JYrifRSAMmUClPcDRvf9AeHLvUwrVE3fALCRs6RNGRyZfLzcGxwDctubDuEIU8AIvzr/5XqDXFKEuyy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6gr8tFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63315C433F1;
	Sun, 17 Mar 2024 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710687168;
	bh=s89tZtC6mktj6Ii5rq9MBZ3IjgBpGHd8y4TIiYjhd/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6gr8tFM74MxNS9+6ahloRQT9jHQxIaW/P/VNFyH39L46v42rEdQsdb3i2jnlQhMa
	 rQ5TWKFQKeshHOfCnFDB5GX2Fg50YwDQEnrtTJ1Y50qRxXJeP432bFczcIVBUHNGig
	 G2bwONto51xyvxL5BzBdsuM+PfKqWtxtFGiViAJ69KPf+BOWGSLBYm79YEPcZ3WvRv
	 1XiLqPp2uBmlbv059Y2ecmwSb+2zPi7cvW1ahzPigLYATaQfDdZ2uplqv9eWJDTcnz
	 sS4n4yYbRwO5fG2M1RJBYQKQSXOgZDWlEkub6SNWoxCuEYC1P2lWnJHynC2Oyql7LV
	 yRfPJ6jh0to9Q==
Date: Sun, 17 Mar 2024 14:52:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: add Versal platform support
Message-ID: <20240317-okay-rinsing-3f730007fd3c@spud>
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-2-tanmay.shah@amd.com>
 <20240317-overturn-frozen-b152dc552a2f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CRx4OHhbV6C8HkHh"
Content-Disposition: inline
In-Reply-To: <20240317-overturn-frozen-b152dc552a2f@spud>


--CRx4OHhbV6C8HkHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 02:50:27PM +0000, Conor Dooley wrote:
> On Fri, Mar 15, 2024 at 02:15:31PM -0700, Tanmay Shah wrote:
> > AMD-Xilinx Versal platform is successor of ZynqMP platform. Real-time
> > Processor Unit R5 cluster IP on Versal is same as of ZynqMP Platform.
>=20
> > Only difference is power-domains ID needed by power management firmware.
> > Hence, keeping the compatible property same as of zynqmp node.
>=20
> No, don't be lazy. Add a compatible with a fallback please.

> This doesn't apply to linux-next either FYI.

Ordinarily'd I'd not even bother applying a patch like this and I
wouldn't notice, but the diff for the versal-net patch is difficult to
read without colour-moved enabled and since I can't apply this I'm not
going to review that patch.

--CRx4OHhbV6C8HkHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcDvAAKCRB4tDGHoIJi
0uyMAP4oLTfDDU/F8G6VPDGZ+zSDC13OMgL+2qEhZBSFzPn3WwEA+CeeQrcXbKd+
CvoTGaG+/92l6rzk+q7zvqHJLo7j8Q8=
=SUd/
-----END PGP SIGNATURE-----

--CRx4OHhbV6C8HkHh--


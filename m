Return-Path: <linux-kernel+bounces-92758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2B872597
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A3282A86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8001640B;
	Tue,  5 Mar 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwuXR1oO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C014A9D;
	Tue,  5 Mar 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659491; cv=none; b=V3Mzt9lrF8zRpw1A18MKLskAreoObH+Mduz87Hcii64mCuP2MdD13UM+mKZHDALzY3L8U3Z0uqAT1FCTKSGFrQoQQOf5Qu38hJT+ii6aQPuCAyMKNlOfHPqgkmG61pKU039ASoQqfBqjWM4SSrYLFBz2OjuOCh2FHK8K9ERqbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659491; c=relaxed/simple;
	bh=QsenZAH1ku6PvZX7ejloa6VeWLc+wSXNgpDQ7jBBw5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1TI3YXx0xnjI9ZVhCmWPOnwbIWhkUZPArPY3BtjRNUnKhHI3OR9ncp+hiDubCgw41R13vMre7J0Hq/Ah9AbTrrdSLXwZwhuxKQKpVFaATHzwWSW5GLDkbPwdJu9JOZxdAvq8xC/BYvZc+8OvgpWBYzbWDxhu/ZsWv43GpTO7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwuXR1oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11305C433F1;
	Tue,  5 Mar 2024 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709659491;
	bh=QsenZAH1ku6PvZX7ejloa6VeWLc+wSXNgpDQ7jBBw5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwuXR1oOn3cAnb66aX7pDqhqWQLptn4H9mnfjQtk/eTS9nk8mhADs3PIdTBJtx1v+
	 eXYLcsE8SLBPnVvzQPmrR0WRuPjOwBtyluyHD/lk6499LHFcOSRPLxAIJg5uJ+z4pp
	 q6tCLX6KoE6uIeS7G8tTGq0y/9S5pb6Y5+pSis931MFL0rAYzY3fsYxUrcLAmeCvSd
	 hF5K+Xaz2Z2kDqD4eIAl0woUZKrIQki6a5BJSF44bN0Bl3IIPIhWGSG8V6tPyGKSc5
	 l9Ir+vsBnXa/O+oRyIz1BpUXjV+XwEp7486g39dzlv+pC1fmgXkyKW9o6fI6yuO7Zi
	 KJWXqw++Ejd+A==
Date: Tue, 5 Mar 2024 17:24:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, guoren@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] riscv: dts: add initial canmv-k230 and k230-evb
 dts
Message-ID: <20240305-ripcord-engraving-af3310d62a67@spud>
References: <mhng-f1aa91d4-211f-4eb4-a94d-a9d88b0d3f6a@palmer-ri-x1c9>
 <7A86D933-B85F-4B29-8D6D-AB414A42AC06@cyyself.name>
 <tencent_B2C1146D4947315C8018AE90EDC64F3E6207@qq.com>
 <20240305-shorten-disallow-eae65fdc8fdb@spud>
 <tencent_3638D6E106C784859837E6F3C10BDA688F0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vhZQxYF104MnbLU5"
Content-Disposition: inline
In-Reply-To: <tencent_3638D6E106C784859837E6F3C10BDA688F0A@qq.com>


--vhZQxYF104MnbLU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 01:17:29AM +0800, Yangyu Chen wrote:
> > On Mar 6, 2024, at 01:01, Conor Dooley <conor@kernel.org> wrote:
> > On Wed, Mar 06, 2024 at 12:37:16AM +0800, Yangyu Chen wrote:

> >>> Link: https://github.com/cyyself/opensbi/commit/b113c1c01d700314a4a69=
6297ec09031a9399354
> >>>=20
> >>> Furthermore, I wonder whether a CPU node like this would be acceptabl=
e.
> >>> I don't have any other details of how another CPU from K230 SoC works=
 on
> >>> Linux.
> >=20
> > A CPU node like what? It is not clear to me.
>=20
> It in the k230.dtsi file. Only has big core there.

The node that is currently there looks fine to me.

--vhZQxYF104MnbLU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZedVXgAKCRB4tDGHoIJi
0saeAP4pPuYdIfPpajZxYSLmdBJkzM9jXmO55zWBkmcKkm1OrwEAjXqI9zESV97A
Cl7lBRtyzckFGrJKMW1RI+mIFSqnGgg=
=bd1D
-----END PGP SIGNATURE-----

--vhZQxYF104MnbLU5--


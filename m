Return-Path: <linux-kernel+bounces-88664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08386E4FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1504E1F22EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B022570CBB;
	Fri,  1 Mar 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIRzC7wM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68A47F51;
	Fri,  1 Mar 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309202; cv=none; b=u63trLF9l3L26R1bHziPyfzvr2LTXpbf2GmX0cN5cNQLIxpY7XhlSciOi4ikdRptXSqQnX/2D1C27ze/oDGRi0zDVB+XehOzitNOXeodeBc7JOxByuH4Yfgw671Esr2X5TlZy43nJAlM2+OqW9O7V1A7Eh5DahErP/vrtivaCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309202; c=relaxed/simple;
	bh=knyN2wQ07TfXmZro4f/osbfPbiUBGVLB0wDHfSDhvKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0aN1JA92rWAOGvsGIZzxL5htS7vBF+HhirQpGv9LDuxWIk+C5pvGF2vuLnX/GcSnUL6QSPz4KvQtk828TSspQwCYlK8jGRoWMJWsL/BrkyeX+oBa203rxSddhcQCZJi5vsNbF7stiSCUp3HBDoGe7p3Pva5/Big5zuTC1sx+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIRzC7wM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76634C433C7;
	Fri,  1 Mar 2024 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709309200;
	bh=knyN2wQ07TfXmZro4f/osbfPbiUBGVLB0wDHfSDhvKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIRzC7wMamEOMafiaMqYgiJMEZgEwNvPRIyYOqudsfNKS+sRlJXEjxVnZ0Ua31gO5
	 f/+jxbOCFmfJXwtmuwNBsjUNl56U2uFlVPKDnX1GppZad70KykYqPFMwdc5aQMd4n9
	 YYBr7GE1YNdfD1sZPc2uZHc66P2KOnm37wJAPefCIybAYl3fI9g8oNiBfyRXsr591S
	 BRHRi8mx2OGFA6kAYA2VNj8O4gcrI6Oh+yJ8uLhQ+YJcP783cy5Xl6pt/RaMHbtVea
	 SnEDC3NyDcvLURrdQ3g3Gbktumu714YWMCew8DIfHXNdJPoj8H1VebtpR25nReX+SM
	 +BV32Hw+zTGaA==
Date: Fri, 1 Mar 2024 16:06:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240301-ending-resize-9ee4e1998f6c@spud>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <ZeDbiLR8vLtVfgGX@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JPNJZm8NAkhZORDD"
Content-Disposition: inline
In-Reply-To: <ZeDbiLR8vLtVfgGX@lizhi-Precision-Tower-5810>


--JPNJZm8NAkhZORDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 02:31:20PM -0500, Frank Li wrote:
> On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > Some sai only connect one direction. So allow only "rx" or "tx" for
> > > dma-names.
> >=20
> > Which sai? Can you restrict this per compatible please, so that someone
> > cannot add 2 dmas for ones where only the tx is supported.
>=20
> SAI is exact the same. Only external connect one dma channel.

Right. The wording made it sound like some SAIs were capable of this and
some were not, but what you actually mean is that all SAIs can sometimes
be connected in only one direction.

--JPNJZm8NAkhZORDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeH9CwAKCRB4tDGHoIJi
0hweAP9TNn1/yWSr9gMtGNBg3TsNMmm8lgc2S75Z33QQzz3JPgD/VAYtixlWg7Wa
V6MhQcfPzV1HKMSVqlAcRCNuvXsgQAo=
=V04g
-----END PGP SIGNATURE-----

--JPNJZm8NAkhZORDD--


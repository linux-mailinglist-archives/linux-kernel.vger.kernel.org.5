Return-Path: <linux-kernel+bounces-163831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021BA8B72F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BFEB21B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0512D214;
	Tue, 30 Apr 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8WKV1Ii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0304211C;
	Tue, 30 Apr 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475617; cv=none; b=XF6NeDfBQ93Tyig7knxBJVN4XWAVk2sOqGo+3SPwuGomUj17GwYV/p6AE2lYrO9jaZ+dHam9zjmcSoarxTxRUnJU9Pz9sPY3D7gvAkjJ2+5A1dz+jZPu6MF5v4uQD2DcQdgYadTfsrjwpjKzGd/FsydwhymPRiwRHEYHdrDdmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475617; c=relaxed/simple;
	bh=muqIjVHzEEG31WNmMmWpy+dDISrb8zNJmjv3GCbIVe0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=sO0xokcris3Pu38VDJnZTQF+EUwFmnsfw5FdcYP4ICjpfA2yDjB0XnN1cBzYDxC8o8UPKw+OxRvIZu/eYHnUYDVt2YcLgd4u3LK3/KnAVNs+DGAz2UbF2c33jdEyDogPzOIFA6s2M8Y8MTlzvfqhMTKC+WZivh+lBmcFmp28iQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8WKV1Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A1EC4AF19;
	Tue, 30 Apr 2024 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714475617;
	bh=muqIjVHzEEG31WNmMmWpy+dDISrb8zNJmjv3GCbIVe0=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=A8WKV1IiC2YbOETMl3IwqBVrJwEyUixq5N0/xh7CbUanUOA9PF10Z/sODAuJTZ1B7
	 dKZDkKK72C/tIsxotGu/eQVuq0xsdtmX5MtV9EL2TWz9Me8RdWHM2hQREMeFkmO8u+
	 ZuuEN/XBBIBymUUOgnNw/E7CWJBH7m9YOqb47x2QHJMj9/FEFguvnykzMVIbOqTCbf
	 Nu99AxmdjhKV5NZEb765CHHOfyMWOv+G7Bm2n3J4Dt8eHR70l2eekpQxCOQVwsPCil
	 mtfV4HTRdCgM+Mj/FSxkuxVuO2v/CO+xJFaL4wJ3jv0paUWqL/Jos1ri/krUsUEKBu
	 L1GN5kUrOrTdA==
Content-Type: multipart/signed;
 boundary=ae9f0f2df1a869383dbbc955fdbb73d48e8e25c89c9e6058d7bd4b04b596;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 30 Apr 2024 13:13:33 +0200
Message-Id: <D0XEVRFIP18W.2QSS5RI8KJT03@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: add sophgo spi-nor-controller
Cc: <dlan@gentoo.org>, <linux-spi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Jingbao Qiu" <qiujingbao.dlmu@gmail.com>, <broonie@kernel.org>,
 <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <unicorn_wang@outlook.com>, <inochiama@outlook.com>,
 <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
X-Mailer: aerc 0.16.0
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
 <20240427075426.662671-2-qiujingbao.dlmu@gmail.com>
In-Reply-To: <20240427075426.662671-2-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--ae9f0f2df1a869383dbbc955fdbb73d48e8e25c89c9e6058d7bd4b04b596
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat Apr 27, 2024 at 9:54 AM CEST, Jingbao Qiu wrote:
> Add YAML bindings for cv1800 spi nor controller.

nit: SPI NOR

Is this really just an SPI NOR controller? Doesn't it work with
SPI NAND? Or in general, any memory like SPI device.

-michael

--ae9f0f2df1a869383dbbc955fdbb73d48e8e25c89c9e6058d7bd4b04b596
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZjDSXRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iJNAGAu32BEX3H9O4Pu7etz7CVD8z8oeIH+VWu
FhiufQ1Ev62lT1+WvRo8Ss00OwbKkTuIAYC4EmvZxvqIXaZUDHHxu8EeMSzG9jjD
lQNZ0+rPTwQUevpVOS1HsZsQ76GPaHGSKHI=
=ftlX
-----END PGP SIGNATURE-----

--ae9f0f2df1a869383dbbc955fdbb73d48e8e25c89c9e6058d7bd4b04b596--


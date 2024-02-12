Return-Path: <linux-kernel+bounces-61931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D46851899
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3FB1F211CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF63D0AD;
	Mon, 12 Feb 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TujBrWeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DC3D0A4;
	Mon, 12 Feb 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753755; cv=none; b=psnAn8N8QLL+U2Ih9ahNcVw9rjlXzxNyCynGJIxD2chwrF6HmsLgXuxIaKPqEqozhDjy9kVlNvDRTvsf2zRwismVowUI83J1cp0WkrYj9AdJdzOh2zXrQOmGqKjsQNR6esj/ZOmMi+ZAw8HyCZpV0yvc7jD6Yha6czG5Rhsnh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753755; c=relaxed/simple;
	bh=BO82b3pF0PgWZbp7XtrFt5+deNdyxcVfHCqOz7Kr9Us=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=OxvKBCNG25TsayJNDvB0TipjdSIQ+fza0xeKv/zctZhGQ3+kDDV5SKmtFGFXwoVavruKUssnULIWYSyecplQR8hUVdQr9KlpU0SKo118AAVF6OCkMrWKT8DctkCPalGnrszT+H/71pyuVo0gqYXy3bwettKoVbuUF+/ioMax3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TujBrWeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B67C433F1;
	Mon, 12 Feb 2024 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707753754;
	bh=BO82b3pF0PgWZbp7XtrFt5+deNdyxcVfHCqOz7Kr9Us=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=TujBrWeBJT+lImis8uQdYb3Iw8y7ZrBPelEPlFc7/JVzV/uLFR5WBrp5XFNsLMILQ
	 rUAgsBTbUWdq+SULdLgg3/3HnEsDaEqvvdYi0bmeguYyj9mhs/CC1ZXlu81dqAq+qf
	 YEE6IzXXI2rDiCANqzvLbss0xHw1Sehrhw05/75gxYX6wlLSlcCmywGvQYXVppUbhu
	 kTO8g7S4Iu1sDj5hoKVDyxlzLTv5EngrCz/yNU0j5xhQfO/C/moznk2rXyoxw7qRQI
	 R96Rc1rXQqOI+416w/QJKP8uFAtMNuMNxTPmGTdgwci9mLRnQ44i6UZXw06OIeT0UX
	 E14MSFs4+esng==
Content-Type: multipart/signed;
 boundary=05d8fdd48591a07013dcd1904d8242782772683d9de18a86a0b1a38b036b;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 12 Feb 2024 17:02:31 +0100
Message-Id: <CZ386ITQ83KH.1KNOV5MXLXPBF@kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: Add support for TI J722S
 Evaluation Module
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Davis" <afd@ti.com>, "Vaishnav Achath" <vaishnav.a@ti.com>,
 <nm@ti.com>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
 <robh+dt@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240206100608.127702-1-vaishnav.a@ti.com>
 <20240206100608.127702-4-vaishnav.a@ti.com>
In-Reply-To: <20240206100608.127702-4-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--05d8fdd48591a07013dcd1904d8242782772683d9de18a86a0b1a38b036b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Feb 6, 2024 at 11:06 AM CET, Vaishnav Achath wrote:
> +# Boards with J722s SoC
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm.dtb

I'm a bit confused by your names. What are the new/correct ones now?
Some seem to use the amXX names and some the jXX ones. I've read [1]
and it appears it was suggested to use the am67 names for the device
trees. Esp. because there is already, am62, am64, am65, am68 and
am69 in as names for the device trees.

The TRM you've linked in the cover letter doesn't shed much light
either. It just lists both.

-michael

[1] https://lore.kernel.org/all/81f90d13-da10-4a68-a0e7-95212f40b3e8@ti.com=
/           =20

--05d8fdd48591a07013dcd1904d8242782772683d9de18a86a0b1a38b036b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZcpBFxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvv0uwEA4jm13dBnm43Oj2GFAFm9iSVBGGpr5Z5A
SSqmgG6p8ooBAMXFFQ4/G3rtFucR6XBarqueSUXKQmTbzoaXpC4t1a8B
=hBTt
-----END PGP SIGNATURE-----

--05d8fdd48591a07013dcd1904d8242782772683d9de18a86a0b1a38b036b--


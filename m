Return-Path: <linux-kernel+bounces-106192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA7887EA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173721C210B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9554AED3;
	Mon, 18 Mar 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoAASRy4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89F481AC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770841; cv=none; b=ofasxYAQoG0HnnoghX8Is86JmTGBiu8eiLGs7GwScKIYnzBW2llfdy/u06bY+ccDnVrSL1Mr2NGxttFaQNeCoPElZPyHfPs2hm/5m3HvQAKTkgTryiau06dlw/pVQtFJs1AiqAOGDNWTjhiGQY0HPKdzC4IcRwFIsU2kd9pcvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770841; c=relaxed/simple;
	bh=vkD2c6YOu/3PLLtPJN8BZ4sJ1EZR5ZziaUiEsoLiRHo=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=mzPYsHQPKWRvUcLHhl1FqD7ZJmFyoyxWisYaaCXp3XVUx9BNlCOXMPdCmqK4H34s7Ansob9s4Iz+vCrLrMeaiMPbu2eEH5ADD28ep6ixDSMjT6mLKcIKsZAoe/NPUA2ly/qCmLVvS2Wpeq/0DASd57GaisqoxU1yMYwgxtt+zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoAASRy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE18FC433C7;
	Mon, 18 Mar 2024 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710770841;
	bh=vkD2c6YOu/3PLLtPJN8BZ4sJ1EZR5ZziaUiEsoLiRHo=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=UoAASRy49t4fYNk5zt4y3ZniIxzKKiwzxdCQE4wzQnV649Zwua5izMsVO/rVMbngB
	 KMMX/zmbd1oJMn7AQRMeeX/sMIMN163l/RUwVVwT7LLkBwQXfG3Bf5EFSgDM869Z5q
	 J1fqus1YFKq0OnTNxkIQj7VziN2+7BBOLm1iOgkkZbVaUSSeD9L7vO4LXAtM/2hBo6
	 K/JUc5lAA48VTB3Mu3GzGzyZ5JFRzPCHv73prUmPeRNyPxLhAzmjy9SlQs44qv/WTZ
	 KPpAJlD2d1JzKY3hJy6BNiSjR7FNu0Y90a+huEiqI9LHf2I8zW5VGhzEG//MGA6TmB
	 1XPARtvsjEiVQ==
Content-Type: multipart/signed;
 boundary=8ac9ce41e26f4cabb23549944e22bfa9a25961dadc257ee5a3e92aa37b29;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 18 Mar 2024 15:07:13 +0100
Message-Id: <CZWXNB1U9VWE.G9CWTCUO3ZY3@kernel.org>
To: "Aapo Vienamo" <aapo.vienamo@linux.intel.com>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mtd: core: Don't fail mtd_otp_nvmem_add() if OTP
 is unsupported
Cc: <mika.westerberg@linux.intel.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240313173425.1325790-1-aapo.vienamo@linux.intel.com>
 <20240313173425.1325790-3-aapo.vienamo@linux.intel.com>
In-Reply-To: <20240313173425.1325790-3-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8ac9ce41e26f4cabb23549944e22bfa9a25961dadc257ee5a3e92aa37b29
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Mar 13, 2024 at 6:34 PM CET, Aapo Vienamo wrote:
> Handle the case where -EOPNOTSUPP is returned from OTP driver.
>
> This addresses an issue that occurs with the Intel SPI flash controller,
> which has a limited supported opcode set. Whilst the OTP functionality
> is not available due to this restriction, other parts of the MTD
> functionality of the device are intact. This change allows the driver
> to gracefully handle the restriction by allowing the supported
> functionality to remain available instead of failing the probe
> altogether.
>
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--8ac9ce41e26f4cabb23549944e22bfa9a25961dadc257ee5a3e92aa37b29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZfhKkRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvs0YQEAsYw1iglE8VFvcu5bjOkVo5oFjG2qb2Jo
lbITqsfqxfoA/iYKuEvmeC+oVqLKwTwaumonvnWI4F8TpREztajbvYoD
=uszn
-----END PGP SIGNATURE-----

--8ac9ce41e26f4cabb23549944e22bfa9a25961dadc257ee5a3e92aa37b29--


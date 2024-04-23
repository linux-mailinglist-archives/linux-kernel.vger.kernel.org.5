Return-Path: <linux-kernel+bounces-155493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2698AEB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63D9B2147A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0BE13CA83;
	Tue, 23 Apr 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYgWBV7m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A513C9C5;
	Tue, 23 Apr 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886897; cv=none; b=Fp6A93MiemDu3LLd/I9L6zq+WHQIpzEfWhNOP5pkZbujLCIGWhfNYfJ08q/aGhb/HiFwmTmleF5xJ0KqeqRgzUHMOe7/0JiHolOaKmo+F8CEEwdrNAm0vlwzIoBPXtLw5PqmeRcFGoKl9Tt22TgoNx5Is8XzD28e3CfiHL6StIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886897; c=relaxed/simple;
	bh=OnUR5ZTH3ib/xsiRvY5RaBExyt2bYFtPkTTCfjWrMAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKY8t6vgnbxQfYl4jGs2i7AWD/xmIKcNqNxhFeA+XPysub+53eh3A7Vr8MR3qYjYOTuiU/M3EsdtJMpjQKL/ekCZQNDal2D6Rl+3YA4z4ZMAKYVwZPXCqxPcCrN7E3Z0XnrCvy/yG7SONbh4qowJy/lGilOKorW14gzZsfdMJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYgWBV7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F4CC2BD11;
	Tue, 23 Apr 2024 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713886896;
	bh=OnUR5ZTH3ib/xsiRvY5RaBExyt2bYFtPkTTCfjWrMAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYgWBV7mbHOz6IiEf/2oGVM6dOLAgUp95qKZ0FXThv43HZCaYurXUVuPfVQUToy+x
	 2D2NaLmd9J89DDEG8FBvHbcfvkwrJFTOO7YOR77PFIK7TArlllgIDJZ+VZLssU1V14
	 tAQ7LZo6K9JtlbbvrsQX/5C0WoP5jkp0NCcFzaQ6b/pGo5ajDuth1v59215DDn0X0T
	 UDuPLNjZsO0BwD/E4/Lplv3A314naJzdIZLcijPYFJ8xVsqybuuEfZokHoO0Yzapql
	 g3d7ys4Ys81dCRsYyXeTPLEHU/Hwq/BQFKAMaEyYqxkEM1hh/5qgr3hWgHYVGb2g5b
	 moHrTFuM1+NKQ==
Date: Tue, 23 Apr 2024 16:41:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	leyfoon.tan@starfivetech.com, jeeheng.sia@starfivetech.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: cache: Add docs for StarFive
 Starlink cache controller
Message-ID: <20240423-depravity-premium-b7ff778014f4@spud>
References: <20240423072639.143450-1-joshua.yeong@starfivetech.com>
 <20240423072639.143450-3-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dQ3vim3zqT9txeSW"
Content-Disposition: inline
In-Reply-To: <20240423072639.143450-3-joshua.yeong@starfivetech.com>


--dQ3vim3zqT9txeSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 03:26:39PM +0800, Joshua Yeong wrote:
> Add DT binding documentation used by StarFive's
> JH8100 SoC Starlink cache controller.
>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Other than Rob's bot's report, this looks alight to me.

--dQ3vim3zqT9txeSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZifWrAAKCRB4tDGHoIJi
0l5CAQDJLOQk3+8wxytgri/eE0jyCXIMubVtypxaKKSI8743DAD8C9SYRFeHe69e
JpFhPVut94uUmk15b1Kznlz61Lpd5QM=
=5LcH
-----END PGP SIGNATURE-----

--dQ3vim3zqT9txeSW--


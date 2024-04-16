Return-Path: <linux-kernel+bounces-147296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AC8A7220
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3410283707
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E93E132C16;
	Tue, 16 Apr 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCfp/0c4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DF85644;
	Tue, 16 Apr 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288009; cv=none; b=b6e3ilkRI1MQK9jC8Q0tYzqCpZG+NTPG9ztjKf/42R5FSswaBtOBrbpWyu7MfYk/NmuTeo9/+gGwDZIIefWvWRxR7tL9Z3Yn5qodKN8IIB4z/30Xh3IhC48G57WnCWDQGC0spOy7RWdk+69/9EXIHCY+0r5LTzvvmP9nNTCIpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288009; c=relaxed/simple;
	bh=TUCkqN0bChrT+YYSF+EDgSuiAXDlMj7cvKsODOUIbtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWRK9dL5P/vL3mI1eSuWwJNxdDe+2iM05dVgRYh6RXFdt0LUdY6azU+eAWKO45cHpynw3CQQ78wUbV245jPC0mIWvqgAc97RPWhCmKGXMdU9RXlRP8BabNv44OGPi+tjnvyD3LbgdZRf5LFeQemC/uo4Bdf23Iacsp6IWmyqVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCfp/0c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0320EC32786;
	Tue, 16 Apr 2024 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713288009;
	bh=TUCkqN0bChrT+YYSF+EDgSuiAXDlMj7cvKsODOUIbtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCfp/0c4r/WzQkgsOXxcD/afl8MTNXULv4RNm+UpSReLW6Fy2UZKya3JVZ2cWz2Vw
	 blYAfeg1Fu5/yeu7N8OUfaZGUEvIC6n/U7vxMonqosKjj7SSULbI4hTl65J8DnfzFn
	 8A3kFwT5aEm6PqZamlQ37Rwjo/5uLPNtg2PRdfa/FwgoFOWoB522RTyYqZRQANzQHa
	 G9ymPIQVCj4ALhwwvH8WkefTrsw41g3PKOti6BeZLdDVCro3W6GfEhnR5wbtQGq3rE
	 6go2nAwATvrArRMdRgsSYVUkgRcxAy2RbvhKlvELXXurnDIp1iTE6IfA58DFsyXwMt
	 IIAL54lqFSXgg==
Date: Tue, 16 Apr 2024 18:20:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	sfr@canb.auug.org.au, weizhao.ouyang@arm.com
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Message-ID: <20240416-choosing-boney-33cf206d0f38@spud>
References: <20240415170737.49350-1-liujianfeng1994@gmail.com>
 <20240415170737.49350-2-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fr3SbvJt7CACZ2ne"
Content-Disposition: inline
In-Reply-To: <20240415170737.49350-2-liujianfeng1994@gmail.com>


--fr3SbvJt7CACZ2ne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 01:07:35AM +0800, Jianfeng Liu wrote:
> Add vendor prefix for ArmSoM (https://www.armsom.org)
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--fr3SbvJt7CACZ2ne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6zRAAKCRB4tDGHoIJi
0umEAP99gkT0sllsGmn8w34osIi1pdK7bYfr6U/5X2qd/48iTAEAssUl628UBsIw
DgC7KeqMihgHfv7FLDjLr/gFuAUkLAE=
=CeOr
-----END PGP SIGNATURE-----

--fr3SbvJt7CACZ2ne--


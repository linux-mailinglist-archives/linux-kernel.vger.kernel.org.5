Return-Path: <linux-kernel+bounces-145518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AAF8A574F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34582B23519
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD183A0D;
	Mon, 15 Apr 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY8VYQg/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E882891;
	Mon, 15 Apr 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197542; cv=none; b=V0hXWC914ILhnBsJN1pnVl1JYO2zWkvGDxVuWUpC9e1CQQQoCFZvSNWeKJNcbBkFT62ttMRqMY1R+leWYINzBbmJl+2s0CMBDwSRwSAfoheMYVTCczItKxYH1lorvko9zH+uWcvTbM6l+oNHe8KH7TH46B7B4KyFWatlvvQvfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197542; c=relaxed/simple;
	bh=lf/eRIj/5j8u//ixELV2WwrUVkIcFMU4DZBF09ROLs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUc4bM3nQ53J+PkbWsXYlN01yxzZZcK66mY+0x/+Y7MOhc4lgRx9lX+p6NJooQOTwP4WVvi+eYY6zMF6rQE3DFDuCSULbtFPMdi9Xx+6FOjqslnTarU/v4TYL0CNeG1cdK804JxsDjSK+q3amf/NSdhEyG1v4QRMFQrFwJ2LPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY8VYQg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F5DC113CC;
	Mon, 15 Apr 2024 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197542;
	bh=lf/eRIj/5j8u//ixELV2WwrUVkIcFMU4DZBF09ROLs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY8VYQg/kDNpT3Ypyl8UjW7PsG4RSdEPOB6e3kuF2CNnSRuRavvwKX6f6RSqwoQ9b
	 1HpcQ+crapieVK1m6Mj4P1xFow5OxmtSXkhNVWYYoENy+R9l2uTz8A4zGY+MnqA4w/
	 l+0v5f+bymKN5I30nFS14A9YNgqxkH/IZXupSnyV/08Eawydb27eqtCQ5ADpvuRDjJ
	 Rb5RYbes+mITOi+GjZwmWsvHlUqsFxq1+wCnToKsyRruUuy76FdQUySHmbNfcUeqK6
	 QMGib7Xdse50YxBeKbcUtyq4EStoqGHUfzDGrAQikpu+KTz6nbmIb+Bdg6QdxOvSEK
	 IRK4ia7EuCYKQ==
Date: Mon, 15 Apr 2024 17:12:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
	airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, markyao0591@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: display: add #sound-dai-cells
 property to rockchip dw hdmi
Message-ID: <20240415-even-credible-385b03941c85@spud>
References: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AEo7oWbtHZPZ4TpT"
Content-Disposition: inline
In-Reply-To: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>


--AEo7oWbtHZPZ4TpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 05:38:05PM +0200, Johan Jonker wrote:
> The Rockchip DWC HDMI TX Encoder can take one I2S input and transmit it
> over the HDMI output. Add #sound-dai-cells (=3D 0) to the binding for it.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Please send cover letters for multi-patch series, for all 3:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Chees,
Conor.

--AEo7oWbtHZPZ4TpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1R4AAKCRB4tDGHoIJi
0rvCAP9DMAtQlMI0B9a808d60hETrodKbxFqTBwuNCFIwujrSAEAuM+sNixMih38
zXZd/R0HJhwIqi6+r0qVmT4pKU4+DQg=
=qORJ
-----END PGP SIGNATURE-----

--AEo7oWbtHZPZ4TpT--


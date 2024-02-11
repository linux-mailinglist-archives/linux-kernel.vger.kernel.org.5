Return-Path: <linux-kernel+bounces-60884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96E850A94
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C604B1F225C7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1E5CDF0;
	Sun, 11 Feb 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9A+XE6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3959162;
	Sun, 11 Feb 2024 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673064; cv=none; b=bpR3zv8Mmfyg7cLbzVSRLTUawzyGo6EaIMTwlo/gJpyrks82y7e53wKpcOHKVpVX2rVauuVpLY4+BpOnCkMEhEL6rClXcPqITXM+3TP9TIjEG2PIb3qyTh/aVWL5VskufKunYtUCc3PCnw4bpp8zeXeqU41sGu+jtSGvW9lUr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673064; c=relaxed/simple;
	bh=BijN319EfGu1m7rRC+51kCR4T/74PRX271dOSyQJYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toEDkYcW88/CH+jTV1EaxuyIviLAA9DN/9OoF7U9zo71b2Q/2TMSkyjeO7+eFpa1+toJD+Jmg5qG88tX41w+7XMrSDQNtCy1+NTazTIATxApEcXo2DAnRXNJV6s0npycEm/NPWieK/dPdNZ7/w8x9pkfPLtnuUa74BmkRbT0ojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9A+XE6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C188C433F1;
	Sun, 11 Feb 2024 17:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673064;
	bh=BijN319EfGu1m7rRC+51kCR4T/74PRX271dOSyQJYhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9A+XE6lES5hKk+F3fn3pYuI6AY/xg3hPJ6Ns5ScX/IijSTFqGmkynlnFJti6mD6d
	 quwTSxxSmCCHsRJg5thWUiia/zv7GEizi8S6RomkPPcikLmsaKQfei96juPMfx/wMh
	 hD6F+DCB3BTEKzM2eGHeA8gD0ZVxN6LXGRLKuKIfTaf/7QVf/b4kmMLAvVA3XgYxNN
	 ABjqIfmu3a+wOV9lQNNRQsSLMpFha1r8W8G3OoZnafF1h8a5HUKat85YLHVrqnUXe3
	 XHUlipFsgUHAkgB5jWgXHxb0Hvun2xfa07RVWFD4nvW0TFzi+e3KAd9iyOf3+cQW5v
	 UYIvUgU5aLVKw==
Date: Sun, 11 Feb 2024 17:37:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 02/10] dt-bindings: soc: rockchip: add rk3588 USB3
 syscon
Message-ID: <20240211-blubber-ferocity-76ff9fdec828@spud>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
 <20240209181831.104687-3-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EMH7lUpdQh5I6JHK"
Content-Disposition: inline
In-Reply-To: <20240209181831.104687-3-sebastian.reichel@collabora.com>


--EMH7lUpdQh5I6JHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 07:17:18PM +0100, Sebastian Reichel wrote:
> RK3588 USB3 support requires the GRF for USB and USBDP PHY.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--EMH7lUpdQh5I6JHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZckF4wAKCRB4tDGHoIJi
0n0/APwIxasmdK65sg2KgHpBPYsg7Ng3l+Y4gFUzUAzKQQEptgEAhKHKw/+QY4Ts
ipZKAWfKJ3ZwP/Y0gg0rF7P+3yFJeAk=
=Rj83
-----END PGP SIGNATURE-----

--EMH7lUpdQh5I6JHK--


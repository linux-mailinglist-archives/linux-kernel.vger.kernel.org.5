Return-Path: <linux-kernel+bounces-98550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F3877BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A191F21A86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320F412B7E;
	Mon, 11 Mar 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeZgrurt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C711C92;
	Mon, 11 Mar 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146698; cv=none; b=UVPneohNXpZiHtM2bHFCg9Yp2BbTIOzymqDV4CVWFJuy01sz2xUZ8YJK49Jo2+MSWtstwTLaazLi0O4zEgfzaEw6BdKVgA0vim7nVPCuhimGtBLtyUNNv47oXuITdILf7buoUJzHswSR6NhVPY1oeTDWh1idlHXguKekMCZyZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146698; c=relaxed/simple;
	bh=JZieu3zU1s4uVfTI4Zgzi+WlM1F7Ie9p1d0FIqjXRiM=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=AWp6TOPRP58bo71ss8GV3dX1q7wacziAqr/KidaEdYDOVBUuQVbFgxO6msJXKgzPOt6J2aLL2l/cv8MeqSp8wLSwf9P54is818N8CnDstWdWSAoFIicFL50REzJ4vF73KrVYxQeOLsfYvo97U/cVnEaKFokmif+d/f7MAaNVMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeZgrurt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B7BC433F1;
	Mon, 11 Mar 2024 08:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710146697;
	bh=JZieu3zU1s4uVfTI4Zgzi+WlM1F7Ie9p1d0FIqjXRiM=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=LeZgrurtAo7JrdGrtriPGahn3+EwF9D5tkRERDVUbBZT5H6+Yo8LTDZrNVkhu467U
	 ykHgsNjHJsPg9lO+YNLDbw2PaWEZeb1S0BqZ94lpcemTbdthHbs1kTktCJTMvBsI/5
	 dL9mcoKhvN354OKZaoJ46P9sU59p1Jy1+NOsZ8uZtU77mEmKq/tRzcunIri3e7afE5
	 n2QVReGPsX3a2pbxLbuteTwNFKRTm4EC+YPJLjx0g+yig+OzYbxOR996UISrK9DoS5
	 RNznzAd+NmQQ0XK9HfF5S7hPgm5NhdgEA4HcmCuypGq3W2BITYLdmJtIPCbOvqeiNy
	 YBWG5Xj+rMl/Q==
Content-Type: multipart/signed;
 boundary=86841d8504dafca0128a03728b2bfca24996893b0da9c247055c8de47cf4;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 11 Mar 2024 09:44:44 +0100
Message-Id: <CZQSEKZ288OL.205CBK4EC7G2J@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200
Cc: <devicetree@vger.kernel.org>, "Sean Wang" <sean.wang@mediatek.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
X-Mailer: aerc 0.16.0
References: <20240221155905.1217340-1-mwalle@kernel.org>
 <20240221155905.1217340-2-mwalle@kernel.org>
In-Reply-To: <20240221155905.1217340-2-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--86841d8504dafca0128a03728b2bfca24996893b0da9c247055c8de47cf4
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Feb 21, 2024 at 4:59 PM CET, Michael Walle wrote:
> Add basic support for the Kontron 3.5" single board computer featuring a
> Mediatek i1200 SoC (MT8395/MT8195).
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Any feedback on this? Should I repost after the merge window or is
it fine as it is for now?

-michael

> ---
> v3:
> - add vsys regulator
> - correct the LDO input of the mt6360 regulator
> - add missing interrupt-cells
> - no underscores in node names
> - dropped regulator-compatible everywhere and use the correc node name
>   instead
> - reordered mmc0 properties
> - split mmc1 pinctrl properties, add no-mmc
> - removed all MTK_DRIVE_8mA
> - add i2c0 and i2c1
> - add comments for spi and i2c busses
> - add firmware-name property for scp (this should probably go into the
>   base dtsi?!)
> - add missing tpm compatible
> - renamed thermal zones to something more meaningful
> - add correct bias-pull-up to (some) i2c busses
> - moved reset handling into the PHY node, also added a compatible string
>   for the PHY.
>
> Mh, my memory is hazy, but IIRC I run into the same problem which was
> discussed on netdev some time ago. That is, the PHY driver cannot be
> probed unless it is taken out of reset. Which will only happen if you
> probe it. And the workaround/advise was to use the compatible string in
> that case, which is unfortunate.
> Just wanted to point out, that it is *not* the same as snps,reset-*
> because the latter will work just fine without the compatible. I'll
> go with the compatible for now.
>
> I did *not* add the vbus to the USB ports, not even on the front port.
> That is because of:
>   dependencies:
>     connector: [ usb-role-switch ]
> and we just have a simple USB3.2 USB-A connector, no dual roles. IMHO
> that is a bug in the driver, which should handle the vbus supply as
> optional.
>
> v2:
> - none

--86841d8504dafca0128a03728b2bfca24996893b0da9c247055c8de47cf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZe7EfBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvuK8QD/UWncUk5POfZLlmd3CHTLcee2U3Na43dg
L/gT99njMMsA/0NaR+3lRjSoxExN2TN5WFbjChnjUOGtaN5B5CkV2VoL
=KYjX
-----END PGP SIGNATURE-----

--86841d8504dafca0128a03728b2bfca24996893b0da9c247055c8de47cf4--


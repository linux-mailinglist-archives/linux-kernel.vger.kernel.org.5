Return-Path: <linux-kernel+bounces-103318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B287BDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CB2B21AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0366EB4B;
	Thu, 14 Mar 2024 13:49:32 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1F433AD;
	Thu, 14 Mar 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424172; cv=none; b=nOlZgfHkLL/k80kSYve9/C2x3hgckuAdne28sWwgjEv144sweDH4bgoNMz2YP9V1gL4AkWWvhkZ3Ou9ylVd5xDjQmgrNiBGUc6RDQqKKSj0ICzBGJBGOoKhjsgrXEpxaasClmeK0Axf4cPfH7jWKXvukasuPSgfBvRuMUJTP7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424172; c=relaxed/simple;
	bh=L6fYLI0ju8HAJIcXgB4+WM7nTJhvpjxHbwCwpgmyIpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heornmU9UN6UAyCjs1CPbEpKW7aBbAWTJyBdspKETNp12Ioqmai8Jz3rx+LJ/rGZta094k6gZF+fpMkztDOvHY9RYf9cTNzOwp8uH1A/0c1lTrioHsC9cMkiBBgjZYLkgtmq1eZ9r+QLjHwRCPXVCJHksVhJSn8+7l7ouMaeJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rklSU-00048K-FK; Thu, 14 Mar 2024 14:49:22 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f
Date: Thu, 14 Mar 2024 14:49:21 +0100
Message-ID: <48986334.fMDQidcC6G@diego>
In-Reply-To: <3eb63e39-c7f2-4411-bb84-e4c152be1f0c@arinc9.com>
References:
 <20240314-for-rockchip-mt7531-phy-address-v1-1-743b5873358f@arinc9.com>
 <4682635.taCxCBeP46@diego> <3eb63e39-c7f2-4411-bb84-e4c152be1f0c@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hey,

Am Donnerstag, 14. M=C3=A4rz 2024, 13:37:19 CET schrieb Ar=C4=B1n=C3=A7 =C3=
=9CNAL:
> Hello Heiko.
>=20
> On 14.03.2024 15:31, Heiko St=C3=BCbner wrote:
> > Am Donnerstag, 14. M=C3=A4rz 2024, 13:24:35 CET schrieb Ar=C4=B1n=C3=A7=
 =C3=9CNAL via B4 Relay:
> >> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>
> >> The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got=
 two
> >> findings that support this. There's no bootstrapping option to change =
the
> >> PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
> >> address of the switch. So the reg property on the device tree is curre=
ntly
> >> ignored by the Linux driver.
> >>
> >> Therefore, describe the correct PHY address on Banana Pi BPI-R2 Pro th=
at
> >> has this switch.
> >>
> >> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >=20
> > Fixes: c1804463e5c6 ("arm64: dts: rockchip: Add mt7531 dsa node to BPI-=
R2-Pro board")
>=20
> Do I need to resubmit with this added, or would you add it while applying
> the patch?

nope, all good. b4 am should just pick up this trailer when it downloads
the patch from lore.kernel.org.

That's the reason I added it as a reply, as we're just in the middle of the
merge window right now.

Heiko




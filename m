Return-Path: <linux-kernel+bounces-119815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886C88CD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3AB1C6211C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046713D24E;
	Tue, 26 Mar 2024 19:33:54 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C894380;
	Tue, 26 Mar 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481634; cv=none; b=BLM0wj9iTfiWNvDhBDgtOYXS8+LcbejldK3l3k8HzoDWNcLM8Jm6lOu24MU8agYmeynCegeo0rsxxDJ9Fg/KptTgLOBU9FLs0cRoyr8/5Zh0BEF1gP7/c+r4SvlXoPL28XBiv9RqAfiMxIqqy7hEfn6o2SoduPDO5LXxRqqIhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481634; c=relaxed/simple;
	bh=r8LUNgZ43DVe/TijpV7enqwPpranuYoML63Rx2D6B9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=felkTXoGM/xeJ9jyd4UUePEm52M67CaF3YM5jdJHR7EKXVh+kxN3vRGjQcwFzyShe7UeyGK/Ze6pA/hbisEsd6YiRT4kJXjRn5xHrDnaVtdmSTT2Bnsj1ooBzg23WmLmJEMcVlQ6/rOaWMA1jKMI3T7GTdz4UtQMoLN57Z1uSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rpCYM-00076I-Oh; Tue, 26 Mar 2024 20:33:46 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Riesch <michael.riesch@wolfvision.net>,
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: add wolfvision pf5 mainboard
Date: Tue, 26 Mar 2024 20:33:45 +0100
Message-ID: <2672576.Isy0gbHreE@diego>
In-Reply-To: <171148006579.3222626.4177463381080253015.robh@kernel.org>
References:
 <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
 <171148006579.3222626.4177463381080253015.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 26. M=E4rz 2024, 20:11:58 CET schrieb Rob Herring:
>=20
> On Mon, 25 Mar 2024 15:22:30 +0100, Michael Riesch wrote:
> > Habidere,
> >=20
> > This series adds the device tree for the WolfVision PF5 mainboard, which
> > serves as base for recent WolfVision products. It features the Rockchip
> > RK3568 and can be extended with several different extension boards.
> >=20
> > The WolfVision PF5 IO Expander is one example of such an extension boar=
d.
> > The corresponding device tree overlay is also included in this series.
> >=20
> > May this be the beginning of a beautiful friendship :-)
> >=20
> > Looking forward to your comments!
> >=20
> > Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> > ---
> > Michael Riesch (4):
> >       dt-bindings: add wolfvision vendor prefix
> >       dt-bindings: arm: rockchip: add wolfvision pf5 mainboard
> >       arm64: dts: rockchip: add wolfvision pf5 mainboard
> >       arm64: dts: rockchip: add wolfvision pf5 io expander board
> >=20
> >  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
> >  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
> >  arch/arm64/boot/dts/rockchip/Makefile              |   2 +
> >  .../rk3568-wolfvision-pf5-io-expander.dtso         | 137 ++++++
> >  .../boot/dts/rockchip/rk3568-wolfvision-pf5.dts    | 528 +++++++++++++=
++++++++
> >  5 files changed, 674 insertions(+)
> > ---
> > base-commit: 4cece764965020c22cff7665b18a012006359095
> > change-id: 20240325-feature-wolfvision-pf5-5c1924c0389c
> >=20
> > Best regards,
> > --
> > Michael Riesch <michael.riesch@wolfvision.net>
> >=20
> >=20
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy rockchip/rk3568-wolfvision-pf5.=
dtb' for 20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net:
>=20
> arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dtb: hdmi@fe0a0000: Un=
evaluated properties are not allowed ('#sound-dai-cells' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip=
,dw-hdmi.yaml#

just for the record, this is not the fault of the Wolfvision board,
but caused by an undocumented property in the core hdmi node.

I've prepared a fix for the binding in [0], but as Krzysztof noted,
this patch needs a v2 with a change.


Heiko



[0] https://lore.kernel.org/dri-devel/20240326172801.1163200-1-heiko@sntech=
=2Ede/




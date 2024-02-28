Return-Path: <linux-kernel+bounces-85149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843E86B121
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B7228B1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0BD155A4D;
	Wed, 28 Feb 2024 14:01:26 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73041534F4;
	Wed, 28 Feb 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128886; cv=none; b=JROyJbOLhrBzwHpSDsT4pJCuET6m9GvMGZj4gmxvZ0/jRf1Evs8lJuEhjyVzgYEn02L0fi5DZaEkA77CNu1Ri26Ms2AoFaQ/xt1rV2ry8UrCFTDkAEIQ4K0xf4Q60oLlyRv0q2+YQ2/vTxuXYd81w21579/TYklPrE4XvsQWK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128886; c=relaxed/simple;
	bh=tSKzid4IxfCZZxDJBYvKiqvF95mPC/D3udyhhI0ajds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i06xpnvkJwgz6p0KS4JRMsygLeb41XGgCvxMRgxixEpnuXsaFtwT2wtUBzYg7wXcQ6W8ZXUHspomQcwHZ4yU6nSuiPa7Tcpo/5XG/eurbZwiF4sGgzWXhi2Riv3QfBL+9FrnDruiSojk9wsBMl17gIhAImGJJ2f9nC88jpLHH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rfKUm-0002j4-9z; Wed, 28 Feb 2024 15:01:16 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Cc: conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, quentin.schulz@theobroma-systems.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] Add support for Theobroma-Systems Tiger SoM
Date: Wed, 28 Feb 2024 15:01:15 +0100
Message-ID: <7842578.gsGJI6kyIV@diego>
In-Reply-To: <170912782011.3288301.9840425544379703699.robh@kernel.org>
References:
 <20240227164659.705271-1-heiko@sntech.de>
 <170912782011.3288301.9840425544379703699.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 28. Februar 2024, 14:46:16 CET schrieb Rob Herring:
> 
> On Tue, 27 Feb 2024 17:46:55 +0100, Heiko Stuebner wrote:
> > This adds support for the rk3588-based Tiger system-on-module from
> > Theobroma Systems and includes support for the combination with
> > the Haikou-baseboard.
> > 
> > Included is also a fix for the rk3588's i2s nodes to remove a
> > yet-unsupported devicetree property that slipped in.
> > 
> > 
> > Heiko Stuebner (4):
> >   arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
> >   dt-bindings: arm: rockchip: Add Theobroma-Systems RK3588 Q7 with
> >     baseboard
> >   arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM
> >   arm64: dts: rockchip: add Haikou baseboard with RK3588-Q7 SoM
> > 
> >  .../devicetree/bindings/arm/rockchip.yaml     |   6 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 266 +++++++
> >  .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 691 ++++++++++++++++++
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |   2 -
> >  5 files changed, 964 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
> > 
> > --
> > 2.39.2
> > 
> > 
> > 
> 
> 
> My bot found new DT warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y rockchip/rk3588-tiger-haikou.dtb' for 20240227164659.705271-1-heiko@sntech.de:
> 
> arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: syscon@fd5a8000: 'clocks' is a required property
> 	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
> 


for the record, this is fixed by
https://lore.kernel.org/linux-rockchip/20240227210521.724754-1-heiko@sntech.de

which I applied earlier today.


Heiko




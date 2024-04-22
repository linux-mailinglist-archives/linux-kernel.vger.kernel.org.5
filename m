Return-Path: <linux-kernel+bounces-152977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD28AC702
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4C11C20EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B572A1D5;
	Mon, 22 Apr 2024 08:30:41 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D8205E0E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774641; cv=none; b=rRoH/W43EcGoPO4HYdqX7/1ADGNkVOwofhln+SJLJxt2MbwVMJUqB6UnF4da1+KXTbXaVsPuGkqjb/pXVE8WsZCqbuUeV6Dxf2zM/c3GSVPnnPcYnvEdzV5+NXoqwu9baupHTVKue5Ja2UHAR3TL4AoVwptSzc8DDUP3FQ7kEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774641; c=relaxed/simple;
	bh=EK+dqgsbNtopGk47Jcbq9GlupmjarL1gVr2btr6y34s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmdAjcSEcPzuPnxT66AOmQ6rPSW5v2m5ucIGHzFDRGtEQb0VCdjHbDdFR2CatlCf/7Gz8UuV7OaZ8y2Odfvpb5x7hNI1YICJXg28HlgxvxpH/S7dEypXR6J5AWH7tU5P3aYD3PSTKBsV8kpH4SsuaLHLpzOqguEvyTpZfy1m0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d85.versanet.de ([94.134.29.133] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ryp4H-0000f8-Cv; Mon, 22 Apr 2024 10:30:29 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, quentin.schulz@theobroma-systems.com
Subject:
 Re: [PATCH 0/2] Add support for the dual-role dwc3 controllers on
 rk3588-tiger
Date: Mon, 22 Apr 2024 09:43:12 +0200
Message-ID: <2108948.KlZ2vcFHjT@diego>
In-Reply-To: <171356537191.48026.7238978785873260892.robh@kernel.org>
References:
 <20240418210332.2394871-1-heiko@sntech.de>
 <171356537191.48026.7238978785873260892.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Rob,

Am Samstag, 20. April 2024, 00:24:23 CEST schrieb Rob Herring:
> On Thu, 18 Apr 2024 23:03:30 +0200, Heiko Stuebner wrote:
> > A comment fix and then the addition of the nodes for the dwc3 controllers
> > using the newly merged usbdp phys.
> > 
> > Heiko Stuebner (2):
> >   arm64: dts: rockchip: fix comment for upper usb3 port
> >   arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou
> > 
> >  .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 60 ++++++++++++++++++-
> >  .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 15 +++++
> >  2 files changed, 74 insertions(+), 1 deletion(-)
> > 
> > --
> > 2.39.2
> > 
> > 
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y rockchip/rk3588-tiger-haikou.dtb' for 20240418210332.2394871-1-heiko@sntech.de:
> 
> arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: /extcon-usb3: failed to match any schema with compatible: ['linux,extcon-usb-gpio']

This follows the txt-binding from
	https://www.kernel.org/doc/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
so in mainline there is no yaml binding yet for the usb-id-extcon.

Though I did find a still pending yaml conversion for it in
	https://lore.kernel.org/linux-arm-kernel/20240215093214.796821-1-alexander.stein@ew.tq-group.com/T/

Though not sure what the holdup is there as it got a Review from you?
Can you just pick this for the main dt-tree?


Heiko




Return-Path: <linux-kernel+bounces-32640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E0835E59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AA01F23B00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8BF39AE1;
	Mon, 22 Jan 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Hs4z2Ktl"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185421EEFC;
	Mon, 22 Jan 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916354; cv=none; b=mTfTYghRn0TASIriZzUBj5WHsI56jFFQjOGwzh6BE7mUJSBKDsXXJqCeo9zMCBsoPXXMbi/sFOx5dpoEzX1iO9Ohsnh6/NvazdgeUuQPd0YEt/WaCjdpy5uu6aSFb5wdG9gt99wtOx8MP2/sObZuHzYEk2Q57MIB80ajSwxmQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916354; c=relaxed/simple;
	bh=qcjz7Bt72S5uBFawiaiVG8JWN0F8ODPYKAykAFUyWIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nbI7i3aAGyuUbjlWdeay5fwCqL8N+Ik4b3CJZDKrRsa7rIYS8sLIWZiOrXkoF1yABMQYGaUhHh9r7/V/d1FELccDmkJ15AZuXc1IAqkM287vZAqQhl9u4iq8c5bOs1hqv5lFw90qaXJuTZQXBaYQX3FrDAJJlzyoNw2u08WQ8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=Hs4z2Ktl; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rRqlk-0001PB-SL; Mon, 22 Jan 2024 04:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=qcjz7Bt72S5uBFawiaiVG8JWN0F8ODPYKAykAFUyWIA=; b=Hs4z2KtlU0pQyQfN+0hQ
	kUmomCycE4eTZU8ajWuZJJL5skZsU/s44aKGdV/9lSP9fNw+acnLVIBIgnJrlKYlvjo6GWdmKuxU/
	F5k9fz5gvkHCqE1skav4gQAuB1QZwqirGis7hGN+30i6upXTLL8l9GrDk+kYwMFC7V42PHrlbxFVk
	xHDDxR6/742MxnmT8vN0jOhe/NzoVQY30v3TIuvLhKxL0imW+4zi2CQxQc73mRq9kI4nUwBGsVutD
	KJ2lkly4qNjXXwgttgWNZPN9KfVfxcJDmJ/eNWfcu0vu0R33pX64oufR/n9jqtpV9l1kV3qKZ8Wl6
	nJhj71hxPgC/FA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,  Li Yang
 <leoyang.li@nxp.com>,  Primoz Fiser <primoz.fiser@norik.com>,  Christoph
 Stoidner <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
In-Reply-To: <282689a1-a189-4320-9d70-c6d38dc56d9d@gmx.net> (Stefan Wahren's
	message of "Fri, 19 Jan 2024 11:11:39 +0100")
References: <20240119092835.21462-1-othacehe@gnu.org>
	<20240119092835.21462-3-othacehe@gnu.org>
	<282689a1-a189-4320-9d70-c6d38dc56d9d@gmx.net>
Date: Mon, 22 Jan 2024 10:38:36 +0100
Message-ID: <87jzo1emhv.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello Stefan,

> According to the documentation there are GPIOs accessible. Those on the
> expansion header X16 could be named via gpio-line-name this makes it
> easier to access via libgpiod. Also there seems to be LEDs and switches
> on the phyBOARD.

I will add gpio-line-name for the two accessible GPIOs on X16 that are
not mapped to specific functions. I will also add the heartbeat LED that
is located on the SoM. Regarding the two switches on the phyBOARD, they
reset the CPU and the board so I am not sure that they can have an entry
in the device tree.

Thanks,

Mathieu


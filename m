Return-Path: <linux-kernel+bounces-34843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CAC838836
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4154D28A590
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D585479F;
	Tue, 23 Jan 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="qjObFO0P"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5451C3A;
	Tue, 23 Jan 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995915; cv=none; b=WxDx0KlFdq/wVhnK6r5HUhoRmbo9l4iAAn4DLHdR5RPAqcvXDQ46VtyE1y6hwJ3jl6rk56TOCK+cSe3dNKX7Z3qyeT0EATzGZdFHNdBWieCdV2B9JuN62sjR5R9pECT1y/TMA9X8ZhfjBxWrz0DOesxat4ysHUYgOICEqxHhtyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995915; c=relaxed/simple;
	bh=PeGrflTJjw9tp7NkPQZVRHpEGXG8qAQ0CtAN1+Exswg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rz9vXOzxzYGwBR+XHwcpPf9nWdL1t+WSFBOOp3I5xNMP5oZgHQHrvXGsafQIPVnjzC3REQ0xpIpJPmL6AvqrB/583XOHBup48BNKzxDWvEy81apH+lXI8SvbkmKOm0YWBiJ8M85Dg17cHnKSQo7mWoCTqO0CZrt7b0R/WJBP17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=qjObFO0P; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rSBT2-0002Jp-1r; Tue, 23 Jan 2024 02:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=PeGrflTJjw9tp7NkPQZVRHpEGXG8qAQ0CtAN1+Exswg=; b=qjObFO0PtsJ8h9C+e/R6
	GHMXSONNuwwrprKA57kz8NrOMMUc4bZ+KF+f4KnJTC8VIFbB+bImOBHZ31MDOIZo7UptHZk5goweY
	+WXjwZYaHBIJflhtLmwH8+zNVwu0pAyQDKiVdme8rj8oCu8isFB2NiZcQ0O9btNJgBLSMuQsXaWTj
	NvJFOSCYPbraTCVYpXZs44jalcV1YZmQeKMyD+gGjgtT+oMTLPtukXNRVlCcrcYVHZWSDf8uTU4AD
	pLxahombGLBvqDyi4TdQkDzYPC0/Yn4xWph+i43C2+CuYD3uRZiDI9xw8a6oUF+046/ik7w3YyQc+
	o/AoriYqDj+C0g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,  Li Yang
 <leoyang.li@nxp.com>,  Primoz Fiser <primoz.fiser@norik.com>,  Stefan
 Wahren <wahrenst@gmx.net>,  Christoph Stoidner <c.stoidner@phytec.de>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
In-Reply-To: <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de> (Wadim Egorov's
	message of "Tue, 23 Jan 2024 07:11:27 +0100")
References: <20240122095306.14084-1-othacehe@gnu.org>
	<20240122095306.14084-4-othacehe@gnu.org>
	<537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
Date: Tue, 23 Jan 2024 08:44:55 +0100
Message-ID: <87ttn45w94.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hey Wadim,

> You are doing more than you describing in your changes log.
> Here you are forcing a gpio-only functionality for the X16 header. But the
> pins we route down to the X16 expansion connector can be also used
> differently.
> Typically we provide device tree overlays for different use cases on this
> expansion connectors.

Adding those GPIOs on X16 was a suggestion from Stefan back in v3. I
must say that it is quite convenient as a user to be able to interact
with gpiolib on some GPIOs on the eval board.

Would it be a possibility to change the muxing of those two pins in the
overlays if the need arises?

> Maybe this comment was lost, but I asked to move the dts-v1 tag into the
> carrier board device tree.

Missed that, sorry.

Thanks,

Mathieu


Return-Path: <linux-kernel+bounces-92434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C987201A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5CBB263F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B085C5E;
	Tue,  5 Mar 2024 13:26:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6CE85C51
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645207; cv=none; b=pW2YR83F3BzaBFUpFo3WqIAcuD74N9quGt4QwbgX16f4XA37Dw0226RhmnsePJeHDBrLD8HChsbXiDy5DneEGT/Rgq/2StQ2ft/5JhNwy4gwt9ldUW+cJKNvEeD3OxZty9iopgMo5ead9adudemqz1IRtiJxzcW3WsDpplxgQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645207; c=relaxed/simple;
	bh=HzC6DUDdU3tCRfgE5FEHRWz8EqIwGRE0wTGjdVqSu4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LfGE2Kx1Q97tNhtpVeBCxjyJ3Ns9F511s/N4YdjfTKPnKVu0uJVohI590rwZ3HBhQSFmyVWvPoOMXz//ptWjl80LzmaVTMeZIgyay6fTYPqefY2nYf9pLAGAoyF9wn6iKRWo23Zrf7bKN5PxBptX6zNABQiStIvfUng1x/VNDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rhUoI-0004zr-7l; Tue, 05 Mar 2024 14:26:22 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rhUoG-004YsK-CV; Tue, 05 Mar 2024 14:26:20 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rhUoG-000C5R-11;
	Tue, 05 Mar 2024 14:26:20 +0100
Message-ID: <f19eb5bb48898e0c843e936711c2fd3d4c2ee908.camel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] phy: hisilicon: hisi-inno-phy: add support for
 Hi3798MV200 INNO PHY
From: Philipp Zabel <p.zabel@pengutronix.de>
To: forbidden405@outlook.com, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn
 Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, David
 Yang <mmyangfl@gmail.com>
Date: Tue, 05 Mar 2024 14:26:20 +0100
In-Reply-To: <20240305-inno-phy-v4-5-a03204c9cf1c@outlook.com>
References: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
	 <20240305-inno-phy-v4-5-a03204c9cf1c@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-03-05 at 10:19 +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Direct MMIO resgiter access is used by Hi3798MV200. For other models,

See

https://lore.kernel.org/all/4bf4146749abb1500f8a412deb4d61ab0f3c80e6.camel@=
pengutronix.de/

regards
Philipp


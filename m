Return-Path: <linux-kernel+bounces-65108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854AC8547E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EE91F26ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C519199AB;
	Wed, 14 Feb 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H/ThDlXd"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07218EA5;
	Wed, 14 Feb 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909313; cv=none; b=THvoc+DqL6J18USuGBnR425jhF5AWECg3PKQHB9zGtUu/Qf/oIbdKabQl411I0VphlFxMisPlWJPDiIhbVT/4yamHDRfw1HvQ/MB9+3v8eiFCNHguPhD6vef6awOv0eLfgYs0sPFM3uMfyXkrefk1tsAUQzKvMI6PPdEK2rS/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909313; c=relaxed/simple;
	bh=4TJCJS0H9QeGJfNbIzfusY2d/8v1NGh26UGZkAkIDj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2JnqJyVoFrcRsiv8Qb7E7+XGjzSwq+CtyS06XRiihZe7oJyTRaDdKnNluIpP6469MhlqvkLMxGEPz4hOQEHZ2wgzosg/vX8Cc05vZFJcKfHeX2iAzGij+9wt1YKhtNgpRplTPfe5rPtym/XYW2aGlFy0srT6s78d5uldV72a5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H/ThDlXd; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93315240007;
	Wed, 14 Feb 2024 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707909309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xLvZkEWdxA115Gj30wuQmg0zDKAjh3vEwmVlRYZntc=;
	b=H/ThDlXdRx+Bs+Q05JdjQrCCQJwWIgpixQZ+LJCHiWhxKtTt58cCgE6DIUToJkX8+rkYyo
	vZfMkMf3CVZheuUOqT3lsDQUeetFlhOX1X84J1HWkYP3FfLEJ+HwC8xZdI91qPDe2mWRnJ
	OFr2Q+/TVGAh0vSLjboi8wqUpSdYS72LKSJoQGxOl44rSdgC4Uj+VXntfoW1upeJ5XzoLy
	6RsFdQUZDkKBD+/hry2hHrX0/OirjATe3UUAYaaGLS7ToLVYwtNNoIywsFXL8/XsC7J7S1
	vC66GOpTXn4gbfN+D0bgp8lDG5JrzPTokfg87R5Uiwtg8L7Qo7/UDYzzpEBqKw==
Date: Wed, 14 Feb 2024 12:15:05 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team
 <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/6] arm64: dts: imx8mp: add HDMI power-domains
Message-ID: <20240214121505.2aff7e69@booty>
In-Reply-To: <20240210204606.11944-4-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
	<20240210204606.11944-4-aford173@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

On Sat, 10 Feb 2024 14:45:59 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the PGC and HDMI blk-ctrl nodes providing power control for
> HDMI subsystem peripherals.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

[Tested using Avnet MSC SM2S-IMX8PLUS SoM on Avnet MSC SM2-MB-EP1]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


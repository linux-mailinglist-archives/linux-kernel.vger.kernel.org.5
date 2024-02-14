Return-Path: <linux-kernel+bounces-65111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA928547EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F80B1F26E99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7F81BDC3;
	Wed, 14 Feb 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jvUkSjEA"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A61BC53;
	Wed, 14 Feb 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909333; cv=none; b=nxFNUougPuROr6KbT/fRRt8O5Ngu4nZqK3ZFfN8k2whKftYiag2VBkZAEmf0ctQ6UHcGLzw2AEt3rw6x+PG8PDhXzi2DesNorDGHqkHg3TRb8c6PKunySJo9tnHCQDKHWCrLfHV8ZUrTZ8zcMKWHUNwvnk8iHAAZXstj1BKeLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909333; c=relaxed/simple;
	bh=twQDEBtpJAs/vEpHUL6Ae+yl5fCPJ0apPZrITNa4BMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQ5zwVkn/p7GZ5gb5TSNC7acR00udntTSD5U1Ixv3ruyjyInUg6gQUtTc6+5Cx3/tUncZk5Q1w7F6vONh8a+L5kNqx5xQ9vFOm4Fvf03qF1nToKPBbGh/IXrHtOSIA3oVojoWvDwp7aIzIiAkbIrhLnS0xmxscmPCPVYtQBQNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jvUkSjEA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB448FF809;
	Wed, 14 Feb 2024 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707909330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVBBoExIDPIGxFfOdUtokpvWpmMZogOfSCWA93Y4vsg=;
	b=jvUkSjEApoYJjkVAqiGQPhn57zZNnoG5YsyMDQELN0D0DpNC41Vyc4onb9KoMHI5iAo/j6
	4mzuDkfNKETQq5kcMT1aRS4G5psFXEYrp1F4V4IsPSwSFRTAJUMGhZ1gk+nH+a80b/cMI5
	gKjrXwc0X+gKB1HxvWkeFodMPs+UEqr5JRwaxwt8NUhgO9fT03mE5rjkLxubpwmMnomR3h
	uB2IaB5iO45GxAowHFoUyMZUKweYJMKcCWclJT/azzJEhlU9NQBXgtA49Sw6CVQb+Mvt2I
	7qV/dvd8cFeqk9aXiAOp+x3hbF22NQEa8LQSYSlMI5qReSAN3MKnTERPGDfkvg==
Date: Wed, 14 Feb 2024 12:15:26 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 aford@beaconembedded.com, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/6] arm64: defconfig: Enable
 DRM_IMX8MP_DW_HDMI_BRIDGE as module
Message-ID: <20240214121526.384440d1@booty>
In-Reply-To: <20240210204606.11944-7-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
	<20240210204606.11944-7-aford173@gmail.com>
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

On Sat, 10 Feb 2024 14:46:02 -0600
Adam Ford <aford173@gmail.com> wrote:

> The i.MX8M Plus has support for an HDMI transmitter.  The
> video is genereated by lcdif3, routed to the hdmi parallel
> video interface, then fed to a DW HDMI bridge to support
> up to 4K video output.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

[Tested using Avnet MSC SM2S-IMX8PLUS SoM on Avnet MSC SM2-MB-EP1]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


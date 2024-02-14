Return-Path: <linux-kernel+bounces-65110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4C8547EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9151F247C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1C1B964;
	Wed, 14 Feb 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g8H+BXtI"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BF1B95F;
	Wed, 14 Feb 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909329; cv=none; b=q3h7GHNAlcnD9WGCLBxB0jnWvcKG747OIKPPFnPZT6CPmN+F0P6WO043nqUkPDa/M+Wq8Dw2seEWTouyZyeVxqsic7n0lefqVV0l5kDKvs2Um3xF9QjmTDTm2IIfbadD5hSZeTKunJPbRCBEHU7bQbp343s8sKjBjQX8/6b+a1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909329; c=relaxed/simple;
	bh=R3lueT7DRFxtSqDkcvTwfhN6x9tMi39sHGhUsaP/cHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7TyavHam1iKMXtTtF/TFElF92v/EeLFhHPDoMPk6Mhh510kOXsCc7EStZIy5+gNGQDdn4ECG4XUvWbmFSW0n/nWHtTAiSSAfa38PhDO3NoHt8IL8IMldP0rUjFiXnYZaiTebVufAtlAYwP6f4d0JDjx/LDekdtTTaB//chF7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g8H+BXtI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D86D4000F;
	Wed, 14 Feb 2024 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707909325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YLskWpW8KzLQWkWwiaSJ6tOyG1M/XihbyVEveatvXM=;
	b=g8H+BXtIWWIpzUB0OLMzuzyN3do/wpKt+Dw/srTrn4CMwgARzZEXODUH9aUW8sCUaBKg3F
	wbm6Wfkxfyz0xe9q1ghbP+u4m5HumVT9remZ3srxc7qdPOjv/USLU5hzePqIXBkU3F9Ix0
	DGutAllH2Nw1lfxHIDm8hSoIZE1OkeT+0CJ8KQGbGp5+i+4m/nNDQr4moya6ct5icCA1gw
	yzP1dnyBx07n9m/aYRtWPsCpE7hnuXHmFuB2kyLWBUP54MNqlpdTPxoUfV+euywNW0jKJu
	bNaEkAytbd2Li5Vyw8Er2594tSfb+fIORpSVlRXXUYG+BFvIcI4iP33PdK3yqA==
Date: Wed, 14 Feb 2024 12:15:22 +0100
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
Subject: Re: [PATCH V4 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Message-ID: <20240214121522.7c1ed4bf@booty>
In-Reply-To: <20240210204606.11944-6-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
	<20240210204606.11944-6-aford173@gmail.com>
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

On Sat, 10 Feb 2024 14:46:01 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the DT nodes for all the peripherals that make up the
> HDMI display pipeline.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Re-ordered the HDMI parts to properly come after irqstree_hdmi
>      inside AIPS4.  Change size of LCDIF3 and PVI to match TRM sizes
>      of 4KB.
> 
> V2:  I took this from Lucas' original submission with the following:
>      Removed extra clock from HDMI-TX since it is now part of the
>      power domain
>      Added interrupt-parent to PVI
>      Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
>      Added ports to HDMI-tx

[Tested using Avnet MSC SM2S-IMX8PLUS SoM on Avnet MSC SM2-MB-EP1]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-75337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2FB85E6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706C61F254C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9D85950;
	Wed, 21 Feb 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm2Cxvib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576885642;
	Wed, 21 Feb 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541816; cv=none; b=LzPKpzLCO8XWefNDcazTw8LsykL88Lu1Vzuo2Q7UTqoDgbxS+y1UFuhehbIyRT2sCsNVPbCpOvaPdikq7F4QMgJJ4dy3R8DsL8xIAcA9FaMeA0STpHBFdWs2rHHuJMFsVGMV6uktK6TlAWCDuuf1w6qFanM0msX/XOZa9QgZCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541816; c=relaxed/simple;
	bh=x/lhlI51yb6yH2YUoCrdyfz4kHTWX+g1FJ7xY4yHJ5g=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bTzLK5J9CGyaPqTuwhzDXJTlLdBe05a7zVcLl5GyPozJBuVEz8HsGN2AYHO2W+ZFxAiGbNGdGK0TiEscVsh5k/HGiDUZzj+WixFrfukfP1xPXNRxbpsjYXDRVC0pS67IyN98qxxuLCBOsXi2R62jf/tnHL3d8OS13xWpQDtHuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm2Cxvib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B11C43390;
	Wed, 21 Feb 2024 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541815;
	bh=x/lhlI51yb6yH2YUoCrdyfz4kHTWX+g1FJ7xY4yHJ5g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jm2CxvibFpZ4eNyMCS/LTN877w6WRQjclIGZ/aKILm0jFuKJvKVkj0KzszedcwVcn
	 p9Rru7KLs0Gb0yenqLuAC9Napf2tHXYjmFURtlG5AHUbbC6b+A7KyZqYjFTNDIKtu4
	 swrx+vZN9F6eThgd5cgmuUmBasIUpq10KSA/bMsp3nlcJL957n2EGqC8lojq/B2VAM
	 K0zC4GiROBBQpScoqLZ9gekdDmmcvaAX+dQbGj0Tclpr3QILlRy2Kc7idgZeCymwaJ
	 /HqAVZujRkMzHQH2L1Fn+GSAZim058Ot6npcC1GiyMAXCVVeZU/3LillNEW421jq1R
	 SKOngIKnPsN5A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: wilc1000: revert reset line logic flip
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240217-wilc_1000_reset_line-v2-1-b216f433d7d5@bootlin.com>
References: <20240217-wilc_1000_reset_line-v2-1-b216f433d7d5@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 David Mosberger-Tang <davidm@egauge.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170854181192.1918455.14748300319931361175.kvalo@kernel.org>
Date: Wed, 21 Feb 2024 18:56:53 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> This reverts commit fcf690b0b47494df51d214db5c5a714a400b0257.
> 
> When using a wilc1000 chip over a spi bus, users can optionally define a
> reset gpio and a chip enable gpio. The reset line of wilc1000 is active
> low, so to hold the chip in reset, a low (physical) value must be applied.
> 
> The corresponding device tree binding documentation was introduced by
> commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gpios
> properties") and correctly indicates that the reset line is an active-low
> signal. The corresponding driver part, brought by commit ec031ac4792c
> ("wilc1000: Add reset/enable GPIO support to SPI driver") was applying the
> correct logic. But commit fcf690b0b474 ("wifi: wilc1000: use correct
> sequence of RESET for chip Power-UP/Down") eventually flipped this logic
> and started misusing the gpiod APIs, applying an inverted logic when
> powering up/down the chip (for example, setting the reset line to a logic
> "1" during power up, which in fact asserts the reset line when device tree
> describes the reset line as GPIO_ACTIVE_LOW). As a consequence, any
> platform currently using the driver in SPI mode must use a faulty reset
> line description in device tree, or else chip will be maintained in reset
> and will not even allow to bring up the chip.
> 
> Fix reset line usage by inverting back the gpiod APIs usage, setting the
> reset line to the logic value "0" when powering the chip, and the logic
> value "1" when powering off the chip.
> 
> Fixes: fcf690b0b474 ("wifi: wilc1000: use correct sequence of RESET for chip Power-UP/Down")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>

Patch applied to wireless-next.git, thanks.

f3ec64394763 wifi: wilc1000: revert reset line logic flip

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240217-wilc_1000_reset_line-v2-1-b216f433d7d5@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



Return-Path: <linux-kernel+bounces-81204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B516D867309
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86305B359FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEFB55E72;
	Mon, 26 Feb 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TRaofYXQ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E455C3F;
	Mon, 26 Feb 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944305; cv=none; b=oZyehISizpJS4mqNZXGwxOneMdSvsKopSSR5DEGhEQnF16sWhn52Oz8PtR8TaXbVPJxRElBPOMpBgcLw10mMPlHuRtpH1byZt1RBA0ItItacPoe7wXutdYBk4+/Q7IBVC8h4Mz4VO36RCensA/t7fVxz9ZfjN5VPgP0WyMJan2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944305; c=relaxed/simple;
	bh=snSn7ccEbLZ+7kSkKsYvWViDDDORgIjM64c02g9kvwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFH2M28VgcbSycvFnlmBgvBYPiiKft9oYXc7BPVVtZTAA/NUMQ/9sa6pXxA3WKYlmFmdgo48htLOOGu+5sv3uRbJACX7bVfnwioPip569+3a1YNRH/S6vf66sVz3n41ofBLB//ZSFrGW4/zzVizaLMWOM/Vj+3lVifgUoQjOyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TRaofYXQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A7AA60009;
	Mon, 26 Feb 2024 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPexO6DRjAqEh41hFAbTYxuEnPMPjtTxwMJrh7MLMNs=;
	b=TRaofYXQ2zaSq+Ppu6StTVFrg1zN2D0YPWob5XALDQrTurFWqQcigGboAQdnVCPwhZNcqf
	40B1yCw8sqby8K7KbFd2GP7zaYzyOMvi6XbUKGNjiSP/zd21Q9MoM2iIZyQDI7oPipQAcC
	nNppCVoDguyhEZf1As6CmfcvFf/a+OTPpbMPEHrK1yTtZjCnWPX7wZSsi8sWCIU8E46oMz
	1ZnI8InnR/Peru/Jv6fF9PDB4qtAJGebmpb8yHkSovZxaq87t/GAMOhJUlOM9wIBiW6LEq
	4fM8kjOb23t6L7TSXNl9VCmL85fKqlbPeuu4uzJw12yvh7IHYpvKDPSE1Rtb/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Yixun Lan <yixun.lan@amlogic.com>,
	Jianxin Pan <jianxin.pan@amlogic.com>
Cc: oxffffaa@gmail.com,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@sberdevices.ru,
	Stable@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix scrambling mode value in command macro
Date: Mon, 26 Feb 2024 11:45:00 +0100
Message-Id: <20240226104500.490108-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210214551.441610-1-avkrasnov@salutedevices.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ef6f463599e16924cdd02ce5056ab52879dc008c'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sat, 2024-02-10 at 21:45:51 UTC, Arseniy Krasnov wrote:
> Scrambling mode is enabled by value (1 << 19). NFC_CMD_SCRAMBLER_ENABLE
> is already (1 << 19), so there is no need to shift it again in CMDRWGEN
> macro.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Cc: <Stable@vger.kernel.org>
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel


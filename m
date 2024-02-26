Return-Path: <linux-kernel+bounces-81192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A584B8671D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73F91C22A47
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16A2C18F;
	Mon, 26 Feb 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nlVOK+dO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0721A0D;
	Mon, 26 Feb 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944264; cv=none; b=oEugdX0y2OMBiuqFtJaD2OKv7babpzg6gAxB4s4xbm5U6nKgI14z5xYi0AS27CtwK6mPtaV3dWTgXKOyBc3IeBJ54PypniFjx1bPAuhQbpnzOLcU2ULBRQc9mP6KkxcxOe3YyyDB5CG+l1qaqrY6NbRv61BrOx2e8pOCaFQ2DL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944264; c=relaxed/simple;
	bh=MRvEfGXgTvdBoQBzWQc3mPG1lnoaEh91uHGlYOFLtWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0v7b50R7m2i1k+SLi1ihpc0fxRroyJ3gC/ekean6Zmr5K5mxFwguGcO1+45Q2HCJ5sxxY0bpTSxV414lt6KaEeHWifHhsvN3bv8cnwyXuZHnD/MekAK64NdI7nSpqTWj9Hoi22zlG7/Z8lZbO9a/VjM/mHDFFTC2jGHn/yC86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nlVOK+dO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD0CC240004;
	Mon, 26 Feb 2024 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVWZdJzIt0sMRE0sF1Fi2eHeNg9G/wm4KdgqiJdEH80=;
	b=nlVOK+dOs1yaI5QT3ei8fQBNTi7qk+B9IwGRaGEcWl+nXu8tNkOgBAtJUCw9H4zyL4gUe2
	loDiJiVhee7gxN73gr17hQJnReOnWgDqMwik2qzWVK2TSDQO0qqsAhyCqiPFg6V7LW313z
	Yc3Anpz0ESPrxsvQz7pB7R4AjrDosSqphB9/hLrZQuobBM3GX6XlibinLs6YJhc1PhqWlT
	JM+5I7CYt3Q3PnXqz5VLUfFX3LTAVQvy9YZvlgckD0tM3mb2piTT4R4e8oTRo0sJthRsf3
	teZ+RYYBbOdGpOvlnGtEkP+lf6feuckGN3HoZ4+8JzZ5l2o3wjs+A8sX4GsnHQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>,
	Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 06/13] dt-bindings: mtd: brcmnand: Add ecc strap property
Date: Mon, 26 Feb 2024 11:44:18 +0100
Message-Id: <20240226104418.489578-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-7-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'280962d413e873c7b2ff82b0767d04c60cbe0615'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:51 UTC, William Zhang wrote:
> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
> board boot strap for broadband board designs because they do not specify
> ecc setting in dts but rather using the strap setting.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel


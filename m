Return-Path: <linux-kernel+bounces-116816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE988A6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47584B33F40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE718BC43;
	Mon, 25 Mar 2024 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kg16ByBE"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB112FF7C;
	Mon, 25 Mar 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361939; cv=none; b=E85MTCn7G3q52uZNtzqr9hMpCRkWKTAMN814TZ9Ty//wrWtcoyi1Kgy3A12YyQgIdz2DLBzM2E4xG7rANzi6gaAasFwQBf1CCjIwFSYDnaxcsbiQmHg/ncLQXG++ogi4kVVNr3HAwOKSx7//juoh1J+CIOJpyoUntrZUW8GzvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361939; c=relaxed/simple;
	bh=PwgsFa5XA28r6N/luTZ5/joQDm3rKoAZilaYfT7S4vU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbXF7ZGcE/7rCcyp6n8of862Nk6USluBtU3i62KXzczAjS0AfBdEOvF45m3cudZMuRGDKgJPR2IbmFcmyt9YW3h2143GAZwry4yyHoLRO5XouN3YC7Mc0/YV6zj7vIyOvp6UJ0u72DLCPMKnAz/PZpKEszQApOwdd2Mj8TAwJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kg16ByBE; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F607E0004;
	Mon, 25 Mar 2024 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbqeBpH+1QqX5M3BkHKBHii3KNtrStCGIe/gU4War+M=;
	b=kg16ByBE+hTjI5M1VNC9tw5XGgrSRTyhUOsnX6FW+GRN5E8xg0DVVMdVUNxYKM+ZlZxDSX
	ArfOPFUhppEDSpXnyZoEpeCfVZHHzLcyVuWtAZZsDkuMxCA3KQsSyzcNRg93ePpCqKRTdS
	oz2UFUCRjBQlKmwQywTiO9rP1scFmZitYTxgIA8vta4fJs1+v3tEWM7d7fxmHYmZoCK8a9
	jPEllFSh+USSEFdrM71O/lGUL7z5bmjWVIZHOUFVK3YsySEZw1XE+vOIeZVkM8csTZJV+j
	XcIJeo9sf3d08eJ9PFDaJHG9sqSRRI3RhKY2TXqZQaeExGZfQYpwXoARcx9w0g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: Add Samsung S5Pv210 OneNAND
Date: Mon, 25 Mar 2024 11:18:47 +0100
Message-Id: <20240325101847.262460-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240313184317.18466-1-krzysztof.kozlowski@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'26729dbb53ac575635ef96ece0442165efa9613f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-03-13 at 18:43:17 UTC, Krzysztof Kozlowski wrote:
> Document binding for Samsung S5Pv210 SoC OneNAND controller used already
> in S5Pv210 DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel


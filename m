Return-Path: <linux-kernel+bounces-97367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E2E87698A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B88628304A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566956773;
	Fri,  8 Mar 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N0vqFYfj"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8F28DA4;
	Fri,  8 Mar 2024 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918308; cv=none; b=K5IPchO2rVOXLVAB54QEt8f61SW3PXtA/yX8vn81/oOA6yVZot9k1qOOYjmp45/VVNrvefa5QgNesZ6x1GsJ7CeCi4s2KbyevN1pIK56lcFnnrxTbGmLNWJBxLAuI4/bMFvwJaa+6dwrmLTPApCSzy1ZhAa/irch5Twf9RL1yPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918308; c=relaxed/simple;
	bh=/IUtR1QhrOh+Npea2oe41h1LCefsP4M9voCRGpR8M7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQ0/egMyZ+puHNJroPHMDBYje/ZUpAd5sR2I5HQqAVAOrlgx4s0yzwFU8DTIJXh6HbtSVt3JYqejcVIJBxst4yG44GMMEHNQ+z1DlF7XDnEgr1FHBmYj2HOTPs9eEOQFNduKuwv8heisecwuOdijIAtV/xJ5CaYp3e2l1eHM08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N0vqFYfj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD624C0007;
	Fri,  8 Mar 2024 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMNvpchq6L9NiooxCj/RaP2N+unTTBYKBtPBw/XfUSY=;
	b=N0vqFYfjmYFxrSNypQ/bG9DaU49kgOcdKSYl+GUe8G6eQjh6IA8hBGAv5ZLv1ZDR8HJbfY
	tuRs+1+DtJwo0dgY52Jb2cwr9frsC0bW9ysa9W1aVs3pnESLkNQHgfOE/J9NXBdQlfqiyE
	8qjLNi5f192YhIqegXckujWjgUAkAh51VPDTSTDezNI/H1XSOjBmyjUfatsyoCKO1+2SmT
	MdZU+MRcua8V1KktjstYHyqfxWAFp9BIe4Vc42+cNPdFc4Ly4txrBDZ+qdI6ZA2T/M1PjX
	+yNAc97U3J4/O9Ed7gyd+7NdzttWrj3Jp4viUxe0vhk5TdmYnsfRUqeJym8YXQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:17 +0100
Subject: [PATCH 02/11] spi: cadence-qspi: switch from legacy names to
 modern ones
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-2-a503856dd205@bootlin.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Both spi_master_get_devdata() and the ->master field in struct
spi_device are part of the compatibility layer provided by
<linux/spi/spi.h>. Switch away from them.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1f2d404c2cde..266a5d5dcfaf 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1412,7 +1412,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	int ret;
-	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
 	ret = pm_runtime_resume_and_get(dev);

-- 
2.44.0



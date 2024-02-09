Return-Path: <linux-kernel+bounces-59385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6E84F62D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B178E1C211A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E754C619;
	Fri,  9 Feb 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oozC31nL"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F73F9F1;
	Fri,  9 Feb 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486361; cv=none; b=WLV29M67eEaOZVyMxzrtS/FI2AxPB9cbEea/0J76RaaUSj3+6XbcCcLIVcFtzcNCcL1zZxksNHzAUNVbT95yWSd6S2ikArq1fK8LkIkRcnPLSXvzMKu4gji0i/0BTV0l3nkyiGnapsynh3elnBRLyMuB2MDEged4uSlKURInblI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486361; c=relaxed/simple;
	bh=x5yS+e1whkCcW1X010hyPSw0T9R1J+tGq/AJHUt+taI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCJhEHsEpcx7sRzbGDPYb657kom8m8vlByhyBZhzImcvu9hyjfhalMEPQwy4hY8Ik0X4J4b89V0QhBcGwximBI+mio4OekeKm8HC6Dbjyix9lCCX35CXQvMCaDhgEIXuzaQwVGfc7PuiEP0QgcHvMxQoKzekPMIKIdnZfJCkA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oozC31nL; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8726DE000A;
	Fri,  9 Feb 2024 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmJR6rtP7JOiSMvD1eVy/J8FgmNvCY5EiCZrsGZDPYk=;
	b=oozC31nL1eJOZ2+j1mLC/Dcu2XlJA3UDbLJPJgGQQUAiXyVKDbeVHfEBkr2DhtnUs0b15I
	6p+mu2FEkt/Xquhr2tsY2APlkhWWq0dZd0wO9GA3J7EX9vZhMzIECvS+ZE+iTHWbhwxmLs
	P7LEN6FgpBjXzFjjFmNGk+avzNv8/P62ZgMktanVfhtCXKZlFp108mxXaxxEs5f42yS40O
	fuGO8pLEAFc3/dQBU/V/oOfi7+10tgJfZ+AktOjuVmAg9ysMbBScsh9AzG/aPvGTl1BV78
	c79HG/G3C5/QpL/vlheCqy7A2vF9OhkiYPnTnyS/JP0+itLynLov8E5Cj4nigA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:45:33 +0100
Subject: [PATCH 4/4] spi: cadence-qspi: switch from legacy names to modern
 ones
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-cs-v1-4-a4f9dfed9ab4@bootlin.com>
References: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
In-Reply-To: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Both spi_master_get_devdata() and the ->master field in struct
spi_device are part of the compatibility layer provided by
<linux/spi/spi.h>. Switch away from them.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 895c950e7fd6..7ae3b2329089 100644
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
2.43.0



Return-Path: <linux-kernel+bounces-113370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346D8883C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648461C2378A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77619DF7A;
	Sun, 24 Mar 2024 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEHN+lkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1419DF64;
	Sun, 24 Mar 2024 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320172; cv=none; b=XDnz9BEboup+GH7mHxVpeBcp/ooIuwcWLaD/OSEpyGbS2SI+Gp8jn0W2nShYGvR7rkSMyIig7UIqau0MxRRj1/geei8BDakW5g3T7Gsj5OL+Ka1rxFy2zWyKw2RLQBJA354srr0asUV+LyKwLv3+u8eUtL5D1B2aBR0/YHV9HPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320172; c=relaxed/simple;
	bh=ezCUrIvDRIMjnNi19J2vJvkJAVoFfPKZW7OmIymu7FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHl+JBEldJdHaPscWnohNlJz6CNfo2+NTPQCOmGIU+jkE6a+36cN79QwUmx9b3clLO6IuB99SLVA6VNhnS2Hl0Xk9+E8rpwfTV5gxHG/IU+NPcs6tdGlJSewNsM8Vb87MjWpk4eR8FDeOf1n3BZb3szv+dv0psoWRMCFeKNE7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEHN+lkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964BCC43394;
	Sun, 24 Mar 2024 22:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320171;
	bh=ezCUrIvDRIMjnNi19J2vJvkJAVoFfPKZW7OmIymu7FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEHN+lkYPO+oQ28x1o8feH41I2joLMDQ0qy8VDXxaGlgr2P3dZ03Q9749v3YdU0ga
	 1qVc21HTw61wPfBb9BHINl6Ey7bCwDa1ngsWceNQlqU/zcoRtz2aoSmcfP6vo8VmdR
	 76Q3Ra+JaMoihaE9Cdb/pw32KAgDRn9nhUObmEI5SniQPdAH5N8mYjOuokqWm1SxKs
	 dKmrKhEAyJL5SWLuYKY0m32n49zmx+XUMIYIkZjkOAaBjhbpjWsKHzDQZfq+bqwt8i
	 lbvT/O4yoqtjPHjh7A1SkL9L9ZdW5Fsi2hyJjOkMobmFLSNtP1YLDBlEn/3MIf1AV+
	 r6qQPxY919Y4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Regan <dregan@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	William Zhang <william.zhang@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 479/715] mtd: rawnand: brcmnand: exec_op helper functions return type fixes
Date: Sun, 24 Mar 2024 18:30:58 -0400
Message-ID: <20240324223455.1342824-480-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Regan <dregan@broadcom.com>

[ Upstream commit d4bba1501f72e8af09f2cde3d327147de1b69f5d ]

Fix return types for exec_op reset and status helper functions.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/102423.html
Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
Signed-off-by: David Regan <dregan@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240223034758.13753-2-william.zhang@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 8faca43ae1ff9..b8e70fc64348e 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -625,7 +625,7 @@ enum {
 /* Only for v7.2 */
 #define	ACC_CONTROL_ECC_EXT_SHIFT		13
 
-static u8 brcmnand_status(struct brcmnand_host *host);
+static int brcmnand_status(struct brcmnand_host *host);
 
 static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctrl)
 {
@@ -1690,7 +1690,7 @@ static int brcmnand_waitfunc(struct nand_chip *chip)
 				 INTFC_FLASH_STATUS;
 }
 
-static u8 brcmnand_status(struct brcmnand_host *host)
+static int brcmnand_status(struct brcmnand_host *host)
 {
 	struct nand_chip *chip = &host->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -1701,7 +1701,7 @@ static u8 brcmnand_status(struct brcmnand_host *host)
 	return brcmnand_waitfunc(chip);
 }
 
-static u8 brcmnand_reset(struct brcmnand_host *host)
+static int brcmnand_reset(struct brcmnand_host *host)
 {
 	struct nand_chip *chip = &host->chip;
 
@@ -2433,7 +2433,11 @@ static int brcmnand_exec_op(struct nand_chip *chip,
 
 	if (brcmnand_op_is_status(op)) {
 		status = op->instrs[1].ctx.data.buf.in;
-		*status = brcmnand_status(host);
+		ret = brcmnand_status(host);
+		if (ret < 0)
+			return ret;
+
+		*status = ret & 0xFF;
 
 		return 0;
 	}
-- 
2.43.0



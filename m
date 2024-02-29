Return-Path: <linux-kernel+bounces-86997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30F86CE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC43128502C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458B152E1C;
	Thu, 29 Feb 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDX3JzBC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B114A089;
	Thu, 29 Feb 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221834; cv=none; b=Ti9Nlx0rsK7SO+PEv+rVfYB7Zr6nE2JgMOaNZ2Z3qlQsLkbT/KtsWSIwe3v7vE+2SHhfW7tVyRhYM+EN5aMqkViKjul5Fi99SvGxJBDW+8molsqqIIAD/OdiIh1mrNxnIjsTLozWdkfpqYWyPHLjTUzLCMNAjLNU/0iBoaOCom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221834; c=relaxed/simple;
	bh=8A546/n7jgq6mRsKQpZaS+4lWC8QWDJzykAsB1qA71o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdWc+BYIS/hztd4RLEsIlmfvU0N/vYVft0KLnBLhcFaHfKOIBqWCALir7GtQQ6F9tJjhRqIAQeGYPkJp93xbbxhTtJ+4GfRIMsjLxoLUzBIrIRZjPQQ7/GfbzMamyMAALtlhzsePntWRNz1dU+cRLRcuyRGP+rGYvQIC5ujiC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDX3JzBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EDCC433F1;
	Thu, 29 Feb 2024 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221834;
	bh=8A546/n7jgq6mRsKQpZaS+4lWC8QWDJzykAsB1qA71o=;
	h=From:To:Cc:Subject:Date:From;
	b=gDX3JzBC9vzvzRRRgA3MZew8xOjDkt8WQYdE4ALUyRWc7nTXSbvQAPnrnR/uL64Sl
	 /MGrWDUsK+fnhxqLVnmgerli0xUW7/2+keWt/lgGP0lo1cgPE/RCPgo+r01WhlrsEe
	 EfXxqKgzD+GN5/Hm04PyMy4TXAIhEZfnCQa6YoyMBuRAVXbB7Dw+7OEnvzXeR2CP0h
	 AY7P65Fla5auHn0hp9pxs3FkyJ/fZQ2BPGlGjamUJF9gQmvI/LNle0b1yC9kBlA8uh
	 HMD6swzQSszfQaym/cWA/Elq2y5C44eos1dqetpBnT/T/8eieWk7aucN0ge2QY/4gj
	 eifG8lL0kSeOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 01/12] media: Revert "media: rkisp1: Drop IRQF_SHARED"
Date: Thu, 29 Feb 2024 10:50:18 -0500
Message-ID: <20240229155032.2850566-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit a107d643b2a3382e0a2d2c4ef08bf8c6bff4561d ]

This reverts commit 85d2a31fe4d9be1555f621ead7a520d8791e0f74.

The rkisp1 does share interrupt lines on some platforms, after all. Thus
we need to revert this, and implement a fix for the rkisp1 shared irq
handling in a follow-up patch.

Closes: https://lore.kernel.org/all/87o7eo8vym.fsf@gmail.com/
Link: https://lore.kernel.org/r/20231218-rkisp-shirq-fix-v1-1-173007628248@ideasonboard.com

Reported-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index aeb6bb63667eb..41abb18b00acb 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -559,7 +559,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 				rkisp1->irqs[il] = irq;
 		}
 
-		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
+		ret = devm_request_irq(dev, irq, info->isrs[i].isr, IRQF_SHARED,
 				       dev_driver_string(dev), dev);
 		if (ret) {
 			dev_err(dev, "request irq failed: %d\n", ret);
-- 
2.43.0



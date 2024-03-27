Return-Path: <linux-kernel+bounces-120916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71488E07C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D57B27384
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7D9149C72;
	Wed, 27 Mar 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flYmHvvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B7149C5F;
	Wed, 27 Mar 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541576; cv=none; b=nX4haGnwXIgr4AbMq7C5oGyCb/NZEAVt3iz7b5Uxf+fnNfiOterSumKMMmy2yaTmMKiC8XkA+A/bH9dV46rT36OT4fm8eeew5YqviraFKQypfMUjahFHZi6S5H7oGdu4++HMeA1G16y26mD1349jUfpJ4xYnii3T35Aa8EsRCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541576; c=relaxed/simple;
	bh=G83QTErL8n2Y76MXQwujf0FzfFPIzjjZ6OxjLFGq1kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwHp2rXNBH08Ep2jJ7buvd++I4Y9n6LAO2Dre0zsFOFMlQw/3JP8y8F+Dt1fCZCokgjzzLH8jE2eL1/6n1AlVkMy6O6qxq7WNmaO3+EjzwD5BJtllBb6EzmKDu4QVYSnkvQ4F5koqd6+q8pA9oGw2+7DBpS1pUWEoh2/+s5hKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flYmHvvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A0AC433F1;
	Wed, 27 Mar 2024 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541576;
	bh=G83QTErL8n2Y76MXQwujf0FzfFPIzjjZ6OxjLFGq1kI=;
	h=From:To:Cc:Subject:Date:From;
	b=flYmHvvPZynlm5lgPXZEH5rKK4nLgRrjVE1Jbz0fDYHevtxgDlOow+NWxVoZbvOOU
	 NTcNLmPFNGcCtVQX7OKQ/q9mGmUpsZXihLYRRHIZX1Z5vcXT/VhYaaVVOnxrWBV/md
	 4yBY82npHcodzAe3mLCyhJVcrrdlKWQh0+ypYAj3hyl08LVQ4VjNubb1EfyHSixvYz
	 3bi8kvgwBZqBzIuuNKBv/spllyj/e5f/77Ss4QwyJu3dglHsA1fvJ3rkgyYefCpX0h
	 eGsQjTWJvW/KXA8gr93QRC7W7pqPhsKUNr6S1L5Wy6jAh9gI0iCJMhQ3wRqtd5x3aB
	 uQwHHHWDR2q3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rogerq@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "usb: dwc3-am62: fix module unload/reload behavior" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:54 -0400
Message-ID: <20240327121254.2829897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6661befe41009c210efa2c1bcd16a5cc4cff8a06 Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 27 Feb 2024 11:23:48 +0200
Subject: [PATCH] usb: dwc3-am62: fix module unload/reload behavior

As runtime PM is enabled, the module can be runtime
suspended when .remove() is called.

Do a pm_runtime_get_sync() to make sure module is active
before doing any register operations.

Doing a pm_runtime_put_sync() should disable the refclk
so no need to disable it again.

Fixes the below warning at module removel.

[   39.705310] ------------[ cut here ]------------
[   39.710004] clk:162:3 already disabled
[   39.713941] WARNING: CPU: 0 PID: 921 at drivers/clk/clk.c:1090 clk_core_disable+0xb0/0xb8

We called of_platform_populate() in .probe() so call the
cleanup function of_platform_depopulate() in .remove().
Get rid of the now unnnecessary dwc3_ti_remove_core().
Without this, module re-load doesn't work properly.

Fixes: e8784c0aec03 ("drivers: usb: dwc3: Add AM62 USB wrapper driver")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20240227-for-v6-9-am62-usb-errata-3-0-v4-1-0ada8ddb0767@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 90a587bc29b74..f85603b7f7c5e 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -267,21 +267,14 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dwc3_ti_remove_core(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-	return 0;
-}
-
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
-	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
+	pm_runtime_get_sync(dev);
+	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
 	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
@@ -289,7 +282,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }
-- 
2.43.0






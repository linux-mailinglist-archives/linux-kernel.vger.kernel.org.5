Return-Path: <linux-kernel+bounces-134630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA889B3DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FEB1F2142D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEE3DB86;
	Sun,  7 Apr 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ndXKCBHe"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EEA11181;
	Sun,  7 Apr 2024 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520192; cv=none; b=dqADoRVlVdM9ttww1jNWF8Zxx0pywF7BHFUxzZ7mHr+FWd+nRnrP5r1kilv49HXrzxtHAINvg/0STBk7fu+K7NUiQDIbzf7znlPsPOXUaMSGQMdcbua2f8LaM3cNM63wCm8vT8THx4w1C7G6x7ERiXOpp/8xjtUHy2dklK/EJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520192; c=relaxed/simple;
	bh=keKEy/3Xr8accsTk/JDqcRgA2FSs4IU5nT8QrCVYNHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yn3BqJDtt50VX+cFmpXHEn19VVlWO4hDnu/MaNr9w/95NhhBdYivJWSjPMBe+lsWCEMq1un6nq6nOoeAimqqNeCh2h+Qyd7FFLqlAP38dQXSW3hOIemZAkiwqGHHn/qKiu+r3aF1PUtykJUMIWSHXOTfzyEBtKZdKvy5edILRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ndXKCBHe; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id tYiBrICUDz1OZtYiBrfStB; Sun, 07 Apr 2024 22:01:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712520119;
	bh=gOBZVvTbMI4Vvy9nFHPCW2JYo+PpjPrCvqOXxjC2HGc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ndXKCBHemAwbLOKLOO2DOm3giezlAGq19PHmek5chO1wkT5gUZPMjUJikYvKnURdd
	 wGHjgS0P7bENVtSp2WxQxaXAnUsnehEl+PPfoClhHm0ad3IYGBWiZjlq9Xr5h7MU8d
	 h8XmHoL7HbSVSRY4dS4rWUnG5SR2I0CNAewO8hIpMr7fO65TS3F/YugMLCEXaGcTHU
	 SbngVs0Sreh/6oF97hzgyZbuchAFrL34WYM2ykDORy1WiDAkweUrr/gh8Td80eY4me
	 JViE28pwYxzW8uZlisovIEchTebYhV0fsGyuUQAGOVRH42LrmtFDROZP1qooMrHpRV
	 JQQCItc7Q4Piw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Apr 2024 22:01:59 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] thermal/drivers/mediatek/lvts_thermal: Make debugfs related fields more consistent
Date: Sun,  7 Apr 2024 22:01:48 +0200
Message-ID: <42a87fb9837f1760d1ad4eb7162a7536785dc6f5.1712520052.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugfs code is only generated if CONFIG_MTK_LVTS_THERMAL_DEBUGFS is
defined.

So 'dom_dentry' should be included in the 'struct lvts_domain' with the
same condition, instead of CONFIG_DEBUG_FS.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a..3003dc350766 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -150,7 +150,7 @@ struct lvts_domain {
 	void __iomem *base;
 	size_t calib_len;
 	u8 *calib;
-#ifdef CONFIG_DEBUG_FS
+#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
 	struct dentry *dom_dentry;
 #endif
 };
-- 
2.44.0



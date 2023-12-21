Return-Path: <linux-kernel+bounces-8394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21581B68B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE4F1F261F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD67CCE9;
	Thu, 21 Dec 2023 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NByCFnyz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589687BF0F;
	Thu, 21 Dec 2023 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162930;
	bh=6AYkxKl8UtbFduON+vHDTlSbEKDTiAXo+qEGqK3aoS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NByCFnyzTo9m0wh9v1y13lUpMSf5CRF7uM6N7DGKk0U5Y/h4ryJ4gNAZw8J2ltJe8
	 w0Cr0vo6JEevDL+3XbhBlwbmJoRSa2kUBsoovq2Nt2dgBLaAjbiJKnewj9Xx418VjL
	 EavcvSLQOmu9yGCYW1K7pyabhD1JJqFvkQSF7RQXEYONyjbQNBAppq38DTkwwZqIl9
	 NtWy0sGdQz1xBDxjzvdr721DQ52GnCeW/G97EQLIXb2nQ10Zoic1opx2wEPEf67ePC
	 E9cBmOPLFrM9p4v4v2DHbPBWyvRGb7GWEFwjtxJ4MUORe2vtGfAjODakNezpCjuysC
	 v3buCg4Ym2PNQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 402A5378201D;
	Thu, 21 Dec 2023 12:48:50 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 24/26] fixup! power: supply: core: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:23 +0100
Message-ID: <20231221124825.149141-25-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d656a2e39157..b0211ab97f9c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1310,7 +1310,7 @@ static int psy_register_thermal(struct power_supply *psy)
 
 	/* Register battery zone device psy reports temperature */
 	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
-		tzdp.name = psy->desc->name;
+		tzdp.type = psy->desc->name;
 		psy->tzd = thermal_zone_device_register(&tzdp);
 		if (IS_ERR(psy->tzd))
 			return PTR_ERR(psy->tzd);
-- 
2.43.0



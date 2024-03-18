Return-Path: <linux-kernel+bounces-106079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52A87E8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B04F1C218B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA5364CD;
	Mon, 18 Mar 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DwDAwUJe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B03364BA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761571; cv=none; b=cvF1pZYGtts8igA0Lceuh/dlUcKpFCBi/tuIp4/7cV7+6LCZKbs8d5jULEig96JUCg6qd1xJQGtBj3630CyK31SAVbxFB5sR5XTAOBdc4afgizQAqcez/NlVxJVSplhnXNMTpgcjZMgU+7HOQN8fiTiKT3xWeBuyTOGUfrlkwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761571; c=relaxed/simple;
	bh=/d5mJxYY4XDPQ3SgGmz93D2aIiHlNJP2hzTiAI2mHJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hw8pQbe4CVs3FER2BM5l6KMdonXRAM4vbC1VQ8H2H9aDmHK1bPMzfn7gTPhWJx36NOHhqS+eOnJ9b/igYeyQV2+l+PEQHcqhoS9yndo9cJ4ttlr5udhRwOwbVPIde49rRKHxHcEQNloIy20yFioSYlIhS+bY4yGgQsLwGQDh6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DwDAwUJe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710761565;
	bh=/d5mJxYY4XDPQ3SgGmz93D2aIiHlNJP2hzTiAI2mHJw=;
	h=From:To:Cc:Subject:Date:From;
	b=DwDAwUJePBLCCDWQPb6+9mbOnzo5lmTbjLowhBYzzO7xsxnxQ6VVmr6q0qYsgumvd
	 32vzMhI4guZ5sTlz04PTtkGnVIwj6LNBesNsajbUw40WLNJo40Ujo5YF4ZF3TVBUNW
	 oWW9dgw3lzq6KRFnGNYQuks9JK83P2wFmMYqhcMDKfdP4mW4UuT5WrYSdPt6Ne+rFj
	 gRlZlgLyof6Xf9IfzeZB3mmm7cn5+h5F4MZjLTuCrHtKzNjlWzlHVdUb7m/kOhH3v7
	 +meubq4217R3HPsT/K5bI4vXvLNcQBIWbbg8UMzLnRX66NA9yzss5BotsJWQO3lK2o
	 2C45V7SctO4rA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1D41A37811D4;
	Mon, 18 Mar 2024 11:32:45 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	treapking@chromium.org,
	kernel@collabora.com
Subject: [PATCH] soc: mediatek: mtk-svs: Append "-thermal" to thermal zone names
Date: Mon, 18 Mar 2024 12:32:37 +0100
Message-ID: <20240318113237.125802-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal framework registers thermal zones as specified in DT and
including the "-thermal" suffix: append that to the driver specified
tzone_name to actually match the thermal zone name as registered by
the thermal API.

Fixes: 2bfbf82956e2 ("soc: mediatek: mtk-svs: Constify runtime-immutable members of svs_bank")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index e553800a9e4d..e431e0a53ed9 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1768,6 +1768,7 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 	const struct svs_bank_pdata *bdata;
 	struct svs_bank *svsb;
 	struct dev_pm_opp *opp;
+	char tz_name_buf[20];
 	unsigned long freq;
 	int count, ret;
 	u32 idx, i;
@@ -1819,10 +1820,12 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 		}
 
 		if (!IS_ERR_OR_NULL(bdata->tzone_name)) {
-			svsb->tzd = thermal_zone_get_zone_by_name(bdata->tzone_name);
+			snprintf(tz_name_buf, ARRAY_SIZE(tz_name_buf),
+				 "%s-thermal", bdata->tzone_name);
+			svsb->tzd = thermal_zone_get_zone_by_name(tz_name_buf);
 			if (IS_ERR(svsb->tzd)) {
 				dev_err(svsb->dev, "cannot get \"%s\" thermal zone\n",
-					bdata->tzone_name);
+					tz_name_buf);
 				return PTR_ERR(svsb->tzd);
 			}
 		}
-- 
2.44.0



Return-Path: <linux-kernel+bounces-164624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535EF8B8043
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0830D1F230DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D6C194C95;
	Tue, 30 Apr 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FqFvg2W7"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535D1BC59;
	Tue, 30 Apr 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503804; cv=none; b=YuKUypEYMbtnWZ9hULOP+xrHLwBhDOX7pYdtN1DbGonB6wZ8nGRj4a0ujHnLuMf+KLQScXGkWdC2WBPXMC5WzqH+9oFbN9Klhhw92i17l8fmSKkQ/eiGWMmb884xACBtBpPt111wb1QR5HSjfaH7b9mud0bHHAtOy4HUV97xayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503804; c=relaxed/simple;
	bh=A/3jgo7B0Ak18AEd05J73EHmxvmTkgnPJzFGXe2ZTuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ij0h22QLUfAz8PJDEpNDFtCSAXIHP5DLnyg/IFcQ7Jx31YKjBtkIyMgcvu/R0NK3f96EgrjlnebAt4oL2Er+vdUIOploG8jbymSsOGRCL57hKTM8Nc3QVpe3rnNn6WT3kz8KXYVDv4h6Zf2eI3oFjoZj66VmyNye6WkBkXoppWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FqFvg2W7; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 1skxsYnM1PWAk1skxsYEec; Tue, 30 Apr 2024 21:03:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714503794;
	bh=VEKXdsrN4FCUT2d2eWfWEpHgGeD3ZeJqsDSnHgARRQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FqFvg2W7mwZwu3pd8aMBdiabZL+lLxGETx8aDFjgfSAYIVqZeJHGXaWc5IHQVTnP2
	 9BNFKKRrxu+4nCH4x7IFk3lBu+89i3N4xdVVP0hWqGqGMclO5VUTOOZM5BNeyKeTI/
	 ZI8Hkh57B0qnHXFLbgBctIaeTYxnQuQOHV7Cpwg2OP4IU+Ya1Nri8gY4Luai/nnydL
	 Uhj0o4DfaBcEmH5Oy+FaQ08CALqKpbQF8uXCtbpc1xIvmua8aU7Irb5X3D5y96GV3J
	 JEtgV6xojiG/ya/AJHoq1EQyU/ZYS/Qy94vaMh5z2sPJ/yOlmoylaqq46AHZat3XRW
	 8UZ6OXjSVQ6dA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 30 Apr 2024 21:03:14 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Alice Chen <alice_chen@richtek.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] leds: mt6370: Remove an unused field in struct mt6370_priv
Date: Tue, 30 Apr 2024 21:02:22 +0200
Message-ID: <22704991f7acca6c2e687ff4bec7822087e1305a.1714503647.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct mt6370_priv", the 'reg_cfgs' field is unused.

Moreover the "struct reg_cfg" is defined nowhere. Neither in this file, nor
in a global .h file, so it is completely pointless.

So, remove it.

Found with cppcheck, unusedStructMember.

Fixes: 5c38376ef5b4 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Compile tested only.

Changes in v2:
  - Tweak the commit message   [AngeloGioacchino Del Regno]
  - Add a Fixes: tag   [AngeloGioacchino Del Regno]
  - Add a R-b: tag

v1: https://lore.kernel.org/all/e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr/
---
 drivers/leds/rgb/leds-mt6370-rgb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
index 448d0da11848..359ef00498b4 100644
--- a/drivers/leds/rgb/leds-mt6370-rgb.c
+++ b/drivers/leds/rgb/leds-mt6370-rgb.c
@@ -149,7 +149,6 @@ struct mt6370_priv {
 	struct regmap_field *fields[F_MAX_FIELDS];
 	const struct reg_field *reg_fields;
 	const struct linear_range *ranges;
-	struct reg_cfg *reg_cfgs;
 	const struct mt6370_pdata *pdata;
 	unsigned int leds_count;
 	unsigned int leds_active;
-- 
2.44.0



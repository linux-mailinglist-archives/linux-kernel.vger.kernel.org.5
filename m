Return-Path: <linux-kernel+bounces-93907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B708736B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F541C2365C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8AC1272A4;
	Wed,  6 Mar 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WcGASoc1"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FB1E519
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728768; cv=none; b=uzMlHPw8MSwSC5RiI9L0YzJQY9OwBtgpLrJf3eA36NLTG7ht49nnBoEpGVb/sF6bIME+2hVsp/e/kPibus14mQKgVY+Z9VGXt4DJBVDJN+3Zpxwynb/p2DyB4meol3IKkuOiEqygOj2gCoIbsEEEuiWl1vbapm2FnMgTslFRLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728768; c=relaxed/simple;
	bh=DyNIMG5zL0ui6GMf73JDrA/3Viho9HpORxGOnZWybHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B1Qc9duhgHR+V0q/+Bv/QXvS2rJiw/BlzTf48SXWOS3hN2TlRFv1xkkfEP+25iz5gZrCQwz5oFNUcH20t4bmJDnDfMQ6jZwzk+oHdeGSRvI7V/crwYwe9b3AbGP6WuZk4/gAgfjP4e3cWHT+Y2xzd5RL8miLwU7RR+bMZnHld7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WcGASoc1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E34940008;
	Wed,  6 Mar 2024 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709728764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elkd8DsFZS5LmKpv07wv9/YlAnCVft4QUXCwGUZen9k=;
	b=WcGASoc1KG0VbPwmMfiT95+0rpCtDVoXHW6AJ82VN7BMBrhC0n0M0ft/A5ZE91It8UhKsr
	4PEuag7MjK0qJjoCnqoUEcGAL8eF0axOME4/bJe2SaiTDeM/tnPn+jlow/uN37ta/sNlkz
	MsCKorGBGR/SrP8+FZm5Y386BgqIQn9G44GIPw6O9OxPMjBcPHashdFxBOJWN/ohM06hrl
	4iwT+Q//4XCfbzPAvkGllT6wcFxkiB1d7dxy2MlXIuER/KnArACdYph/Ac787FvLyqRy9Y
	YZ9Rg5C5piEiVvjvIsoit5FmWw7TsvEasEvOHVmmd4OOHoNVQyUhROBxEiqE4g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 06 Mar 2024 13:39:20 +0100
Subject: [PATCH] Revert "drm/bridge: ti-sn65dsi83: Fix enable error path"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-ti-sn65dsi83-regulator-imbalance-v1-1-a3cea5f3e5b3@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPdj6GUC/x3NwQqDMAyA4VeRnBdI202HrzI8dG3UgKuSuDEQ3
 31lx+/y/wcYq7BB3xyg/BGTtVS4SwNpjmVilFwNnvyVArW4C1ppb9nkHlB5ei9xXxXl9YxLLIn
 REXvXjTmQT1Azm/Io3//iMZznDzvwTRRyAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

This reverts commit 8a91b29f1f50ce7742cdbe5cf11d17f128511f3f.

The regulator_disable() added by the original commit solves one kind of
regulator imbalance but adds another one as it allows the regulator to be
disabled one more time than it is enabled in the following scenario:

 1. Start video pipeline -> sn65dsi83_atomic_pre_enable -> regulator_enable
 2. PLL lock fails -> regulator_disable
 3. Stop video pipeline -> sn65dsi83_atomic_disable -> regulator_disable

The reason is clear from the code flow, which looks like this (after
removing unrelated code):

  static void sn65dsi83_atomic_pre_enable()
  {
      regulator_enable(ctx->vcc);

      if (PLL failed locking) {
          regulator_disable(ctx->vcc);  <---- added by patch being reverted
          return;
      }
  }

  static void sn65dsi83_atomic_disable()
  {
      regulator_disable(ctx->vcc);
  }

The use case for introducing the additional regulator_disable() was
removing the module for debugging (see link below for the discussion). If
the module is removed after a .atomic_pre_enable, i.e. with an active
pipeline from the DRM point of view, .atomic_disable is not called and thus
the regulator would not be disabled.

According to the discussion however there is no actual use case for
removing the module with an active pipeline, except for
debugging/development.

On the other hand, the occurrence of a PLL lock failure is possible due to
any physical reason (e.g. a temporary hardware failure for electrical
reasons) so handling it gracefully should be supported. As there is no way
for .atomic[_pre]_enable to report an error to the core, the only clean way
to support it is calling regulator_disabled() only in .atomic_disable,
unconditionally, as it was before.

Link: https://lore.kernel.org/all/15244220.uLZWGnKmhe@steina-w/
Fixes: 8a91b29f1f50 ("drm/bridge: ti-sn65dsi83: Fix enable error path")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Many thanks to Alexander for the discussion.
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index e3501608aef9..12fb22d4cd23 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -499,7 +499,6 @@ printk(KERN_ERR "%s: LVDS in fallback (24/SPWG)\n", __func__);
 		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
 		/* On failure, disable PLL again and exit. */
 		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
-		regulator_disable(ctx->vcc);
 		return;
 	}
 

---
base-commit: a71e4adac20bfe852d269addfef340923ce23a4c
change-id: 20240306-ti-sn65dsi83-regulator-imbalance-10e217fd302c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>



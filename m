Return-Path: <linux-kernel+bounces-157126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA4B8B0D28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816871C24BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D315ECDB;
	Wed, 24 Apr 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1ZhwOyr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132515ECF9;
	Wed, 24 Apr 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970226; cv=none; b=a7kxZp0an8c8w5GNV7g2pFartReqRe4VP9EupHcJy4Urm/RaZDpO+HmpU+ii6/LrzE21DcyZozvG/chcqoa8QT9diAMkoOxFpIzObVMl6CvYfdw6PATt9VNo10dcSkYQYX9r2A1Ml847ljczqqga3CO4036aPLTIAxfY/2IDmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970226; c=relaxed/simple;
	bh=+Kqt34lIDZiWMLI8D20HGPRYTW4m1fjEqIhAtNe49Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIbcVb23a1mpoJxgxYwy7ExMOhBkwF1LCqF06n6bbPpsIRHeqwQGbf1B3MWgdvWjxU6dJxUH4VifxevzYYGdc+JX0NNxF8Z39KgU/PFMS10RpS49uVFREGbEt4ZRO13Bz7yJUSifGw1JGrT4KcGTVRKcTtvO4668TctPKwraqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1ZhwOyr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713970226; x=1745506226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Kqt34lIDZiWMLI8D20HGPRYTW4m1fjEqIhAtNe49Yw=;
  b=M1ZhwOyr74BgWW4hkmsx2BfnWkoLF6hB7K8oJ/R0sbMnbprjZy6ob8qh
   0XN4/lxR0U0Hx+k1rmOASl2gkVcIEqwjVYfT+nK99sNxUYA8Vm8KYsMwP
   seFtM0IwP8hmdjcEkK9HAwNRShLghtGYOadUBo0a2I88w7s8q5XMQnJOr
   nQmZw+NATt1fYZKjjEkngqxgTV2jtdBpyLDnKCtZIxtgf3a9eBufNuuJr
   6Aztt6s01CYNhxmxfteyQF8Rj/YEe3vDKURBNOQjNZSqdHj47HBmsnJzz
   hgpl1IUS87WgKxMKVwUzhUtlH3YkFCQnue6v90cyHXqfMMxlYrM5+yjT3
   A==;
X-CSE-ConnectionGUID: X2PbYMRuR+Oevkc3rl94iA==
X-CSE-MsgGUID: +KqAjWlCSt6XKQcUTcAVfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13441125"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13441125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:50:25 -0700
X-CSE-ConnectionGUID: GbYnY7HvT0C6ih+YpHugTw==
X-CSE-MsgGUID: N9bZbFAORXyW4Uj9qpMSjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55933059"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 24 Apr 2024 07:50:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A9152136; Wed, 24 Apr 2024 17:50:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] ALSA: control: Use list_for_each_entry_safe()
Date: Wed, 24 Apr 2024 17:49:41 +0300
Message-ID: <20240424145020.1057216-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of reiterating the list, use list_for_each_entry_safe()
that allows to continue without starting over.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
---
v3: Update snd_ctl_led_reset() in the same way (Takashi)
v2: added tag (Jaroslav)
 sound/core/control_led.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 061a8ea23340..804805a95e2f 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -289,25 +289,22 @@ static void snd_ctl_led_ctl_destroy(struct snd_ctl_led_ctl *lctl)
 static void snd_ctl_led_clean(struct snd_card *card)
 {
 	unsigned int group;
+	struct snd_ctl_led_ctl *lctl, *_lctl;
 	struct snd_ctl_led *led;
-	struct snd_ctl_led_ctl *lctl;
 
 	for (group = 0; group < MAX_LED; group++) {
 		led = &snd_ctl_leds[group];
-repeat:
-		list_for_each_entry(lctl, &led->controls, list)
-			if (!card || lctl->card == card) {
+		list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
+			if (!card || lctl->card == card)
 				snd_ctl_led_ctl_destroy(lctl);
-				goto repeat;
-			}
 	}
 }
 
 static int snd_ctl_led_reset(int card_number, unsigned int group)
 {
 	struct snd_card *card __free(snd_card_unref) = NULL;
+	struct snd_ctl_led_ctl *lctl, *_lctl;
 	struct snd_ctl_led *led;
-	struct snd_ctl_led_ctl *lctl;
 	struct snd_kcontrol_volatile *vd;
 	bool change = false;
 
@@ -319,14 +316,12 @@ static int snd_ctl_led_reset(int card_number, unsigned int group)
 		if (!snd_ctl_led_card_valid[card_number])
 			return -ENXIO;
 		led = &snd_ctl_leds[group];
-repeat:
-		list_for_each_entry(lctl, &led->controls, list)
+		list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
 			if (lctl->card == card) {
 				vd = &lctl->kctl->vd[lctl->index_offset];
 				vd->access &= ~group_to_access(group);
 				snd_ctl_led_ctl_destroy(lctl);
 				change = true;
-				goto repeat;
 			}
 	}
 	if (change)
-- 
2.43.0.rc1.1336.g36b5255a03ac



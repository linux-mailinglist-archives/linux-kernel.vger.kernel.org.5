Return-Path: <linux-kernel+bounces-155909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91788AF8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB31F260E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F11143866;
	Tue, 23 Apr 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQAjUcRu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B95142909;
	Tue, 23 Apr 2024 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906670; cv=none; b=aY8sXqD40IdL2Zvr3mBWyYVS1wCBIU3cDKEHNbbtU1eRKCaVFbQ4KYqK4vU7NNLUn38ukYkLC6hGN2gg9ic4BrVw+Mx7z8OMGQqOFryNoF/hkR+um1fjhlTJLIQm0atpb6ya8F0HKczrf3mDqeBATmkh3BhYJc0++AzIHJL/E74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906670; c=relaxed/simple;
	bh=d7TVE296PHJP44llwt9u2h0wBexxmfsPmyLF5+Hwt7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4UalLPHmkkd1v0Bzvc4E/tMJqXLMVLS6F6jZursuWCuhUrNZg5225VxbiehtpB00vUOYNv02rqlUxWxjhosLOgtn524lWRvndYo3dvmZ3aaSS17gCEnZlcoBgpSp7b1xJb0kxil9WzobqScfPRYJdPvMGnTtfa4y2WF5+1itHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQAjUcRu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713906669; x=1745442669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d7TVE296PHJP44llwt9u2h0wBexxmfsPmyLF5+Hwt7I=;
  b=cQAjUcRuarWhpaUSy9KiiyXAYGO6NW6SUQoz2Mwn8lvXtYnif5ini6vL
   QHBLuXUQkU344W4af6LS3NeVwtVVX6Pt21aX4EfQBHqDixQqsOu/4w91d
   eXN3YORv28DjhWFZCUvnTV+L39XQQw04St8fvklnjNrdpkBAH6w9e0PAI
   Kf0q8kl1ONGc2AqBpsuqhHsEGqqVaPR6CzQV9L21kvBe6ZXxNrdETImDs
   8x6gWvHCmSFO3CVVKaYmxpwdH6TswCSPrzqUuHMtDNJ9xVybLbhJ3Kjp3
   zVXlgSvpWh2icwh0TNSi4I3/Tahdaty1TxD5n//VaS9zl2dInij6fMF7E
   w==;
X-CSE-ConnectionGUID: 68w5/Q2ISY2oyr+TZDe5NQ==
X-CSE-MsgGUID: pWvGqNhBS8eMatlJqDyblA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13304611"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13304611"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 14:11:08 -0700
X-CSE-ConnectionGUID: votKh3BHQgOzYJN5Hbz8zA==
X-CSE-MsgGUID: f9jACy/KQGaiBd4uSpPCTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24494406"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 23 Apr 2024 14:11:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8524528A; Wed, 24 Apr 2024 00:11:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ALSA: control: Use list_for_each_entry_safe()
Date: Wed, 24 Apr 2024 00:10:22 +0300
Message-ID: <20240423211102.3785556-1-andriy.shevchenko@linux.intel.com>
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
v2: added tag (Jaroslav)
 sound/core/control_led.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 061a8ea23340..ea95405c76a4 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -290,16 +290,13 @@ static void snd_ctl_led_clean(struct snd_card *card)
 {
 	unsigned int group;
 	struct snd_ctl_led *led;
-	struct snd_ctl_led_ctl *lctl;
+	struct snd_ctl_led_ctl *lctl, *_lctl;
 
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
 
-- 
2.43.0.rc1.1336.g36b5255a03ac



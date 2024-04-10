Return-Path: <linux-kernel+bounces-138432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1289F127
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25F21F24E33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3E15ADA6;
	Wed, 10 Apr 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq3Hu+oo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A76159589;
	Wed, 10 Apr 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749640; cv=none; b=t0Te+o1xLUs+XHnSv8+E2b3R+nIAj9/sq7HOuJWfCuOLbb70sKvP5u+43LudcPCCAo/w7f3jLP+CUKwOmA2vi/7rs80l7rSfQA6PthQPr74KTOe21AWSXX8iELT1oexNV2R7IC5SElT+I8lR75UU+RSWo7Q5VQY0AgT9RUFz+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749640; c=relaxed/simple;
	bh=6ZUpQRQfMAOGNZsK9PQ1Cubb6lWLTvq0Q4yRruNIE0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xi30sL3msaNsks41hW4zlKZlr+6WnTw08pvXKf8T216B4j8NX4NYszYR3WqLYWVPVjvZJnBgYlgag1eXDiFysvFma47hPSHwc5MfFDdRk3us4BnI7XK3POHYXQqoRQ6Sd1kLBk085OPfCgolmrtH5BOI6Dj13mt3fWox9Lw86FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq3Hu+oo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749639; x=1744285639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ZUpQRQfMAOGNZsK9PQ1Cubb6lWLTvq0Q4yRruNIE0Q=;
  b=Tq3Hu+ooYljq/5H4j2YagTD9UB33edlrfbODVcoFfCWkbvaLLscM1MWw
   68OFj+8qFXJ1fKw3ZI03Qrf63r8ZTfKTGpS6d2eDD4rz8l66OzjBIksz3
   j1GFC162ydNXf336gaIcxkLX7mL0oHjF6bIz8a5pg/pmnpRGcgkQc+xco
   IIQueBwy0AhmDAvuwckiiSO5ecxTgk43gUdtvIHXBXuOJTQCQcFSPAdFj
   XGjNV57txGM/FRgG4kdQ5AEXa6TSk32t3icueEzRQuVoYt5U9AVZhJcsB
   HufaIj1nHWjH1CNAL8kzd2slcJoZ6RUcEXU1xWadBYpUCFBHJhpm9naWa
   Q==;
X-CSE-ConnectionGUID: EWYUZ0CqQ/ykdwpuevqLXw==
X-CSE-MsgGUID: c4vYJ/Z0RpCL5+at9ul/7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7977929"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7977929"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:47:18 -0700
X-CSE-ConnectionGUID: bHAUoJrLRreGVN5yUJy3oQ==
X-CSE-MsgGUID: K7Ud7PSCQ1SeBDQ7TpzYSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51752533"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:47:16 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 04F681203E6;
	Wed, 10 Apr 2024 14:47:12 +0300 (EEST)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: tomi.valkeinen@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon fails
Date: Wed, 10 Apr 2024 14:47:12 +0300
Message-Id: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn on the privacy LED only if streamon succeeds. This can be done after
enabling streaming on the sensor.

Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 4c6198c48dd6..012b757eac9f 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	if (WARN_ON(!!sd->enabled_streams == !!enable))
 		return 0;
 
-#if IS_REACHABLE(CONFIG_LEDS_CLASS)
-	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
-		if (enable)
-			led_set_brightness(sd->privacy_led,
-					   sd->privacy_led->max_brightness);
-		else
-			led_set_brightness(sd->privacy_led, 0);
-	}
-#endif
 	ret = sd->ops->video->s_stream(sd, enable);
 
 	if (!enable && ret < 0) {
@@ -428,9 +419,20 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 		ret = 0;
 	}
 
-	if (!ret)
+	if (!ret) {
 		sd->enabled_streams = enable ? BIT(0) : 0;
 
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
+			if (enable)
+				led_set_brightness(sd->privacy_led,
+						   sd->privacy_led->max_brightness);
+			else
+				led_set_brightness(sd->privacy_led, 0);
+		}
+#endif
+	}
+
 	return ret;
 }
 
-- 
2.39.2



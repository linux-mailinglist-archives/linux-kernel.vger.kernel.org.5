Return-Path: <linux-kernel+bounces-138293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69589EF63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A161F22B24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57628158DC9;
	Wed, 10 Apr 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QX/VNOmg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A08F4E;
	Wed, 10 Apr 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743389; cv=none; b=JL2aSLMgocY+CetdabfeOHXZ7vYgr5JEvU3gwZpsRJ7SSiNbiV5Zr9qejeFwmg2jk0ApsSAZpadeUmZX/O0SX0Us0apQgS6m2QydohfJhjUG4PUgSUH9MS5y0rOij++si1Y8ie/9StinDctmAvo1bqnscAnv9C9LTR4lLt4ENjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743389; c=relaxed/simple;
	bh=PESaPOPG9KlJZbxWL1LM1wMqfUvpvl3bfm2/tdacBQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsXceJ/z+9u8W9Kaync1kKRY+dy3riY3jZf7uYqVRuwVdinFdpS529SH9PCQ+25YVhNmwOjDlpMEo2/Hl4t/MqE4PLW+xNKrhh6ynXjTXe6Z/JkHqxTdBGw5MeiaHA1REL3MDaQN53dgjYY5A8ps3f9I5iQwytbdiNRZSwWyksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QX/VNOmg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712743387; x=1744279387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PESaPOPG9KlJZbxWL1LM1wMqfUvpvl3bfm2/tdacBQw=;
  b=QX/VNOmgo86Vv1uQGXrXBFHPT/oxH3yO33KSL4Zzp7y+nSu5b8mDljVC
   RbGh4fEO08OD4EJEi0fT/xql50WwLj7htMkQqtX1vWaLwQxu4AhBDraoj
   8nWL3Xj8kHDvI7z5FqpsJBW0rt/5Qp+UI6kkwAsGrbDYp81uMPlgAYJVG
   P+A/+reSzuS0DFBCOkUKTZec08cp5OcoKCoughko71ck3yyJ2XTByUUzh
   05tzaLQtJmpj2Ra7hxoInp7Is2miF0PdMmoR8zdqlzvG7RByYuNgpkkD8
   DY64Inj6KZQdD6MY340yR0tWvo21Z0qXd41FSkaA1lNj1ito5LCEUKAtk
   A==;
X-CSE-ConnectionGUID: 1XH/mDwDSGKbQmW/wBRIpA==
X-CSE-MsgGUID: cQD/xHHLSyW/+zrVHUjZXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11887954"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11887954"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:03:07 -0700
X-CSE-ConnectionGUID: Hsqu5gW0S5KbhhQG3TuwzA==
X-CSE-MsgGUID: ruyqUbEYSFmhiGCE9Xl7tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25193688"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:03:05 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9F0E311FC46;
	Wed, 10 Apr 2024 13:03:01 +0300 (EEST)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: tomi.valkeinen@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] media: v4l: Don't turn on privacy LED if streamon fails
Date: Wed, 10 Apr 2024 13:03:01 +0300
Message-Id: <20240410100301.658824-1-sakari.ailus@linux.intel.com>
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
 drivers/media/v4l2-core/v4l2-subdev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 4c6198c48dd6..acb7c3003ab6 100644
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
@@ -431,6 +422,16 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	if (!ret)
 		sd->enabled_streams = enable ? BIT(0) : 0;
 
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+	if (!IS_ERR_OR_NULL(sd->privacy_led) && !(enable && ret < 0)) {
+		if (enable)
+			led_set_brightness(sd->privacy_led,
+					   sd->privacy_led->max_brightness);
+		else
+			led_set_brightness(sd->privacy_led, 0);
+	}
+#endif
+
 	return ret;
 }
 
-- 
2.39.2



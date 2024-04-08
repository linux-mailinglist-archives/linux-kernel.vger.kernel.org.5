Return-Path: <linux-kernel+bounces-134831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E189B794
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613E81C210A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4336F9E9;
	Mon,  8 Apr 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMulaKug"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74920312;
	Mon,  8 Apr 2024 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557337; cv=none; b=JvKOHe8+z12JlmIx8B/ettAEdNH+dhgTpcDAxW1V6X4KAble5IUk5pxzsnhjFhcVvY0BUCxlNsaXMYQ+zxvFkBsuiuIsZezsy4kxxXoTno+CGlCZb0k8VW260tswk/PX/fnYgVEZJnX96Y8oN/FJ0Kiqd+pPK5Qlz0sU6pGyvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557337; c=relaxed/simple;
	bh=Zrm/wvyh0xkh9uGwTCqa1YeOhLPuzSzzYRBCkJY6zAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EeJjc5j/hfd/hnMIi8Ug17ugbuuHTkiy4FFVqs93Uh9y3M0oM9rjzNm8d9bk5VVgX3QgzC7Tp5R4zwZO0qcRWUoqNj7Bsp6Xl5RFXpASL7BTWalpxXJ6TkViZmMq4O/LAYXa8fsUHbKIg7p1DcbIbbCcA8hRbLrjCSXwFiQWiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMulaKug; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712557336; x=1744093336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zrm/wvyh0xkh9uGwTCqa1YeOhLPuzSzzYRBCkJY6zAg=;
  b=aMulaKugh7UJai1u7w8wae9OJE5l3nJaO8cxtibgPxXmXCNadZifyUWi
   a7kxdv/LJZ8XTqA2dTiZXI4GoEoX0l3WfF+yfAche23e8l3ePYJhGLdfe
   suHRtnNBptLmyohnU16HeAzQl/s39I8v+DSOGLwHYvxnbvvhdcRDwfivE
   xknUdF9VHHbSZDkjHHJjaSFXvloh1e6Dbfl/74rqaRWREimy9kfDEzkAB
   HgTejkwbOCSZ3g520aK5Mp5G/f30JtWH68uv1ipWzOEuMvwZAbnnh7llr
   uPya3LfGPznL92lMo6QcpbaMY7K5YCN0d5aigTwW/iABcz4FoaruJAvSd
   g==;
X-CSE-ConnectionGUID: 4DX4JlVfTvih4uWzRYbl1Q==
X-CSE-MsgGUID: ielZVIqRRIaWUd9FjrESWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7940466"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7940466"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:22:15 -0700
X-CSE-ConnectionGUID: Pu0oYijaTpyA84VUyhTUPg==
X-CSE-MsgGUID: 7yLmEzAxSROmn3MKm8uGmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="50977361"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:22:14 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: intel_ace2x: use legacy formula for intel_alh_id
Date: Mon,  8 Apr 2024 06:22:06 +0000
Message-Id: <20240408062206.421326-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Starting with Lunar Lake, the notion of ALH is mostly irrelevant,
since the HDaudio DMAs are used. However the firmware still relies on
an 'ALH gateway' with a 'node_id' based on the same formula.

This patch in isolation has no functional impact, it's only when the
ASoC parts use it that we will see a changed behavior.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 4910cab22273..75e629c938dc 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -302,6 +302,11 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 		goto error;
 	}
 
+	/* use same definitions for alh_id as previous generations */
+	pdi->intel_alh_id = (sdw->instance * 16) + pdi->num + 3;
+	if (pdi->num >= 2)
+		pdi->intel_alh_id += 2;
+
 	/* the SHIM will be configured in the callback functions */
 
 	sdw_cdns_config_stream(cdns, ch, dir, pdi);
-- 
2.34.1



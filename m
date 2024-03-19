Return-Path: <linux-kernel+bounces-106976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67687F636
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36191F2292D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D277BB1E;
	Tue, 19 Mar 2024 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="atfdZVuW"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98AE7BAF7;
	Tue, 19 Mar 2024 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820574; cv=none; b=hd0D9FTa+/MIMB5Ba3psdD6mhWMfYWYdGGHdSewfV4XLfNlDUWBcsQzO5ayxrKxllose6qeobCzwsBBQh35Ok1/O5K421PCSoiUn7swW06nU8/koddh9AVpF32ij8pfSk27QEvzbqF52E/pAXWArWcS5dTdUimIpFc8JrD8SxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820574; c=relaxed/simple;
	bh=iyb8H4Jp8rxsdGteD+xvj4n9KobPYhd4mb8G65zKrMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tin0Eoe7iS1WD75AoRJ/vSG2JiE9o1VntnnxnI0+8X55NU8Zp7wqOSe9CxYWP45JE3kmuBGzGCl7l87SrWqD9llC/cQwJq2lsg/cvJz3+lf7Lkn17KgMsFILhCaQX70ka95WSgAr4UAWzbkmykH0ukswCBp8r55ZI6Iw8f/96BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=atfdZVuW; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710820572; x=1742356572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iyb8H4Jp8rxsdGteD+xvj4n9KobPYhd4mb8G65zKrMM=;
  b=atfdZVuWcnpFN+oH/EgdY2hw7ywyrqDE47lDJjVXcjpvzonibtD+mQbQ
   /Bxx1cMhFbCPgLl5jCGUNkQ+/ShTLIt6/YyVg8OEHMZVBOtKPbuKivHLM
   OnEQXvBLzKlGGk914V3hbqy7rV0RJJMCrtCm5iSSoKPAhT5Vb6T2Ji8OY
   6mYimc6n90JPeyL1DJ/uLwPIWMP0jpg1jUqtJAVJd1qfGlDQTfIvDXmBR
   vpWMpNoclZLQT2h5W5pu46av3GKLBPjAAxQdMbLhjbBa0k7wKZkPlvhmN
   0ki3mUWVT9r8/zNPxzUgDl6IqTc0Md4Icxezi5mQiE3EaBhdm1CqXqjt7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="140289575"
X-IronPort-AV: E=Sophos;i="6.07,135,1708354800"; 
   d="scan'208";a="140289575"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 12:56:08 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 13624D9F00;
	Tue, 19 Mar 2024 12:56:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D303D5A02;
	Tue, 19 Mar 2024 12:56:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C9CF61EAC12;
	Tue, 19 Mar 2024 12:56:04 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 074881A006B;
	Tue, 19 Mar 2024 11:55:58 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm,fbdev: td043mtea1: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 11:55:55 +0800
Message-Id: <20240319035555.1577734-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.004
X-TMASE-Result: 10--6.993400-10.000000
X-TMASE-MatchedRID: vWLMKRYJCzcbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u9hCyUKzFE4pMOmbgJn0O1cd5G
	gTXcmX3z/gi5MRR1gmq+lAgAwPD5q0OVyXblM7jP+xRIVoKNMvNiPDVCot+tGBET8F2y8zKEYdS
	DeLvQ19lun5ICGwWKCEriUbUlPOKO1UOlz1sLXchF4zyLyne+AUrr7Qc5WhKhzvn1t6wuaa+zst
	h4cn4jroa8IWqgpLBOAMuqetGVetksDkkP3zIjq3QfwsVk0UbtuRXh7bFKB7qOOXt5BU5y6WbW/
	lbxeI8DFks+BRjeYgccgXIv3OTHQPpCuffGH9zI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Neil Armstrong <neil.armstrong@linaro.org>
CC: Jessica Zhang <quic_jesszhan@quicinc.com>
CC: Sam Ravnborg <sam@ravnborg.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Thomas Zimmermann <tzimmermann@suse.de>
CC: David Airlie <airlied@gmail.com>
CC: Daniel Vetter <daniel@ffwll.ch>
CC: Helge Deller <deller@gmx.de>
CC: linux-omap@vger.kernel.org
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
   Fix missing '+' before '=' in drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c        | 13 ++++---------
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c    | 12 ++++--------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index cf4609bb9b1d..0983fe47eb5a 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -242,16 +242,11 @@ static ssize_t gamma_show(struct device *dev, struct device_attribute *attr,
 	struct td043mtea1_panel *lcd = dev_get_drvdata(dev);
 	ssize_t len = 0;
 	unsigned int i;
-	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(lcd->gamma); i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len, "%u ",
-			       lcd->gamma[i]);
-		if (ret < 0)
-			return ret;
-		len += ret;
-	}
-	buf[len - 1] = '\n';
+	for (i = 0; i < ARRAY_SIZE(lcd->gamma); i++)
+		len += sysfs_emit_at(buf, len, "%u ", lcd->gamma[i]);
+	if (len)
+		buf[len - 1] = '\n';
 
 	return len;
 }
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 477789cff8e0..3624452e1dd0 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -228,14 +228,10 @@ static ssize_t tpo_td043_gamma_show(struct device *dev,
 	int ret;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ddata->gamma); i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len, "%u ",
-				ddata->gamma[i]);
-		if (ret < 0)
-			return ret;
-		len += ret;
-	}
-	buf[len - 1] = '\n';
+	for (i = 0; i < ARRAY_SIZE(ddata->gamma); i++)
+		len += sysfs_emit_at(buf, len, "%u ", ddata->gamma[i]);
+	if (len)
+		buf[len - 1] = '\n';
 
 	return len;
 }
-- 
2.29.2



Return-Path: <linux-kernel+bounces-104075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF9E87C8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500F31C221CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA4134C4;
	Fri, 15 Mar 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="N3w3+JOL"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C58F70;
	Fri, 15 Mar 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481955; cv=none; b=qCOUTjFqD14ahGu7g5vJ2iYgY1DNIy4yeTpXXDCaTvR3a5RKY9UxhOz7htTjLAa5U+YW49eWGEIaOl0nJf1TQNOfpb3Qg0OkhCCRvD6+gmbEhYNQ61sRB1O1tof2J+kOEDPEYsqEbjTHJFbXgKXQ7CAjw/8fPyV5whSF9Mq/WmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481955; c=relaxed/simple;
	bh=GaRvUMYJRgQO4S22m+dRiQR4wBFciE7wN7V24w8WpVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNEDlH4K7t+CFXDn+yP5AyV53LRCpYv6dOAT84gsNLHbx0VfJvBIXHV0lr8q029dkGThzWF7tRQTWGaH9wIVn/8AxQhNQPBb22cKnoRUY38FullyyNHjoMuMMX1gPzbWI9Ep8Zd1KoNEoBXuOEf6PtsLHlGCgR2ZngJ01aicMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=N3w3+JOL; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710481953; x=1742017953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GaRvUMYJRgQO4S22m+dRiQR4wBFciE7wN7V24w8WpVE=;
  b=N3w3+JOLokBFrRwj8exxSquKWsLAwnKF5uVK9QkIQmoYejeoTum/bLrO
   arnoKuJZO8YoJ3ZwXcKh0mAxIKp15zBypSeywEMSx77ycxyPHIymvlLf7
   6lopIR7uHyfJpRU1+Z4ZSo/pW4wPrVlJ/ehmeO7/jLouE0C2sdy8NrYeQ
   /ecuTlQ2xTxgc56G8qiHGGuI4vVwMMTdI6cP0pUq5n6ZN+DbDD7qWQtl0
   AjhNvLUBbzRvnqmPrZLG6oje/U2jiREPw0/OnFCSmkAhDkh1Xxl/iOtu1
   6DLj0/EM2g+UWSdpxghpwVgYOkkk88/z9XzYkSwQj0BS1cN92019k/kNC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="131718016"
X-IronPort-AV: E=Sophos;i="6.07,127,1708354800"; 
   d="scan'208";a="131718016"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 14:52:30 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F0CDC21AA;
	Fri, 15 Mar 2024 14:52:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BCC87206005;
	Fri, 15 Mar 2024 14:52:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6058D202CCD27;
	Fri, 15 Mar 2024 14:52:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id F25FA1A006E;
	Fri, 15 Mar 2024 13:52:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: ti: Convert sprintf/snprintf to sysfs_emit
Date: Fri, 15 Mar 2024 13:52:11 +0800
Message-Id: <20240315055211.1347548-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240315055211.1347548-1-lizhijian@fujitsu.com>
References: <20240315055211.1347548-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28252.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28252.004
X-TMASE-Result: 10--5.172400-10.000000
X-TMASE-MatchedRID: /mcjwogdDrk4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2NqnJEIlJ6Y9uLV5fSMRD1zq8Jg
	qp/3e7heEkt/L8HtAJ785xNkZcrN2ePWEUnWb98FBDn6Fjq77jvioIsi7Sa0gwLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxEi2pD9yuITpisGdm68NWTHaNJ/iTxXCafS0Ip2eEHnwj/1Rbkzl1EymDn
	I5x2hWCjoczmuoPCq0Nn6pNPJRC8NOThyVNyDhs53U0BEDMf+ClEs0EKf18lWQ2h0Kw1ovG
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Kalle Valo <kvalo@kernel.org>
CC: linux-wireless@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: subject updated

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/net/wireless/ti/wlcore/sysfs.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sysfs.c b/drivers/net/wireless/ti/wlcore/sysfs.c
index f0c7e09b314d..c07acfcbbd9c 100644
--- a/drivers/net/wireless/ti/wlcore/sysfs.c
+++ b/drivers/net/wireless/ti/wlcore/sysfs.c
@@ -19,11 +19,8 @@ static ssize_t bt_coex_state_show(struct device *dev,
 	struct wl1271 *wl = dev_get_drvdata(dev);
 	ssize_t len;
 
-	len = PAGE_SIZE;
-
 	mutex_lock(&wl->mutex);
-	len = snprintf(buf, len, "%d\n\n0 - off\n1 - on\n",
-		       wl->sg_enabled);
+	len = sysfs_emit(buf, "%d\n\n0 - off\n1 - on\n", wl->sg_enabled);
 	mutex_unlock(&wl->mutex);
 
 	return len;
@@ -78,13 +75,11 @@ static ssize_t hw_pg_ver_show(struct device *dev,
 	struct wl1271 *wl = dev_get_drvdata(dev);
 	ssize_t len;
 
-	len = PAGE_SIZE;
-
 	mutex_lock(&wl->mutex);
 	if (wl->hw_pg_ver >= 0)
-		len = snprintf(buf, len, "%d\n", wl->hw_pg_ver);
+		len = sysfs_emit(buf, "%d\n", wl->hw_pg_ver);
 	else
-		len = snprintf(buf, len, "n/a\n");
+		len = sysfs_emit(buf, "n/a\n");
 	mutex_unlock(&wl->mutex);
 
 	return len;
-- 
2.29.2



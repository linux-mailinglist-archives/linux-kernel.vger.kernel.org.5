Return-Path: <linux-kernel+bounces-105621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493D87E1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9F9B21C79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891B71D54A;
	Mon, 18 Mar 2024 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iduGRWLO"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93472032C;
	Mon, 18 Mar 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725343; cv=none; b=Apc8pUdVouqLyJyUipoEaIh9HpV0WEblpps+35sm2Z43umo2vXTGEvuOmRuoxUeVU/UBPPuoR/q7vb3wIlAMd8V+T2MmdFFx8S3X4hl7Ra1GdnfkcoZOhrJ55yE4Ywv1tf1t6H1rPx2Caj8mwKgZUzXu5y7yC0S4AYRZUblGCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725343; c=relaxed/simple;
	bh=Taji648BJ3gDaRhagaa2XtRCbo14juKZEgZcaAyYeJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbC74pDoWYT1ZNWZ92FrLwVao0z3r2kbvHzSbrKdtawufbCizktf4avZW8GILkv5R0zn7ZPTBU+Lw5lr5zELJr0Xn5dTuDqaH7eR34vCtNW6dGnOk22dJFfFkMVeRTxB6pv/ufFz1e5aXywnhM/SCsQAUR7cFzGLsav4ifiAyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iduGRWLO; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710725341; x=1742261341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Taji648BJ3gDaRhagaa2XtRCbo14juKZEgZcaAyYeJw=;
  b=iduGRWLOkQtZI0jvJmRW5/8PY2J5J+LzKV6IX1tcMupJiA/9ogSQsLqR
   eTzbQjmdzDh43sJGMBVRpQdcygYMnos2dFpPJYTf3Z/j8WAkMMKBWe0ym
   EHvU0udz+e7GkwDgLnTr2erBd22rrrvp8RhEcbuqXHmLM/xqan4mLj3Lp
   QVcHWHQIxv5TCpk4Hr8VM7nU5XQqebu7SKvXNao1kfEKPRIuhnGRRPI9j
   BzcBSm+USXnYwNUrNi0DDZwbjreyzKgJQg7q8burddMx0NblRmYqluQaw
   qW6jRDdj6+eP8dQi/G3KkJuyuKQ29P8Uyk/kYpKYiIwkkFFqCNnqwYOeQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="152408373"
X-IronPort-AV: E=Sophos;i="6.07,133,1708354800"; 
   d="scan'208";a="152408373"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:28:52 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B6AC2C21A4;
	Mon, 18 Mar 2024 10:28:49 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DC6F6D6221;
	Mon, 18 Mar 2024 10:28:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76C68200A7D5A;
	Mon, 18 Mar 2024 10:28:48 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E8BCB1A006A;
	Mon, 18 Mar 2024 09:28:47 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v3 3/4] HID: roccat: Convert sprintf/snprintf to sysfs_emit
Date: Mon, 18 Mar 2024 09:28:18 +0800
Message-Id: <20240318012819.1405003-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240318012819.1405003-1-lizhijian@fujitsu.com>
References: <20240318012819.1405003-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28258.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28258.003
X-TMASE-Result: 10--12.236400-10.000000
X-TMASE-MatchedRID: APZBv0eB5fI4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSK0+leiJxLlf0swHSFcVJ6C99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+m5x7uAXGEprcE5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc0724j+mhsXnCs/XK4XmHd63JHzmmMD/HXF+MCcAfUypiVjFu9dqRsNfOPxrx
	i5QEx5YO3wTUW8jWH4XVbmZeaDTs5H0YXYnbGozFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHueR6O
	rkFNSKI4FxqRn0IADtjgE302w6R+aPIdl86jyFawFMlIPaIBbQ==
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

CC: Stefan Achatz <erazor_de@users.sourceforge.net>
CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hid/hid-roccat-isku.c     |  2 +-
 drivers/hid/hid-roccat-kone.c     | 12 ++++++------
 drivers/hid/hid-roccat-koneplus.c |  4 ++--
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 drivers/hid/hid-roccat-pyra.c     |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 458060403397..0cd6208fb371 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -61,7 +61,7 @@ static ssize_t isku_sysfs_show_actual_profile(struct device *dev,
 {
 	struct isku_device *isku =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", isku->actual_profile);
+	return sysfs_emit(buf, "%d\n", isku->actual_profile);
 }
 
 static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 00a1abc7e839..3f8f459edcf3 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -400,7 +400,7 @@ static ssize_t kone_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_profile);
+	return sysfs_emit(buf, "%d\n", kone->actual_profile);
 }
 static DEVICE_ATTR(actual_profile, 0440, kone_sysfs_show_actual_profile, NULL);
 
@@ -409,7 +409,7 @@ static ssize_t kone_sysfs_show_actual_dpi(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_dpi);
+	return sysfs_emit(buf, "%d\n", kone->actual_dpi);
 }
 static DEVICE_ATTR(actual_dpi, 0440, kone_sysfs_show_actual_dpi, NULL);
 
@@ -432,7 +432,7 @@ static ssize_t kone_sysfs_show_weight(struct device *dev,
 
 	if (retval)
 		return retval;
-	return snprintf(buf, PAGE_SIZE, "%d\n", weight);
+	return sysfs_emit(buf, "%d\n", weight);
 }
 static DEVICE_ATTR(weight, 0440, kone_sysfs_show_weight, NULL);
 
@@ -441,7 +441,7 @@ static ssize_t kone_sysfs_show_firmware_version(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->firmware_version);
+	return sysfs_emit(buf, "%d\n", kone->firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440, kone_sysfs_show_firmware_version,
 		   NULL);
@@ -451,7 +451,7 @@ static ssize_t kone_sysfs_show_tcu(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.tcu);
+	return sysfs_emit(buf, "%d\n", kone->settings.tcu);
 }
 
 static int kone_tcu_command(struct usb_device *usb_dev, int number)
@@ -553,7 +553,7 @@ static ssize_t kone_sysfs_show_startup_profile(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.startup_profile);
+	return sysfs_emit(buf, "%d\n", kone->settings.startup_profile);
 }
 
 static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 22b895436a7c..8ccb3b14a1a9 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -242,7 +242,7 @@ static ssize_t koneplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct koneplus_device *koneplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", koneplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", koneplus->actual_profile);
 }
 
 static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
@@ -309,7 +309,7 @@ static ssize_t koneplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KONEPLUS_SIZE_INFO);
 	mutex_unlock(&koneplus->koneplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   koneplus_sysfs_show_firmware_version, NULL);
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 86af538c10d6..748d4d7cb2fc 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -272,7 +272,7 @@ static ssize_t kovaplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_profile);
 }
 
 static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
@@ -325,7 +325,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, NULL);
 
@@ -334,7 +334,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_x_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_x_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_x, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_x, NULL);
@@ -344,7 +344,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_y_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_y_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_y, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_y, NULL);
@@ -365,7 +365,7 @@ static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KOVAPLUS_SIZE_INFO);
 	mutex_unlock(&kovaplus->kovaplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   kovaplus_sysfs_show_firmware_version, NULL);
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 5663b9cd9c69..eeb3d38cd805 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -283,7 +283,7 @@ static ssize_t pyra_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct pyra_device *pyra =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", pyra->actual_cpi);
+	return sysfs_emit(buf, "%d\n", pyra->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
 
@@ -300,7 +300,7 @@ static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 			&settings, PYRA_SIZE_SETTINGS);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", settings.startup_profile);
+	return sysfs_emit(buf, "%d\n", settings.startup_profile);
 }
 static DEVICE_ATTR(actual_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
 static DEVICE_ATTR(startup_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
@@ -321,7 +321,7 @@ static ssize_t pyra_sysfs_show_firmware_version(struct device *dev,
 			&info, PYRA_SIZE_INFO);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440, pyra_sysfs_show_firmware_version,
 		   NULL);
-- 
2.29.2



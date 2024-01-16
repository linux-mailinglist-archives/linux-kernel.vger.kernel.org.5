Return-Path: <linux-kernel+bounces-26999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C538082E8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168EB1F23AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625112B9B;
	Tue, 16 Jan 2024 04:53:36 +0000 (UTC)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D911C84;
	Tue, 16 Jan 2024 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125645470"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125645470"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:20 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A6D11D6188;
	Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E32D2D1037;
	Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E6636B4C5;
	Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2BA571A015F;
	Tue, 16 Jan 2024 12:52:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 10/42]  drivers/hid/hid-roccat-*: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:19 +0800
Message-Id: <20240116045151.3940401-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--14.475000-10.000000
X-TMASE-MatchedRID: 6n1zk+md1nUbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQclB
	Lll1g/6SBNyCmIook0dM0AWQBBcXdpRSkbxKeJc4K0+leiJxLlf0swHSFcVJ6DoUdFbHYUawvwU
	evDt+uW5/XjpbSJS7a0NziVKCujClzYigC8AbwLLfSQNpZkETVBgff28UuvITATcg4/ageygDLs
	WB7rAWWw4Xs7pbWEXf7s2Nt+r3hd9Vdkt0SbCMkW/6CCblACLhfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtX28xNpU0U3NhU2eCowgLsevf3R1I+ALA478u2VNp3LSHqCbfj0eF4g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/hid/hid-roccat-isku.c:64:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kone.c:403:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kone.c:412:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kone.c:435:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kone.c:444:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kone.c:454:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kone.c:556:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-koneplus.c:245:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-koneplus.c:312:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kovaplus.c:275:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kovaplus.c:328:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kovaplus.c:337:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kovaplus.c:347:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-kovaplus.c:368:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-pyra.c:286:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-pyra.c:303:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-roccat-pyra.c:324:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Stefan Achatz <erazor_de@users.sourceforge.net>
CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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



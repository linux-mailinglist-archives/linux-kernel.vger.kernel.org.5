Return-Path: <linux-kernel+bounces-23827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3F82B262
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F23D1C23B11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757484F5F2;
	Thu, 11 Jan 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL28c4Ea"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADB2943E;
	Thu, 11 Jan 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b5155e154so70618325e9.3;
        Thu, 11 Jan 2024 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704989112; x=1705593912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgO2C2K3sxaq3X2gNkwdf4lQCjnJmutMW83/EFN7dt0=;
        b=eL28c4EapICFEDNr3AEuiHZEnIwsUy5v6Mb3dOyqz9vdu4b0SZnAJDspLmL8VLCRh0
         x8ErxBqFDLm4/97NaY4UywQDU9lzhzEXY/8YQR5gTjUj6HSLZJCnBCNaKhx20c4APltE
         DpQC6xFCcvDLGgkf+JKm1GTdzyyA/goFY+NulimyYG9un4JEtYuykvJJBSDiZGBVsD2w
         tq8Tp50DeGj5i+QssCW89US00Us9ji6hz3u2Q31Bs4Vv8c+9Id8l7UeOi420y/MZN1ZZ
         bNMYQSmowgxiogYxtzQ88+GaYnTIrmzIWbJzjdFgxOGw35Ou3DKHLKqYOEuWix6ieNMO
         u2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989112; x=1705593912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgO2C2K3sxaq3X2gNkwdf4lQCjnJmutMW83/EFN7dt0=;
        b=wAo0X4/hEZhaMRIsaKqpncc8E3U4+Dund6PwhyudUs9plEOlOtGbNf2uTdCa1ScL+1
         nTTjZesCyP2mkkisjZ3k/DjSJm1mSBqG89ClsbvqsCQnt4jYG/3oKyCqAigkvExsc4OR
         7HLPJnTK9w4UffKKvnKlRnKQPA3lfU665IY6pdtwfh8KmsXgJEQfApwZfJMyssOmnJfR
         pGx4bYnHdraRth5soo5obxTIKuO0yfWoYXapO4xLDVMt2u/Hk7OkQMhQdfAGefA4qUyF
         51vDN0clW6osq+8KWZqVT27Kc9Cr5Jcs2AOr2nC+W3NbiCKyMbzYQRnNi+EWDTueyv2+
         KGmA==
X-Gm-Message-State: AOJu0Yx+3PnPFlheUhovGLItIxglLf+HTWh5zqXwebMeR1LVKKsy901T
	JsyFGF5wK2Fav8mYn02lSDX/1QwEsSY=
X-Google-Smtp-Source: AGHT+IG0ZFylnjLHXdar+VdcLLJKa3U55RoK0ZJtMTczmgtKLboA+3b6ojAWNCZP40TyNWVSlUYhaQ==
X-Received: by 2002:a05:600c:5251:b0:40e:490a:ed59 with SMTP id fc17-20020a05600c525100b0040e490aed59mr20601wmb.114.1704989111550;
        Thu, 11 Jan 2024 08:05:11 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm6350002wms.25.2024.01.11.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:05:10 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v7 1/2] leds: trigger: netdev: display only supported link speed attribute
Date: Thu, 11 Jan 2024 17:04:54 +0100
Message-ID: <20240111160501.1774-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the addition of more link speed mode to the netdev trigger, it was
pointed out that there may be a problem with bloating the attribute list
with modes that won't ever be supported by the trigger as the attached
device name doesn't support them.

To clear and address this problem, change the logic where these
additional trigger modes are listed.

Since the netdev trigger REQUIRE a device name to be set, attach to the
device name change function additional logic to parse the supported link
speed modes using ethtool APIs and show only the supported link speed
modes attribute.

Link speed attribute are refreshed on device_name set and on
NETDEV_CHANGE events.

This only apply to the link speed modes and every other mode is still
provided by default.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
Took a while but I found a way to not use phy_speeds.

Saddly that is way too specific to PHYs and we can't add PHYLIB as
a dependency for leds.

I instead found a handy way to keep everything to ethtool, it's a bit
worse optimization wise but does the same work. (the perf penality
is really minimal as we only parse supported speeds and it's difficult
to have a device that have tons of speeds modes)

Changes v7:
- Fix comments to follow normal linux instead of net format
Changes v6:
- Improve comments wording
- Add Reviewed-by tag
Changes v5:
- Add macro to make code less ugly
Changes v4:
- Rework to use an alternative to phy_speeds API
Changes v3:
- Use phy_speeds API to parse the ethtool mask
Changes v2:
- Use is_visibile instead of removing/adding attr

 drivers/leds/trigger/ledtrig-netdev.c | 90 +++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 836610292b37..5807385593dc 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -18,10 +18,12 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/linkmode.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
+#include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/timer.h>
 #include "../leds.h"
@@ -65,12 +67,15 @@ struct led_netdev_data {
 
 	unsigned long mode;
 	int link_speed;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_link_modes);
 	u8 duplex;
 
 	bool carrier_link_up;
 	bool hw_control;
 };
 
+static const struct attribute_group netdev_trig_link_speed_attrs_group;
+
 static void set_baseline_state(struct led_netdev_data *trigger_data)
 {
 	int current_brightness;
@@ -218,13 +223,20 @@ static void get_device_state(struct led_netdev_data *trigger_data)
 	struct ethtool_link_ksettings cmd;
 
 	trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
-	if (!trigger_data->carrier_link_up)
+
+	if (__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd))
 		return;
 
-	if (!__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd)) {
+	if (trigger_data->carrier_link_up) {
 		trigger_data->link_speed = cmd.base.speed;
 		trigger_data->duplex = cmd.base.duplex;
 	}
+
+	/*
+	 * Have a local copy of the link speed supported to avoid rtnl lock every time
+	 * modes are refreshed on any change event
+	 */
+	linkmode_copy(trigger_data->supported_link_modes, cmd.link_modes.supported);
 }
 
 static ssize_t device_name_show(struct device *dev,
@@ -292,6 +304,10 @@ static ssize_t device_name_store(struct device *dev,
 
 	if (ret < 0)
 		return ret;
+
+	/* Refresh link_speed visibility */
+	sysfs_update_group(&dev->kobj, &netdev_trig_link_speed_attrs_group);
+
 	return size;
 }
 
@@ -455,15 +471,63 @@ static ssize_t offloaded_show(struct device *dev,
 
 static DEVICE_ATTR_RO(offloaded);
 
-static struct attribute *netdev_trig_attrs[] = {
-	&dev_attr_device_name.attr,
-	&dev_attr_link.attr,
+#define CHECK_LINK_MODE_ATTR(link_speed) \
+	do { \
+		if (attr == &dev_attr_link_##link_speed.attr && \
+		    link_ksettings.base.speed == SPEED_##link_speed) \
+			return attr->mode; \
+	} while (0)
+
+static umode_t netdev_trig_link_speed_visible(struct kobject *kobj,
+					      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct led_netdev_data *trigger_data;
+	unsigned long *supported_link_modes;
+	u32 mode;
+
+	trigger_data = led_trigger_get_drvdata(dev);
+	supported_link_modes = trigger_data->supported_link_modes;
+
+	/*
+	 * Search in the supported link mode mask a matching supported mode.
+	 * Stop at the first matching entry as we care only to check if a particular
+	 * speed is supported and not the kind.
+	 */
+	for_each_set_bit(mode, supported_link_modes, __ETHTOOL_LINK_MODE_MASK_NBITS) {
+		struct ethtool_link_ksettings link_ksettings;
+
+		ethtool_params_from_link_mode(&link_ksettings, mode);
+
+		CHECK_LINK_MODE_ATTR(10);
+		CHECK_LINK_MODE_ATTR(100);
+		CHECK_LINK_MODE_ATTR(1000);
+		CHECK_LINK_MODE_ATTR(2500);
+		CHECK_LINK_MODE_ATTR(5000);
+		CHECK_LINK_MODE_ATTR(10000);
+	}
+
+	return 0;
+}
+
+static struct attribute *netdev_trig_link_speed_attrs[] = {
 	&dev_attr_link_10.attr,
 	&dev_attr_link_100.attr,
 	&dev_attr_link_1000.attr,
 	&dev_attr_link_2500.attr,
 	&dev_attr_link_5000.attr,
 	&dev_attr_link_10000.attr,
+	NULL
+};
+
+static const struct attribute_group netdev_trig_link_speed_attrs_group = {
+	.attrs = netdev_trig_link_speed_attrs,
+	.is_visible = netdev_trig_link_speed_visible,
+};
+
+static struct attribute *netdev_trig_attrs[] = {
+	&dev_attr_device_name.attr,
+	&dev_attr_link.attr,
 	&dev_attr_full_duplex.attr,
 	&dev_attr_half_duplex.attr,
 	&dev_attr_rx.attr,
@@ -472,7 +536,16 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_offloaded.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(netdev_trig);
+
+static const struct attribute_group netdev_trig_attrs_group = {
+	.attrs = netdev_trig_attrs,
+};
+
+static const struct attribute_group *netdev_trig_groups[] = {
+	&netdev_trig_attrs_group,
+	&netdev_trig_link_speed_attrs_group,
+	NULL,
+};
 
 static int netdev_trig_notify(struct notifier_block *nb,
 			      unsigned long evt, void *dv)
@@ -481,6 +554,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		netdev_notifier_info_to_dev((struct netdev_notifier_info *)dv);
 	struct led_netdev_data *trigger_data =
 		container_of(nb, struct led_netdev_data, notifier);
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
 	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
@@ -515,6 +589,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
 		get_device_state(trigger_data);
+		/* Refresh link_speed visibility */
+		if (evt == NETDEV_CHANGE)
+			sysfs_update_group(&led_cdev->dev->kobj,
+					   &netdev_trig_link_speed_attrs_group);
 		break;
 	}
 
-- 
2.43.0



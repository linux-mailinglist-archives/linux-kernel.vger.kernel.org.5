Return-Path: <linux-kernel+bounces-7608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7A81AAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99031F246FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BDA4CB22;
	Wed, 20 Dec 2023 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKiIzYXE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44C4AF8F;
	Wed, 20 Dec 2023 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso2439455e9.1;
        Wed, 20 Dec 2023 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703112543; x=1703717343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLG+WS5lbsTbYWBSLepysO/8E3wFqMQRDPLf36qaA0M=;
        b=HKiIzYXEtwM/SRDi7ZKNZoJ7+c6Kxut8nTwet/uWbAmsvfA7CPAq62y/04LYqJ+u7s
         AByoVKwI9TvE4fo/Q7LMFVIt9cs1Ra6LzcGOCQNeCx+1zNRt9iJrutNqOOWfN6gv4lqi
         rEF/l+o2/B1KFAFrvKBkjd+y3xO2pDCGHfOMQWAqApo/mQVtoh2lZtgsZJRA8IQ1kfcB
         s9kUdFn6z8/wACQcb0/YWcW66bZLdgu0Ygoq4b51v5ZQptoWrqvI9E8GT09ologryhIm
         ME6qGi5/CZNuK5/my15GY8jl2UU9vGU67WorZtZkmuZhlfcq/QzrcVRjGEK8qVQ9YdoA
         QDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703112543; x=1703717343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLG+WS5lbsTbYWBSLepysO/8E3wFqMQRDPLf36qaA0M=;
        b=hEkhVLawlUcpfDueDgTeATw4M+VblDwScVJutD/g7euilnSTcKf0dbOlZY8yAwuQzG
         7JXU1TKcqDoGSlr5vn03ueMOvcIjM2XfAYY2+vRsb0avNtrwsZ7m86k1a7ZUuCneBjnu
         Kt0rnFalQIyIAVa3ObG5CA043t4ji0rwJYIkdK/Vr0cL0+ddlbZr/Vsy0BFhxIab1FDG
         DgZXooqsCh1uhqT3ILJohi8jTrPHRWhcI3j1pOIuUrLVrgsMsJh7tihcpSgb86qh9Tnx
         PMjxgUvpyLyRxwDnlZfbje04MkM0R7LsqrzQfJtT0WpE3HZQA58n5asFtp260aOdslkn
         74Rg==
X-Gm-Message-State: AOJu0Yzu41NwmXt0QsQJXQK1m+VJlH7gXIzXi3h4tkKa6stis51hxmue
	LtS5njgmFFtK5S+SizupQxc=
X-Google-Smtp-Source: AGHT+IFLNDANIsk/nrBsWUpkjfW6CcYSQRB+d5kBoTMuJmq0txW+IAJ8Iu6SRZbw1Jn86kU8hj9BmA==
X-Received: by 2002:a05:600c:68c8:b0:40d:379c:f749 with SMTP id jd8-20020a05600c68c800b0040d379cf749mr181795wmb.198.1703112543157;
        Wed, 20 Dec 2023 14:49:03 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id bi8-20020a05600c3d8800b0040d28bbaf7bsm8220838wmb.10.2023.12.20.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:49:02 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v5 1/2] leds: trigger: netdev: display only supported link speed attribute
Date: Wed, 20 Dec 2023 23:48:26 +0100
Message-Id: <20231220224827.27667-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
Took a while but I found a way to not use phy_speeds.

Saddly that is way too specific to PHYs and we can't add PHYLIB as
a dependency for leds.

I instead found a handy way to keep everything to ethtool, it's a bit
worse optimization wise but does the same work. (the perf penality
is really minimal as we only parse supported speeds and it's difficult
to have a device that have tons of speeds modes)

Changes v5:
- Add macro to make code less ugly
Changes v4:
- Rework to use an alternative to phy_speeds API
Changes v3:
- Use phy_speeds API to parse the ethtool mask
Changes v2:
- Use is_visibile instead of removing/adding attr

 drivers/leds/trigger/ledtrig-netdev.c | 88 +++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index bd68da15c723..f0f946747ff5 100644
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
@@ -55,12 +57,15 @@ struct led_netdev_data {
 
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
@@ -208,13 +213,19 @@ static void get_device_state(struct led_netdev_data *trigger_data)
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
+	/* Have a local copy of the link speed supported to not rtnl lock every time
+	 * Modes are refreshed on any change event to handle mode changes
+	 */
+	linkmode_copy(trigger_data->supported_link_modes, cmd.link_modes.supported);
 }
 
 static ssize_t device_name_show(struct device *dev,
@@ -282,6 +293,10 @@ static ssize_t device_name_store(struct device *dev,
 
 	if (ret < 0)
 		return ret;
+
+	/* Refresh link_speed visibility */
+	sysfs_update_group(&dev->kobj, &netdev_trig_link_speed_attrs_group);
+
 	return size;
 }
 
@@ -440,15 +455,62 @@ static ssize_t offloaded_show(struct device *dev,
 
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
+	/* Search in the supported link mode mask a matching supported mode.
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
@@ -457,7 +519,16 @@ static struct attribute *netdev_trig_attrs[] = {
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
@@ -466,6 +537,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		netdev_notifier_info_to_dev((struct netdev_notifier_info *)dv);
 	struct led_netdev_data *trigger_data =
 		container_of(nb, struct led_netdev_data, notifier);
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
 	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
@@ -500,6 +572,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
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
2.40.1



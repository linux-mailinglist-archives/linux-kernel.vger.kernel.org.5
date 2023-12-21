Return-Path: <linux-kernel+bounces-8817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9681BCA9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B951C24868
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54459910;
	Thu, 21 Dec 2023 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5cQnDG8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790D5990A;
	Thu, 21 Dec 2023 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so10491695e9.3;
        Thu, 21 Dec 2023 09:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178702; x=1703783502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxyyNz03V4YUou6bGUQaIh6mW7VTZjF7uWLvt+WkU0A=;
        b=D5cQnDG8Ah4vEnofdcWJvcSC0ppVbRi8CoNKSFBeKoF/rcfok44xhXdTxZH2VstdF5
         /AmzlQ52d0Qp2YqUUqlbzQODbgEiYJMlRjUOIFXQO1n72qxuuq5uGsxDLmfQ6SW+FdXs
         PSthtFb2VanDqt1pjZ87g4JDkt38ealClPjazbqgQdnPT/AeUJXL7Hs7iTwXoN50PrGq
         R49KJg0K7kQEWoGlK2N7jAoUHktnvOmzqXBKH3OyhJXfeVhOXoGuUOBY1iBKEfdDUmuE
         TXb4V38ewidI+q0mrCHeXefYZ0/l5PupiWyBFnwzhJi9Jkl3wiDcj/04rR/9zhwWb6Ug
         d+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178702; x=1703783502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxyyNz03V4YUou6bGUQaIh6mW7VTZjF7uWLvt+WkU0A=;
        b=G9F6XXszzxqBYCDNI1kub4XEoZBqgXfkmvxdX6zLc6EsfEve9ztuXxC6EBgF9+Axvf
         Ae3HMY9QCBdXJULCM8SxRNKAR3DRrb3Uz03bZ4xD4umjn5A7rmK5BfCmBu1DoXKeCz8a
         89qcDWo08QdK6if4G2rKbuxS93hZVRlzIOXI5N4psK3wr7QuQ7t/W4CZjOYjuukMAiOM
         OMeYtH4DB6a6ZnOYOgy+8/hAmgBQDSeb74VIL7d719xq1vL3ZBUMz5+UoPyKBq1K42iE
         8QrRoJmXGstM5vNoKSWCwCdIsJcGdUzfkYDd6KTab7Sc/MQYOPZhIYM9MG8EgMyGloNC
         ykPg==
X-Gm-Message-State: AOJu0YwZ5NoIQpCagCjuUnt2RmNWE4LVcYimdavMAq8RJr1NGW37nLWw
	o9sKY9T/drJWnFaA7VXZYPA=
X-Google-Smtp-Source: AGHT+IE7x/1pngX0thSOSJPoes8nJoeTTiJkgTC7nrtg6gNdZoTGR3uUXHBNoLyTsDgrQYNxoa+jww==
X-Received: by 2002:a05:600c:524e:b0:40c:295f:1195 with SMTP id fc14-20020a05600c524e00b0040c295f1195mr28321wmb.55.1703178702368;
        Thu, 21 Dec 2023 09:11:42 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id m20-20020a05600c4f5400b0040c44b4a282sm4020727wmq.43.2023.12.21.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:11:41 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 1/2] leds: trigger: netdev: display only supported link speed attribute
Date: Thu, 21 Dec 2023 18:11:24 +0100
Message-Id: <20231221171125.1732-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

 drivers/leds/trigger/ledtrig-netdev.c | 88 +++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 836610292b37..f082a952bd4d 100644
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
@@ -218,13 +223,19 @@ static void get_device_state(struct led_netdev_data *trigger_data)
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
+	/* Have a local copy of the link speed supported to avoid rtnl lock every time
+	 * modes are refreshed on any change event
+	 */
+	linkmode_copy(trigger_data->supported_link_modes, cmd.link_modes.supported);
 }
 
 static ssize_t device_name_show(struct device *dev,
@@ -292,6 +303,10 @@ static ssize_t device_name_store(struct device *dev,
 
 	if (ret < 0)
 		return ret;
+
+	/* Refresh link_speed visibility */
+	sysfs_update_group(&dev->kobj, &netdev_trig_link_speed_attrs_group);
+
 	return size;
 }
 
@@ -455,15 +470,62 @@ static ssize_t offloaded_show(struct device *dev,
 
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
@@ -472,7 +534,16 @@ static struct attribute *netdev_trig_attrs[] = {
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
@@ -481,6 +552,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		netdev_notifier_info_to_dev((struct netdev_notifier_info *)dv);
 	struct led_netdev_data *trigger_data =
 		container_of(nb, struct led_netdev_data, notifier);
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
 	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
@@ -515,6 +587,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
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



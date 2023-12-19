Return-Path: <linux-kernel+bounces-5884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EEC8190FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77429285656
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B625D39863;
	Tue, 19 Dec 2023 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpunAdOT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552139846;
	Tue, 19 Dec 2023 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3363aa2bbfbso5286100f8f.0;
        Tue, 19 Dec 2023 11:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703014952; x=1703619752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2P9nyA4a467CCHc41H1cuZ6IA7gQD1kkIc1PJ1pADf4=;
        b=EpunAdOTMWULFLp18Nyi4Qc+QH25MGdlUWk2M57uMYOy/w2JfqkMunfuTR774tJJ6I
         h0NxTAMgtZOWmMgRE356uuzUeovuRAgoJE7TfSJNpDNt+3EVgglKeewzQ67WnrOGW1SJ
         Gi8injnGaq1eyWtrrAsxL8vLt2Twv5m4UoGXabRqEUqYbrc3mI9JfJdUUOMQrP31vElB
         9nUsOUaG4WZ3+dLHRmkCZJDlBI/GHsVKkx/XuFUdOejGZ7AUeOjWquEu4NozZD3C/mMf
         0mBPkLjznd47bcqrt+Qa80kGD3C4x0dfxMgGXROzxFRKSGHbujdywsUD7i83BQOIjUhK
         c53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703014952; x=1703619752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P9nyA4a467CCHc41H1cuZ6IA7gQD1kkIc1PJ1pADf4=;
        b=IiUDIYocPhXgRbWfEd3LrBMRgOzNaXG9emD8jvZ+t/XI2BtpmpRSj8l0xzqG/tII10
         u54RG1KdiGI1xD/OxBzH2QkqXgM+Xrao5I2a38j1KTtkBfrwH4QdToiDXtU8QNI05KrN
         nrk742IgQazV9ayKxk8+wJmJZrEHx36uqhUFvDVW0APAcE2neSWRWxbA6gtZgdMSMjXQ
         s+vwCwP+HMoOn6mvflJNMh4UV2UUjDXHichj8dXDt8DYfvOletMy80pMsKxp54Z6Nl8A
         k7UKDkVBCF9LFqbOIooCqzAOM6jYGCvI36BUxOmeBjBbbQuaE7KwZtXrlpoH58CU/1jT
         NK5g==
X-Gm-Message-State: AOJu0YybTrS3IUXr8Z7WNBt1kTCjC9JZ+Dkqf6I1sTKJ6/eARSounobi
	iJ3k1Eqv8yOY3+kmbs+POXM=
X-Google-Smtp-Source: AGHT+IHfhyAb2BYm823qDaESlPAIx0Z7KI6PIvKxHwArog+OsFDij0sQJbLnb+zJDvZ+nBjzkGshIA==
X-Received: by 2002:a5d:518d:0:b0:336:4c9d:8d1a with SMTP id k13-20020a5d518d000000b003364c9d8d1amr4460463wrv.35.1703014952293;
        Tue, 19 Dec 2023 11:42:32 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id f18-20020adffcd2000000b0033660aabe76sm9131524wrs.39.2023.12.19.11.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 11:42:31 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v4 1/2] leds: trigger: netdev: display only supported link speed attribute
Date: Tue, 19 Dec 2023 17:53:52 +0100
Message-Id: <20231219165353.23233-1-ansuelsmth@gmail.com>
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

Changes v4:
- Rework to use an alternative to phy_speeds API
Changes v3:
- Use phy_speeds API to parse the ethtool mask
Changes v2:
- Use is_visibile instead of removing/adding attr

 drivers/leds/trigger/ledtrig-netdev.c | 98 +++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index bd68da15c723..47733494aaf8 100644
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
 
@@ -440,15 +455,72 @@ static ssize_t offloaded_show(struct device *dev,
 
 static DEVICE_ATTR_RO(offloaded);
 
-static struct attribute *netdev_trig_attrs[] = {
-	&dev_attr_device_name.attr,
-	&dev_attr_link.attr,
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
+		if (attr == &dev_attr_link_10.attr &&
+		    link_ksettings.base.speed == SPEED_10)
+			return attr->mode;
+
+		if (attr == &dev_attr_link_100.attr &&
+		    link_ksettings.base.speed == SPEED_100)
+			return attr->mode;
+
+		if (attr == &dev_attr_link_1000.attr &&
+		    link_ksettings.base.speed == SPEED_1000)
+			return attr->mode;
+
+		if (attr == &dev_attr_link_2500.attr &&
+		    link_ksettings.base.speed == SPEED_2500)
+			return attr->mode;
+
+		if (attr == &dev_attr_link_5000.attr &&
+		    link_ksettings.base.speed == SPEED_5000)
+			return attr->mode;
+
+		if (attr == &dev_attr_link_10000.attr &&
+		    link_ksettings.base.speed == SPEED_10000)
+			return attr->mode;
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
@@ -457,7 +529,16 @@ static struct attribute *netdev_trig_attrs[] = {
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
@@ -466,6 +547,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		netdev_notifier_info_to_dev((struct netdev_notifier_info *)dv);
 	struct led_netdev_data *trigger_data =
 		container_of(nb, struct led_netdev_data, notifier);
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
 	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
@@ -500,6 +582,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
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



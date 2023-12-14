Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC372812FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572980AbjLNMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572970AbjLNMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:20:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9B112;
        Thu, 14 Dec 2023 04:20:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33621d443a7so4323087f8f.3;
        Thu, 14 Dec 2023 04:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702556458; x=1703161258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTkiSP+MxKrMId9/OvL1ZupidnFboSQTL72KpVM+M+Q=;
        b=ZyYLXhTCZJ20za5v8OZUf+gyif6hW9ysh1EVGUeRDIxnTYKgIxayk8ifMxc6DktRCq
         ofquPuFMl4uER6Js6HGPfVF8xJTDfqvVGyOWp5S3W5taCoKFeLu3NQyzvPvYym5oVhgM
         wpyX3dlhIx+i4llShr9NkIHMxeB2nuMWEn4n5I9pfiHO76DzJdBHJETHV9ymQH5md5hP
         PODLMVi45Lg4zio3GMQEK2bCEhrnmO4TOtXva3FNTKHbPTuVYZj3IWFfvY52XZsRIRX7
         H8kj4UHdk/7Dh+CHgb9R17LAtpxgP7lWuWU5wfl5Gfw7UgidBSPLzF8o5H+3Minp0Pn+
         01wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556458; x=1703161258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTkiSP+MxKrMId9/OvL1ZupidnFboSQTL72KpVM+M+Q=;
        b=Pqg/XtvGlVKC73Yn9Cr2wTS9K4W52VqpjgoAT31uJYXIfQnHwhMkRVz94Z/raG0mmt
         gyGnsMfFpmw9xC/swf1oJirAGFXPIVXZn84GA3I8+3RGON5qvSo2JR1Vt2/TQqz37iWw
         BMW7Tb7V/mf5GiGfUNCXM7UU8hfPmA28rFUJ6l1TJ1RhEMzhqtJHzY2jGs6cYCUMpFvz
         3XmImcJoE8+V8jeX4lsxR2fhbf30jzHhBlWC2ppgs4OV8mXPucRSm53TgfMPrX+k/g/r
         Eqm8xCQjbQ3Kl4XgplQ8On6LDp6eUMUteysoa441BZYAatBkmlrJx5z1wzgZ8Cvq5sOx
         Kjrw==
X-Gm-Message-State: AOJu0Yxvk6RDGQYp0KOXfxpaoDPVm59NX2XAQJBGlE2Ji8KVtEWhw23N
        4iiQlZmqVgl1RAffXwwUrnQ=
X-Google-Smtp-Source: AGHT+IHUx8uByEjYu0UiXRRWXssAP3UeLQtNDVDRl0YkNW+5n7cjkUTQ7hurZ5sk2Rc6YFxeYebErA==
X-Received: by 2002:adf:ea44:0:b0:336:4704:d288 with SMTP id j4-20020adfea44000000b003364704d288mr457691wrn.83.1702556457498;
        Thu, 14 Dec 2023 04:20:57 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id s18-20020a5d5112000000b0033330ace23asm15988494wrt.73.2023.12.14.04.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:20:56 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 1/2] leds: trigger: netdev: display only supported link speed attribute
Date:   Thu, 14 Dec 2023 13:20:40 +0100
Message-Id: <20231214122041.17439-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Changes v3:
- Use phy_speeds API to parse the ethtool mask
Changes v2:
- Use is_visibile instead of removing/adding attr

 drivers/leds/trigger/ledtrig-netdev.c | 104 ++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index bd68da15c723..345e522bc44a 100644
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
@@ -55,12 +57,16 @@ struct led_netdev_data {
 
 	unsigned long mode;
 	int link_speed;
+	unsigned int supported_link_speeds[20];
+	int supported_link_speeds_num;
 	u8 duplex;
 
 	bool carrier_link_up;
 	bool hw_control;
 };
 
+static const struct attribute_group netdev_trig_link_speed_attrs_group;
+
 static void set_baseline_state(struct led_netdev_data *trigger_data)
 {
 	int current_brightness;
@@ -206,15 +212,25 @@ static bool can_hw_control(struct led_netdev_data *trigger_data)
 static void get_device_state(struct led_netdev_data *trigger_data)
 {
 	struct ethtool_link_ksettings cmd;
+	int speeds_num;
 
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
+	speeds_num = phy_speeds(trigger_data->supported_link_speeds,
+				ARRAY_SIZE(trigger_data->supported_link_speeds),
+				cmd.link_modes.supported);
+	trigger_data->supported_link_speeds_num = speeds_num;
 }
 
 static ssize_t device_name_show(struct device *dev,
@@ -257,6 +273,7 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = SPEED_UNKNOWN;
 	trigger_data->duplex = DUPLEX_UNKNOWN;
+	trigger_data->supported_link_speeds_num = 0;
 	if (trigger_data->net_dev != NULL) {
 		rtnl_lock();
 		get_device_state(trigger_data);
@@ -282,6 +299,10 @@ static ssize_t device_name_store(struct device *dev,
 
 	if (ret < 0)
 		return ret;
+
+	/* Refresh link_speed visibility */
+	sysfs_update_group(&dev->kobj, &netdev_trig_link_speed_attrs_group);
+
 	return size;
 }
 
@@ -440,15 +461,72 @@ static ssize_t offloaded_show(struct device *dev,
 
 static DEVICE_ATTR_RO(offloaded);
 
-static struct attribute *netdev_trig_attrs[] = {
-	&dev_attr_device_name.attr,
-	&dev_attr_link.attr,
+static umode_t netdev_trig_link_speed_visible(struct kobject *kobj,
+					      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct led_netdev_data *trigger_data;
+	unsigned int *supported_link_speeds;
+	int speeds_num, i;
+
+	trigger_data = led_trigger_get_drvdata(dev);
+	supported_link_speeds = trigger_data->supported_link_speeds;
+	speeds_num = trigger_data->supported_link_speeds_num;
+
+	for (i = 0; i < speeds_num; i++) {
+		int speed = supported_link_speeds[i];
+
+		switch (speed) {
+		case SPEED_10:
+			if (attr == &dev_attr_link_10.attr)
+				return attr->mode;
+			break;
+		case SPEED_100:
+			if (attr == &dev_attr_link_100.attr)
+				return attr->mode;
+			break;
+		case SPEED_1000:
+			if (attr == &dev_attr_link_1000.attr)
+				return attr->mode;
+			break;
+		case SPEED_2500:
+			if (attr == &dev_attr_link_2500.attr)
+				return attr->mode;
+			break;
+		case SPEED_5000:
+			if (attr == &dev_attr_link_5000.attr)
+				return attr->mode;
+			break;
+		case SPEED_10000:
+			if (attr == &dev_attr_link_10000.attr)
+				return attr->mode;
+			break;
+		default:
+			return 0;
+		}
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
@@ -457,7 +535,16 @@ static struct attribute *netdev_trig_attrs[] = {
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
@@ -466,6 +553,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		netdev_notifier_info_to_dev((struct netdev_notifier_info *)dv);
 	struct led_netdev_data *trigger_data =
 		container_of(nb, struct led_netdev_data, notifier);
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
 	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
@@ -500,6 +588,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
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


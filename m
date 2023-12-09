Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9000880B509
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjLIPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 10:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLIPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 10:07:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77610D0;
        Sat,  9 Dec 2023 07:07:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3333a3a599fso2158515f8f.0;
        Sat, 09 Dec 2023 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702134463; x=1702739263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbOPxAZwngZ5oda3DzjX+vKKVhzs5jrjqmvI2kfRVGo=;
        b=laJELOAy77pEJn4dp+OUgPotHPgXF06xlaLdaI2ErDnSlYCEx1MLs9BWAPLLtmXH0b
         nVPUfypXFFJ+m4IUhecYrYE9i6FlkIcRTOGYFOYjr3I+NSGwWxY1OY+dta9lbypwpFJX
         nC5Kmpu60a8U5iUzilwNqn5A77yJXQJJx2Wm8eidCwLxd/+kAIYN3BaPZQZ7PzmqWkXJ
         hRPpKYXke83ZdjL2O62xiQwjjvjGzE2xaMYCmwLqjHzJ70HOiWDw06HsJF0K5/FpeamF
         /fsn1Ig1mvdlsfuuNxdg/eGFCTpyw8ckz0FgU/ieUFAigE8hojO4LVixoxIsve3DezQR
         A3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702134463; x=1702739263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbOPxAZwngZ5oda3DzjX+vKKVhzs5jrjqmvI2kfRVGo=;
        b=dXFkOspWlzBn0iKzuhTAZmmOJLMRcrsXgof5k3ThrdbaHv0ipuVenz/RNo0yMhvPs6
         p6K/4zNf87KLgM62ZQV+A/k04GMO7WLO6PY2RJbjuv0MCr3zGUK4HR7/L2p9GPTkUgXF
         6WKF7wDCVBE5XRxGrX2kbNzsgK7JvBpvqGw3uXWcG8EXZnc13mGzRZ0PhACPFJ26soAW
         eiimye09yRDFoN6536Q13SBBc4iUNYiaq/rZrFQm9VfVA1zMu5Leq1D++4ewpPI1NW7k
         VIqdAT2SolXtsIqUDWN3PqGR5eYt7IKw7eNiDOSjptC/UWuG+lkmfcsHdz9jXwTk0lEE
         bKPg==
X-Gm-Message-State: AOJu0YxQZY+JPBlGzCy4nDGFvP/T4XnykfNTu193NTHTQYbP6pjORsfV
        /gBYg86+YkQvxynvaHIv6ZA=
X-Google-Smtp-Source: AGHT+IFomuPDTazEVop3tripjpKqhYu6EV2i+iW/3nbiD2fy4xIShBqGHYZfUNUHGtlyUxyxXkuR5Q==
X-Received: by 2002:a7b:c40c:0:b0:40c:25ed:9be2 with SMTP id k12-20020a7bc40c000000b0040c25ed9be2mr862379wmi.75.1702134463061;
        Sat, 09 Dec 2023 07:07:43 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id p14-20020a05600c358e00b0040c37c4c229sm4367548wmq.14.2023.12.09.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 07:07:42 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH] leds: trigger: netdev: display only supported link speed attribute
Date:   Sat,  9 Dec 2023 16:07:24 +0100
Message-Id: <20231209150724.25565-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
additional trigger modes are added.

Since the netdev trigger REQUIRE a device name to be set, attach to the
device name change function additional logic to parse the supported link
speed modes using ethtool APIs and add only the supported link speed
modes attribute.

This only apply to the link speed modes and every other mode is still
provided by default.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 56 +++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 09e75fd9f2bc..ce84808e231c 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -61,6 +61,8 @@ struct led_netdev_data {
 	bool hw_control;
 };
 
+static int add_link_speed_attr(struct led_netdev_data *trigger_data);
+
 static void set_baseline_state(struct led_netdev_data *trigger_data)
 {
 	int current_brightness;
@@ -262,8 +264,10 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = SPEED_UNKNOWN;
 	trigger_data->duplex = DUPLEX_UNKNOWN;
-	if (trigger_data->net_dev)
+	if (trigger_data->net_dev) {
 		get_device_state(trigger_data);
+		add_link_speed_attr(trigger_data);
+	}
 
 	trigger_data->last_activity = 0;
 
@@ -396,6 +400,50 @@ DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
 DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
 
+static int add_link_speed_attr(struct led_netdev_data *trigger_data)
+{
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
+	struct device *dev = led_cdev->dev;
+	struct ethtool_link_ksettings cmd;
+	int ret;
+
+	/* First remove any entry previously added */
+	device_remove_file(dev, &dev_attr_link_10);
+	device_remove_file(dev, &dev_attr_link_100);
+	device_remove_file(dev, &dev_attr_link_1000);
+	device_remove_file(dev, &dev_attr_link_2500);
+	device_remove_file(dev, &dev_attr_link_5000);
+	device_remove_file(dev, &dev_attr_link_10000);
+
+	ret = __ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
+	if (ret)
+		return ret;
+
+	/* Add only supported entry */
+	if (test_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, cmd.link_modes.supported) ||
+	    test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, cmd.link_modes.supported))
+		device_create_file(dev, &dev_attr_link_10);
+
+	if (test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, cmd.link_modes.supported) ||
+	    test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, cmd.link_modes.supported))
+		device_create_file(dev, &dev_attr_link_100);
+
+	if (test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, cmd.link_modes.supported) ||
+	    test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, cmd.link_modes.supported))
+		device_create_file(dev, &dev_attr_link_1000);
+
+	if (test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, cmd.link_modes.supported))
+		device_create_file(dev, &dev_attr_link_2500);
+
+	if (test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, cmd.link_modes.supported))
+		device_create_file(dev, &dev_attr_link_5000);
+
+	if (test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, cmd.link_modes.supported))
+		device_create_file(dev, &dev_attr_link_10000);
+
+	return 0;
+}
+
 static ssize_t interval_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -446,12 +494,6 @@ static DEVICE_ATTR_RO(offloaded);
 static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_device_name.attr,
 	&dev_attr_link.attr,
-	&dev_attr_link_10.attr,
-	&dev_attr_link_100.attr,
-	&dev_attr_link_1000.attr,
-	&dev_attr_link_2500.attr,
-	&dev_attr_link_5000.attr,
-	&dev_attr_link_10000.attr,
 	&dev_attr_full_duplex.attr,
 	&dev_attr_half_duplex.attr,
 	&dev_attr_rx.attr,
-- 
2.40.1


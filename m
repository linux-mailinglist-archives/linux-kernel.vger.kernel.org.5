Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2477F1D71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjKTTnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKTTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:43:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D0A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:43:16 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso60814121fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1700509395; x=1701114195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sBaX7cd2IB03WvLrDTwS4RvBzwWpZetb/SceoGXYXLY=;
        b=MXb8Vdp0nAhGG8zIhvggQD+T3XJu0X55lAXOxUvD9W+v51mI6c0TyOhUhwU2//alZM
         gGRRssJ1SaG+9ktSspqzPt33MnLafWQNBEiqk4Vzv5MJDqL6CFsGtVjaRKyeYcUSV95O
         ukUhBo/O6g90Dy2PMvJ+F9wMP65MzTgu5eoMnPB/cT/nTD1h0VNsiEeeMKXV9mAyvexK
         6gID0RZjtXCR0y+ASJfO/2g/uJ1E9LaAuaGYsA0Wk/PEKiYQDWi2BnCJ02W266dNG5Ji
         J0FEj8LypcWHfBjAMo+cejv1gpynP2eey3kJGVWWqSo92RFR2k7G87WZ+InDQXgdgz98
         CYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509395; x=1701114195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBaX7cd2IB03WvLrDTwS4RvBzwWpZetb/SceoGXYXLY=;
        b=wKg6BKLLp8wz8ZVnZHp+wWZL34AyuqOcFLFikMTujtJ9uyIk0HvdOcMSNw2PC+ta/5
         k2ohmc8NMVndTgLoiQuuaEJIKZi9k97KJWgErUzvJRsy6TbV+7gNIbezz6tK/lqCNezM
         YolTt29LxxP/cH2naE+BAiSs8Nu381rd9TUgkzN/lNtS7RG0IOEDI610Ynp2nBF/Pncx
         sqtRv41pYIUD+4sX1NGc0Tr1u8p8XWqzrIx+65iJuz8PBsW/DOahLcZ7PuiN9EZlo0+a
         c7pX2p2qsJfVsXeTuGg+q8tQZEzIC5pVrMktdRAk2Ejfo+7xErVrXZc2ZQvsI6lGdiXQ
         GVjQ==
X-Gm-Message-State: AOJu0YwqvESayRvPQK6o4rLmmCCs2V5R1W6BASKt0T5mguRHnV4FYTaN
        060TX1Dw1GJSu/zdaa71lSWzWg==
X-Google-Smtp-Source: AGHT+IGmtE4YjC5aoWCS8grgwxnw1llYbhbGq33aAp8FGkIK0VyzB2wbZpO5SiJGpLp7JGyfsdUCaQ==
X-Received: by 2002:a05:651c:157:b0:2c8:7520:70e5 with SMTP id c23-20020a05651c015700b002c8752070e5mr4639432ljd.17.1700509394976;
        Mon, 20 Nov 2023 11:43:14 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b0040531f5c51asm14700325wmq.5.2023.11.20.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:43:14 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] regulator: event: Add regulator netlink event support
Date:   Mon, 20 Nov 2023 19:43:09 +0000
Message-ID: <20231120194311.3581036-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/Makefile |   1 +
 drivers/regulator/core.c   |   7 +-
 drivers/regulator/event.c  | 135 +++++++++++++++++++++++++++++++++++++
 drivers/regulator/regnl.h  |   8 +++
 4 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 drivers/regulator/event.c
 create mode 100644 drivers/regulator/regnl.h

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b2b059b5ee56..de37144e4784 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -5,6 +5,7 @@
 
 
 obj-$(CONFIG_REGULATOR) += core.o dummy.o fixed-helper.o helpers.o devres.o irq_helpers.o
+obj-$(CONFIG_REGULATOR) += event.o
 obj-$(CONFIG_OF) += of_regulator.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4aa9ec8c22f3..384ffe8618fd 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -33,6 +33,7 @@
 
 #include "dummy.h"
 #include "internal.h"
+#include "regnl.h"
 
 static DEFINE_WW_CLASS(regulator_ww_class);
 static DEFINE_MUTEX(regulator_nesting_mutex);
@@ -4854,7 +4855,11 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
 	/* call rdev chain first */
-	return blocking_notifier_call_chain(&rdev->notifier, event, data);
+	int ret =  blocking_notifier_call_chain(&rdev->notifier, event, data);
+
+	reg_generate_netlink_event(rdev_get_name(rdev), event);
+
+	return ret;
 }
 
 int _regulator_bulk_get(struct device *dev, int num_consumers,
diff --git a/drivers/regulator/event.c b/drivers/regulator/event.c
new file mode 100644
index 000000000000..ba72a705f09e
--- /dev/null
+++ b/drivers/regulator/event.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "regnl.h"
+
+#ifdef CONFIG_NET
+static unsigned int reg_event_seqnum;
+struct reg_genl_event {
+	char reg_name[15];
+	u64 event;
+};
+
+/* attributes of reg_genl_family */
+enum {
+	REG_GENL_ATTR_UNSPEC,
+	REG_GENL_ATTR_EVENT,	/* reg event info needed by user space */
+	__REG_GENL_ATTR_MAX,
+};
+
+#define REG_GENL_ATTR_MAX (__REG_GENL_ATTR_MAX - 1)
+
+/* commands supported by the reg_genl_family */
+enum {
+	REG_GENL_CMD_UNSPEC,
+	REG_GENL_CMD_EVENT,	/* kernel->user notifications for reg events */
+	__REG_GENL_CMD_MAX,
+};
+
+#define REG_GENL_CMD_MAX (__REG_GENL_CMD_MAX - 1)
+
+#define REG_GENL_FAMILY_NAME		"reg_event"
+#define REG_GENL_VERSION		0x01
+#define REG_GENL_MCAST_GROUP_NAME	"reg_mc_group"
+
+static const struct genl_multicast_group reg_event_mcgrps[] = {
+	{ .name = REG_GENL_MCAST_GROUP_NAME, },
+};
+
+static struct genl_family reg_event_genl_family __ro_after_init = {
+	.module = THIS_MODULE,
+	.name = REG_GENL_FAMILY_NAME,
+	.version = REG_GENL_VERSION,
+	.maxattr = REG_GENL_ATTR_MAX,
+	.mcgrps = reg_event_mcgrps,
+	.n_mcgrps = ARRAY_SIZE(reg_event_mcgrps),
+};
+
+int reg_generate_netlink_event(const char *reg_name, u64 event)
+{
+	struct sk_buff *skb;
+	struct nlattr *attr;
+	struct reg_genl_event *edata;
+	void *msg_header;
+	int size;
+
+	/* allocate memory */
+	size = nla_total_size(sizeof(struct reg_genl_event)) +
+	    nla_total_size(0);
+
+	skb = genlmsg_new(size, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	/* add the genetlink message header */
+	msg_header = genlmsg_put(skb, 0, reg_event_seqnum++,
+				 &reg_event_genl_family, 0,
+				 REG_GENL_CMD_EVENT);
+	if (!msg_header) {
+		nlmsg_free(skb);
+		return -ENOMEM;
+	}
+
+	/* fill the data */
+	attr = nla_reserve(skb, REG_GENL_ATTR_EVENT, sizeof(struct reg_genl_event));
+	if (!attr) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	edata = nla_data(attr);
+	memset(edata, 0, sizeof(struct reg_genl_event));
+
+	strscpy(edata->reg_name, reg_name, sizeof(edata->reg_name));
+	edata->event = event;
+
+	/* send multicast genetlink message */
+	genlmsg_end(skb, msg_header);
+	size = genlmsg_multicast(&reg_event_genl_family, skb, 0, 0, GFP_ATOMIC);
+
+	pr_debug("%s -> %lx , ret: %x %x", reg_name, event, size);
+	if (size == -ESRCH)
+		pr_debug("multicast message sent, but nobody was listening...\n");
+	else if (size)
+		pr_debug("failed to send multicast genl message\n");
+	else
+		pr_debug("multicast message sent %d\n", reg_event_seqnum);
+
+	return 0;
+}
+EXPORT_SYMBOL(reg_generate_netlink_event);
+
+static int __init reg_event_genetlink_init(void)
+{
+	return genl_register_family(&reg_event_genl_family);
+}
+
+#else
+int reg_generate_netlink_event(const char *device_class, const char *bus_id, u8 type, int data)
+{
+	return 0;
+}
+EXPORT_SYMBOL(reg_generate_netlink_event);
+
+static int reg_event_genetlink_init(void)
+{
+	return -ENODEV;
+}
+#endif
+
+static int __init reg_event_init(void)
+{
+	int error;
+
+	/* create genetlink for acpi event */
+	error = reg_event_genetlink_init();
+	dev_err(NULL, "%s Loaded", __func__);
+	if (error)
+		pr_warn("Failed to create genetlink family for reg event\n");
+
+	return 0;
+}
+
+fs_initcall(reg_event_init);
diff --git a/drivers/regulator/regnl.h b/drivers/regulator/regnl.h
new file mode 100644
index 000000000000..0b27972bd523
--- /dev/null
+++ b/drivers/regulator/regnl.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __REGULATOR_EVENT_H
+#define __REGULATOR_EVENT_H
+
+int reg_generate_netlink_event(const char *reg_name, u64 event);
+
+#endif

base-commit: 753e4d5c433da57da75dd4c3e1aececc8e874a62
-- 
2.41.0


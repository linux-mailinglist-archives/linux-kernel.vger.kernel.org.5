Return-Path: <linux-kernel+bounces-167573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AF68BAB78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E972928149C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C5152781;
	Fri,  3 May 2024 11:15:16 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6D152193;
	Fri,  3 May 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734915; cv=fail; b=CQ2Bre6SWG4jA1IosmbnEofyIGNum9UorgSkeIJJxWhZvjuoL2NweNS4fUYlTp77LdJzHDajyUsiBM/FD5fE25b93DqgV4+cE75gG+H/KV2KXwxsHAuFyqVbHa7yIO97TUQ+nJndz0VRYIbv+Aci2Q2FDXvB+uYXgrjUBoR+tXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734915; c=relaxed/simple;
	bh=3qOIH8Lv+VG0PbhRMvTuEHuVFClRqRVgFLVFmh74las=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ny+XRLpwqXrd7i3WBm6GdKj8RVFU/onqsM3pDIL3+fTuP/23haGcD/2IegMEZWhSd317HsCu3oky9VpYX68IAszg+Wj99FuSpKRDFvQdg3sXuFZXTXTKBX6fijtIy8C78cwKJbVwPpS+BnHp2NA2pGbluKW+uYyM5tTwPUv4Vu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlvKIViyg9sKWJP0+CRNaCxzGcvSOOhH8NtoTjv+vOl926zjllICY+B/RzKC+fkGMU+d26CgHXG6yyD88yaSOpPBMPzv7C8Jx5zqXBB8K6YXyb/cWB95txm2GdNOP/jbFCLuJr80eiBWVlv25/Co5jClE04hmmtg9hBgS+vWBPcBjbbAYe770DcEJgly77Rt2EEeS/02Q9DGlgHjICxZaOzS6NCbdJ16tl0A68vu+erAR7jHdH/hobmHv3yP/J+3UVFrWwATZppwUdgW9rg9XT84e4OEEvNjGZH2V22OOlCkscyfq12nINB39QHT5k+SaTO6vhBasjbdBSeWYKXnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAqNpNO+pzoUOb1ovcRYsgkdv6JzCxdG9bEgFv6/p0Q=;
 b=bkKIM/sjjQRILtyCzWH/GJsjqaDWCrSlwzP4lpcBGxN6pzaK0wlsTBki9OTKHXjsz0OQ92ba39eT/oJrbaIFbg9JPMkx30ALRMujsb0rZyaxMJPPefJ5Rq38Fc2z9FW2on26XkT/7nfASNrlmoOEfbS58fSWgnoGbd+belxqJZV7CONEiqBDyujWjb3St0KRgFCCha2fmftZwdchqtisBujKJ7PUMj6H3PntCuP2mTZM7YkD7yxOQhtmS5OtYXVMmhwd0GEZyYwTxQaxs99rS++m1/ri52dEUCN/C/FctIpLypGF+enI6oJ28VNmYGJebqLESUTF1MFfFyrm/EiJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1112.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:15:05 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:15:05 +0000
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH v3 6/7] gpiolib: enable GPIO interrupt to wake up a system from sleep
Date: Fri,  3 May 2024 19:14:35 +0800
Message-Id: <20240503111436.113089-7-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::20) To ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1176:EE_|ZQ0PR01MB1112:EE_
X-MS-Office365-Filtering-Correlation-Id: ebce3d29-f0be-4031-fc78-08dc6b6248d4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NwHDAIU/Y9PYmIoVj46oSiFQgBksWJK4YZtdts3CQ10zkRJD3XTKUbVcLlC6G4cfouyTMFgiOrZ1Vjq2m40MPjFpjJNg4Xj1cOZsD8yMmvrPcEtpe/pbFq9RbREUf62RuiZgjV/7bcqTm8AylumF1H9Hxt+4PlLZxudMyRfte2UgHSLxUwAVEdpOBtGKS10UTLWJuvHP5v/80JQpfOdEsy5C2/nDImWD9Cqm9PPds9yIO4zFkkxmoxDw7nOze8vf5vi0KBjrIcKr4MgAve/eVsio6FNnsO64yrMnLzFO2LMv9YsSCPWfA4/Bil83J3Db6MLBH3jyortkiKQOg+6MUztqX9Xfnuc2uVwqzpYdhfcrgG+L49hszZP/7klJe4VeN31gPi/QpYZ6p8uIEAwYhJgOoAUrqxxAulIdtBHTDEbkovN7d7D6iJAvtS12+vsP1oqrqhqQGdHqx1+tDo/xpI7pWkTe4fJ3Vv/+h+aoE6m7jPBkYw5nNMSXJekQf7zWlvRzALHpYSZLeotF5oTutMUBMXWL2+ANhvCzFXFn3IR3PjbJf/S0apkjJhRxqwTU3xR1b8a227U9bnBTqHdhORVMHmPs+yxXtIwcg0aPsKFBlqRhWVG9IAufMu6oQ7rUnC9dwRz5uswwArTu7UjUKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wUFH8X3wJl+3Y78oXno3rgnp0IZbQUjiD5Es4WWqSM7fr6XYhKh8BTnubT0j?=
 =?us-ascii?Q?Isq/NofV54V6B+ti1CTB+q1yzd7LdcGtHVBkk+vqXLPhwpqF/f65WEqmF6n2?=
 =?us-ascii?Q?cM5deJXLuPjSPYk+CFNR8Cams0vjLsemmYP6C6Mcr4kc0ZyynPDnnOxCLPfv?=
 =?us-ascii?Q?5CVhhzxuNOBNv35Y1fo1RYLJxzgKf0x5QtLDyFwotunYvWDeJHgDDloZEo08?=
 =?us-ascii?Q?ZJeCd+JlTc+KCuHOUrhuQJG3r+wGqvkisWEV7yHW5lLfJUPcJFWz05NArIhl?=
 =?us-ascii?Q?p/AbvDaYRNlrT6vvL4GakCWC3k1jKtxbHRaSbaYnQdVRFwj8gbZDbNu1fzVY?=
 =?us-ascii?Q?RDOP7tAEjVlv5KRMmtCPIKPTxng9a91pRaClEndcez01tpenugAUJFFQAaTc?=
 =?us-ascii?Q?mP+53xlaBXAfvPuAlsmDeHv08YArhB9Ms7qSLI8GNZrvv6pzClkmxge79fSz?=
 =?us-ascii?Q?WGsBMHDhKHlO5HkrH6ZGD5hdENR4uzV7MNpvZmb5/VFmH1vCVx4LGN3hyfKv?=
 =?us-ascii?Q?2BPobKterJcun8/1vmyhuLabfp92YNIGvJSAgVwbCdtEFUmQMLmSl2B860lu?=
 =?us-ascii?Q?VF8FqlMaMTVSonXD9n/+nfC+xSJvDcY8Rqg5vE23RNsuGJ2Cf6BjqzfHGDJ/?=
 =?us-ascii?Q?uXA7ptwzYgvfqIoHZnqbDP1iCl84CB8GEikN1OBWouUa8B2UjcUqYsMJkR8x?=
 =?us-ascii?Q?gGBtCf4T49t+rgVALqI98SaqXVRsI7j04JTi6OxCc8Z7GgQAZ6S3L5h3SRnW?=
 =?us-ascii?Q?Et7hiwU6TY/nxmdp7DZmEMwXj56AyKu5yhBm1TxDE1U3mmeDP+wiLSxvenFj?=
 =?us-ascii?Q?fzOwzHkAbIlaDhqJKiVn8m74gH0lAkPc+EC/PNQJClUE8tIS1NjDr7Y+H3qu?=
 =?us-ascii?Q?ea8p3g9Q+TDE0mc8T/VIjUFaqrH0G5zW3ILyKHeOHZsJc62O6gN2ZaGJ44YN?=
 =?us-ascii?Q?2Zk+DI8ehYZCkzuLTrkvEulaVzBzINY8sOkCChOp2O7OCC98GD+rzrczj9/W?=
 =?us-ascii?Q?P9agKYqFvOqCbdk8wHTLyAQsBzOvHI55xwkfdHr22b6Armh7bcgspo1YFVQp?=
 =?us-ascii?Q?Nfiy7c9jQthkPLptrfBLn/z9RluiEO4UPgKkwwK3PjZQ3QF9zEi+mh2kglcl?=
 =?us-ascii?Q?tf6GxT0qtczgmt5iayJGqj/TjeOK/whmmkTY88KmCPhIdB7obMJ+2rPKxp1W?=
 =?us-ascii?Q?0C1jKB25bcbzHWQExbizRiUgtH5BuZ8U9o3SDjKNGMdE/w23P7U8HQpI9z5h?=
 =?us-ascii?Q?TzhxA8XjRJatEm0nfh12mJtbcymJUwCIR7JQRd4Wx/U/VQMTrFywJHDFct+J?=
 =?us-ascii?Q?KU1O+YWknnUJf0dmOjoMr5Du++pO2E7jBMBAlfPjU+7hXecv5YSIBqvxViUN?=
 =?us-ascii?Q?ynii4bQltLzEsULIQpB4UNKKf8oSg4+bX1JE47H5PB2xh1FfryToNzW1lTQe?=
 =?us-ascii?Q?pGKtGE4lXLj7ldIWFUGTwBXdBJwSLUCkJtkeytSQUN9SojG7dJb8/HLVoFeq?=
 =?us-ascii?Q?OYWqAupfn6aIeHfnkTiYxccTrAEDFIqeFBNPGU79FmYVSCmt3beV5eBEsMbO?=
 =?us-ascii?Q?fBLxcZ0Gf7rM5JOd/0C0t2TU+x7u8S1rbA1CQOM7Fti4k1zQh/7vnLZxBYmw?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebce3d29-f0be-4031-fc78-08dc6b6248d4
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:15:05.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwz7IU8b1Bb22q5T70iUIpLHoGS8688VTJYSP68RbPJHTsoLKTHScN3l/mZf5lEGTZyMsPk1Cbmlu4cQlvjdC1Tkrq9sEZtT5t72H+ZOB6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1112

Add function gpiochip_wakeup_irq_setup() to configure and enable a
GPIO pin with interrupt wakeup capability according to user-defined
wakeup-gpios property in the device tree. Interrupt generated by
toggling the logic level (rising/falling edge) on the specified
GPIO pin can wake up a system from sleep mode.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 drivers/gpio/gpiolib.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 94903fc1c145..92cfbc34abb0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -96,6 +97,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc);
 static int gpiochip_irqchip_init_hw(struct gpio_chip *gc);
 static int gpiochip_irqchip_init_valid_mask(struct gpio_chip *gc);
 static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc);
+static int gpiochip_wakeup_irq_setup(struct gpio_chip *gc);
 
 static bool gpiolib_initialized;
 
@@ -1045,8 +1047,15 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		if (ret)
 			goto err_remove_irqchip;
 	}
+
+	ret = gpiochip_wakeup_irq_setup(gc);
+	if (ret)
+		goto err_remove_device;
+
 	return 0;
 
+err_remove_device:
+	gcdev_unregister(gdev);
 err_remove_irqchip:
 	gpiochip_irqchip_remove(gc);
 err_remove_irqchip_mask:
@@ -1874,6 +1883,84 @@ static int gpiochip_irqchip_add_allocated_domain(struct gpio_chip *gc,
 	return 0;
 }
 
+static irqreturn_t gpio_wake_irq_handler(int irq, void *data)
+{
+	struct irq_data *irq_data = data;
+
+	if (!irq_data || irq != irq_data->irq)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int gpiochip_wakeup_irq_setup(struct gpio_chip *gc)
+{
+	struct device *dev = gc->parent;
+	struct gpio_irq_chip *girq = &gc->irq;
+	struct gpio_desc *wakeup_gpiod;
+	struct irq_desc *wakeup_irqd;
+	struct irq_domain *irq_domain;
+	struct irq_data *irq_data;
+	unsigned int offset;
+	int wakeup_irq;
+	int ret;
+
+	if (!(device_property_read_bool(dev, "wakeup-source")))
+		return 0;
+
+	irq_domain = girq->domain;
+
+	if (!irq_domain) {
+		dev_err(dev, "Couldn't allocate IRQ domain\n");
+		return -ENXIO;
+	}
+
+	wakeup_gpiod = devm_gpiod_get_optional(dev, "wakeup", GPIOD_IN);
+
+	if (IS_ERR(wakeup_gpiod)) {
+		dev_err(dev, "invalid wakeup gpio: %lu\n", PTR_ERR(wakeup_gpiod));
+		return PTR_ERR(wakeup_gpiod);
+	}
+	if (!wakeup_gpiod) {
+		dev_dbg(dev, "property wakeup-gpios is not defined\n");
+		return 0;
+	}
+
+	offset = gpio_chip_hwgpio(wakeup_gpiod);
+	wakeup_irq = gpiod_to_irq(wakeup_gpiod);
+	if (wakeup_irq < 0) {
+		dev_err(dev, "failed to convert wakeup GPIO to IRQ\n");
+		return wakeup_irq;
+	}
+	irq_domain->ops->map(irq_domain, wakeup_irq, offset);
+	wakeup_irqd = irq_to_desc(wakeup_irq);
+	irq_data = irq_get_irq_data(wakeup_irq);
+	girq->handler = handle_edge_irq;
+
+	if (!(wakeup_irqd->status_use_accessors & IRQ_NOREQUEST)) {
+		device_init_wakeup(dev, 1);
+		ret = devm_request_threaded_irq(dev, wakeup_irq, NULL,
+						gpio_wake_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT |
+						IRQF_SHARED,
+						"pm-wakeup-gpio", irq_data);
+		if (ret) {
+			dev_err(dev, "unable to request wakeup IRQ: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = dev_pm_set_wake_irq(dev, wakeup_irq);
+	if (ret) {
+		dev_err(dev, "failed to enable gpio irq wake\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * gpiochip_add_irqchip() - adds an IRQ chip to a GPIO chip
  * @gc: the GPIO chip to add the IRQ chip to
-- 
2.25.1



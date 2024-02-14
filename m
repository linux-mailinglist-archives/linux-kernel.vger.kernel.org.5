Return-Path: <linux-kernel+bounces-65425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4E854CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B2E1C28888
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D060BBE;
	Wed, 14 Feb 2024 15:29:27 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6B60B9C;
	Wed, 14 Feb 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924567; cv=none; b=SEiY1ip8jL8gRWsWAEr6JfqYXf2oC4sUWHtcJKCyGnwtj3jItScQ1Ygh4wfzyA9NNSc2BML/XqAE3oizA7gVpMqfLONfTxiT2ycXi85X+c5WYjGnzs91nELj6P95//gv+9nRMcXHjPQ5pyJc6KKyQi2t203IEj3IfDWH7NfRMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924567; c=relaxed/simple;
	bh=eBmfDmsPjhH+X5o8K2+TeEVZvEw2hmlxQGjrllmBphM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D5Q+ePyLvO146JfH24gQ7+ZY2SIekZ9qWcRVNj830z/hxd9DOVLHiNOgNaXr1VTxtPKxPJOdjETafjeTiCk6+6IAW5PCeZfgtBufi06fUUPZALOot50HX0a4Wy0VitUL4p8JKJyEoMcRKh1KIpUfTnrUACA3yG9zQmiI9CTfjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5620f15c3e5so1922661a12.2;
        Wed, 14 Feb 2024 07:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924562; x=1708529362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE18yVmAwBaKs7mnnBm3VQecjIpWZcprNzlYBID58iw=;
        b=Cbbd6jTA+tW33/huLvvQ4vU1wnBjY/eCXz+MWuOmODuEtbeCiiN2l6Q3orPgWALFOL
         JhaJiEWCWjmbBYUJnO+B7GJu0xcCxg5zkp15x7hnuBY/M32kJDAeu3b8UKuINOKgrnvZ
         n0v1q0NwsVGlHW/4Bev738hOaDhlCOOtBUpo4mYA+MMmr3Ku+HoWPk45duVHWBUi2rJD
         qlkXtuDQNkVqFU227SaoZbjbL7c3kt1UIQMIeHZtSdWKJL0QEh7APOy7WLTkkD+qgu6Y
         UNrZ6wOQh+NcWfwcnwoB7Cl+pIYXrdEWjDMJGP3qAuhtbjHj71M/Ippn7LI2jDHZN/0E
         9cyw==
X-Forwarded-Encrypted: i=1; AJvYcCWAsmjKX8dw6rwVXbsLYjsQt//XUNAlCclyQm4CfG0YwLfeToREjsRBu3hNGcSllwRD8WPAgGETkSdOCo1YSd3AupOOm2SKFWssZejG
X-Gm-Message-State: AOJu0YzQ2EtCdM+jvKMJ60D5LCKe8CJy9Yqblgw0Dl2KsKEqAWL2MJXD
	e09/pXwnQ83BWywDUU0rzm0I7eRRovBn2MHFDLjXk30WVz+y+XJdLMHuVulL
X-Google-Smtp-Source: AGHT+IFT59hPClPRPX7AtQUNrs2AJ5o6U/9OyGYMPUv6dmUlFmZDmbglTJDWcMmY+ZRVEjkt5K9A1g==
X-Received: by 2002:a05:6402:3088:b0:562:1dcb:a856 with SMTP id de8-20020a056402308800b005621dcba856mr1826807edb.33.1707924562635;
        Wed, 14 Feb 2024 07:29:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcBTj8mDiQnBt5AbeKlpzkWnbDg00rpWmCxXlyJWFl4x5LoA8iUxKMfHgyemi5t45C1A9ywb9vfaDlvGMXIJA8VLBeb8lfMONhRpv4sSU84kMzde47///5gtsdg8NP/gYPjTPYECzzh3IHiA9AT9WVrrt8vybsvi/O0pXHSWYmxlphT3paPDX7LNmCnX6tD1CXsvXc6A1NVi+xxtlerxwlNx8bqcdxyNgEfKPaytHbXrz3DOUQzCU=
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id ew4-20020a056402538400b0055fe5a611f2sm4732804edb.20.2024.02.14.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:29:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2 7/7] net: fill in MODULE_DESCRIPTION()s for missing arcnet
Date: Wed, 14 Feb 2024 07:27:41 -0800
Message-Id: <20240214152741.670178-8-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214152741.670178-1-leitao@debian.org>
References: <20240214152741.670178-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the ARC modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/arcnet/arc-rawmode.c  | 1 +
 drivers/net/arcnet/arc-rimi.c     | 1 +
 drivers/net/arcnet/capmode.c      | 1 +
 drivers/net/arcnet/com20020-pci.c | 1 +
 drivers/net/arcnet/com20020.c     | 1 +
 drivers/net/arcnet/com20020_cs.c  | 1 +
 drivers/net/arcnet/com90io.c      | 1 +
 drivers/net/arcnet/com90xx.c      | 1 +
 drivers/net/arcnet/rfc1051.c      | 1 +
 drivers/net/arcnet/rfc1201.c      | 1 +
 10 files changed, 10 insertions(+)

diff --git a/drivers/net/arcnet/arc-rawmode.c b/drivers/net/arcnet/arc-rawmode.c
index 8c651fdee039..57f1729066f2 100644
--- a/drivers/net/arcnet/arc-rawmode.c
+++ b/drivers/net/arcnet/arc-rawmode.c
@@ -186,4 +186,5 @@ static void __exit arcnet_raw_exit(void)
 module_init(arcnet_raw_init);
 module_exit(arcnet_raw_exit);
 
+MODULE_DESCRIPTION("ARCnet raw mode packet interface module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
index 8c3ccc7c83cd..53d10a04d1bd 100644
--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -312,6 +312,7 @@ module_param(node, int, 0);
 module_param(io, int, 0);
 module_param(irq, int, 0);
 module_param_string(device, device, sizeof(device), 0);
+MODULE_DESCRIPTION("ARCnet COM90xx RIM I chipset driver");
 MODULE_LICENSE("GPL");
 
 static struct net_device *my_dev;
diff --git a/drivers/net/arcnet/capmode.c b/drivers/net/arcnet/capmode.c
index c09b567845e1..7a0a79973769 100644
--- a/drivers/net/arcnet/capmode.c
+++ b/drivers/net/arcnet/capmode.c
@@ -265,4 +265,5 @@ static void __exit capmode_module_exit(void)
 module_init(capmode_module_init);
 module_exit(capmode_module_exit);
 
+MODULE_DESCRIPTION("ARCnet CAP mode packet interface module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 7b5c8bb02f11..c5e571ec94c9 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -61,6 +61,7 @@ module_param(timeout, int, 0);
 module_param(backplane, int, 0);
 module_param(clockp, int, 0);
 module_param(clockm, int, 0);
+MODULE_DESCRIPTION("ARCnet COM20020 chipset PCI driver");
 MODULE_LICENSE("GPL");
 
 static void led_tx_set(struct led_classdev *led_cdev,
diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index 06e1651b594b..a0053e3992a3 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -399,6 +399,7 @@ EXPORT_SYMBOL(com20020_found);
 EXPORT_SYMBOL(com20020_netdev_ops);
 #endif
 
+MODULE_DESCRIPTION("ARCnet COM20020 chipset core driver");
 MODULE_LICENSE("GPL");
 
 #ifdef MODULE
diff --git a/drivers/net/arcnet/com20020_cs.c b/drivers/net/arcnet/com20020_cs.c
index dc3253b318da..75f08aa7528b 100644
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -97,6 +97,7 @@ module_param(backplane, int, 0);
 module_param(clockp, int, 0);
 module_param(clockm, int, 0);
 
+MODULE_DESCRIPTION("ARCnet COM20020 chipset PCMCIA driver");
 MODULE_LICENSE("GPL");
 
 /*====================================================================*/
diff --git a/drivers/net/arcnet/com90io.c b/drivers/net/arcnet/com90io.c
index 37b47749fc8b..3b463fbc6402 100644
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -350,6 +350,7 @@ static char device[9];		/* use eg. device=arc1 to change name */
 module_param_hw(io, int, ioport, 0);
 module_param_hw(irq, int, irq, 0);
 module_param_string(device, device, sizeof(device), 0);
+MODULE_DESCRIPTION("ARCnet COM90xx IO mapped chipset driver");
 MODULE_LICENSE("GPL");
 
 #ifndef MODULE
diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx.c
index f49dae194284..b3b287c16561 100644
--- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -645,6 +645,7 @@ static void com90xx_copy_from_card(struct net_device *dev, int bufnum,
 	TIME(dev, "memcpy_fromio", count, memcpy_fromio(buf, memaddr, count));
 }
 
+MODULE_DESCRIPTION("ARCnet COM90xx normal chipset driver");
 MODULE_LICENSE("GPL");
 
 static int __init com90xx_init(void)
diff --git a/drivers/net/arcnet/rfc1051.c b/drivers/net/arcnet/rfc1051.c
index a7752a5b647f..46519ca63a0a 100644
--- a/drivers/net/arcnet/rfc1051.c
+++ b/drivers/net/arcnet/rfc1051.c
@@ -78,6 +78,7 @@ static void __exit arcnet_rfc1051_exit(void)
 module_init(arcnet_rfc1051_init);
 module_exit(arcnet_rfc1051_exit);
 
+MODULE_DESCRIPTION("ARCNet packet format (RFC 1051) module");
 MODULE_LICENSE("GPL");
 
 /* Determine a packet's protocol ID.
diff --git a/drivers/net/arcnet/rfc1201.c b/drivers/net/arcnet/rfc1201.c
index a4c856282674..0edf35d971c5 100644
--- a/drivers/net/arcnet/rfc1201.c
+++ b/drivers/net/arcnet/rfc1201.c
@@ -35,6 +35,7 @@
 
 #include "arcdevice.h"
 
+MODULE_DESCRIPTION("ARCNet packet format (RFC 1201) module");
 MODULE_LICENSE("GPL");
 
 static __be16 type_trans(struct sk_buff *skb, struct net_device *dev);
-- 
2.39.3



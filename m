Return-Path: <linux-kernel+bounces-63434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9956E852F28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F628334D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5E39FF0;
	Tue, 13 Feb 2024 11:22:02 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884353E1E;
	Tue, 13 Feb 2024 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823321; cv=none; b=KeggKJK6Yin4pXGgzzM/nUO0SHVYE5RhLaQZQJpWo8tI1pQ6Wcrj7kRBTgW03tBHi6WNiRckRsHxGBeKF3KbTsv5kpAB7r+XuTE8xFgXs3/2Ky2tqMstloMaYSOylC22JdjWWQPqDlgYgpUBnwyxIuW023uP3JOSsquhr4ICZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823321; c=relaxed/simple;
	bh=s6T/zSMMEHZIFTOkc0e0h1ky/C0Y56wV6iDS5Nk+ook=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UitV3urVNykJNLn2Qrtnb3S5k6sgph0QxPQEVKsWbAcqJzyiEMbL31Q+yTVs0rP54vXBq3BJem/br5WA/1O/XlRHyMubDDG8qDshA0ALVkii/KPyhlGEKuEsmdhecQKvlECX0zRP0aZzusK3b5LR7rhbNJaRGj+uSpXxR07VSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a38271c0bd5so528262766b.0;
        Tue, 13 Feb 2024 03:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823318; x=1708428118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF5tSCyO28Quew0M8TTq2zPTAoVa+RqiCLspA3/IxPI=;
        b=U/5KVSO+d3vaUt7PJd8JziiRlXArj0DXbz/W28Iw66VE2sgdmlinzYDyF7/dBC8bhf
         8SVxyAybWn7ePW7fJaq7YjAP/iPAzo40SnBL6SoRKDiug4kQJMtwsdA7WMMTVkNXgo5o
         Kv5u2JVJVHEL4kjLs/hmV5X7V7xQ0Cd6d9vcaLOxu5cel/ohXow7rjMJcKgKA3jplnAV
         OPfrnZBOFhiq1809nFwu2ZNKbsn6BG3CZszoHzzyjwqTKlnhYnQO1YPvvzCdp7gq+kss
         Sgbss9O3AsmQQSzl4gA+ORLNdFqWIrQIIdcdr522Ct64xesWj4Vb2b6ONYVXCBWHJhvj
         UBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb7sNh9zDjYlNH4fRByifdX9azqCiqB60Q6fIR3bzrWVyaLVK9K7H3zMCkvutZrlLDFVU8cC/vDiL7l8GeatcG+XfWjc4SpSZ3UJVV
X-Gm-Message-State: AOJu0YzL1/GaQYCa/gQK1/tqSeBMG3LP0elBV4Z1IZM9e/67KHeTwdFg
	lthXHaGL+XMSIylGrZxB/8+5wLqgRY6KjQe9qxj+nQvFLGIdMdAjmuDnoTmN
X-Google-Smtp-Source: AGHT+IEvHALJxeyXK/tOIwb7oXhE3xreT25ZdIXweBKkiFCqFUOmFVDPs2F1tjxtyzKgN7X+sp6P6Q==
X-Received: by 2002:a17:906:cec4:b0:a3c:e2ba:3820 with SMTP id si4-20020a170906cec400b00a3ce2ba3820mr1973376ejb.41.1707823318482;
        Tue, 13 Feb 2024 03:21:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUW4uOf9PixhUed3X1XpcyMKUkKmzKYY7i+CbkDEHBVHOSJq+IfDkrUkVSOpi1NR0IU11belvfuKjN01SiS67E5sBsy+y8kh3efGvpx2MIpX1g02GgInBbjyPIVo0y+CgmvxpGo9Q2MJIOH43BiakiTf+5mOYFw/qEbKB95yl451mIAocil8NSIQfAB3aH1OZ5lYuXuf15SKtgrIsH+I+vfTIxtGZoXlhUlC+Dp4xYM79tN5Xj3CYg=
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b00a3c488d79b1sm1194580ejc.223.2024.02.13.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net 7/7] net: fill in MODULE_DESCRIPTION()s for missing arcnet
Date: Tue, 13 Feb 2024 03:21:22 -0800
Message-Id: <20240213112122.404045-8-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240213112122.404045-1-leitao@debian.org>
References: <20240213112122.404045-1-leitao@debian.org>
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
index dc3253b318da..38b72eb2e89c 100644
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



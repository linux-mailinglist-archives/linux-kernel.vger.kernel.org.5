Return-Path: <linux-kernel+bounces-121963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D188EFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A14A1F2F7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1C152506;
	Wed, 27 Mar 2024 20:08:35 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD814D441;
	Wed, 27 Mar 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570115; cv=none; b=I0JLYAJQ0ue9QQdvPHSPxqjbbdBEFoonU36LfAxJSW3OB1vedFw0OEYIwZJ4CrWRNOg6m1L5Um8xXMOS/sWQA7G/fr9fOOhy+dM/vYGS68ppxN6IQeBXGBVq3wNjhpMksNYiQcaWpfGWe0p4tQTq98IZty5hcyO7DtGZ+WxdAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570115; c=relaxed/simple;
	bh=8Y3vf7PfmMwRO9eXofIWij+5MZuF1YYATDF0u2spiSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPmyEpMJ3en2eWOna3P3czFgBxdw0YHeHcoX7eTBhTtdbn9sDjBSALdZbBQhyAiBJvANf4CoEtcg8JzHEXiwXKStNtC8vsMrz/eynyDy4kjjN9oxCIegHeJKCDAM0Tf5e0f6/G/8jOLOEGIlP/z4GgmKazlbDImgB5uWPhiezSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so210553a12.2;
        Wed, 27 Mar 2024 13:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711570110; x=1712174910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO9s1BeoZjBDn6WqUxa6AhT8ICWzxqEv44Pbstg52Cw=;
        b=r/AShWe9Kqj3wgUam15rK7ggLDbgQ5Ccv+QlOljB6Stx0vUirTnsw285rKm1bKPiKx
         s4Jweza1pBUOL8+VeQciNx3XToc9fNpJv96kOK2cl69mh2BHgi75liBbQVLwt40CNgK5
         P83VO/FuMdjBgdhn9oAT8NPsT0CAGM9TeRfyTlWkodXj4EZI6OijO+UWK5c1kegv6Na7
         +F37nx/jp7kCZn3p1k6P596/lzs1h5aB3TGr8rB9Lo/y7G8fBxoUnB9/QXz6szgYZHA4
         78wXHmc0J1XlDXAi9VU2atXxACzv7Fw7PL/nWwY//GHVF4Ue+xgHdTxbarjBor7xEtx7
         Phkw==
X-Forwarded-Encrypted: i=1; AJvYcCU/caHpAXKqOXuOLLGpLUKIeQNsgbSICLgPHAQ6/uzZpkg9vqhjWHipg+vdX0WBQERETqi5WJpLdY6gJ8gHmVM9WLC/dtP1WVWFm+Jz8BTiQxIJEoFdJdP8lEXGeYfU3+ZUq/Em
X-Gm-Message-State: AOJu0YwlY4PkoI5U6N6915ljfVUHrQr7+ti7MIsdi1RqPMD1KQByOSYM
	ecn8nUNTzbCVjCp77uTQ9Km46cmyRQXwRfgXlULgAosdn8k2DWaS
X-Google-Smtp-Source: AGHT+IEyA06tFoP4OXbKmdI7yiXOK98xU+GGl8Z1d/DOxVD2Ihqo+Oi0AwEvPy35kO8m8ppN3eVWxQ==
X-Received: by 2002:a50:9b02:0:b0:566:131b:5b5f with SMTP id o2-20020a509b02000000b00566131b5b5fmr752299edi.26.1711570110204;
        Wed, 27 Mar 2024 13:08:30 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm2939840edv.25.2024.03.27.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:08:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: create a dummy net_device allocator
Date: Wed, 27 Mar 2024 13:08:04 -0700
Message-ID: <20240327200809.512867-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is impossible to use init_dummy_netdev together with alloc_netdev()
as the 'setup' argument.

This is because alloc_netdev() initializes some fields in the net_device
structure, and later init_dummy_netdev() memzero them all. This causes
some problems as reported here:

	https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/

Split the init_dummy_netdev() function in two. Create a new function called
init_dummy_netdev_core() that does not memzero the net_device structure.
Then have init_dummy_netdev() memzero-ing and calling
init_dummy_netdev_core(), keeping the old behaviour.

init_dummy_netdev_core() is the new function that could be called as an
argument for alloc_netdev().

Also, create a helper to allocate and initialize dummy net devices,
leveraging init_dummy_netdev_core() as the setup argument. This function
basically simplify the allocation of dummy devices, by allocating and
initializing it. Freeing the device continue to be done through
free_netdev()

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netdevice.h |  3 +++
 net/core/dev.c            | 55 ++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c6f6ac779b34..f4226a99a146 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4545,6 +4545,9 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
 
 void ether_setup(struct net_device *dev);
 
+/* Allocate dummy net_device */
+struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name);
+
 /* Support for loadable net-drivers */
 struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 				    unsigned char name_assign_type,
diff --git a/net/core/dev.c b/net/core/dev.c
index 0766a245816b..df2484bbc041 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10340,25 +10340,12 @@ int register_netdevice(struct net_device *dev)
 }
 EXPORT_SYMBOL(register_netdevice);
 
-/**
- *	init_dummy_netdev	- init a dummy network device for NAPI
- *	@dev: device to init
- *
- *	This takes a network device structure and initialize the minimum
- *	amount of fields so it can be used to schedule NAPI polls without
- *	registering a full blown interface. This is to be used by drivers
- *	that need to tie several hardware interfaces to a single NAPI
- *	poll scheduler due to HW limitations.
+/* Initialize the core of a dummy net device.
+ * This is useful if you are calling this function after alloc_netdev(),
+ * since it does not memset the net_device fields.
  */
-void init_dummy_netdev(struct net_device *dev)
+static void init_dummy_netdev_core(struct net_device *dev)
 {
-	/* Clear everything. Note we don't initialize spinlocks
-	 * are they aren't supposed to be taken by any of the
-	 * NAPI code and this dummy netdev is supposed to be
-	 * only ever used for NAPI polls
-	 */
-	memset(dev, 0, sizeof(struct net_device));
-
 	/* make sure we BUG if trying to hit standard
 	 * register/unregister code path
 	 */
@@ -10379,8 +10366,28 @@ void init_dummy_netdev(struct net_device *dev)
 	 * its refcount.
 	 */
 }
-EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
+/**
+ *	init_dummy_netdev	- init a dummy network device for NAPI
+ *	@dev: device to init
+ *
+ *	This takes a network device structure and initialize the minimum
+ *	amount of fields so it can be used to schedule NAPI polls without
+ *	registering a full blown interface. This is to be used by drivers
+ *	that need to tie several hardware interfaces to a single NAPI
+ *	poll scheduler due to HW limitations.
+ */
+void init_dummy_netdev(struct net_device *dev)
+{
+	/* Clear everything. Note we don't initialize spinlocks
+	 * are they aren't supposed to be taken by any of the
+	 * NAPI code and this dummy netdev is supposed to be
+	 * only ever used for NAPI polls
+	 */
+	memset(dev, 0, sizeof(struct net_device));
+	init_dummy_netdev_core(dev);
+}
+EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
 /**
  *	register_netdev	- register a network device
@@ -10991,6 +10998,18 @@ void free_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(free_netdev);
 
+/**
+ * alloc_netdev_dummy - Allocate and initialize a dummy net device.
+ * @sizeof_priv: size of private data to allocate space for
+ * @name: device name format string
+ */
+struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name)
+{
+	return alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN,
+			    init_dummy_netdev_core);
+}
+EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
+
 /**
  *	synchronize_net -  Synchronize with packet receive processing
  *
-- 
2.43.0



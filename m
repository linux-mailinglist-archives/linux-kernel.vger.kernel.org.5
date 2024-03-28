Return-Path: <linux-kernel+bounces-123839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4219A890EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659C21C241E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185B13B287;
	Thu, 28 Mar 2024 23:52:35 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E631A89;
	Thu, 28 Mar 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669955; cv=none; b=uD9t5hU49TO59nJSgkrFwwzPiksCKEUTk9UoLHQCN0SSZHR2tJAUgw2aDAX2m8+R+zbgM2SR3A5cMm18paLcsTR3Zb6MKVf86D2yYE3t94sbabyD2Qx4MyeynzoEz1VgKCh+tLnG5eFrOZmvjuWBXAFSnDrVaotJ+iJEJtkQIvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669955; c=relaxed/simple;
	bh=Aaex8XdaiRbhiPxurPKB6VvYpuawTdgcWzQkaL2dAAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMbI1bUvpfdDK3yEOX22zmSEka30/a/yFrXNNIdqzS/X3rks0bMdoB/yRqpm6dt6OLspxmGLZhDLS/mfdO1UD3+aJKv7cvtys0qJzjgWVJL4iCblMIQpZ6dVlgd416bwkhoukM+oRBUozV9WLYps0VFJEsuXphSmCxSqvgfxnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so201766766b.0;
        Thu, 28 Mar 2024 16:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711669952; x=1712274752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDQZ4TCZJAm8B9PFbu8n/GFhzD7Qvw4oLNGfFUuqwYg=;
        b=ei8IlcGRO5i8kM3O6sVVdvU/XdfE97SE4RRxIW1FzwytvdJOd8OeMsWr5W1R/IfAxN
         IhUEOkD6ZT6FgVMPIpjowVCdMw9UzqziX/GIcOhQS1xD1SSzZs3lQwJcqbN7TVaDisMe
         L8tEm/uqD7cfP8EFJ5Crssnpg37gfOe/wrWW4prI65ZWU4EE8utvYcvSfv6YxRE0ITJB
         GPjZ9jQDiE23XRRdRFKolm4Ogy1athK4Sig7WEAUbbxZ+3iG6ddvPb45Qm6+yrYC2pI4
         MSXVK8nTIIYXZJxnSkQoYnPHzcV5c3E8tiyOXKuQP6sPzlkc+HPSTOaO+GlN0pRfmmLc
         7TCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNTRXaKKqPoaRNHr3hDohGKCL/NHiF5B5s+t3kBqR8Za/bqXljwb4ccM1hLsOY5tS1eN5oi8sBhNeUvB4fGKygiVrBiUeqW6+rzJYG9sjypNjy7haQp+aRriL1ITJm3ZKW4Ll9
X-Gm-Message-State: AOJu0YxaSxYr8agYwcSI+TGKv6C7PNQ5pZLuftKscl5jnUI+vLnKKbBL
	BOjkBUrgHR2r9bIO98Kh4aP/an2tPqO7+ajXso+acvLQBWb2Tm5C
X-Google-Smtp-Source: AGHT+IH697SVZ05qTsKYQ9A+lgocUEzeu7PDOyaqtnwbg4LvVaLGYuxOD0HjVRrYzJnvwLCjU4XyxQ==
X-Received: by 2002:a17:906:68f:b0:a45:ad5d:98ac with SMTP id u15-20020a170906068f00b00a45ad5d98acmr424828ejb.44.1711669951559;
        Thu, 28 Mar 2024 16:52:31 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id le6-20020a170906ae0600b00a4e275ce430sm890993ejb.141.2024.03.28.16.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:52:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 1/5] net: create a dummy net_device allocator
Date: Thu, 28 Mar 2024 16:52:01 -0700
Message-ID: <20240328235214.4079063-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328235214.4079063-1-leitao@debian.org>
References: <20240328235214.4079063-1-leitao@debian.org>
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
 net/core/dev.c            | 54 ++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e41d30ebaca6..8aa4a2645ad5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4546,6 +4546,9 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
 
 void ether_setup(struct net_device *dev);
 
+/* Allocate dummy net_device */
+struct net_device *alloc_netdev_dummy(int sizeof_priv);
+
 /* Support for loadable net-drivers */
 struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 				    unsigned char name_assign_type,
diff --git a/net/core/dev.c b/net/core/dev.c
index 5d36a634f468..300e097b97d8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10391,25 +10391,12 @@ int register_netdevice(struct net_device *dev)
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
@@ -10430,8 +10417,28 @@ void init_dummy_netdev(struct net_device *dev)
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
@@ -11042,6 +11049,17 @@ void free_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(free_netdev);
 
+/**
+ * alloc_netdev_dummy - Allocate and initialize a dummy net device.
+ * @sizeof_priv: size of private data to allocate space for
+ */
+struct net_device *alloc_netdev_dummy(int sizeof_priv)
+{
+	return alloc_netdev(sizeof_priv, "dummy#", NET_NAME_UNKNOWN,
+			    init_dummy_netdev_core);
+}
+EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
+
 /**
  *	synchronize_net -  Synchronize with packet receive processing
  *
-- 
2.43.0



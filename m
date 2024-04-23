Return-Path: <linux-kernel+bounces-155777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 867FA8AF6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F15B27B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33281420B3;
	Tue, 23 Apr 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="n80HJiyp"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B013FD9F;
	Tue, 23 Apr 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899002; cv=none; b=JVP75drl8psQwAWIxDaevhh5fIpshhH1CYH+lMaJ1dxtQksDm8GNs0UjfM3oKQ0T15DgU57exRbhVYM8eSRjZvR2fWU4s/ehz4i/jtgvYheE7dIQ/UWQ7yNfCRLjCpcDs4qFLjE8638sC//GaCP5I9wt1nzqGTFFFuj97Fg4WTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899002; c=relaxed/simple;
	bh=6CA2yUI4lZF+hvaY11aNP5dxnASGSWgiQeLpU5ZmBgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJybiNiTBBZ5dj+sOgajs6VolSYV6Vk1aOa2eBNAPKk6YuH6rqca9ffQ7WFLYMJn34RGQP+jwv/suv0ehns8CmWKVcPEGt2xzO8QMsCTiwOYyp4kK9vEikl8X5/LSxNIC4pmKv9++De0U/S0JWNjSDYiQgeQBVWMOKhr+XQUuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=n80HJiyp reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c5f9482874c97825; Tue, 23 Apr 2024 20:03:18 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0FECB66DB86;
	Tue, 23 Apr 2024 20:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713895398;
	bh=6CA2yUI4lZF+hvaY11aNP5dxnASGSWgiQeLpU5ZmBgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n80HJiypBaaZCHp81z6vvN3RTpS3nCuHp/aMfIV5E0OHUbvkaxkKZn8nW6hmezcUJ
	 H3i+5aeG7mP5D6RjrZy5frXj+sbdQ3maH+Q8k+BWgEiy6oINg/LeRtfy8e++FYYkLh
	 nZHbFY6oIdQXvckByW3fKQBopNZVCU0rhhXV2/0CV7+K8Rky8pliuAaGLutJtG6wV0
	 EhVCoZXS7WuFlzn3hDvuYeuukvoLxlCG6GH5mFR2M7NXCUffO+Re+L+Tc/IOotcOuc
	 C4gDK79Dl4W0BP7vK9lkBzotGEeoZ+21GWi6WhEtrAtcVHXwvbN8bV101QQJmCwRUt
	 ADf+8V+Dpl7QQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 2/3] thermal/debugfs: Pass cooling device state to
 thermal_debug_cdev_add()
Date: Tue, 23 Apr 2024 20:00:57 +0200
Message-ID: <2181352.irdbgypaU6@kreacher>
In-Reply-To: <5774279.DvuYhMxLoT@kreacher>
References: <5774279.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If cdev_dt_seq_show() runs before the first state transition of a cooling
device, it will not print any state residency information for it, even
though it might be reasonably expected to print residency information for
the initial state of the cooling device.

For this reason, rearrange the code to get the initial state of a cooling
device at the registration time and pass it to thermal_debug_cdev_add(),
so that the latter can create a duration record for that state which will
allow cdev_dt_seq_show() to print its residency information.

Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    9 +++++++--
 drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
 drivers/thermal/thermal_debugfs.h |    4 ++--
 3 files changed, 19 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -928,6 +928,7 @@ __thermal_cooling_device_register(struct
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
+	unsigned long current_state;
 	int id, ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
@@ -965,6 +966,10 @@ __thermal_cooling_device_register(struct
 	if (ret)
 		goto out_cdev_type;
 
+	ret = cdev->ops->get_cur_state(cdev, &current_state);
+	if (ret)
+		goto out_cdev_type;
+
 	thermal_cooling_device_setup_sysfs(cdev);
 
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
@@ -978,6 +983,8 @@ __thermal_cooling_device_register(struct
 		return ERR_PTR(ret);
 	}
 
+	thermal_debug_cdev_add(cdev, current_state);
+
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
 
@@ -993,8 +1000,6 @@ __thermal_cooling_device_register(struct
 
 	mutex_unlock(&thermal_list_lock);
 
-	thermal_debug_cdev_add(cdev);
-
 	return cdev;
 
 out_cooling_dev:
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -466,8 +466,9 @@ void thermal_debug_cdev_state_update(con
  * Allocates a cooling device object for debug, initializes the
  * statistics and create the entries in sysfs.
  * @cdev: a pointer to a cooling device
+ * @state: current state of the cooling device
  */
-void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state)
 {
 	struct thermal_debugfs *thermal_dbg;
 	struct cdev_debugfs *cdev_dbg;
@@ -484,9 +485,16 @@ void thermal_debug_cdev_add(struct therm
 		INIT_LIST_HEAD(&cdev_dbg->durations[i]);
 	}
 
-	cdev_dbg->current_state = 0;
+	cdev_dbg->current_state = state;
 	cdev_dbg->timestamp = ktime_get();
 
+	/*
+	 * Create a record for the initial cooling device state, so its
+	 * duration will be printed by cdev_dt_seq_show() as expected if it
+	 * runs before the first state transition.
+	 */
+	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, state);
+
 	debugfs_create_file("trans_table", 0400, thermal_dbg->d_top,
 			    thermal_dbg, &tt_fops);
 
Index: linux-pm/drivers/thermal/thermal_debugfs.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.h
+++ linux-pm/drivers/thermal/thermal_debugfs.h
@@ -2,7 +2,7 @@
 
 #ifdef CONFIG_THERMAL_DEBUGFS
 void thermal_debug_init(void);
-void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state);
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
 void thermal_debug_tz_add(struct thermal_zone_device *tz);
@@ -14,7 +14,7 @@ void thermal_debug_tz_trip_down(struct t
 void thermal_debug_update_stats(struct thermal_zone_device *tz);
 #else
 static inline void thermal_debug_init(void) {}
-static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state) {}
 static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
 static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
 						   int state) {}





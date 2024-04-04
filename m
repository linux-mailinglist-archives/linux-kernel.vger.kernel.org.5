Return-Path: <linux-kernel+bounces-132039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A548898F05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E921C28444
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40A134CC6;
	Thu,  4 Apr 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sDcofTuR"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5E134404;
	Thu,  4 Apr 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258840; cv=none; b=dPZn6yI0nQGUiBIJDV45vVVqMlT9XdOvw791tOwgHXU8zI+NxsINTDREbiNNDoPVo8lkS3e09Vw99u3DUGczIiK0/UGOr9e+reHiJKaey8smTb4MWXXhGE/d5SijJ3Mu1xIShAlGhGy5bK7mSR4ZsMlyz+pYVUtJy4IhMDeDopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258840; c=relaxed/simple;
	bh=vkdN9bc97p/devrra31F+aN1d0APMHfWHF3uqUbNmeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JKBsofXKvs4gSl+8JqxgoLRYcHujCEUGTxtI8eN31m9lcrGvCyjKuaGJ7lvxaHCReFTiDnTCPZb3D3sNgF80Mr7VWuaGVbBquWvMCOFY7HN374lbuCL4FlKQxhPYvJRAURgSrxlr68bnKhiPTN++YYWZtCPcyW0yfPxvTXoylGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sDcofTuR reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 43b95b81933d4ea7; Thu, 4 Apr 2024 21:27:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 10BEE665D83;
	Thu,  4 Apr 2024 21:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712258828;
	bh=vkdN9bc97p/devrra31F+aN1d0APMHfWHF3uqUbNmeY=;
	h=From:To:Cc:Subject:Date;
	b=sDcofTuRmD2N8fsJqjfbBVB6JnF71+i8SyTf0c7HiZLTZ6WJ/T8OZfvZmJ5pq66E5
	 cZLs66t9veKtstJvDvteXA3jOENUk+Dasf5JvnwOGJA2rMnf7jOu6NOpDDp4nqXhsx
	 ZvfypW8W6v609L8KAgp5AyxPrKDKU0uFQqgoXwW/88chCsGsgDrqh+Bmf/tQPIdjB5
	 6ZSLqdFBaFRsaiptYXS2XdANvEj828mDq3upQ9iDY3ZsLTNYNPTRKSnfo9ycXokBAp
	 8e4735dYD+5xsKgfIPFCSAP5L0Sy7wVw91mN3HP32iqYVvn8TRzwYO349E7VxPCHCZ
	 GYHna4FWvEepQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1] thermal: core: Relocate the struct thermal_governor definition
Date: Thu, 04 Apr 2024 21:27:07 +0200
Message-ID: <2725268.mvXUDI8C0e@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgudefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that struct thermal_governor is only used by the thermal core
and so move its definition to thermal_core.h.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h |   25 +++++++++++++++++++++++++
 include/linux/thermal.h        |   25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -23,6 +23,31 @@ struct thermal_trip_desc {
 };
 
 /**
+ * struct thermal_governor - structure that holds thermal governor information
+ * @name:	name of the governor
+ * @bind_to_tz: callback called when binding to a thermal zone.  If it
+ *		returns 0, the governor is bound to the thermal zone,
+ *		otherwise it fails.
+ * @unbind_from_tz:	callback called when a governor is unbound from a
+ *			thermal zone.
+ * @throttle:	callback called for every trip point even if temperature is
+ *		below the trip point temperature
+ * @update_tz:	callback called when thermal zone internals have changed, e.g.
+ *		thermal cooling instance was added/removed
+ * @governor_list:	node in thermal_governor_list (in thermal_core.c)
+ */
+struct thermal_governor {
+	const char *name;
+	int (*bind_to_tz)(struct thermal_zone_device *tz);
+	void (*unbind_from_tz)(struct thermal_zone_device *tz);
+	int (*throttle)(struct thermal_zone_device *tz,
+			const struct thermal_trip *trip);
+	void (*update_tz)(struct thermal_zone_device *tz,
+			  enum thermal_notify_event reason);
+	struct list_head	governor_list;
+};
+
+/**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
  * @type:	the thermal zone device type
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -126,31 +126,6 @@ struct thermal_cooling_device {
 #endif
 };
 
-/**
- * struct thermal_governor - structure that holds thermal governor information
- * @name:	name of the governor
- * @bind_to_tz: callback called when binding to a thermal zone.  If it
- *		returns 0, the governor is bound to the thermal zone,
- *		otherwise it fails.
- * @unbind_from_tz:	callback called when a governor is unbound from a
- *			thermal zone.
- * @throttle:	callback called for every trip point even if temperature is
- *		below the trip point temperature
- * @update_tz:	callback called when thermal zone internals have changed, e.g.
- *		thermal cooling instance was added/removed
- * @governor_list:	node in thermal_governor_list (in thermal_core.c)
- */
-struct thermal_governor {
-	const char *name;
-	int (*bind_to_tz)(struct thermal_zone_device *tz);
-	void (*unbind_from_tz)(struct thermal_zone_device *tz);
-	int (*throttle)(struct thermal_zone_device *tz,
-			const struct thermal_trip *trip);
-	void (*update_tz)(struct thermal_zone_device *tz,
-			  enum thermal_notify_event reason);
-	struct list_head	governor_list;
-};
-
 /* Structure to define Thermal Zone parameters */
 struct thermal_zone_params {
 	const char *governor_name;





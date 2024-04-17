Return-Path: <linux-kernel+bounces-148524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D4A8A83F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DFA284B81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD1140E30;
	Wed, 17 Apr 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BzfDyKsj"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115E13E88C;
	Wed, 17 Apr 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359529; cv=none; b=vBh4p9GF5i6sBRWGdYwxy/+kqydQD67YIzjc/1+n8Nq1a+liQiKpn6SkbOlzI9cp7F5sXcChHAOPBIRE4CxFxrW9KHnlDLxjBaG2NgIbNWtId9aT2eeqiBVZ5SDODu/rtZ4d+XoIlht6VKVSWzswnqKx1bXhDFdPTOhtBJEbcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359529; c=relaxed/simple;
	bh=8QaLAPTDIhcj685tv/xgh0SXkZ17NauhUBDxY/86eRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbP63xax0vJVftnB+NGFVW3MN4mC4VI6sa4apwvfl3Qrk7yu2/YAi2rY3k/rkMKu+rCGpCkvBd7akVbPYW6Vr7xCdCqycZZEcoudSEJGgz1kFxH28h/ZeJqirZHyfYqkD8Tr9u9NbxKLXz25xdLJ2uiPG5f9VNYjmUQzeZkFqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BzfDyKsj reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 612d45fe4c8ba6e1; Wed, 17 Apr 2024 15:11:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7354166D262;
	Wed, 17 Apr 2024 15:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713359516;
	bh=8QaLAPTDIhcj685tv/xgh0SXkZ17NauhUBDxY/86eRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzfDyKsjCxbokZNWvmHDcRVKiipl5iYe/YxFVFOyazEAxCnoFnamOZJ2Ye7J0KrGS
	 To3OUtvLXqCHHFQQp7VY5EUeCOSvvGx89MlZ9Oc24jftL/2BDeQC2GsozYGaSLDU75
	 +133WOWcQSd+pPn6Qhd17UQ85AFekxyVdOtUC7vO9SemQTOlg0m7RkuE3CYlsS/s3G
	 hDZEeuDhTpw0KoQh5ZdhUQcBg6Qac5hmxkgQ8tmRXfwWZ/+3PakMB+glvphc63eZs/
	 71CrfC3GtPfu3+sJCE4mHEitvGiUG8gvXUyUZu1vbKeW13jwbszRAHQlJOaJ+5ieNs
	 /RcA9WxPL40MA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 3/3] thermal/debugfs: Rename thermal_debug_update_temp() to
 thermal_debug_update_trip_stats()
Date: Wed, 17 Apr 2024 15:11:50 +0200
Message-ID: <2937506.e9J7NaK4W3@kreacher>
In-Reply-To: <4918025.31r3eYUQgx@kreacher>
References: <4918025.31r3eYUQgx@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename thermal_debug_update_temp() to thermal_debug_update_trip_stats()
which is a better match for the purpose of the function.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    2 +-
 drivers/thermal/thermal_debugfs.c |    2 +-
 drivers/thermal/thermal_debugfs.h |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -504,7 +504,7 @@ void __thermal_zone_device_update(struct
 	if (governor->manage)
 		governor->manage(tz);
 
-	thermal_debug_update_temp(tz);
+	thermal_debug_update_trip_stats(tz);
 
 	monitor_thermal_zone(tz);
 }
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -676,7 +676,7 @@ out:
 	mutex_unlock(&thermal_dbg->lock);
 }
 
-void thermal_debug_update_temp(struct thermal_zone_device *tz)
+void thermal_debug_update_trip_stats(struct thermal_zone_device *tz)
 {
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
 	struct tz_debugfs *tz_dbg;
Index: linux-pm/drivers/thermal/thermal_debugfs.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.h
+++ linux-pm/drivers/thermal/thermal_debugfs.h
@@ -11,7 +11,7 @@ void thermal_debug_tz_trip_up(struct the
 			      const struct thermal_trip *trip);
 void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
 				const struct thermal_trip *trip);
-void thermal_debug_update_temp(struct thermal_zone_device *tz);
+void thermal_debug_update_trip_stats(struct thermal_zone_device *tz);
 #else
 static inline void thermal_debug_init(void) {}
 static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
@@ -24,5 +24,5 @@ static inline void thermal_debug_tz_trip
 					    const struct thermal_trip *trip) {};
 static inline void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
 					      const struct thermal_trip *trip) {}
-static inline void thermal_debug_update_temp(struct thermal_zone_device *tz) {}
+static inline void thermal_debug_update_trip_stats(struct thermal_zone_device *tz) {}
 #endif /* CONFIG_THERMAL_DEBUGFS */





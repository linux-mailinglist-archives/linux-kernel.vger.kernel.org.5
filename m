Return-Path: <linux-kernel+bounces-155774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212558AF6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25652869EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EAC13FD67;
	Tue, 23 Apr 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="k/Wg5lgZ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1822F00;
	Tue, 23 Apr 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898880; cv=none; b=r+hKRXRZRDBGtAGeV/QB+FpT4UigT8EP3mLj0yfYdVAUWR7wukLNwQHioev0nQ8Tyo9+5IKUVfADdQzmCNhRgvt44C7p1j7S2bLT33y7ZPpAmPnpSJF3sGGWeQlbgs42wjdwIXi+AcWV5rVXykxXrif7Wutj5g7AM42DPK4yR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898880; c=relaxed/simple;
	bh=tkGMGjpcpFko6fk7a+2OyUel2wfyFYBcaIRYqOvd8j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GUGtIsq+p8MzFWjZMGSuxQU+W7+98g8l23eBhz1wXRCYhq0bdjv7j3ExCa/McRJTrki3m39AIU8MGlVyM2ZgKwYCFWf/yH5ZHo5iwTNVAaCq/Cko+a9TmbEie6316DlA4rYaBaqo7hgwzNBcm1jafbMVgh5JzIBXZNW5lC1nzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=k/Wg5lgZ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 963cb8568aca2043; Tue, 23 Apr 2024 21:01:16 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8445966DB89;
	Tue, 23 Apr 2024 21:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713898876;
	bh=tkGMGjpcpFko6fk7a+2OyUel2wfyFYBcaIRYqOvd8j4=;
	h=From:To:Cc:Subject:Date;
	b=k/Wg5lgZMEI9xlmnJYmKdoQ83DZxUokRlMzbEMewF+adSgHS1rUSJXPlQlTsWPCrc
	 giOFs6fCDz4qA0Cr/N4TVJkDYuacEb8RcjQ5ZSiccUq634LQgdkZK1qdONvtvgSH2f
	 fmkq8Xb5Vbye9PgMSwI4DtbfqiGnFIeekexQ8nLvnlyxpzR50BEI7dqlgqDmxtO0/4
	 xmGdXR3Zbai9SveBIFCXuiGZGpVpSHPwIETPx8/CLiwc1oWJueXckdtNdF3zHyE3ki
	 6D2+9Dzfnl2nLmjBOxx1ABwRVlJ4uc2+iChKec/C7rfP7QT9aI8wIQn1fClvegKLL5
	 uh0OzDYonEOvQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1] thermal: core: Introduce thermal_governor_trip_crossed()
Date: Tue, 23 Apr 2024 21:01:15 +0200
Message-ID: <12426299.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgv
 lhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a wrapper around the .trip_crossed() governor callback invocation
to reduce code duplications slightly and improve the code layout in
__thermal_zone_device_update().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

As requested in https://lore.kernel.org/linux-pm/3c169af3-e9c3-47c0-b343-48f699680009@linaro.org/

---
 drivers/thermal/thermal_core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -450,6 +450,15 @@ static void thermal_zone_device_init(str
 		pos->initialized = false;
 }
 
+static void thermal_governor_trip_crossed(struct thermal_governor *governor,
+					  struct thermal_zone_device *tz,
+					  const struct thermal_trip *trip,
+					  bool crossed_up)
+{
+	if (governor->trip_crossed)
+		governor->trip_crossed(tz, trip, crossed_up);
+}
+
 static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
 				   const struct list_head *b)
 {
@@ -489,16 +498,14 @@ void __thermal_zone_device_update(struct
 	list_for_each_entry(td, &way_up_list, notify_list_node) {
 		thermal_notify_tz_trip_up(tz, &td->trip);
 		thermal_debug_tz_trip_up(tz, &td->trip);
-		if (governor->trip_crossed)
-			governor->trip_crossed(tz, &td->trip, true);
+		thermal_governor_trip_crossed(governor, tz, &td->trip, true);
 	}
 
 	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_down_list, notify_list_node) {
 		thermal_notify_tz_trip_down(tz, &td->trip);
 		thermal_debug_tz_trip_down(tz, &td->trip);
-		if (governor->trip_crossed)
-			governor->trip_crossed(tz, &td->trip, false);
+		thermal_governor_trip_crossed(governor, tz, &td->trip, false);
 	}
 
 	if (governor->manage)





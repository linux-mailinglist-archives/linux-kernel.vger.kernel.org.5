Return-Path: <linux-kernel+bounces-148851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A18A8820
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6581F23F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B91487F7;
	Wed, 17 Apr 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="l/ivSgb7"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EB1487E2;
	Wed, 17 Apr 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369095; cv=none; b=PUjkDzH/lfZSsJnDGIvCHTP4W0CHDH6FAWcxpBD7wUTpL8my5bzN5Ej++WeXpClZEWGK+tkhaKprgRkyTyBn+z0TS2a0JT9UAJ6ogznmquidEJ9tggnVwp+4BXCBzIRW9H2XTDRLUWt82LzFey40+9z1rTW9fFCkQotRrvkNXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369095; c=relaxed/simple;
	bh=KHhUKfMqKwftT0o+cptgB02ZPGoBIFgTbNYwHn4USI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=maiatUpkCW2OD8srxiXsgZCfRcjLemLhFFKbVOu9sIrBMn6qJ5UZNFVDrvtR0ykRdJ88+wNly4XK4iIc0noZ9PLBDrhA9OYwK1Ld5+eeDEb6hOQ3QXIG3AsKcv2QqRpg5Eyf3EQUoUcuFw6MO3bC+x7wKitWLRghFyH1ybNLbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=l/ivSgb7 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 55df5da1b28053fc; Wed, 17 Apr 2024 17:51:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9C80666D284;
	Wed, 17 Apr 2024 17:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713369090;
	bh=KHhUKfMqKwftT0o+cptgB02ZPGoBIFgTbNYwHn4USI8=;
	h=From:To:Cc:Subject:Date;
	b=l/ivSgb7g6hD/JHHwT+0JQ9VJY8RsHdlVzUV+kjmrLU1YS/jbO+qvyeT04OyYODAi
	 gkaLbnKaZkZiAQ+fm2W+iCQDcZGzLuS3ttWvcmJk8Wghj+4I8Nqf58jsGCfjvaPOJL
	 SwyZLdY9nGUWdqV4GpOKWrOzlkswGDF6ngQd7/4fvn/zFB7wisk0JbGCgiM8XMUcQ7
	 lpdruSIFU9LeKd2Ipn/4udCdQorL8isq2VIpdW3ontxe4xAxYgJS8arq/GyFp6AGgP
	 ujIfWtapQK9rm5ScP2gA7gTlCwUQuoDI+cwxd5rskqw/4Ku2adsvristFnVM2IHuok
	 H3LliR7xuw8dQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] thermal/debugfs: Make tze_seq_show() skip invalid trips and trips
 with no stats
Date: Wed, 17 Apr 2024 17:51:29 +0200
Message-ID: <2727917.mvXUDI8C0e@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
 rhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, tze_seq_show() output includes all of the trips in the zone
except for critical ones, including invalid trips and trips with no stats
which is confusing.

Make it skip the trips for which there is not mitigation information.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is independent of the other thermal patches sent by me recently.

---
 drivers/thermal/thermal_debugfs.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -754,6 +754,11 @@ static int tze_seq_show(struct seq_file
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
+		struct trip_stats *trip_stats;
+
+		/* Skip invalid trips. */
+		if (trip->temperature == THERMAL_TEMP_INVALID)
+			continue;
 
 		/*
 		 * There is no possible mitigation happening at the
@@ -763,6 +768,13 @@ static int tze_seq_show(struct seq_file
 		if (trip->type == THERMAL_TRIP_CRITICAL)
 			continue;
 
+		trip_id = thermal_zone_trip_id(tz, trip);
+		trip_stats = &tze->trip_stats[trip_id];
+
+		/* Skip trips without any stats. */
+		if (trip_stats->min > trip_stats->max)
+			continue;
+
 		if (trip->type == THERMAL_TRIP_PASSIVE)
 			type = "passive";
 		else if (trip->type == THERMAL_TRIP_ACTIVE)
@@ -770,17 +782,15 @@ static int tze_seq_show(struct seq_file
 		else
 			type = "hot";
 
-		trip_id = thermal_zone_trip_id(tz, trip);
-
 		seq_printf(s, "| %*d | %*s | %*d | %*d | %*lld | %*d | %*d | %*d |\n",
 			   4 , trip_id,
 			   8, type,
 			   9, trip->temperature,
 			   9, trip->hysteresis,
-			   10, ktime_to_ms(tze->trip_stats[trip_id].duration),
-			   9, tze->trip_stats[trip_id].avg,
-			   9, tze->trip_stats[trip_id].min,
-			   9, tze->trip_stats[trip_id].max);
+			   10, ktime_to_ms(trip_stats->duration),
+			   9, trip_stats->avg,
+			   9, trip_stats->min,
+			   9, trip_stats->max);
 	}
 
 	return 0;





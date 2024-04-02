Return-Path: <linux-kernel+bounces-128537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BB8895C28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C14F287035
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BB15CD41;
	Tue,  2 Apr 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kSHA0010"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97715B545;
	Tue,  2 Apr 2024 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084692; cv=none; b=eZrh0egYldR9pJNPH7dqmcgUmAyNAbBTA/UbWk9A1Js0TdjAL/wAeGy+wjtkL85tM3WbOoqbSPWf9Kw4rm0jfhyjcCtJmP5ChRM76XKMHq5BSCRtBUc2S5iCluj0bZCULgesy3gKhvmpi3njVb9qq+qM0CMMHzX9uel3P0NNvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084692; c=relaxed/simple;
	bh=2dcqxo9c6BdB6SEFCjR+IPVn6M6pE3yvQx46EWwBfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6MJcOzzLTRY2hzcPpV2wCbcr5i0HSs/26+k6wXq0DYISgrkAeSfECdwzgu+vSH7ib3YLWUBQhzDxFZkBij+l1fd8J8OuEvhpmC6iA/PjyTcEUNZB+vN5k+klkuerRf/Rb+FvGD9BNC2vtysgy3lxkwYGvYUB9llZY4tjeNLnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kSHA0010 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 3a062e1005967750; Tue, 2 Apr 2024 21:04:42 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 138A066C5C5;
	Tue,  2 Apr 2024 21:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712084682;
	bh=2dcqxo9c6BdB6SEFCjR+IPVn6M6pE3yvQx46EWwBfdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kSHA0010Tl88AoTXE08yRucGzMwtjGZhSRByMzrU0LhaJLKY6dUzoJC4tejRtS9H9
	 0uanEKn+Rpz9Ow+WvhBdAYUe+XotFnEWuLRm5CQpWcGk1ionX8b+GNx6c8sT/kgaTC
	 0OSGPbGumTHhJTjJ9j2mSJ9eGMJZOUe02Of4rzSbrY6xU9OGr30V6ljhYPdHlVQvvo
	 h/B2fizeMAwe/bAxfSTvi6iJCtGWRPw03PN7Xo1aoUTNcncBtTHQ35Xw/b5rOqsdio
	 D04ubleazI13t+pdXQRo5OEIu7vscFVG+HBkatfeiYl8+YkfGHUtuD+sUr9WMli51n
	 L1eo3D97uMgMw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v3 4/6] thermal: core: Send trip crossing notifications at init time
 if needed
Date: Tue, 02 Apr 2024 21:02:10 +0200
Message-ID: <1963742.PYKUYFuaPT@kreacher>
In-Reply-To: <4558251.LvFx2qVVIh@kreacher>
References: <4558251.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgr
 rhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a trip point is already exceeded by the zone temperature at the
initialization time, no trip crossing notification is send regarding
this even though mitigation should be started then.

Address this by rearranging the code in handle_thermal_trip() to
send a trip crossing notification for trip points already exceeded
by the zone temperature initially which also allows to reduce its
size by using the observation that the initialization and regular
trip crossing on the way up become the same case then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: New patch

---
 drivers/thermal/thermal_core.c |   37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -364,6 +364,7 @@ static void handle_thermal_trip(struct t
 				struct thermal_trip_desc *td)
 {
 	const struct thermal_trip *trip = &td->trip;
+	int old_threshold;
 
 	if (trip->temperature == THERMAL_TEMP_INVALID)
 		return;
@@ -375,25 +376,11 @@ static void handle_thermal_trip(struct t
 	 * is what needs to be compared with the previous zone temperature
 	 * to decide which action to take.
 	 */
-	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
-		/* Initialization. */
-		td->threshold = trip->temperature;
-		if (tz->temperature >= td->threshold)
-			td->threshold -= trip->hysteresis;
-	} else if (tz->last_temperature < td->threshold) {
-		/*
-		 * There is no mitigation under way, so it needs to be started
-		 * if the zone temperature exceeds the trip one.  The new
-		 * threshold is then set to the low temperature of the trip.
-		 */
-		if (tz->temperature >= trip->temperature) {
-			thermal_notify_tz_trip_up(tz, trip);
-			thermal_debug_tz_trip_up(tz, trip);
-			td->threshold = trip->temperature - trip->hysteresis;
-		} else {
-			td->threshold = trip->temperature;
-		}
-	} else {
+	old_threshold = td->threshold;
+	td->threshold = trip->temperature;
+
+	if (tz->last_temperature >= old_threshold &&
+	    tz->last_temperature != THERMAL_TEMP_INVALID) {
 		/*
 		 * Mitigation is under way, so it needs to stop if the zone
 		 * temperature falls below the low temperature of the trip.
@@ -402,10 +389,18 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz, trip);
 			thermal_debug_tz_trip_down(tz, trip);
-			td->threshold = trip->temperature;
 		} else {
-			td->threshold = trip->temperature - trip->hysteresis;
+			td->threshold -= trip->hysteresis;
 		}
+	} else if (tz->temperature >= trip->temperature) {
+		/*
+		 * There is no mitigation under way, so it needs to be started
+		 * if the zone temperature exceeds the trip one.  The new
+		 * threshold is then set to the low temperature of the trip.
+		 */
+		thermal_notify_tz_trip_up(tz, trip);
+		thermal_debug_tz_trip_up(tz, trip);
+		td->threshold -= trip->hysteresis;
 	}
 
 	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)





Return-Path: <linux-kernel+bounces-145743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569B8A5A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AD61C2244A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484615575B;
	Mon, 15 Apr 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M9EGh4hO"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2884D24;
	Mon, 15 Apr 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207803; cv=none; b=TMeqPJah9IjtCfrwR+wtuTZJNNu04GvDRwTEpMoZeEVmmZP2+WbD8W2wjDahZxd0fl0LW4DHaH7E9zos4nNBkFwNbFJCrvToFY6Oph/GyOcEO/vE7Bw3MyZ5ol/xixi0iILYUOrp476cFpVxVoHUMmsX7nuJeTqIHJvsycPowb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207803; c=relaxed/simple;
	bh=CQNI1NZ7g4v/dwm4IEXv3eA8nBv8ecvnI47e7IY43ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/6n9pdD/3sl6kq6hOO+Vz9mBDV+3rKclldxvIc/zaHdNUDVY6/39ZBM2afJ4/htyTlDDRX5COUD05T5iC7ILQm3uJFw/XERHJ6tH+wVYh8FxXneLl3CmQImLba15XLZ0vgk+s4yyInO93GpbES42IKF52V/vsm3uFxUO1YqVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M9EGh4hO reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id e37f4f2d11543fe6; Mon, 15 Apr 2024 21:03:12 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8A69D66CF45;
	Mon, 15 Apr 2024 21:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713207792;
	bh=CQNI1NZ7g4v/dwm4IEXv3eA8nBv8ecvnI47e7IY43ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9EGh4hODnGqxqAYnNjSiv101bCMaZIlxWdb/zEp7XiWTnyPnayIMso9Yg8faJ9M3
	 r57uiL/FBfHoDW99iReGstfc/qItdgnx8rXzg/N++/zuJUXE1UtODq4AgZQIEPMYS1
	 xw28c7SbtnFpkVMcPKkRVfHv7NMav3jYXQnR9khHutNr7g17Cx/PTX+48/ZYN1rMUa
	 5LK2pvFWa81nmqDJ8cbqXxiJN5dKcYilPwr7jcT1q4QAP62Klw8fXMj7QtWhaX62G4
	 0hiyjWlRqfRqvk95h+slHnhKITQ20lIKONSNoNhJ4Lg9FRChX+80svF0l7W7Dwg8Y/
	 AQSGkIo0ekqDA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 2/2] thermal/debugfs: Add helper function for trip stats updates
Date: Mon, 15 Apr 2024 21:03:06 +0200
Message-ID: <2321994.ElGaqSPkdT@kreacher>
In-Reply-To: <12418263.O9o76ZdvQC@kreacher>
References: <12418263.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code updating a trip_stats entry in thermal_debug_tz_trip_up()
and thermal_debug_update_temp() is almost entirely duplicate, so move
it to a new helper function that will be called from both these places.

While at it, drop a redundant tz_dbg->nr_trips check and a label related
to it from thermal_debug_update_temp().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   42 +++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -539,6 +539,19 @@ static struct tz_episode *thermal_debugf
 	return tze;
 }
 
+static struct trip_stats *update_tz_episode(struct tz_debugfs *tz_dbg,
+					    int trip_id, int temperature)
+{
+	struct tz_episode *tze = list_first_entry(&tz_dbg->tz_episodes,
+						  struct tz_episode, node);
+	struct trip_stats *trip_stats = &tze->trip_stats[trip_id];
+
+	trip_stats->max = max(trip_stats->max, temperature);
+	trip_stats->min = min(trip_stats->min, temperature);
+	trip_stats->avg += (temperature - trip_stats->avg) / ++trip_stats->count;
+	return trip_stats;
+}
+
 void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 			      const struct thermal_trip *trip)
 {
@@ -547,6 +560,7 @@ void thermal_debug_tz_trip_up(struct the
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
 	int temperature = tz->temperature;
 	int trip_id = thermal_zone_trip_id(tz, trip);
+	struct trip_stats *trip_stats;
 	ktime_t now = ktime_get();
 
 	if (!thermal_dbg)
@@ -612,14 +626,8 @@ void thermal_debug_tz_trip_up(struct the
 	 */
 	tz_dbg->trips_crossed[tz_dbg->nr_trips++] = trip_id;
 
-	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
-	tze->trip_stats[trip_id].timestamp = now;
-	tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
-	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
-	tze->trip_stats[trip_id].count++;
-	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
-		(temperature - tze->trip_stats[trip_id].avg) /
-		tze->trip_stats[trip_id].count;
+	trip_stats = update_tz_episode(tz_dbg, trip_id, temperature);
+	trip_stats->timestamp = now;
 
 unlock:
 	mutex_unlock(&thermal_dbg->lock);
@@ -686,9 +694,8 @@ out:
 void thermal_debug_update_temp(struct thermal_zone_device *tz)
 {
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
-	struct tz_episode *tze;
 	struct tz_debugfs *tz_dbg;
-	int trip_id, i;
+	int i;
 
 	if (!thermal_dbg)
 		return;
@@ -697,20 +704,9 @@ void thermal_debug_update_temp(struct th
 
 	tz_dbg = &thermal_dbg->tz_dbg;
 
-	if (!tz_dbg->nr_trips)
-		goto out;
+	for (i = 0; i < tz_dbg->nr_trips; i++)
+		update_tz_episode(tz_dbg, tz_dbg->trips_crossed[i], tz->temperature);
 
-	for (i = 0; i < tz_dbg->nr_trips; i++) {
-		trip_id = tz_dbg->trips_crossed[i];
-		tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
-		tze->trip_stats[trip_id].count++;
-		tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, tz->temperature);
-		tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, tz->temperature);
-		tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
-			(tz->temperature - tze->trip_stats[trip_id].avg) /
-			tze->trip_stats[trip_id].count;
-	}
-out:
 	mutex_unlock(&thermal_dbg->lock);
 }
 





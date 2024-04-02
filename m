Return-Path: <linux-kernel+bounces-128538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE9895C2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E44287035
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58415D5B3;
	Tue,  2 Apr 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Qug/eleB"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F315B971;
	Tue,  2 Apr 2024 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084694; cv=none; b=nndbUIdzQs5KEaz5l+LmYkMplMB/LM5tlxomod18uSw3JN63FzEQ+wvw3qThEz/umBh48JxRUf0hWZxjqNn2u+/l2c9L8XNCZzLKzs4fCf+YF4BsVa9fg7JCbJAAONuaw0mvdpHVSkKHt6gQLl+qqJoKTvIMHSvFowbOUcsU/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084694; c=relaxed/simple;
	bh=DE5eoRU2f66R4TK5qRodALK3I7w9DDS5pmcpplghZ58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7UoKeXRUa5KXm9UDJLxw+Z+QBKfRFpaD0LNqbj6Qi7oobzlLtkZ2hYnOUyAfc2GeSK9EQVxz526cxzopyMsYdf6Rfpofj5CEh4nsNIrP870XKaI07VmsFK57I+xVvKVtTARWxd/eex8V/mSUJjMjcQauVXS3xBpuKkK7iCUwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Qug/eleB reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 7976256cf383d4e6; Tue, 2 Apr 2024 21:04:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2593166C5C5;
	Tue,  2 Apr 2024 21:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712084683;
	bh=DE5eoRU2f66R4TK5qRodALK3I7w9DDS5pmcpplghZ58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qug/eleBuOyrSLSmQTd4xlGehY/wHzcNOHoxz4CwwUICz/w5DRyLsE1pTucnMGjfy
	 OP+lTOnERUvKcKE5J4DF42Sti8ihvKPkcAgCgD+0Gsct4W696C0UquNY8H6lQkD2KF
	 FZSHTRvkKSo35JKZdmKcAjzJjgetNoLHEpeY4rdeaLW5nc9H8a8EWQJ5JZXibm19ga
	 UW1AKLsnpdpUHFqa9BtEMRXLSaJBYUONtyzxgkrc7kZEYeLd50JRB5GlD/NHfZflsJ
	 QEY7cVDen9F/YVcghWJDO1JERcZUGQwU9mnn0tSieU57MfcwJxFcQbai4ktbFSkPNG
	 kWy3uiHg8QCpw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v3 3/6] thermal: core: Rewrite comments in handle_thermal_trip()
Date: Tue, 02 Apr 2024 20:59:01 +0200
Message-ID: <3284691.aeNJFYEL58@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgr
 rhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the comments regarding trip crossing and threshold updates in
handle_thermal_trip() slightly more clear.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: New patch

---
 drivers/thermal/thermal_core.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -368,6 +368,13 @@ static void handle_thermal_trip(struct t
 	if (trip->temperature == THERMAL_TEMP_INVALID)
 		return;
 
+	/*
+	 * If the trip temperature or hysteresis has been updated recently,
+	 * the threshold needs to be computed again using the new values.
+	 * However, its initial value still reflects the old ones and that
+	 * is what needs to be compared with the previous zone temperature
+	 * to decide which action to take.
+	 */
 	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
 		/* Initialization. */
 		td->threshold = trip->temperature;
@@ -375,11 +382,9 @@ static void handle_thermal_trip(struct t
 			td->threshold -= trip->hysteresis;
 	} else if (tz->last_temperature < td->threshold) {
 		/*
-		 * The trip threshold is equal to the trip temperature, unless
-		 * the latter has changed in the meantime.  In either case,
-		 * the trip is crossed if the current zone temperature is at
-		 * least equal to its temperature, but otherwise ensure that
-		 * the threshold and the trip temperature will be equal.
+		 * There is no mitigation under way, so it needs to be started
+		 * if the zone temperature exceeds the trip one.  The new
+		 * threshold is then set to the low temperature of the trip.
 		 */
 		if (tz->temperature >= trip->temperature) {
 			thermal_notify_tz_trip_up(tz, trip);
@@ -390,14 +395,9 @@ static void handle_thermal_trip(struct t
 		}
 	} else {
 		/*
-		 * The previous zone temperature was above or equal to the trip
-		 * threshold, which would be equal to the "low temperature" of
-		 * the trip (its temperature minus its hysteresis), unless the
-		 * trip temperature or hysteresis had changed.  In either case,
-		 * the trip is crossed if the current zone temperature is below
-		 * the low temperature of the trip, but otherwise ensure that
-		 * the trip threshold will be equal to the low temperature of
-		 * the trip.
+		 * Mitigation is under way, so it needs to stop if the zone
+		 * temperature falls below the low temperature of the trip.
+		 * In that case, the trip temperature becomes the new threshold.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz, trip);





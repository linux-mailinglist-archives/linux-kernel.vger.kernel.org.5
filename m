Return-Path: <linux-kernel+bounces-139133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1089FEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1472D28AB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B17190678;
	Wed, 10 Apr 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XlQ7hpRB"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207517F39D;
	Wed, 10 Apr 2024 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771103; cv=none; b=t/f5I0FsXDy8gH90PR7Z7Aq4RQVv/2aSSPj6Oag5TIwjv10IhtcOJkvRwYmJPC2avXkY8swqZ+S4V8ZTaGr7VvQSM0PzUPWF6YWROvF7whMnptL7Fgu4eshdo3I7RQUejBh+QyLf6Mcd5+5hRh9OmSiUD57WRnTxNaIgRUkjAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771103; c=relaxed/simple;
	bh=CifjVrjUKG+0XiMiN+5J1c80gqRxTGj0TWQ+VlD1gpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxa1H4VvwcWlecHJxsw5+4pczpTwTwl3lwhALm6QBCHUzA0pPt2sR2Os6nwwWL5wmIGGeB+KiBEmEZRu1ISUegt+pKL2UOZqWVTLal6xZJASuIwD93wMU6VzFclNESqzjrRgCY6JFUUg+9q/YeaQN2TUOhBAn6xuAVBOhP3R828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XlQ7hpRB reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 7f3fb694b8305f10; Wed, 10 Apr 2024 19:44:51 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 17AB566C66F;
	Wed, 10 Apr 2024 19:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771091;
	bh=CifjVrjUKG+0XiMiN+5J1c80gqRxTGj0TWQ+VlD1gpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XlQ7hpRB3aaato4ZrW3UEMBhSR3zgyzYkSR3z0FfTX9J3mfCPfsSxsiq48K1qKaTk
	 GGIOk7L5XTDBcwqgK3vqhJTCOCHnWMionLjtcAewNCve7GLBeqnoJ6+eej3bAsF1c5
	 9qwdLj3JOV+IURbJfc+UOV9I8bNYCgPJMmmsJ4EgU99HsFICyJ12JtCukOhwgnwBb+
	 tudBy84msFDYgBJuPA5uGGWFISVDK/7IAfbYdTE2Crn+cDyBHmJrK9oIxk1VK7PNu5
	 hxwSEUhusjbWO+dYMw4bf8h9+udNZpkmgvI+SJYMXmIcpPnOBE9aBfhEBfsVOAQ1Xr
	 FZNnBL0D9Fqjw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 12/16] thermal: gov_fair_share: Use trip thresholds instead of trip
 temperatures
Date: Wed, 10 Apr 2024 18:58:56 +0200
Message-ID: <5484095.Sb9uPGUboI@kreacher>
In-Reply-To: <13515747.uLZWGnKmhe@kreacher>
References: <13515747.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In principle, the Fair Share governor should take trip hystereses
into account.  After all, once a trip has been crossed on the way up,
mitigation is still needed until it is crossed on the way down.

For this reason, make it use trip thresholds that are computed by
the core when trips are crossed, so as to apply mitigations if the
zone temperature is in a hysteresis rage of one or more trips that
were crossed on the way up, but have not been crossed on the way
down yet.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_fair_share.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -17,28 +17,26 @@
 
 static int get_trip_level(struct thermal_zone_device *tz)
 {
-	const struct thermal_trip *level_trip = NULL;
+	const struct thermal_trip_desc *level_td = NULL;
 	const struct thermal_trip_desc *td;
 	int trip_level = -1;
 
 	for_each_trip_desc(tz, td) {
-		const struct thermal_trip *trip = &td->trip;
-
-		if (trip->temperature >= tz->temperature)
+		if (td->threshold > tz->temperature)
 			continue;
 
 		trip_level++;
 
-		if (!level_trip || trip->temperature > level_trip->temperature)
-			level_trip = trip;
+		if (!level_td || td->threshold > level_td->threshold)
+			level_td = td;
 	}
 
 	/*  Bail out if the temperature is not greater than any trips. */
 	if (trip_level < 0)
 		return 0;
 
-	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, level_trip),
-				level_trip->type);
+	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, &level_td->trip),
+				level_td->trip.type);
 
 	return trip_level;
 }





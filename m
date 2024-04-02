Return-Path: <linux-kernel+bounces-128533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F22895C22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9DB0B24C51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1267C15B55F;
	Tue,  2 Apr 2024 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="I5+8kT4Q"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990715B15D;
	Tue,  2 Apr 2024 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084690; cv=none; b=L8Z/Ky30HNil6RHhLAYCkiRpT2BP+UxE7wi9fyEayGiEcdlCgTfyYvJM3bu41AY6bjQzR1e1+YJ8Ga54/7Xzc+vkPSKOBbIzr0PBlYHWTwvYZ27VmArxddJaVpuGEE5NDhgf+UrDstYo/4x/6QkLrKT5A1G4FWiRpq05x3hhE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084690; c=relaxed/simple;
	bh=Sav0fBkqwvpYmvVJzF5OXLJQIoDayOcopD95uzdB+yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nK7isA209MMsLximC2QjKff41JIHt/Pa7TDwgm1N5QvPfNGXfz8HW2ElytvOThMaBk6oipGGD4Zn9cipUMMs22c4fjak4Ok/3IOu73j7JUxEwK90Cn3pxH+M9ZsSBhlsCEBxIv2z8txjHSDV5dyut7I6uyTdThh71GLqEcmNt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=I5+8kT4Q; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 2047051b797e604b; Tue, 2 Apr 2024 21:04:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 392E366C5C5;
	Tue,  2 Apr 2024 21:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712084679;
	bh=Sav0fBkqwvpYmvVJzF5OXLJQIoDayOcopD95uzdB+yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5+8kT4Q2BObBMgkLRHciZQkCa9ZqhyIsOzEVQpRbnNSWJGRiPOGulz2bpdxdb86i
	 1ixGXiQW+2BafeM46UnhOONLMyjLeBS6J2NTYrXp05K41Y3LZBPzsdajsVmDQpJtFF
	 xtO9qeAtQiD+WP1bCGQLO78BSb0cRQ/b6Jp8dW5QMru2uS0iHZT60Av/AxSJAfbmOO
	 6oQO+e/NOe/FqN0XT+8LHA9EGMJ2dTtejg3CqP75ZdEjFUOQJOk7TwVqpZc2sMMD55
	 tu/HX6XCRxbbQO1XXeruP/CLaYuVfNsk9nyOhC2B3+vicDP4qw8K+/hXrcci6YGRwo
	 oGVc0r0RCGPkg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 6/6] thermal: core: Relocate critical and hot trip handling
Date: Tue, 02 Apr 2024 21:04:28 +0200
Message-ID: <3556878.iIbC2pHGDl@kreacher>
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

Modify handle_thermal_trip() to call handle_critical_trips() only after
finding that the trip temperature has been crossed on the way up and
remove the redundant temperature check from the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -349,10 +349,6 @@ void thermal_zone_device_critical_reboot
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip)
 {
-	/* If we have not crossed the trip_temp, we do not care. */
-	if (trip->temperature <= 0 || tz->temperature < trip->temperature)
-		return;
-
 	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
 
 	if (trip->type == THERMAL_TRIP_CRITICAL)
@@ -404,12 +400,15 @@ static void handle_thermal_trip(struct t
 		list_add_tail(&td->notify_list_node, way_up_list);
 		td->notify_temp = trip->temperature;
 		td->threshold -= trip->hysteresis;
+
+		if (trip->type == THERMAL_TRIP_CRITICAL ||
+		    trip->type == THERMAL_TRIP_HOT) {
+			handle_critical_trips(tz, trip);
+			return;
+		}
 	}
 
-	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip);
-	else
-		handle_non_critical_trips(tz, trip);
+	handle_non_critical_trips(tz, trip);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)





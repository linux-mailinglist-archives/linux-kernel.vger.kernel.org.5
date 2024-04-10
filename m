Return-Path: <linux-kernel+bounces-139137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172389FF01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43DF1F271D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2601199EAC;
	Wed, 10 Apr 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Gy7gmy0E"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C97181339;
	Wed, 10 Apr 2024 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771104; cv=none; b=Xaer4+RZCLZCt4wlPQ+kJhFZgvyq7E4EqS4l4o4W6kmHLbatVX0PlO31PUDrizJF0zCQx/lxWJuN5t6A7mC66f89FrIAPPJNhpoXexrckwVlk+7sAB1IZ5rTc02O3k9lA42lPGuu/K0xceYv0kJJ799XzTZQcr50RQf2RNVaFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771104; c=relaxed/simple;
	bh=S3GudwWSPWDgCp0Uz2WARPZEeLaa6Uxnwns5ZDR22LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seKIvrge4V8B7OCGwOFJ/K9XgBeQPmn7QPBXAMxUbQs8j2ZnrSTt1tiP94RME8KPrLkfpibocXRsYHoinQELP/XgNSr/qTAxlOZm6ET5+zUDdpStQ21MJ7JEfmMS9oOKAuax/u7Dn5xUubzRRS+vo/yHiBr5DVtzbhXXX7aX8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Gy7gmy0E reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id ad53043102c6b081; Wed, 10 Apr 2024 19:44:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5982266C66F;
	Wed, 10 Apr 2024 19:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771099;
	bh=S3GudwWSPWDgCp0Uz2WARPZEeLaa6Uxnwns5ZDR22LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gy7gmy0EsJ4Mhd3c3IPn7pXYRr3r7D7JsIaEVxbzXvws4yT8hX4K4bxTaAgDmuxVN
	 KT5l8O95R8ZH04uRIPvPwR6979n4jzvolj5JqXBGAtlU/SmSuzUzYCJraQtqfV/eig
	 jHRK2l87eX5dsgpFLRESJjb5G2G28Oc+6TCG2B3xf8qMuHVYFdQaCYIVa6b5zaEPUe
	 tVJ+Z2pgTPNxfsHx7e16VsbvNixKribRCTJq/K1L+aZOu0sb5CfPdsL+Nl7yKgR0Vo
	 i6jpmhf7NnitOBmLbI5WoMfi2eh/HTsCQL2TeLtKHXpgwweNymDVUT67+/dJuboukP
	 Oiy+iYKO4yLYA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 03/16] thermal: gov_bang_bang: Clean up thermal_zone_trip_update()
Date: Wed, 10 Apr 2024 18:05:44 +0200
Message-ID: <22273122.EfDdHjke4D@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do the following cleanups in thermal_zone_trip_update():

 * Drop the useless "zero hysteresis" message.
 * Eliminate the trip_index local variable that is redundant.
 * Drop 2 comments that are not useful.
 * Downgrade a diagnostic message from pr_warn() to pr_debug().
 * Use consistent field formatting in diagnostic messages.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -17,29 +17,23 @@ static void thermal_zone_trip_update(str
 				     const struct thermal_trip *trip,
 				     bool crossed_up)
 {
-	int trip_index = thermal_zone_trip_id(tz, trip);
 	struct thermal_instance *instance;
 
-	if (!trip->hysteresis)
-		dev_info_once(&tz->device,
-			      "Zero hysteresis value for thermal zone %s\n", tz->type);
-
 	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
-				trip_index, trip->temperature, tz->temperature,
-				trip->hysteresis);
+		thermal_zone_trip_id(tz, trip), trip->temperature,
+		tz->temperature, trip->hysteresis);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
 
-		/* in case fan is in initial state, switch the fan off */
 		if (instance->target == THERMAL_NO_TARGET)
 			instance->target = 0;
 
-		/* in case fan is neither on nor off set the fan to active */
 		if (instance->target != 0 && instance->target != 1) {
-			pr_warn("Thermal instance %s controlled by bang-bang has unexpected state: %ld\n",
-					instance->name, instance->target);
+			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
+				 instance->target, instance->name);
+
 			instance->target = 1;
 		}
 
@@ -52,8 +46,7 @@ static void thermal_zone_trip_update(str
 		else if (instance->target == 1 && !crossed_up)
 			instance->target = 0;
 
-		dev_dbg(&instance->cdev->device, "target=%d\n",
-					(int)instance->target);
+		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 
 		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false; /* cdev needs update */





Return-Path: <linux-kernel+bounces-139119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065289FED9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27701C22B62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF71802BF;
	Wed, 10 Apr 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="oxbOfCp3"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9317F369;
	Wed, 10 Apr 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771098; cv=none; b=LMGNZRPL1HkWjyS3bzqLgompBt/WIJH6vIysgtIf2PvE5xZZVDdM8ULLev6jXWTdMbG+RMW1RKl/OLfzdg2nMIppkna8+k2f+3T/+xF7yfku1jPknkI7Nlmm/xWxyQDB12RFQcKx4cn0baMigKg49cvUyZqgvGpSB3S0y0H8vEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771098; c=relaxed/simple;
	bh=J3FVnwDh/KGiA6tpfeXzIKlz2LWvlujkzxc+I0KPgFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxhlSZ+zWzhZbeqR99972jFZTxzK7w520UfGZXCpZ4Yly6JPtNt8PnpXSVYaeuyKPkJ9NijexG5TWOR8j+j2DDcloHZTtrDFbCZV8+nWXMfFUb0etrdi0cpT32t3KSFeZfY1qykKB+M7V1p7VCUs9FuqW6yYdPCyjYTyfQxQHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=oxbOfCp3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 65631d58b4123eed; Wed, 10 Apr 2024 19:44:47 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 59FAD66C66F;
	Wed, 10 Apr 2024 19:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771087;
	bh=J3FVnwDh/KGiA6tpfeXzIKlz2LWvlujkzxc+I0KPgFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oxbOfCp34dSikTSvRh20E+pQNQ5B0RJPEGlIv4//yecq30J08PCq7hJIfAZeWIzwm
	 MbHIkinVq86zESqyD049uRYJ5CXO+Z953AhLmbEPVJWzaeRU6+yMoKwdvpMT6GZ0Tp
	 bnDfOlfer4EWovhKfzbQOvjwaY8E8mHSnF1n4Vj+70jlQgSq6DDVEYnIOnjKgyeK5S
	 uB/6xVcuPbxZdWoMWSkogMvL5gDsaGxFOW9IrwOG2qSKRCP50L5Wv/FLiR7gjx62v1
	 WB1qGUZXOVOj1HlD9vgxQK8LLL7QhVOF5IpI+UwJrle1CRCugEWcPc5dBkyWZIpDV9
	 PUip6MCY/oHTw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 16/16] thermal: core: Relocate critical and hot trip handling
Date: Wed, 10 Apr 2024 19:44:34 +0200
Message-ID: <9337957.rMLUfLXkoz@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] 

Modify handle_thermal_trip() to call handle_critical_trips() only after
finding that the trip temperature has been crossed on the way up and
remove the redundant temperature check from the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -350,10 +350,6 @@ void thermal_zone_device_critical_reboot
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip)
 {
-	/* If we have not crossed the trip_temp, we do not care. */
-	if (trip->temperature <= 0 || tz->temperature < trip->temperature)
-		return;
-
 	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
 
 	if (trip->type == THERMAL_TRIP_CRITICAL)
@@ -405,10 +401,11 @@ static void handle_thermal_trip(struct t
 		list_add_tail(&td->notify_list_node, way_up_list);
 		td->notify_temp = trip->temperature;
 		td->threshold -= trip->hysteresis;
-	}
 
-	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip);
+		if (trip->type == THERMAL_TRIP_CRITICAL ||
+		    trip->type == THERMAL_TRIP_HOT)
+			handle_critical_trips(tz, trip);
+	}
 }
 
 static void update_temperature(struct thermal_zone_device *tz)





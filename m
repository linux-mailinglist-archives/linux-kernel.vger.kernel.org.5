Return-Path: <linux-kernel+bounces-148523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E278A83F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4680728553C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64313140E26;
	Wed, 17 Apr 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FtBWrzas"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00913F420;
	Wed, 17 Apr 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359529; cv=none; b=CfpbCqt25eNDvyBmy987H2VgdbBwBo3dNMG/vJHZeIzKn/SpbVXqMKGR4Cl4QddQb5JPpjk8JmZQT4GtCZRBtYhnyjnxdUi7nsZfmiJfLMrTkmPVhbLX7g1UusrarhciNikFAzNxgQ1q/0qdpYckplPep+Ln6GdZXfEaxyc7OHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359529; c=relaxed/simple;
	bh=AiW/0Dtry5H3PJpVJs+HnEugJ5BjdEdzU+HcYJktYVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar7UmGurr3LEHLVeJlVdsG+RtIzHw1T60yJJHzU4j/8bcTZ3QveC2+wWnPxRCnzAD151vy+alEe4EO7Ip/FwIzOWuPx6yGlI2+VGguaRPilj4vmA26w2uRlmqmDJwChQy0P+b6zzmDeuL2VoOrkcSnNVIQfUIvs1u1/jIH9JO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FtBWrzas reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id e2b5c418384b6776; Wed, 17 Apr 2024 15:11:58 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 63B2A66D25E;
	Wed, 17 Apr 2024 15:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713359518;
	bh=AiW/0Dtry5H3PJpVJs+HnEugJ5BjdEdzU+HcYJktYVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FtBWrzas8MbmLhMm6q17mF//aXY8FGZvDSE+m8UEinpFZFraQ0du9DkeZ1XtMfuq/
	 lWeaFADwcVxYAhO6apI/DqIdPRCT118mRAVUEOCTAYkEqpaAbxcvETGncPKFPy7+ls
	 YBzIb9O5KSgXqL6na+hMf3qikOth4GRLbkbQVbxTwYssfSUtiskgkrUp1QvFG+syi8
	 1W7C7LeAO1LOI0WVDY5+hv3r2S7fiND1DHhkliewxZyARwPOaYcZqVvqDJADtM2XLx
	 NrB4HR45wdIfpNPSjGuyoUGkZJw1TvDZQ9r9eDmc6gA3aWf6b+Ea9X5ebYaZvRb9u3
	 R112Vm9Zhkf2w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 1/3] thermal/debugfs: Avoid excessive updates of trip point
 statistics
Date: Wed, 17 Apr 2024 15:09:46 +0200
Message-ID: <4890052.GXAFRqVoOG@kreacher>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since thermal_debug_update_temp() is called before invoking
thermal_debug_tz_trip_down() for the trips that were crossed by the
zone temperature on the way up, it updates the statistics for them
as though the current zone temperature was above the low temperature
of each of them.  However, if a given trip has just been crossed on the
way down, the zone temperature is in fact below its low temperature,
but this is handled by thermal_debug_tz_trip_down() running after the
update of the trip statistics.

The remedy is to call thermal_debug_update_temp() after
thermal_debug_tz_trip_down() has been invoked for all of the
trips in question, but then thermal_debug_tz_trip_up() needs to
be adjusted, so it does not update the statistics for the trips
that has just been crossed on the way up, as that will be taken
care of by thermal_debug_update_temp() down the road.

Modify the code accordingly.

Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    3 ++-
 drivers/thermal/thermal_debugfs.c |    7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -427,7 +427,6 @@ static void update_temperature(struct th
 	trace_thermal_temperature(tz);
 
 	thermal_genl_sampling_temp(tz->id, temp);
-	thermal_debug_update_temp(tz);
 }
 
 static void thermal_zone_device_check(struct work_struct *work)
@@ -505,6 +504,8 @@ void __thermal_zone_device_update(struct
 	if (governor->manage)
 		governor->manage(tz);
 
+	thermal_debug_update_temp(tz);
+
 	monitor_thermal_zone(tz);
 }
 
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -545,7 +545,6 @@ void thermal_debug_tz_trip_up(struct the
 	struct tz_episode *tze;
 	struct tz_debugfs *tz_dbg;
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
-	int temperature = tz->temperature;
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	ktime_t now = ktime_get();
 
@@ -614,12 +613,6 @@ void thermal_debug_tz_trip_up(struct the
 
 	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
 	tze->trip_stats[trip_id].timestamp = now;
-	tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
-	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
-	tze->trip_stats[trip_id].count++;
-	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
-		(temperature - tze->trip_stats[trip_id].avg) /
-		tze->trip_stats[trip_id].count;
 
 unlock:
 	mutex_unlock(&thermal_dbg->lock);





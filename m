Return-Path: <linux-kernel+bounces-148522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BFB8A83F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C8DB2547F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFBE140363;
	Wed, 17 Apr 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="j4NbVIIS"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390913F001;
	Wed, 17 Apr 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359528; cv=none; b=TOUPNu3DCPXKqvPE6FN3m2P8VxpnilHkISxuwXTVfw1cu2mdPnSt1VnCeAXEQG0bzuq/lbmrxtJWfxOXzlmgj9kSOwUJLPrsA2+CtC2cMWRsHl2jDpYK7jAuyGWHtGXHN+VAmNx7EdEIVTz2wCQXJrXwMohqk8asFpUoKaiWi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359528; c=relaxed/simple;
	bh=eRTZTYWsrsAzosaYotskxpU3+pLx7YbUhBaPfLOi0Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8nkSgWgjaWu3jHkkJJsRAf4fUk7G1L63G2554QRHkehAWBESp9Domf39WXnfNJU/cl64/P3KNdQyey+WOs+L7CoqN0yARWlG7j70cFfujl8vF60A50rtF/JLo0gUh8SYZnfPMZsVFQMeEC6DaThkAGCtPq6L+Rulf09cnyQrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=j4NbVIIS; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c15569bc44d7f6e3; Wed, 17 Apr 2024 15:11:57 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 62B7666D25E;
	Wed, 17 Apr 2024 15:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713359517;
	bh=eRTZTYWsrsAzosaYotskxpU3+pLx7YbUhBaPfLOi0Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4NbVIISqPn0LRbnNIgZv49exHaC2tge+YUWKnxq80C5AtmrcgR+lc9+NC2N+Hox4
	 BBLpHg7irayq3roNBH+b5DJL+S/SIK7wqTmKCo8w4X3rrp+SCTcexK8yjiFI+ujOzC
	 inxkCmmE9gexoANMQbStXzja+SO5LgX/zmRzDz7ORgHzacxnZg2BUQoxPpR4tDBuar
	 /g3g0V8EOk5zWWci+7V9UH8q/0zH+mn8ZjBr29wtv0U6mhKx1xCP3G9kj6OcCnkcBQ
	 AXnUPsHsKs+i3bgMwytS0QHI3kEixscO4diNTBpWNlpk8Y4fKa9CiJOwdXvXYvVXUb
	 e9wKhn3RdQzdQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 2/3] thermal/debugfs: Clean up thermal_debug_update_temp()
Date: Wed, 17 Apr 2024 15:10:34 +0200
Message-ID: <2185763.irdbgypaU6@kreacher>
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

Notice that it is not necessary to compute tze in every iteration of the
for () loop in thermal_debug_update_temp() because it is the same for all
trips, so compute it once before the loop starts.

Also use a trip_stats local variable to make the code in that loop easier
to follow and move the trip_id variable definition into that loop because
it is not used elsewhere in the function.

While at it, change to order of local variable definitions in the function
to follow the reverse-xmas-tree pattern.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -679,9 +679,9 @@ out:
 void thermal_debug_update_temp(struct thermal_zone_device *tz)
 {
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
-	struct tz_episode *tze;
 	struct tz_debugfs *tz_dbg;
-	int trip_id, i;
+	struct tz_episode *tze;
+	int i;
 
 	if (!thermal_dbg)
 		return;
@@ -693,15 +693,16 @@ void thermal_debug_update_temp(struct th
 	if (!tz_dbg->nr_trips)
 		goto out;
 
+	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
+
 	for (i = 0; i < tz_dbg->nr_trips; i++) {
-		trip_id = tz_dbg->trips_crossed[i];
-		tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
-		tze->trip_stats[trip_id].count++;
-		tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, tz->temperature);
-		tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, tz->temperature);
-		tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
-			(tz->temperature - tze->trip_stats[trip_id].avg) /
-			tze->trip_stats[trip_id].count;
+		int trip_id = tz_dbg->trips_crossed[i];
+		struct trip_stats *trip_stats = &tze->trip_stats[trip_id];
+
+		trip_stats->max = max(trip_stats->max, tz->temperature);
+		trip_stats->min = min(trip_stats->min, tz->temperature);
+		trip_stats->avg += (tz->temperature - trip_stats->avg) /
+					++trip_stats->count;
 	}
 out:
 	mutex_unlock(&thermal_dbg->lock);





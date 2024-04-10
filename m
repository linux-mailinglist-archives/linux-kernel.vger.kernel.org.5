Return-Path: <linux-kernel+bounces-139131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818089FEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B06285F00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5033184108;
	Wed, 10 Apr 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BICP+tk1"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDC017F39C;
	Wed, 10 Apr 2024 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771102; cv=none; b=b5KB+iA9t0hzUewgUh1QuSgtoSOJ61cLTzcSqonivDDZhi1MSpEYtrHLKrpy1NnqJmKtFvD33kni1hVMmX7euN8SP3hlRtCDn6UKacdtOiU/171sQGHtOpCk/+92h2yeh+tRC9KT69aP0g6340wOKsO6v6v40Vv/mtlNKcGICpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771102; c=relaxed/simple;
	bh=x/rTmZAzWqW+xMwWax6HbPC4NnWFSCmVjfuyEhUoQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzMeB1k97l7095JkChtg6+f0PHF4tD0EHy+OA5Sqe3o4L595JUzRzRcbLhpjN1YmnSCpZKykyIYwWpHU8nbXEj1q1fEqY5RQJx6cJwgIYvIoK09uvexIr4huGI5YJ7nlVWS+P7hPn1AGe221nb7IhSzWCUTVtL5o55qX0jKmcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BICP+tk1 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 8c375ef2b1d9d543; Wed, 10 Apr 2024 19:44:50 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2C7A566C66F;
	Wed, 10 Apr 2024 19:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771090;
	bh=x/rTmZAzWqW+xMwWax6HbPC4NnWFSCmVjfuyEhUoQpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BICP+tk1ODnlcoY2xZjSZvNG/vvHmv5Hvvb5kCuzE5Bdy1XdZoCzLNPix8FBpqTd/
	 bJS3mq9U3iyGf4wvBrKM2+ZoqH00liiJ221Mt8v6TBmuWaUqEwtyhIlfvvNszuHaVv
	 eZKsxyQi/12gDu3+yrG/5+umwDMij7xq9lfOleSpX3OQKq65YSIc1VFHm4cyJmI91D
	 HH2aH/ppt++BNAV8EizuM1NS5X20dOWbsFSsLmN60b3Ebl9dUcgMhkWrJaxxP8BErr
	 kjFHgkUqGOktKDdhjOhU5kWmwOBy4iM2pNoAGJctPdCRyGVzId8Y6BsI8JBpqgekdi
	 JkcYT1usIaC0w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 13/16] thermal: gov_fair_share: Eliminate unnecessary integer
 divisions
Date: Wed, 10 Apr 2024 19:00:10 +0200
Message-ID: <2170379.OBFZWjSADL@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The computations carried out by fair_share_throttle() for each trip
point include at least one redundant integer division which introduces
superfluous rounding errors.  Also the multiplications by 100 in it are
not really necessary and can be eliminated.

Rearrange fair_share_throttle() to carry out only one integer division per
trip and only as many integer multiplications as necessary and rename one
variable in it (while at it).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_fair_share.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -41,12 +41,6 @@ static int get_trip_level(struct thermal
 	return trip_level;
 }
 
-static long get_target_state(struct thermal_zone_device *tz,
-		struct thermal_cooling_device *cdev, int percentage, int level)
-{
-	return (long)(percentage * level * cdev->max_state) / (100 * tz->num_trips);
-}
-
 /**
  * fair_share_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
@@ -58,7 +52,7 @@ static long get_target_state(struct ther
  *
  * Parameters used for Throttling:
  * P1. max_state: Maximum throttle state exposed by the cooling device.
- * P2. percentage[i]/100:
+ * P2. weight[i]/total_weight:
  *	How 'effective' the 'i'th device is, in cooling the given zone.
  * P3. trip_level/max_no_of_trips:
  *	This describes the extent to which the devices should be throttled.
@@ -72,30 +66,34 @@ static void fair_share_throttle(struct t
 {
 	struct thermal_instance *instance;
 	int total_weight = 0;
-	int total_instance = 0;
+	int nr_instances = 0;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
 
 		total_weight += instance->weight;
-		total_instance++;
+		nr_instances++;
 	}
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		int percentage;
 		struct thermal_cooling_device *cdev = instance->cdev;
+		u64 dividend;
+		u32 divisor;
 
 		if (instance->trip != trip)
 			continue;
 
-		if (!total_weight)
-			percentage = 100 / total_instance;
-		else
-			percentage = (instance->weight * 100) / total_weight;
-
-		instance->target = get_target_state(tz, cdev, percentage,
-						    trip_level);
+		dividend = trip_level;
+		dividend *= cdev->max_state;
+		divisor = tz->num_trips;
+		if (total_weight) {
+			dividend *= instance->weight;
+			divisor *= total_weight;
+		} else {
+			divisor *= nr_instances;
+		}
+		instance->target = div_u64(dividend, divisor);
 
 		mutex_lock(&cdev->lock);
 		__thermal_cdev_update(cdev);





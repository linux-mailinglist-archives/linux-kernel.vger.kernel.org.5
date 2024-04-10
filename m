Return-Path: <linux-kernel+bounces-139134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D489FEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79A728593B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706719067B;
	Wed, 10 Apr 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JB1bdQVy"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D51180A89;
	Wed, 10 Apr 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771103; cv=none; b=UM6Is3ScioyErxZy5F2ytcuyLUN2XL1931i6PhMhNHg1ltJkp0puo2cRatofZMnMxzH/Ktqq7baIDdtnu2Co35KJkXr+7fpEY/GHj3mjxzAES16HFUvgLTdqu+GYxvmLLf/j0UriapEqheFd/oFY8dMY5laPkIz+oSCFK9Pkxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771103; c=relaxed/simple;
	bh=hkMWHvHYQS4MmSqAa11HxBZKh9J4WE9vRTr50DrZTx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+z3pqWogAfb3tvuOX/YcrPnFLpT3ZnKpqrzFPIHDOp5byS3PCn5G7Dx8odAtdJzE3m7yA1spajaqTSqfjjrA5V903yIepAYkY74Q6uS7O5tdgDJ9yUxAlzzH5Y9g+rp4PqwsScRC8guRXLB6w+NRhl6bS0RSOK9+fmATSv0h4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JB1bdQVy reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 0bff15c04255a154; Wed, 10 Apr 2024 19:44:53 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CE5D266C66F;
	Wed, 10 Apr 2024 19:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771093;
	bh=hkMWHvHYQS4MmSqAa11HxBZKh9J4WE9vRTr50DrZTx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JB1bdQVyscMohZm2b4QioU75sZupLKylO+Qlo0SXjEHip3qbw46CKJC+HCSwGqPCR
	 xZdnsrKiBXh2btNr3BlczB5m5+ORwDnUBq3ANXsvgPKZ/w/K8xZv7lLqbh5NKk3+L8
	 fUlc/bpbMbBIj3lVQdAnU3uRMAZNxc7wXjGclxFs+O10BBM2g1LvX5CK4FRoO+YWV1
	 fjSH0NXHpVYIK2rN1jpI2mz+yfeZ8eXNhLf9el0/iip8hf8Q0xA89SJJrFlE92kqmS
	 W5PokYwXC9gaLZgJSnSK6uGWANVUuNq7urs76hmSUzWBLjSIDWUjiF/Qe/9U8rzD8k
	 kw6pbu/pOcYjg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 10/16] thermal: gov_step_wise: Clean up thermal_zone_trip_update()
Date: Wed, 10 Apr 2024 18:44:14 +0200
Message-ID: <1883063.atdPhlSkOF@kreacher>
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

Do some assorted cleanups in thermal_zone_trip_update():

 * Compute the trend value upfront.
 * Move old_target definition to the block where it is used.
 * Adjust white space around diagnositc messages and locking.
 * Use suitable field formatting in a message to avoid an explicit
   cast to int.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -65,13 +65,10 @@ static void thermal_zone_trip_update(str
 				     const struct thermal_trip *trip,
 				     int trip_threshold)
 {
+	enum thermal_trend trend = get_tz_trend(tz, trip);
 	int trip_id = thermal_zone_trip_id(tz, trip);
-	enum thermal_trend trend;
 	struct thermal_instance *instance;
 	bool throttle = false;
-	int old_target;
-
-	trend = get_tz_trend(tz, trip);
 
 	if (tz->temperature >= trip_threshold) {
 		throttle = true;
@@ -82,13 +79,16 @@ static void thermal_zone_trip_update(str
 		trip_id, trip->type, trip_threshold, trend, throttle);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		int old_target;
+
 		if (instance->trip != trip)
 			continue;
 
 		old_target = instance->target;
 		instance->target = get_target_state(instance, trend, throttle);
-		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
-					old_target, (int)instance->target);
+
+		dev_dbg(&instance->cdev->device, "old_target=%d, target=%ld\n",
+			old_target, instance->target);
 
 		if (instance->initialized && old_target == instance->target)
 			continue;
@@ -104,6 +104,7 @@ static void thermal_zone_trip_update(str
 		}
 
 		instance->initialized = true;
+
 		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);





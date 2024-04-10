Return-Path: <linux-kernel+bounces-139130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB489FEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE841C20C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCB1836DC;
	Wed, 10 Apr 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RTi7gH0F"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0071802A6;
	Wed, 10 Apr 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771102; cv=none; b=n8mir+mOFZbHrrbkRmtvESucd0Zk7Ke8NB56sb4lYSeuIlpfJwwIVDEcqSkcQUStX8nsAqcFj1DkAPbLhdmVvd8KHxtnvEklWrrskOMb8Npp6Vg9hb30FUmHaJPaEu9d/OOC2Z5VssjJzBVV7P9OeMqJWjotyZVUuDF17v7XKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771102; c=relaxed/simple;
	bh=tWSbL77Uu0S5xnOIRWaaVpbSPmpL1rxRn22rKE+1/l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daWPaZ6KBQGWunPGlkQLPc0iSrIsD39AWe8mcHqUukWIYaqwrve7sFGgS0mKaZOhvLv8DqiL4660b572T4qSnetZ+89sN243/WbIDfSEXxJfwEYppySBJfBvvEVc2OuINe33zuppEgJXkhHmf9eGX8quJhTfDpt1kTnfms6U8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RTi7gH0F reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c0eaaeb4e1f813d6; Wed, 10 Apr 2024 19:44:57 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E7AE066C66F;
	Wed, 10 Apr 2024 19:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771097;
	bh=tWSbL77Uu0S5xnOIRWaaVpbSPmpL1rxRn22rKE+1/l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RTi7gH0F4xSRi/fFkU5LLFrH6B3DNjpvQIyraxTGxqWY8tqvgab4n3V8YESzzApZK
	 eZYeeEYixNeeOpyg66FszDzmpWvrg9cYoHeO/A5M0V3PsFmAp5ybkLJQRM0UxRsd+o
	 sR41GWYXTdZzPuJEUhjGU2ropgltJdPkf8INSPWIyT+e7R/iQeTfnpvJfyyRxe2H2y
	 aoHMsWwvmpvWOSQrlydvizRz8ofZ0Cx4GwBgqwg+YWqYlf7dp0OcCxRxwhajH+4mA8
	 N8yhsOMaNHCGCZECuNFCAxdgvMyI/ytwLwtLjIEPYg+3m9/+BFT8ZQnkfoKr0v8Th+
	 VNr3eEi0VCkdA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 06/16] thermal: gov_power_allocator: Use .manage() callback instead
 of .throttle()
Date: Wed, 10 Apr 2024 18:10:14 +0200
Message-ID: <1815410.VLH7GnMWUR@kreacher>
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

The Power Allocator governor really only wants to be called once per
thermal zone update and it does a special check to skip the extra,
from its perspective, invocations of the .throttle() callback.

Make it use .manage() instead of .throttle().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_power_allocator.c |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -395,7 +395,7 @@ static void divvy_up_power(struct power_
 	}
 }
 
-static int allocate_power(struct thermal_zone_device *tz, int control_temp)
+static void allocate_power(struct thermal_zone_device *tz, int control_temp)
 {
 	struct power_allocator_params *params = tz->governor_data;
 	unsigned int num_actors = params->num_actors;
@@ -410,7 +410,7 @@ static int allocate_power(struct thermal
 	int i = 0, ret;
 
 	if (!num_actors)
-		return -ENODEV;
+		return;
 
 	/* Clean all buffers for new power estimations */
 	memset(power, 0, params->buffer_size);
@@ -471,8 +471,6 @@ static int allocate_power(struct thermal
 				      num_actors, power_range,
 				      max_allocatable_power, tz->temperature,
 				      control_temp - tz->temperature);
-
-	return 0;
 }
 
 /**
@@ -745,40 +743,32 @@ static void power_allocator_unbind(struc
 	tz->governor_data = NULL;
 }
 
-static int power_allocator_throttle(struct thermal_zone_device *tz,
-				    const struct thermal_trip *trip)
+static void power_allocator_manage(struct thermal_zone_device *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip *trip = params->trip_switch_on;
 	bool update;
 
 	lockdep_assert_held(&tz->lock);
 
-	/*
-	 * We get called for every trip point but we only need to do
-	 * our calculations once
-	 */
-	if (trip != params->trip_max)
-		return 0;
-
-	trip = params->trip_switch_on;
 	if (trip && tz->temperature < trip->temperature) {
 		update = tz->passive;
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
-		return 0;
+		return;
 	}
 
 	tz->passive = 1;
 
-	return allocate_power(tz, params->trip_max->temperature);
+	allocate_power(tz, params->trip_max->temperature);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
 	.name		= "power_allocator",
 	.bind_to_tz	= power_allocator_bind,
 	.unbind_from_tz	= power_allocator_unbind,
-	.throttle	= power_allocator_throttle,
+	.manage		= power_allocator_manage,
 	.update_tz	= power_allocator_update_tz,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);





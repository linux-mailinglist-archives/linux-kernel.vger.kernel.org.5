Return-Path: <linux-kernel+bounces-139128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D33B89FEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECEA1C23102
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE08181D1D;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nxJcMALb"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BB17F373;
	Wed, 10 Apr 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771101; cv=none; b=p5Vhfxh6XmSspYfm2NXT90Jp2TSmuXU69o04Sq4suAC6aGSCUKTT8NGhQrDl4h4IKUtPhb8aSY/80Ok1rnqGRpN5s62RmK5ciw2mSsfrNHJ7jZpqdfz/z7eSzUHgTJOd21AAag6nizPSyovaC2j8vMp+MxaVqbzSymH+TNX2SnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771101; c=relaxed/simple;
	bh=KDEZGqVK+a+9HcbLaldc+1MzUP3IHmBDbVJNhkob+mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBb+c80+tJpkesX8VLzrAO7tv+/bqGP2gC+Bw6jrUFe0s8C5zydmogTPg/7oA0wVsUPd27lSkuP1pjy5ViqlE7aMpuhr0SIEG/IhXq6REVEH7DWTt46aNn3pLeAmt1EVse+TUpEsHW0DnjlWHC0L0ddx0JAk3VZSdsu7W3Vm/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nxJcMALb reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 4e1645a71e206586; Wed, 10 Apr 2024 19:44:49 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2246966C66F;
	Wed, 10 Apr 2024 19:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771089;
	bh=KDEZGqVK+a+9HcbLaldc+1MzUP3IHmBDbVJNhkob+mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxJcMALbf6WROrRz3bAx1vRfMFb75Kc4zMov3Kx+YT7G6kw9X4SKEdnjJb6bNZruf
	 5p3GKHXSsnPUayC8JF5YmAY3bIY3YEEktndEJMYLOyFa9pNXiPZby7UaKAFfR/l5Cn
	 eSKFtOV6o4N0jN7oniTkl3+CjBtc2ADAEksyan1NLCI6Fux+F1Ui52DEaB3iOwOqlE
	 le6mca+QIUBwRxNtg1D/5ZzsDvZ+A5mmCKpWMonLM2LYdWNx8fhfzfxc27N8CnDrNf
	 B8fO8ZSzecmLWzCHn+ZmynZg3WFUtLlyJtJHr3EoYNPS0nEgOIcHot7QyyxYCCZNYb
	 o5qEDxs9yhrxg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 14/16] thermal: gov_user_space: Use .trip_crossed() instead of
 .throttle()
Date: Wed, 10 Apr 2024 19:03:10 +0200
Message-ID: <15186663.tv2OnDr8pf@kreacher>
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

Notifying user space about trip points that have not been crossed is
not particuarly useful, so modity the User Space governor to use the
trip_crossed() callback, which is only invoked for trips that have been
crossed, instead of .throttle() that is invoked for all trips in a
thermal zone every time the zone is updated.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: I am not actually sure if there is user space depending on the
current behavior that can be broken by this change.

I can easily imagine trying to implement a complicated governor in user
space that will look at all of the trips in the thermal zone regardless
of whether or not they are crossed, which can be kind of helped by the
current behavior of the user space governor.

However, the total overhead caused by it is considerable and quite
arguably it may not be acceptable at least in some cases.

---
 drivers/thermal/gov_user_space.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/thermal/gov_user_space.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_user_space.c
+++ linux-pm/drivers/thermal/gov_user_space.c
@@ -26,11 +26,13 @@ static int user_space_bind(struct therma
  * notify_user_space - Notifies user space about thermal events
  * @tz: thermal_zone_device
  * @trip: trip point
+ * @crossed_up: whether or not the trip has been crossed on the way up
  *
  * This function notifies the user space through UEvents.
  */
-static int notify_user_space(struct thermal_zone_device *tz,
-			     const struct thermal_trip *trip)
+static void notify_user_space(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip,
+			      bool crossed_up)
 {
 	char *thermal_prop[5];
 	int i;
@@ -46,13 +48,11 @@ static int notify_user_space(struct ther
 	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
 	for (i = 0; i < 4; ++i)
 		kfree(thermal_prop[i]);
-
-	return 0;
 }
 
 static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
-	.throttle	= notify_user_space,
+	.trip_crossed	= notify_user_space,
 	.bind_to_tz	= user_space_bind,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);





Return-Path: <linux-kernel+bounces-139132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3389FEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36FC1F24697
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9F18410C;
	Wed, 10 Apr 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vTXNDlrQ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4D180A70;
	Wed, 10 Apr 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771102; cv=none; b=oa5ZjTH7gFpovmjxb8LKjY5Vy9ryBfMCawef3rn6kp1MLQpz/I1fA6F4JPVqKPN+Qf2Jr9qUzA9/XYyo8Ni69lVqf6QzxC5zS3r70ZuFgpEZPZDieWfmgoZDXWq69pAq/wG1sc/4hlePIEY3vw2S9GTtHpMz8ifIf/Es0/ly8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771102; c=relaxed/simple;
	bh=B5J+m5y9UQ7/XO42/yL80vp+siK13YMOr1jwCBLtv20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjldZiuiPQyCX47x4tgUbQP/o8T73dRkw9IACd37vqUIlErLg+lCaIXyctK0z0oQC0Pa/BezMFapCuW3EFKUyn0WFk9Jl3dVTLfvcyuP5dtlOkDf7Eu91YqP0/Lm/2IZJJPSjIPLM+jUHMgEqYO4q/3ogWlqngCzVBx+jFAZU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vTXNDlrQ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 8e9c8fcf2b46ca6d; Wed, 10 Apr 2024 19:44:58 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B120C66C66F;
	Wed, 10 Apr 2024 19:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771098;
	bh=B5J+m5y9UQ7/XO42/yL80vp+siK13YMOr1jwCBLtv20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vTXNDlrQrLZLZ+DIPbKXtKFERmXMFd/BKaq5iY/ptj3X5BHn0QHbPpvRYPdZ042Or
	 R8kwjnhzNUQODnlTH1/7uXBZG3QiUOrKQMOSSdnjKT8u7ieiCKnYmEzIDBS+ru/v7I
	 C84N3nrZAXrrwHEQ8pLQyo3Ggidt0UTNb8MjQZPGO+EnmhRl2Z+xEQCBcnjsVpiOVG
	 c48sE/eb0GbsbhYaW4gmnEbPwxUxe6lYXAAzILyMS5baK7h/EbJbyAO1mc7QUhLYLY
	 QX5Cjlq6rPlRCx9IeCHSXT9z0FnKhXtnatGu2K1nIZrqM3x1ce7cMNl2rpxhNbBy1s
	 5MzUjy64bhK+w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 05/16] thermal: core: Introduce .manage() callback for thermal
 governors
Date: Wed, 10 Apr 2024 18:08:12 +0200
Message-ID: <3242862.5fSG56mABF@kreacher>
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

Introduce a new thermal governor callback called .manage() that will be
invoked once per thermal zone update after processing all of the trip
points in the core.

This will allow governors that look at multiple trip points together
to check all of them in a consistent configuration, so they don't need
to play tricks with skipping .throttle() invocations that they are not
interested in and they can avoid carrying out the same computations for
multiple times in one cycle.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    3 +++
 drivers/thermal/thermal_core.h |    2 ++
 2 files changed, 5 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -516,6 +516,9 @@ void __thermal_zone_device_update(struct
 			governor->trip_crossed(tz, &td->trip, false);
 	}
 
+	if (governor->manage)
+		governor->manage(tz);
+
 	monitor_thermal_zone(tz);
 }
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -31,6 +31,7 @@ struct thermal_trip_desc {
  * @unbind_from_tz:	callback called when a governor is unbound from a
  *			thermal zone.
  * @trip_crossed:	called for trip points that have just been crossed
+ * @manage:	called on thermal zone temperature updates
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
  * @update_tz:	callback called when thermal zone internals have changed, e.g.
@@ -44,6 +45,7 @@ struct thermal_governor {
 	void (*trip_crossed)(struct thermal_zone_device *tz,
 			     const struct thermal_trip *trip,
 			     bool crossed_up);
+	void (*manage)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz,
 			const struct thermal_trip *trip);
 	void (*update_tz)(struct thermal_zone_device *tz,





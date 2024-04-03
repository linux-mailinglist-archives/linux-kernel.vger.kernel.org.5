Return-Path: <linux-kernel+bounces-130427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0EC8977E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB06281E17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484615382F;
	Wed,  3 Apr 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cArjfyC4"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AB1534E6;
	Wed,  3 Apr 2024 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167933; cv=none; b=KQ+6qTjVgkiZcCZN2Cdm0zfuGCIhGHWZ70rRN6gvULefsKD0K2//b+ueDMWhP6mpwnOU6G4HWSH4DUxIhMArb+k06p8l+QzVCnW6q36VCUkiHfF5C8dAKmpT9zaij7Wz/GdbeoN8LmB+yfy2Hu4m/t2bfsBARyOvA9XwlZY4RxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167933; c=relaxed/simple;
	bh=qGMeKA42r0NipAvaOzYcoKIIUuiGOzHMBG4lHVRRTO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY6RxDVVoqaUt/XXQ/MYYQRYF8BmFhNdWTL5bGytin9deuKIaG65GW4/ZX8q6tFaRFb/7MeXtZXmWU2aQnnk6PlwPlFCFCYRXGTVj7qOyF3zyEplxWqFOKGMoQn8aMcmwA1luChX8RrMOY5+TDX/tpPLMpValscvZDgWBhsoTg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cArjfyC4; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 170218018de553b5; Wed, 3 Apr 2024 20:12:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1116E662F36;
	Wed,  3 Apr 2024 20:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712167928;
	bh=qGMeKA42r0NipAvaOzYcoKIIUuiGOzHMBG4lHVRRTO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cArjfyC4p1Hp7lYMOPDDhzdiJ9aRbpvRjafjZzB5FL40/2m6Uj0vYS4TAam6cd8Ls
	 Af2+o60s6d6xd8qUDjeTAX+cmE84OtyC9fOAj5ko3c7O7leBo1aQnpjEgpl3YuFv56
	 5vsPyuK+Tl3a3lFfVcYGmgjBEs6V+ecEeqiS35hym+uaq8m7Wb7ao0KwtuXL25mIsY
	 pxII73qxJjTWPihE32WeF5xtAdgU7qhWO8+aqbudh3dK1HJRpz6oPsK3z0Qf8ehy+h
	 cSWxXsuw2yp51G1Y2Ph/MH/F7D64dUn1J8PRrom45y0IhGXJT7BV69uQvKOcuW5mVB
	 QNXDOJVAltLbQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/2] thermal: gov_step_wise: Simplify get_target_state()
Date: Wed, 03 Apr 2024 20:11:10 +0200
Message-ID: <4907519.31r3eYUQgx@kreacher>
In-Reply-To: <5766468.DvuYhMxLoT@kreacher>
References: <5766468.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The step-wise governor's get_target_state() function contains redundant
braces, redundant parens and a redundant next_target local variable, so
get rid of all that stuff.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -32,7 +32,6 @@ static unsigned long get_target_state(st
 {
 	struct thermal_cooling_device *cdev = instance->cdev;
 	unsigned long cur_state;
-	unsigned long next_target;
 
 	/*
 	 * We keep this instance the way it is by default.
@@ -40,32 +39,26 @@ static unsigned long get_target_state(st
 	 * cdev in use to determine the next_target.
 	 */
 	cdev->ops->get_cur_state(cdev, &cur_state);
-	next_target = instance->target;
 	dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
 
 	if (!instance->initialized) {
-		if (throttle) {
-			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
-		} else {
-			next_target = THERMAL_NO_TARGET;
-		}
+		if (throttle)
+			return clamp(cur_state + 1, instance->lower, instance->upper);
 
-		return next_target;
+		return THERMAL_NO_TARGET;
 	}
 
 	if (throttle) {
 		if (trend == THERMAL_TREND_RAISING)
-			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
-	} else {
-		if (trend == THERMAL_TREND_DROPPING) {
-			if (cur_state <= instance->lower)
-				next_target = THERMAL_NO_TARGET;
-			else
-				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
-		}
+			return clamp(cur_state + 1, instance->lower, instance->upper);
+	} else if (trend == THERMAL_TREND_DROPPING) {
+		if (cur_state <= instance->lower)
+			return THERMAL_NO_TARGET;
+
+		return clamp(cur_state - 1, instance->lower, instance->upper);
 	}
 
-	return next_target;
+	return instance->target;
 }
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz,





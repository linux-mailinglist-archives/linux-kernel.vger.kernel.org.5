Return-Path: <linux-kernel+bounces-139125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7AF89FEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E091F24063
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B70181D17;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UG3RqXFW"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC417F375;
	Wed, 10 Apr 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771099; cv=none; b=QJN2Vmxwj4JsJMNnO8zT2LrjqqpwIT8STtNtSOLpGQ/BzHv+rJ9DGwp/dZkVFb/2k9MMcCxNEJkdL0zZB++uITCTHP1WrmeKKmuz2a1IfJ3np9RWNtBPNi3vvRvAlhhCIeo66dtrlEMOdhj6O8kSNhJO4gDWuewmhBH55PNpezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771099; c=relaxed/simple;
	bh=jZ42qBAOVfXfjDC/gxg6TKm2g0q8hkME0qL1SccI63w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYMqPjvUfOpk3eEEKGCZuTjzYerF+ydnt61Xqzvimb3GVT1UrNrLsQIA63ZW/ag3FyePWp7/mWBsQmBHdbmg7c/tJgCFe2K1NQSJrt/5iwX7+TO1lNccuK4wwCoRnUdWymDqmP+xVDDU1CE65ilmAWPUAtg42jQWRnCpWx9Vbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UG3RqXFW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 2915b8068ed30433; Wed, 10 Apr 2024 19:44:55 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 37C9C66C66F;
	Wed, 10 Apr 2024 19:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771095;
	bh=jZ42qBAOVfXfjDC/gxg6TKm2g0q8hkME0qL1SccI63w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UG3RqXFWFOLKMOX4IoF4HNLP+dfdQ3sRfdSrc3uSmyDXCP+4JLt5RUtS8vDFcgWBG
	 Oz0Y0+qCWK3W+jMJHeChNUL8uiMwvr/lxzbVFmf5jowd2EQhXHFc+bVILc/Szv7PDa
	 w0c8tjyL4TyRR7kOs3oEAx8XD2HwwyzNuWq+/lTIBi2V2R5zrFpQuykzs1o3Wal2+T
	 npZ6Iubb828hRYBbalL8unut4mSK3ZDPtUp99mWqNTG4O3IQzsPVA0nawSvpZUD0Zo
	 Pgiy5vJSs7Tnp0RP3xtdo73VgfRziAuw7qFdYPcAeq/icdyiOaMc/HhaWGjBXnt+RQ
	 MWGiSU74t7PRQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a redundant variable
Date: Wed, 10 Apr 2024 18:12:45 +0200
Message-ID: <1913649.CQOukoFCf9@kreacher>
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

Notice that the passive field in struct thermal_zone_device is not
used by the Power Allocator governor itself and so the ordering of
its updates with respect to allow_maximum_power() or allocate_power()
does not matter.

Accordingly, make power_allocator_manage() update that field right
before returning, which allows the current value of it to be passed
directly to allow_maximum_power() without using the additional update
variable that can be dropped.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_power_allocator.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -747,21 +747,18 @@ static void power_allocator_manage(struc
 {
 	struct power_allocator_params *params = tz->governor_data;
 	const struct thermal_trip *trip = params->trip_switch_on;
-	bool update;
 
 	lockdep_assert_held(&tz->lock);
 
 	if (trip && tz->temperature < trip->temperature) {
-		update = tz->passive;
-		tz->passive = 0;
 		reset_pid_controller(params);
-		allow_maximum_power(tz, update);
+		allow_maximum_power(tz, tz->passive);
+		tz->passive = 0;
 		return;
 	}
 
-	tz->passive = 1;
-
 	allocate_power(tz, params->trip_max->temperature);
+	tz->passive = 1;
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {





Return-Path: <linux-kernel+bounces-92285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96422871DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529D5286010
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9515B69A;
	Tue,  5 Mar 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sPUzEEsY"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A585A4CA;
	Tue,  5 Mar 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638334; cv=none; b=EZaNl6wrd/EzLtBK6LrUrHv+PtZrln728VRk4vZu7hTe9vP5dl4XyJH89EEHkSpnsu+mgTGoJjHILKD8NzCQCqAagh+1NMzCVFUGiI34WOlQBePmbN7FOsMIYMy3fiLmuWwQ2I/WZF/SyYKmcqU2tgtbi8Vupmefh9hWbpzXrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638334; c=relaxed/simple;
	bh=8bl4HrCXQqQhmGUX17Z5ko4AOGeK9Ujk1PJ+PZmCZhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AiMLaK4hypASa+QwCqGT3/UW7RleRPT9Kec4vcU3X0UTQrnzyhvux4NoV+tPFCLwLqwqTQHeuN/qrKo7fj22PTyatvXSGhXAGTXD0mSDIhNIac9Sw9YTlmog6AgL1+iDcswh37Mbp5QHdQ8YSzsMlSxYfkvTLSZVQCOu5gKZdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sPUzEEsY reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 759bb0c3c76c11ab; Tue, 5 Mar 2024 12:32:09 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5633266AA28;
	Tue,  5 Mar 2024 12:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1709638329;
	bh=8bl4HrCXQqQhmGUX17Z5ko4AOGeK9Ujk1PJ+PZmCZhc=;
	h=From:To:Cc:Subject:Date;
	b=sPUzEEsY0iWNzokEocriV84S79KM71+LSCm8wZsHRxw+BG7f0pcKvlt0NLEwKaQg9
	 Vlb0n4coN0F/tBxHF8BC/Z+0fVB9zMCiP0H86xympHYc10Vl8zWO56kkSJGH7IOPck
	 MPNm+X+OS4rw+eReWTx9VCwQiSP5gxU4k28FqbDl4+CG0QVQpA8AAlWE/e9tldmQAH
	 58z8kuOv7Bj0cUbVn/J7YQN3SrjLyBw4a7jN60tejWR96KJadMpksN2bRX4/gj1FrK
	 +6n1rWpLLKGtIsbeNzjeDcrVe+tuEhBfBMnWTmzWnkduwKpYdf6ESzKTTH1H6NITBP
	 wgn+vRQTEcZ+w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject:
 [PATCH v1] thermal: intel: int340x_thermal: Use thermal zone accessor
 functions
Date: Tue, 05 Mar 2024 12:32:09 +0100
Message-ID: <2724753.mvXUDI8C0e@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhho
 sehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make int340x_thermal use the dedicated accessor functions for the
thermal zone device object address and the thermal zone type string.

This is requisite for future thermal core improvements.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -58,7 +58,8 @@ static int int340x_thermal_set_trip_temp
 
 static void int340x_thermal_critical(struct thermal_zone_device *zone)
 {
-	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
+	dev_dbg(thermal_zone_device(zone), "%s: critical temperature reached\n",
+		thermal_zone_device_type(zone));
 }
 
 static inline void *int_to_trip_priv(int i)





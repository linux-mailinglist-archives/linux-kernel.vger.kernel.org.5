Return-Path: <linux-kernel+bounces-164323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F768B7C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ECBB260AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1617BB01;
	Tue, 30 Apr 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YOrPW0Ji"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860F175551;
	Tue, 30 Apr 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492394; cv=none; b=JzXV8Gbdb51uvQ8pMk0/Yx/v9ZxmlVbkFnJoSIxLwducwtAS+G2rQSnqhqBSy7SWZNeqlNp9hNjBpSFN4LdtZ/uKZC3YMxy6T6fz0JKj5Ke74QvFnxZTSztJ+hs4Zb8qaBHXlzJcntKTiLPs7RYkZsMc60AvLUXycqNfeqt9Xsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492394; c=relaxed/simple;
	bh=5l2heTlDRdh8TNuc+FkR1nWVng8KhgGpiI1+RYy0rFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOBoFiKEschEWqCphxzIb2/9bnF4PkpOaxamGnMNs/pUXPk4SwMre9E5rFI9iVnrFlUgEA9AnBSyYODT0TmN3ckHi/EtvM17awP6LMEq/c/E1j5YNC4bQN/q8kc3r0rp4cgHm2Bn9Zgpb+gWplGAGEyIhA+dBiw8IHNR2dEYpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YOrPW0Ji reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 81ba361248e88355; Tue, 30 Apr 2024 17:53:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 795F566E643;
	Tue, 30 Apr 2024 17:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714492383;
	bh=5l2heTlDRdh8TNuc+FkR1nWVng8KhgGpiI1+RYy0rFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YOrPW0JieFZdQhvZEClSjpagZsfdXO87Xq/8vZJ40qdyv+urA3lQC6Z2asE4DvOty
	 WoIKlVT0x325wYNZAMT83kw+Wh7DWFruBt8NdqPIx9gimm2M6KQCMY41pkNUqy8UAQ
	 6/V12lsG/WIJBlvybai0mfK1xuV9A7rzT7XycricBiE1tLvbBJCeORrJ0be5p7HW1a
	 chiI5S1b267iZLAr6KxevVHZlO2tw6q0bpqrQfu+a2hWIvVdfn9TJji/jDtTGo9kJV
	 doEngK9yhoXgLg1sMs5J1fl0ykJMSGrnvhMl7+Mx63elmDlUfjykiA6bgA0vhF5Lj9
	 w+zZVTqkgqGcA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [PATCH v2 1/2] thermal: core: Do not call handle_thermal_trip() if zone
 temperature is invalid
Date: Tue, 30 Apr 2024 17:45:55 +0200
Message-ID: <4902888.GXAFRqVoOG@kreacher>
In-Reply-To: <5790995.DvuYhMxLoT@kreacher>
References: <5790995.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
 rggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make __thermal_zone_device_update() bail out if update_temperature()
fails to update the zone temperature because __thermal_zone_get_temp()
has returned an error and the current zone temperature is
THERMAL_TEMP_INVALID (user space receiving netlink thermal messages,
thermal debug code and thermal governors may get confused otherwise).

Fixes: 9ad18043fb35 ("thermal: core: Send trip crossing notifications at init time if needed")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 drivers/thermal/thermal_core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -487,6 +487,9 @@ void __thermal_zone_device_update(struct
 
 	update_temperature(tz);
 
+	if (tz->temperature == THERMAL_TEMP_INVALID)
+		return;
+
 	__thermal_zone_set_trips(tz);
 
 	tz->notify_event = event;





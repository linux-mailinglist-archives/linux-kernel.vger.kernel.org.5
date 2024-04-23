Return-Path: <linux-kernel+bounces-155778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBEA8AF700
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193AF2894E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B41422C1;
	Tue, 23 Apr 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dyL7/vX6"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11008140368;
	Tue, 23 Apr 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899003; cv=none; b=QHkP/VgE83Sx85LUa9aZbQDJ76sZQ5IdepJgMp8I/m4mhCsGnFVbZUpzVeFnZtQJrX9432UvBId6RgRSc6ElUV2l6+W5Bn0PSVW8uU73zYzk1aGigjbfmCZm20sSp+yedSzQq9i0Fjgbrs2COXGqMYJBC+m18pWpTnGZCiDTINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899003; c=relaxed/simple;
	bh=BCnLUuHW13RAzYcj99Bg9BBRzCEWgCC4VRRm5BqFDsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WL+0x596XpN88qJQJNnY/9snNP86CgMJVLiCK2Vmbzb65HKCC8XW8RLjdATeuhdZR+9m4jbYDsKaQdD6Tdg0pUBkmt2bkwQDKbQ97aDLNI71uFCQ6K7kmp+/8zo3rVJ5uIqKd9I47HaTRDfgMF1nmQsIz2ZWZy+7RX3KZTJQy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dyL7/vX6 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id e648cc0ef7cc95b2; Tue, 23 Apr 2024 20:03:19 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D4ABB66DB86;
	Tue, 23 Apr 2024 20:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713895399;
	bh=BCnLUuHW13RAzYcj99Bg9BBRzCEWgCC4VRRm5BqFDsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dyL7/vX6+N17bdJwiEJ40z8PUKUFAdeolxetOluIbAwssaqT6/OksUlRlRF8F789D
	 HNQGwrGIWo/IgUcFM4MOoDFkIc5umSTrEOaUvVyr41jcC2hsdbiylQ+iUOsTgkz/SE
	 LwyDdoigbiG6yd1EK6UUkapvDMIcsN6Ne2U3YRQ2p/36YNxIhXj8T8QbDVftvO59AJ
	 jGMmOxYn3CeKOdFpw52jJvwAyrr3kmZH7+yONIPr9AGX6ogR00D06xqQ+N+blcCJTN
	 cB1Zzzgy7abGo+WazpB5cnQs9v7Sm86bfHwrNjYoUjzgHg7W0kyUpjx/EF3zoY8x8K
	 oPKJ7tRLIBY+Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 1/3] thermal/debugfs: Create records for cdev states as they get
 used
Date: Tue, 23 Apr 2024 19:59:46 +0200
Message-ID: <4886487.GXAFRqVoOG@kreacher>
In-Reply-To: <5774279.DvuYhMxLoT@kreacher>
References: <5774279.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because thermal_debug_cdev_state_update() only creates a duration record
for the old state of a cooling device, if its new state is used for the
first time, there will be no record for it and cdev_dt_seq_show() will
not print the duration information for it even though it contains code
to compute the duration value in that case.

Address this by making thermal_debug_cdev_state_update() create a
duration record for the new state if there is none.

Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -433,6 +433,14 @@ void thermal_debug_cdev_state_update(con
 	}
 
 	cdev_dbg->current_state = new_state;
+
+	/*
+	 * Create a record for the new state if it is not there, so its
+	 * duration will be printed by cdev_dt_seq_show() as expected if it
+	 * runs before the next state transition.
+	 */
+	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, new_state);
+
 	transition = (old_state << 16) | new_state;
 
 	/*





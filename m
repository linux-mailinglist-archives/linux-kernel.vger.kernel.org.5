Return-Path: <linux-kernel+bounces-158659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5728B2387
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AE428B3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2306149E14;
	Thu, 25 Apr 2024 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ZQL4CTRQ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744402AEEA;
	Thu, 25 Apr 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054063; cv=none; b=X8alLITSLM99MnkwM2T/zDojAmWeUe1iSRa7C7hE6NfkW/xaBJaIDTQWOxoPcMnY1LkKtiD1t3yG2lD6otLRmyNujdomNxTu7j/uWfrMEEo3zM9vLbCGbdVJgqqors/+Uw5xSuKmWxjIg89kyuGZTxHSMc33unRy2K/8Dfn0BwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054063; c=relaxed/simple;
	bh=qUJWY3uQuu4A6OgOooiFLifpXiV1Fs2pSsfapJbxAM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5QnCviO3QfHgIAI2K4UKpl8anHXvLcWkYZ4tCe3oC9vm4e+6Zy5hn+xnU9pu+mjWQWJiJ4PgbOBxfgjC7gJ9xf3uT3jd9/oUUi/5DwJ6D9rGZeaYCWAB0gl0PBCplnwBS/lz+7QW0F0fc8ts6acLCzzzOe2GfPHmit1voRdjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ZQL4CTRQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 9757c531a07d5360; Thu, 25 Apr 2024 16:07:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 26B8166DF23;
	Thu, 25 Apr 2024 16:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714054059;
	bh=qUJWY3uQuu4A6OgOooiFLifpXiV1Fs2pSsfapJbxAM4=;
	h=From:To:Cc:Subject:Date;
	b=ZQL4CTRQ2vTjlf8tWKP1ZonUynq6oSV4oX8nPO1xVuplKOqfEuzz632lDTd87uaxw
	 2Ff2nESmhQhWtd5MPfeIr+Y4l4D1MGnF2NrN1MvjpjASLeLXv+qtBaWZDMov9wsMR/
	 elUpgQLaeIVP7yvwEJ5V1mCevyMD+j1bbsylxOmepdG91dllPIJAxLwucO6gD7mNT1
	 IPLIRI44phy/FbusfpDkkUv8qUnVlEAwFa2T/WLpsxjMP9MqjUH6VkABI2VLrwHMfI
	 PCetoZU2/bx6hjGt4PJajhAfjKlPyiAoe4pLa0NiUI+hxod9IWKlInS6gNZq3FfGBt
	 YPTAeDm02X8TQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1] thermal: trip: Add missing empty code line
Date: Thu, 25 Apr 2024 16:07:38 +0200
Message-ID: <3563200.iIbC2pHGDl@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidr
 lhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add missing empty line of code to thermal_zone_trip_id().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_trip.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -138,6 +138,7 @@ int thermal_zone_trip_id(const struct th
 	 */
 	return trip_to_trip_desc(trip) - tz->trips;
 }
+
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip)
 {





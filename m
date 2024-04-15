Return-Path: <linux-kernel+bounces-145744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97238A5A50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604181F22DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C7155A57;
	Mon, 15 Apr 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Nxf8k2NC"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0B13B78F;
	Mon, 15 Apr 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207803; cv=none; b=vAPIaEP78AEZR/fA93CuGyGXLExjvBo5IkVJ4Jc3XTx1QQOxnWu/+VCZDWkxe2vXktNUVM5/olxXozIROZ9I43acYn/ZVFQxeIexla5AwckucXLBwg2A5G2TVuJKWW5q4IUSncuau4uRiJGG6JKkL8aEAsJyM+TFQMWRnvUd2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207803; c=relaxed/simple;
	bh=R5j1i6fx4eY28IZJTdMlNFW1/w7oGnarF5KekQdrVhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E60K7Gxxl0m4/s0YvSpZrp4/gny6lxx5aOMd7m3MNVOoUaXQwFNhA+SpeNVrBmpGKrDFukDNnxx90vx7EuCqYSohuaTtH3eBZ593WtkgQ/5+P+GaJ3ii6duSFs9OzRU36uSKlB6KhNC7QbnkWkkzmPgQ0xLO5CNq04QEMyVNyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Nxf8k2NC reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id a459e9c29f1a53e7; Mon, 15 Apr 2024 21:03:12 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5C83D66CF48;
	Mon, 15 Apr 2024 21:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713207792;
	bh=R5j1i6fx4eY28IZJTdMlNFW1/w7oGnarF5KekQdrVhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nxf8k2NCcan69GF2dTpbwl/A9AWr7/Xk04tst6/6igviEAa8f+7qd9+CczqrGq6+8
	 ZRCD+5ZDwPulOVqfZEaam5nsYO7msSc6CkSJYnEnumXlkqn7OAAJHqNODIpcg6/K8n
	 6pdV450uZ3TqGl2lxrPDJwdTTlv9SEJfthY+prSNH8gmi7dlADiNtI+WPYxZCa62qH
	 0QO33YQRNVwR3196zDpRLfnvtcZh8uCX59jiaMWa1PQE8qJ86Au+CqxM3T7u7voGOH
	 4nbAuMmeNPUNMYDPDDUZXqRO+hhlrHpHWGSggQfeTswTYtkkXMhMui8dFnb+Mfz+/p
	 nUAqiI6pjdXvA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 1/2] thermal/debugfs: Add missing count increment to
 thermal_debug_tz_trip_up()
Date: Mon, 15 Apr 2024 21:02:12 +0200
Message-ID: <4912620.31r3eYUQgx@kreacher>
In-Reply-To: <12418263.O9o76ZdvQC@kreacher>
References: <12418263.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The count field in struct trip_stats, representing the number of times
the zone temperature was above the trip point, needs to be incremented
in thermal_debug_tz_trip_up(), for two reasons.

First, if a trip point is crossed on the way up for the first time,
thermal_debug_update_temp() called from update_temperature() does
not see it because it has not been added to trips_crossed[] array
in the thermal zone's struct tz_debugfs object yet.  Therefore, when
thermal_debug_tz_trip_up() is called after that, the trip point's
count value is 0, and the attempt to divide by it during the average
temperature computation leads to a divide error which causes the kernel
to crash.  Setting the count to 1 before the division by incrementing it
fixes this problem.

Second, if a trip point is crossed on the way up, but it has been
crossed on the way up already before, its count value needs to be
incremented to make a record of the fact that the zone temperature is
above the trip now.  Without doing that, if the mitigations applied
after crossing the trip cause the zone temperature to drop below its
threshold, the count will not be updated for this episode at all and
the average temperature in the trip statistics record will be somewhat
smaller than it should be.

Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
Cc :6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -616,6 +616,7 @@ void thermal_debug_tz_trip_up(struct the
 	tze->trip_stats[trip_id].timestamp = now;
 	tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
 	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
+	tze->trip_stats[trip_id].count++;
 	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
 		(temperature - tze->trip_stats[trip_id].avg) /
 		tze->trip_stats[trip_id].count;





Return-Path: <linux-kernel+bounces-130425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58478977E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DF9281E21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD28615358B;
	Wed,  3 Apr 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="udlbv5Rt"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947611534E4;
	Wed,  3 Apr 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167933; cv=none; b=FZEZHeFQbUj7k0A6o8nBcHfaKnKMSlBA1gMhZTZhIOULnHgWovjCKhTaVdwdBwFJrlmWI31p6POrbxxYClZR6pe5WH1W8Rv8o4VdFiwTMhMmrdJBbSf+hX+BkispEMTS45MxiuLwkGEj9ls86vgxUg0OlK8eGmioQW41zJthVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167933; c=relaxed/simple;
	bh=fycaxtzLFd7HApnTntQU05w3Bn4wrwYw7izu3q5Vzd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEsg2an9kGgBhDpZ7alr587hTtl/SZ4OZSBxTAPbgnN5AvMwNPkphk4wAYcxNYj0f/4Ytk12I+TfZchQ3Fsd9QYMPW2vqpgCTW34llt6TCIOEsPYhwZhh8Q1VG8xmM4zfOj6w3UPU1vtOATWCgRo7DOM6FtcOlRcMcHEaAAEp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=udlbv5Rt reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 2ecd91c500791d1f; Wed, 3 Apr 2024 20:12:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2AE67662F36;
	Wed,  3 Apr 2024 20:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712167927;
	bh=fycaxtzLFd7HApnTntQU05w3Bn4wrwYw7izu3q5Vzd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=udlbv5Rt7XeSzRzVO4ud4zDbZ5ktxh1uhvc2U4AVF5jCDCpdqTJxSfb84LGr1eQmU
	 aIe48HycsV1F2P3rHvWnYEHfxfHMD81LECLF4tuOxUN95JM/dTdXLrTN1R+pwId2Og
	 tcsPk609HpqvYhZYcTCJtNOBTH7+QupE5/VgeMDOkEpz8iR9Mm4a2VVVfpLXE4N9er
	 usDXA6jHHDHDY64APGyP4EPopbsg+gttv9d9U+KZ0gX9kyxltJ7hcuhAxyESWFbaDb
	 QXD+se7uPyhNxljeb91Cg5P/ekR4a4yPVPyBbmPTKEs8GQ+yfrS96RicRujtLZcAyi
	 WWyTc9FvGTMpA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 2/2] thermal: gov_step_wise: Simplify checks related to passive
 trips
Date: Wed, 03 Apr 2024 20:12:02 +0200
Message-ID: <2318465.ElGaqSPkdT@kreacher>
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

Make it more clear from the code flow that the passive polling status
updates only take place for passive trip points.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -92,15 +92,13 @@ static void thermal_zone_trip_update(str
 		if (instance->initialized && old_target == instance->target)
 			continue;
 
-		if (old_target == THERMAL_NO_TARGET &&
-		    instance->target != THERMAL_NO_TARGET) {
-			/* Activate a passive thermal instance */
-			if (trip->type == THERMAL_TRIP_PASSIVE)
+		if (trip->type == THERMAL_TRIP_PASSIVE) {
+			/* If needed, update the status of passive polling. */
+			if (old_target == THERMAL_NO_TARGET &&
+			    instance->target != THERMAL_NO_TARGET)
 				tz->passive++;
-		} else if (old_target != THERMAL_NO_TARGET &&
-			   instance->target == THERMAL_NO_TARGET) {
-			/* Deactivate a passive thermal instance */
-			if (trip->type == THERMAL_TRIP_PASSIVE)
+			else if (old_target != THERMAL_NO_TARGET &&
+				 instance->target == THERMAL_NO_TARGET)
 				tz->passive--;
 		}
 





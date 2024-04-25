Return-Path: <linux-kernel+bounces-158635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487198B2348
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3F2B26AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D9B149E1B;
	Thu, 25 Apr 2024 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UG48wMtD"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078051494D2;
	Thu, 25 Apr 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053460; cv=none; b=aaxMpH0N1NpnavG2OIG9jMPi7SMNZ7uyY1eA28bUoVm3WQoKwZOjgFq915B2wKvjQSdR7zwIlAHHPU6nOGjsK5ly+j5ITAQU753eL+u4vAodM1bNbkf35QlhG2QNGIBqeehT+6ZrKKkeVGsleu5OHHFumE0Xek2qFhm3Zc80fEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053460; c=relaxed/simple;
	bh=qGv9hKiqXyr11qBSCn4TaTUWz/H334NkfuERNuFWckM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHhQ/GEJVtsSy93wbs7nZJeSMuw0L2UsAj+BrKlkFCY53PGvGWMWWS3c8XXBii1jRHfyLQlIzbzoQe4r8Zn1eF5djH34HfuORYnM6XyRE/agE1PzXuRKbH0Ppou7QuzAdvEc3X9byJKB0dk6/Ias4h2X1yTbnCCAaX8KxlwHtSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UG48wMtD reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 481c96702fb04be3; Thu, 25 Apr 2024 15:57:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 990FE66DF24;
	Thu, 25 Apr 2024 15:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714053450;
	bh=qGv9hKiqXyr11qBSCn4TaTUWz/H334NkfuERNuFWckM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UG48wMtD2AjVaVHaKyewb4xzlZufoxymBj0aiaPwU8gB767c1QY++XsZhk+xbR9+K
	 oGITaRPlcAZStK6JOwpWnzAdALGTJsb2NMKgOTcn3CiPWNR84TC9HgEANKMwHh9cCH
	 Pq4tpLO4a6fgtjDfGH7q6pnJHZVOkkRVbIzLcf/FyUAotoGmKp4lZxJ7Od8pnjCAnS
	 XMj3P/h2zREyo/jKysdrn57rBgoAciQmwEuESRKALJ9Ali3u5Gt4WGy/ioj7UiLE/n
	 wwVNJG3J84VuDCmTzBGu0oUNQZP1gr1coOBOkivZeI9hTJcHypHeqPruu2qkdujmIx
	 XkM789x2MD8JQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [PATCH v1 1/3] thermal/debugfs: Free all thermal zone debug memory on zone
 removal
Date: Thu, 25 Apr 2024 15:49:04 +0200
Message-ID: <4918398.31r3eYUQgx@kreacher>
In-Reply-To: <12427744.O9o76ZdvQC@kreacher>
References: <12427744.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
 rggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because thermal_debug_tz_remove() does not free all memory allocated for
thermal zone diagnostics, some of that memory becomes unreachable after
freeing the thermal zone's struct thermal_debugfs object.

Address this by making thermal_debug_tz_remove() free all of the memory
in question.

Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
Cc :6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -832,15 +832,28 @@ void thermal_debug_tz_add(struct thermal
 void thermal_debug_tz_remove(struct thermal_zone_device *tz)
 {
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_episode *tze, *tmp;
+	struct tz_debugfs *tz_dbg;
+	int *trips_crossed;
 
 	if (!thermal_dbg)
 		return;
 
+	tz_dbg = &thermal_dbg->tz_dbg;
+
 	mutex_lock(&thermal_dbg->lock);
 
+	trips_crossed = tz_dbg->trips_crossed;
+
+	list_for_each_entry_safe(tze, tmp, &tz_dbg->tz_episodes, node) {
+		list_del(&tze->node);
+		kfree(tze);
+	}
+
 	tz->debugfs = NULL;
 
 	mutex_unlock(&thermal_dbg->lock);
 
 	thermal_debugfs_remove_id(thermal_dbg);
+	kfree(trips_crossed);
 }





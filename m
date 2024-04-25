Return-Path: <linux-kernel+bounces-158633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2B8B2346
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77CC1C214C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E7149E0A;
	Thu, 25 Apr 2024 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Atb2e8oS"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DFA17565;
	Thu, 25 Apr 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053459; cv=none; b=tAvh8rJRB6xrZYWMf6Ivq6FTwGw9KpjwvBfP7IThTzPla0fGaO3Ajybh3MeGP0vFiuG47oz9G5xGyUkVbiIu76ZUNRK7VdF5gUe7MrowQxTQo9xuK/ekU6akY7oNeOkfgqP+GbHB+wyShYWuADErUXFhVG1faWl+CijQ7IqrADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053459; c=relaxed/simple;
	bh=md7mVEfndKgd7O96TkmoVOmif2jnxJJjZ8nDmaFy5HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gubh728yFrlE4YFz/lU8Fv6VpL/DpvxkAGTTo/7K0WeO5HVsnRu9Qk/Ak+eNQfFU7DWHWqasSYs5qvrCfdGhxfSFlAAdpmi4Qie/deMgKNr6VHbDe67Tcn7r+Q894Q1jo2GujN1lRgj6PjkTUiGduBu6FkFPPe9sH0jY5scYdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Atb2e8oS reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 5d17d3ac70c195b5; Thu, 25 Apr 2024 15:57:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 17B8C66DF20;
	Thu, 25 Apr 2024 15:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714053448;
	bh=md7mVEfndKgd7O96TkmoVOmif2jnxJJjZ8nDmaFy5HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Atb2e8oSdOIO1v499cHwBlzv8QMeWj8u2qYdDVdsTpGUgkcRO9TQuHj2LlIqN9qZ9
	 iyZ6HEfddJIdfCuQwzpLyP85rCSeMqmo5eZazLlgDT33TJvGzUT9sJPP6zOxmEn8O2
	 F7AlkxQcC7bq4vrxNbuac8F3pcT1utgsh+PSnXj8WXyKYU/r6ilbAgbJLhumCRfA1d
	 XynsOiIMykJ4vLasOQ/SAjUeFrtg5/buo0+pJF0rO2FZFjfLbMTPE9D1bW4C0q6vGG
	 V1AAZhh88oYNdkNyDofmWlJQ+w88pumJbsL6OyASds1I51DnQQM57Qkxep4uDlUTh1
	 EDWALzr27f31w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [PATCH v1 3/3] thermal/debugfs: Prevent use-after-free from occurring after
 cdev removal
Date: Thu, 25 Apr 2024 15:57:12 +0200
Message-ID: <13503555.uLZWGnKmhe@kreacher>
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

Since thermal_debug_cdev_remove() does not run under cdev->lock, it can
run in parallel with thermal_debug_cdev_state_update() and it may free
the struct thermal_debugfs object used by the latter after it has been
checked against NULL.

If that happens, thermal_debug_cdev_state_update() will access memory
that has been freed already causing the kernel to crash.

Address this by using cdev->lock in thermal_debug_cdev_remove() around
the cdev->debugfs value check (in case the same cdev is removed at the
same time in two differet threads) and its reset to NULL.

Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
Cc :6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -503,15 +503,21 @@ void thermal_debug_cdev_add(struct therm
  */
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
 {
-	struct thermal_debugfs *thermal_dbg = cdev->debugfs;
+	struct thermal_debugfs *thermal_dbg;
 
+	mutex_lock(&cdev->lock);
+
+	thermal_dbg = cdev->debugfs;
 	if (!thermal_dbg)
 		return;
 
+	cdev->debugfs = NULL;
+
+	mutex_unlock(&cdev->lock);
+
 	mutex_lock(&thermal_dbg->lock);
 
 	thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
-	cdev->debugfs = NULL;
 
 	mutex_unlock(&thermal_dbg->lock);
 





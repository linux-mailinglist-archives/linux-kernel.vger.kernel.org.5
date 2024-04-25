Return-Path: <linux-kernel+bounces-158838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE538B2592
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DE4284957
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829F14BFBC;
	Thu, 25 Apr 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hbwfSz8U"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4891CF8A;
	Thu, 25 Apr 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060083; cv=none; b=T6hllSw5Sph29pYFvGCzqXxAf1bfwqQExOBE7I9hb7l4i3MtIgZZchkPrTk664miTgMBpJqtsSxPeXvpjnQtOGMXMbdbAJV6TQZr3cAwe0E82SntWlGsBkV20mbqiDgd01lOpVOBHlMaU4T8kzYGkfhHvWc/PeyoQYJ4z75tJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060083; c=relaxed/simple;
	bh=vRl3nerpRfMSVNdi2yLByaHezOdTcLaQL5k4oJE5Jx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2j5VgZwKZP0F0S1yv24qZlhiZ52fQ38czseq4w9s3X+8yf9RuX4suoT4BbvNYdv2LEkGAqtQ4RFMP+XEYG4VIkC4UP38muRahMmdFQXWztcYPIlhIEfqtUAZoPmFItkR1JFCwmMs6ZjkzeK5jzDGVzJk4olMqDPT1oZFIVLKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hbwfSz8U reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id af50854ee9ed0a10; Thu, 25 Apr 2024 17:47:58 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3308466DF31;
	Thu, 25 Apr 2024 17:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714060078;
	bh=vRl3nerpRfMSVNdi2yLByaHezOdTcLaQL5k4oJE5Jx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hbwfSz8UspzW8rjFdkmLtLc+FpOwVaJcJDoDJX5jlRmHDixcSCCHcMQqKBElPMAoR
	 ELou1a6skzjjhL+wLSQBI66gqA8RR10u1twRbCJhIuFbLQeOhhHriR6f/iBt6Unejq
	 7ztp9wEx3gstD2FCYglWnBNaQ2vnGEiB4aCQxuUuq+f2p9iKx4wPUyOoqWq66SATUu
	 kysupLnoiHUUTdLnfDoyN362soZb5+a/NamwbGl7sTjlbVV4EdtF+V7VAPFUaYkDqw
	 Ny5ZY6uoggwt12vnp83TYGXjt9ucy2tWv6lZUI107ObtNZ6rgIFafJLn8qRFZOMuMt
	 twqwCdyJwa/Lg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [Alternative][PATCH v1 2/3] thermal/debugfs: Fix two locking issues with
 thermal zone debug
Date: Thu, 25 Apr 2024 17:47:57 +0200
Message-ID: <5780690.DvuYhMxLoT@kreacher>
In-Reply-To: <1888579.tdWV9SEqCh@kreacher>
References: <12427744.O9o76ZdvQC@kreacher> <1888579.tdWV9SEqCh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
 rhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

With the current thermal zone locking arrangement in the debugfs code,
user space can open the "mitigations" file for a thermal zone before
the zone's debugfs pointer is set which will result in a NULL pointer
dereference in tze_seq_start().

Moreover, thermal_debug_tz_remove() is not called under the thermal
zone lock, so can run in parallel with the other functions accessing
the thermal zone's struct thermal_debugfs object.  Then, it may clear
tz->debugfs after one of those functions has checked it and the
struct thermal_debugfs object may be freed prematurely.

To address the first problem, pass a pointer to the thermal zone's
struct thermal_debugfs object to debugfs_create_file() in
thermal_debug_tz_add() and make tze_seq_start(), tze_seq_next(),
tze_seq_stop(), and tze_seq_show() retrieve it from s->private
instead of a pointer to the thermal zone object.  This will ensure
that tz_debugfs will be valid across the "mitigations" file accesses
until thermal_debugfs_remove_id() called by thermal_debug_tz_remove()
removes that file.

To address the second problem, use tz->lock in thermal_debug_tz_remove()
around the tz->debugfs value check (in case the same thermal zone is
removed at the same time in two differet threads) and its reset to NULL.

Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
Cc :6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is an alternative fix for the issues addressed by

https://lore.kernel.org/linux-pm/1888579.tdWV9SEqCh@kreacher/

and I slightly prefer it, because it is less intrusive and makes
the thermal zone debug code more consistent with the analogous code
for cdevs.

Accordingly, I've replace the above with this patch in the
thermal-core-next branch in linux-pm.git.

---
 drivers/thermal/thermal_debugfs.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -139,11 +139,13 @@ struct tz_episode {
  * we keep track of the current position in the history array.
  *
  * @tz_episodes: a list of thermal mitigation episodes
+ * @tz: thermal zone this object belongs to
  * @trips_crossed: an array of trip points crossed by id
  * @nr_trips: the number of trip points currently being crossed
  */
 struct tz_debugfs {
 	struct list_head tz_episodes;
+	struct thermal_zone_device *tz;
 	int *trips_crossed;
 	int nr_trips;
 };
@@ -710,8 +712,7 @@ out:
 
 static void *tze_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct thermal_zone_device *tz = s->private;
-	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct thermal_debugfs *thermal_dbg = s->private;
 	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
 
 	mutex_lock(&thermal_dbg->lock);
@@ -721,8 +722,7 @@ static void *tze_seq_start(struct seq_fi
 
 static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct thermal_zone_device *tz = s->private;
-	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct thermal_debugfs *thermal_dbg = s->private;
 	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
 
 	return seq_list_next(v, &tz_dbg->tz_episodes, pos);
@@ -730,15 +730,15 @@ static void *tze_seq_next(struct seq_fil
 
 static void tze_seq_stop(struct seq_file *s, void *v)
 {
-	struct thermal_zone_device *tz = s->private;
-	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct thermal_debugfs *thermal_dbg = s->private;
 
 	mutex_unlock(&thermal_dbg->lock);
 }
 
 static int tze_seq_show(struct seq_file *s, void *v)
 {
-	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *thermal_dbg = s->private;
+	struct thermal_zone_device *tz = thermal_dbg->tz_dbg.tz;
 	struct thermal_trip_desc *td;
 	struct tz_episode *tze;
 	const char *type;
@@ -816,6 +816,8 @@ void thermal_debug_tz_add(struct thermal
 
 	tz_dbg = &thermal_dbg->tz_dbg;
 
+	tz_dbg->tz = tz;
+
 	tz_dbg->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
 	if (!tz_dbg->trips_crossed) {
 		thermal_debugfs_remove_id(thermal_dbg);
@@ -824,20 +826,30 @@ void thermal_debug_tz_add(struct thermal
 
 	INIT_LIST_HEAD(&tz_dbg->tz_episodes);
 
-	debugfs_create_file("mitigations", 0400, thermal_dbg->d_top, tz, &tze_fops);
+	debugfs_create_file("mitigations", 0400, thermal_dbg->d_top,
+			    thermal_dbg, &tze_fops);
 
 	tz->debugfs = thermal_dbg;
 }
 
 void thermal_debug_tz_remove(struct thermal_zone_device *tz)
 {
-	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct thermal_debugfs *thermal_dbg;
 	struct tz_episode *tze, *tmp;
 	struct tz_debugfs *tz_dbg;
 	int *trips_crossed;
 
-	if (!thermal_dbg)
+	mutex_lock(&tz->lock);
+
+	thermal_dbg = tz->debugfs;
+	if (!thermal_dbg) {
+		mutex_unlock(&tz->lock);
 		return;
+	}
+
+	tz->debugfs = NULL;
+
+	mutex_unlock(&tz->lock);
 
 	tz_dbg = &thermal_dbg->tz_dbg;
 
@@ -850,8 +862,6 @@ void thermal_debug_tz_remove(struct ther
 		kfree(tze);
 	}
 
-	tz->debugfs = NULL;
-
 	mutex_unlock(&thermal_dbg->lock);
 
 	thermal_debugfs_remove_id(thermal_dbg);





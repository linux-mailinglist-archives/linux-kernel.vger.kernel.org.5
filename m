Return-Path: <linux-kernel+bounces-158634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803AD8B2347
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416C6B268BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64948149E10;
	Thu, 25 Apr 2024 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="D9g2zfyP"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E43149C56;
	Thu, 25 Apr 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053459; cv=none; b=RSwh1V5VYyXfbGutBz1J2QrfDk79+jPFdpNo39knklWlQ6cIOU9bHwFzjUq40gpQuVPRhpxR6g1Bh4lzm/KsaMtpRlFlNmHK3Pc7uITJJ1PTAQ6I1p/zmj6m2eIqEXxR4NAjwW1DDSNJxxV0j4hp3aOR7kck6E8asn+7QhOo554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053459; c=relaxed/simple;
	bh=MlMc+m0WCmwrvO4Ai45Pe6nuVtg7C4Cya5AQOAQ5MTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBiSnZpoOPVvh2Gu8ngnQjzVcHcBWD1TeFnE6QhP3F0oG8y7LdIQHcllK+ZlHGDKI/VWTbdwJaZ22d/+BUP174aqmmCf8pj07VDdOZFaF34AcWUIgE9MCYVDg0M7gi4DSbhAH5ikltRbbheC/g1+pXCTrlJRUjqzzqjWY0pXiGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=D9g2zfyP; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 7cbe6bc34e49c28f; Thu, 25 Apr 2024 15:57:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D65A766DF20;
	Thu, 25 Apr 2024 15:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714053449;
	bh=MlMc+m0WCmwrvO4Ai45Pe6nuVtg7C4Cya5AQOAQ5MTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9g2zfyPDv1O3eUBk4zDl3JIolJ+5NCT0gfBBOM9kKwKvwVs8PEKi4Mr6AZ8x/fqe
	 /d9Qmul516LYTJoDPNq7ZNQzpfFpZ3dwrcjEQ6MiCxrdNZ8x0aWr341tZ6xBMVdJDp
	 u1Tx6/cSfpHhEpTSHVmKRfsCsN4Lik6ziRcC3ne0CyBDj+STlU+FODginR4CQZXKrl
	 pZybLEbe2IDp6a+Ly3jiCH/vgW/0C4ThkQ3j5rj+Nz02oDqHUmLsYYDUwMYDPQFWeh
	 LPPf+aaVc4iGoeDHmE0dpdSmxenLnlSurt2DOgvxxIpsRc1WNLKpezh/c9NATiQlV3
	 Zf6vle4Cev4fg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/3] thermal/debugfs: Fix thermal zone locking
Date: Thu, 25 Apr 2024 15:55:45 +0200
Message-ID: <1888579.tdWV9SEqCh@kreacher>
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

With the current thermal zone locking arrangement in the debugfs code,
user space can open the "mitigations" file for a thermal zone before
the zone's debugfs pointer is set which will result in a NULL pointer
dereference in tze_seq_start().

While this could be addressed by putting the creation of the
"mitigations" file under thermal_dbg->lock, there is still a problem
with thermal_debug_tz_remove() that is not called under the thermal
zone lock and can run in parallel with the other functions accessing
the thermal zone's struct thermal_debugfs object.  Then, it may
clear tz->debugfs after one of those functions has checked it and the
struct thermal_debugfs object may be freed prematurely.

To address both problems described above at once, use the observation
that thermal_debug_tz_trip_up(), thermal_debug_tz_trip_down(), and
thermal_debug_update_trip_stats() all run under the thermal zone
lock and because they all acquire thermal_dbg->lock for the thermal
zone's struct thermal_debugfs object, they must wait on that lock if it
is held while they are running and their callers (holding the thermal
zone lock) must wait along with them.  This means that tze_seq_start()
may as well acquire tz->lock instead of thermal_dbg->lock and check the
struct thermal_debugfs object pointer retrieved from the thermal zone
against NULL under it.

Then, tz->lock can also be acquired by thermal_debug_tz_add() and
thermal_debug_tz_remove() to eliminate the race conditions at hand.

Rearrange the code in question accordingly and remove the
thermal_dbg->lock locking, which is now redundant, from it.

Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
Cc :6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   60 +++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -551,8 +551,6 @@ void thermal_debug_tz_trip_up(struct the
 	if (!thermal_dbg)
 		return;
 
-	mutex_lock(&thermal_dbg->lock);
-
 	tz_dbg = &thermal_dbg->tz_dbg;
 
 	/*
@@ -591,7 +589,7 @@ void thermal_debug_tz_trip_up(struct the
 	if (!tz_dbg->nr_trips) {
 		tze = thermal_debugfs_tz_event_alloc(tz, now);
 		if (!tze)
-			goto unlock;
+			return;
 
 		list_add(&tze->node, &tz_dbg->tz_episodes);
 	}
@@ -613,9 +611,6 @@ void thermal_debug_tz_trip_up(struct the
 
 	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
 	tze->trip_stats[trip_id].timestamp = now;
-
-unlock:
-	mutex_unlock(&thermal_dbg->lock);
 }
 
 void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
@@ -631,8 +626,6 @@ void thermal_debug_tz_trip_down(struct t
 	if (!thermal_dbg)
 		return;
 
-	mutex_lock(&thermal_dbg->lock);
-
 	tz_dbg = &thermal_dbg->tz_dbg;
 
 	/*
@@ -643,7 +636,7 @@ void thermal_debug_tz_trip_down(struct t
 	 * no mitigation mechanism yet at boot time.
 	 */
 	if (!tz_dbg->nr_trips)
-		goto out;
+		return;
 
 	for (i = tz_dbg->nr_trips - 1; i >= 0; i--) {
 		if (tz_dbg->trips_crossed[i] == trip_id)
@@ -651,7 +644,7 @@ void thermal_debug_tz_trip_down(struct t
 	}
 
 	if (i < 0)
-		goto out;
+		return;
 
 	tz_dbg->nr_trips--;
 
@@ -671,9 +664,6 @@ void thermal_debug_tz_trip_down(struct t
 	 */
 	if (!tz_dbg->nr_trips)
 		tze->duration = ktime_sub(now, tze->timestamp);
-
-out:
-	mutex_unlock(&thermal_dbg->lock);
 }
 
 void thermal_debug_update_trip_stats(struct thermal_zone_device *tz)
@@ -686,12 +676,10 @@ void thermal_debug_update_trip_stats(str
 	if (!thermal_dbg)
 		return;
 
-	mutex_lock(&thermal_dbg->lock);
-
 	tz_dbg = &thermal_dbg->tz_dbg;
 
 	if (!tz_dbg->nr_trips)
-		goto out;
+		return;
 
 	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
 
@@ -704,19 +692,22 @@ void thermal_debug_update_trip_stats(str
 		trip_stats->avg += (tz->temperature - trip_stats->avg) /
 					++trip_stats->count;
 	}
-out:
-	mutex_unlock(&thermal_dbg->lock);
 }
 
 static void *tze_seq_start(struct seq_file *s, loff_t *pos)
 {
 	struct thermal_zone_device *tz = s->private;
-	struct thermal_debugfs *thermal_dbg = tz->debugfs;
-	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
+	struct thermal_debugfs *thermal_dbg;
 
-	mutex_lock(&thermal_dbg->lock);
+	mutex_lock(&tz->lock);
 
-	return seq_list_start(&tz_dbg->tz_episodes, *pos);
+	thermal_dbg = tz->debugfs;
+	if (!thermal_dbg) {
+		mutex_unlock(&tz->lock);
+		return NULL;
+	}
+
+	return seq_list_start(&thermal_dbg->tz_dbg.tz_episodes, *pos);
 }
 
 static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
@@ -731,9 +722,8 @@ static void *tze_seq_next(struct seq_fil
 static void tze_seq_stop(struct seq_file *s, void *v)
 {
 	struct thermal_zone_device *tz = s->private;
-	struct thermal_debugfs *thermal_dbg = tz->debugfs;
 
-	mutex_unlock(&thermal_dbg->lock);
+	mutex_unlock(&tz->lock);
 }
 
 static int tze_seq_show(struct seq_file *s, void *v)
@@ -826,23 +816,33 @@ void thermal_debug_tz_add(struct thermal
 
 	debugfs_create_file("mitigations", 0400, thermal_dbg->d_top, tz, &tze_fops);
 
+	mutex_lock(&tz->lock);
+
 	tz->debugfs = thermal_dbg;
+
+	mutex_unlock(&tz->lock);
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
 
-	tz_dbg = &thermal_dbg->tz_dbg;
+	tz->debugfs = NULL;
 
-	mutex_lock(&thermal_dbg->lock);
+	mutex_unlock(&tz->lock);
 
+	tz_dbg = &thermal_dbg->tz_dbg;
 	trips_crossed = tz_dbg->trips_crossed;
 
 	list_for_each_entry_safe(tze, tmp, &tz_dbg->tz_episodes, node) {
@@ -850,10 +850,6 @@ void thermal_debug_tz_remove(struct ther
 		kfree(tze);
 	}
 
-	tz->debugfs = NULL;
-
-	mutex_unlock(&thermal_dbg->lock);
-
 	thermal_debugfs_remove_id(thermal_dbg);
 	kfree(trips_crossed);
 }





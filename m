Return-Path: <linux-kernel+bounces-56975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8556984D210
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80231C2293F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4311EA72;
	Wed,  7 Feb 2024 19:13:00 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7C84FB3;
	Wed,  7 Feb 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333180; cv=none; b=McAEyYxFXwRlWcukFvjLKwnNZwZ4108bF0CqGiFEyABZns+eZTzbMemdYoO/LSs76JVeVXyPv2tOYMVeSo5I+wDYL9ocR++7YHXGd3z4GwBHW5imHzLxL2p/HPa6ifUgau1n7V21fH197njSVv0iSMm4+uo4pu3edtpJiAjvBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333180; c=relaxed/simple;
	bh=IKdzAuASVSS/yKCccM5Mg8xdrg02liH8JpWtvz0XBq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl4HbFblep3004a7pyJcpCCX5YZVrfFhz6vJAZmuflWe/2LKwlfcyFKClf48k+rADLe0XOqTF3jlpZoyGwstN2V2zgM9YSSnh5JSLEXoR0p7cVUUa1ZJlG8wm3K7S6p+NnL+t6nDfuvPhcquiJbL75YQk2vmMXotJPIMQd/50bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id e8e8c8c4c6c01498; Wed, 7 Feb 2024 20:12:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DD008669B2E;
	Wed,  7 Feb 2024 20:12:49 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject:
 [PATCH v1 1/3] iwlwifi: mvm: Drop unused fw_trips_index[] from
 iwl_mvm_thermal_device
Date: Wed, 07 Feb 2024 20:09:15 +0100
Message-ID: <13461881.uLZWGnKmhe@kreacher>
In-Reply-To: <1892445.tdWV9SEqCh@kreacher>
References: <1892445.tdWV9SEqCh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhorhihrdhgrhgvvghnmhgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehmihhrihgrmhdrrhgrtghhvghlrdhkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvrghloheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 jhhohhgrnhhnvghsrdgsvghrghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The fw_trips_index[] array in struct iwl_mvm_thermal_device is only
populated, but never read, so drop it.

Note that the iwl_mvm_send_temp_report_ths_cmd() code populating
fw_trips_index[] is questionable, because it accesses a trips table
of a thermal zone directly, which is not guaranteed to work in the
future.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |    2 --
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c  |   13 +------------
 2 files changed, 1 insertion(+), 14 deletions(-)

Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -539,12 +539,10 @@ struct iwl_mvm_tt_mgmt {
 /**
  *struct iwl_mvm_thermal_device - thermal zone related data
  * @temp_trips: temperature thresholds for report
- * @fw_trips_index: keep indexes to original array - temp_trips
  * @tzone: thermal zone device data
 */
 struct iwl_mvm_thermal_device {
 	struct thermal_trip trips[IWL_MAX_DTS_TRIPS];
-	u8 fw_trips_index[IWL_MAX_DTS_TRIPS];
 	struct thermal_zone_device *tzone;
 };
 
Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -562,7 +562,7 @@ int iwl_mvm_send_temp_report_ths_cmd(str
 	struct temp_report_ths_cmd cmd = {0};
 	int ret;
 #ifdef CONFIG_THERMAL
-	int i, j, idx = 0;
+	int i, idx = 0;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -588,17 +588,6 @@ int iwl_mvm_send_temp_report_ths_cmd(str
 	/*sort cmd array*/
 	sort(cmd.thresholds, idx, sizeof(s16), compare_temps, NULL);
 
-	/* we should save the indexes of trips because we sort
-	 * and compress the orginal array
-	 */
-	for (i = 0; i < idx; i++) {
-		for (j = 0; j < IWL_MAX_DTS_TRIPS; j++) {
-			if ((int)(le16_to_cpu(cmd.thresholds[i]) * 1000) ==
-			    mvm->tz_device.trips[j].temperature)
-				mvm->tz_device.fw_trips_index[i] = j;
-		}
-	}
-
 send:
 #endif
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,





Return-Path: <linux-kernel+bounces-85376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4186B524
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E551C21E38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC57B1EA99;
	Wed, 28 Feb 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xAd72J1L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iVEBTj8T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pz2nAxBu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NOaApkRl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3A1CAAB;
	Wed, 28 Feb 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138331; cv=none; b=tk94ekSRZZAWEGeKt1YlXnXmV9Rw4o0XK7uftqeymPt8HgM1hSI/p7sprIKiEyKdYcnAJaEtuSWX6RL7gv8vMTCVl1uKaMQKzMKu2hD6K5Wh8UBxeXAnsZ51zra8NpHkFz3HJaE+mYD3ElDKha5ZCgapJSTtjsyWo0mBYGg3hVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138331; c=relaxed/simple;
	bh=JxP9GcXwVJpfYHD5gmr0uw+XlSWp8lZYEClj+2tCrXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gpQLMTQeehWfdVbfARX8Bv/PapS3PcQBOeao6X6U6GECvfhCQ9rZC5uOyOKl2BdHjDkjfVWKxMsaQMQTngVDOVVRMt6/dETARZgn2fK4EIz16xEzZXgaamE5nKzMdYqrkqo/YzgD/AweDsvpKGV6kn3HqmsZ/gbXijDhG0l37TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xAd72J1L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iVEBTj8T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pz2nAxBu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NOaApkRl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD2621F796;
	Wed, 28 Feb 2024 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709138328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WO75YmVzdv4mgGMuVpHJywPWnkx4nZzb1oXuZM8U/OM=;
	b=xAd72J1LCi8cOXXBPuA2v6ecbOaxI1mocvxa5VlSOATY3Qq6adB9mlwXKgwR+7BLaEXqKq
	9LHNniy13houaZan2dEqrXiRxpQmKsCjLfMRMCb2FjO6WYTQTFwcBpxrxJkTKhnl3wVlxH
	WgkauH9XCXKoUsdQPKDLIzkdMrGDrLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709138328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WO75YmVzdv4mgGMuVpHJywPWnkx4nZzb1oXuZM8U/OM=;
	b=iVEBTj8T/fJOHrH8qMuL/lVhFKn36Me8/ItQxiqw0VffvT2wiUAywQkl11GHmEGFeO+YgG
	p5gDWPdsNK4uVfBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709138327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WO75YmVzdv4mgGMuVpHJywPWnkx4nZzb1oXuZM8U/OM=;
	b=Pz2nAxBuTbtnoXxsv8ZfZ5yUKVszLZyHBjAMEh4V6s7GKUsBAaQiBF0+g38+q+GUe9J3EE
	NP4gVM172uZ2LjUaNB6CH8rcmRMyNLdCaVoLlo8tdGL7tIrZPej6P6/h0mEY+n8Cl74sBD
	A6MXAkaxceWSBIKRYOqdyUTQQjt54r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709138327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WO75YmVzdv4mgGMuVpHJywPWnkx4nZzb1oXuZM8U/OM=;
	b=NOaApkRltBSHYazj/9Z4XTydxb1TByctk72JjsFGFd8nX8rj4GS/Mg5MnQBAdOanIBgyE2
	dccfUcns1tc2DxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABACA13A58;
	Wed, 28 Feb 2024 16:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q8vsJ5dh32WbFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 28 Feb 2024 16:38:47 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iwlwifi: cfg: Add missing MODULE_FIRMWARE() for *.pnvm
Date: Wed, 28 Feb 2024 17:38:37 +0100
Message-Id: <20240228163837.4320-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Pz2nAxBu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NOaApkRl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.17)[-0.834];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 0.52
X-Rspamd-Queue-Id: DD2621F796
X-Spam-Flag: NO

A few models require *.pnvm files while we don't declare them via
MODULE_FIRMWARE().  This resulted in the breakage of WiFi on the
system that relies on the information from modinfo (e.g. openSUSE
installer image).

This patch adds those missing MODULE_FIRMWARE() entries for *.pnvm
files.

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1207553
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

The original patch was submitted months ago
  https://lore.kernel.org/r/20230405063546.12439-1-tiwai@suse.de
but it seems forgotten / overlooked.
Now updated to the latest firmware files and resubmitted.


 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 4 ++++
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d594694206b3..fb31a4262edc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -426,3 +426,7 @@ MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+
+MODULE_FIRMWARE("iwlwifi-so-a0-gf4-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-so-a0-gf-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-ty-a0-gf-a0.pnvm");
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 134635c70ce8..aa0f501ff74e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -299,3 +299,6 @@ MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+
+MODULE_FIRMWARE("iwlwifi-ma-b0-gf4-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-ma-b0-gf-a0.pnvm");
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 82da957adcf6..1b6249561cd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -179,3 +179,5 @@ MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+
+MODULE_FIRMWARE("iwlwifi-gl-c0-fm-c0.pnvm");
-- 
2.35.3



Return-Path: <linux-kernel+bounces-83036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17E868D97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02C9287D79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A7C1386B3;
	Tue, 27 Feb 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NfWSYoux";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErkJlFA1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NfWSYoux";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErkJlFA1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A81384AB;
	Tue, 27 Feb 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029760; cv=none; b=uyD8C61jRxqeCuvdu3GZ6z4AmX30zg45a9F9nGptjywHiQAjXmwTlnPCtXSLx8yRpnAByfPtR+L1RsEShWXrOXLXYbQoRgFlnSvS3yHTTBQhd6WLfCjTGQE+BBP3p/Y/wNjeR0XVM4YYuO0q0CZpLLmjFkUsPbu29rdRicvrURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029760; c=relaxed/simple;
	bh=sHVTLu99EYH20eFMAj8Z1GVmlTadbN+UNu5+uZ//67k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3i0IrNqR1dlCyuYYsCR7/pMmG1kXfdpL2yKcu7PrKM2s1TfkWYKkNWvfaZg9noOfKXK43eOR9OhO9F2Q5M9ScfLjuSxtD9tTK0v+QElZVw6jnygp7VFIrd0HoIWC8gsxT7AUkfjf5fp7PcdgM++Mb/ZpXTimdzL21i+Kw2xIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NfWSYoux; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErkJlFA1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NfWSYoux; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErkJlFA1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19FED2240B;
	Tue, 27 Feb 2024 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709029757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=And22F79eTMCKFSOxS0cURY8ciLXgYFzuTYPu2HxNT0=;
	b=NfWSYoux1tV1M1Z2a+L01ex7CkPEuWEVY+7MSe15h2wYZvLkxf8RpxNChttyQbDv7wSWlz
	kqHkU3f0zH5f9niDg6VCx1Yzjk7ou+OirtFwZWOJTZDFx4fFDNoJGiHKz4BNPeVTnA4cdc
	SIokj6dII7tleYRwbjZE/qcP0BxhAMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709029757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=And22F79eTMCKFSOxS0cURY8ciLXgYFzuTYPu2HxNT0=;
	b=ErkJlFA1KDFiLofenbwIfJMNqhHbQnLAlNJCo0RTcRx/++Gbt3LpMU9+TAKsNk1Dt2pX2v
	gzuQjeNU26Jn8hAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709029757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=And22F79eTMCKFSOxS0cURY8ciLXgYFzuTYPu2HxNT0=;
	b=NfWSYoux1tV1M1Z2a+L01ex7CkPEuWEVY+7MSe15h2wYZvLkxf8RpxNChttyQbDv7wSWlz
	kqHkU3f0zH5f9niDg6VCx1Yzjk7ou+OirtFwZWOJTZDFx4fFDNoJGiHKz4BNPeVTnA4cdc
	SIokj6dII7tleYRwbjZE/qcP0BxhAMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709029757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=And22F79eTMCKFSOxS0cURY8ciLXgYFzuTYPu2HxNT0=;
	b=ErkJlFA1KDFiLofenbwIfJMNqhHbQnLAlNJCo0RTcRx/++Gbt3LpMU9+TAKsNk1Dt2pX2v
	gzuQjeNU26Jn8hAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0011513A65;
	Tue, 27 Feb 2024 10:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CZgFO3y53WXZAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Feb 2024 10:29:16 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922
Date: Tue, 27 Feb 2024 11:29:14 +0100
Message-Id: <20240227102914.8341-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *****
X-Spam-Score: 5.18
X-Spamd-Result: default: False [5.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.02)[54.26%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:url];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,collabora.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Since dracut refers to the module info for defining the required
firmware files and btmtk driver doesn't provide the firmware info for
MT7922, the generate initrd misses the firmware, resulting in the
broken Bluetooth.

This patch simply adds the MODULE_FIRMWARE() for the missing entry
for covering that.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1214133
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btmtk.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index aaabb732082c..e5138a207f37 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -420,5 +420,6 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_MT7622);
 MODULE_FIRMWARE(FIRMWARE_MT7663);
 MODULE_FIRMWARE(FIRMWARE_MT7668);
+MODULE_FIRMWARE(FIRMWARE_MT7922);
 MODULE_FIRMWARE(FIRMWARE_MT7961);
 MODULE_FIRMWARE(FIRMWARE_MT7925);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 56f5502baadf..cbcdb99a22e6 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -4,6 +4,7 @@
 #define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
+#define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
 
-- 
2.35.3



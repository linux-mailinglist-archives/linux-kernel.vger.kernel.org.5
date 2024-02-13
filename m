Return-Path: <linux-kernel+bounces-63620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA4F85325F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EB01F23D35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422356B68;
	Tue, 13 Feb 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RmEer6nz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QjwKP+KB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RmEer6nz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QjwKP+KB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C656769;
	Tue, 13 Feb 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832429; cv=none; b=tJz5mpjysipcy50I3llm8DBZOIWsTpOnwCytwTlnkwBO87RGgxVBWik+BppCFTLLf0DFKJY+WnB6rs+IYmDF8zI8iUzLnRZPhxwU59f9A1ZUksxuAwb/d1kyElSeyjrEib+RsJj43MSe3+ktRnI2+6EQDC8AIGmY0PkBaQ3Dju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832429; c=relaxed/simple;
	bh=qT7rHicdtc4WdDDNnByPVJtgj/EFMHXfSeHcA/PlnBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4PpE0qf4qPAKX14ZK9R/YpVi7jFr9zuuehCDcsDDGzE2t5dmoWMmJmD777vgkWzcMmRPCaox/I+xotdj/wHqhKSowvPacjabkgtfal8DFsbXX0Um9hiztDHjEHPaBkY9yB3c9emwoikuLDBOGrn5PEb9n+FclYgrGA6YZNVmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RmEer6nz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QjwKP+KB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RmEer6nz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QjwKP+KB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 581851F7E0;
	Tue, 13 Feb 2024 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707832425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lqGnkWNffnK1QfHQP/tkrG31UipTum3bXY+Egr3HCiw=;
	b=RmEer6nz53QSJME1/f2p/cO39+BRocao5zdxL5yKudGPAFCbCq7LKjaEeNn1K1JRU8WnIk
	FCGBJ2WjjD3grajG/uVsTmgIf7dYdKuxYVXNQLQ1dGKlPPMM7uzu7Dv/0DX546vP7BkxzB
	Du4Y1UI3lxvEhpPi6zqJdLEFIdcsUio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707832425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lqGnkWNffnK1QfHQP/tkrG31UipTum3bXY+Egr3HCiw=;
	b=QjwKP+KBusj9Xvmb6AxB4gmGAjF5nXKDId35HajqJxWmhFdsCKcFGOVzntE+izRkoAM8w0
	eUP2Uq0vOBGj3TCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707832425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lqGnkWNffnK1QfHQP/tkrG31UipTum3bXY+Egr3HCiw=;
	b=RmEer6nz53QSJME1/f2p/cO39+BRocao5zdxL5yKudGPAFCbCq7LKjaEeNn1K1JRU8WnIk
	FCGBJ2WjjD3grajG/uVsTmgIf7dYdKuxYVXNQLQ1dGKlPPMM7uzu7Dv/0DX546vP7BkxzB
	Du4Y1UI3lxvEhpPi6zqJdLEFIdcsUio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707832425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lqGnkWNffnK1QfHQP/tkrG31UipTum3bXY+Egr3HCiw=;
	b=QjwKP+KBusj9Xvmb6AxB4gmGAjF5nXKDId35HajqJxWmhFdsCKcFGOVzntE+izRkoAM8w0
	eUP2Uq0vOBGj3TCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 458191370C;
	Tue, 13 Feb 2024 13:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XyR9EGl0y2WhHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 13:53:45 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: seq: fix function cast warnings
Date: Tue, 13 Feb 2024 14:53:43 +0100
Message-Id: <20240213135343.16411-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

clang-16 points out a control flow integrity (kcfi) issue when event
callbacks get converted to incompatible types:

sound/core/seq/seq_midi.c:135:30: error: cast from 'int (*)(struct snd_rawmidi_substream *, const char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  135 |                 snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/core/seq/seq_virmidi.c:83:31: error: cast from 'int (*)(struct snd_rawmidi_substream *, const unsigned char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   83 |                         snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For addressing those errors, introduce wrapper functions that are used
for callbacks and bridge to the actual function call with pointer
cast.

The code was originally added with the initial ALSA merge in linux-2.5.4.

[ the patch description shamelessly copied from Arnd's original patch
  -- tiwai ]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240213101020.459183-1-arnd@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_midi.c    | 8 +++++++-
 sound/core/seq/seq_virmidi.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 18320a248aa7..78dcb0ea1558 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -113,6 +113,12 @@ static int dump_midi(struct snd_rawmidi_substream *substream, const char *buf, i
 	return 0;
 }
 
+/* callback for snd_seq_dump_var_event(), bridging to dump_midi() */
+static int __dump_midi(void *ptr, void *buf, int count)
+{
+	return dump_midi(ptr, buf, count);
+}
+
 static int event_process_midi(struct snd_seq_event *ev, int direct,
 			      void *private_data, int atomic, int hop)
 {
@@ -132,7 +138,7 @@ static int event_process_midi(struct snd_seq_event *ev, int direct,
 			pr_debug("ALSA: seq_midi: invalid sysex event flags = 0x%x\n", ev->flags);
 			return 0;
 		}
-		snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
+		snd_seq_dump_var_event(ev, __dump_midi, substream);
 		snd_midi_event_reset_decode(msynth->parser);
 	} else {
 		if (msynth->parser == NULL)
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 1b9260108e48..1678737f11be 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -62,6 +62,13 @@ static void snd_virmidi_init_event(struct snd_virmidi *vmidi,
 /*
  * decode input event and put to read buffer of each opened file
  */
+
+/* callback for snd_seq_dump_var_event(), bridging to snd_rawmidi_receive() */
+static int dump_to_rawmidi(void *ptr, void *buf, int count)
+{
+	return snd_rawmidi_receive(ptr, buf, count);
+}
+
 static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 					 struct snd_seq_event *ev,
 					 bool atomic)
@@ -80,7 +87,7 @@ static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 		if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 			if ((ev->flags & SNDRV_SEQ_EVENT_LENGTH_MASK) != SNDRV_SEQ_EVENT_LENGTH_VARIABLE)
 				continue;
-			snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
+			snd_seq_dump_var_event(ev, dump_to_rawmidi, vmidi->substream);
 			snd_midi_event_reset_decode(vmidi->parser);
 		} else {
 			len = snd_midi_event_decode(vmidi->parser, msg, sizeof(msg), ev);
-- 
2.35.3



Return-Path: <linux-kernel+bounces-16463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A8823EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D31F25156
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19902208D0;
	Thu,  4 Jan 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zB3BJRwh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHrZS6J3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zB3BJRwh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHrZS6J3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6220B00;
	Thu,  4 Jan 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E54E21F0F;
	Thu,  4 Jan 2024 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704361628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EMpOkek3UzbzqloIm6JwYe5MMwJcc3+DVcMOLpoJnf0=;
	b=zB3BJRwh+uPkFPa53G4XEAMAcg7SpZOAlaiigRFvKe5aIXx3DFYfIod9gwZ60HBBDSw/7+
	L5hyL0RuADAqcJEEMHxqfBSZN7Yqg6VcN+4n3Za2j7EEdiZcJHs89xGkOQ533vL3ItMqgz
	KB/MAy6O+pXv0uNQ/AHG9rChyz8mjZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704361628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EMpOkek3UzbzqloIm6JwYe5MMwJcc3+DVcMOLpoJnf0=;
	b=GHrZS6J37nBA04Vh8IB9jSLWziWwp6+YwkUhLnxrmYRxFYVV/YbNOZgqHmIq4LPhHCQFaR
	K4s8aqXPzcgopzBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704361628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EMpOkek3UzbzqloIm6JwYe5MMwJcc3+DVcMOLpoJnf0=;
	b=zB3BJRwh+uPkFPa53G4XEAMAcg7SpZOAlaiigRFvKe5aIXx3DFYfIod9gwZ60HBBDSw/7+
	L5hyL0RuADAqcJEEMHxqfBSZN7Yqg6VcN+4n3Za2j7EEdiZcJHs89xGkOQ533vL3ItMqgz
	KB/MAy6O+pXv0uNQ/AHG9rChyz8mjZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704361628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EMpOkek3UzbzqloIm6JwYe5MMwJcc3+DVcMOLpoJnf0=;
	b=GHrZS6J37nBA04Vh8IB9jSLWziWwp6+YwkUhLnxrmYRxFYVV/YbNOZgqHmIq4LPhHCQFaR
	K4s8aqXPzcgopzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D541E137E8;
	Thu,  4 Jan 2024 09:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dfR+Mpt+lmWuZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Jan 2024 09:47:07 +0000
Date: Thu, 04 Jan 2024 10:47:07 +0100
Message-ID: <8734vda0ro.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.7-final
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.7-final from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-final

The topmost commit is b6ce6e6c79e4ec650887f1fe391a70e54972001a

----------------------------------------------------------------

sound fixes for 6.7-final

It became more than wished, partly because of vacations.
But all changes are fairly device-specific and should be safe to
apply.

- A regression fix for Oops at ASoC HD-audio probe
- A series of TAS2781 HD-audio codec fixes
- A random build regression fix with SPI helpers
- Minor endianness fix for USB-audio mixer code
- ASoC FSL driver error handling fix
- ASoC Mediatek driver register fix
- A series of ASoC meson g12a driver fixes
- A few usual HD-audio oneliner quirks

----------------------------------------------------------------

Aabish Malik (1):
      ALSA: hda/realtek: enable SND_PCI_QUIRK for hp pavilion 14-ec1xxx series

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook

Arnd Bergmann (1):
      ALSA: hda: cs35l41: fix building without CONFIG_SPI

Chancel Liu (1):
      ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable

Eugen Hristev (1):
      ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Convert meter levels from little-endian

Gergo Koteles (4):
      ALSA: hda/tas2781: do not use regcache
      ALSA: hda/tas2781: fix typos in comment
      ALSA: hda/tas2781: move set_drv_data outside tasdevice_init
      ALSA: hda/tas2781: remove sound controls in unbind

Mark Brown (4):
      ASoC: meson: g12a-toacodec: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-toacodec: Fix event generation
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-codec: Delay the codec device registration

Siddhesh Dharme (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

---
 sound/pci/hda/cs35l41_hda_property.c        |   4 +-
 sound/pci/hda/patch_realtek.c               |   3 +
 sound/pci/hda/tas2781_hda_i2c.c             | 244 +++++++++++++++-------------
 sound/soc/codecs/tas2781-comlib.c           |   4 +-
 sound/soc/codecs/tas2781-i2c.c              |   2 +
 sound/soc/fsl/fsl_rpmsg.c                   |  10 +-
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c |   2 +-
 sound/soc/meson/g12a-toacodec.c             |   5 +-
 sound/soc/meson/g12a-tohdmitx.c             |   8 +-
 sound/soc/sof/intel/hda-codec.c             |  18 +-
 sound/usb/mixer_scarlett2.c                 |   4 +-
 11 files changed, 172 insertions(+), 132 deletions(-)



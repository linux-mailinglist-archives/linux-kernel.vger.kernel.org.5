Return-Path: <linux-kernel+bounces-9909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B7381CD22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5F0284133
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F58124B2B;
	Fri, 22 Dec 2023 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wKWIY2vo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UFWvKtba";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wKWIY2vo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UFWvKtba"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A128DAE;
	Fri, 22 Dec 2023 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9095E1FCF3;
	Fri, 22 Dec 2023 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703262825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ASfyBiHGopBSHPsiBWh86SSl0tC2PpCWSmHou4sRjFQ=;
	b=wKWIY2voTOHgcKt20XRhosPW5MIO99Cq0cC+l6Q6zw8kvwRZ0Jm1n0YRK6w9STiR6sgzLk
	pJhRf097OtkwwrqrstVKClT2KeadhKn/Ai8KJxCz1VrsUhIfG5CmSQl/uqoi0sloXGKVqs
	kAptiChXekgamjS6/jM3tJdOEVIDSUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703262825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ASfyBiHGopBSHPsiBWh86SSl0tC2PpCWSmHou4sRjFQ=;
	b=UFWvKtbatTEic60MrYwX8isazwz4LuO4QDbLQD1fSU45mC1L9dZqJUXkLQ/3ZNpj7xTHrc
	VekBRQ/qjUHUjQBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703262825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ASfyBiHGopBSHPsiBWh86SSl0tC2PpCWSmHou4sRjFQ=;
	b=wKWIY2voTOHgcKt20XRhosPW5MIO99Cq0cC+l6Q6zw8kvwRZ0Jm1n0YRK6w9STiR6sgzLk
	pJhRf097OtkwwrqrstVKClT2KeadhKn/Ai8KJxCz1VrsUhIfG5CmSQl/uqoi0sloXGKVqs
	kAptiChXekgamjS6/jM3tJdOEVIDSUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703262825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ASfyBiHGopBSHPsiBWh86SSl0tC2PpCWSmHou4sRjFQ=;
	b=UFWvKtbatTEic60MrYwX8isazwz4LuO4QDbLQD1fSU45mC1L9dZqJUXkLQ/3ZNpj7xTHrc
	VekBRQ/qjUHUjQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D96313997;
	Fri, 22 Dec 2023 16:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mGo5FWm6hWV7RAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 22 Dec 2023 16:33:45 +0000
Date: Fri, 22 Dec 2023 17:33:44 +0100
Message-ID: <s5httoatcwn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.7-rc7
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 TO_DN_ALL(0.00)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wKWIY2vo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UFWvKtba
X-Spam-Score: -3.31
X-Rspamd-Queue-Id: 9095E1FCF3

Linus,

please pull sound fixes for v6.7-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc7

The topmost commit is 916d051730ae48aef8b588fd096fefca4bc0590a

----------------------------------------------------------------

sound fixes for 6.7-rc7

Apparently there were so many kids wishing bug fixes that made Santa
busy; here we have lots of fixes although it's a bit late.
But all changes are device-specific, hence it should be relatively
safe to apply.

Most of changes are for Cirrus codecs (for both ASoC and HD-audio),
while the remaining are fixes for TI codecs, HD-audio and USB-audio
quirks.

----------------------------------------------------------------

Charles Keepax (1):
      ASoC: cs42l43: Don't enable bias sense during type detect

Clément Villeret (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG GV302XA

Curtis Malainey (1):
      ASoC: SOF: mediatek: mt8186: Revert Add Google Steelix topology compatible

Gergo Koteles (2):
      ALSA: hda/tas2781: select program 0, conf 0 by default
      ASoC: tas2781: check the validity of prm_no/cfg_no

Ghanshyam Agrawal (1):
      kselftest: alsa: fixed a print formatting warning

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346
      ASoC: Intel: bytcr_rt5640: Add new swapped-speakers quirk

Jeremie Knuesel (1):
      ALSA: usb-audio: Increase delay in MOTU M quirk

Jerome Brunet (1):
      ASoC: hdmi-codec: fix missing report for jack initial status

Ricardo Rivera-Matos (3):
      ASoC: cs35l45: Use modern pm_ops
      ASoC: cs35l45: Prevent IRQ handling when suspending/resuming
      ASoC: cs35l45: Prevents spinning during runtime suspend

Richard Fitzgerald (1):
      ASoC: Intel: soc-acpi-intel-mtl-match: Change CS35L56 prefixes to AMPn

Shengjiu Wang (1):
      ASoC: fsl_sai: Fix channel swap issue on i.MX8MP

Stefan Binding (9):
      ALSA: hda: cs35l41: Add config table to support many laptops without _DSD
      ALSA: hda: cs35l41: Support additional ASUS ROG 2023 models
      ALSA: hda/realtek: Add quirks for ASUS ROG 2023 models
      ALSA: hda: cs35l41: Support additional ASUS Zenbook 2022 Models
      ALSA: hda/realtek: Add quirks for ASUS Zenbook 2022 Models
      ALSA: hda: cs35l41: Support additional ASUS Zenbook 2023 Models
      ALSA: hda/realtek: Add quirks for ASUS Zenbook 2023 Models
      ALSA: hda: cs35l41: Do not allow uninitialised variables to be freed
      ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel

---
 sound/pci/hda/cs35l41_hda.c                       |   2 +
 sound/pci/hda/cs35l41_hda.h                       |   5 +-
 sound/pci/hda/cs35l41_hda_property.c              | 365 +++++++++++++++++++---
 sound/pci/hda/patch_realtek.c                     |  38 ++-
 sound/pci/hda/tas2781_hda_i2c.c                   |   4 +
 sound/soc/codecs/cs35l45-i2c.c                    |   2 +-
 sound/soc/codecs/cs35l45-spi.c                    |   2 +-
 sound/soc/codecs/cs35l45.c                        |  56 +++-
 sound/soc/codecs/cs42l43-jack.c                   |  21 +-
 sound/soc/codecs/hdmi-codec.c                     |  12 +-
 sound/soc/codecs/tas2781-fmwlib.c                 |  14 +-
 sound/soc/fsl/fsl_sai.c                           |   3 +
 sound/soc/intel/boards/bytcr_rt5640.c             |  31 +-
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c |   8 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c            |   3 -
 sound/usb/quirks.c                                |   4 +-
 tools/testing/selftests/alsa/mixer-test.c         |   2 +-
 17 files changed, 477 insertions(+), 95 deletions(-)



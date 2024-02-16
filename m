Return-Path: <linux-kernel+bounces-68716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC6857EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EDB1F24C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301812C811;
	Fri, 16 Feb 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ndmrASdB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo7+ion/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ndmrASdB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo7+ion/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8712CDAE;
	Fri, 16 Feb 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092672; cv=none; b=pbxGMTRXpoNtqPIyCPnOhAVQQdzwC8DSdywcEvUX0K3iijnaro4X75a9QMPszpOUJJvWrop7q8coV9xSsczskzWZajJ8QQMzMoZYJZvpvw0si9Fr4N5FKQgaEGwkTH6qCsLdedps7TX9VAEwjrlmJnvN5OJJkvRkRG4xhIPjzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092672; c=relaxed/simple;
	bh=6Nyr2kbTtr1bWhf81Y2lUy3CqpGOK5m1z3OI16vJqBc=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=M+cku00Z1WE5DLwR23qtsTlhVtKY9GncG1eYclk0uE6Ul2Ny04hnsl6fcqUkJXeOn7dObaAzu2+k50Unvn6QwpZyhay33w7BioZb01KWNbuOKUAGumblMk3cCISC7Y0fuvBe/CTgtMQNzRHzUwHi002vHg5UkpXmTEgXM/Oisbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ndmrASdB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo7+ion/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ndmrASdB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo7+ion/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 714442224A;
	Fri, 16 Feb 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708092651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Je0Y3u5LRIHMiq2lpHu5CgF/QTNe6B2n02BcT0xjC3M=;
	b=ndmrASdB76ewEhbEuUBU0u9Kx9ph53WMwDa+y3dAc18kExjj1K3InQDvw3mzEcCcK2FBM+
	87isl7XW+cr+FTHETml6JAQ3ubswksRZfUOIbLixIcQioMF/siGP7ZbKtFBRP2im4kBiA/
	GU29HYCn+oCTxm3Ff/tYrIbT8gnzvA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708092651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Je0Y3u5LRIHMiq2lpHu5CgF/QTNe6B2n02BcT0xjC3M=;
	b=Qo7+ion/zV+GZoHHfz8BXsiyrFRksE1HcSGroLfRMBwAD4kh4C8WqVs6zEFlNUzCYeJ8Ht
	UM0C0z8A58C9Z0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708092651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Je0Y3u5LRIHMiq2lpHu5CgF/QTNe6B2n02BcT0xjC3M=;
	b=ndmrASdB76ewEhbEuUBU0u9Kx9ph53WMwDa+y3dAc18kExjj1K3InQDvw3mzEcCcK2FBM+
	87isl7XW+cr+FTHETml6JAQ3ubswksRZfUOIbLixIcQioMF/siGP7ZbKtFBRP2im4kBiA/
	GU29HYCn+oCTxm3Ff/tYrIbT8gnzvA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708092651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Je0Y3u5LRIHMiq2lpHu5CgF/QTNe6B2n02BcT0xjC3M=;
	b=Qo7+ion/zV+GZoHHfz8BXsiyrFRksE1HcSGroLfRMBwAD4kh4C8WqVs6zEFlNUzCYeJ8Ht
	UM0C0z8A58C9Z0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B50D13A39;
	Fri, 16 Feb 2024 14:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wdl+DOtsz2VdMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Feb 2024 14:10:51 +0000
Date: Fri, 16 Feb 2024 15:10:50 +0100
Message-ID: <875xyoijo5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.8-rc5
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ndmrASdB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Qo7+ion/"
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 714442224A
X-Spam-Level: 
X-Spam-Score: -2.31
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.8-rc5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc5

The topmost commit is 41c25e193b2befc22462aa41591d397fab174ca1

----------------------------------------------------------------

sound fixes for 6.8-rc5

A collection of device-specific fixes.  It became a bit bigger
than wished, but all look reasonably small and safe to apply.

- A few Cirrus Logic CS35L56 and CS42L43 driver fixes
- ASoC SOF fixes and workarounds
- Various ASoC Intel fixes
- Lots of HD-, USB-audio and AMD ACP quirks

----------------------------------------------------------------

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix dynamic port assignment when TDM is set

Arnd Bergmann (1):
      ASoC: q6dsp: fix event handler prototype

Attila Tőkés (1):
      ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix pci_probe() error path

Charles Keepax (2):
      ASoC: cs42l43: Handle error from devm_pm_runtime_enable
      ASoC: cs42l43: Add system suspend ops to disable IRQ

Cristian Ciocaltea (1):
      ASoC: SOF: amd: Fix locking in ACP IRQ handler

Curtis Malainey (1):
      ASoC: SOF: IPC3: fix message bounds on ipc ops

Dan Carpenter (1):
      ASoC: cs35l56: fix reversed if statement in cs35l56_dspwait_asp1tx_put()

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt645

Gergo Koteles (1):
      ASoC: tas2781: add module parameter to tascodec_init()

Hans de Goede (4):
      ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards
      ASoC: Intel: cht_bsw_rt5645: Cleanup codec_name handling
      ASoC: rt5645: Make LattePanda board DMI match more precise
      ASoC: rt5645: Add DMI quirk for inverted jack-detect on MeeGoPad T8

Jean-Loïc Charroud (3):
      ALSA: hda/realtek: cs35l41: Add internal speaker support for ASUS UM3402 with missing DSD
      ALSA: hda/realtek: cs35l41: Fix device ID / model name
      ALSA: hda/realtek: cs35l41: Fix order and duplicates in quirks table

Jeffrey Hugo (1):
      ASoC: dt-bindings: google,sc7280-herobrine: Drop bouncing @codeaurora

Lukas Bulwahn (1):
      ALSA: hda/cs35l56: select intended config FW_CS_DSP

Mario Limonciello (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8

Peter Ujfalusi (3):
      ASoC: SOF: Intel: pci-tgl: Change the default paths and firmware names
      ASoC: SOF: Intel: pci-lnl: Change the topology path to intel/sof-ipc4-tplg
      ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend

Ranjani Sridharan (1):
      ASoC: SOF: ipc3-topology: Fix pipeline tear down logic

Richard Fitzgerald (3):
      ASoC: cs35l56: Fix deadlock in ASP1 mixer register initialization
      ASoC: cs35l56: Remove default from IRQ1_CFG register
      ASoC: cs35l56: Workaround for ACPI with broken spk-id-gpios property

Shuming Fan (1):
      ALSA: hda/realtek: add IDs for Dell dual spk platform

Takashi Iwai (1):
      ALSA: usb-audio: More relaxed check of MIDI jack names

Tomasz Kudela (1):
      ALSA: hda: Add Lenovo Legion 7i gen7 sound quirk

bo liu (1):
      ALSA: hda/conexant: Add quirk for SWS JS201D

---
 .../bindings/sound/google,sc7280-herobrine.yaml    |   1 -
 include/sound/tas2781.h                            |   1 +
 sound/pci/hda/Kconfig                              |   4 +-
 sound/pci/hda/cs35l41_hda_property.c               |   4 +
 sound/pci/hda/patch_conexant.c                     |  18 ++
 sound/pci/hda/patch_realtek.c                      |  12 +-
 sound/pci/hda/tas2781_hda_i2c.c                    |   2 +-
 sound/soc/amd/yc/acp6x-mach.c                      |  14 ++
 sound/soc/codecs/cs35l56-shared.c                  |   1 -
 sound/soc/codecs/cs35l56.c                         | 252 ++++++++++++++-------
 sound/soc/codecs/cs35l56.h                         |   2 +-
 sound/soc/codecs/cs42l43.c                         |  48 +++-
 sound/soc/codecs/rt5645.c                          |  26 +++
 sound/soc/codecs/tas2781-comlib.c                  |   3 +-
 sound/soc/codecs/tas2781-i2c.c                     |   2 +-
 sound/soc/intel/avs/core.c                         |   3 +
 sound/soc/intel/avs/topology.c                     |   2 +-
 sound/soc/intel/boards/bytcht_cx2072x.c            |   3 +-
 sound/soc/intel/boards/bytcht_da7213.c             |   3 +-
 sound/soc/intel/boards/bytcht_es8316.c             |   3 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   3 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |   3 +-
 sound/soc/intel/boards/bytcr_wm5102.c              |   3 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   7 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   3 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |   8 +-
 sound/soc/sof/amd/acp-ipc.c                        |   2 +
 sound/soc/sof/amd/acp.c                            |  17 +-
 sound/soc/sof/intel/pci-lnl.c                      |   2 +-
 sound/soc/sof/intel/pci-tgl.c                      |  64 +++---
 sound/soc/sof/ipc3-topology.c                      |  69 ++++--
 sound/soc/sof/ipc3.c                               |   2 +-
 sound/soc/sof/ipc4-pcm.c                           |  13 +-
 sound/usb/midi.c                                   |  77 +++----
 34 files changed, 447 insertions(+), 230 deletions(-)



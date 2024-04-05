Return-Path: <linux-kernel+bounces-132842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EDD899B0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEF31C21271
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A41715FD01;
	Fri,  5 Apr 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="btdwcYdE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="deR1eZtU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VGMQE6cD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vMLivAGh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9914F9D3;
	Fri,  5 Apr 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313723; cv=none; b=BPNj6yT4smgi+skm3NevYeyZBEJeSfbjNTtMY7wB/fsM0Bx7Qp5hVURscd3TRAfmTrHXKADUBmCUK9p3/MNyESPoI8lE8gGHdlAFi7XMIfe4AvSZP17s5TszfYgOEnwwYcqcMuxAInOHZJi9wgOxhajzdq4K3ydJjxd8XuZ1qjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313723; c=relaxed/simple;
	bh=vx9SJcUn2kxr8XQd05GyfiX5qgYQbuAD49fMDEkX93s=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=dm0ToW506I1HxvXwV7mnbX+qNSA9QLrQboIYTc2rHWSg4xhpr24uln/D7JJ3QQLm/873kyTth0jvu9YUoRyxykfNIvp78KzDFLKO1j5OaPJQScvx8VUvHyUnhzLGHM2uMJMALpYJFop4+3M6uloqpXCA7KtbOaTD1uAJpMwyU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=btdwcYdE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=deR1eZtU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VGMQE6cD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vMLivAGh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBBE51F78A;
	Fri,  5 Apr 2024 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712313719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R4rA7RpaH5pH3UUltOy7FhpMqxHru1qmiIGu6FlyYXk=;
	b=btdwcYdEwhA4HfcIC+X3QhGU5QkxBeuadwLuI2tkq+Gh5KmUMLs/gt5alDZUZmrFXdXbVU
	vqVeUlYJy0+nAsqwdF8ve8GClKH8hQprkaov6jed9CyKVyvkl9ZoksFauKf3kbQTx28jvG
	2zrjyt+UBEHczrxTX7AVK2r4Nf4/kQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712313719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R4rA7RpaH5pH3UUltOy7FhpMqxHru1qmiIGu6FlyYXk=;
	b=deR1eZtUYW78irhIDZMTvQ1pT22oF0PGASq2b0udpTdIUODylE4KzaGO3uoKHTX3eRSmi/
	YMXBlPJdsdq7HjAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712313718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R4rA7RpaH5pH3UUltOy7FhpMqxHru1qmiIGu6FlyYXk=;
	b=VGMQE6cDReShAf3H3IHhwBGam9n9WU3vpnIcNL68klOmfuGgXZ4r8B0/9BF7Gu0vJEpGzY
	HUSYNJWQKw36oPfwsC3nS3MKdFoU05EvkRlpVp1eaZZxwIRuq1OrqswmY7weTStGcrky6z
	UAGwgnqKcXmbG//vkJdPRUPiMl2PQRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712313718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R4rA7RpaH5pH3UUltOy7FhpMqxHru1qmiIGu6FlyYXk=;
	b=vMLivAGhBaF7jq5X6Jp2Znh0fsc+CytbpQyY0yInc9HSS9V9ir0KvnAHKgzQAxU3+DtDag
	TChByfXObP+gJdBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 86A3C139E8;
	Fri,  5 Apr 2024 10:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id anAIH3bVD2YscgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Fri, 05 Apr 2024 10:41:58 +0000
Date: Fri, 05 Apr 2024 12:42:03 +0200
Message-ID: <87v84wm6pw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.9-rc3
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]

Linus,

please pull sound fixes for v6.9-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc3

The topmost commit is 100c85421b52e41269ada88f7d71a6b8a06c7a11

----------------------------------------------------------------

sound fixes for 6.9-rc3

This became a bit bigger collection of patches, but almost all are
about device-specific fixes, and should be safe for 6.9.

- Lots of ASoC Intel SOF-related fixes/updates
- Locking fixes in SoundWire drivers
- ASoC AMD ACP/SOF updates
- ASoC ES8326 codec fixes
- HD-audio codec fixes and quirks
- A regression fix in emu10k1 synth code

----------------------------------------------------------------

Amadeusz S³awiñski (1):
      ASoC: Intel: avs: boards: Add modules description

Chaitanya Kumar Borah (1):
      ASoC: SOF: Core: Add remove_late() to sof_init_environment failure path

Charles Keepax (1):
      ASoC: cs42l43: Correct extraction of data pointer in suspend/resume

Christian Bendiksen (1):
      ALSA: hda/realtek: Add sound quirks for Lenovo Legion slim 7 16ARHA7 models

Christoffer Sandberg (1):
      ALSA: hda/realtek - Fix inactive headset mic jack

Gergo Koteles (1):
      ASoC: tas2781: mark dvc_tlv with __maybe_unused

I Gede Agastya Darma Laksana (1):
      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Luke D. Jones (1):
      ALSA: hda/realtek: cs35l41: Support ASUS ROG G634JYR

Oswald Buddenhagen (1):
      Revert "ALSA: emu10k1: fix synthesizer sample playback position and caching"

Peter Ujfalusi (19):
      ASoC: SOF: Add dsp_max_burst_size_in_ms member to snd_sof_pcm_stream
      ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs
      ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint
      ASoC: SOF: Intel: hda: Implement get_stream_position (Linear Link Position)
      ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position callback
      ASoC: SOF: Introduce a new callback pair to be used for PCM delay reporting
      ASoC: SOF: Intel: Set the dai/host get frame/byte counter callbacks
      ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter() for pcm_delay
      ASoC: SOF: Intel: hda-common-ops: Do not set the get_stream_position callback
      ASoC: SOF: Remove the get_stream_position callback
      ASoC: SOF: ipc4-pcm: Move struct sof_ipc4_timestamp_info definition locally
      ASoC: SOF: ipc4-pcm: Combine the SOF_IPC4_PIPE_PAUSED cases in pcm_trigger
      ASoC: SOF: ipc4-pcm: Invalidate the stream_start_offset in PAUSED state
      ASoC: SOF: sof-pcm: Add pointer callback to sof_ipc_pcm_ops
      ASoC: SOF: ipc4-pcm: Correct the delay calculation
      ALSA: hda: Add pplcllpl/u members to hdac_ext_stream
      ASoC: SOF: Intel: hda: Compensate LLP in case it is not reset
      ASoC: SOF: Intel: hda-dsp: Skip IMR boot on ACE platforms in case of S3 suspend
      ASoC: SOF: Intel: lnl: Disable DMIC/SSP offload on remove

Pierre-Louis Bossart (6):
      ASoC: rt5682-sdw: fix locking sequence
      ASoC: rt711-sdca: fix locking sequence
      ASoC: rt711-sdw: fix locking sequence
      ASoC: rt712-sdca-sdw: fix locking sequence
      ASoC: rt722-sdca-sdw: fix locking sequence
      ASoC: rt-sdw*: add __func__ to all error logs

Rander Wang (1):
      ASoC: SOF: mtrace: rework mtrace timestamp setting

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()

Simon Trimmer (3):
      ASoC: cs-amp-lib: Check for no firmware controls when writing calibration
      ALSA: hda: cs35l56: Add ACPI device match tables
      ALSA: hda/realtek: Add quirks for ASUS Laptops using CS35L56

Stephen Lee (1):
      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Takashi Iwai (1):
      ALSA: line6: Zero-initialize message buffers

Uwe Kleine-König (1):
      OSS: dmasound/paula: Mark driver struct with __refdata to prevent section mismatch

Vijendar Mukunda (3):
      ASoC: amd: acp: fix for acp pdm configuration check
      ASoC: amd: acp: fix for acp_init function error handling
      ASoC: SOF: amd: fix for false dsp interrupts

Zhang Yi (4):
      ASoC: codecs: ES8326: Solve error interruption issue
      ASoC: codecs: ES8326: modify clock table
      ASoC: codecs: ES8326: Solve a headphone detection issue after suspend and resume
      ASoC: codecs: ES8326: Removing the control of ADC_SCALE

---
 include/sound/hdaudio_ext.h            |   3 +
 include/sound/tas2781-tlv.h            |   2 +-
 sound/oss/dmasound/dmasound_paula.c    |   8 +-
 sound/pci/emu10k1/emu10k1_callback.c   |   7 +-
 sound/pci/hda/cs35l41_hda_property.c   |   6 +
 sound/pci/hda/cs35l56_hda_i2c.c        |  13 ++-
 sound/pci/hda/cs35l56_hda_spi.c        |  13 ++-
 sound/pci/hda/patch_realtek.c          |  60 +++++++++-
 sound/soc/amd/acp/acp-pci.c            |  13 ++-
 sound/soc/codecs/cs-amp-lib.c          |   5 +
 sound/soc/codecs/cs42l43.c             |  12 +-
 sound/soc/codecs/es8326.c              |  37 ++++---
 sound/soc/codecs/es8326.h              |   2 +-
 sound/soc/codecs/rt1316-sdw.c          |   8 +-
 sound/soc/codecs/rt1318-sdw.c          |   8 +-
 sound/soc/codecs/rt5682-sdw.c          |  16 +--
 sound/soc/codecs/rt700.c               |  16 +--
 sound/soc/codecs/rt711-sdca-sdw.c      |   6 +-
 sound/soc/codecs/rt711-sdca.c          |  18 +--
 sound/soc/codecs/rt711-sdw.c           |   8 +-
 sound/soc/codecs/rt711.c               |  16 +--
 sound/soc/codecs/rt712-sdca-dmic.c     |  24 ++--
 sound/soc/codecs/rt712-sdca-sdw.c      |   7 +-
 sound/soc/codecs/rt712-sdca.c          |  20 ++--
 sound/soc/codecs/rt715-sdca-sdw.c      |   2 +-
 sound/soc/codecs/rt715-sdca.c          |  46 ++++----
 sound/soc/codecs/rt715-sdw.c           |   4 +-
 sound/soc/codecs/rt715.c               |  24 ++--
 sound/soc/codecs/rt722-sdca-sdw.c      |   4 +-
 sound/soc/codecs/rt722-sdca.c          |  21 ++--
 sound/soc/codecs/wm_adsp.c             |   3 +-
 sound/soc/intel/avs/boards/da7219.c    |   1 +
 sound/soc/intel/avs/boards/dmic.c      |   1 +
 sound/soc/intel/avs/boards/es8336.c    |   1 +
 sound/soc/intel/avs/boards/i2s_test.c  |   1 +
 sound/soc/intel/avs/boards/max98357a.c |   1 +
 sound/soc/intel/avs/boards/max98373.c  |   1 +
 sound/soc/intel/avs/boards/max98927.c  |   1 +
 sound/soc/intel/avs/boards/nau8825.c   |   1 +
 sound/soc/intel/avs/boards/probe.c     |   1 +
 sound/soc/intel/avs/boards/rt274.c     |   1 +
 sound/soc/intel/avs/boards/rt286.c     |   1 +
 sound/soc/intel/avs/boards/rt298.c     |   1 +
 sound/soc/intel/avs/boards/rt5514.c    |   1 +
 sound/soc/intel/avs/boards/rt5663.c    |   1 +
 sound/soc/intel/avs/boards/rt5682.c    |   1 +
 sound/soc/intel/avs/boards/ssm4567.c   |   1 +
 sound/soc/soc-ops.c                    |   2 +-
 sound/soc/sof/amd/acp.c                |   8 +-
 sound/soc/sof/core.c                   |  14 ++-
 sound/soc/sof/intel/hda-common-ops.c   |   3 +
 sound/soc/sof/intel/hda-dai-ops.c      |  11 ++
 sound/soc/sof/intel/hda-dsp.c          |  20 +++-
 sound/soc/sof/intel/hda-pcm.c          |  29 +++++
 sound/soc/sof/intel/hda-stream.c       |  70 ++++++++++++
 sound/soc/sof/intel/hda.h              |   6 +
 sound/soc/sof/intel/lnl.c              |  34 ++++--
 sound/soc/sof/intel/mtl.c              |  14 ---
 sound/soc/sof/intel/mtl.h              |  10 --
 sound/soc/sof/ipc4-mtrace.c            |  11 +-
 sound/soc/sof/ipc4-pcm.c               | 193 ++++++++++++++++++++++++++-------
 sound/soc/sof/ipc4-priv.h              |  14 ---
 sound/soc/sof/ipc4-topology.c          |  22 +++-
 sound/soc/sof/ops.h                    |  24 +++-
 sound/soc/sof/pcm.c                    |   8 ++
 sound/soc/sof/sof-audio.h              |   9 +-
 sound/soc/sof/sof-priv.h               |  24 +++-
 sound/usb/line6/driver.c               |   6 +-
 68 files changed, 695 insertions(+), 285 deletions(-)



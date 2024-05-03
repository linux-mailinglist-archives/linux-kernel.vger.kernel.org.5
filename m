Return-Path: <linux-kernel+bounces-167382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503D8BA8BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CA41F22AFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E14149C57;
	Fri,  3 May 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gt2/CZj2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UyLpMJIf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gt2/CZj2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UyLpMJIf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70C148FEA;
	Fri,  3 May 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724904; cv=none; b=QElzXBCkG1QDO5wkD/k4ZJGho6svXNvSLDJltaFTRVVACrwa3bOHGjzAHctdkIx/cHRgEHCUELgLoDsB7LGuYtrMJ5+egrF55SPjoZELfu9X+btSewr2xPnHgJYDEyvjpj4s/NCsYmfytKwnPgA93c2WES6TQgKgVixxO4adjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724904; c=relaxed/simple;
	bh=Xaz/e0SDPcyiqESy32W44FFRd0uvgAjWmvtsu44aftE=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=hDzDWMlQMyM29991qHodpYwPnDX3PMvv9gVtzY2JbV85L9/K1lWNxqJpSrdPv+WU6jeT388BVzUyNJF+0gozOL7nrvbHeRWY5VErRdtcSxbysoY3iszdCVCkq/tcHChilL8V6T9gxsOsa5RnNpHuqk4haaMfz1uQNS9x1Ofu/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gt2/CZj2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UyLpMJIf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gt2/CZj2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UyLpMJIf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 876201FEF2;
	Fri,  3 May 2024 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714724899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=17c6zPQSHaQHAyr87PcNMLXzI5ceMlsPO6xumZ53h28=;
	b=Gt2/CZj2YvUWAzUSuN20M6rTSbI4yFVIfCYmlFkk/0ZxoFcyT41Z3jIFJoCf+WvHyPeazj
	mbeIGlkEec9+ywlx6oiE88MFBwHn5XWWCFBdOwgKRbAAXdWBXwQwN2repMsw+hLnUVzERd
	cjvVQRbRUUlW/B/uL+H0lNQK/87vN/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714724899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=17c6zPQSHaQHAyr87PcNMLXzI5ceMlsPO6xumZ53h28=;
	b=UyLpMJIfzQIxbkZUUcI13mGZKbRv8+gBfOIKU0NRpxmoggSNNtkWCWMGF9vorulKkgXg98
	hBN+6lMUQr4GV2Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Gt2/CZj2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UyLpMJIf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714724899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=17c6zPQSHaQHAyr87PcNMLXzI5ceMlsPO6xumZ53h28=;
	b=Gt2/CZj2YvUWAzUSuN20M6rTSbI4yFVIfCYmlFkk/0ZxoFcyT41Z3jIFJoCf+WvHyPeazj
	mbeIGlkEec9+ywlx6oiE88MFBwHn5XWWCFBdOwgKRbAAXdWBXwQwN2repMsw+hLnUVzERd
	cjvVQRbRUUlW/B/uL+H0lNQK/87vN/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714724899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=17c6zPQSHaQHAyr87PcNMLXzI5ceMlsPO6xumZ53h28=;
	b=UyLpMJIfzQIxbkZUUcI13mGZKbRv8+gBfOIKU0NRpxmoggSNNtkWCWMGF9vorulKkgXg98
	hBN+6lMUQr4GV2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E98C13991;
	Fri,  3 May 2024 08:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UQ/kFSOgNGaCHAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 May 2024 08:28:19 +0000
Date: Fri, 03 May 2024 10:28:32 +0200
Message-ID: <87y18rguz3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.9-rc7
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 876201FEF2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

Linus,

please pull sound fixes for v6.9-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc7

The topmost commit is fdb3f29dfe0d51bdb8e7b3a6d876ea8339d44df8

----------------------------------------------------------------

sound fixes for 6.9-rc7

As usual in a late stage, we received a fair amount of fixes for ASoC,
and it became bigger than wished.  But all fixes are rather device-
specific, and they look pretty safe to apply.

A major par of changes are series of fixes for ASoC meson and SOF
drivers as well as for Realtek and Cirrus codecs.  In addition,
recent emu10k1 regression fixes and usual HD-audio quirks are
included.

----------------------------------------------------------------

Amadeusz S³awiñski (1):
      ASoC: Intel: avs: Set name of control as in topology

Aman Dhoot (1):
      ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix debug window description

Derek Fang (2):
      ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
      ASoC: dt-bindings: rt5645: add cbj sleeve gpio property

Hans de Goede (1):
      ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM too

Jack Yu (4):
      ASoC: rt722-sdca: modify channel number to support 4 channels
      ASoC: rt722-sdca: add headset microphone vrefo setting
      ASoC: rt715: add vendor clear control register
      ASoC: rt715-sdca: volume step modification

Jerome Brunet (5):
      ASoC: meson: axg-fifo: use threaded irq to check periods
      ASoC: meson: axg-card: make links nonatomic
      ASoC: meson: axg-tdm-interface: manage formatters in trigger
      ASoC: meson: axg-tdm: add continuous clock support
      ASoC: meson: cards: select SND_DYNAMIC_MINORS

Joao Paulo Goncalves (1):
      ASoC: ti: davinci-mcasp: Fix race condition during probe

Kailang Yang (1):
      ALSA: hda/realtek - Set GPIO3 to default at S4 state for Thinkpad with ALC1318

Oswald Buddenhagen (6):
      ALSA: emu10k1: fix E-MU card dock presence monitoring
      ALSA: emu10k1: factor out snd_emu1010_load_dock_firmware()
      ALSA: emu10k1: move the whole GPIO event handling to the workqueue
      ALSA: emu10k1: use mutex for E-MU FPGA access locking
      ALSA: emu10k1: fix E-MU dock initialization
      ALSA: emu10k1: make E-MU FPGA writes potentially more reliable

Peter Ujfalusi (5):
      ASoC: SOF: ipc4-pcm: Use consistent name for snd_sof_pcm_stream pointer
      ASoC: SOF: ipc4-pcm: Use consistent name for sof_ipc4_timestamp_info pointer
      ASoC: SOF: ipc4-pcm: Introduce generic sof_ipc4_pcm_stream_priv
      ASoC: SOF: ipc4-pcm: Do not reset the ChainDMA if it has not been allocated
      ASoC: SOF: Core: Handle error returned by sof_select_ipc_and_paths

Pierre-Louis Bossart (6):
      ASoC: SOF: Intel: add default firmware library path for LNL
      ASoC: SOF: debug: show firmware/topology prefix/names
      ASoC: da7219-aad: fix usage of device_get_named_child_node()
      ASoC: cs35l56: fix usages of device_get_named_child_node()
      ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection
      ALSA: hda: intel-sdw-acpi: fix usage of device_get_named_child_node()

Ranjani Sridharan (1):
      ASoC: SOF: pcm: Restrict DSP D0i3 during S0ix to IPC3

Richard Fitzgerald (4):
      regmap: Add regmap_read_bypassed()
      ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_boot()
      ASoC: cs35l56: Fix unintended bus access while resetting amp
      ASoC: cs35l56: Prevent overwriting firmware ASP config

Sameer Pujar (1):
      ASoC: tegra: Fix DSPK 16-bit playback

Simon Trimmer (1):
      ASoC: cs35l56: Avoid static analysis warning of uninitialised variable

Srinivas Kandagatla (1):
      ASoC: codecs: wsa881x: set clk_stop_mode1 flag

Stefan Binding (1):
      ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config

Takashi Iwai (2):
      ALSA: hda/realtek: Fix conflicting PCI SSID 17aa:386f for Lenovo Legion models
      ALSA: hda/realtek: Fix build error without CONFIG_PM

end.to.start (1):
      ASoC: acp: Support microphone from device Acer 315-24p

---
 Documentation/devicetree/bindings/sound/rt5645.txt |   6 +
 drivers/base/regmap/regmap.c                       |  37 +++++
 include/linux/regmap.h                             |   8 ++
 include/sound/cs35l56.h                            |   2 +
 include/sound/emu10k1.h                            |   7 +-
 sound/hda/intel-dsp-config.c                       |  27 +++-
 sound/hda/intel-sdw-acpi.c                         |   2 +
 sound/pci/emu10k1/emu10k1.c                        |   3 +-
 sound/pci/emu10k1/emu10k1_main.c                   | 158 ++++++++++++---------
 sound/pci/emu10k1/emumixer.c                       |  18 ++-
 sound/pci/emu10k1/emuproc.c                        |   9 ++
 sound/pci/emu10k1/io.c                             |  51 +++----
 sound/pci/hda/cs35l56_hda.c                        |   4 +
 sound/pci/hda/patch_realtek.c                      |  78 +++++++++-
 sound/soc/amd/yc/acp6x-mach.c                      |   7 +
 sound/soc/codecs/cs35l41.c                         |  28 +++-
 sound/soc/codecs/cs35l56-sdw.c                     |   2 -
 sound/soc/codecs/cs35l56-shared.c                  |  85 +++++++----
 sound/soc/codecs/cs35l56.c                         |  39 ++++-
 sound/soc/codecs/da7219-aad.c                      |   6 +-
 sound/soc/codecs/rt5645.c                          |  25 ++++
 sound/soc/codecs/rt715-sdca.c                      |   8 +-
 sound/soc/codecs/rt715-sdw.c                       |   1 +
 sound/soc/codecs/rt722-sdca.c                      |  27 +++-
 sound/soc/codecs/rt722-sdca.h                      |   3 +
 sound/soc/codecs/wsa881x.c                         |   1 +
 sound/soc/intel/avs/icl.c                          |   2 +-
 sound/soc/intel/avs/topology.c                     |   2 +
 sound/soc/intel/boards/bytcr_rt5640.c              |  24 ++--
 sound/soc/meson/Kconfig                            |   1 +
 sound/soc/meson/axg-card.c                         |   1 +
 sound/soc/meson/axg-fifo.c                         |  31 ++--
 sound/soc/meson/axg-tdm-formatter.c                |  40 ++++++
 sound/soc/meson/axg-tdm-interface.c                |  38 +++--
 sound/soc/meson/axg-tdm.h                          |   5 +
 sound/soc/sof/core.c                               |   4 +-
 sound/soc/sof/debug.c                              |  18 +++
 sound/soc/sof/intel/pci-lnl.c                      |   3 +
 sound/soc/sof/ipc3-pcm.c                           |   1 +
 sound/soc/sof/ipc4-pcm.c                           | 121 +++++++++++-----
 sound/soc/sof/pcm.c                                |  13 +-
 sound/soc/sof/sof-audio.h                          |   2 +
 sound/soc/tegra/tegra186_dspk.c                    |   7 +-
 sound/soc/ti/davinci-mcasp.c                       |  12 +-
 44 files changed, 715 insertions(+), 252 deletions(-)



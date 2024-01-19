Return-Path: <linux-kernel+bounces-31352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8B832CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D754B222F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0654F99;
	Fri, 19 Jan 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z9jYM9sE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DHlg99wG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1KKtT2jX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bmYrSuuO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421C54BE3;
	Fri, 19 Jan 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681080; cv=none; b=EoaLIURQDe5QSVjA5JIDy3C2MxulT4vgextsG4mECPyc/3xGyfc3Ec5VHtPUiD62USWbVLmt37KIK1pD1CUygNxQhrt6okMvH5XfOW5U2b8eUdeXiRkrkKNVihjXTuVicYVtFRZ29Wpx9RTDcFdDaDmQDeXK4F6UWwMx/G4jogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681080; c=relaxed/simple;
	bh=lPPXDt+XvoN6YBh8qHhnZqlV9+3Kqzv4OYpbBiFulr8=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=D1FvECUUpX7fQIDzuUquD8KMNk0yriBdPZOTOa74pW+dpYzKgkaZ+sFCmWrG+optNad7bu9NI/+94fR/4aON8ZgO48aOdxkfTmmEOdsy+fYbhuq+OT5UTepG8GP+xjC/V2R53dwjGx0dJ63vwNn/IygaozVJNEDxD23abqlHlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z9jYM9sE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DHlg99wG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1KKtT2jX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bmYrSuuO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A58A91FD15;
	Fri, 19 Jan 2024 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705681076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CP2uValOwWCAjeFRvYWAW6amhd5cd0jqCsima+LQWHA=;
	b=Z9jYM9sEwC8NnxC1Y7RlVqKpUJ85lv11QlK04sOxZbsXFLPJdcyBmjedWPWtwQsGQPE8kK
	YA1vOzI3l9Q+c9v6eeXij7rjA4nzMpRp6hPpeWdctATL07y3dF6616kVXRtC7y3ePztBAO
	Qw/bTGPf31AhIJ9hpPnUH6mCaY6frng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705681076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CP2uValOwWCAjeFRvYWAW6amhd5cd0jqCsima+LQWHA=;
	b=DHlg99wGOdciqTLupx/BLRbD6WF7/PAKbQ66rr2pyG5W4aLIXxawegsBc0Ps9iA2ZLkHkJ
	6esHcdE5BW36oMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705681075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CP2uValOwWCAjeFRvYWAW6amhd5cd0jqCsima+LQWHA=;
	b=1KKtT2jXaq45AJYVdez6FOU5AivLF1Lryzi5CfaLCpN8oEEz/DC7e8LOD4EMtQ9bNMx+3M
	wI9NzBfvehCAo3n++zf9gsUQzUlOzKkwbitMsDcCLonHr4UER5DJ+rtbqw5IR8iRz/JrE+
	+vK1QsTWp9l5HUO9RYNlnZrpNyyXtPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705681075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CP2uValOwWCAjeFRvYWAW6amhd5cd0jqCsima+LQWHA=;
	b=bmYrSuuO5+eAh1qyU1YU7+c7WConmWYvwZX3eacx6ooc6x87skSpYTH2fr61vHIgVCVLZv
	fRl18ZvueFhzM7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74DB81388C;
	Fri, 19 Jan 2024 16:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hBEBG7OgqmWoVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Jan 2024 16:17:55 +0000
Date: Fri, 19 Jan 2024 17:17:55 +0100
Message-ID: <875xzps3f0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.8-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1KKtT2jX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bmYrSuuO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: A58A91FD15
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.8-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.8-rc1

The topmost commit is fb3c007fde80d9d3b4207943e74c150c9116cead

----------------------------------------------------------------

sound fixes for 6.8-rc1

A collection of small fixes:
- Lots of ASoC SOF fixes and related reworks
- ASoC TAS codec fixes including DT updates
- A few HD-audio quirks and regression fixes
- Minor fixes for aloop, oxygen and scarlett2 mixer

----------------------------------------------------------------

Amadeusz Sławiński (1):
      ALSA: hda: Properly setup HDMI stream

AngeloGioacchino Del Regno (2):
      ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link
      ASoC: mediatek: sof-common: Add NULL check for normal_link string

Bin Li (1):
      ALSA: hda/realtek: Enable headset mic on Lenovo M70 Gen5

Chancel Liu (1):
      ALSA: aloop: Introduce a function to get if access is interleaved mode

ChiYuan Huang (2):
      ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
      ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow

Heiner Kallweit (1):
      ALSA: hda: generic: Remove obsolete call to ledtrig_audio_get

Kai Vehmanen (1):
      ASoC: SOF: ipc4-loader: remove the CPC check warnings

Kuninori Morimoto (1):
      ASoC: audio-graph-card2: fix index check on graph_parse_node_multi_nm()

Nícolas F. R. A. Prado (1):
      ASoC: mediatek: mt8192: Check existence of dai_name before dereferencing

Peter Ujfalusi (3):
      ASoC: Intel: bxt_da7219_max98357a: Fix kernel ops due to COMP_DUMMY change
      ASoC: Intel: bxt_rt298: Fix kernel ops due to COMP_DUMMY change
      ASoC: SOF: icp3-dtrace: Revert "Fix wrong kfree() usage"

Rander Wang (1):
      ASoC: SOF: ipc4-pcm: remove log message for LLP

Shenghao Ding (4):
      ASoC: dt-bindings: move tas2563 from tas2562.yaml to tas2781.yaml
      ASoC: tas2562: move tas2563 from tas2562 driver to tas2781 driver
      ASoC: tas2781: Add tas2563 into header file for DSP mode
      ASoC: tas2781: Add tas2563 into driver

Takashi Iwai (2):
      ALSA: oxygen: Fix right channel of capture volume mixer
      ALSA: scarlett2: Fix yet more -Wformat-truncation warnings

Yo-Jung Lin (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on HP ZBook

Çağhan Demir (1):
      ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx

---
 .../devicetree/bindings/sound/tas2562.yaml         |  2 -
 .../devicetree/bindings/sound/ti,tas2781.yaml      | 78 +++++++++++++++++-----
 include/sound/tas2781.h                            |  9 +--
 sound/drivers/aloop.c                              | 23 +++++--
 sound/pci/hda/hda_generic.c                        |  1 -
 sound/pci/hda/patch_hdmi.c                         |  6 ++
 sound/pci/hda/patch_realtek.c                      |  3 +
 sound/pci/oxygen/oxygen_mixer.c                    |  2 +-
 sound/soc/codecs/rtq9128.c                         | 73 +++++++++++---------
 sound/soc/codecs/tas2562.c                         |  3 -
 sound/soc/codecs/tas2781-i2c.c                     |  8 ++-
 sound/soc/generic/audio-graph-card2.c              |  2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  6 ++
 sound/soc/intel/boards/bxt_rt298.c                 |  3 +-
 sound/soc/mediatek/common/mtk-dsp-sof-common.c     |  2 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |  3 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         | 33 +--------
 sound/soc/mediatek/mt8195/mt8195-mt6359.c          | 41 ++++++++----
 sound/soc/sof/ipc3-dtrace.c                        |  3 +-
 sound/soc/sof/ipc4-loader.c                        | 11 ++-
 sound/soc/sof/ipc4-pcm.c                           |  4 +-
 sound/usb/mixer_scarlett2.c                        | 42 ++++++------
 22 files changed, 209 insertions(+), 149 deletions(-)



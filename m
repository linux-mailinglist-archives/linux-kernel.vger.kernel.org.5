Return-Path: <linux-kernel+bounces-49467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71789846AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AB31C212C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E017C7B;
	Fri,  2 Feb 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LD5n153v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tFKbyQ70";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LD5n153v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tFKbyQ70"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96718027;
	Fri,  2 Feb 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862417; cv=none; b=BOUiFFxVIEJ4qdboLQRlq2wYDm5mIayXweiIRQnbYBvJk9XOtvnhrTobGdxVtPOAWRJsbJYzRLAOXmnDOqVdAXjLLO0sVTxv7Ajs2iRxcYC5BBgxg6k8Qgwm/LKeo+66buA+lQlkearMWw9HHx2AYimGjHgWQqrsPywf7rXqJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862417; c=relaxed/simple;
	bh=Q79bl0uT0SEKh/4+xbeE5SIBUEP9hSsP3MQSHgC6Afc=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=qJ0U/z1smwUaktQdu/K5rvjd2JzcTUbTfmRWppl1f4F9krKXcg4hPY7EUqheHZ5YVkCKDzdXks1dH8++3heuN4U03VcEL619mAkgS+JXyEn7TLH55gH/CSNa94TgiuY5al1/zCIYeoO4nts/M2Eufg7bLD3I9hQ0gNeFcaZDWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LD5n153v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tFKbyQ70; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LD5n153v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tFKbyQ70; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4290F2211E;
	Fri,  2 Feb 2024 08:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706862408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tSZTflnXhgQLtHulndXWpjjTjnPwm5EhG1Kf9/DEbJ8=;
	b=LD5n153vOX5+/LIBNIP7TmHU0OlBOTlBnk+I2DY993uJPtiZ3vEhRbjvk6dcOsVkjPzp2H
	LKXnIgCVRibHVrR5WHyInm1yUbbgKBnfAH4AGQjfKxydk+0afWmPQTPE6S299Is+zkVIol
	P55nLjd5d9IhwId2ZQygCGR1zI22aCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706862408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tSZTflnXhgQLtHulndXWpjjTjnPwm5EhG1Kf9/DEbJ8=;
	b=tFKbyQ705FnWeYgD0p9IE2Y49fy6QT2EgZE6RR4/dyxjlUff44FZqTelDxXiDZkdQE3Vi8
	X7ZF2NWFuRdoE/CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706862408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tSZTflnXhgQLtHulndXWpjjTjnPwm5EhG1Kf9/DEbJ8=;
	b=LD5n153vOX5+/LIBNIP7TmHU0OlBOTlBnk+I2DY993uJPtiZ3vEhRbjvk6dcOsVkjPzp2H
	LKXnIgCVRibHVrR5WHyInm1yUbbgKBnfAH4AGQjfKxydk+0afWmPQTPE6S299Is+zkVIol
	P55nLjd5d9IhwId2ZQygCGR1zI22aCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706862408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tSZTflnXhgQLtHulndXWpjjTjnPwm5EhG1Kf9/DEbJ8=;
	b=tFKbyQ705FnWeYgD0p9IE2Y49fy6QT2EgZE6RR4/dyxjlUff44FZqTelDxXiDZkdQE3Vi8
	X7ZF2NWFuRdoE/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D20213A58;
	Fri,  2 Feb 2024 08:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VoYvAUinvGV8PgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Feb 2024 08:26:48 +0000
Date: Fri, 02 Feb 2024 09:26:47 +0100
Message-ID: <875xz7e0fs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.8-rc3
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LD5n153v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tFKbyQ70
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
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
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4290F2211E
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.8-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc3

The topmost commit is d4ea2bd1bb502c54380cc44a4130660494679bb8

----------------------------------------------------------------

sound fixes for 6.8-rc3

A collection of fixes, mostly device-specific ones.

- Minor PCM core fix for name strings
- ASoC Qualcomm fixes, including DAI support extensions
- ASoC AMD platform updates
- ASoC Allwinner platform updates
- Various ASoC codec fixes for WSA, WCD, ES8326 drivers
- Various HD-audio and USB-audio fixes and quirks
- A series of fixes for Cirrus CS35L56 codecs

----------------------------------------------------------------

Alexander Tsoy (6):
      ALSA: usb-audio: Skip setting clock selector for single connections
      ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision
      ALSA: usb-audio: Support read-only clock selector control
      Revert "ALSA: usb-audio: Skip setting clock selector for single connections"
      ALSA: usb-audio: Check presence of valid altsetting control
      ALSA: usb-audio: Ignore clock selector errors for single connection

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power

Chen-Yu Tsai (3):
      ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
      ASoC: sun4i-spdif: Fix requirements for H6
      ASoC: sun4i-spdif: Add Allwinner H616 compatible

Chhayly Leang (1):
      ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR

David Senoner (1):
      ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Fei Shao (1):
      ASoC: codecs: ES8326: Remove executable bit

Ivan Orlov (1):
      ALSA: pcm: Add missing formats to formats list

Jacob Siverskog (1):
      ALSA: usb-audio: fix typo

Johan Hovold (5):
      ASoC: codecs: wsa883x: fix PA volume control
      ASoC: codecs: lpass-wsa-macro: fix compander volume hack
      ASoC: codecs: wcd9335: drop unused gain hack remnant
      ASoC: codecs: wcd938x: fix headphones volume controls
      ASoC: qcom: sc8280xp: limit speaker volumes

José Relvas (1):
      ALSA: hda/realtek: Apply headset jack quirk for non-bass alc287 thinkpads

Julian Sikorski (1):
      ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Kailang Yang (1):
      ALSA: hda/realtek - Add speaker pin verbtable for Dell dual speaker platform

Kenzo Gomez (1):
      ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA

Krzysztof Kozlowski (4):
      ASoC: codecs: wcd938x: handle deferred probe
      ASoC: codecs: wcd938x: skip printing deferred probe failuers
      ASoC: codecs: wcd934x: drop unneeded regulator include
      ASoC: allow up to eight CPU/codec DAIs

Li RongQing (1):
      ALSA: virtio: remove duplicate check if queue is broken

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

Marian Postevca (1):
      ASoC: amd: acp: Fix support for a Huawei Matebook laptop

Richard Fitzgerald (18):
      ASoC: wm_adsp: Fix firmware file search order
      ASoC: wm_adsp: Don't overwrite fwf_name with the default
      ASoC: cs35l56: cs35l56_component_remove() must clear cs35l56->component
      ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp
      ASoC: cs35l56: Don't add the same register patch multiple times
      ASoC: cs35l56: Remove buggy checks from cs35l56_is_fw_reload_needed()
      ASoC: cs35l56: Fix to ensure ASP1 registers match cache
      ASoC: cs35l56: Fix default SDW TX mixer registers
      ALSA: hda: cs35l56: Initialize all ASP1 registers
      ASoC: cs35l56: Fix for initializing ASP1 mixer registers
      ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon revision
      ASoC: cs35l56: Firmware file must match the version of preloaded firmware
      ASoC: cs35l56: Load tunings for the correct speaker models
      ASoC: cs35l56: Allow more time for firmware to boot
      ALSA: hda: cs35l56: Fix order of searching for firmware files
      ALSA: hda: cs35l56: Fix filename string field layout
      ALSA: hda: cs35l56: Firmware file must match the version of preloaded firmware
      ALSA: hda: cs35l56: Remove unused test stub function

Rui Salvaterra (2):
      ALSA: hda: Replace numeric device IDs with constant values
      ALSA: hda: Increase default bdl_pos_adj for Apollo Lake

Sean Young (1):
      ALSA: usb-audio: add quirk for RODE NT-USB+

Takashi Iwai (1):
      ALSA: usb-audio: Sort quirk table entries

Techno Mooney (1):
      ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF

Venkata Prasad Potturu (3):
      ASoC: amd: acp: Enable rt5682s clocks in acp slave mode
      ASoC: amd: acp: Update platform name for different boards
      ASoC: amd: acp: Add check for cpu dai link initialization

Vitaly Rodionov (1):
      ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Zhu Ning (4):
      ASoC: codecs: ES8326: improving crosstalk performance
      ASoC: codecs: ES8326: Improving the THD+N performance
      ASoC: codecs: ES8326: Minimize the pop noise on headphone
      ASoC: codecs: ES8326: fix the capture noise issue

---
 .../bindings/sound/allwinner,sun4i-a10-spdif.yaml  |   5 +-
 include/sound/cs35l56.h                            |   7 +-
 sound/core/pcm.c                                   |   4 +
 sound/pci/hda/cs35l41_hda_property.c               |   4 +
 sound/pci/hda/cs35l56_hda.c                        | 138 +++++----
 sound/pci/hda/hda_intel.c                          |   6 +-
 sound/pci/hda/patch_cs8409.c                       |   1 +
 sound/pci/hda/patch_realtek.c                      |  16 +-
 sound/soc/amd/acp/acp-mach-common.c                |  16 +-
 sound/soc/amd/acp/acp-sof-mach.c                   |   4 +
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c      |   8 +
 sound/soc/amd/yc/acp6x-mach.c                      |   7 +
 sound/soc/codecs/cs35l56-shared.c                  | 140 ++++++++--
 sound/soc/codecs/cs35l56.c                         | 307 +++++++++++++++++----
 sound/soc/codecs/cs35l56.h                         |   2 +
 sound/soc/codecs/es8326.c                          | 186 +++++++++----
 sound/soc/codecs/es8326.h                          |   3 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |   7 -
 sound/soc/codecs/wcd9335.c                         |   4 -
 sound/soc/codecs/wcd934x.c                         |   1 -
 sound/soc/codecs/wcd938x.c                         |   8 +-
 sound/soc/codecs/wm_adsp.c                         |  73 +++--
 sound/soc/codecs/wsa883x.c                         |   6 +-
 sound/soc/qcom/sc8280xp.c                          |  12 +-
 sound/soc/soc-core.c                               |   5 +-
 sound/soc/sunxi/sun4i-spdif.c                      |   5 +
 sound/usb/clock.c                                  |  34 ++-
 sound/usb/format.c                                 |  20 ++
 sound/usb/midi2.c                                  |   2 +-
 sound/usb/quirks.c                                 |  38 +--
 sound/virtio/virtio_card.c                         |   2 -
 sound/virtio/virtio_ctl_msg.c                      |   2 -
 sound/virtio/virtio_pcm_msg.c                      |   2 -
 33 files changed, 801 insertions(+), 274 deletions(-)
 mode change 100755 => 100644 sound/soc/codecs/es8326.c



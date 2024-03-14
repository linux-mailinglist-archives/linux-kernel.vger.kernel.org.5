Return-Path: <linux-kernel+bounces-103147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61F987BB97
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219851F23924
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C356EB41;
	Thu, 14 Mar 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dI6fhfrW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="81O/v960";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dI6fhfrW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="81O/v960"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4446CDCE;
	Thu, 14 Mar 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413769; cv=none; b=nFtIfbQ2wGV95QPunIKPhvvJYG6ccPaoIyIH3bkHjSsMs1Kz/u3uhcoy4vA0eiqeFMLhoaVMNErZ0mkmjvn7TkDHiaU8iBuKUTugXN+IXQt2xZOCJ0Rs/YCwzncGNVLqtoLKYL0jdngJPuMyVRiraDnNKLWOkGlq1a0RR/OiUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413769; c=relaxed/simple;
	bh=DVgSXg+MqyL03MMEXMZBX8uZTDI/Uv69V3ledCgezrA=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=K+27qeZQCYBjtAFwKsOBwWfVm10R2ISNVa22po3vaBbClo3m6XyX0TU+DMF0n3Lgq+til93gk3l17kRrxWAo6nntdhbHHSqEcXcSuVU6/FQKR4BJaWU8sBuX8G/Bq2qhIM6bQcxrywRYqe7YS4hf7yH3UMSQjWbs9AtoqOTH4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dI6fhfrW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=81O/v960; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dI6fhfrW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=81O/v960; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C2CF1F84C;
	Thu, 14 Mar 2024 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710413764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kooYt7j8jcwKcgRFvSLsBtM0YlJnEApTeUuNtYUgd4k=;
	b=dI6fhfrWTODap/86tWUz5fzTP1bY7qhb9uHydrV2R0s11MDnzRXt6bIrhSsjBsNzK22CYp
	y7dV6+qA9/KxH+zmJ7QLjnDEnX+BHz/ErAufJrztI1I5qf5l8ETfjAPCYodIg3UPT2Y0/K
	cic5Bs/HhiuJz9A9eqYdPRqqAPWDXVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710413764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kooYt7j8jcwKcgRFvSLsBtM0YlJnEApTeUuNtYUgd4k=;
	b=81O/v960Sk1/EW7nhuzc+z3L4i+6vxmKVJwlMZ8kB8kMiXJyQJKSj6/ysjdSTMhcvOzuhC
	ZAYaRenQNwwJZsAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710413764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kooYt7j8jcwKcgRFvSLsBtM0YlJnEApTeUuNtYUgd4k=;
	b=dI6fhfrWTODap/86tWUz5fzTP1bY7qhb9uHydrV2R0s11MDnzRXt6bIrhSsjBsNzK22CYp
	y7dV6+qA9/KxH+zmJ7QLjnDEnX+BHz/ErAufJrztI1I5qf5l8ETfjAPCYodIg3UPT2Y0/K
	cic5Bs/HhiuJz9A9eqYdPRqqAPWDXVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710413764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kooYt7j8jcwKcgRFvSLsBtM0YlJnEApTeUuNtYUgd4k=;
	b=81O/v960Sk1/EW7nhuzc+z3L4i+6vxmKVJwlMZ8kB8kMiXJyQJKSj6/ysjdSTMhcvOzuhC
	ZAYaRenQNwwJZsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC9091386E;
	Thu, 14 Mar 2024 10:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +m6jLMPX8mU0WAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Mar 2024 10:56:03 +0000
Date: Thu, 14 Mar 2024 11:56:03 +0100
Message-ID: <874jd9m69o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.9-rc1
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
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
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -2.10
X-Spam-Flag: NO

Linus,

please pull sound updates for v6.9-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc1

The topmost commit is a39d51ff1f52cd0b6fe7d379ac93bd8b4237d1b7

----------------------------------------------------------------

sound updates for 6.9-rc1

This was a relatively calm development cycle.  Most of changes are
rather small device-specific fixes and enhancements.  The only
significant changes in ALSA core are code refactoring with the recent
cleanup infrastructure, which should bring no functionality changes.
Some highlights below:

Core:
- Lots of cleanups in ALSA core code with automatic kfree cleanup
  and locking guard macros
- New ALSA core kunit test

ASoC:
- SoundWire support for AMD ACP 6.3 systems
- Support for reporting version information for AVS firmware
- Support DSPless mode for Intel Soundwire systems
- Support for configuring CS35L56 amplifiers using EFI calibration
   data
- Log which component is being operated on as part of power management
   trace events.
- Support for Microchip SAM9x7, NXP i.MX95 and Qualcomm WCD939x

HD- and USB-audio:
- More Cirrus HD-audio codec support
- TAS2781 HD-audio codec fixes
- Scarlett2 mixer fixes

Others:
- Enhancement of virtio driver for audio control supports
- Cleanups of legacy PM code with new macros
- Firewire sound updates

----------------------------------------------------------------

Aiswarya Cyriac (1):
      ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.

Alexander Stein (2):
      ASoC: dt-bindings: fsl-sai: Add power-domains
      ASoC: dt-bindings: fsl-sai: Support Rx-only SAI

Amadeusz S≥awiÒski (3):
      ASoC: Intel: avs: UAPI: Add tokens for initial config feature
      ASoC: Intel: avs: Add topology parsing support for initial config
      ASoC: Intel: avs: Send initial config to module if present

Andy Shevchenko (2):
      ASoC: Intel: atom: sst_ipc: Remove unused intel-mid.h
      ASoC: Intel: catpt: Carefully use PCI bitwise constants

Anton Yakovlev (1):
      ALSA: virtio: add support for audio controls

Arnd Bergmann (7):
      ASoC: SOF: amd: fix SND_AMD_SOUNDWIRE_ACPI dependencies
      ASoC: fix SND_SOC_WCD939X dependencies
      ALSA: ctxfi: avoid casting function pointers
      ALSA: aw2: avoid casting function pointers
      ALSA: avoid 'bool' as variable name
      ALSA: core: fix buffer overflow in test_format_fill_silence()
      ASoC: SOF: amd: fix soundwire dependencies

Athaariq Ardhiansyah (1):
      ALSA: hda/realtek: fix ALC285 issues on HP Envy x360 laptops

Bard Liao (12):
      ASoC: Intel: sof_sdw: use single rtd_init for rt_amps
      ASoC: Intel: add get_codec_dai_by_name helper function
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: use helper to get codec dai by name
      ASoC: Intel: sof_sdw_rt711: use helper to get codec dai by name
      ASoC: Intel: sof_sdw_rt712_sdca: use helper to get codec dai by name
      ASoC: Intel: sof_sdw_rt700: use helper to get codec dai by name
      ASoC: Intel: sof_sdw_cs42l42: use helper to get codec dai by name
      ASoC: Intel: sof_sdw_rt5682: use helper to get codec dai by name
      ASoC: Intel: sof_sdw: add common sdw dai link init
      ASoC: Intel: sof_sdw: remove .init callbacks
      ASoC: Intel: sof_sdw: starts non sdw BE id with the highest sdw BE id
      ASoC: SOF: ipc4-topology: set config_length based on device_count

Brent Lu (8):
      ASoC: Intel: sof_rt5682: board id cleanup for jsl boards
      ASoC: Intel: sof_rt5682: board id cleanup for tgl boards
      ASoC: Intel: sof_rt5682: board id cleanup for adl boards
      ASoC: Intel: sof_rt5682: board id cleanup for rpl boards
      ASoC: Intel: sof_rt5682: board id cleanup for mtl boards
      ASoC: Intel: sof_rt5682: dmi quirk cleanup for mtl boards
      ASoC: Intel: board_helpers: support DAI link order customization
      ASoC: Intel: sof_cs42l42: use common module for DAI link generation

Cezary Rojewski (22):
      ASoC: Intel: avs: Expose FW version with sysfs
      ASoC: Intel: avs: L1SEN reference counted
      ASoC: Intel: avs: Fix sound clipping in single capture scenario
      ASoC: Intel: avs: Prefix SKL/APL-specific members
      ASoC: Intel: avs: Abstract IPC handling
      ASoC: Intel: avs: Abstract IRQ handling
      ASoC: Intel: avs: CNL-based platforms support
      ASoC: Intel: avs: ICL-based platforms support
      ASoC: Intel: avs: TGL-based platforms support
      ASoC: Intel: avs: ICCMAX recommendations for ICL+ platforms
      ASoC: Intel: avs: Populate board selection with new I2S entries
      ASoC: codecs: da7213: Simplify mclk initialization
      ASoC: codecs: nau8825: Simplify mclk initialization
      ASoC: codecs: rt5514: Simplify mclk initialization
      ASoC: codecs: rt5616: Simplify mclk initialization
      ASoC: codecs: rt5640: Simplify mclk initialization
      ASoC: codecs: rt5660: Simplify mclk initialization
      ALSA: hda: Skip i915 initialization on CNL/LKF-based platforms
      ASoC: codecs: hda: Skip HDMI/DP registration if i915 is missing
      ASoC: Intel: avs: Ignore codecs with no suppoting driver
      ASoC: codecs: hda: Cleanup error messages
      ALSA: hda: Reuse for_each_pcm_streams()

Chancel Liu (4):
      ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX95 platform
      ASoC: fsl_sai: Add support for i.MX95 platform
      ASoC: dt-bindings: fsl,micfil: Add compatible string for i.MX95 platform
      ASoC: soc-core.c: Prefer to return dai->driver->name in snd_soc_dai_name_get()

Chao Song (2):
      ASoC: Intel: soc-acpi: add RT712 support for LNL
      ASoC: Intel: soc-acpi-intel-lnl-match: Add rt722 support

Charles Keepax (12):
      ASoC: cs42l43: Tidy up header includes
      ASoC: cs42l43: Minor code tidy ups
      ASoC: cs42l43: Check error from device_property_read_u32_array()
      ASoC: cs42l43: Add pm_ptr around the power ops
      ASoC: cs42l43: Use USEC_PER_MSEC rather than hard coding
      ASoC: cs42l43: Refactor to use for_each_set_bit()
      ASoC: cs42l43: Use fls to calculate the pre-divider for the PLL
      ASoC: cs42l43: Add clear of stashed pointer on component remove
      ASoC: cs42l43: Sync the hp ilimit works when removing the component
      ASoC: cs42l43: Shut down jack detection on component remove
      ASoC: Intel: ssp-common: Add stub for sof_ssp_get_codec_name
      ASoC: Intel: sof_sdw: Remove unused function prototypes

Christophe JAILLET (1):
      ALSA: synth: Save a few bytes of memory when registering a 'snd_emux'

Colin Ian King (2):
      ASoC: tas2781: Remove redundant initialization of pointer 'data'
      ALSA: echoaudio: remove redundant assignment to variable clock

Cristian Ciocaltea (8):
      ASoC: amd: acp: Drop redundant initialization of machine driver data
      ASoC: amd: acp: Make use of existing *_CODEC_DAI macros
      ASoC: amd: acp: Add missing error handling in sof-mach
      ASoC: amd: acp: Update MODULE_DESCRIPTION for sof-mach
      ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
      ASoC: SOF: amd: Optimize quirk for Valve Galileo
      ASoC: SOF: core: Skip firmware test for custom loaders
      ASoC: SOF: amd: Compute file paths on firmware load

Dan Carpenter (1):
      ASoC: SOF: Add some bounds checking to firmware data

Daniel Baluta (1):
      ASoC: SOF: imx: Add devicetree support to select topologies

David Lin (1):
      ASoC: nau8540: Add pre-charge actions for input

Dharma Balasubiramani (2):
      ASoC: dt-bindings: atmel,sam9x5-wm8731: Convert to json-schema
      ASoC: dt-bindings: atmel,asoc-wm8904: Convert to json-schema

Erick Archer (2):
      ASoC: qcom: Use devm_kcalloc() instead of devm_kzalloc()
      ASoC: ti: j721e-evm: Use devm_kcalloc() instead of devm_kzalloc()

Geoffrey D. Bennett (4):
      ALSA: scarlett2: Fix Scarlett 4th Gen 4i4 low-voltage detection
      ALSA: scarlett2: Fix Scarlett 4th Gen autogain status values
      ALSA: scarlett2: Fix Scarlett 4th Gen input gain range
      ALSA: scarlett2: Fix Scarlett 4th Gen input gain range again

Gergo Koteles (6):
      ASoC: tas2781: remove unused acpi_subysystem_id
      ALSA: hda/tas2781: use dev_dbg in system_resume
      ALSA: hda/tas2781: add lock to system_suspend
      ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
      ALSA: hda/tas2781: do not call pm_runtime_force_* in system_resume/suspend
      ALSA: hda/tas2781: restore power state after system_resume

Herve Codina (1):
      ASoC: codecs: Add support for the framer codec

Ivan Orlov (3):
      ALSA: pcm: Fix snd_pcm_format_name function
      ALSA: core: Add sound core KUnit test
      ALSA: core: Fix dependencies for SND_CORE_TEST

Javier GarcÌa (1):
      ASoC: dt-bindings: rt1015: Convert to dtschema

Jerome Brunet (8):
      ASoC: meson: aiu: fix function pointer type mismatch
      ASoC: meson: t9015: fix function pointer type mismatch
      ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
      ASoC: meson: axg-tdm-interface: add frame rate constraint
      ASoC: meson: axg-tdm-interface: update error format error traces
      ASoC: meson: axg-spdifin: use max width for rate detection
      ASoC: meson: axg-fifo: take continuous rates
      ASoC: meson: axg-fifo: use FIELD helpers

Johan Carlsson (1):
      ALSA: usb-audio: Stop parsing channels bits when all channels are found.

Kenny Levinsen (1):
      ALSA: usb-audio: Name feature ctl using output if input is PCM

Konrad Dybcio (1):
      ASoC: dt-bindings: cs35l45: Add interrupts

Krzysztof Kozlowski (11):
      ASoC: dt-bindings: Do not override firmware-name $ref
      ASoC: codecs: constify static sdw_slave_ops struct
      ASoC: dt-bindings: qcom,sm8250: Allow up to 8 codec DAIs
      ASoC: codecs: tx-macro: Drop unimplemented DMIC clock divider
      ASoC: codecs: tx-macro: Mark AMIC control registers as volatile
      ASoC: codecs: tx-macro: Simplify setting AMIC control
      ASoC: Constify pointer to of_phandle_args
      ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios for shared line
      ASoC: codecs: wsa884x: Allow sharing reset GPIO
      ASoC: codecs: tx-macro: split widgets per different LPASS versions
      ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+

Kuninori Morimoto (4):
      ASoC: ti: use devm_snd_soc_register_card()
      ASoC: fsl: use devm_snd_soc_register_card()
      ASoC: atmel: use devm_snd_soc_register_card()
      ASoC: soc-core: tidyup strcmp() param on snd_soc_is_matching_dai()

Lad Prabhakar (1):
      ASoC: sh: rz-ssi: Fix error message print

Luca Ceresoli (2):
      ASoC: trace: add component to set_bias_level trace events
      ASoC: trace: add event to snd_soc_dapm trace events

Maciej Strozek (1):
      ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23 for MTL

Masahiro Yamada (3):
      ASoC: pxa: remove duplicated CONFIG_SND_PXA2XX_AC97 entry
      ASoC: codecs: remove redundant 'tristate' in sound/soc/codecs/Kconfig
      ALSA: seq: remove redundant 'tristate' for SND_SEQ_UMP_CLIENT

Nathan Chancellor (1):
      ALSA: hwdep: Move put_user() call out of scoped_guard() in snd_hwdep_control_ioctl()

Neil Armstrong (5):
      ASoC: dt-bindings: qcom,wcd938x: move out common properties
      ASoC: dt-bindings: document WCD939x Audio Codec
      ASoC: codec: wcd-mbhc-v2: add support when connected behind an USB-C audio mux
      ASoC: codecs: Add WCD939x Soundwire devices driver
      ASoC: codecs: Add WCD939x Codec driver

Peter Ujfalusi (2):
      ASoC: SOF: Intel: lnl: Do not use LNL specific wrappers in DSPless mode
      ASoC: SOF: Fix runtime pm usage counter balance after fw exception

Pierre-Louis Bossart (16):
      ALSA: HDA: intel-sdw-acpi: add kernel parameter to select alternate controller
      ASoC: SOF: ipc4-topology: change chain_dma handling in dai_config
      ASoC: SOF: ops: add new 'is_chain_dma_supported' callback
      ASoC: SOF: Intel: hda: add 'is_chain_dma_supported' callback
      ASoC: SOF: Intel: hda-dai-ops: enable chain_dma for ALH
      ASoC: SOF: ipc4: store number of playback/capture streams
      ASoC: SOF: ipc4-pcm: fix dma_id for CHAIN_DMA capture
      ASoC: SOF: ipc4-topology: allow chain_dma for all supported DAIs
      ASoC: SOF: Intel: hda-dai: remove dspless special case
      ASoC: SOF: topology: dynamically allocate and store DAI widget->private
      ASoC: SOF: Intel: start SoundWire links earlier for LNL+ devices
      ASoC: SOF: Intel: hda-dai-ops: use dai_type
      ASoC: SOF: Intel: hda-dai-ops: add SoundWire dspless mode
      ASoC: SOF: Intel: hda-dai: add support for dspless mode beyond HDAudio
      ASoC: SOF: Intel: hda-mlink: update incorrect comment
      ALSA: hda/tas2781: remove unnecessary runtime_pm calls

R SUNDAR (1):
      spi: Remove the @multi_cs_cap to prevent kernel-doc warnings

Randy Dunlap (1):
      ASoC: p1022_rdk: fix all kernel-doc warnings

Ranjani Sridharan (1):
      ASoC: SOF: topology: Parse DAI type token for dspless mode

Ricardo B. Marliere (2):
      ALSA: aoa: make soundbus_bus_type const
      ALSA: seq: make snd_seq_bus_type const

Richard Fitzgerald (13):
      ALSA: hda: realtek: Re-work CS35L41 fixups to re-use for other amps
      ALSA: hda: realtek: Move hda_component implementation to module
      ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
      ASoC: cs-amp-lib: Add helpers for factory calibration data
      ASoC: cs35l56: Add helper functions for amp calibration
      ASoC: cs35l56: Apply amp calibration from EFI data
      ALSA: hda: cs35l56: Apply amp calibration from EFI data
      ASoC: cs35l56: Prevent bad sign extension in cs35l56_read_silicon_uid()
      ASoC: cs-amp-lib: Add KUnit test for calibration helpers
      firmware: cirrus: cs_dsp: Initialize debugfs_root to invalid
      firmware: cirrus: cs_dsp: Remove non-existent member from kerneldoc
      ALSA: hda: hda_component: Add missing #include guards
      ALSA: hda: hda_component: Include sound/hda_codec.h

Rob Herring (2):
      ASoC: dt-bindings: samsung,tm2: Correct "audio-codec" constraints
      ASoC: dt-bindings: audio-graph-port: Drop type from "clocks"

Sayed, Karimuddin (1):
      ALSA: hda/realtek: Add "Intel Reference board" SSID in the ALC256.

Sebastian Reichel (1):
      ASoC: dt-bindings: fsl,imx-asrc: convert to YAML

Simon Trimmer (4):
      ALSA: hda/realtek: Add quirks for HP G11 Laptops using CS35L56
      ASoC: cs35l56: Add support for CS35L54 and CS35L57
      ALSA: hda: cs35l56: Add support for CS35L54 and CS35L57
      platform/x86: serial-multi-instantiate: Add support for CS35L54 and CS35L57

Srinivas Kandagatla (1):
      ASoC: codecs: va-macro: add npl clk

Stefan Binding (5):
      ALSA: hda: cs35l41: Set Channel Index correctly when system is missing _DSD
      ALSA: hda: cs35l41: Support additional HP Envy Models
      ALSA: hda: cs35l41: Support HP models without _DSD using dual Speaker ID
      ALSA: hda/realtek: Add quirks for various HP ENVY models
      ALSA: hda/realtek: Remove two HP Laptops using CS35L41

Takashi Iwai (72):
      ALSA: aloop: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: dummy: Replace with DEFINE_SIPMLE_DEV_PM_OPS()
      ALSA: pcsp: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: als300: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: als4000: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: atiixp: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: ens137x: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: intel8x0: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: nm256: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: aoa: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: aaci: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: pxa2xx-ac97: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ASoC: pxa2xx-ac97: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: at73c213: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: ali5451: Embed suspend image into struct snd_ali
      ALSA: ali5451: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: azt3328: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: cmipci: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: cs4281: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: echoaudio: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: es1938: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: es1968: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: fm801: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: maestro3: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: riptide: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: rme96: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: sis7019: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: via82xx: Simplify with DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: doc: Use DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: seq: fix function cast warnings
      ALSA: hda: Set up BDL table at hw_params
      ALSA: hda: Downgrade BDL table overflow message
      ALSA: hda: beep: Drop stale mutex
      ALSA: seq: prioq: Unify cell removal functions
      ALSA: pcm: Use automatic cleanup of kfree()
      ALSA: control: Use automatic cleanup of kfree()
      ALSA: compress_offload: Use automatic cleanup of kfree()
      ALSA: timer: Use automatic cleanup of kfree()
      ALSA: vmaster: Use automatic cleanup of kfree()
      ALSA: seq: oss: Use automatic cleanup of kfree()
      ALSA: seq: virmidi: Use automatic cleanup of kfree()
      ALSA: seq: ump: Use automatic cleanup of kfree()
      ALSA: seq: core: Use automatic cleanup of kfree()
      ALSA: pcm: Use CLASS() for fdget()/fdput()
      ALSA: mixer_oss: ump: Use automatic cleanup of kfree()
      ALSA: pcm_oss: ump: Use automatic cleanup of kfree()
      ALSA: kunit: Fix sparse warnings
      ALSA: ump: Use guard() for locking
      ALSA: compress_offload: Use guard() for locking
      ALSA: timer: Use guard() for locking
      ALSA: hrtimer: Use guard() for locking
      ALSA: hwdep: Use guard() for locking
      ALSA: info: Use guard() for locking
      ALSA: mixer_oss: Use guard() for locking
      ALSA: control: Use guard() for locking
      ALSA: rawmidi: Use guard() for locking
      ALSA: jack: Use guard() for locking
      ALSA: core: Use guard() for locking
      ALSA: seq: fifo: Use guard() for locking
      ALSA: seq: memory: Use guard() for locking
      ALSA: seq: ports: Use guard() for locking
      ALSA: seq: queue: Use guard() for locking
      ALSA: seq: timer: Use guard() for locking
      ALSA: seq: midi: Use guard() for locking
      ALSA: seq: ump: Use guard() for locking
      ALSA: seq: virmidi: Use guard() for locking
      ALSA: seq: prioq: Use guard() for locking
      ALSA: pcm: Use guard() for locking
      ALSA: pcm: Use guard() for PCM stream locks
      ALSA: pcm: oss: Use guard() for setup
      ALSA: control_led: Use guard() for locking
      ALSA: ac97: More cleanup with snd_ctl_find_id_mixer()

Takashi Sakamoto (5):
      ALSA: firewire-motu: add support for MOTU 896 mk3 FireWire and Hybrid
      ALSA: oxfw: use const qualifier for immutable argument
      ALSA: oxfw: support the case that AV/C Stream Format Information command is not available
      ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter
      ALSA: oxfw: add support for Miglia Harmony Audio

Thomas Weiﬂschuh (1):
      ALSA: aaci: Delete unused variable in aaci_do_suspend

Valentine Altair (1):
      ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on some HP models

Varshini Rajendran (2):
      ASoC: dt-bindings: atmel-classd: add sam9x7 compatible
      ASoC: dt-bindings: microchip: add sam9x7

Vijendar Mukunda (20):
      ASoC/soundwire: implement generic api for scanning amd soundwire controller
      soundwire: amd: update license
      soundwire: amd: refactor amd soundwire manager device node creation
      soundwire: amd: implement function to extract slave information
      soundwire: amd: refactor soundwire pads enable
      soundwire: amd: refactor register mask structure
      ASoC: SOF: amd: add code for invoking soundwire manager helper functions
      ASoC: SOF: amd: add interrupt handling for SoundWire manager devices
      ASoC: SOF: amd: Add Soundwire DAI configuration support for AMD platforms
      ASoC: SOF: amd: add machine select logic for soundwire based platforms
      ASoC: SOF: amd: update descriptor fields for acp6.3 based platform
      ASoC: SOF: amd: select soundwire dependency flag for acp6.3 based platform
      ASoC: SOF: amd: refactor acp driver pm ops
      ASoC: amd: ps: refactor acp device configuration read logic
      ASoC: amd: ps: refactor acp child platform device creation code
      ASoC: amd: ps: remove acp_reset flag
      ASoC: amd: ps: fix for acp pme wake for soundwire configuration
      ASoC: amd: ps: add machine select and register code
      ASoC: amd: ps: update license
      ASoC: amd: ps: modify ACP register end address macro

Vitaly Rodionov (1):
      ASoC: cs42l42: Remove redundant delays in suspend().

Yang Li (1):
      ASoC: codecs: Remove unneeded semicolon

Yinchuan Guo (1):
      ASoC: codecs: fix TYPO 'reguest' to 'request' in error log

Zhang Yi (2):
      ASoC: codecs: ES8326: Changing members of private structure
      ASoC: codecs: ES8326: change support for ES8326

Zhu Ning (1):
      ASoC: codecs: ES8326: Adding new volume kcontrols

mosomate (1):
      ASoC: Intel: common: DMI remap for rebranded Intel NUC M15 (LAPRC710) laptops

---
 .../ABI/testing/sysfs-bus-pci-devices-avs          |    8 +
 .../bindings/sound/atmel,asoc-wm8904.yaml          |   84 +
 .../bindings/sound/atmel,sam9x5-wm8731-audio.yaml  |   76 +
 .../bindings/sound/atmel,sama5d2-classd.yaml       |    7 +-
 .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |   35 -
 .../devicetree/bindings/sound/atmel-wm8904.txt     |   55 -
 .../bindings/sound/audio-graph-port.yaml           |    2 +-
 .../devicetree/bindings/sound/cirrus,cs35l45.yaml  |    3 +
 .../devicetree/bindings/sound/everest,es8326.yaml  |    8 +-
 .../devicetree/bindings/sound/fsl,asrc.txt         |   80 -
 .../devicetree/bindings/sound/fsl,easrc.yaml       |    4 +-
 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |  162 +
 .../devicetree/bindings/sound/fsl,micfil.yaml      |   14 +-
 .../devicetree/bindings/sound/fsl,sai.yaml         |    6 +
 .../bindings/sound/infineon,peb2466.yaml           |    2 +-
 .../bindings/sound/microchip,sama7g5-i2smcc.yaml   |   11 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    2 +-
 .../devicetree/bindings/sound/qcom,wcd938x.yaml    |   81 +-
 .../bindings/sound/qcom,wcd939x-sdw.yaml           |   69 +
 .../devicetree/bindings/sound/qcom,wcd939x.yaml    |   96 +
 .../bindings/sound/qcom,wcd93xx-common.yaml        |   95 +
 .../devicetree/bindings/sound/qcom,wsa8840.yaml    |   11 +-
 .../devicetree/bindings/sound/realtek,rt1015.yaml  |   41 +
 Documentation/devicetree/bindings/sound/rt1015.txt |   23 -
 .../devicetree/bindings/sound/samsung,tm2.yaml     |    7 +-
 .../sound/kernel-api/writing-an-alsa-driver.rst    |    6 +-
 MAINTAINERS                                        |    7 +
 drivers/acpi/scan.c                                |    2 +
 drivers/firmware/cirrus/cs_dsp.c                   |    7 +-
 drivers/platform/x86/serial-multi-instantiate.c    |   28 +
 drivers/soundwire/Makefile                         |    2 +-
 drivers/soundwire/amd_init.c                       |  235 ++
 drivers/soundwire/amd_init.h                       |   13 +
 drivers/soundwire/amd_manager.c                    |   47 +-
 drivers/soundwire/amd_manager.h                    |   16 +-
 drivers/soundwire/dmi-quirks.c                     |    8 +
 include/linux/firmware/cirrus/cs_dsp.h             |    1 -
 include/linux/soundwire/sdw_amd.h                  |   83 +-
 include/linux/spi/spi.h                            |    2 -
 include/sound/ak4531_codec.h                       |    3 +
 include/sound/cs-amp-lib.h                         |   66 +
 include/sound/cs35l56.h                            |   11 +
 include/sound/cs42l42.h                            |    5 +-
 include/sound/emux_synth.h                         |    2 +-
 include/sound/hda-mlink.h                          |    2 +-
 include/sound/hda_register.h                       |    2 +
 include/sound/pcm.h                                |   12 +
 include/sound/sb.h                                 |    3 +
 include/sound/soc.h                                |    4 +-
 include/sound/sof/dai-amd.h                        |    7 +
 include/sound/sof/dai.h                            |    2 +
 include/sound/tas2781.h                            |    1 -
 include/trace/events/asoc.h                        |   45 +-
 include/uapi/linux/virtio_snd.h                    |  154 +
 include/uapi/sound/intel/avs/tokens.h              |    9 +
 include/uapi/sound/sof/tokens.h                    |    4 +
 sound/aoa/fabrics/layout.c                         |    7 +-
 sound/aoa/soundbus/core.c                          |    2 +-
 sound/arm/aaci.c                                   |   11 +-
 sound/arm/pxa2xx-ac97.c                            |    7 +-
 sound/core/Kconfig                                 |   17 +
 sound/core/Makefile                                |    2 +
 sound/core/compress_offload.c                      |  134 +-
 sound/core/control.c                               |  454 +--
 sound/core/control_compat.c                        |   87 +-
 sound/core/control_led.c                           |  150 +-
 sound/core/hrtimer.c                               |   24 +-
 sound/core/hwdep.c                                 |   78 +-
 sound/core/info.c                                  |   93 +-
 sound/core/info_oss.c                              |   10 +-
 sound/core/init.c                                  |  199 +-
 sound/core/jack.c                                  |   25 +-
 sound/core/oss/mixer_oss.c                         |  287 +-
 sound/core/oss/pcm_oss.c                           |   74 +-
 sound/core/pcm.c                                   |  100 +-
 sound/core/pcm_compat.c                            |   95 +-
 sound/core/pcm_lib.c                               |   10 +-
 sound/core/pcm_memory.c                            |   30 +-
 sound/core/pcm_native.c                            |  457 +--
 sound/core/rawmidi.c                               |  253 +-
 sound/core/seq/Kconfig                             |    1 -
 sound/core/seq/oss/seq_oss_device.h                |    2 +-
 sound/core/seq/oss/seq_oss_init.c                  |   19 +-
 sound/core/seq/oss/seq_oss_midi.c                  |   11 +-
 sound/core/seq/seq_compat.c                        |   12 +-
 sound/core/seq/seq_fifo.c                          |   55 +-
 sound/core/seq/seq_memory.c                        |   28 +-
 sound/core/seq/seq_midi.c                          |   38 +-
 sound/core/seq/seq_midi_event.c                    |   14 +-
 sound/core/seq/seq_ports.c                         |  114 +-
 sound/core/seq/seq_prioq.c                         |  198 +-
 sound/core/seq/seq_queue.c                         |   78 +-
 sound/core/seq/seq_timer.c                         |  163 +-
 sound/core/seq/seq_ump_client.c                    |   46 +-
 sound/core/seq/seq_virmidi.c                       |   49 +-
 sound/core/seq_device.c                            |    2 +-
 sound/core/sound.c                                 |   28 +-
 sound/core/sound_kunit.c                           |  312 ++
 sound/core/sound_oss.c                             |   17 +-
 sound/core/timer.c                                 |  442 +--
 sound/core/timer_compat.c                          |    7 +-
 sound/core/ump.c                                   |   35 +-
 sound/core/vmaster.c                               |   19 +-
 sound/drivers/aloop.c                              |    9 +-
 sound/drivers/dummy.c                              |    9 +-
 sound/drivers/pcsp/pcsp.c                          |    9 +-
 sound/firewire/Kconfig                             |    2 +
 sound/firewire/amdtp-stream.c                      |   12 +-
 sound/firewire/amdtp-stream.h                      |    4 +
 sound/firewire/motu/motu-protocol-v3.c             |    9 +
 sound/firewire/motu/motu.c                         |    2 +
 sound/firewire/motu/motu.h                         |    1 +
 sound/firewire/oxfw/oxfw-stream.c                  |  100 +-
 sound/firewire/oxfw/oxfw.c                         |   10 +-
 sound/firewire/oxfw/oxfw.h                         |    7 +-
 sound/hda/hdac_i915.c                              |   32 +-
 sound/hda/hdac_stream.c                            |    2 +-
 sound/hda/intel-sdw-acpi.c                         |    7 +
 sound/pci/ac97/ac97_patch.c                        |    7 +-
 sound/pci/ali5451/ali5451.c                        |   32 +-
 sound/pci/als300.c                                 |    9 +-
 sound/pci/als4000.c                                |    9 +-
 sound/pci/atiixp.c                                 |   12 +-
 sound/pci/atiixp_modem.c                           |   11 +-
 sound/pci/aw2/aw2-saa7146.h                        |    5 +-
 sound/pci/azt3328.c                                |   11 +-
 sound/pci/cmipci.c                                 |   11 +-
 sound/pci/cs4281.c                                 |   13 +-
 sound/pci/ctxfi/ctamixer.c                         |   10 +-
 sound/pci/ctxfi/ctamixer.h                         |    8 +-
 sound/pci/ctxfi/ctatc.c                            |   23 +-
 sound/pci/ctxfi/ctdaio.c                           |    5 +-
 sound/pci/ctxfi/ctdaio.h                           |    4 +-
 sound/pci/ctxfi/ctsrc.c                            |   10 +-
 sound/pci/ctxfi/ctsrc.h                            |    8 +-
 sound/pci/echoaudio/echoaudio.c                    |   21 +-
 sound/pci/echoaudio/echoaudio.h                    |    2 -
 sound/pci/echoaudio/echoaudio_3g.c                 |    1 -
 sound/pci/ens1370.c                                |    9 +-
 sound/pci/es1938.c                                 |   11 +-
 sound/pci/es1968.c                                 |   17 +-
 sound/pci/fm801.c                                  |   11 +-
 sound/pci/hda/Kconfig                              |    6 +
 sound/pci/hda/Makefile                             |    2 +
 sound/pci/hda/cs35l41_hda_property.c               |   90 +-
 sound/pci/hda/cs35l56_hda.c                        |   55 +-
 sound/pci/hda/cs35l56_hda.h                        |    2 +-
 sound/pci/hda/cs35l56_hda_i2c.c                    |    7 +-
 sound/pci/hda/cs35l56_hda_spi.c                    |    7 +-
 sound/pci/hda/hda_beep.c                           |    1 -
 sound/pci/hda/hda_beep.h                           |    1 -
 sound/pci/hda/hda_codec.c                          |    2 +-
 sound/pci/hda/hda_component.c                      |  169 +
 sound/pci/hda/hda_component.h                      |   65 +
 sound/pci/hda/hda_controller.c                     |   14 +-
 sound/pci/hda/patch_realtek.c                      |  334 +-
 sound/pci/hda/tas2781_hda_i2c.c                    |   50 +-
 sound/pci/intel8x0.c                               |    9 +-
 sound/pci/intel8x0m.c                              |    9 +-
 sound/pci/maestro3.c                               |   29 +-
 sound/pci/nm256/nm256.c                            |    9 +-
 sound/pci/riptide/riptide.c                        |   11 +-
 sound/pci/rme96.c                                  |   30 +-
 sound/pci/sis7019.c                                |   13 +-
 sound/pci/via82xx.c                                |   15 +-
 sound/pci/via82xx_modem.c                          |    9 +-
 sound/soc/amd/Kconfig                              |   17 +
 sound/soc/amd/Makefile                             |    2 +-
 sound/soc/amd/acp/Kconfig                          |    7 +
 sound/soc/amd/acp/Makefile                         |    2 +
 sound/soc/amd/acp/acp-mach-common.c                |    6 +-
 sound/soc/amd/acp/acp-sof-mach.c                   |   26 +-
 sound/soc/amd/acp/amd-sdw-acpi.c                   |   62 +
 sound/soc/amd/ps/Makefile                          |    2 +-
 sound/soc/amd/ps/acp63.h                           |   91 +-
 sound/soc/amd/ps/pci-ps.c                          |  569 +--
 sound/soc/amd/ps/ps-mach.c                         |    2 +-
 sound/soc/amd/ps/ps-pdm-dma.c                      |    2 +-
 sound/soc/amd/ps/ps-sdw-dma.c                      |    2 +-
 sound/soc/atmel/mikroe-proto.c                     |    8 +-
 sound/soc/codecs/Kconfig                           |   55 +-
 sound/soc/codecs/Makefile                          |   13 +
 sound/soc/codecs/cs-amp-lib-test.c                 |  709 ++++
 sound/soc/codecs/cs-amp-lib.c                      |  277 ++
 sound/soc/codecs/cs35l56-sdw.c                     |   23 +-
 sound/soc/codecs/cs35l56-shared.c                  |   92 +-
 sound/soc/codecs/cs35l56.c                         |   58 +-
 sound/soc/codecs/cs42l42.c                         |    1 -
 sound/soc/codecs/cs42l43-jack.c                    |   27 +-
 sound/soc/codecs/cs42l43-sdw.c                     |    1 +
 sound/soc/codecs/cs42l43.c                         |   82 +-
 sound/soc/codecs/cs42l43.h                         |   25 +-
 sound/soc/codecs/da7213.c                          |   12 +-
 sound/soc/codecs/es8326.c                          |  110 +-
 sound/soc/codecs/es8326.h                          |    5 +-
 sound/soc/codecs/framer-codec.c                    |  413 +++
 sound/soc/codecs/hda.c                             |   15 +-
 sound/soc/codecs/lpass-macro-common.h              |    7 +
 sound/soc/codecs/lpass-tx-macro.c                  |  693 +++-
 sound/soc/codecs/lpass-va-macro.c                  |   57 +
 sound/soc/codecs/max98363.c                        |    2 +-
 sound/soc/codecs/max98373-sdw.c                    |    2 +-
 sound/soc/codecs/nau8540.c                         |  112 +-
 sound/soc/codecs/nau8540.h                         |   13 +-
 sound/soc/codecs/nau8825.c                         |   12 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 |    2 +-
 sound/soc/codecs/rt274.c                           |    2 +-
 sound/soc/codecs/rt286.c                           |    2 +-
 sound/soc/codecs/rt298.c                           |    2 +-
 sound/soc/codecs/rt5514-spi.c                      |    2 +-
 sound/soc/codecs/rt5514.c                          |    9 +-
 sound/soc/codecs/rt5616.c                          |    9 +-
 sound/soc/codecs/rt5640.c                          |    9 +-
 sound/soc/codecs/rt5645.c                          |    2 +-
 sound/soc/codecs/rt5651.c                          |    2 +-
 sound/soc/codecs/rt5659.c                          |    2 +-
 sound/soc/codecs/rt5660.c                          |    9 +-
 sound/soc/codecs/rt5663.c                          |    2 +-
 sound/soc/codecs/rt5665.c                          |    2 +-
 sound/soc/codecs/rt5668.c                          |    2 +-
 sound/soc/codecs/rt5682-i2c.c                      |    2 +-
 sound/soc/codecs/rt5682s.c                         |    2 +-
 sound/soc/codecs/rt712-sdca-dmic.c                 |    2 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |    2 +-
 sound/soc/codecs/rt722-sdca-sdw.c                  |    2 +-
 sound/soc/codecs/tas2781-comlib.c                  |    1 -
 sound/soc/codecs/tas2781-fmwlib.c                  |    2 +-
 sound/soc/codecs/wcd-clsh-v2.h                     |    1 +
 sound/soc/codecs/wcd-mbhc-v2.c                     |   95 +-
 sound/soc/codecs/wcd-mbhc-v2.h                     |    3 +
 sound/soc/codecs/wcd939x-sdw.c                     | 1551 ++++++++
 sound/soc/codecs/wcd939x.c                         | 3686 ++++++++++++++++++++
 sound/soc/codecs/wcd939x.h                         |  989 ++++++
 sound/soc/codecs/wm_adsp.c                         |   27 +-
 sound/soc/codecs/wm_adsp.h                         |    2 +
 sound/soc/codecs/wsa884x.c                         |   53 +-
 sound/soc/fsl/eukrea-tlv320.c                      |    8 +-
 sound/soc/fsl/fsl_sai.c                            |   13 +
 sound/soc/fsl/p1022_rdk.c                          |   33 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |    3 +-
 sound/soc/intel/avs/Makefile                       |    5 +-
 sound/soc/intel/avs/apl.c                          |   58 +-
 sound/soc/intel/avs/avs.h                          |   70 +-
 sound/soc/intel/avs/board_selection.c              |   85 +
 sound/soc/intel/avs/cnl.c                          |   61 +
 sound/soc/intel/avs/core.c                         |  170 +-
 sound/soc/intel/avs/icl.c                          |  197 ++
 sound/soc/intel/avs/ipc.c                          |   66 +-
 sound/soc/intel/avs/loader.c                       |    2 +-
 sound/soc/intel/avs/messages.c                     |    1 +
 sound/soc/intel/avs/messages.h                     |   38 +-
 sound/soc/intel/avs/path.c                         |   33 +
 sound/soc/intel/avs/pcm.c                          |   77 +-
 sound/soc/intel/avs/registers.h                    |   21 +-
 sound/soc/intel/avs/skl.c                          |   61 +-
 sound/soc/intel/avs/sysfs.c                        |   35 +
 sound/soc/intel/avs/tgl.c                          |   54 +
 sound/soc/intel/avs/topology.c                     |  164 +-
 sound/soc/intel/avs/topology.h                     |   13 +
 sound/soc/intel/boards/Kconfig                     |    1 +
 sound/soc/intel/boards/sof_board_helpers.c         |  249 +-
 sound/soc/intel/boards/sof_board_helpers.h         |   29 +
 sound/soc/intel/boards/sof_cs42l42.c               |  232 +-
 sound/soc/intel/boards/sof_rt5682.c                |  151 +-
 sound/soc/intel/boards/sof_sdw.c                   |  106 +-
 sound/soc/intel/boards/sof_sdw_common.h            |   82 +-
 sound/soc/intel/boards/sof_sdw_cs42l42.c           |   35 +-
 sound/soc/intel/boards/sof_sdw_cs42l43.c           |   25 +-
 sound/soc/intel/boards/sof_sdw_cs_amp.c            |    3 +-
 sound/soc/intel/boards/sof_sdw_maxim.c             |    4 +-
 sound/soc/intel/boards/sof_sdw_rt5682.c            |   35 +-
 sound/soc/intel/boards/sof_sdw_rt700.c             |   35 +-
 sound/soc/intel/boards/sof_sdw_rt711.c             |   19 +-
 sound/soc/intel/boards/sof_sdw_rt712_sdca.c        |   39 +-
 sound/soc/intel/boards/sof_sdw_rt715.c             |   12 +-
 sound/soc/intel/boards/sof_sdw_rt715_sdca.c        |   12 +-
 sound/soc/intel/boards/sof_sdw_rt_amp.c            |   53 +-
 .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   19 +-
 sound/soc/intel/boards/sof_ssp_common.h            |    8 +
 sound/soc/intel/catpt/dsp.c                        |    4 +-
 sound/soc/intel/common/soc-acpi-intel-adl-match.c  |   12 +-
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c  |   10 +-
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |  102 +
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |   61 +-
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c  |    4 +-
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  |    6 +-
 sound/soc/meson/aiu.c                              |   19 +-
 sound/soc/meson/aiu.h                              |    1 -
 sound/soc/meson/axg-fifo.c                         |   25 +-
 sound/soc/meson/axg-fifo.h                         |   14 +-
 sound/soc/meson/axg-frddr.c                        |   13 +-
 sound/soc/meson/axg-spdifin.c                      |    6 +-
 sound/soc/meson/axg-tdm-interface.c                |   31 +-
 sound/soc/meson/axg-toddr.c                        |   30 +-
 sound/soc/meson/t9015.c                            |   20 +-
 sound/soc/pxa/Kconfig                              |    3 -
 sound/soc/pxa/pxa2xx-ac97.c                        |    6 +-
 sound/soc/qcom/common.c                            |    2 +-
 sound/soc/sh/rz-ssi.c                              |    2 +-
 sound/soc/soc-core.c                               |   21 +-
 sound/soc/soc-dapm.c                               |    8 +-
 sound/soc/sof/amd/Kconfig                          |   18 +
 sound/soc/sof/amd/acp-common.c                     |   65 +-
 sound/soc/sof/amd/acp-dsp-offset.h                 |   10 +
 sound/soc/sof/amd/acp-loader.c                     |   34 +-
 sound/soc/sof/amd/acp.c                            |  232 +-
 sound/soc/sof/amd/acp.h                            |   26 +-
 sound/soc/sof/amd/pci-acp63.c                      |    7 +
 sound/soc/sof/core.c                               |   10 +
 sound/soc/sof/debug.c                              |    8 +-
 sound/soc/sof/fw-file-profile.c                    |   18 +-
 sound/soc/sof/imx/imx8.c                           |   16 +
 sound/soc/sof/imx/imx8m.c                          |   10 +
 sound/soc/sof/imx/imx8ulp.c                        |   10 +
 sound/soc/sof/intel/hda-common-ops.c               |    1 +
 sound/soc/sof/intel/hda-dai-ops.c                  |   51 +-
 sound/soc/sof/intel/hda-dai.c                      |   17 +-
 sound/soc/sof/intel/hda-dsp.c                      |    5 +
 sound/soc/sof/intel/hda-stream.c                   |    9 +
 sound/soc/sof/intel/hda.c                          |   80 +-
 sound/soc/sof/intel/hda.h                          |    5 +
 sound/soc/sof/intel/lnl.c                          |   24 +-
 sound/soc/sof/ipc3-loader.c                        |    2 +
 sound/soc/sof/ipc3-pcm.c                           |   25 +
 sound/soc/sof/ipc3-topology.c                      |   40 +
 sound/soc/sof/ipc4-pcm.c                           |   19 +-
 sound/soc/sof/ipc4-priv.h                          |    4 +
 sound/soc/sof/ipc4-topology.c                      |   28 +-
 sound/soc/sof/ops.h                                |    9 +
 sound/soc/sof/sof-audio.c                          |    8 +-
 sound/soc/sof/sof-audio.h                          |    2 +
 sound/soc/sof/sof-priv.h                           |   10 +
 sound/soc/sof/topology.c                           |   30 +-
 sound/soc/ti/j721e-evm.c                           |    4 +-
 sound/soc/ti/omap-hdmi.c                           |   10 +-
 sound/spi/at73c213.c                               |   11 +-
 sound/synth/emux/emux.c                            |    4 +-
 sound/usb/mixer.c                                  |   49 +-
 sound/usb/mixer_scarlett2.c                        |   88 +-
 sound/usb/stream.c                                 |    5 +-
 sound/virtio/Makefile                              |    1 +
 sound/virtio/virtio_card.c                         |   21 +
 sound/virtio/virtio_card.h                         |   22 +
 sound/virtio/virtio_kctl.c                         |  477 +++
 344 files changed, 16601 insertions(+), 5314 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-avs
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,asoc-wm8904.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sam9x5-wm8731-audio.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-wm8904.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd939x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt1015.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt1015.txt
 create mode 100644 drivers/soundwire/amd_init.c
 create mode 100644 drivers/soundwire/amd_init.h
 create mode 100644 include/sound/cs-amp-lib.h
 create mode 100644 sound/core/sound_kunit.c
 create mode 100644 sound/pci/hda/hda_component.c
 create mode 100644 sound/soc/amd/acp/amd-sdw-acpi.c
 create mode 100644 sound/soc/codecs/cs-amp-lib-test.c
 create mode 100644 sound/soc/codecs/cs-amp-lib.c
 create mode 100644 sound/soc/codecs/framer-codec.c
 create mode 100644 sound/soc/codecs/wcd939x-sdw.c
 create mode 100644 sound/soc/codecs/wcd939x.c
 create mode 100644 sound/soc/codecs/wcd939x.h
 create mode 100644 sound/soc/intel/avs/cnl.c
 create mode 100644 sound/soc/intel/avs/icl.c
 create mode 100644 sound/soc/intel/avs/sysfs.c
 create mode 100644 sound/soc/intel/avs/tgl.c
 create mode 100644 sound/virtio/virtio_kctl.c



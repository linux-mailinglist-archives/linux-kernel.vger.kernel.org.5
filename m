Return-Path: <linux-kernel+bounces-23466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD6982AD30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8E21F23FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC214F96;
	Thu, 11 Jan 2024 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OneyNOkr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HHP5lCl9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FQ8NIGBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mtbMuQem"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BF014F88;
	Thu, 11 Jan 2024 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33DDC22205;
	Thu, 11 Jan 2024 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704971879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kavRcu79pE4dzG9M+ZCvRqJ5XTRMgcked+kaVCToPE=;
	b=OneyNOkrmSlvFr3gmhXdDQUVG+7+lOFeXW6XoaTTvQxd4zhouiXhXBPOPrnRy9Ut5kEQ4t
	5NtlgFdmEr/EBeb0bCU6mKIxaq6HtOaWVyiMXk1debGULgK9SVzAcKC3WBYi7PlDDZ0EHu
	Ppga9+Dla8FghDKsI4c1yGBM69B8PHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704971879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kavRcu79pE4dzG9M+ZCvRqJ5XTRMgcked+kaVCToPE=;
	b=HHP5lCl9PlaybP091lcvRfXBPrHuJGylWtzNQlN3io3kzU/XJ0cN1jd5f72fTE0vB0fJyD
	DoB2DAkQWHSy00Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704971802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kavRcu79pE4dzG9M+ZCvRqJ5XTRMgcked+kaVCToPE=;
	b=FQ8NIGBgdfNFm5sSnlww9JwPI7Hyal/SiG0rAGl794HFgTdfNp156E82waTCPXOWPCC3Gm
	uQLNcFVRrVUJ6jVi7hvAO4CY3lglq5LiXj0vu4822dx9Y3z5Huyf1nt2CdTHPVc2vG3PYG
	qeaCdif3IlImzYlKzOHEsZTPjC3cy54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704971802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kavRcu79pE4dzG9M+ZCvRqJ5XTRMgcked+kaVCToPE=;
	b=mtbMuQemeeCQp1ius2aUQpjNulJPIvnlYwgaKALtTmeIeev1DtstKLNTX3y1igotWEtXds
	GIsjzTSFzO+0pYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C723A13635;
	Thu, 11 Jan 2024 11:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEwVLxrOn2XvEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 11 Jan 2024 11:16:42 +0000
Date: Thu, 11 Jan 2024 12:18:12 +0100
Message-ID: <87a5pcp18r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.8-rc1
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FQ8NIGBg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mtbMuQem
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 33DDC22205
X-Spam-Flag: NO

Linus,

please pull sound updates for v6.8-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc1

The topmost commit is fd38dd6abda589a8771e7872e4dea28c99c6a6ef

----------------------------------------------------------------

sound updates for 6.8-rc1

It was a clam development cycle.  There were an ALSA core extension
for subformat PCM bits and a few ASoC core changes to support N:M
mappings, while the most of remaining changes are driver-specific.

Core:
- API extensions for properly limiting PCM format bits via subformat
- Enhanced support for N:M CPU:CODEC mappings in the core and in
  audio-graph-card2

ASoC:
- Lots of SOF updates: fallback support to older IPC versions,
  notification on control changes with IPC4.
  Also supports for ACPI parse for the ES83xx driver that reduces
  quirks.
- Device tree support for describing parts of the card which can be
  active over suspend (for very low power playback or wake word use
  cases)
- Support for more AMD and Intel systems, NXP i.MX8m MICFIL, Qualcomm
  SM8250, SM8550, SM8650 and X1E80100
- Drop of Freescale MPC8610 code that is no longer supported

HD-audio:
- More CS35L41 codec extensions for Dell, HP and Lenovo models
- TAS2781 codec extensions for Lenovo and co
- New PCM subformat supports

Others:
- More enhancement for Scarlett2 USB mixer support
- Various kselftest fixes

----------------------------------------------------------------

Amadeusz S³awiñski (18):
      ASoC: Intel: avs: da7219: Add proper id_table
      ASoC: Intel: avs: dmic: Add proper id_table
      ASoC: Intel: avs: es8336: Add proper id_table
      ASoC: Intel: avs: hdaudio: Add proper id_table
      ASoC: Intel: avs: i2s_test: Add proper id_table
      ASoC: Intel: avs: max98357a: Add proper id_table
      ASoC: Intel: avs: max98373: Add proper id_table
      ASoC: Intel: avs: max98927: Add proper id_table
      ASoC: Intel: avs: nau8825: Add proper id_table
      ASoC: Intel: avs: probe: Add proper id_table
      ASoC: Intel: avs: rt274: Add proper id_table
      ASoC: Intel: avs: rt286: Add proper id_table
      ASoC: Intel: avs: rt298: Add proper id_table
      ASoC: Intel: avs: rt5514: Add proper id_table
      ASoC: Intel: avs: rt5663: Add proper id_table
      ASoC: Intel: avs: rt5682: Add proper id_table
      ASoC: Intel: avs: ssm4567: Add proper id_table
      ASoC: dapm: Simplify widget clone

Arnd Bergmann (2):
      ASoC: fsl_rpmsg: update Kconfig dependencies
      ALSA: ac97: fix build regression

Baofeng Tian (3):
      ASoC: SOF: ipc4-topology: Add module ID print during module set up
      ASoC: SOF: align topology header file with sof topology header
      ASoC: SOF: add alignment for topology header file struct definition

Bard Liao (7):
      ASoC: Intel: sof_maxim_common: add else between 2 if test
      ASoC: Intel: sof_maxim_common: check return value
      ASoC: SOF: ipc4: check return value of snd_sof_ipc_msg_data
      ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43 and cs35l56 support
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: ctx->headset_codec_dev = NULL
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: check ctx->headset_codec_dev instead of playback
      ASoC: SOF: topology: Use partial match for disconnecting DAI link and DAI widget

Brent Lu (27):
      ASoC: Intel: sof_ssp_amp: remove dead code
      ASoC: Intel: ssp-common: get codec name function
      ASoC: Intel: board_helpers: support codec link initialization
      ASoC: Intel: sof_cs42l42: use common module for codec link
      ASoC: Intel: sof_nau8825: use common module for codec link
      ASoC: Intel: sof_rt5682: use common module for codec link
      ASoC: Intel: board_helpers: support amp link initialization
      ASoC: Intel: sof_cs42l42: use common module for amp link
      ASoC: Intel: sof_nau8825: use common module for amp link
      ASoC: Intel: sof_rt5682: use common module for amp link
      ASoC: Intel: sof_ssp_amp: use common module for amp link
      ASoC: Intel: sof_ssp_amp: rename function parameter
      ASoC: Intel: board_helpers: support BT offload link initialization
      ASoC: Intel: sof_cs42l42: use common module for BT offload link
      ASoC: Intel: sof_nau8825: use common module for BT offload link
      ASoC: Intel: sof_rt5682: use common module for BT offload link
      ASoC: Intel: sof_ssp_amp: use common module for BT offload link
      ASoC: Intel: sof_ssp_amp: simplify HDMI-In quirks
      ASoC: Intel: board_helpers: support HDMI-In link initialization
      ASoC: Intel: sof_rt5682: use common module for HDMI-In link
      ASoC: Intel: sof_ssp_amp: use common module for HDMI-In link
      ASoC: Intel: board_helpers: support DAI link array generation
      ASoC: Intel: sof_nau8825: use common module for DAI link generation
      ASoC: Intel: sof_rt5682: use common module for DAI link generation
      ASoC: Intel: sof_nau8825: board id cleanup for adl boards
      ASoC: Intel: sof_nau8825: board id cleanup for rpl boards
      ASoC: Intel: glk_rt5682_max98357a: fix board id mismatch

Cezary Rojewski (15):
      ALSA: hda: Honor subformat when querying PCMs
      ASoC: pcm: Honor subformat when configuring runtime
      ALSA: hda: Upgrade stream-format infrastructure
      ALSA: hda: Switch to new stream-format interface
      ALSA: hda/hdmi: Switch to new stream-format interface
      ALSA: hda/ca0132: Switch to new stream-format interface
      ASoC: codecs: hda: Switch to new stream-format interface
      ASoC: codecs: hdac_hda: Switch to new stream-format interface
      ASoC: codecs: hdac_hdmi: Switch to new stream-format interface
      ASoC: Intel Skylake: Switch to new stream-format interface
      ASoC: SOF: Intel: Switch to new stream-format interface
      ASoC: Intel: avs: Switch to new stream-format interface
      ALSA: hda: Drop snd_hdac_calc_stream_format()
      ASoC: Intel: avs: Kill S24_LE format
      ASoC: Intel: avs: Unhardcode HDAudio BE DAI drivers description

Chancel Liu (4):
      ASoC: dt-bindings: sound-card-common: List sound widgets ignoring system suspend
      ASoC: imx-rpmsg: Force codec power on in low power audio mode
      ASoC: dt-bindings: fsl,mqs: Convert format to json-schema
      ASoC: soc-pcm.c: Complete the active count for components without DAIs

Chao Song (6):
      ASoC: Intel: sof_sdw: remove unused function declaration
      ASoC: Intel: sof_sdw: Add rt722 support
      ASoC: Intel: soc-acpi: add Gen4.1 SDCA board support for LNL RVP
      ASoC: Intel: soc-acpi-intel-mtl-match: Add rt722 support
      ASoC: Intel: cht_bsw_rt5672: check return value
      ASoC: rt722-sdca: Set lane_control_support for multilane

Charles Keepax (3):
      ASoC: cs42l43: Add missing static from runtime PM ops
      ASoC: cs42l43: Allow HP amp to cool off after current limit
      ASoC: cs42l43: Add missing statics for hp_ilimit functions

Chen-Yu Tsai (1):
      ASoC: SOF: Move sof_of_machine_select() to core.c from sof-of-dev.c

Christophe JAILLET (3):
      ASoC: tegra: convert not to use dma_request_slave_channel()
      ASoC: sh: convert not to use dma_request_slave_channel()
      ASoC: sprd: Simplify memory allocation in sprd_platform_compr_dma_config()

Colin Ian King (2):
      ASoC: core: Fix a handful of spelling mistakes.
      ASoC: cs4271: Fix spelling mistake "retrieveing" -> "retrieving"

Cristian Ciocaltea (6):
      ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
      ASoC: amd: vangogh: Drop conflicting ACPI-based probing
      ASoC: amd: vangogh: Allow probing ACP PCI when SOF is disabled
      ASoC: amd: vangogh: Switch to {RUNTIME,SYSTEM_SLEEP}_PM_OPS
      ASoC: amd: acp-config: Add missing MODULE_DESCRIPTION
      ASoC: amd: acp: Add missing MODULE_DESCRIPTION in mach-common

Curtis Malainey (1):
      ASoC: SOF: Wire up buffer flags

Dan Carpenter (2):
      ASoC: amd: acp: remove unnecessary NULL check
      ASoC: audio-graph-card2: fix off by one in graph_parse_node_multi_nm()

Daniel Baluta (4):
      ASoC: SOF: imx8m: Add DAI driver entry for MICFIL PDM
      ASoC: SOF: Add support for configuring PDM interface from topology
      ASoC: audio-graph-card2: Introduce playback-only/capture-only DAI link flags
      ASoC: dt-bindings: audio-graph-port: Document new DAI link flags playback-only/capture-only

Daniel Golle (1):
      ASoC: mediatek: mt7986: silence error in case of -EPROBE_DEFER

David Lin (1):
      ASoC: nau8810: Fix incorrect type in assignment and cast to restricted __be16

Dmitry Antipov (1):
      ALSA: seq: fix kvmalloc_array() arguments order

Dorian Cruveiller (2):
      ALSA: hda/realtek: enable SND_PCI_QUIRK for Lenovo Legion Slim 7 Gen 8 (2023) serie
      ALSA: hda: Add driver properties for cs35l41 for Lenovo Legion Slim 7 Gen 8 serie

Duje Mihanoviæ (1):
      ASoC: pxa: sspa: Don't select SND_ARM

Fabio Estevam (1):
      ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts

Geoffrey D. Bennett (53):
      ALSA: scarlett2: Update maintainer info
      ALSA: scarlett2: Add missing error check to scarlett2_config_save()
      ALSA: scarlett2: Add missing error check to scarlett2_usb_set_config()
      ALSA: scarlett2: Add missing error checks to *_ctl_get()
      ALSA: scarlett2: Add clamp() in scarlett2_mixer_ctl_put()
      ALSA: scarlett2: Add missing mutex lock around get meter levels
      ALSA: scarlett2: Add #defines for firmware upgrade
      ALSA: scarlett2: Retrieve useful flash segment numbers
      ALSA: scarlett2: Add skeleton hwdep/ioctl interface
      ALSA: scarlett2: Add ioctl commands to erase flash segments
      ALSA: scarlett2: Add support for uploading new firmware
      ALSA: scarlett2: Simplify enums by removing explicit values
      ALSA: scarlett2: Infer has_msd_mode from config items
      ALSA: scarlett2: Infer standalone switch from config items
      ALSA: scarlett2: Check for phantom persistence config item
      ALSA: scarlett2: Check presence of mixer using mux_assignment
      ALSA: scarlett2: Add config set struct
      ALSA: scarlett2: Remove scarlett2_config_sets array
      ALSA: scarlett2: Add check for config_item presence
      ALSA: scarlett2: Refactor scarlett2_usb_set_config()
      ALSA: scarlett2: Refactor scarlett2_config_save()
      ALSA: scarlett2: Formatting fixes
      ALSA: scarlett2: Parameterise notifications
      ALSA: scarlett2: Change num_mux_* from int to u8
      ALSA: scarlett2: Refactor common port_count lookups
      ALSA: scarlett2: Remove struct scarlett2_usb_volume_status
      ALSA: scarlett2: Split dim_mute_update from vol_updated
      ALSA: scarlett2: Remove line_out_hw_vol device info entry
      ALSA: scarlett2: Allow for interfaces without per-channel volume
      ALSA: scarlett2: Add scarlett2_mixer_value_to_db()
      ALSA: scarlett2: Add #define for SCARLETT2_MIX_MAX
      ALSA: scarlett2: Rename db_scale_scarlett2_gain to volume
      ALSA: scarlett2: Split input_other into level/pad/air/phantom
      ALSA: scarlett2: Split direct_monitor out from monitor_other
      ALSA: scarlett2: Remove repeated elem->head.mixer references
      ALSA: scarlett2: Add support for air/phantom control on input 2
      ALSA: scarlett2: Add support for Gen 4 style parameters
      ALSA: scarlett2: Allow for controls with a "mute mode"
      ALSA: scarlett2: Add support for Air Presence + Drive option
      ALSA: scarlett2: Add support for software-controllable input gain
      ALSA: scarlett2: Minor refactor MSD mode check
      ALSA: scarlett2: Disable input controls while autogain is running
      ALSA: scarlett2: Disable autogain during phantom power state change
      ALSA: scarlett2: Add power status control
      ALSA: scarlett2: Store mix_ctls for Gen 4 Direct Monitor
      ALSA: scarlett2: Handle Gen 4 Direct Monitor mix updates
      ALSA: scarlett2: Add support for custom Gen 4 Direct Monitor mixes
      ALSA: scarlett2: Add support for DSP mux channels
      ALSA: scarlett2: Rename DSP mux channels
      ALSA: scarlett2: Add minimum firmware version check
      ALSA: scarlett2: Add R/O headphone volume control
      ALSA: scarlett2: Add support for Solo, 2i2, and 4i4 Gen 4
      ALSA: scarlett2: Add PCM Input Switch for Solo Gen 4

Gergo Koteles (7):
      ASoC: tas2781: add support for FW version 0x0503
      ALSA: hda/tas2781: configure the amp after firmware load
      ALSA: hda/tas2781: add ptrs to calibration functions
      ALSA: hda/tas2781: add configurable global i2c address
      ALSA: hda/tas2781: add TAS2563 support for 14ARB7
      ALSA: hda/tas2781: add fixup for Lenovo 14ARB7
      ALSA: hda/tas2781: annotate calibration data endianness

Ghanshyam Agrawal (2):
      ALSA: au88x0: fixed spelling mistakes in au88x0_core.c
      ALSA: au88x0: fixed a typo

Greg Kroah-Hartman (1):
      ALSA: mark all struct bus_type as const

Hans de Goede (9):
      ASoC: Intel: bytcht_es8316: Add is_bytcr helper variable
      ASoC: Intel: bytcht_es8316: Determine quirks/routing with codec-dev ACPI DSM
      ASoC: rt5645: Drop double EF20 entry from dmi_platform_data[]
      ASoC: rt5645: Add platform-data for Acer Switch V 10
      ASoC: rt5645: Refactor rt5645_parse_dt()
      ASoC: rt5645: Add rt5645_get_pdata() helper
      ASoC: rt5645: Add a rt5645_components() helper
      ASoC: rt5645: Add mono speaker information to the components string
      ASoC: Intel: cht_bsw_rt5645: Set card.components string

Himanshu Bhavani (1):
      ASoC: amd: acp: Remove redundant ret variable

Jack Yu (1):
      ASoC: rt5682s: Add LDO output selection for dacref

Jaroslav Kysela (1):
      ALSA: pcm: Introduce MSBITS subformat interface

Kamil Duljas (1):
      ASoC: SOF: icp3-dtrace: Fix wrong kfree() usage

Keguang Zhang (1):
      ASoC: sti-uniperf: Use default pcm_config instead

Krzysztof Kozlowski (21):
      ASoC: dt-bindings: qcom,sm8250: add SM8550 sound card
      ASoC: dt-bindings: use "soundwire" as controller's node name in examples
      ASoC: dt-bindings: correct white-spaces in examples
      ASoC: qcom: Add helper for allocating Soundwire stream runtime
      ASoC: qcom: Move Soundwire runtime stream alloc to soundcards
      ASoC: qcom: sc8280xp: set card driver name from match data
      ASoC: qcom: sc8280xp: Add support for SM8450 and SM8550
      ASoC: qcom: audioreach: Commonize setting channel mappings
      ASoC: qcom: audioreach: drop duplicate channel defines
      ASoC: qcom: audioreach: Add 4 channel support
      ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8650 LPASS RX
      ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8650 LPASS TX
      ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8650 LPASS VA
      ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8650 LPASS WSA
      ASoC: qcom: Add x1e80100 sound machine driver
      ASoC: dt-bindings: qcom,sm8250: Add X1E80100 sound card
      ASoC: qcom: Fix trivial code style issues
      ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS RX
      ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS TX
      ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS VA
      ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS WSA

Kuninori Morimoto (10):
      ASoC: makes CPU/Codec channel connection map more generic
      ASoC: audio-graph-card2: use better image for Multi connection
      ASoC: audio-graph-card2: add CPU:Codec = N:M support
      ASoC: audio-graph-card2-custom-sample: Add connection image
      ASoC: audio-graph-card2-custom-sample: add CPU/Codec = N:M sample
      ASoC: fsl: fsl-asoc-card: don't need DUMMY Platform
      ASoC: samsung: odroid: don't need DUMMY Platform
      ASoC: intel: hdaudio.c: use snd_soc_dummy_dlc
      ASoC: sof: use snd_soc_dummy_dlc
      ASoC: soc.h: don't create dummy Component via COMP_DUMMY()

Lad Prabhakar (1):
      ASoC: dt-bindings: renesas,rz-ssi: Document RZ/Five SoC

Linus Walleij (20):
      ASoC: cs35l32: Drop legacy include
      ASoC: cs35l33: Fix GPIO name and drop legacy include
      ASoC: cs35l34: Fix GPIO name and drop legacy include
      ASoC: cs35l35: Drop legacy includes
      ASoC: cs35l36: Drop legacy includes
      ASoC: cs4271: Convert to GPIO descriptors
      ASoC: cirrus: edb93xx: Drop legacy include
      ASoC: cs42l42: Drop legacy include
      ASoC: cs43130: Drop legacy includes
      ASoC: cs4349: Drop legacy include
      ASoC: wm0010: Convert to GPIO descriptors
      ASoC: wm1250-ev1: Convert to GPIO descriptors
      ASoC: wm2200: Convert to GPIO descriptors
      ASoC: wm5100: Convert to GPIO descriptors
      ASoC: wm8996: Convert to GPIO descriptors
      ASoC: wm1250-ev1: Fix uninitialized ret
      ASoC: hisilicon: Drop GPIO include
      ASoC: qcom: sc7180: Drop GPIO include
      ASoC: simple-card-utils: Drop GPIO include
      ASoC: tegra: tegra20_ac97: Convert to use GPIO descriptors

Lorenz Brun (1):
      ALSA: hda: cs35l41: Support more HP models without _DSD

Lucas Tanure (1):
      ASoC: fsl_mqs: Remove duplicate linux/of.h header

Mac Chiang (2):
      ASoC: Intel: sof_rt5682: add mtl_rt5650 support
      ASoC: Intel: soc-acpi: rt713+rt1316, no sdw-dmic config

Maciej Strozek (5):
      ASoC: cs43130: Store device in private struct and use it more consistently
      ASoC: cs43130: Add handling of ACPI
      ASoC: cs43130: Add switch to control normal and alt hp inputs
      ASoC: cs43130: Allow driver to work without IRQ connection
      ASoC: cs43130: Allow configuration of bit clock and frame inversion

Michael Ellerman (1):
      ASoC: fsl: mpc8610_hpcd: Remove unused driver

Mirsad Todorovac (4):
      kselftest/alsa - mixer-test: fix the number of parameters to ksft_exit_fail_msg()
      kselftest/alsa - mixer-test: Fix the print format specifier warning
      kselftest/alsa - mixer-test: Fix the print format specifier warning
      kselftest/alsa - conf: Stringify the printed errno in sysfs_get()

Neil Armstrong (4):
      ASoC: codec: wsa884x: make use of new mute_unmute_on_trigger flag
      ASoC: dt-bindings: qcom,sm8250: document SM8650 sound card
      ASoC: qcom: sc8280xp: Add support for SM8650
      ASoC: dt-bindings: qcom,lpass-va-macro: remove spurious contains in if statement

Peter Ujfalusi (21):
      ASoC: SOF: ipc4-topology: Helper to find an swidget by module/instance id
      ASoC: SOF: ipc4: Add data struct for module notification message from firmware
      ASoC: SOF: ipc4-control: Implement control update for switch/enum controls
      ASoC: SOF: ipc4: Handle ALSA kcontrol change notification from firmware
      ASoC: SOF: Intel: Use existing helpers to change GPROCEN and PIE bits
      ASoC: Intel: sof_sdw: Make use of dev_err_probe()
      ASoC: SOF: Move sof_of_machine_select() to sof-of-dev.c from sof-audio.c
      ASoC: SOF: Move sof_machine_* functions from sof-audio.c to core.c
      ASoC: SOF: Add placeholder for platform IPC type and path overrides
      ASoC: SOF: sof-acpi-dev: Save the default IPC type and path overrides
      ASoC: SOF: sof-of-dev: Save the default IPC type and path overrides
      ASoC: SOF: sof-pci-dev: Save the default IPC type and path overrides
      ASoC: SOF: core: Implement firmware, topology path setup in core
      ASoC: SOF: sof-acpi-dev: Rely on core to create the file paths
      ASoC: SOF: sof-of-dev: Rely on core to create the file paths
      ASoC: SOF: sof-pci-dev: Rely on core to create the file paths
      ASoC: SOF: core: Add helper for initialization of paths, ops
      ASoC: SOF: Intel: Do not use resource managed allocation for ipc4_data
      ASoC: SOF: core: Implement IPC version fallback if firmware files are missing
      ASoC: SOF: ipc4: Move window offset configuration earlier
      ASoC: SOF: Intel: hda-codec: Delay the codec device registration

Philipp Stanner (1):
      ALSA: wavefront: copy userspace array safely

Pierre-Louis Bossart (7):
      ASoC: es83xx: add ACPI DSM helper module
      ASoC: Intel: bytcht_es8316: Dump basic _DSM information
      PCI: add INTEL_HDA_ARL to pci_ids.h
      ALSA: hda: Intel: add HDA_ARL PCI ID support
      ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL
      ASoC: SOF: Intel: pci-mtl: fix ARL-S definitions
      ASoC: SOF: Intel: pci-mtl: add HDA_ARL PCI support

Rander Wang (4):
      ASoC: SOF: Intel: lnl: add core get and set support for dsp core
      ASoC: SOF: IPC4: synchronize fw_config_params with fw definitions
      ASoC: SOF: IPC4: query fw_context_save feature from fw
      ASoC: SOF: Intel: check fw_context_save for library reload

Richard Fitzgerald (1):
      ASoC: Intel: sof_sdw_cs_amp: Connect outputs to a speaker widget

Rob Herring (1):
      ASoC: dt-bindings: Simplify port schema

Rui Zhou (4):
      ASoC: dt-bindings: mt8188-mt6359: add es8326 support
      ASoC: mediatek: mt8188-mt6359: commonize headset codec init/exit api
      ASoC: mediatek: mt8188-mt6359: add es8326 support
      ASoC: mediatek: mt8188-mt6359: Enable dual amp for mt8188-rt5682s

Sebastian Reichel (1):
      dt-bindings: es8328: convert to DT schema format

Seven Lee (2):
      ASoC: dt-bindings: nau8821: Add DMIC slew rate.
      ASoC: nau8821: Add slew rate controls.

Shengjiu Wang (1):
      ASoC: SOF: imx: Add SNDRV_PCM_INFO_BATCH flag

Shuming Fan (1):
      ASoC: rt5663: cancel the work when system suspends

Stefan Binding (3):
      ALSA: hda: cs35l41: Support additional Dell models without _DSD
      ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low
      ALSA: hda/realtek: Add quirks for Dell models

Syed Saba Kareem (5):
      ASoC: amd: acp: Fix for indentation issue
      ASoC: amd: acp: correct the format order
      ASoC: amd: acp: add Kconfig options for acp7.0 based platform driver
      ASoC: amd: acp: add missing SND_SOC_AMD_ACP_LEGACY_COMMON flag for ACP70
      ASoC: amd: acp: add pm ops support for renoir platform.

Takashi Iwai (1):
      ALSA: hda: Refer to correct stream index at loops

Tom Jason Schwanke (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 13-ay0xxx

Trevor Wu (3):
      ASoC: SOF: mediatek: mt8195: clean up unused code
      ASoC: SOF: mediatek: mt8186: clean up unused code
      ASoC: SOF: mediatek: remove unused variables

Venkata Prasad Potturu (13):
      ASoC: amd: Add new dmi entries for acp5x platform
      ASoC: amd: vangogh: Add condition check for acp config flag
      ASoC: amd: Remove extra dmi parameter
      ASoC: amd: acp: Add new cpu dai and dailink creation for I2S BT instance
      ASoC: amd: acp: Add i2s bt support for nau8821-max card
      ASoC: amd: acp: Enable dpcm_capture for MAX98388 codec
      ASoC: amd: acp: Set bclk as source to set pll for rt5682s codec
      ASoC: amd: acp: Set bclk as source to set pll for rt5682s codec
      ASoC: SOF: amd: Refactor spinlock_irq(&sdev->ipc_lock) sequence in irq_handler
      ASoC: SOF: Refactor sof_i2s_tokens reading to update acpbt dai
      ASoC: SOF: Add i2s bt dai configuration support for AMD platforms
      ASoC: SOF: Rename amd_bt sof_dai_type
      ASoC: SOF: amd: Add acp-psp mailbox interface for iram-dram fence register modification

Vijendar Mukunda (1):
      ASoC: amd: acp: modify config flag read logic

Wang Jinchao (2):
      ASoC: SOF: amd: remove duplicated including
      ASoC: fsl_mqs: remove duplicated including

Weidong Wang (1):
      ASoC: codecs: Modify the bin file parsing method

Yong Zhi (1):
      ASoC: SOF: Intel: mtl: call dsp dump when boot retry fails

Zhu Ning (3):
      ASoC: codecs: ES8326: Add chip version flag
      ASoC: codecs: ES8326: Changing initialisation and broadcasting
      ASoC: codecs: ES8326: Changing the headset detection time

bo liu (1):
      ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140

---
 .../devicetree/bindings/sound/adi,max98363.yaml    |    2 +-
 .../bindings/sound/audio-graph-port.yaml           |    6 +
 Documentation/devicetree/bindings/sound/es8328.txt |   38 -
 .../devicetree/bindings/sound/everest,es8328.yaml  |   77 +
 .../devicetree/bindings/sound/fsl,mqs.txt          |   36 -
 .../devicetree/bindings/sound/fsl,mqs.yaml         |  105 +
 .../devicetree/bindings/sound/fsl,xcvr.yaml        |   22 +-
 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |    1 +
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml |    9 +
 .../bindings/sound/qcom,lpass-rx-macro.yaml        |   23 +-
 .../bindings/sound/qcom,lpass-tx-macro.yaml        |   25 +-
 .../bindings/sound/qcom,lpass-va-macro.yaml        |   18 +-
 .../bindings/sound/qcom,lpass-wsa-macro.yaml       |   23 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    6 +
 .../devicetree/bindings/sound/qcom,wcd934x.yaml    |    4 +-
 .../bindings/sound/qcom,wcd938x-sdw.yaml           |    4 +-
 .../devicetree/bindings/sound/qcom,wcd938x.yaml    |    4 +-
 .../devicetree/bindings/sound/qcom,wsa883x.yaml    |    2 +-
 .../devicetree/bindings/sound/qcom,wsa8840.yaml    |    2 +-
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   36 +-
 .../devicetree/bindings/sound/renesas,rz-ssi.yaml  |    2 +-
 .../bindings/sound/sound-card-common.yaml          |    7 +
 .../bindings/sound/ti,tlv320aic32x4.yaml           |    2 +-
 Documentation/sound/soc/dapm.rst                   |    2 +-
 MAINTAINERS                                        |    8 +-
 arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi      |    2 +-
 arch/arm/mach-ep93xx/edb93xx.c                     |   32 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |   12 +-
 arch/arm/mach-s3c/mach-crag6410-module.c           |   60 +-
 arch/arm/mach-s3c/mach-crag6410.c                  |   24 +-
 drivers/soundwire/qcom.c                           |   33 +-
 include/linux/pci_ids.h                            |    1 +
 include/sound/ac97_codec.h                         |    2 +-
 include/sound/cs4271.h                             |    1 -
 include/sound/hda_codec.h                          |    5 +-
 include/sound/hdaudio.h                            |   15 +-
 include/sound/pcm.h                                |    7 +
 include/sound/pcm_params.h                         |    2 +
 include/sound/rt5682s.h                            |    8 +
 include/sound/simple_card_utils.h                  |    3 +
 include/sound/soc.h                                |   59 +-
 include/sound/sof.h                                |   15 +
 include/sound/sof/dai-imx.h                        |    7 +
 include/sound/sof/dai.h                            |    2 +
 include/sound/sof/ipc4/header.h                    |   35 +
 include/sound/sof/topology.h                       |   61 +-
 include/sound/tas2781.h                            |    8 +
 include/sound/wm0010.h                             |    6 -
 include/sound/wm1250-ev1.h                         |   24 -
 include/sound/wm2200.h                             |    2 -
 include/sound/wm5100.h                             |    4 -
 include/sound/wm8996.h                             |    3 -
 include/uapi/sound/asound.h                        |    7 +-
 include/uapi/sound/scarlett2.h                     |   54 +
 include/uapi/sound/sof/tokens.h                    |    5 +
 sound/ac97/bus.c                                   |    5 +-
 sound/ac97_bus.c                                   |    2 +-
 sound/core/pcm.c                                   |    3 +
 sound/core/pcm_lib.c                               |   34 +
 sound/core/pcm_native.c                            |   55 +-
 sound/core/seq/seq_memory.c                        |    3 +-
 sound/hda/hda_bus_type.c                           |    2 +-
 sound/hda/hdac_device.c                            |  168 +-
 sound/hda/hdac_stream.c                            |    9 +-
 sound/hda/intel-dsp-config.c                       |   10 +
 sound/isa/wavefront/wavefront_fx.c                 |    6 +-
 sound/pci/au88x0/au88x0.c                          |    2 +-
 sound/pci/au88x0/au88x0_core.c                     |   10 +-
 sound/pci/hda/cs35l41_hda.c                        |   25 +-
 sound/pci/hda/cs35l41_hda.h                        |   12 +-
 sound/pci/hda/cs35l41_hda_i2c.c                    |    2 +-
 sound/pci/hda/cs35l41_hda_property.c               |  126 +-
 sound/pci/hda/cs35l41_hda_spi.c                    |    2 +-
 sound/pci/hda/hda_codec.c                          |    2 +
 sound/pci/hda/hda_controller.c                     |   10 +-
 sound/pci/hda/hda_intel.c                          |    2 +
 sound/pci/hda/patch_ca0132.c                       |    3 +-
 sound/pci/hda/patch_conexant.c                     |  115 +-
 sound/pci/hda/patch_hdmi.c                         |    6 +-
 sound/pci/hda/patch_realtek.c                      |   32 +
 sound/pci/hda/tas2781_hda_i2c.c                    |  117 +-
 sound/soc/amd/acp-config.c                         |   39 +-
 sound/soc/amd/acp/Kconfig                          |   13 +
 sound/soc/amd/acp/Makefile                         |    2 +
 sound/soc/amd/acp/acp-mach-common.c                |   59 +-
 sound/soc/amd/acp/acp-mach.h                       |    3 +
 sound/soc/amd/acp/acp-renoir.c                     |   37 +
 sound/soc/amd/acp/acp-sof-mach.c                   |    4 +-
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c      |    3 +-
 sound/soc/amd/acp/acp63.c                          |   22 +-
 sound/soc/amd/acp/acp70.c                          |   28 +-
 sound/soc/amd/vangogh/acp5x-mach.c                 |   35 +-
 sound/soc/amd/vangogh/pci-acp5x.c                  |   22 +-
 sound/soc/cirrus/edb93xx.c                         |    1 -
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/aw88395/aw88395_device.h          |    1 +
 sound/soc/codecs/aw88395/aw88395_lib.c             |  124 +-
 sound/soc/codecs/aw88395/aw88395_reg.h             |    3 -
 sound/soc/codecs/aw88399.c                         |    1 -
 sound/soc/codecs/aw88399.h                         |    1 +
 sound/soc/codecs/cs35l32.c                         |    1 -
 sound/soc/codecs/cs35l33.c                         |    4 +-
 sound/soc/codecs/cs35l34.c                         |    4 +-
 sound/soc/codecs/cs35l35.c                         |    2 -
 sound/soc/codecs/cs35l36.c                         |    3 +-
 sound/soc/codecs/cs4271.c                          |   39 +-
 sound/soc/codecs/cs42l42.c                         |    1 -
 sound/soc/codecs/cs42l42.h                         |    2 +-
 sound/soc/codecs/cs42l43-jack.c                    |    4 +-
 sound/soc/codecs/cs42l43.c                         |   92 +-
 sound/soc/codecs/cs42l43.h                         |    9 +
 sound/soc/codecs/cs43130.c                         |  320 +-
 sound/soc/codecs/cs43130.h                         |    3 +
 sound/soc/codecs/cs4349.c                          |    1 -
 sound/soc/codecs/es8326.c                          |  229 +-
 sound/soc/codecs/es83xx-dsm-common.c               |   89 +
 sound/soc/codecs/es83xx-dsm-common.h               |  393 ++
 sound/soc/codecs/hda-dai.c                         |    7 +-
 sound/soc/codecs/hda.c                             |    2 +
 sound/soc/codecs/hdac_hda.c                        |    8 +-
 sound/soc/codecs/hdac_hdmi.c                       |   10 +-
 sound/soc/codecs/nau8810.c                         |    9 +-
 sound/soc/codecs/nau8821.c                         |    7 +
 sound/soc/codecs/nau8821.h                         |    3 +
 sound/soc/codecs/rt5645.c                          |  113 +-
 sound/soc/codecs/rt5645.h                          |    3 +
 sound/soc/codecs/rt5663.c                          |   11 +
 sound/soc/codecs/rt5682s.c                         |   23 +
 sound/soc/codecs/rt5682s.h                         |    7 +
 sound/soc/codecs/rt722-sdca-sdw.c                  |    3 +
 sound/soc/codecs/tas2781-comlib.c                  |   15 +
 sound/soc/codecs/tas2781-fmwlib.c                  |    1 +
 sound/soc/codecs/wm0010.c                          |   44 +-
 sound/soc/codecs/wm1250-ev1.c                      |  115 +-
 sound/soc/codecs/wm2200.c                          |   67 +-
 sound/soc/codecs/wm5100.c                          |  107 +-
 sound/soc/codecs/wm8996.c                          |   58 +-
 sound/soc/codecs/wsa884x.c                         |    7 +-
 sound/soc/fsl/Kconfig                              |   14 +-
 sound/soc/fsl/Makefile                             |    4 -
 sound/soc/fsl/fsl-asoc-card.c                      |    3 +-
 sound/soc/fsl/fsl_mqs.c                            |    2 -
 sound/soc/fsl/imx-rpmsg.c                          |   61 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |  451 --
 sound/soc/generic/audio-graph-card.c               |    1 -
 .../generic/audio-graph-card2-custom-sample.dtsi   |  380 +-
 sound/soc/generic/audio-graph-card2.c              |  296 +-
 sound/soc/generic/simple-card-utils.c              |   20 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |    1 -
 sound/soc/intel/avs/boards/da7219.c                |   10 +-
 sound/soc/intel/avs/boards/dmic.c                  |   10 +-
 sound/soc/intel/avs/boards/es8336.c                |   10 +-
 sound/soc/intel/avs/boards/hdaudio.c               |   16 +-
 sound/soc/intel/avs/boards/i2s_test.c              |   10 +-
 sound/soc/intel/avs/boards/max98357a.c             |   10 +-
 sound/soc/intel/avs/boards/max98373.c              |   10 +-
 sound/soc/intel/avs/boards/max98927.c              |   10 +-
 sound/soc/intel/avs/boards/nau8825.c               |   10 +-
 sound/soc/intel/avs/boards/probe.c                 |   10 +-
 sound/soc/intel/avs/boards/rt274.c                 |   10 +-
 sound/soc/intel/avs/boards/rt286.c                 |   10 +-
 sound/soc/intel/avs/boards/rt298.c                 |   10 +-
 sound/soc/intel/avs/boards/rt5514.c                |   10 +-
 sound/soc/intel/avs/boards/rt5663.c                |   10 +-
 sound/soc/intel/avs/boards/rt5682.c                |   10 +-
 sound/soc/intel/avs/boards/ssm4567.c               |   10 +-
 sound/soc/intel/avs/loader.c                       |    4 +-
 sound/soc/intel/avs/path.c                         |    2 +-
 sound/soc/intel/avs/pcm.c                          |   58 +-
 sound/soc/intel/avs/probes.c                       |    3 +-
 sound/soc/intel/avs/topology.c                     |   13 +-
 sound/soc/intel/boards/Kconfig                     |    2 +
 sound/soc/intel/boards/Makefile                    |    3 +-
 sound/soc/intel/boards/bytcht_es8316.c             |   71 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    8 +
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    8 +-
 sound/soc/intel/boards/sof_board_helpers.c         |  330 ++
 sound/soc/intel/boards/sof_board_helpers.h         |   31 +
 sound/soc/intel/boards/sof_cs42l42.c               |  229 +-
 sound/soc/intel/boards/sof_maxim_common.c          |   13 +-
 sound/soc/intel/boards/sof_nau8825.c               |  272 +-
 sound/soc/intel/boards/sof_rt5682.c                |  355 +-
 sound/soc/intel/boards/sof_sdw.c                   |   60 +-
 sound/soc/intel/boards/sof_sdw_common.h            |   18 +-
 sound/soc/intel/boards/sof_sdw_cs_amp.c            |   30 +-
 sound/soc/intel/boards/sof_sdw_rt722_sdca.c        |   97 +
 .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   15 +-
 sound/soc/intel/boards/sof_ssp_amp.c               |  160 +-
 sound/soc/intel/boards/sof_ssp_common.c            |   21 +
 sound/soc/intel/boards/sof_ssp_common.h            |    1 +
 sound/soc/intel/common/soc-acpi-intel-adl-match.c  |    8 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c  |   14 +-
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |   71 +
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |   86 +
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c  |    6 +-
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  |   78 +
 sound/soc/intel/skylake/skl-pcm.c                  |   13 +-
 sound/soc/mediatek/Kconfig                         |    1 +
 sound/soc/mediatek/mt7986/mt7986-wm8960.c          |    2 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |  125 +-
 sound/soc/pxa/Kconfig                              |    1 -
 sound/soc/qcom/Kconfig                             |   12 +
 sound/soc/qcom/Makefile                            |    2 +
 sound/soc/qcom/apq8016_sbc.c                       |    2 +-
 sound/soc/qcom/apq8096.c                           |    2 +-
 sound/soc/qcom/common.c                            |    2 +-
 sound/soc/qcom/lpass-apq8016.c                     |    2 +-
 sound/soc/qcom/lpass-cpu.c                         |    2 +-
 sound/soc/qcom/lpass-hdmi.c                        |    2 +-
 sound/soc/qcom/lpass-ipq806x.c                     |    2 +-
 sound/soc/qcom/lpass-platform.c                    |    2 +-
 sound/soc/qcom/lpass-sc7180.c                      |    2 +-
 sound/soc/qcom/lpass.h                             |    2 +-
 sound/soc/qcom/qdsp6/audioreach.c                  |   55 +-
 sound/soc/qcom/qdsp6/audioreach.h                  |    2 -
 sound/soc/qcom/qdsp6/q6afe.c                       |    8 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |    4 +-
 sound/soc/qcom/qdsp6/q6asm.h                       |   20 +-
 sound/soc/qcom/qdsp6/topology.c                    |    3 +-
 sound/soc/qcom/sc7180.c                            |    3 +-
 sound/soc/qcom/sc8280xp.c                          |   24 +-
 sound/soc/qcom/sdm845.c                            |    2 +-
 sound/soc/qcom/sdw.c                               |   47 +-
 sound/soc/qcom/sdw.h                               |    1 +
 sound/soc/qcom/sm8250.c                            |   17 +-
 sound/soc/qcom/storm.c                             |    2 +-
 sound/soc/qcom/x1e80100.c                          |  168 +
 sound/soc/samsung/odroid.c                         |    3 +-
 sound/soc/sh/fsi.c                                 |    4 +-
 sound/soc/soc-core.c                               |  127 +-
 sound/soc/soc-dapm.c                               |   75 +-
 sound/soc/soc-pcm.c                                |   62 +-
 sound/soc/sof/Kconfig                              |   11 +
 sound/soc/sof/Makefile                             |    3 +-
 sound/soc/sof/amd/acp-common.c                     |    1 -
 sound/soc/sof/amd/acp-ipc.c                        |    4 +-
 sound/soc/sof/amd/acp.c                            |   14 +
 sound/soc/sof/amd/acp.h                            |    5 +
 sound/soc/sof/core.c                               |  311 +-
 sound/soc/sof/fw-file-profile.c                    |  322 ++
 sound/soc/sof/imx/imx8.c                           |    1 +
 sound/soc/sof/imx/imx8m.c                          |    8 +
 sound/soc/sof/imx/imx8ulp.c                        |    1 +
 sound/soc/sof/intel/apl.c                          |    2 +-
 sound/soc/sof/intel/cnl.c                          |    2 +-
 sound/soc/sof/intel/hda-dai-ops.c                  |   21 +-
 sound/soc/sof/intel/hda-dai.c                      |    3 +
 sound/soc/sof/intel/hda-loader.c                   |   10 +-
 sound/soc/sof/intel/hda.c                          |    6 +-
 sound/soc/sof/intel/hda.h                          |    1 +
 sound/soc/sof/intel/icl.c                          |    2 +-
 sound/soc/sof/intel/lnl.c                          |    8 +-
 sound/soc/sof/intel/mtl.c                          |   51 +-
 sound/soc/sof/intel/mtl.h                          |    3 +
 sound/soc/sof/intel/pci-mtl.c                      |   33 +-
 sound/soc/sof/intel/skl.c                          |    2 +-
 sound/soc/sof/intel/tgl.c                          |    4 +-
 sound/soc/sof/ipc3-dtrace.c                        |    3 +-
 sound/soc/sof/ipc3-pcm.c                           |   11 +
 sound/soc/sof/ipc3-topology.c                      |   59 +-
 sound/soc/sof/ipc4-control.c                       |  179 +
 sound/soc/sof/ipc4-loader.c                        |    3 +
 sound/soc/sof/ipc4-priv.h                          |    4 +
 sound/soc/sof/ipc4-topology.c                      |   32 +-
 sound/soc/sof/ipc4.c                               |  121 +-
 sound/soc/sof/mediatek/adsp_helper.h               |    4 -
 sound/soc/sof/mediatek/mt8186/mt8186.c             |   49 -
 sound/soc/sof/mediatek/mt8195/mt8195.c             |   49 -
 sound/soc/sof/sof-acpi-dev.c                       |   14 +-
 sound/soc/sof/sof-audio.c                          |  120 -
 sound/soc/sof/sof-audio.h                          |    1 +
 sound/soc/sof/sof-client-probes.c                  |    4 +-
 sound/soc/sof/sof-of-dev.c                         |   13 +-
 sound/soc/sof/sof-pci-dev.c                        |  102 +-
 sound/soc/sof/sof-priv.h                           |    9 +-
 sound/soc/sof/topology.c                           |   10 +-
 sound/soc/sprd/sprd-pcm-compress.c                 |    6 +-
 sound/soc/sti/sti_uniperif.c                       |    7 +-
 sound/soc/tegra/tegra20_ac97.c                     |   53 +-
 sound/soc/tegra/tegra20_ac97.h                     |    4 +-
 sound/soc/tegra/tegra_pcm.c                        |    4 +-
 sound/usb/mixer_quirks.c                           |    3 +
 sound/usb/mixer_scarlett2.c                        | 4659 +++++++++++++++++---
 tools/include/uapi/sound/asound.h                  |    7 +-
 tools/testing/selftests/alsa/conf.c                |    2 +-
 tools/testing/selftests/alsa/mixer-test.c          |    6 +-
 287 files changed, 10603 insertions(+), 3989 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/es8328.txt
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8328.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.yaml
 delete mode 100644 include/sound/wm1250-ev1.h
 create mode 100644 include/uapi/sound/scarlett2.h
 mode change 100644 => 100755 sound/soc/codecs/es8326.c
 create mode 100644 sound/soc/codecs/es83xx-dsm-common.c
 create mode 100644 sound/soc/codecs/es83xx-dsm-common.h
 delete mode 100644 sound/soc/fsl/mpc8610_hpcd.c
 create mode 100644 sound/soc/intel/boards/sof_sdw_rt722_sdca.c
 create mode 100644 sound/soc/qcom/x1e80100.c
 create mode 100644 sound/soc/sof/fw-file-profile.c



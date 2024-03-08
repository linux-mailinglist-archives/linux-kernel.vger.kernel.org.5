Return-Path: <linux-kernel+bounces-96995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33281876432
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A561F22A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8EA56B83;
	Fri,  8 Mar 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x+FX2zXO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6iUr9nq9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x+FX2zXO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6iUr9nq9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE056459;
	Fri,  8 Mar 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900523; cv=none; b=K20/ZSe+Aui7Audpez8qiTw+nDsemlgNu8+a9dNR0Iunm15qkQdritRSNqbhkDqyvU0oO8mo24hzjEYqLzIGBp7hwt1dOgA4uD8FRGlYn8gDy5J5s6+eQbjJpaiK/T/EHQkJCjnFc8haFibMJw3E+RwXuc01on7nBKMAZ3ZNEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900523; c=relaxed/simple;
	bh=g5ixp0fYy/59trzeP0NPiDYMEkNcgTm9omBN8m96Uik=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=mcEZTh7HI2MSEuuEg1Dsf7nLIMUG2Yd2Rvw9pPNKY/FGZR6ZphETE7GY4Nt0Gp3gF743pEM9QlmbFPM5BCBdJWtbGy6qxHa1QwwRs9vqX48nnxi3lLKfVnJ6vpYbT5zL4a/4cO/XholHbsE0wYeDzeuEHTIsUsQY8TjQlSYO7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x+FX2zXO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6iUr9nq9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x+FX2zXO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6iUr9nq9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98947201E5;
	Fri,  8 Mar 2024 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709900519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DFWYxwJfs4ybUP74ibrFRJ+zlS34JclQA7ZTGwHJbJM=;
	b=x+FX2zXO3kreMbCuMVZAZtnJJ4BxpkpP4FzjAl31wGmxhFtdr8uMe8jKG71YYOwXcfgArR
	5PPYiAD0GRvKLSh0iiliuONzUi0HtFiaz5XQ8+6LGGEW90gpQ3T/AAJ7oncoNMf7SBz0VA
	zUmwnoOjOF/kbcBGhe4Qre+VLrZNoVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709900519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DFWYxwJfs4ybUP74ibrFRJ+zlS34JclQA7ZTGwHJbJM=;
	b=6iUr9nq9v4S9lYpr+kbEEPcxdJbFr3zi/rM9k4cY2CqKV/1RIX9pLGGj0OgumCTwtvUj8X
	VimptQbsQIMJSRBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709900519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DFWYxwJfs4ybUP74ibrFRJ+zlS34JclQA7ZTGwHJbJM=;
	b=x+FX2zXO3kreMbCuMVZAZtnJJ4BxpkpP4FzjAl31wGmxhFtdr8uMe8jKG71YYOwXcfgArR
	5PPYiAD0GRvKLSh0iiliuONzUi0HtFiaz5XQ8+6LGGEW90gpQ3T/AAJ7oncoNMf7SBz0VA
	zUmwnoOjOF/kbcBGhe4Qre+VLrZNoVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709900519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DFWYxwJfs4ybUP74ibrFRJ+zlS34JclQA7ZTGwHJbJM=;
	b=6iUr9nq9v4S9lYpr+kbEEPcxdJbFr3zi/rM9k4cY2CqKV/1RIX9pLGGj0OgumCTwtvUj8X
	VimptQbsQIMJSRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B87F13310;
	Fri,  8 Mar 2024 12:21:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kqq2FOcC62UmDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Mar 2024 12:21:59 +0000
Date: Fri, 08 Mar 2024 13:21:58 +0100
Message-ID: <87plw4vrq1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.8
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.8 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8

The topmost commit is 21e59fe2f7221cdc77b2e5ef90a04c302b237053

----------------------------------------------------------------

sound fixes for 6.8-final

A collection of small fixes.  A half of them are HD-audio quirks while
the rest are various device-specific ASoC fixes.

----------------------------------------------------------------

Al Raj Hassain (1):
      ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI quirk table

Alban Boyé (1):
      ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet

Andreas Pape (1):
      ASoC: rcar: adg: correct TIMSEL setting for SSI9

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook

Kailang Yang (2):
      ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform
      ALSA: hda/realtek - Add Headset Mic supported Acer NB platform

Rob Herring (1):
      ASoC: dt-bindings: nvidia: Fix 'lge' vendor prefix

Stefan Binding (3):
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P
      ALSA: hda/realtek: Add quirks for Lenovo Thinkbook 16P laptops
      ALSA: hda: cs35l41: Overwrite CS35L41 configuration for ASUS UM5302LA

Stuart Henderson (4):
      ASoC: madera: Fix typo in madera_set_fll_clks shift value
      ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
      ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
      ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll

songxiebing (1):
      ALSA: hda: optimize the probe codec process

---
 .../sound/nvidia,tegra-audio-max9808x.yaml         |  2 +-
 sound/pci/hda/cs35l41_hda_property.c               |  6 +++++
 sound/pci/hda/hda_controller.c                     |  3 +++
 sound/pci/hda/patch_realtek.c                      | 15 +++++++++--
 sound/soc/amd/yc/acp6x-mach.c                      |  7 ++++++
 sound/soc/codecs/madera.c                          |  2 +-
 sound/soc/codecs/wm8962.c                          | 29 ++++++++++++++--------
 sound/soc/intel/boards/bytcr_rt5640.c              | 12 +++++++++
 sound/soc/sh/rcar/adg.c                            |  7 ++++++
 9 files changed, 69 insertions(+), 14 deletions(-)



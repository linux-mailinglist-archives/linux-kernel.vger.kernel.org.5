Return-Path: <linux-kernel+bounces-88257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57286DF49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3131C215F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD267E74;
	Fri,  1 Mar 2024 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ubjdcUNa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cffUrO9L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ubjdcUNa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cffUrO9L"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577341E4BD;
	Fri,  1 Mar 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289408; cv=none; b=f+Ww58qLicSbex9YMQM3Pded1c4Y3aD8tobGW+CkGfYYpF6SfCk/XX4lWj30DE9av98dnh9pQGqV+EAxgHYY+ZZvZiOhh0mdcn7bPDUCl46ucktiuxcBj3+xbtU9BGEPDbAjc7ER7Q1eZXzYu9vo+VTUf4MUOXX2pf4TZXqFU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289408; c=relaxed/simple;
	bh=C4l3an7f5mqxgSVgCMxQ+YelMOT39slYRkY8Ig9AT/w=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=Xuwzn//ubga18y4OXHhfffKegzc+g9EyXOGF65pxI19zDijwsufQmyWPpbPUNT4uvGgI2YabQlEqvRpYQVj1LiAEl71vK5SJO6UTDonh9zd5NNHiij7mwqUH1lak2SVF0K7SAV0HTccMEBBWNzd2uzYL7wK4Nv1LCOy1vB0Vppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ubjdcUNa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cffUrO9L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ubjdcUNa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cffUrO9L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84211336DA;
	Fri,  1 Mar 2024 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709289404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=7lP9mv/TOStEwOZNfpSVS2aLQRv5lETQH/OLJx5+RR8=;
	b=ubjdcUNaPp/Q4bp4oxHQ6WA+ASmiUOD+WpnGDKqhQ+YaM7pvSkmqMULBDX6IizvSKMxdw+
	4XMKqBjNKQh3mXdXgSYJeEGAD033PqzzWoosLy3crAV7VRAKXto1Zo9d58XpCuJnDNTns2
	f7BvzPsfqYCg2AKpo+fVxTvobJw8dNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709289404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=7lP9mv/TOStEwOZNfpSVS2aLQRv5lETQH/OLJx5+RR8=;
	b=cffUrO9LHUh25hPiWgpp9mce475BgSfXTRB05NI1S6b1+jQSvDDyO9NSJQlsi750+BdX9j
	q/QwiXRjzdyyRuCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709289404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=7lP9mv/TOStEwOZNfpSVS2aLQRv5lETQH/OLJx5+RR8=;
	b=ubjdcUNaPp/Q4bp4oxHQ6WA+ASmiUOD+WpnGDKqhQ+YaM7pvSkmqMULBDX6IizvSKMxdw+
	4XMKqBjNKQh3mXdXgSYJeEGAD033PqzzWoosLy3crAV7VRAKXto1Zo9d58XpCuJnDNTns2
	f7BvzPsfqYCg2AKpo+fVxTvobJw8dNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709289404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=7lP9mv/TOStEwOZNfpSVS2aLQRv5lETQH/OLJx5+RR8=;
	b=cffUrO9LHUh25hPiWgpp9mce475BgSfXTRB05NI1S6b1+jQSvDDyO9NSJQlsi750+BdX9j
	q/QwiXRjzdyyRuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53C3413A59;
	Fri,  1 Mar 2024 10:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E3XqEryv4WXLMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 01 Mar 2024 10:36:44 +0000
Date: Fri, 01 Mar 2024 11:36:43 +0100
Message-ID: <87h6hq5jd0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.8-rc7
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

Linus,

please pull sound fixes for v6.8-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc7

The topmost commit is 17c6a0c986fbea2c09010c39ef4b44334f06e390

----------------------------------------------------------------

sound fixes for 6.8-rc7

The amount of changes wasn't as small as wished, but all reasonably
small fixes.  There is a PCM core API change, which is for correcting
the behavior change we took in 6.8.  The rest are device-specific
fixes for ASoC AMD, Qualcomm, Cirrus codecs, HD-audio quirks & co.

----------------------------------------------------------------

Colin Ian King (1):
      ASoC: qcom: Fix uninitialized pointer dmactl

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt440

Gergo Koteles (1):
      ALSA: hda/realtek: tas2781: enable subwoofer volume control

Hans Peter (1):
      ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)

Jaroslav Kysela (1):
      ALSA: pcm: clarify and fix default msbits value for all formats

Jay Ajit Mate (1):
      ALSA: hda/realtek: Fix top speaker connection on Dell Inspiron 16 Plus 7630

Jiawei Wang (2):
      ASoC: amd: yc: add new YC platform variant (0x63) support
      ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2

Johnny Hsieh (1):
      ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table

Kailang Yang (1):
      ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port

Richard Fitzgerald (2):
      ASoC: cs35l56: Must clear HALO_STATE before issuing SYSTEM_RESET
      ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()

Takashi Iwai (2):
      ALSA: ump: Fix the discard error code from snd_ump_legacy_open()
      ALSA: Drop leftover snd-rtctimer stuff from Makefile

Takashi Sakamoto (1):
      ALSA: firewire-lib: fix to check cycle continuity

Willian Wang (1):
      ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8

---
 include/sound/soc-card.h          |  2 ++
 include/uapi/sound/asound.h       |  4 ++--
 sound/core/Makefile               |  1 -
 sound/core/pcm_native.c           |  5 +++++
 sound/core/ump.c                  |  4 ++--
 sound/firewire/amdtp-stream.c     |  2 +-
 sound/pci/hda/patch_realtek.c     | 34 ++++++++++++++++++++++++++++++++--
 sound/soc/amd/yc/acp6x-mach.c     | 14 ++++++++++++++
 sound/soc/amd/yc/pci-acp6x.c      |  1 +
 sound/soc/codecs/cs35l45.c        |  2 +-
 sound/soc/codecs/cs35l56-shared.c |  1 +
 sound/soc/codecs/cs35l56.c        |  2 +-
 sound/soc/fsl/fsl_xcvr.c          | 12 +++++++++++-
 sound/soc/qcom/lpass-cdc-dma.c    |  2 +-
 sound/soc/soc-card.c              | 24 ++++++++++++++++++++++--
 15 files changed, 96 insertions(+), 14 deletions(-)



Return-Path: <linux-kernel+bounces-122624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60488FA83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58D42A6C60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74135F873;
	Thu, 28 Mar 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CjMdOJ7U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FJD0B/tE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CjMdOJ7U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FJD0B/tE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1228DD2;
	Thu, 28 Mar 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616249; cv=none; b=Nt7xMmkwTxojxXVJqliA4aXWEg9Nsn5KeMrywGEVxgpi0M+TjAsipmaexs3Qru5RdCkXOPnfYsQ1CpjRhcZxOF3xSIeqzIQO7VK1N9cxzpT7GsIPUrkNdUov9v3q9ZNduPnKTeWlKSKISBUnNvb/nFeob8x2D7YqVyENpH0c0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616249; c=relaxed/simple;
	bh=BK5QDCsJj7fk5pOeiP1Gm7vaJkCrnhRaNZpCaCU6zjI=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=Ks44v9GY2OFQAwCXuxCYM6HjbnR9sgTsmnYTLBJDs0ZH3M5z12eB2tD60OnDC4c08kXfqBY9CA1ZfnxGoZrn2fi35wjroucDpyVs/GbylC6G+yienQQLcKF9AmHZKOGjnyTl9yDOC7QZyzk5U5gaFhR16aecpxeUUinOWSqNVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CjMdOJ7U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FJD0B/tE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CjMdOJ7U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FJD0B/tE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E08D20613;
	Thu, 28 Mar 2024 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711616245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tvr+LohFSR5FjAVMlXknd6aeS/Sg/TG0aaa5I7gqpas=;
	b=CjMdOJ7UI00XT0zedpFSOpeqbayPwExdeQhvQhL/G9hfa75458v+pYmTj3pJ4QYX0X8BQk
	m4ERwlfKhH1MRIrqymthvBVKkOAm9PYR7eP/VVSkGqTqBAdx4uMK671b+tuHOyUUOael99
	7R+79wu1u/RZQEWCALMzzAh3DQZ/VD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711616245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tvr+LohFSR5FjAVMlXknd6aeS/Sg/TG0aaa5I7gqpas=;
	b=FJD0B/tEPmDL6o7CdhH0HTJl1VPEt5l3OmYU/8amerTcpCcYGkbq4XEKUArUCd6h4DJ0uI
	hwCBwgDnnayFWtAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711616245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tvr+LohFSR5FjAVMlXknd6aeS/Sg/TG0aaa5I7gqpas=;
	b=CjMdOJ7UI00XT0zedpFSOpeqbayPwExdeQhvQhL/G9hfa75458v+pYmTj3pJ4QYX0X8BQk
	m4ERwlfKhH1MRIrqymthvBVKkOAm9PYR7eP/VVSkGqTqBAdx4uMK671b+tuHOyUUOael99
	7R+79wu1u/RZQEWCALMzzAh3DQZ/VD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711616245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tvr+LohFSR5FjAVMlXknd6aeS/Sg/TG0aaa5I7gqpas=;
	b=FJD0B/tEPmDL6o7CdhH0HTJl1VPEt5l3OmYU/8amerTcpCcYGkbq4XEKUArUCd6h4DJ0uI
	hwCBwgDnnayFWtAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 65A5B13AB3;
	Thu, 28 Mar 2024 08:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Pv1WF/UwBWasZAAAn2gu4w
	(envelope-from <tiwai@suse.de>); Thu, 28 Mar 2024 08:57:25 +0000
Date: Thu, 28 Mar 2024 09:57:27 +0100
Message-ID: <87ttkqag3s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.9-rc2
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.95
X-Spamd-Result: default: False [-2.95 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.17)[-0.844];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.68)[98.59%]
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.9-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc2

The topmost commit is 1506d96119eb9454d64f5ae80ab8d04c1594ac25

----------------------------------------------------------------

sound fixes for 6.9-rc2

A collection of device-specific small fixes: a series of fixes for
TAS2781 HD-audio codec, ASoC SOF, Cirrus CS35L56 and a couple of
legacy drivers.

----------------------------------------------------------------

Arnd Bergmann (1):
      ALSA: aoa: avoid false-positive format truncation warning

Brent Lu (2):
      ALSA: hda: intel-nhlt: add intel_nhlt_ssp_device_type() function
      ASoC: SOF: ipc4-topology: support NHLT device type

Duoming Zhou (1):
      ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Gergo Koteles (4):
      ALSA: hda/tas2781: remove digital gain kcontrol
      ALSA: hda/tas2781: add locks to kcontrols
      ALSA: hda/tas2781: add debug statements to kcontrols
      ALSA: hda/tas2781: remove useless dev_dbg from playback_hook

Simon Trimmer (2):
      ALSA: hda: cs35l56: Raise device name message log level
      ALSA: hda: cs35l56: Set the init_done flag before component_add()

---
 include/sound/intel-nhlt.h       |  10 ++++
 sound/aoa/soundbus/i2sbus/core.c |   2 +-
 sound/hda/intel-nhlt.c           |  26 +++++++++
 sound/pci/hda/cs35l56_hda.c      |   8 +--
 sound/pci/hda/tas2781_hda_i2c.c  | 120 +++++++++++++++++++++++++--------------
 sound/sh/aica.c                  |  17 +++++-
 sound/soc/sof/ipc4-topology.c    |  19 ++++++-
 7 files changed, 149 insertions(+), 53 deletions(-)



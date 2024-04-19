Return-Path: <linux-kernel+bounces-151506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849F8AAFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4DC1C2248A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D412D210;
	Fri, 19 Apr 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rYaKbLON";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q5igHnKA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lVS6d393";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i0p7MQ0v"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702C12BF2D;
	Fri, 19 Apr 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534882; cv=none; b=mGaeU2/1ns3syWHF8261L3yvDgFG8t2pb4c6WKnUdmCePAK5o/H2PZGfSknITrPS5yQY7L2l6Z0819pFe0L61m6TOlCwzZD7MxDIcdmSqu3frSmgIMOAny013DDaUlQn/Qs9KRDkUDYgbiiSYFAI6u3dUitgmFvrr/Br2rs2t1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534882; c=relaxed/simple;
	bh=0iCQEjvdSo7dJbP+XmqMqLfVWMWsjqqzLI7oVk9RW+E=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=Uyi2zmrZyv7U58Gut1plcasOUFThub9V1suYR4UOwtHPOAPToqKoDb3jSZzmik+dSRaS6o3W8FNCpeuCzkmxFFPG0qrgE+d3olr1F5cyMRgzoHeNs+mxbkihcwKAacfnj9eb8PY1YQPYDsU6B1QrpRD6/aCzdCJ+fqKo3NgHNDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rYaKbLON; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q5igHnKA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lVS6d393; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i0p7MQ0v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0DC575D731;
	Fri, 19 Apr 2024 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713534879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1T1gY+959LBHI4IrkrYy7MTTOkwbZUKPUll4SaqfVL8=;
	b=rYaKbLONZVez4cpfrWYBv4iI3DZN4xnP30wtpPJa0zUDR9HfuXaUNkXbGA1uZpm9+TxLBi
	nhl8owcfGWYsoNEMP9ozNix9L5hYkrij3lPzKfeg0mAmV9j98MUIJrnUXMsrqWDdiwzdwe
	73SD9us2M+5Z4xAZjLNk6uw/JkRArZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713534879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1T1gY+959LBHI4IrkrYy7MTTOkwbZUKPUll4SaqfVL8=;
	b=Q5igHnKARGfob1FoOmWDc7Ak/RwYWEGZ6tFSsdULN7LHeul4SS4cQx4MUwy5sLvmKqMmc3
	G0ynUMUpLhbmtyBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lVS6d393;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i0p7MQ0v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713534878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1T1gY+959LBHI4IrkrYy7MTTOkwbZUKPUll4SaqfVL8=;
	b=lVS6d3938LQiqFRypcGJJz9hk3gfJl2GLt1qvkjq1qFccItXCrd3SiWHokKLVlGecwKnTU
	SVwOdb5irNEeEFBqzodrmm3yckUkNwT7f5Gb2DKyQ5kr/OSTjnRsf+qnqD5yPAuKuGy8Yv
	AgRggIQ9ZSpjYYTV5/JlnWbiSU5NDf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713534878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1T1gY+959LBHI4IrkrYy7MTTOkwbZUKPUll4SaqfVL8=;
	b=i0p7MQ0vcp8KAz+yxl1i9LbYZ8qZ1CcD2TEdQwTELLBC1NvfWbSc5/uZv94tBB4W+i5oXG
	N4zpjdhTpsUs8tDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9E50136CF;
	Fri, 19 Apr 2024 13:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nx7zM513ImZ3XwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Apr 2024 13:54:37 +0000
Date: Fri, 19 Apr 2024 15:54:45 +0200
Message-ID: <87ttjxsbiy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.9-rc5
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0DC575D731
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

Linus,

please pull sound fixes for v6.9-rc5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc5

The topmost commit is f25f17dc5c6a5e3f2014d44635f0c0db45224efe

----------------------------------------------------------------

sound fixes for 6.9-rc5

Things look calm and normal, we got handful HD-audio-related small
fixes and a fix for MIDI 2.0 UMP handling.

----------------------------------------------------------------

Ai Chao (1):
      ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269VC

Huayu Zhang (1):
      ALSA: hda/realtek: Fix volumn control of ThinkBook 16P Gen4

Mauro Carvalho Chehab (1):
      ALSA: hda/realtek: Add quirks for Huawei Matebook D14 NBLB-WAX9N

Shenghao Ding (2):
      ALSA: hda/tas2781: correct the register for pow calibrated data
      ALSA: hda/tas2781: Add new vendor_id and subsystem_id to support ThinkPad ICE-1

Takashi Iwai (1):
      ALSA: seq: ump: Fix conversion from MIDI2 to MIDI1 UMP messages

Vitalii Torshyn (1):
      ALSA: hda/realtek: Fixes for Asus GU605M and GA403U sound

Vitaly Rodionov (1):
      ALSA: hda/realtek: Add quirk for HP SnowWhite laptops

---
 sound/core/seq/seq_ump_convert.c |  2 +-
 sound/pci/hda/patch_realtek.c    | 49 ++++++++++++++++++++++++++++++++++++----
 sound/pci/hda/tas2781_hda_i2c.c  |  4 ++--
 3 files changed, 48 insertions(+), 7 deletions(-)



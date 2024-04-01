Return-Path: <linux-kernel+bounces-126632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A5893AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8004D1F21D63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47821A0A;
	Mon,  1 Apr 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AnynoRy3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="emZn3LsR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5981F5FD;
	Mon,  1 Apr 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711971979; cv=none; b=QZaInSojfrFQ0/xXr7w4hcDNXnBk2GvCN5c4SPb1K2ZpptlYZAA62e2XMW//Hjnr7C5kaCUm+3djqRbxiZ9lplt15Sv0h9YwWaD4HUWFcZ3xNXpRAPPCupw3KGE9oxuzBYNW2tSmrPtGPkNhsC740UDpfXJFDYn0W9xcd/gbFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711971979; c=relaxed/simple;
	bh=JG56/VIF7nGSXyF1vticRoP+S1Ia0KpEMyEjcYayir4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ow3FuKSP1OVB/3fx3gMVIooJm2PupkFfkno0r6C5XTx5bF/jJLMp3zJ6ZPe7s/b8dA9J/7QMBiUOad68LLHuEkkj3AxehUNHSVP4ie/ldslgwwV0x1Uh3e2yfLSUDSe7s6VkINgzeQ8p6eDPbw9MMcDwSIJJUFHa/rw37p7njLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AnynoRy3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=emZn3LsR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54E6933992;
	Mon,  1 Apr 2024 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711971976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/P9D0zj3SgS39zJWbyWM8/mrl9HetiZgtzn9wzpvvk=;
	b=AnynoRy3a17VuykeWkCG3+Q/SG2ksAIzNMEaIT5KyyHPOkT19/NONsI95DpAMgetatjZ1I
	QpGBu3e1ZEsJdQI1Af/88PWKclVSyVLt2B6HB0PCLAEwEQYOI+QXZxDurnDhSDhPczhy2k
	QemTgvdnYIoRGYPloQVDm3xszK+SXOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711971976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/P9D0zj3SgS39zJWbyWM8/mrl9HetiZgtzn9wzpvvk=;
	b=emZn3LsRluDkiyBwB4ZXqXCqSlgT41Tka+MhZYdwySB5RcH0cVxq99trSLs1NXvxJXzhRu
	obywrhO46zd94LAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1671D139BE;
	Mon,  1 Apr 2024 11:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uin4A4ieCmY5EAAAn2gu4w
	(envelope-from <tiwai@suse.de>); Mon, 01 Apr 2024 11:46:16 +0000
Date: Mon, 01 Apr 2024 13:46:20 +0200
Message-ID: <87sf05e25v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <broonie@kernel.org>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ALSA: cirrus: Tidy up of firmware control read/write
In-Reply-To: <41d1aad9-2381-4d7b-b247-9d114c5c517f@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
	<87o7awnmdd.wl-tiwai@suse.de>
	<41d1aad9-2381-4d7b-b247-9d114c5c517f@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 54E6933992
X-Spamd-Result: default: False [-1.05 / 50.00];
	BAYES_HAM(-1.74)[93.45%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.05
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, 01 Apr 2024 11:32:49 +0200,
Richard Fitzgerald wrote:
> 
> On 30/03/2024 08:40, Takashi Iwai wrote:
> > On Mon, 25 Mar 2024 12:31:22 +0100,
> > Richard Fitzgerald wrote:
> >> 
> >> This set of patches factors out some repeated code to clean up
> >> firmware control read/write functions, and removes some redundant
> >> control notification code.
> >> 
> >> Simon Trimmer (5):
> >>    firmware: cs_dsp: Add locked wrappers for coeff read and write
> >>    ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
> >>    ALSA: hda: hda_cs_dsp_ctl: Use
> >>      cs_dsp_coeff_lock_and_[read|write]_ctrl()
> >>    ASoC: wm_adsp: Remove notification of driver write
> >>    ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write
> > 
> > The patch 4 doesn't look cleanly applicable to my tree.
> > Should it be applied via Mark's tree?
> > 
> 
> Yes, it will need to go through Mark's tree.
> Mark's for-next has one extra patch to wm_adsp.c that changes
> the same function:
> 
> f193957b0fbb ("ASoC: wm_adsp: Fix missing mutex_lock in
> wm_adsp_write_ctl()")

OK, then it should go via Mark's tree.
Feel free to take my ack:

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


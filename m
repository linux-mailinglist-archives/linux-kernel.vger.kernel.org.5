Return-Path: <linux-kernel+bounces-126757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8786F893C57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2212F1F223ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A844374;
	Mon,  1 Apr 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="06EdeJK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DtMP8+pZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFBB41A8F;
	Mon,  1 Apr 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982903; cv=none; b=DulTi8ASqGkMa2GJym70m9NayQ3maXtRQk5rpTPbOQ6xbumP47V58beVXPmO/cXZja1V7QwWW6Df9E+9sBfdaGZkmDW9kRU0XDBNv+wIItsb0ZICJpNAfz3Tcjh2R9tD6t3dflgS4ABgdJTotvbJ02tJoqKY9oALJZ919mk7wNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982903; c=relaxed/simple;
	bh=7ubcAZ53bNX8OmYuapcEIXIACrFpAoA1Ij/WMLDmqkM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I43VH28+/x35Xv6/O3BNCaR2mK9GoX5D0WvrJhYw5jgLOYkrFrQcuUpm2x3d5flZH/wrzLHC+gxeMKmBW8+S/2pK1suPK8T//+Lj8gbKCePqih5qxAfgcyOsEVOsMyX/MdPY0sovUVwk2tUTeTd6qu/cf8D8JOfB0YNOcQZpPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=06EdeJK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DtMP8+pZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5EC72035C;
	Mon,  1 Apr 2024 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711982899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zgc2xnigK6/fmVr0xlhvZsS6Kf0WzeOKUYY3G7tjqw=;
	b=06EdeJK3dovh93Ny2GCcG4VjWh6DAHhfj5FxMaxaGu2L0rdq/cGE/nZyjC1hhEdZ55V6SL
	4Q7Sw/bhQM5cVswyQoCB6AOWJNjD1Md4htXUOzoBQHIY80gyCrwxYU+GqrVLjrkHRj8wBF
	n412mn+9CNkU3vgpGp/LXLPmxJoxy8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711982899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zgc2xnigK6/fmVr0xlhvZsS6Kf0WzeOKUYY3G7tjqw=;
	b=DtMP8+pZtfuDpJbnD/Yz8NzX5dfloPU+8jEn0yVGKxKx4gHmVhfpDFkG0eykJypXMrtIRm
	6kJ87/fgxxtn6UBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 87B7E1348C;
	Mon,  1 Apr 2024 14:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1lVVHzPJCmaiPgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Mon, 01 Apr 2024 14:48:19 +0000
Date: Mon, 01 Apr 2024 16:48:23 +0200
Message-ID: <87h6glt9zc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592 decrease 30% of gaming performance
In-Reply-To: <CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
	<874jcl7e83.wl-tiwai@suse.de>
	<CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
	<87v851e2di.wl-tiwai@suse.de>
	<CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.11
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: D5EC72035C

On Mon, 01 Apr 2024 15:49:33 +0200,
Mikhail Gavrilov wrote:
> 
> On Mon, Apr 1, 2024 at 4:41 PM Takashi Iwai <tiwai@suse.de> wrote:
> > The only code of the commit 587d67fd929a is the close of ALSA timer
> > device.  If it really matters, it implies that the user-space seems
> > trying to open/close the ALSA timer device so frequently.
> >
> > Are you using ALSA dmix/dsnoop?  It would explain.
> 
> It's new words for me. I didn’t configure anything like this myself,
> only if the maintainers of my distribution enable it by default.
> I only know that Fedora Rawhide uses Pipewire for mixing sound.

Then it shouldn't be dmix/dsnoop.  You'd better try profiling what's
going on there.  e.g. try to get perf results with and without the
commit.


Takashi


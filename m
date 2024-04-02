Return-Path: <linux-kernel+bounces-127413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA29894AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF91C22016
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFC218627;
	Tue,  2 Apr 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVP4myHD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6RwV7fUM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B09323D;
	Tue,  2 Apr 2024 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037405; cv=none; b=NwCC/J7xlzOC6s8bmq+bDwnDjCqiOpmgqZjJfJPCJqU+CZCflMQe2mF/xX8FnoLCGX4ZSL2oNwTHxFvoTJiE+ctfmNnMWAjsJdw8Oun6lZIaBI4120F8RgkQg22uYbxHekHBPnqwn8DNXP5on8XLRw3NL+5evp0LTbGVzRoZXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037405; c=relaxed/simple;
	bh=r7CQo84lhaY6GlXs0N/ZHRxC5QyLD18tpZWa2eEQUHI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+CpGV6yswSQmFLLafFhQRj4VZvXKPoRQnbI6ke2VAhWXBOgP661OEw2X6whPydLNA6bA1lGo5rG6PgxILmAvADx0tnjA5r7CUgDSf5YcMrcqWR1S69Ln1qRD508G5TZORDh7imzbFlg/y3Aq4xw5ROeo/x2FJwzSihAeX3gqmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVP4myHD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6RwV7fUM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C47C220AE;
	Tue,  2 Apr 2024 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712037401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hWpiDi37HOrtYFnr82tOTQamP5ZS+re5rb82xsc3So=;
	b=XVP4myHDewzSK5T6rbT8RpTY448N9+sCppFUFZAXDpSMFSKSrfIakA8B1nTC1sKWLFjGCI
	Lj9YF8of2lca4ZDLOhD0Zg1CpalWqapjLF3NCeHIbk87XGr4o8zBNIu76Lztw48a0bwsWD
	ieL8sW9T8gxBTCRIHrLT4NxLXAjWm0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712037401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hWpiDi37HOrtYFnr82tOTQamP5ZS+re5rb82xsc3So=;
	b=6RwV7fUMu6okdcSOK0ZZZPFie+L5R2AQZ/4JiGCGx9bUB3WXqfBkfrAJRJup5BhEzpIJIL
	e8h+TMJ71xVHy5AQ==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DBC013A90;
	Tue,  2 Apr 2024 05:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uqibDRmeC2bQMQAAn2gu4w
	(envelope-from <tiwai@suse.de>); Tue, 02 Apr 2024 05:56:41 +0000
Date: Tue, 02 Apr 2024 07:56:45 +0200
Message-ID: <878r1wtihu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Takashi Iwai <tiwai@suse.de>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the sound-current tree
In-Reply-To: <20240402075853.4e5a61cf@canb.auug.org.au>
References: <20240402075853.4e5a61cf@canb.auug.org.au>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,gmx.de,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.99%]
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, 01 Apr 2024 22:58:53 +0200,
Stephen Rothwell wrote:
> 
> Hi all,
> 
> In commit
> 
>   e1d8acf35ce7 ("Revert "ALSA: emu10k1: fix synthesizer sample playback position and caching"")
> 
> Fixes tag
> 
>   Fixes: df335e9a8b (ALSA: emu10k1: fix synthesizer sample playback position and caching, 2023-05-18)
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
> 
> The date field adds nothing.
> 
> Thus:
> 
> Fixes: df335e9a8bcb ("ALSA: emu10k1: fix synthesizer sample playback position and caching")

The commit is corrected now.  Thanks.


Takashi


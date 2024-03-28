Return-Path: <linux-kernel+bounces-122952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277C89002E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FFBB227D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2392F8004A;
	Thu, 28 Mar 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sxAPoSHk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H5uHIngv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sxAPoSHk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H5uHIngv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92852F6F;
	Thu, 28 Mar 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632356; cv=none; b=KlVZJBPEnq1/IPO1ocd/MMqB5051O9jTZRYTPnidtHJWf3/6Wm1Fv9XkaS6sf4Vvbr3j9bP1jiKveZsMd0AtvoYBAgmuDvBZOxvFRdd71PS6aj8htfr6FcBCPmkpSbq9vpHYtaq+r4jyD7RD8yyLLaWsZ5lkZ7HEOhhTPUfdASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632356; c=relaxed/simple;
	bh=41Y7z6ebP/p4fGVZKrhTf1bgP3gMs7DUKhuoy4YKYzM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+p/3u3wjHZ2dM2S3JYF3Q8+pnnVR+QSNldKscv+3izN/eYGxv2+6PjtHoHs+unJYpHWhcdDfq+7MiF0E4IwPUovuS31ddxpLJIbC3e9KhpUKvbGQ3/n75RilMEXUjiBGtQntjD83+LBYJyzPrlXtYm0ZpC7vCg+bIax1z8HQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sxAPoSHk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H5uHIngv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sxAPoSHk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H5uHIngv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E92FB20951;
	Thu, 28 Mar 2024 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SmnT7lPBqfUIuBbGDpkvVsT3Swvb884jcOc++WNaIc=;
	b=sxAPoSHkxCW7RZQ52km7JeH44I2CSXzil8NugxkB9BEOs44HdlChUg+Q3G+2j+VdPmIlo1
	Y8fHSIC18w3/grxuApZ7/jZjSr/7jyKstDKPbxpe4JFXPIt3L46BvqqtVCqs/aGt/t57dH
	Y5WwxtLKHRyaF/bPHEhTBCWznN+bUa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SmnT7lPBqfUIuBbGDpkvVsT3Swvb884jcOc++WNaIc=;
	b=H5uHIngvTQm23cgy/1vaE5HB46CDyIfY6cYe2lOfUcTLTuZ1nfT0TnNjs5HSiERxPegv4w
	eKY/K9/XBqHr+1AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SmnT7lPBqfUIuBbGDpkvVsT3Swvb884jcOc++WNaIc=;
	b=sxAPoSHkxCW7RZQ52km7JeH44I2CSXzil8NugxkB9BEOs44HdlChUg+Q3G+2j+VdPmIlo1
	Y8fHSIC18w3/grxuApZ7/jZjSr/7jyKstDKPbxpe4JFXPIt3L46BvqqtVCqs/aGt/t57dH
	Y5WwxtLKHRyaF/bPHEhTBCWznN+bUa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SmnT7lPBqfUIuBbGDpkvVsT3Swvb884jcOc++WNaIc=;
	b=H5uHIngvTQm23cgy/1vaE5HB46CDyIfY6cYe2lOfUcTLTuZ1nfT0TnNjs5HSiERxPegv4w
	eKY/K9/XBqHr+1AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CDA1B13AF8;
	Thu, 28 Mar 2024 13:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gcmdMeBvBWZJPgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Thu, 28 Mar 2024 13:25:52 +0000
Date: Thu, 28 Mar 2024 14:25:55 +0100
Message-ID: <87il16a3oc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christoffer Sandberg <cs@tuxedo.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Fix inactive headset mic jack
In-Reply-To: <20240328102757.50310-1-wse@tuxedocomputers.com>
References: <20240328102757.50310-1-wse@tuxedocomputers.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E92FB20951
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sxAPoSHk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H5uHIngv
X-Spamd-Result: default: False [-1.88 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.57)[81.33%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,tuxedocomputers.com:email];
	URIBL_BLOCKED(0.00)[tuxedo.de:email,suse.de:dkim,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,tuxedocomputers.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.88
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 28 Mar 2024 11:27:57 +0100,
Werner Sembach wrote:
> 
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> This patch adds the existing fixup to certain TF platforms implementing
> the ALC274 codec with a headset jack. It fixes/activates the inactive
> microphone of the headset.
> 
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Applied now with Cc-to-stable.  Thanks.


Takashi


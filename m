Return-Path: <linux-kernel+bounces-44679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD18425D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747F0292921
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7D6BB26;
	Tue, 30 Jan 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EQI8WiiL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WqzEqxZp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EQI8WiiL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WqzEqxZp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F36DCFB;
	Tue, 30 Jan 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620242; cv=none; b=GtPC1DC88//ArBMwj4ZYg9hfRLcgS2jZs2e4+Kww+0kewJzZqms2bO+jNtB8WW4VlkKNA96T7JLv/8mQTQ7MNV/kDUoPChWZ+T5IZNU5fYAKTVyhrJLIEbjVM37tIRpLYgQexkNdsZXlJyItmLS+oTk/Wy9cKmW0Rjc2KGbdS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620242; c=relaxed/simple;
	bh=IdFaHE5Ms+GEigRHXWpqWfKUWOfSZEiD+SvC+PEroMo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9X8EH5NBaglE2mZEl8qk5WtXjezOvQ+WmGf9TxGtzxaYIGARVUGEvw/f25+vDLo+cKEfZH0TR/lv5c2aaszzwMjTTWcy7xu2uXzP28VzCzc1eUMI38zeK5lUyG+7L+ZEMlR1/4vw2xCvlbdIj6gClydImIGL7B4rPqVt5lIiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EQI8WiiL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WqzEqxZp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EQI8WiiL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WqzEqxZp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 666241F84B;
	Tue, 30 Jan 2024 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706620239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLVoZRDpJbfql9mrOgoOatUxVxP6A8SBP4rtVDrSFDQ=;
	b=EQI8WiiLfAOqqLSP3EPB52W08BdAhRiKNI05dlBSVYJyByLZiAcTaVf1r7lcR4cu4b6Szg
	23yu0rnzfzg035uF3J22Upqy+8Gsj61cGlXkd6RE6AcPXPDFyRD+q5fuzKLAnEdKHLia0t
	YWYeLct41T2jAB7h2JmhzSXLfd9ySCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706620239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLVoZRDpJbfql9mrOgoOatUxVxP6A8SBP4rtVDrSFDQ=;
	b=WqzEqxZpAHni5awvhZrQtIDycV2PsVJqug47hL9oeb09oQd9NoZ1FFLDnpN0KiX/KAeQMn
	JVtC5e8zkBSQwSBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706620239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLVoZRDpJbfql9mrOgoOatUxVxP6A8SBP4rtVDrSFDQ=;
	b=EQI8WiiLfAOqqLSP3EPB52W08BdAhRiKNI05dlBSVYJyByLZiAcTaVf1r7lcR4cu4b6Szg
	23yu0rnzfzg035uF3J22Upqy+8Gsj61cGlXkd6RE6AcPXPDFyRD+q5fuzKLAnEdKHLia0t
	YWYeLct41T2jAB7h2JmhzSXLfd9ySCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706620239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLVoZRDpJbfql9mrOgoOatUxVxP6A8SBP4rtVDrSFDQ=;
	b=WqzEqxZpAHni5awvhZrQtIDycV2PsVJqug47hL9oeb09oQd9NoZ1FFLDnpN0KiX/KAeQMn
	JVtC5e8zkBSQwSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 157BC12FF7;
	Tue, 30 Jan 2024 13:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LUTEA0/1uGXHWAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Jan 2024 13:10:39 +0000
Date: Tue, 30 Jan 2024 14:10:38 +0100
Message-ID: <87y1c72chd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chhayly Leang <clw.leang@gmail.com>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR
In-Reply-To: <20240126080912.87422-1-clw.leang@gmail.com>
References: <20240126080912.87422-1-clw.leang@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EQI8WiiL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WqzEqxZp
X-Spamd-Result: default: False [-2.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-2.85)[99.38%];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 666241F84B
X-Spam-Level: 
X-Spam-Score: -2.16
X-Spam-Flag: NO

On Fri, 26 Jan 2024 09:09:12 +0100,
Chhayly Leang wrote:
> 
> Adds sound support for ASUS Zenbook UM3402YAR with missing DSD
> 
> Signed-off-by: Chhayly Leang <clw.leang@gmail.com>

Applied now.  Thanks.


Takashi


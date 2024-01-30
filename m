Return-Path: <linux-kernel+bounces-44458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120B84223B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DFE282A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4C66B47;
	Tue, 30 Jan 2024 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IADt+4EB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JxOUfGh2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IADt+4EB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JxOUfGh2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F29664BB;
	Tue, 30 Jan 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612737; cv=none; b=Rnk9JaI42KrRnajWGkHD5rghan0xD18mvMupAZgjZf2R/sf+hJuqtC/ybZ1jjeVdS4RBpfWGM+CRhXzPGmT15Ie1NTdKqI7bG+02XLx61G3skU+SF7igdI6fz1ZQ56xktnLMtpCu3tNUHbY+evpoDM5HP/zUhvcpjCpCbq6Ulk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612737; c=relaxed/simple;
	bh=bA6oiIJ/ZMUKaMCF87cC9UASHPrEnY7xDEMlpEbuvbI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIWrSwKsugHZvaTP5MsnxR3RSxbgSPfhYE6fckz2W7Wyy2L8pr+d4QeaLVXh8qn5/MubNv5u+Sh3AC/Z2dQsboWTnxtOCMIgnPhVO1sr+ANJmktu6K1x7CMUj1Hpu47jUfkCNF7PUTlEZ2hrlyqAPpo18DXg1BHf9Z+GSpc6HWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IADt+4EB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JxOUfGh2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IADt+4EB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JxOUfGh2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 520DF222DE;
	Tue, 30 Jan 2024 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706612733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHa2+/RV9Q49g5mVEupkk6ydWd6AuIwK8lzXmqDcRUc=;
	b=IADt+4EBl2bU99+MBfsG1F076DnSP2i7/qOLQsgO+2dFTS5lRId2vQq97ZY5XAeOk24EZc
	Kf4ti75J7cVnpyznvYLqS8ovdoHEiudEwYaJhMrm3T86BmSvMgxOCubsyxHmI+uJA2S+JC
	waJIYyYCG1ZFZqu5nSnwoLg20avckk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706612733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHa2+/RV9Q49g5mVEupkk6ydWd6AuIwK8lzXmqDcRUc=;
	b=JxOUfGh2RNH48wOpvh20XKRzZv+tDKCa7oHUoJu8FM1/ESIiDGJZIgM6JRMhVoBtyCFlXP
	Te6H7rCo3dYdl5AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706612733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHa2+/RV9Q49g5mVEupkk6ydWd6AuIwK8lzXmqDcRUc=;
	b=IADt+4EBl2bU99+MBfsG1F076DnSP2i7/qOLQsgO+2dFTS5lRId2vQq97ZY5XAeOk24EZc
	Kf4ti75J7cVnpyznvYLqS8ovdoHEiudEwYaJhMrm3T86BmSvMgxOCubsyxHmI+uJA2S+JC
	waJIYyYCG1ZFZqu5nSnwoLg20avckk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706612733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHa2+/RV9Q49g5mVEupkk6ydWd6AuIwK8lzXmqDcRUc=;
	b=JxOUfGh2RNH48wOpvh20XKRzZv+tDKCa7oHUoJu8FM1/ESIiDGJZIgM6JRMhVoBtyCFlXP
	Te6H7rCo3dYdl5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFFE512FF7;
	Tue, 30 Jan 2024 11:05:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MP7/OPzXuGVfPQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Jan 2024 11:05:32 +0000
Date: Tue, 30 Jan 2024 12:05:32 +0100
Message-ID: <87il3b3wub.wl-tiwai@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri, 26 Jan 2024 09:09:12 +0100,
Chhayly Leang wrote:
> 
> Adds sound support for ASUS Zenbook UM3402YAR with missing DSD
> 
> Signed-off-by: Chhayly Leang <clw.leang@gmail.com>

Yet another missing entry; can Cirrus people review this before I
merge?


thanks,

Takashi

> ---
>  sound/pci/hda/cs35l41_hda_property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index 35277ce890a..2af083183d8 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -76,6 +76,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
>  	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
> +	{ "10431683", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
>  	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> @@ -410,6 +411,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "10431533", generic_dsd_config },
>  	{ "CSC3551", "10431573", generic_dsd_config },
>  	{ "CSC3551", "10431663", generic_dsd_config },
> +	{ "CSC3551", "10431683", generic_dsd_config },
>  	{ "CSC3551", "104316D3", generic_dsd_config },
>  	{ "CSC3551", "104316F3", generic_dsd_config },
>  	{ "CSC3551", "104317F3", generic_dsd_config },
> -- 
> 2.42.0
> 


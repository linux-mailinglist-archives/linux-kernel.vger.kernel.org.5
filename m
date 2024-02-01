Return-Path: <linux-kernel+bounces-48160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA3845812
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83AA291E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7386653;
	Thu,  1 Feb 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sVkuvq9M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U3iAOdW4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="igZEU4SK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5n7VExPE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE178664A;
	Thu,  1 Feb 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791780; cv=none; b=BZpSwqOElPqqfJl9LA1PRWBMJZ5dthaosWZXzaihZKEN+HUqy6la1f8dnQvJFMV3Z4BRWoUHyZCGd1qPuO/gQTmAr/oTA4azBoEj1l8KOgKyKX3vEw4F6PsfmPq4bBq3ckS5LL7XpTTInUL5qCoyBO6/f6r+pEmid5m96+OM/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791780; c=relaxed/simple;
	bh=73yNjbX3V5CwANTEQjLTld89ILQCh/j/Q6b2MYKvOug=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr9bWKz0dCeNmXvng7GQHVjoGmQgCi4YFf6OvoA6EwqoioxnObDg28p611qKIfAxKtLW69d9OW4qt9MVIk36VuF80tMP2ekk9urw379XZ8sXRxdzXk0M8GVYl2PMo3kDfHkysK6xdRf7eogSfLBVVgbjbaSpEGXlCUs4Yca52XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sVkuvq9M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U3iAOdW4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=igZEU4SK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5n7VExPE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E79B61FB83;
	Thu,  1 Feb 2024 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0OPATdqXvb+caoegnnSuXx1SUc1odadlEih9NfSLUgs=;
	b=sVkuvq9My99tel6yzls+aOPbmI5KRf2qL6l4MgCTWKRZLCxJrpAGURLWLPE3tKKo5vRt16
	5YLG9O9ZasCyiEf1H0Yeigsr/Zyo7c6+WRqB2NcAJfV/tVb2ShJeICKfmNIMBeLGGG6Zgk
	WTbazjGlEuEmFzsKlh4e2i9QCpjiBDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0OPATdqXvb+caoegnnSuXx1SUc1odadlEih9NfSLUgs=;
	b=U3iAOdW4Mhkj2iThF5ZtIKItLDpdXCEseESa7zVN4wxEPqCxcY400oVuPch5xsKMCZ+7bY
	Hvb5oKkNtw5kWWAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0OPATdqXvb+caoegnnSuXx1SUc1odadlEih9NfSLUgs=;
	b=igZEU4SKS2Hu9A5IDMqwX9MDFkJ9hQUfhB6qKDGEceK6QjdnB4EXiZoOA+AL/JidoftTsI
	QjRe0szEKCJPz8SI0Z00GWAphEb+nLV8ls+z4szoF18sSEk3XMB6UDAy3P2DI3Mdye6upy
	JL5QAjIxg4G6M93N8Qi5NRTsx1r2I58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0OPATdqXvb+caoegnnSuXx1SUc1odadlEih9NfSLUgs=;
	b=5n7VExPEYQcJR3mjewXySgWcwTfX1DyLpogo/QHlF6xs4za9C6VuNJRkIR4ONS2A/YBQ/a
	HVBWwDHJX29KvgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD037139B1;
	Thu,  1 Feb 2024 12:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJwOKV6Tu2XkOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 01 Feb 2024 12:49:34 +0000
Date: Thu, 01 Feb 2024 13:49:34 +0100
Message-ID: <87msskz6w1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 00/18] ALSA: Various fixes for Cirrus Logic CS35L56 support
In-Reply-To: <1cc8d9c7-2af5-43f1-a022-75624deae51f@sirena.org.uk>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
	<1cc8d9c7-2af5-43f1-a022-75624deae51f@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=igZEU4SK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5n7VExPE
X-Spamd-Result: default: False [-0.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.08)[87.99%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.39
X-Rspamd-Queue-Id: E79B61FB83
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, 01 Feb 2024 13:47:38 +0100,
Mark Brown wrote:
> 
> On Mon, Jan 29, 2024 at 04:27:19PM +0000, Richard Fitzgerald wrote:
> > This chain of patches fixes various things that were undocumented, unknown
> > or uncertain when the original driver code was written. And also a few
> > things that were just bugs.
> > 
> > The HDA patches have dependencies on the ASoC patches, except for the final
> > patch that removes a bogus test stub function.
> 
> Takashi, should I apply the ALSA bits of this via ASoC?

Judging from the amount, better to go through your tree.
Please go ahead.


thanks,

Takashi


Return-Path: <linux-kernel+bounces-76179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F485F3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5DA1F25048
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CA3716F;
	Thu, 22 Feb 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bqwri99i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oHdJI6L1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bqwri99i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oHdJI6L1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380D182D2;
	Thu, 22 Feb 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592754; cv=none; b=t8elg1SLy2wHMw13rHcekoeXLDmtcFjRgDpOqamiAwGrH21AM7NjU9LPLtGYkcpavnb7CJMKtIaALA63kkbmlAmGQRWOezGR7WpfD1W71MQGsLhy6AD8vp91EAfVjcR8oEinCAFiIWFW9pPQorznaaOg0dAm3sCzRmW2o86JJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592754; c=relaxed/simple;
	bh=+vn1ckrtx6RQRz3eYg5eAEtVg2EE5KZ8R/asI7H1qUU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfTK3ZYQttsj2oAyvRkyKzXyRIKwUgP8qfRTrc5qZ2pX8qUC99vxaXOohJ8Y37SR2qqD4XUzBw13zP+opcoDzUCDhMGxLguYdLY2HOv8irE8RpfQ0+fKk6YcN6o6bwrQZKYcElufDV3vHtEkhvBzwgmWxMOeZ6XTF2WTugGRZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bqwri99i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oHdJI6L1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bqwri99i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oHdJI6L1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A14081F452;
	Thu, 22 Feb 2024 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708592750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttaLeBa6Qt+Edx6r7FQgoY9x3tYtNqF1wyVE0b0N7DE=;
	b=bqwri99i1QH2wmnjSrvjlkJ5dHkkUE/dlBi64+ydWv6GhDzXZbkwryfDO+m1tWuh6OE8r6
	un/SoOaGQBeFX0PXhDRVR+9ywkusq93xXTPDT/mdHQuaiGJ/KEHoAdWRddxeE9XImif/7y
	+VRL/NgSLAhhyNbEz0eIHxLclPBeCxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708592750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttaLeBa6Qt+Edx6r7FQgoY9x3tYtNqF1wyVE0b0N7DE=;
	b=oHdJI6L1KVsC8yy2wNGf5T/J6pqSJe7T1aBZAJ2KsvrqX1TeZ+E4LJ4AC2XUNwkokc4tgL
	AsDhlKJCgGp8aBCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708592750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttaLeBa6Qt+Edx6r7FQgoY9x3tYtNqF1wyVE0b0N7DE=;
	b=bqwri99i1QH2wmnjSrvjlkJ5dHkkUE/dlBi64+ydWv6GhDzXZbkwryfDO+m1tWuh6OE8r6
	un/SoOaGQBeFX0PXhDRVR+9ywkusq93xXTPDT/mdHQuaiGJ/KEHoAdWRddxeE9XImif/7y
	+VRL/NgSLAhhyNbEz0eIHxLclPBeCxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708592750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttaLeBa6Qt+Edx6r7FQgoY9x3tYtNqF1wyVE0b0N7DE=;
	b=oHdJI6L1KVsC8yy2wNGf5T/J6pqSJe7T1aBZAJ2KsvrqX1TeZ+E4LJ4AC2XUNwkokc4tgL
	AsDhlKJCgGp8aBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C17D13A8C;
	Thu, 22 Feb 2024 09:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h/N6GG4O12VBeQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 22 Feb 2024 09:05:50 +0000
Date: Thu, 22 Feb 2024 10:05:50 +0100
Message-ID: <87sf1k6f81.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: echoaudio: remove redundant assignment to variable clock
In-Reply-To: <20240221113809.3410109-1-colin.i.king@gmail.com>
References: <20240221113809.3410109-1-colin.i.king@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bqwri99i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oHdJI6L1
X-Spamd-Result: default: False [0.40 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.79)[84.62%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.40
X-Rspamd-Queue-Id: A14081F452
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, 21 Feb 2024 12:38:09 +0100,
Colin Ian King wrote:
> 
> The variable clock is being assigned a value that is never read,
> it is being re-assigned a new value in every case in the following
> switch statement. The assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> sound/pci/echoaudio/echoaudio_3g.c:277:2: warning: Value stored
> to 'clock' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, applied.


Takashi


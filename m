Return-Path: <linux-kernel+bounces-67248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086168568A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EC91C23A30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36713399D;
	Thu, 15 Feb 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xriu/gwi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kkXBOJae";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bUhAm7AE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3FY5kUQx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87353369;
	Thu, 15 Feb 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012771; cv=none; b=jIRLDV/ovybreA+1H5B3uXnrCQOmmtVmCQq9lrl6hhtx93xSi3mFfWff4tI7/BszK8qpRv0Brh0q4I+Wc1TK4EpwpAQ1XKgr42naGsnUHhUs3lG8jteGWImYDaCBLTsym1I4V7feJKAh4zLTEQJcKMpLlmHMXsuDUuh7/+ZgdRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012771; c=relaxed/simple;
	bh=qD5ZBWGhYIi5J1d+Tg9J/cj0nxcLLO7z0cu37i5BH4w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8FvVzrEVDFqNwDll6Q4WTCXYl+dyXBNVwXy3iFvjl11doqGwfJU5s65KM7ASWHuWZcHOOgJ2slAKjI1a6A9c5ilyC5DOzH4Bzk/1+37rnQa9YRuwoKalCE+9P5htrqQAliztEFZsY7FJ3HfEUxAQuE6R9/WqvPQb9roYD6SopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xriu/gwi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kkXBOJae; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bUhAm7AE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3FY5kUQx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED2051F8BA;
	Thu, 15 Feb 2024 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708012768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYbT9HGAWfdr7p8j7wtUx16p3Lt7ILfaJCRH7kN3wWA=;
	b=xriu/gwiZT2kxNs/oQ1w65/t3dTAb78sZbL4DzHkD+RfGIxQDzZ7tQ7+G+r6wbWcTOBptK
	4v0iRh4lGixYdT13A+djtqUiHeQXNePQM3rJQm+velTfXYbqoU2hlL2vRcsMTZG9CbxKvH
	xZhR04rkRX65tOffok3Owupa3xuCwFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708012768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYbT9HGAWfdr7p8j7wtUx16p3Lt7ILfaJCRH7kN3wWA=;
	b=kkXBOJaesWZfSs5r5xDkTRngfUJBsHBnHyhKIEy8Rdkp0p0XW+AUSlW4xlp7HU+UgWnNlE
	omNsEG3BNR2hBBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708012767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYbT9HGAWfdr7p8j7wtUx16p3Lt7ILfaJCRH7kN3wWA=;
	b=bUhAm7AEVRWoyDSF8yD3RaGghiP0pkHgs+Ij1hKHdYbYL/pFk4N61W8s4dYkJjtjQ0KtXU
	CFZLVKCCWZ12VcXWa7q3g7uJ5HepewwGgQsx52FlXlicIKtWkJz8rk6IuiRU2USG6QVxwI
	Q9P741i99LDhuRTEhJOxY0/lQxUdmgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708012767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYbT9HGAWfdr7p8j7wtUx16p3Lt7ILfaJCRH7kN3wWA=;
	b=3FY5kUQx/ZRaNWdW5qKUMJxHjPcJtUDo2qsMLIHGYxXDOgdJGB2RcIM/bavBakuoCxI2YH
	295wsqUPw7j6dwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A95A313A82;
	Thu, 15 Feb 2024 15:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Rh+J980zmVGfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Feb 2024 15:59:27 +0000
Date: Thu, 15 Feb 2024 16:59:27 +0100
Message-ID: <878r3len1c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	eniac-xw.zhang@hp.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
In-Reply-To: <20240215154922.778394-1-alexandru.gagniuc@hp.com>
References: <87frxteoil.wl-tiwai@suse.de>
	<20240215154922.778394-1-alexandru.gagniuc@hp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bUhAm7AE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3FY5kUQx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.86)[85.51%]
X-Spam-Score: -3.37
X-Rspamd-Queue-Id: ED2051F8BA
X-Spam-Flag: NO

On Thu, 15 Feb 2024 16:49:22 +0100,
Alexandru Gagniuc wrote:
> 
> From: Eniac Zhang <eniac-xw.zhang@hp.com>
> 
> The HP mt645 G7 Thin Client uses an ALC236 codec and needs the
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make the mute and
> micmute LEDs work.
> 
> There are two variants of the USB-C PD chip on this device. Each uses
> a different BIOS and board ID, hence the two entries.
> 
> Signed-off-by: Eniac Zhang <eniac-xw.zhang@hp.com>
> Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
> Cc: <stable@vger.kernel.org>

Thanks, applied now.


Takashi


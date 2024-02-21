Return-Path: <linux-kernel+bounces-74509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D185D547
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC76A282A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CD3D984;
	Wed, 21 Feb 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="unjQKVka";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y6j3qvVZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="unjQKVka";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y6j3qvVZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF733C493;
	Wed, 21 Feb 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510538; cv=none; b=fN2GUONedA1vHNQQecyMlYcjsD2gQp5tMIfyO8yCW7KBUCWHp73tgQE6hKtDPMir7w6AzbTXk3N1tcd0yAbCuJLYd/LNHSNeU7N/DJWdsH6cDmB1qufcn5MLMK74eiHi6wab+BpV6qsOqskmQIYZRH6tb++YyoI7ovWuxzDuGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510538; c=relaxed/simple;
	bh=FFhzB5J0U7oDf1Def7V0K2KK57vojCXFuzsSXD8TFBM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vm9qNo3+A+lWUJNl9ypB9VOYReCjaXGzBSd0od0RhPY4k5rqqGRYgB57M6INCrFFwbeTpoYtpZxVGgqlDbd8FRIrA/d6aBwjhX4OynUTnTEr26qr5WrOA2CcZFri463PB0+4kMKBMGjS7/5h62YTPwzHLuSNcHbg++VJHh03ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=unjQKVka; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y6j3qvVZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=unjQKVka; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y6j3qvVZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A81731FB4C;
	Wed, 21 Feb 2024 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708510534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnEpfxCF7g+UuoIAlRYfvXg3wCMzx5yNP4QWoEWyTKc=;
	b=unjQKVkaMfH6X9pDCO/+Q+i5tb6iPxxIGdXg5MpX/quYRXylOl3gFK07m5BrSOYN9qp1rs
	H43x/7IXDkreY6nf1fw3Fba4fih+jKN9diNc9StoNvKTQ7AtkVmyXtYgHLtaAuMZceczuR
	5XVjar+lYYTttSJFVQGBoa1MfgwJO0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708510534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnEpfxCF7g+UuoIAlRYfvXg3wCMzx5yNP4QWoEWyTKc=;
	b=y6j3qvVZNBxZYXlwPRbQ0cvtYXK0pnPnmicK81HuSDyQ61dedLe23K413zxGLCwNG0Kazx
	xXDPj+E+VzJK6IBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708510534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnEpfxCF7g+UuoIAlRYfvXg3wCMzx5yNP4QWoEWyTKc=;
	b=unjQKVkaMfH6X9pDCO/+Q+i5tb6iPxxIGdXg5MpX/quYRXylOl3gFK07m5BrSOYN9qp1rs
	H43x/7IXDkreY6nf1fw3Fba4fih+jKN9diNc9StoNvKTQ7AtkVmyXtYgHLtaAuMZceczuR
	5XVjar+lYYTttSJFVQGBoa1MfgwJO0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708510534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnEpfxCF7g+UuoIAlRYfvXg3wCMzx5yNP4QWoEWyTKc=;
	b=y6j3qvVZNBxZYXlwPRbQ0cvtYXK0pnPnmicK81HuSDyQ61dedLe23K413zxGLCwNG0Kazx
	xXDPj+E+VzJK6IBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B91513A69;
	Wed, 21 Feb 2024 10:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCCbGEbN1WXdQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Feb 2024 10:15:34 +0000
Date: Wed, 21 Feb 2024 11:15:34 +0100
Message-ID: <87edd66s3d.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	eniac-xw.zhang@hp.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt440
In-Reply-To: <20240220175812.782687-1-alexandru.gagniuc@hp.com>
References: <87frxteoil.wl-tiwai@suse.de>
	<20240220175812.782687-1-alexandru.gagniuc@hp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=unjQKVka;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y6j3qvVZ
X-Spamd-Result: default: False [-0.02 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
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
	 BAYES_HAM(-0.71)[83.51%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.02
X-Rspamd-Queue-Id: A81731FB4C
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue, 20 Feb 2024 18:58:12 +0100,
Alexandru Gagniuc wrote:
> 
> From: Eniac Zhang <eniac-xw.zhang@hp.com>
> 
> The HP mt440 Thin Client uses an ALC236 codec and needs the
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

But at the next time, don't hang on the existing thread when
submitting a new patch.


Takashi


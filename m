Return-Path: <linux-kernel+bounces-16402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42681823DEE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10DA1F24B44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85D71EA7E;
	Thu,  4 Jan 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xwZGXUtR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qfBUSdo4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xwZGXUtR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qfBUSdo4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB01EA71;
	Thu,  4 Jan 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 910DE21E73;
	Thu,  4 Jan 2024 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704358416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60pY3+TKeowAJTEaVySctoSv+hCzrSmVwOvZhPv/TuE=;
	b=xwZGXUtRJiRdVKlDQuXxAzS9QJHCdfY3oTf5juhly34nhize5xSUTJZoAh2CUalB+iCaNb
	MrmxGH5cpeffpB8VjVkJjcv6kc8/dmLq5SZhctEhRVa+6hba5YV1sPIAjUFenP09ZXrUDB
	gDnodDKckz7Nm2UDXSUU0AXLd1bwBAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704358416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60pY3+TKeowAJTEaVySctoSv+hCzrSmVwOvZhPv/TuE=;
	b=qfBUSdo4Dz9Uw9vvrnfXEiR8x6mdnbYmZrk9lrkmX2SP64Upz/F0v7lDUIXmYw8iIU1xDB
	D91wi1m732D3ooBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704358416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60pY3+TKeowAJTEaVySctoSv+hCzrSmVwOvZhPv/TuE=;
	b=xwZGXUtRJiRdVKlDQuXxAzS9QJHCdfY3oTf5juhly34nhize5xSUTJZoAh2CUalB+iCaNb
	MrmxGH5cpeffpB8VjVkJjcv6kc8/dmLq5SZhctEhRVa+6hba5YV1sPIAjUFenP09ZXrUDB
	gDnodDKckz7Nm2UDXSUU0AXLd1bwBAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704358416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60pY3+TKeowAJTEaVySctoSv+hCzrSmVwOvZhPv/TuE=;
	b=qfBUSdo4Dz9Uw9vvrnfXEiR8x6mdnbYmZrk9lrkmX2SP64Upz/F0v7lDUIXmYw8iIU1xDB
	D91wi1m732D3ooBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A40313722;
	Thu,  4 Jan 2024 08:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0BSLFBBylmUmVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Jan 2024 08:53:36 +0000
Date: Thu, 04 Jan 2024 09:53:35 +0100
Message-ID: <87il49a38w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Siddhesh Dharme <siddheshdharme18@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6
In-Reply-To: <20240104060736.5149-1-siddheshdharme18@gmail.com>
References: <20240104060736.5149-1-siddheshdharme18@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *****
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xwZGXUtR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qfBUSdo4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.95)[99.77%]
X-Spam-Score: -4.46
X-Rspamd-Queue-Id: 910DE21E73
X-Spam-Flag: NO

On Thu, 04 Jan 2024 07:07:36 +0100,
Siddhesh Dharme wrote:
> 
> LEDs in 'HP ProBook 440 G6' laptop are controlled by ALC236 codec.
> Enable already existing quirk 'ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF'
> to fix mute and mic-mute LEDs.
> 
> Signed-off-by: Siddhesh Dharme <siddheshdharme18@gmail.com>

Applied now.  Thanks.


Takashi


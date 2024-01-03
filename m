Return-Path: <linux-kernel+bounces-15369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAEA822AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF329281786
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13318656;
	Wed,  3 Jan 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="csPnfQS9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BE9BWfc3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="csPnfQS9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BE9BWfc3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43918AE4;
	Wed,  3 Jan 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78B1F22000;
	Wed,  3 Jan 2024 10:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704276095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRrlLOpUS4Z66xJflc9R/S145LEw3nb0i4YZ3phxOtA=;
	b=csPnfQS9M5QU2QqH7JDwqqGD6CM3dLH2+gP9oEJTVi9C2ZshkT4btm0pf7Evf0je3aOE/e
	oaePhQzne7j5Zt4NG2E73Y+UH/n9Lt8VvEgWtVVnTpUM5JiX/1VDkkvmIjy7SKglxrE/JU
	UIhaLNLkxxMenT3XEsGnjLkGLQqdohw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704276095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRrlLOpUS4Z66xJflc9R/S145LEw3nb0i4YZ3phxOtA=;
	b=BE9BWfc3P9bGZXFttHPxV0tG4rfn+tb8w1Em/0KWdSALYyApVsO6+qxXpTiao2XtRIIPGf
	496PLZOZMblWvhBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704276095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRrlLOpUS4Z66xJflc9R/S145LEw3nb0i4YZ3phxOtA=;
	b=csPnfQS9M5QU2QqH7JDwqqGD6CM3dLH2+gP9oEJTVi9C2ZshkT4btm0pf7Evf0je3aOE/e
	oaePhQzne7j5Zt4NG2E73Y+UH/n9Lt8VvEgWtVVnTpUM5JiX/1VDkkvmIjy7SKglxrE/JU
	UIhaLNLkxxMenT3XEsGnjLkGLQqdohw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704276095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRrlLOpUS4Z66xJflc9R/S145LEw3nb0i4YZ3phxOtA=;
	b=BE9BWfc3P9bGZXFttHPxV0tG4rfn+tb8w1Em/0KWdSALYyApVsO6+qxXpTiao2XtRIIPGf
	496PLZOZMblWvhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D90A13AA6;
	Wed,  3 Jan 2024 10:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1NCwBX8wlWXUdwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Jan 2024 10:01:35 +0000
Date: Wed, 03 Jan 2024 11:01:34 +0100
Message-ID: <87h6juburl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lorenz Brun <lorenz@brun.one>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: hda: cs35l41: Support more HP models without _DSD
In-Reply-To: <20240102214821.3394810-1-lorenz@brun.one>
References: <20240102214821.3394810-1-lorenz@brun.one>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.53)[97.91%]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=csPnfQS9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BE9BWfc3
X-Spam-Score: -1.84
X-Rspamd-Queue-Id: 78B1F22000

On Tue, 02 Jan 2024 22:48:20 +0100,
Lorenz Brun wrote:
> 
> This adds overrides for a series of notebooks using a common config
> taken from HP's proprietary Windows driver.
> 
> This has been tested on a HP 15-ey0xxxx device (subsystem 103C8A31)
> together with another Realtek quirk and the calibration files from the
> proprietary driver.
> 
> Signed-off-by: Lorenz Brun <lorenz@brun.one>

Applied now.  Thanks.


Takashi


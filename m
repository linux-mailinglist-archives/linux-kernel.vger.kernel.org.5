Return-Path: <linux-kernel+bounces-27159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1ED82EB57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A0CB220CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4F12B6E;
	Tue, 16 Jan 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1yblC7tX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ogVjHOhL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1yblC7tX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ogVjHOhL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678C125C8;
	Tue, 16 Jan 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76C7F220EE;
	Tue, 16 Jan 2024 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705396500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/q28bq2IPwljKWkNpRnhO3yGpDnEFg1mwIdnMakniJ4=;
	b=1yblC7tXeVIvm71Uh2szz++K+EO3vId6IfrXldwvR68+ZXmDcgQpKCOzOugviJZs5sTKSo
	/9CKDAgYPgXD9ZQAN23RJEoa6evIAHE5nSGvBLPX2kDcQi3YHfXEW73rdFzggpxjvt+LDG
	MbCCCka51y0K8eewYXeaDbhsARp0b14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705396500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/q28bq2IPwljKWkNpRnhO3yGpDnEFg1mwIdnMakniJ4=;
	b=ogVjHOhLIzeEURRkhN4euSLbIDrSSQwG1UEqFHPI9sVJTFP6RrF/fQ9O/mhrhEd9wPpN/e
	wqe65bEZSvHHfWCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705396500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/q28bq2IPwljKWkNpRnhO3yGpDnEFg1mwIdnMakniJ4=;
	b=1yblC7tXeVIvm71Uh2szz++K+EO3vId6IfrXldwvR68+ZXmDcgQpKCOzOugviJZs5sTKSo
	/9CKDAgYPgXD9ZQAN23RJEoa6evIAHE5nSGvBLPX2kDcQi3YHfXEW73rdFzggpxjvt+LDG
	MbCCCka51y0K8eewYXeaDbhsARp0b14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705396500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/q28bq2IPwljKWkNpRnhO3yGpDnEFg1mwIdnMakniJ4=;
	b=ogVjHOhLIzeEURRkhN4euSLbIDrSSQwG1UEqFHPI9sVJTFP6RrF/fQ9O/mhrhEd9wPpN/e
	wqe65bEZSvHHfWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D49D132FA;
	Tue, 16 Jan 2024 09:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4x2qBRRJpmXDDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 16 Jan 2024 09:15:00 +0000
Date: Tue, 16 Jan 2024 10:14:59 +0100
Message-ID: <874jfdwsfg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kenzo Gomez <kenzo.sgomez@gmail.com>
Cc: sbinding@opensource.cirrus.com,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
In-Reply-To: <20240112182113.70650-1-kenzo.sgomez@gmail.com>
References: <20240112163239.59743-1-kenzo.sgomez@gmail.com>
	<20240112182113.70650-1-kenzo.sgomez@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1yblC7tX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ogVjHOhL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 76C7F220EE
X-Spam-Flag: NO

On Fri, 12 Jan 2024 19:20:34 +0100,
Kenzo Gomez wrote:
> 
> Add new model entry into configuration table.
> 
> Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>

This isn't applied cleanly to the latest code, as there were code
changes to drop some fields.

Please rebase on top of for-linus branch of sound.git tree (or the
latest Linus tree) and resubmit.


thanks,

Takashi

> ---
>  sound/pci/hda/cs35l41_hda_property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index c1afb721b4c6..9ec5773e580e 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -54,6 +54,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "10431533", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431573", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
>  	{ "10431663", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
> +	{ "104316A3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104316D3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104316F3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104317F3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> @@ -358,6 +359,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "10431533", generic_dsd_config },
>  	{ "CSC3551", "10431573", generic_dsd_config },
>  	{ "CSC3551", "10431663", generic_dsd_config },
> +	{ "CSC3551", "104316A3", generic_dsd_config },
>  	{ "CSC3551", "104316D3", generic_dsd_config },
>  	{ "CSC3551", "104316F3", generic_dsd_config },
>  	{ "CSC3551", "104317F3", generic_dsd_config },
> -- 
> 2.43.0
> 


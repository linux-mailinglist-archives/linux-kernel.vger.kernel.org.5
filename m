Return-Path: <linux-kernel+bounces-41618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262383F56F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3510A1F21E23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB46020B04;
	Sun, 28 Jan 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l9KTQ5bc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hWrkoH6q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l9KTQ5bc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hWrkoH6q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD93208B4;
	Sun, 28 Jan 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443892; cv=none; b=X+/9+Ke+7KNUqgJ2+zIZ05QI2yLbSrBYfYlSTAqA9y5jhMMABZE9MJX2uc2XjqUT0gtBpLBX2LUzQK8eBs7ypQ4nqphDhmbF6LQ4NyLn8nz0jsfSPpmMMD52oHpgOg7R6kg70pIGCm3AXgaSYvc5Rm/jTBGIcBAtxhePY1plGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443892; c=relaxed/simple;
	bh=FQzq2NAotC6wUwaYUkpZ6HIbEUogOXl600xzI6zhA3M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TClaablG9PDcEd+jpOWHGTZqzZq+dCqo7TZA/gv1iRa4/qUytpMxlaxS4M2sSZI6SFcag2E8Qd+yUgDjxLa9flK6O9l/A09axnR34rpgUz+O0PxN+AgzYofH/Vv2Q9RyasaP4jTICRrQDi63SLx2nGJEOCxMnKKZUkQWNn6/CqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l9KTQ5bc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hWrkoH6q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l9KTQ5bc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hWrkoH6q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7FC51F785;
	Sun, 28 Jan 2024 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706443888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=l9KTQ5bcyVy6bLVoIHOJK4BScfdG6DXFVv2ZcSFDteRwjEA/5bJl0S4d1Ve8WSzILFaJBE
	azxW2cFOyF/Uhw1ZJb/8BB8Pwlca0rFtrvdVGjd2kTnjRtQX5EfZNLmb+tTT5HF3IrIty2
	cj358sPztKLfqsM3I7FrtgiDh94r72Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706443888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=hWrkoH6qQg2VeOEV2IIT2RHQ/UTAU2k1X6sgqo7D/6WmDKi2+fOHLYC1kfXiA9DrXcX73e
	CyjGnV3UCXEwivCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706443888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=l9KTQ5bcyVy6bLVoIHOJK4BScfdG6DXFVv2ZcSFDteRwjEA/5bJl0S4d1Ve8WSzILFaJBE
	azxW2cFOyF/Uhw1ZJb/8BB8Pwlca0rFtrvdVGjd2kTnjRtQX5EfZNLmb+tTT5HF3IrIty2
	cj358sPztKLfqsM3I7FrtgiDh94r72Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706443888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=hWrkoH6qQg2VeOEV2IIT2RHQ/UTAU2k1X6sgqo7D/6WmDKi2+fOHLYC1kfXiA9DrXcX73e
	CyjGnV3UCXEwivCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87B8312FF7;
	Sun, 28 Jan 2024 12:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hKyWH3BEtmU2CgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 28 Jan 2024 12:11:28 +0000
Date: Sun, 28 Jan 2024 13:11:28 +0100
Message-ID: <87zfwpmzdb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/4] Support HP Models without _DSD
In-Reply-To: <20240126164005.367021-1-sbinding@opensource.cirrus.com>
References: <20240126164005.367021-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.71)[98.72%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.81

On Fri, 26 Jan 2024 17:40:01 +0100,
Stefan Binding wrote:
> 
> Add Quirks and driver properties for Dell models.
> Driver properties are required since these models do not have _DSD.
> Some models require special handing for Speaker ID and cannot use
> the configuration table to add properties.
> Also fix an issue for Channel Index property, when set through the
> configuration table, to use the same method as when loading _DSD
> properties. This is needed for laptops with 4 amps where the
> channels do not alternate.
> 
> Changes from v1:
> - Rebase on latest for-next
> 
> Stefan Binding (4):
>   ALSA: hda: cs35l41: Set Channel Index correctly when system is missing
>     _DSD
>   ALSA: hda: cs35l41: Support additional HP Envy Models
>   ALSA: hda: cs35l41: Support HP models without _DSD using dual Speaker
>     ID
>   ALSA: hda/realtek: Add quirks for various HP ENVY models

Applied all four patches now.


thanks,

Takashi


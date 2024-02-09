Return-Path: <linux-kernel+bounces-59327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA084F572
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133BA287253
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C2376F1;
	Fri,  9 Feb 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vvuJvAfI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lfP41yDI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vvuJvAfI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lfP41yDI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCA2E834;
	Fri,  9 Feb 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483408; cv=none; b=etJHzklHnG0oCYWqYojzAv0DhymabmdjcB5aAFm6cg0ESBcOjwrYNcPsvzCjwWlTvyTFfqetaF9hdZwBtco/EkxqBds/PZXcv9lBM5Y2rEphb4gZrdCRftaHxyNrf96I9GDxXugp7nBZQPLssfGW7wtRL13qOd771nugAfo4Tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483408; c=relaxed/simple;
	bh=vz7WmaJKxSLR9cTZS0snEgTs6qW/i6xAZX9T17iieKQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha5d15i8FBnt8a5P6dsVA539nx381mg9o/FFQxNQgpqtiAOsQk3nkfJtBcjhVALK0u0SprjwDvIAeF4rGpBBLdCNm4F8eMEgpmjA/BePTyYhD0EttE3zKGDOwYx3hmf++zlkSstN11eDgbFQm5Jk7vVygQLXps7WCQpbJ3gSm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vvuJvAfI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lfP41yDI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vvuJvAfI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lfP41yDI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A78061F808;
	Fri,  9 Feb 2024 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707483404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2WFYZu1fDS3ytGuxWo6CElT3uSbG6y5j9xkJhZ4dqA=;
	b=vvuJvAfIhQOtclkOy4futXBVHAPM69yS/xoEUFkFh3QlSY/QoT+7pP0h2O1jvw4OIfx4R+
	uRr9PIfGUss5v7PsAuoSSVU0iKFPZGl3QGsOYD2VzWeUTiSF7+YOkmGSE4cKK/9vG4wGUK
	hbzzIXiQXz0LadQDZT0HowIlmN066Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707483404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2WFYZu1fDS3ytGuxWo6CElT3uSbG6y5j9xkJhZ4dqA=;
	b=lfP41yDIvmo+jL8W1gj06hYnKi9CIYP3ER1sSS1FjnQH1+6mpT5YjbMv9lC0HGvD9PQzZv
	KErS2g/Wi3PiRzBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707483404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2WFYZu1fDS3ytGuxWo6CElT3uSbG6y5j9xkJhZ4dqA=;
	b=vvuJvAfIhQOtclkOy4futXBVHAPM69yS/xoEUFkFh3QlSY/QoT+7pP0h2O1jvw4OIfx4R+
	uRr9PIfGUss5v7PsAuoSSVU0iKFPZGl3QGsOYD2VzWeUTiSF7+YOkmGSE4cKK/9vG4wGUK
	hbzzIXiQXz0LadQDZT0HowIlmN066Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707483404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2WFYZu1fDS3ytGuxWo6CElT3uSbG6y5j9xkJhZ4dqA=;
	b=lfP41yDIvmo+jL8W1gj06hYnKi9CIYP3ER1sSS1FjnQH1+6mpT5YjbMv9lC0HGvD9PQzZv
	KErS2g/Wi3PiRzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B5C11326D;
	Fri,  9 Feb 2024 12:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YSyeGAwhxmVuUwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Feb 2024 12:56:44 +0000
Date: Fri, 09 Feb 2024 13:56:43 +0100
Message-ID: <87a5o923uc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/cs35l56: select intended config FW_CS_DSP
In-Reply-To: <20240209082044.3981-1-lukas.bulwahn@gmail.com>
References: <20240209082044.3981-1-lukas.bulwahn@gmail.com>
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
X-Spamd-Result: default: False [1.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.28)[89.92%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.12
X-Spam-Flag: NO

On Fri, 09 Feb 2024 09:20:44 +0100,
Lukas Bulwahn wrote:
> 
> Commit 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic
> CS35L56 amplifier") adds configs SND_HDA_SCODEC_CS35L56_{I2C,SPI},
> which selects the non-existing config CS_DSP. Note the renaming in
> commit d7cfdf17cb9d ("firmware: cs_dsp: Rename KConfig symbol CS_DSP ->
> FW_CS_DSP"), though.
> 
> Select the intended config FW_CS_DSP.
> 
> This broken select command probably was not noticed as the configs also
> select SND_HDA_CS_DSP_CONTROLS and this then selects FW_CS_DSP. So, the
> select FW_CS_DSP could actually be dropped, but we will keep this
> redundancy in place as the author originally also intended to have this
> redundancy of selects in place.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks, applied.


Takashi


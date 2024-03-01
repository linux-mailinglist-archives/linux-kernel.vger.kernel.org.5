Return-Path: <linux-kernel+bounces-88282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F386DF96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCBD1C21F58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F66BFA0;
	Fri,  1 Mar 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GhvRVu/C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sq+LaSDe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GhvRVu/C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sq+LaSDe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D096313B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290068; cv=none; b=ksu5PYZp/9x4o0yqHA2gWUgdHPDn8jndJYazuXJ7A4JX4z+uRNLgi52uI4GB+CjW2/DdMEvOzixWzrirf8LcVP6RgbhYISh3qkajWq9iBO/RULlyTdZK0MSmlCylPGbvQUnLmXysZWm4hkVAMj6nUNrNHU5IBUkRNmYHVAKLemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290068; c=relaxed/simple;
	bh=GncIjYQFKSI5OHKs2/2JjiMcE0TZH3rTYcWPo/6HJqA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP36kMBuKE0vTJjLLbqByj8KOMrOwucob9liAjGj53n6iicuopvo1JUHKxkEbT99aTTm+QrhoEoWQ1QuoGHvgQax8EeV9HUgRpiqYP3G8yufROvX4tb8RDMF96dJ3yG4XunNj+xlYLG+SlQIhbq9yj+SvkfizihJXOSVcbvTjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GhvRVu/C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sq+LaSDe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GhvRVu/C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sq+LaSDe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FA5720196;
	Fri,  1 Mar 2024 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709290065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWGSaEX/Y5LMnuTka/zcFMuOxuaVz5XxBPp27koraVs=;
	b=GhvRVu/Cw8VfI9KQO5dvejU32WKE58DUFLCI9mWBi7PNvErU9ZI8I6tnh7je8iss7Zc3AZ
	Y5rDgj5LObPpPGp95OIP9lLpHCFuT6CcI6PZf3zytAfuq1HA0YvgN9kEd8F7L2qHLx+mdj
	mSSrPd5yeSNLNes3NeoHoABXVGpxTRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709290065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWGSaEX/Y5LMnuTka/zcFMuOxuaVz5XxBPp27koraVs=;
	b=Sq+LaSDeFROys/+qh21g/9XXQzVygEe7k4URIZUUIBLr9EMSk6ms3D1tQpzAsCkK6VzypX
	qdVuigJrIAJieTCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709290065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWGSaEX/Y5LMnuTka/zcFMuOxuaVz5XxBPp27koraVs=;
	b=GhvRVu/Cw8VfI9KQO5dvejU32WKE58DUFLCI9mWBi7PNvErU9ZI8I6tnh7je8iss7Zc3AZ
	Y5rDgj5LObPpPGp95OIP9lLpHCFuT6CcI6PZf3zytAfuq1HA0YvgN9kEd8F7L2qHLx+mdj
	mSSrPd5yeSNLNes3NeoHoABXVGpxTRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709290065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWGSaEX/Y5LMnuTka/zcFMuOxuaVz5XxBPp27koraVs=;
	b=Sq+LaSDeFROys/+qh21g/9XXQzVygEe7k4URIZUUIBLr9EMSk6ms3D1tQpzAsCkK6VzypX
	qdVuigJrIAJieTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F041413A59;
	Fri,  1 Mar 2024 10:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5wqOVCy4WXJMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 01 Mar 2024 10:47:44 +0000
Date: Fri, 01 Mar 2024 11:47:44 +0100
Message-ID: <87a5ni5iun.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: songxiebing <soxiebing@163.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	songxiebing@kylinos.cn,
	tiwai@suse.com
Subject: Re: [PATCH v2] ALSA: hda: optimize the probe codec process
In-Reply-To: <20240301011841.7247-1-soxiebing@163.com>
References: <878r35huf0.wl-tiwai@suse.de>
	<20240301011841.7247-1-soxiebing@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="GhvRVu/C";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Sq+LaSDe
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[163.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[163.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2FA5720196
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Fri, 01 Mar 2024 02:18:41 +0100,
songxiebing wrote:
> 
> From: songxiebing <songxiebing@kylinos.cn>
> 
> In azx_probe_codecs function, when bus->codec_mask is becomes to 0(no codecs),
> execute azx_init_chip, bus->codec_mask will be initialized to a value again,
> this causes snd_hda_codec_new function to run, the process is as follows:
> -->snd_hda_codec_new
> -->snd_hda_codec_device_init
> -->snd_hdac_device_init---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_SUBSYSTEM_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_REV_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_NODE_COUNT) 2s
> when no codecs, read communication is error, each command will be polled for
> 2 second, a total of 10s, it is easy to some problem.
> like this:
>   2 [   14.833404][ 6] [  T164] hda 0006:00: Codec #0 probe error; disabling it...
>   3 [   14.844178][ 6] [  T164] hda 0006:00: codec_mask = 0x1
>   4 [   14.880532][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0000
>   5 [   15.891988][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0000
>   6 [   16.978090][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0001
>   7 [   18.140895][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0002
>   8 [   19.135516][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0004
>  10 [   19.900086][ 6] [  T164] hda 0006:00: no codecs initialized
>  11 [   45.573398][ 2] [    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [kworker/2:0:25]
> 
> Here, when bus->codec_mask is 0, use a direct break to avoid execute snd_hda_codec_new function.
> 
> Signed-off-by: songxiebing <songxiebing@kylinos.cn>
> ---
> Changes in v2: fix some non-ASCII comma letters.

Thanks, applied now.


Takashi


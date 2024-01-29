Return-Path: <linux-kernel+bounces-42325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF783FF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952DE1C221BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E09852F6E;
	Mon, 29 Jan 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ELocXG1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JQDQA61D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ELocXG1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JQDQA61D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E6524CD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515625; cv=none; b=cTgDw1CTJLMkG5O7W/EXRAKPUsRqvVDALqVIuy6UiEXqwfbrZB5rp1A1hqPXH9ZjJiex7f9oXOZ2x+5R5Kg20fT9Y5U4/c0VY4TtcLEkN3yAUk6opiD+LRQhPD12K0N+CvQBGihgO/vLJtNvS6eIGo7cUC2UY4ZCiv7YC2WsK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515625; c=relaxed/simple;
	bh=H35fdW4gVungKlRweV6QGxtbuZchIY35GN2KZum2j/Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP9UD2Tu6+DVI7UCXHo4nHR4+ufgC0rX5IgCtx4EVbiiUIw3HH8nrMVPtbnIP2R5pnWrrJvJP5oh312nuZolZs3kAGdP52JbTYbo63WK2MBZLNUrKt50n2YveIEs2LMJ/LtZ4La/20Wh/qW9PH2UODxOjmKLGWdjMd5JV2FxfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ELocXG1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JQDQA61D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ELocXG1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JQDQA61D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15E5E22278;
	Mon, 29 Jan 2024 08:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706515622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gR9Q6QtUFPxQ5lRGmQh7es6crm7lqvpf2h3nR4Z5S/k=;
	b=ELocXG1fbHxWtJwt1sW55ENrf/EoEygqFD9tdE1ixiMCl8h5KkmBXtRK1BM1P+oMsrUQLB
	dLia7g836dvmRMlvQzuNcIm7G0Qx7S9WwMMJMFhhHWNR3S6dQgffQPc7/ooTz7/UEtkREH
	HhqSg81xKPDk0MIcCW1swMwuFaN5fjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706515622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gR9Q6QtUFPxQ5lRGmQh7es6crm7lqvpf2h3nR4Z5S/k=;
	b=JQDQA61DKFDzTwtSQN1Ry6u6uwB2/HnCYn+RR8Ng9zg/zI6q33t5UavZwuAEQRoUw+7JNo
	zPVbE/wtjN/s7HBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706515622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gR9Q6QtUFPxQ5lRGmQh7es6crm7lqvpf2h3nR4Z5S/k=;
	b=ELocXG1fbHxWtJwt1sW55ENrf/EoEygqFD9tdE1ixiMCl8h5KkmBXtRK1BM1P+oMsrUQLB
	dLia7g836dvmRMlvQzuNcIm7G0Qx7S9WwMMJMFhhHWNR3S6dQgffQPc7/ooTz7/UEtkREH
	HhqSg81xKPDk0MIcCW1swMwuFaN5fjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706515622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gR9Q6QtUFPxQ5lRGmQh7es6crm7lqvpf2h3nR4Z5S/k=;
	b=JQDQA61DKFDzTwtSQN1Ry6u6uwB2/HnCYn+RR8Ng9zg/zI6q33t5UavZwuAEQRoUw+7JNo
	zPVbE/wtjN/s7HBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA1C712FF7;
	Mon, 29 Jan 2024 08:07:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6mPuM6Vct2XeWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Jan 2024 08:07:01 +0000
Date: Mon, 29 Jan 2024 09:07:01 +0100
Message-ID: <87o7d4mul6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luka Guzenko <l.guzenko@web.de>
Cc: tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx
In-Reply-To: <20240128155704.2333812-1-l.guzenko@web.de>
References: <20240128155704.2333812-1-l.guzenko@web.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ELocXG1f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JQDQA61D
X-Spamd-Result: default: False [-1.92 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[web.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[web.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.61)[98.26%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 15E5E22278
X-Spam-Level: 
X-Spam-Score: -1.92
X-Spam-Flag: NO

On Sun, 28 Jan 2024 16:57:04 +0100,
Luka Guzenko wrote:
> 
> This HP Laptop uses ALC236 codec with COEF 0x07 controlling the
> mute LED. Enable existing quirk for this device.
> 
> Signed-off-by: Luka Guzenko <l.guzenko@web.de>

Thanks, applied now.


Takashi


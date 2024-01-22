Return-Path: <linux-kernel+bounces-32984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75778362CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577271F238F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A543B282;
	Mon, 22 Jan 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pciRvT6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cg2KM1A5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pciRvT6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cg2KM1A5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F323B781;
	Mon, 22 Jan 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925271; cv=none; b=oDam3DRXBcg/ILZXOqEpByzjXQ2ZAgP3tod8/I2JGLDPQl2KeT8ams0gcdpHNO6m0eQrtYKWhxECCD9dm3AHnVcB9ElqSGwFafI3comfFm1MeYUbZvu1lI1lMceJjkiVy8tACbR23PT5mNZ91Pbs+uDQ7I99qSFVw0OVffRImM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925271; c=relaxed/simple;
	bh=CixXdO6L97yTmXCmrviahH+3fGc5B5cIC/8ZuU/XwmQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ8sz+z83DUHA5FA8Q7y3cik77BWiK8y+xRertwps8zVhOaHbl95Wk3vNVUAfp5TXgGYsJzkrCmMCwWKHUpWEHQbLtcpaAXzxjMQZvBxTTaU+amu1m9PQSxDOjf2ZYY0hsK3PJX7d9mjp94iWAdnOSnz90EAiuAULdvwarpeffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pciRvT6f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cg2KM1A5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pciRvT6f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cg2KM1A5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3008222A0;
	Mon, 22 Jan 2024 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705925268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdnB6ps93L9KKLDzp3Va5cDDdlG9KAe7wrmPY1lnT9E=;
	b=pciRvT6fNztMytFXB0YJhHDHYSoJ7JmoNmAyrzD+CbDI6h1wVFkloqnDJnC613MyOJ/Idq
	5TOFt2lzJZ08lQCUpljlPzKjT065N/QxywhoDfoDbGJVGfH3BRPHrOlIiVRCqJhE0euaHI
	8AO3uKjNLFdbeKVcdWQqykNI42bMwas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705925268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdnB6ps93L9KKLDzp3Va5cDDdlG9KAe7wrmPY1lnT9E=;
	b=Cg2KM1A53/c+vBHa0cR11fo/d341fORkHokwieuM44QhLX9aHzpdv8UlrF7vrMBEldAzG+
	JLtSAbQi7kNr8RAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705925268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdnB6ps93L9KKLDzp3Va5cDDdlG9KAe7wrmPY1lnT9E=;
	b=pciRvT6fNztMytFXB0YJhHDHYSoJ7JmoNmAyrzD+CbDI6h1wVFkloqnDJnC613MyOJ/Idq
	5TOFt2lzJZ08lQCUpljlPzKjT065N/QxywhoDfoDbGJVGfH3BRPHrOlIiVRCqJhE0euaHI
	8AO3uKjNLFdbeKVcdWQqykNI42bMwas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705925268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdnB6ps93L9KKLDzp3Va5cDDdlG9KAe7wrmPY1lnT9E=;
	b=Cg2KM1A53/c+vBHa0cR11fo/d341fORkHokwieuM44QhLX9aHzpdv8UlrF7vrMBEldAzG+
	JLtSAbQi7kNr8RAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BA2D139B0;
	Mon, 22 Jan 2024 12:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +HwAGZRarmW9JwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Jan 2024 12:07:48 +0000
Date: Mon, 22 Jan 2024 13:07:47 +0100
Message-ID: <87a5oxy3jg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: synth: Save a few bytes of memory when registering a 'snd_emux'
In-Reply-To: <9e7b94c852a25ed4be5382e5e48a7dd77e8d4d1a.1705743706.git.christophe.jaillet@wanadoo.fr>
References: <9e7b94c852a25ed4be5382e5e48a7dd77e8d4d1a.1705743706.git.christophe.jaillet@wanadoo.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.26
X-Spamd-Result: default: False [-3.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[wanadoo.fr];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.96)[99.81%]
X-Spam-Flag: NO

On Sat, 20 Jan 2024 10:42:12 +0100,
Christophe JAILLET wrote:
> 
> snd_emux_register() calls pass a string literal as the 'name' parameter.
> 
> So kstrdup_const() can be used instead of kfree() to avoid a memory
> allocation in such cases.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, applied now.


Takashi


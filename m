Return-Path: <linux-kernel+bounces-157166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA418B0DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A281F2779C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2582315F301;
	Wed, 24 Apr 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vJut1mN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YB1CO9Au";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vJut1mN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YB1CO9Au"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957F15ECFA;
	Wed, 24 Apr 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971345; cv=none; b=kCj2wt0/9DW2fhyEetQB/OJlM1rocm4sN3hbIAWBb0SXgwKr7sRiE0iWSWVXT8lVPL4iAm9rOiwgJpqLqyhh2FWM7/eoM8lQh/7s2i5QWLksGpHojpSqSOXm6dTXhY5dFfkjpSytxfJYQb68CATjEUr6gxIyjdBeCkka6qBPe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971345; c=relaxed/simple;
	bh=1cC+dl99vUkCC/y/DlMQ3kWiLeXLZTw215yKJsh50Gg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acijkyWFktOGwzessf6mzdgmusKAGgD5tcoomVVgTm02bu2yjVH34lfWebc8VtfTWOBvnprdIW4jSo6viSySlsIsIDbluBGRuzAMjXt3gJoWKkQOB6aB3pA+/Ve2AE0vLq2ZUg7kWn0PAeKd6Qp6y5N2lA8Ixdt6jKfTTqwk+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vJut1mN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YB1CO9Au; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vJut1mN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YB1CO9Au; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C74643E87D;
	Wed, 24 Apr 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713971341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLdpY+1hIEu3e4O0c0geOCLCPxEN5AFsYCzq4SoIol0=;
	b=vJut1mN2LqJfc1IY40T3t9VmfM1dB0Uze3e/LUY6CukUwLdARzvgt8UljBg26AtPPdcgnl
	yQRfcVt4BJpamY/IMcqaiskvP2i3J7JmR3Egdp1unyhQyTv8Q8fxyqdBVQbtWVYUf4QkoU
	oLcZL9q5m29KvG8wtdE+PuJh8dk6+4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713971341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLdpY+1hIEu3e4O0c0geOCLCPxEN5AFsYCzq4SoIol0=;
	b=YB1CO9Auo8xLcnDR0CgOsrbBGaRzyWPc00ual1Qfa+zqV2BfhMYi3uj6Cpb7NU6DrDoqPm
	1HPbWBqLHb0A/nCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713971341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLdpY+1hIEu3e4O0c0geOCLCPxEN5AFsYCzq4SoIol0=;
	b=vJut1mN2LqJfc1IY40T3t9VmfM1dB0Uze3e/LUY6CukUwLdARzvgt8UljBg26AtPPdcgnl
	yQRfcVt4BJpamY/IMcqaiskvP2i3J7JmR3Egdp1unyhQyTv8Q8fxyqdBVQbtWVYUf4QkoU
	oLcZL9q5m29KvG8wtdE+PuJh8dk6+4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713971341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLdpY+1hIEu3e4O0c0geOCLCPxEN5AFsYCzq4SoIol0=;
	b=YB1CO9Auo8xLcnDR0CgOsrbBGaRzyWPc00ual1Qfa+zqV2BfhMYi3uj6Cpb7NU6DrDoqPm
	1HPbWBqLHb0A/nCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A84AF13690;
	Wed, 24 Apr 2024 15:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C1tvKI0gKWZvIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Apr 2024 15:09:01 +0000
Date: Wed, 24 Apr 2024 17:09:12 +0200
Message-ID: <875xw6dch3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v3 1/1] ALSA: control: Use list_for_each_entry_safe()
In-Reply-To: <20240424145020.1057216-1-andriy.shevchenko@linux.intel.com>
References: <20240424145020.1057216-1-andriy.shevchenko@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.11
X-Spam-Level: 
X-Spamd-Result: default: False [-3.11 / 50.00];
	BAYES_HAM(-2.81)[99.17%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email]

On Wed, 24 Apr 2024 16:49:41 +0200,
Andy Shevchenko wrote:
> 
> Instead of reiterating the list, use list_for_each_entry_safe()
> that allows to continue without starting over.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> ---
> v3: Update snd_ctl_led_reset() in the same way (Takashi)
> v2: added tag (Jaroslav)

Thanks, applied now.


Takashi


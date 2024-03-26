Return-Path: <linux-kernel+bounces-118872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325488C07F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DFE301DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E755C13;
	Tue, 26 Mar 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qFWDvUdh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RGiqrTXZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qFWDvUdh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RGiqrTXZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8152F9A;
	Tue, 26 Mar 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452012; cv=none; b=bWIXRkLEK8Ahx95scb1H/GiKu+Wwqd9F26sScc32GiYYHzI04fRxRM52gPBg4nWAfGSjfm2JoEs0vNzl5gYqiVvuzunsIor6RRtdyUklCGcmTwwaihpPn96hzprsL9/cI+Xk1cdkHBZVMMy0pJGNnH2gp6uw6pHas6j+8YYN+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452012; c=relaxed/simple;
	bh=JZJYfdkOEfrBChAlxdomlE/FMRCLxwEMSTjs1gzQjmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIWrA1tsvzfq/ZGLVKfIeucb57xB972ia22tQYHGCo/DtQ3QRgGjRrDid3REZrsR/gJSUH7UXChIAL20yar4Lt/Qvij7im5u8V5DooNu8oCD21lO9AS0tZ5djNcxBhufxGNmHf0qgR3GPvudS+5vdcQpPt47cciUyJxowhz7o2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qFWDvUdh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RGiqrTXZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qFWDvUdh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RGiqrTXZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E50037AD9;
	Tue, 26 Mar 2024 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711452007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUTUfOoY+2SogT+OaWxxDe3rJC42MpmS4UtIqhLd8AA=;
	b=qFWDvUdhEw+1w/36ez/ULmEshiSbU5BLtgbDEF5s7BImFrCk9b0FDVTJDah6rEIFcP+GDv
	1tKvqWfah85kRk1vM3jHpa66iHIuxUF0xWPPxWdWbTDHPxRbl4bYf6kuD+FcICqI/jIQdT
	LFo/4EeF93yBxknPJXIF9twrAR84Y0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711452007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUTUfOoY+2SogT+OaWxxDe3rJC42MpmS4UtIqhLd8AA=;
	b=RGiqrTXZMmGKLYf71hZOyClLQLEXPh5KTBTWeJIWdVc50zMD57PT2M/+RVnKyF8BAcKIus
	hrKfijCK98fmQMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711452007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUTUfOoY+2SogT+OaWxxDe3rJC42MpmS4UtIqhLd8AA=;
	b=qFWDvUdhEw+1w/36ez/ULmEshiSbU5BLtgbDEF5s7BImFrCk9b0FDVTJDah6rEIFcP+GDv
	1tKvqWfah85kRk1vM3jHpa66iHIuxUF0xWPPxWdWbTDHPxRbl4bYf6kuD+FcICqI/jIQdT
	LFo/4EeF93yBxknPJXIF9twrAR84Y0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711452007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUTUfOoY+2SogT+OaWxxDe3rJC42MpmS4UtIqhLd8AA=;
	b=RGiqrTXZMmGKLYf71hZOyClLQLEXPh5KTBTWeJIWdVc50zMD57PT2M/+RVnKyF8BAcKIus
	hrKfijCK98fmQMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2737D13306;
	Tue, 26 Mar 2024 11:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n7DQB2evAmb6DgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Mar 2024 11:20:07 +0000
Date: Tue, 26 Mar 2024 12:20:08 +0100
Message-ID: <87le65utnb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning
In-Reply-To: <ZgIsBqoMb7p3fMDr@neat>
References: <ZgIsBqoMb7p3fMDr@neat>
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
X-Spam-Score: -3.29
X-Spamd-Result: default: False [-3.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.97%]
X-Spam-Flag: NO

On Tue, 26 Mar 2024 02:59:34 +0100,
Gustavo A. R. Silva wrote:
> 
> Use the `DEFINE_FLEX()` helper for an on-stack definition of a
> flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> sound/firewire/amdtp-stream.c:1184:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use DEFINE_FLEX() helper instead of a new tagged struct.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/d3a764eb76909b16b8a22d9ff530e5edf0e59e6b.1709658886.git.gustavoars@kernel.org/

Applied now.  Thanks.


Takashi


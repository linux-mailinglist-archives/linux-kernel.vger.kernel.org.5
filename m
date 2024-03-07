Return-Path: <linux-kernel+bounces-96478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEAB875CB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A19A1C21293
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4762C1A3;
	Fri,  8 Mar 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nocBvkjm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OK+uAUHW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nocBvkjm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OK+uAUHW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86795C99;
	Fri,  8 Mar 2024 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868455; cv=none; b=epM+qvyeyKDnZdovUmTApbkzSEKZt6tY2cKkigw5TwKuGcvCYlJnOiT70gdGdGZsi8cDvctpzMJur3sSFuFw7BJXKRJs9HbLN5UPhKA2+kbdWmGdfO25rDPYuSqfc+2//izlGwPXWnixXwDMgX1vmKsf8BGi4MqAdG2I7PoPvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868455; c=relaxed/simple;
	bh=uT5NxCosrcGa0uMON5obvvuAZK/yHU43ALWlFYP0uko=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmcsgcmrb18/V+F0qHSiR3ufex7mttOsHVKiLGkoVdJ3IWk/PmZ5EdsMJhnu9ZHgr1DzNehj839SxWAaom6B1u8VXtlnTFaQLzrkMJ2RVKyu78PYK00HyJk/URPU6CDHewa89ULZlIB290Rhc42kl0lnB9296uOKqIrpCXqBTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nocBvkjm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OK+uAUHW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nocBvkjm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OK+uAUHW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FFBD8CDF0;
	Thu,  7 Mar 2024 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709828938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcYB3THyLEHAGqQD5ulPE5CsY6vdqyT5FGwSx8tObPQ=;
	b=nocBvkjmC+2+qVgS3MNjA0sKHbC4JjTj4jfMJbFYOqa22+/6IYkFqvQYqkLj/unUB1RjTD
	D4v3p+Og9hgVt8YtKUDGOyJxhX9TAj9Dt0PoR+6lj0b4pNNTvmNsaWxFwaPVEb0jFtYMbs
	yfGhWAa8ytoquW6HvtOxv5lB4yBZ1lU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709828938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcYB3THyLEHAGqQD5ulPE5CsY6vdqyT5FGwSx8tObPQ=;
	b=OK+uAUHWj2F47iM2fqT6RBehlSwP2l3ejUIllxfehNfG9arsaydRyRtLMlhgyHZRjaEdMm
	JJI4p/ejf4XpQSDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709828938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcYB3THyLEHAGqQD5ulPE5CsY6vdqyT5FGwSx8tObPQ=;
	b=nocBvkjmC+2+qVgS3MNjA0sKHbC4JjTj4jfMJbFYOqa22+/6IYkFqvQYqkLj/unUB1RjTD
	D4v3p+Og9hgVt8YtKUDGOyJxhX9TAj9Dt0PoR+6lj0b4pNNTvmNsaWxFwaPVEb0jFtYMbs
	yfGhWAa8ytoquW6HvtOxv5lB4yBZ1lU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709828938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcYB3THyLEHAGqQD5ulPE5CsY6vdqyT5FGwSx8tObPQ=;
	b=OK+uAUHWj2F47iM2fqT6RBehlSwP2l3ejUIllxfehNfG9arsaydRyRtLMlhgyHZRjaEdMm
	JJI4p/ejf4XpQSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCCC3136C7;
	Thu,  7 Mar 2024 16:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mgz6L0nr6WULegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 07 Mar 2024 16:28:57 +0000
Date: Thu, 07 Mar 2024 17:28:57 +0100
Message-ID: <87le6uxaye.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ALSA: hda: hda_component: Add missing #include guards
In-Reply-To: <20240307111216.45053-1-rf@opensource.cirrus.com>
References: <20240307111216.45053-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nocBvkjm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OK+uAUHW
X-Spamd-Result: default: False [-0.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.03)[87.49%]
X-Spam-Level: 
X-Spam-Score: -0.34
X-Rspamd-Queue-Id: 0FFBD8CDF0
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 07 Mar 2024 12:12:15 +0100,
Richard Fitzgerald wrote:
> 
> Add the conventional include guards around the content of the
> hda_component.h header file. This prevents double-declaration of
> struct hda_component if the header gets included multiple times.
> 
> This isn't causing any problems with current code, so no need to
> backport to older kernels.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Applied both patches now.  Thanks.


Takashi


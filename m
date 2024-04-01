Return-Path: <linux-kernel+bounces-126631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA0893AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A7A1F21B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64A219E2;
	Mon,  1 Apr 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EaEYNc3Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0cNE4ceI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039FEEDC;
	Mon,  1 Apr 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711971711; cv=none; b=UeWzX5f9COvkRxf23AETtKzbbiPe2AHjhIs8QkCbdB6Zt4g7gjjYD6unpbbIxnB8yy+hSwTkFRkOfiU5GiN2vBT+XftyVeRb3dqqdv1Q4EP/3VmGjqwi6Gg00rorbg3XDdTXDN7GucmQnKZxJyXXWEk6G6wQO4QjHvmkd/ItDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711971711; c=relaxed/simple;
	bh=UYC+YR1VPLL0SL0EBTzo51XPgYlTO5o6c89ZeisMVC0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSWW5IjsTWIMlPYKVwkpjrAkaKnykqc37UiWphgd+l467VSt0mQcYk7qwQOaimE6OerSuQJK6MYf7HFQVQ1wTKa5SSRVYs4EEWpyy2KT2eoNgt8EcIi21HuzO8iMEDZhS3snqLyS9wJN6E4KjtZsjOrKJPtLUiD9oie/rYhCwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaEYNc3Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0cNE4ceI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6107333982;
	Mon,  1 Apr 2024 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711971701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30FgTz2okvHE1p2zMAwKysKeti14MJFUOG5cwd4mQgg=;
	b=EaEYNc3YIYrPzwE6gP1rN33NdgwBmWlO8frXhMmciYNPIYI9ZZ2YVX9LNN8zQ9+41SQXV2
	na2tzvJJg4QLPegsWBRBeGM1/HpLhMQ5W7X2kjoBI0iqFEZ3I52nW5Fd4Umi/RkcNP0ZLL
	HecrbPtfClD1gH4TyiI98ia87/DEiC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711971701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30FgTz2okvHE1p2zMAwKysKeti14MJFUOG5cwd4mQgg=;
	b=0cNE4ceIZzfxKBkcQpiihuJscMD9hCtiR0GnFx57879MPnXseVCW2/EzN5S2XUGD+gs3hw
	JQpXYPDGB8yuXfAQ==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 363C9139BE;
	Mon,  1 Apr 2024 11:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rQR7C3WdCmbdDgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Mon, 01 Apr 2024 11:41:41 +0000
Date: Mon, 01 Apr 2024 13:41:45 +0200
Message-ID: <87v851e2di.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592 decrease 30% of gaming performance
In-Reply-To: <CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
	<874jcl7e83.wl-tiwai@suse.de>
	<CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.70 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[28.02%];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: 0.70
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, 01 Apr 2024 13:07:26 +0200,
Mikhail Gavrilov wrote:
> 
> On Mon, Apr 1, 2024 at 12:07 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > Is it a regression against the performance on 6.8?
> >
> > If so, what happens when you revert both this (587d67fd929a) and
> > beb45974dd49?  That should make the timer code back to 6.8 code.
> >
> >
> > Takashi
> 
> The commit beb45974dd49 boosted performance to 30%, but commit
> 587d67fd929a canceled this boost.
> 
> I want to say that reverting commit beb45974dd49 returns performance
> to 83FPS [1] and this is sad.
> 
> So I ask again is it possible to find a better approach than 587d67fd929a?
> 
> [1] https://postimg.cc/xJMjkcHP

The only code of the commit 587d67fd929a is the close of ALSA timer
device.  If it really matters, it implies that the user-space seems
trying to open/close the ALSA timer device so frequently.

Are you using ALSA dmix/dsnoop?  It would explain.


Takashi


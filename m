Return-Path: <linux-kernel+bounces-71682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58285A8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4461F21FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DED3F8DA;
	Mon, 19 Feb 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rzYDlyl2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5sanQCU8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rzYDlyl2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5sanQCU8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42A3D54E;
	Mon, 19 Feb 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360087; cv=none; b=eQjKMZZUdFRMQ3wPcFuh7jW8nne6+Fjw5Ixk9m54gThAqqXEhM3KhkL0cBHIcOnAMhFgjLWW0Nrrx7FDjTlkQu+7KtyXHkEfufdBcdL0GL07XNT5n34z41WRr3qWY0oyNZrL3VcDSlSFSwJkCUm+2aCcfJX3y06Z7/4yzgXSzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360087; c=relaxed/simple;
	bh=wenKmRMWCQcXIEBiuJKWht34XyvUOfgSErz+melCPE8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+BtHDbvDA4oL1ulMgP3ZCjE/YExukHG/OABS6kEYTW84AAJQwkG/eNih5zU1/bf2DZ1eLJx/vob8zmq1ZrGd2FQDcHpVY1ol0v6KIPNVszIG0mPKhFNCaz4ymYw9Hz4Hn8wk1gGqA+f1IqnM/m/2eKTBgEKGpQW5Xff9KVIQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rzYDlyl2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5sanQCU8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rzYDlyl2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5sanQCU8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A77A1F806;
	Mon, 19 Feb 2024 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708360083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13HhidbPpoIts7Hq4/4TUjOdAZJMflmnTuIfI0fm7Qw=;
	b=rzYDlyl2OF28oP51oMd8AJmVnJIxcqqdLJCF8TTBp4gY6p2ZKWtaVS/QgYSblcjQiYYTaQ
	4btKOc5uT5toqCG4gDNutEJt+YtdcHRPnbR/TxcvHJn58ruVeulM+21Q/46B2G2Y944MCi
	rHB8+p4iDY6hkM86Wr5BB9j51nycMyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708360083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13HhidbPpoIts7Hq4/4TUjOdAZJMflmnTuIfI0fm7Qw=;
	b=5sanQCU8YvYZCdwwcCfedyarzaOWOI5NQPO1FkTG8fvtgZEWH+uJpi/jl6kWgZFg2KVxAE
	Px/UU7HncS10oVDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708360083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13HhidbPpoIts7Hq4/4TUjOdAZJMflmnTuIfI0fm7Qw=;
	b=rzYDlyl2OF28oP51oMd8AJmVnJIxcqqdLJCF8TTBp4gY6p2ZKWtaVS/QgYSblcjQiYYTaQ
	4btKOc5uT5toqCG4gDNutEJt+YtdcHRPnbR/TxcvHJn58ruVeulM+21Q/46B2G2Y944MCi
	rHB8+p4iDY6hkM86Wr5BB9j51nycMyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708360083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13HhidbPpoIts7Hq4/4TUjOdAZJMflmnTuIfI0fm7Qw=;
	b=5sanQCU8YvYZCdwwcCfedyarzaOWOI5NQPO1FkTG8fvtgZEWH+uJpi/jl6kWgZFg2KVxAE
	Px/UU7HncS10oVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14B26139D0;
	Mon, 19 Feb 2024 16:28:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l0GaA5OB02X4fwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 16:28:03 +0000
Date: Mon, 19 Feb 2024 17:28:02 +0100
Message-ID: <871q98o1v1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hans Peter <flurry123@gmx.ch>
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8) 
In-Reply-To: <20240219161240.3840-1-flurry123@gmx.ch>
References: <874je4q2h0.wl-tiwai@suse.de>
	<20240219161240.3840-1-flurry123@gmx.ch>
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
X-Spamd-Result: default: False [1.38 / 50.00];
	 ARC_NA(0.00)[];
	 SUBJECT_ENDS_SPACES(0.50)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.ch];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[alsa-info.sh:url,gmx.ch:email];
	 FREEMAIL_TO(0.00)[gmx.ch];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.91%]
X-Spam-Level: *
X-Spam-Score: 1.38
X-Spam-Flag: NO

On Mon, 19 Feb 2024 17:00:57 +0100,
Hans Peter wrote:
> 
> I apologize, this is my first patch ever.
> 
> On my HP EliteBook 840 G8 Notebook PC (ProdId 5S7R6EC#ABD, built 2022 for
> german market) the Mute LED ist always on. The mute button itself works as
> expected. alsa-info.sh shows a different subsystem-id 0x8ab9 for Realtek
> ALC285 Codec, thus the existing quirks for HP 840 G8 don't work.
> Therefore, add a new quirk for this type of EliteBook.
> 
> Signed-off-by: Hans Peter <flurry123@gmx.ch>

Thanks, now it's better, but could you rather resubmit without hanging
on an existing thread?  Keep the subject without reply prefix (at best
put "v2" in the patch prefix, e.g. [PATCH v2] ALSA: hda/realtek: ...


Takashi


Return-Path: <linux-kernel+bounces-71720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A789A85A973
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135EAB25843
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAFA4439A;
	Mon, 19 Feb 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FHxo0pQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0It+0grg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FHxo0pQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0It+0grg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95F40BFD;
	Mon, 19 Feb 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361912; cv=none; b=gV4804p9v8gwcyDYk+E92n9h+aD71mvDzefdZ9GcJ4Osq+MtG1hjWftB+ze8SI0b3PVVsHlBAopFoU0ZCLnrAV6MLbC8ve8fKLo+sttdjZhX/1ZXriMWqUKGjpBRDWSPGmBNOKlkGo5+9IzDRpEXegdHYr/vYJXazpl+wTrvT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361912; c=relaxed/simple;
	bh=F5pttH007rRprjbJopl130Nu9xt8t2EbXf1y11iVAi4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/zUdLPh8LjNrq6DVjqMiOVcWj4mu37Xi1pTsEXab8qfmw8aAtwGL5Uyx70DGdGKZ5fvOJeOLGI7OcPDE0URkL/eVLgAGudZ1n4ywc5rsrIEP0Ic8Xfwc+djETcRX2sFOEXJ9pMh+lbXVr9I+F510RKyTxUCcpsKL23wNqsaGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FHxo0pQz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0It+0grg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FHxo0pQz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0It+0grg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A92C1F801;
	Mon, 19 Feb 2024 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708361908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eo2vXtazXt6E0xtz/5zjooIf8WjKmbBwzcUBF6jdpNQ=;
	b=FHxo0pQzvBeaiaJWwKJIJGG9GMcGIR/C+pwhD3ZxC/+dZHe536v9zNtmdqfXPDLtw2F+eK
	h7KHufF+Aof12W6ZGqMdTOsemXc49f7QZdDu6hBCEmkHNmTpMsdbwAc3zhMRYuh+/N11+i
	2j8K/MwdQC1euE4XnJyRHMisgkg8LNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708361908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eo2vXtazXt6E0xtz/5zjooIf8WjKmbBwzcUBF6jdpNQ=;
	b=0It+0grglmtOJVfOw2Y+f+FFXlZGkxBVADDA6ITd+ik5YDy8q9OSV0npcl6Rmr1+b+WuRR
	xWDY3Uww4uZjLbBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708361908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eo2vXtazXt6E0xtz/5zjooIf8WjKmbBwzcUBF6jdpNQ=;
	b=FHxo0pQzvBeaiaJWwKJIJGG9GMcGIR/C+pwhD3ZxC/+dZHe536v9zNtmdqfXPDLtw2F+eK
	h7KHufF+Aof12W6ZGqMdTOsemXc49f7QZdDu6hBCEmkHNmTpMsdbwAc3zhMRYuh+/N11+i
	2j8K/MwdQC1euE4XnJyRHMisgkg8LNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708361908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eo2vXtazXt6E0xtz/5zjooIf8WjKmbBwzcUBF6jdpNQ=;
	b=0It+0grglmtOJVfOw2Y+f+FFXlZGkxBVADDA6ITd+ik5YDy8q9OSV0npcl6Rmr1+b+WuRR
	xWDY3Uww4uZjLbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F100139D0;
	Mon, 19 Feb 2024 16:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UNP3FbSI02WoCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 16:58:28 +0000
Date: Mon, 19 Feb 2024 17:58:28 +0100
Message-ID: <87ttm4mlvv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hans Peter <flurry123@gmx.ch>
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)
In-Reply-To: <20240219164518.4099-1-flurry123@gmx.ch>
References: <20240219164518.4099-1-flurry123@gmx.ch>
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
X-Spamd-Result: default: False [-1.13 / 50.00];
	 ARC_NA(0.00)[];
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
	 FREEMAIL_TO(0.00)[gmx.ch];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.03)[95.26%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.13

On Mon, 19 Feb 2024 17:38:49 +0100,
Hans Peter wrote:
> 
> On my EliteBook 840 G8 Notebook PC (ProdId 5S7R6EC#ABD; built 2022 for
> german market) the Mute LED is always on. The mute button itself works
> as expected. alsa-info.sh shows a different subsystem-id 0x8ab9 for
> Realtek ALC285 Codec, thus the existing quirks for HP 840 G8 don't work.
> Therefore, add a new quirk for this type of EliteBook.
> 
> Signed-off-by: Hans Peter <flurry123@gmx.ch>

Thanks, applied now.


Takashi


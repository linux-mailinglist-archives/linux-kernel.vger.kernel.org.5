Return-Path: <linux-kernel+bounces-13373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D382041E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA6E1F2187F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A993923CF;
	Sat, 30 Dec 2023 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bHFdo5/k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iypEELcL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bHFdo5/k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iypEELcL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C903C0F;
	Sat, 30 Dec 2023 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C11822116;
	Sat, 30 Dec 2023 09:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703927967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URKImpaQyJorzPDB6yG8qAmmJpe9snvzzVaY0SrX8rM=;
	b=bHFdo5/kTbXZRz3l2kbaFmeHTXzKzKXQZUyUpnO+NE51QN/czfzJ56YI3Xb96xU/qvxouW
	9ax9wVhtPelHSoUA/AP/YpsebV25s7QkovHMns7401p3rEytzm5lKR1SlCXD1xclnolyij
	AYSwpZaI1EH0+WwiiTlGtFJ7+UG5BHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703927967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URKImpaQyJorzPDB6yG8qAmmJpe9snvzzVaY0SrX8rM=;
	b=iypEELcLcsEGQ7PFSePp81LZY6j+hYPra2NjCO+BnKbUXXVTlunfjMS0WM5/v8IZ4fozmc
	5+hNhpBxQX2PBFCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703927967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URKImpaQyJorzPDB6yG8qAmmJpe9snvzzVaY0SrX8rM=;
	b=bHFdo5/kTbXZRz3l2kbaFmeHTXzKzKXQZUyUpnO+NE51QN/czfzJ56YI3Xb96xU/qvxouW
	9ax9wVhtPelHSoUA/AP/YpsebV25s7QkovHMns7401p3rEytzm5lKR1SlCXD1xclnolyij
	AYSwpZaI1EH0+WwiiTlGtFJ7+UG5BHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703927967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URKImpaQyJorzPDB6yG8qAmmJpe9snvzzVaY0SrX8rM=;
	b=iypEELcLcsEGQ7PFSePp81LZY6j+hYPra2NjCO+BnKbUXXVTlunfjMS0WM5/v8IZ4fozmc
	5+hNhpBxQX2PBFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3905E136D1;
	Sat, 30 Dec 2023 09:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pJnSC5/gj2VwNgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 30 Dec 2023 09:19:27 +0000
Date: Sat, 30 Dec 2023 10:19:26 +0100
Message-ID: <87v88gvyht.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dorian Cruveiller <doriancruveiller@gmail.com>
Cc: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Add driver properties for cs35l41 for Lenovo Legion Slim 7 Gen 8 serie
In-Reply-To: <20231229230703.73876-1-doriancruveiller@gmail.com>
References: <20231229230703.73876-1-doriancruveiller@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.38 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.52)[80.35%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.38
X-Spam-Flag: NO

On Sat, 30 Dec 2023 00:07:03 +0100,
Dorian Cruveiller wrote:
> 
> Add driver properties on 4 models of this laptop serie since they don't
> have _DSD in the ACPI table
> 
> Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>

This doesn't seem applicable any longer, as the cs35l41_hda_property.c
had some reworks.  Could you rebase on top of topic/cs35l41 (or
for-next) branch of sound.git tree and resubmit both patches?


thanks,

Takashi


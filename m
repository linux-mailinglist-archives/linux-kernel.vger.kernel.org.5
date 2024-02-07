Return-Path: <linux-kernel+bounces-56696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4631B84CDB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18E928D6F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D67F7C6;
	Wed,  7 Feb 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X7DSmwWw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OWw2wAUI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X7DSmwWw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OWw2wAUI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990577658;
	Wed,  7 Feb 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318617; cv=none; b=IBjE3fQ2gqW9WXnViyi7hrfbzkigcyBBE7uIvLz1nkjXIFw1gyxRAejqUBpMWJbhBHv8LGeK8e4EyGAP+x4FELoY3SBCZ2lwhbprN+3rpoK8LcbcUt22g/QmL1pX3QpwjYpbo9gnpnVlSGEB6KhqMDyXupxmYxZnJoMHbKG8nl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318617; c=relaxed/simple;
	bh=Jv1RJVQSa+s6LkiGweYVwWUnmBEVv5H8dA9b/E7cFxc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xuv5IzV/6/G+qo9/3xR69IrJblYX8tHYPTMd1H6xzLSmT6S6N0FDn9AlOMgejm17BCEds7H0Wj7ZThiaYLFYM30o+B32e0Iwo6QN/cYKyneI4BbslJym5j+8z5uduxMxRSRNng93lc5ILjhQeRGDgpRoRY0cucoYiNuVG2tEsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X7DSmwWw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OWw2wAUI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X7DSmwWw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OWw2wAUI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6188E1F78A;
	Wed,  7 Feb 2024 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707318613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDQEipVTzee4WgFsB2xE+sJDZ6njATigmiLm4iw2r7I=;
	b=X7DSmwWwfzJB57r5y+p/fUCE2Gxo/P8LsynUfmA2PkWKLKVsBDC5O50ecjjb+x7xRLnP/v
	zzf14eQSkPusj3o6Ieknx4UjJpLzWqkig3D4QTwmMjneWVahBX9JgMvmkohkonDy7FIWPj
	U+Dl8t6FxQ+Ul0/UvCJG52ceHhVS0sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707318613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDQEipVTzee4WgFsB2xE+sJDZ6njATigmiLm4iw2r7I=;
	b=OWw2wAUIJl6L4hWSfEepo5y4UZuXpgcHIRf8oLIcxr2hmZeCEMnxdleQaPWXIabF9ZVBtv
	bSoO9a1r3MT6gWCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707318613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDQEipVTzee4WgFsB2xE+sJDZ6njATigmiLm4iw2r7I=;
	b=X7DSmwWwfzJB57r5y+p/fUCE2Gxo/P8LsynUfmA2PkWKLKVsBDC5O50ecjjb+x7xRLnP/v
	zzf14eQSkPusj3o6Ieknx4UjJpLzWqkig3D4QTwmMjneWVahBX9JgMvmkohkonDy7FIWPj
	U+Dl8t6FxQ+Ul0/UvCJG52ceHhVS0sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707318613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDQEipVTzee4WgFsB2xE+sJDZ6njATigmiLm4iw2r7I=;
	b=OWw2wAUIJl6L4hWSfEepo5y4UZuXpgcHIRf8oLIcxr2hmZeCEMnxdleQaPWXIabF9ZVBtv
	bSoO9a1r3MT6gWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17F97139B9;
	Wed,  7 Feb 2024 15:10:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0JprBFWdw2UJOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Feb 2024 15:10:13 +0000
Date: Wed, 07 Feb 2024 16:10:12 +0100
Message-ID: <87jzng5mzv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Jean-Lo=EFc?= Charroud <lagiraudiere+linux@free.fr>
Cc: Takashi Iwai <tiwai@suse.de>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	patches <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD
In-Reply-To: <1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr>
	<87o7cs5r29.wl-tiwai@suse.de>
	<1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.86
X-Spamd-Result: default: False [0.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.34)[76.09%];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[linux];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[free.fr];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed, 07 Feb 2024 15:30:46 +0100,
Jean-Loïc Charroud wrote:
> 
> Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".

This change is only about the string in the table, not the actual
behavior, right?  The name string there is only for debug info, so
it's no big problem even if it's not 100% right.
That is, this can be again split to another patch -- with the
additional Fixes tag to the commit that introduced the entries.

> Add DSD values for "ASUS UM3402" to cs35l41_config_table[].

.. and this one is the mandatory fix for your device.  It should be
the patch 1.  Then we'll have two more, one for correcting the entry
names, and another for sorting the entries.

I'm a bit picky, but now you see how the things work.
Divide-and-conquer is the basic strategy.


Takashi


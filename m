Return-Path: <linux-kernel+bounces-90211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B6086FBFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844EC1F22C51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9A1AAD7;
	Mon,  4 Mar 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cuKySK/g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PhtnxHOY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cuKySK/g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PhtnxHOY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B129199A2;
	Mon,  4 Mar 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541339; cv=none; b=pTi9jVJrbS44BXiBl+go3kNzkcWs392B8jsXrtfPIwgLtDvreCdvvT/d9RzvcJFX/4BMpzO3fDHJknAhqSKQIsw1pdpS98i0HD9t9P1gtlKqkBl58RB6NOYnf3Tqa+zzxeWqaqaP83z5eq37mTcmb6wh+CeboPQwW+Apo3qk4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541339; c=relaxed/simple;
	bh=WKGGpWRMANQaqtEPi4SVdmap1qUQKAiiyE9H3DFCJF8=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=h65i/dNqlX3iId6PR5RHDfa1s0FBg6m/AJuZIawgjd7cUZaAyHV0RCs9By014saIcARp716XbLz+4OkmcsJSc2MGxltpDINjkFO3mSsUbYeb8s9ARdlh45bAY2rKNhcsjVhhjisKa8nWcRlqL96KmdAqp+ZlSmsZdSBIrHDQxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cuKySK/g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PhtnxHOY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cuKySK/g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PhtnxHOY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EC2768848;
	Mon,  4 Mar 2024 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709541336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5Ods5nKi3JLGo8dY/EevI/LJTv5iSGmPuUIXJnh5aFY=;
	b=cuKySK/gWSj3aRK5Akjm7J4dlysMBPpA6EKLtardyf/lc5ZodDMeelhHejt/rPUEQSdMam
	VlTUVqT10JUVTYPWYEPu6kCJZdQPtVRHey6zhFzXKTfLF6X3lBXJ1jyjFBY1xbY5EjB7xv
	3w7pvKRu6XNmgYE1SjGu/CTSlOqNp7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709541336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5Ods5nKi3JLGo8dY/EevI/LJTv5iSGmPuUIXJnh5aFY=;
	b=PhtnxHOYukPKzudsPxUY3YQPZJNaj5df0/OOXPic59SJ3yk9oQF0i95b75cBYYSxqtXZS5
	nWL8jnFUFY3H/xCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709541336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5Ods5nKi3JLGo8dY/EevI/LJTv5iSGmPuUIXJnh5aFY=;
	b=cuKySK/gWSj3aRK5Akjm7J4dlysMBPpA6EKLtardyf/lc5ZodDMeelhHejt/rPUEQSdMam
	VlTUVqT10JUVTYPWYEPu6kCJZdQPtVRHey6zhFzXKTfLF6X3lBXJ1jyjFBY1xbY5EjB7xv
	3w7pvKRu6XNmgYE1SjGu/CTSlOqNp7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709541336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5Ods5nKi3JLGo8dY/EevI/LJTv5iSGmPuUIXJnh5aFY=;
	b=PhtnxHOYukPKzudsPxUY3YQPZJNaj5df0/OOXPic59SJ3yk9oQF0i95b75cBYYSxqtXZS5
	nWL8jnFUFY3H/xCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1629813A5B;
	Mon,  4 Mar 2024 08:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d3qxA9iH5WX1bgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Mar 2024 08:35:36 +0000
Date: Mon, 04 Mar 2024 09:35:35 +0100
Message-ID: <87sf161jjc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
    linux-input@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    regressions@lists.linux.dev
Subject: [REGRESSION] Missing bcm5974 touchpad on Macbooks
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cuKySK/g";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PhtnxHOY
X-Spamd-Result: default: False [-1.94 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:url];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.63)[98.35%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4EC2768848
X-Spam-Level: 
X-Spam-Score: -1.94
X-Spam-Flag: NO

Hi,

we've received a few regression reports for openSUSE Leap about the
missing touchpad on Macbooks.  After debugging, this turned out to be
the backport of the commit 2b9c3eb32a699acdd4784d6b93743271b4970899
    Input: bcm5974 - check endpoint type before starting traffic

And, the same regression was confirmed on the upstream 6.8-rc6
kernel.

Reverting the commit above fixes the problem, the touchpad reappears.

The detailed hardware info is found at:
  https://bugzilla.suse.com/show_bug.cgi?id=1220030

Feel free to join the bugzilla above, or let me know if you need
something for debugging, then I'll delegate on the bugzilla.


thanks,

Takashi


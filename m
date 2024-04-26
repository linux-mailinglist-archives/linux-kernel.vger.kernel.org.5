Return-Path: <linux-kernel+bounces-160211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F58B3AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FD61F23D64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB0149C41;
	Fri, 26 Apr 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NjMIgi9L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Q6gv7Zn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NjMIgi9L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Q6gv7Zn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7603149007;
	Fri, 26 Apr 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144034; cv=none; b=NiteJTDYmY7b+iAMGjxo/PXeDwc553fsJZPEXPsq/sjz2c9Ezr2uLmfxs+c1BZajNg4m0cn6uI+VguzF/87oUcYvIBnXdUCwYJFqr1Bv0m+/65spBD17fiTrfBrWlxJOBq0iuDU1c1Lsdoh1iTEDaYUgSdZPo0lArp97GFRAsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144034; c=relaxed/simple;
	bh=P1j9CF8rNKFfzwB14P3a4NdCNMWR8w49UK9+jltcIf0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tu+Gd96vW6toi6DYkYKcqaMClTS7ZTwem4HyThyprYpRiUvO+X1FokMdFY/6d9SgBZaVW5GevTZ5blK/dQQ/cMZtYnAYARkvGJXcDZnFMvwbTSEeLOQvSWsjD/ejjZDqErtXn29Wx+DhI5HP4PzuueMMHfK2FQkzj9ea7pOtUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NjMIgi9L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Q6gv7Zn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NjMIgi9L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Q6gv7Zn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D817434F1C;
	Fri, 26 Apr 2024 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714144028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4oUvXBlx37Fg431v/r9M3PlkZEuJo6qfb7xxW5BqWk=;
	b=NjMIgi9L3j53ukDkFttWJ//Jqo43feiBLgVE7grPMGVnNgOu0katBBUgmrCe33f3dI3uZH
	eMm3Ur93Y7SPYuTD+ThrdDnOIWi2Dyjjh0FlCEELcDzPApe52W0O+bmbTi2A33YgfFJW8Z
	jET3jiHfaN9GsYr0ifA+8TJl29EEZpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714144028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4oUvXBlx37Fg431v/r9M3PlkZEuJo6qfb7xxW5BqWk=;
	b=1Q6gv7ZnFV2P2z0to2fE8fiieLiQpO//jC0kmZcanlgdXLJxucnzYyfykgCN9lDmEWP3c2
	1y5YlZL0L7cc3lBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714144028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4oUvXBlx37Fg431v/r9M3PlkZEuJo6qfb7xxW5BqWk=;
	b=NjMIgi9L3j53ukDkFttWJ//Jqo43feiBLgVE7grPMGVnNgOu0katBBUgmrCe33f3dI3uZH
	eMm3Ur93Y7SPYuTD+ThrdDnOIWi2Dyjjh0FlCEELcDzPApe52W0O+bmbTi2A33YgfFJW8Z
	jET3jiHfaN9GsYr0ifA+8TJl29EEZpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714144028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4oUvXBlx37Fg431v/r9M3PlkZEuJo6qfb7xxW5BqWk=;
	b=1Q6gv7ZnFV2P2z0to2fE8fiieLiQpO//jC0kmZcanlgdXLJxucnzYyfykgCN9lDmEWP3c2
	1y5YlZL0L7cc3lBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A4C91398B;
	Fri, 26 Apr 2024 15:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LsIsJBzDK2aMfAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Apr 2024 15:07:08 +0000
Date: Fri, 26 Apr 2024 17:07:19 +0200
Message-ID: <87jzkk2me0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: kunit: make read-only array buf_samples static const
In-Reply-To: <20240425160754.114716-1-colin.i.king@gmail.com>
References: <20240425160754.114716-1-colin.i.king@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.03 / 50.00];
	BAYES_HAM(-2.23)[96.34%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.03
X-Spam-Flag: NO

On Thu, 25 Apr 2024 18:07:54 +0200,
Colin Ian King wrote:
> 
> Don't populate the read-only array buf_samples on the stack at
> run time, instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, applied now.


Takashi


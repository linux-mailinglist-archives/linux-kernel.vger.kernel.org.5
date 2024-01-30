Return-Path: <linux-kernel+bounces-44677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3118425D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CD4291F79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ECA6BB45;
	Tue, 30 Jan 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AVAVOZ4K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y7vzA6YL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AVAVOZ4K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y7vzA6YL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE36773D;
	Tue, 30 Jan 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620226; cv=none; b=bEog77OyyxDeD79yo74ERY/owOocN031dT+hsjZG+OjMefrZ+dWdh0vXzWGyKLLGIoPI7taroPxxUNLvb21Lsm5rLqUACOKMiJhW4jJQMBOoLVofGeYW4MWGBcrm9n3g4Su7IEWXtsO9gDGOfBiDgp10YmQvrYJQzdheoQCLMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620226; c=relaxed/simple;
	bh=ltA7e8nGr0U9It4i6fpE4LYFpjN21uK9zaa7giqc9Ds=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBrjcxRmKZsfxPyWN8T7VxYcTnqYq6UlyS4QK1MfmuOlKBK0I7Ii9Ht1jbGQQA8gCJPldCgITPea/rKNXZqVRlcRVqsnkz8Hql8g6fkeEzFMtN5P+RpRzQ3VBVk32rC1JukUKMHBYRs7NfAw/kUqUTKucictmB0gMbNjxZsdBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AVAVOZ4K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y7vzA6YL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AVAVOZ4K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y7vzA6YL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACAF41F84A;
	Tue, 30 Jan 2024 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706620222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFI+Ahj/j5Y+mc+wVzrHxha1owur218M4+BslNp10oQ=;
	b=AVAVOZ4KbilBT8Gx/HshGA9Fh4CbKYPJM03CnR3xDa7I/YqTWHaXOPgh4Pt2OMa3m/TNq4
	A7NM+JzvSvYf8G6yZCXFQocJfkjVe0UdEzvQeL9H6z1rEP+RRnaqL24OX/1xwI4Bsq10Ve
	5PGj4/z7OaE+Qg27webpUPpLnb5a9dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706620222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFI+Ahj/j5Y+mc+wVzrHxha1owur218M4+BslNp10oQ=;
	b=Y7vzA6YL8uBDMsYRsJAAYsiKT/FwXUBAMq3yc6snAmv0iaFVStHND5GEgxD8wPsgS6H0Hn
	N4bx/W3rkOJ+KJCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706620222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFI+Ahj/j5Y+mc+wVzrHxha1owur218M4+BslNp10oQ=;
	b=AVAVOZ4KbilBT8Gx/HshGA9Fh4CbKYPJM03CnR3xDa7I/YqTWHaXOPgh4Pt2OMa3m/TNq4
	A7NM+JzvSvYf8G6yZCXFQocJfkjVe0UdEzvQeL9H6z1rEP+RRnaqL24OX/1xwI4Bsq10Ve
	5PGj4/z7OaE+Qg27webpUPpLnb5a9dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706620222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFI+Ahj/j5Y+mc+wVzrHxha1owur218M4+BslNp10oQ=;
	b=Y7vzA6YL8uBDMsYRsJAAYsiKT/FwXUBAMq3yc6snAmv0iaFVStHND5GEgxD8wPsgS6H0Hn
	N4bx/W3rkOJ+KJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C1CC12FF7;
	Tue, 30 Jan 2024 13:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nvXPED71uGW1WAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Jan 2024 13:10:22 +0000
Date: Tue, 30 Jan 2024 14:10:21 +0100
Message-ID: <87zfwn2chu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kenzo Gomez <kenzo.sgomez@gmail.com>
Cc: alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	tiwai@suse.com
Subject: Re: [PATCH v3] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
In-Reply-To: <20240127164621.26431-1-kenzo.sgomez@gmail.com>
References: <874jfdwsfg.wl-tiwai@suse.de>
	<20240127164621.26431-1-kenzo.sgomez@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AVAVOZ4K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y7vzA6YL
X-Spamd-Result: default: False [-2.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-2.97)[99.87%];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ACAF41F84A
X-Spam-Level: 
X-Spam-Score: -2.28
X-Spam-Flag: NO

On Sat, 27 Jan 2024 17:46:21 +0100,
Kenzo Gomez wrote:
> 
> Add new model entry into configuration table.
> 
> Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>

Applied now.  Thanks.


Takashi


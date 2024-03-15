Return-Path: <linux-kernel+bounces-104604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7B787D0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D17285168
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED03FE47;
	Fri, 15 Mar 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jj73kno8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7nvDSjZd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jj73kno8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7nvDSjZd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CA3F9FB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518160; cv=none; b=RlznEpIqJ2wYgXM4uy7pEYG1c2rt6NvYlba5bL0j7t7pOi+B/rSdnugywMYbNkCgLAhULogrJTBjVQdgDeUkMhGc1wzlHzEq6jhZYB/yTUPhfAzJ3n6XDBInoYDF7/z2UFUcMggkhVr+QPu49N/RhsQORROwNQXWIyW7ccTod0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518160; c=relaxed/simple;
	bh=GHHO+JTnGwew5iimMYtxO7BabmfI0tl2curFYovX7tU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Pp2wylGBjRTiagXK2KkawkcPdi7ZqdSU7lZpuhQDNzbLFjdZQ55s/pef4BSytqqwUlxeo+jibW6tHzlqOzG3imcDIdLiog6C4Nd5ztlx644oL6RsvtMIpjjFpTgcYOmvYFB01Nm1kMS8frJqSnZo5rvAgEUAKePNDaol/Y3hdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jj73kno8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7nvDSjZd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jj73kno8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7nvDSjZd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA84121D9E;
	Fri, 15 Mar 2024 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710518156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bM+b6iegJFO/bpBCATNpW+MQwYK8lYHmpjx0agJrk=;
	b=Jj73kno8v7WCigxelmsCr8o9TfBouysmaf0N7kKrmCVRtbtEi216oGyfYMgrkwSSb6kNnb
	DbCRl/9TcZENrTwqkwW0B8l3B/fWbGGaIi/VyBDsu50/1rX8Sllub0MI+yjCIIBOFVlD5N
	u9/TjbMrUd2pQRcamo9CeKYqQrG1ltE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710518156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bM+b6iegJFO/bpBCATNpW+MQwYK8lYHmpjx0agJrk=;
	b=7nvDSjZdR1nCsZf8dLkVX+WerLhqhNbj4q2UPpN9WjHAFL6R5CmCVTU5hfdHOP1dAjVsln
	rO33AnvcbPKQxSAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710518156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bM+b6iegJFO/bpBCATNpW+MQwYK8lYHmpjx0agJrk=;
	b=Jj73kno8v7WCigxelmsCr8o9TfBouysmaf0N7kKrmCVRtbtEi216oGyfYMgrkwSSb6kNnb
	DbCRl/9TcZENrTwqkwW0B8l3B/fWbGGaIi/VyBDsu50/1rX8Sllub0MI+yjCIIBOFVlD5N
	u9/TjbMrUd2pQRcamo9CeKYqQrG1ltE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710518156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bM+b6iegJFO/bpBCATNpW+MQwYK8lYHmpjx0agJrk=;
	b=7nvDSjZdR1nCsZf8dLkVX+WerLhqhNbj4q2UPpN9WjHAFL6R5CmCVTU5hfdHOP1dAjVsln
	rO33AnvcbPKQxSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1A6713460;
	Fri, 15 Mar 2024 15:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8EJgJ4xv9GUfXAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 15 Mar 2024 15:55:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 Mar 2024 16:55:56 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Marco Elver
 <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Alexander
 Potapenko <glider@google.com>
Subject: Re: [PATCH] mm,page_owner: Fix refcount imbalance
In-Reply-To: <7ea61161-4eee-47b2-9540-00805d906f50@suse.cz>
References: <20240314144753.16276-1-osalvador@suse.de>
 <7ea61161-4eee-47b2-9540-00805d906f50@suse.cz>
User-Agent: Roundcube Webmail
Message-ID: <c3e8dfbceedbfa95a2eeeeef6921d447@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.25
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.75)[84.03%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Jj73kno8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7nvDSjZd
X-Rspamd-Queue-Id: AA84121D9E

On 2024-03-15 14:21, Vlastimil Babka wrote:
> The stackdepot guys probably won't be thrilled about this addition to
> stack_record. Can't we instead make the refcount itself reflect the 
> number
> of base pages?

Yes, we can. I already have a patch doing that, much simpler and much 
shorter.

I will send it out later today.

Thanks!

-- 
Oscar Salvador
SUSE Labs


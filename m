Return-Path: <linux-kernel+bounces-66752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD885611E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE131F21562
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C18527F;
	Thu, 15 Feb 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EizX3RwD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7GOg0row";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bjZK3MKX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EFjIAJ+b"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C424B26
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995631; cv=none; b=rqidVyTumZcFXxPZYvnLD6AomE7JdXlHHAqJYBsgcohndbxRk2aralHRPs89qgxPjgqn/B411fzRthOUawanJjEGqUL3Y7XFFtoSvwcTP4aRZJ7vnDPjp0+KWtmrWaERC7245rXUoKahmUboIDAwX/qBSiiquy2kjV3g/5ljupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995631; c=relaxed/simple;
	bh=aK0mtDtWdYmxVDs2SjArJeFombOARl1UafOeIonIfn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7AIzqH2cWXW/+sfn5nsWZF/ulMBHPr7wYzXjxBGSzybWEmtB6L79YsKBYFnyrY1AcTd5Mm56Rh7se5iB6S33Hu4K8yNYb9J6HtJoz6vbKSa2s+9i0+mCpzQ6OM/mRl4HiNZs3wuq5ojguXmQGPKWsfO4y8oVQGxbl3aF+vhMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EizX3RwD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7GOg0row; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bjZK3MKX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EFjIAJ+b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD5FD1F88D;
	Thu, 15 Feb 2024 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707995628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMLLxU7h6N8I5HtlY+5DpPm+x2pQT0Lo0Bw84nNr6rA=;
	b=EizX3RwDCop3PnaVCfMZ/NbzTyEhv+8b7qZKpZ1K0hQEFPPpWbnWrF6PrrxjRaqrx4IObN
	kpO4LMsnlonHJPzIjT+1qaOFWFYT9ALwYbKKuLXb/qSJfjfHn7g0B49yAh/YiQ5ZaDxNbC
	wZky46y9o12+L3ld991ctORFx8obniQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707995628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMLLxU7h6N8I5HtlY+5DpPm+x2pQT0Lo0Bw84nNr6rA=;
	b=7GOg0rowhONj/MKN8N8LzQYteKHSfAg+55AeFD2wCbSxLgkQROqMZPKJyC6/lMWmKhDwzN
	abAGg5/rtR1utUDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707995627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMLLxU7h6N8I5HtlY+5DpPm+x2pQT0Lo0Bw84nNr6rA=;
	b=bjZK3MKX1HtyBSWZH5KoPDu6+HWb5ci4vghwcldssIp9lgiriyFT5RzcLmxJrGaBk3gQvI
	QfLmUd4APHCmpf6MU+mj4uK+HvX8oOl7tllW3da71QWwUDCF3tZEYbvorYO4Uq3jyLQgz/
	QuPJuS716YK2JJWMAiXRSlMsWai2uVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707995627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMLLxU7h6N8I5HtlY+5DpPm+x2pQT0Lo0Bw84nNr6rA=;
	b=EFjIAJ+b7V7qkqOiDPZhWA1FfnUIuzg2Xc1gTW5+1S5sC4F7AY7X2ebgFJKlTSd1Sp2af6
	IXi9v2K31YuyIxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7C9D13A53;
	Thu, 15 Feb 2024 11:13:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PryKuvxzWWJNQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 11:13:47 +0000
Message-ID: <b730fdd3-7c7b-4790-95e6-63f0792c7f50@suse.cz>
Date: Thu, 15 Feb 2024 12:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/7] mm,page_owner: Update Documentation regarding
 page_owner_stacks
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-8-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214170157.17530-8-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bjZK3MKX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EFjIAJ+b
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.73 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 BAYES_HAM(-2.23)[96.35%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.73
X-Rspamd-Queue-Id: DD5FD1F88D
X-Spam-Flag: NO

On 2/14/24 18:01, Oscar Salvador wrote:
> Update page_owner documentation including the new page_owner_stacks
> feature to show how it can be used.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!


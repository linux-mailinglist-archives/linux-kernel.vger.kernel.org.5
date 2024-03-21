Return-Path: <linux-kernel+bounces-109950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D7288581D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3E71F21879
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA858AB9;
	Thu, 21 Mar 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvr6beSX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjqIxvkz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvr6beSX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjqIxvkz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC941A91
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020029; cv=none; b=Zd5j1sD3EE8NQId0VWp5ndBXqT05ZEidjS/x1OxEyN6l+l8HuhkhxkAA/cV2uK9wMLYdfMiJFaCVu0gG92C2iaQ6RxWr3/BWZ3SMINq8WnuHkoQaPxB5T9r83vgi0ns5P1X8BPw1a71PlN6qgsC6nzuPxzeYuoHvjnxJIRUeX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020029; c=relaxed/simple;
	bh=H9tuj4jwtc/2a8GXDOkN4uIrpvFsckEHOg3RrZxQEq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=is+bqRnsTTOljEQ6jtr6FOgn8GJD2QyrLqBiN6Wmu2pw3hJuEF2zAh/3Df1HICo2bUFszIixQ3Wdu+OyLVuFB7Amyiuxn8CnSPutleVOSvm11H05aJKd5FMhQGaVQG+rm0rhYC128rt9L7U6mzaktJdiAmzNgVTmtmpR03iul2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvr6beSX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjqIxvkz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvr6beSX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjqIxvkz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8412B372A0;
	Thu, 21 Mar 2024 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711020024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVnW9rBBDhVBd0pbBPwkNhr3UB074n24M3Ue4qKQFKU=;
	b=zvr6beSXOkPF756BBoOsjkZQmvXZbTr5cmGzVdFZnzyMyNcka05BFe93cOdCK+Azjpjs4P
	OHSe8yaPB6Ebrl714zUuUJ3iqYFoX1rWVHZiyZMFXn1eX5FV65VW44HjMPMuYQdIkckbqu
	sir22oqI+Ga+xTkFomfYCiwYa7JO1xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711020024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVnW9rBBDhVBd0pbBPwkNhr3UB074n24M3Ue4qKQFKU=;
	b=fjqIxvkzBByZaF2rk+TDrU/mBkCmq+5UUQJLZOFhHLKC5ynYuPfCIrKwQ5B9TPxnU2cnch
	jhGXhxeyWoCt9bCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711020024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVnW9rBBDhVBd0pbBPwkNhr3UB074n24M3Ue4qKQFKU=;
	b=zvr6beSXOkPF756BBoOsjkZQmvXZbTr5cmGzVdFZnzyMyNcka05BFe93cOdCK+Azjpjs4P
	OHSe8yaPB6Ebrl714zUuUJ3iqYFoX1rWVHZiyZMFXn1eX5FV65VW44HjMPMuYQdIkckbqu
	sir22oqI+Ga+xTkFomfYCiwYa7JO1xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711020024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVnW9rBBDhVBd0pbBPwkNhr3UB074n24M3Ue4qKQFKU=;
	b=fjqIxvkzBByZaF2rk+TDrU/mBkCmq+5UUQJLZOFhHLKC5ynYuPfCIrKwQ5B9TPxnU2cnch
	jhGXhxeyWoCt9bCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B811136AD;
	Thu, 21 Mar 2024 11:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xGzWGfgX/GW7LwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 21 Mar 2024 11:20:24 +0000
Message-ID: <e291e52a-ae98-42ac-88c3-7463f952d490@suse.cz>
Date: Thu, 21 Mar 2024 12:20:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm,page_owner: Fix accounting of pages when
 migrating
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-3-osalvador@suse.de>
 <Zfnd_w0ZLOVhgACt@casper.infradead.org>
 <ZfptWDsfdxBltN6T@localhost.localdomain>
 <ed41d5cf-d068-412d-b7bb-5468df2fefb7@suse.cz>
 <ZfwU1mGQKejNaKIk@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZfwU1mGQKejNaKIk@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[infradead.org,linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com,i-love.sakura.ne.jp];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On 3/21/24 12:07, Oscar Salvador wrote:
> On Thu, Mar 21, 2024 at 11:50:36AM +0100, Vlastimil Babka wrote:
>> Yeah I think we could keep that logic.
> 
> I am all for keeping it.
> 
>> But we could also simply subtract the refcount of the old handle (the
>> "allocated for migration") in __folio_copy_owner() no? Then we wouldn't need
>> the extra migrate_handle.
> 
> Since new_page will have the old handle pointing to the old stack after
> the call, we
> could uncharge the old_page to the migrate_stack, which new_page->_handle holds
> before it gets changed.
> 
> So we basically swap it.
> 
> It could work, but I kinda have a bittersweet feeling here.
> I am trying to work towards to reduce the number of lookups in the
> hlist, but for the approach described above I would need to lookup
> the stack for new_page->handle in order to substract the page.

Understood, but migration is kinda heavy and non-fast-path operation already
so the extra lookup wouldn't be in a critical fast path.

> OTHO, I understand that adding migrate_handle kinda wasted memory.
> 16MB for 16GB of memory.
> 
>> Also we might have more issues here. Most page owner code takes care to set
>> everything for all pages within a folio, but __folio_copy_owner() and
>> __set_page_owner_migrate_reason() don't.
> 
> I did not check deeply but do not we split the folio upon migration
> in case it is large?
> Which means we should reach split_page_owner() before the copy takes
> place. Do I get it right?

When I mean is we have __set_page_owner_handle() setting up everything for
tail pages and then we have __folio_copy_owner updating only the head page,
so this will create kinda a mixed up information. Which might not be an
issue as __folio_copy_owner() should mean it's a proper folio thus compound
page thus nobody ever will check those mismatched tail pages... Maybe we
could adjust  __set_page_owner_handle() to skip tail pages for compound
pages as well and unify this, and tail pages would be only setup for those
weird high-order non-compound pages so that the odd case in __free_pages()
works?

Or maybe page_owner is considered debugging functionality enough so it might
be worth having the redundant data in tail pages in case something goes
wrong. But either way now it seems we're not doing it consistently.


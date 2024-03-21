Return-Path: <linux-kernel+bounces-109907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917CE8857A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A603B21786
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A157304;
	Thu, 21 Mar 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGV647uj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O0um/ZCs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bf3yVEuQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UafGAvGq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236B5644E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018240; cv=none; b=VBUx6z/jRcS7iY2NRUL7Fb+/BMST8ripmkvBmeZspPqXfy7SVI/lT8wcaPFhrf3YE2RO3AaeJst7ZL/6pTuuWc7QthtDM5jsWq9T8fTJfTkPW+ATH1nDglIFF5Usrdx95rXV3RuVE65z6Vqk6nKTjd0SEFcQzA/OaHrLXBXeKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018240; c=relaxed/simple;
	bh=HX68hSzTAcjMDkDZGRIL39hdwSHNbaZPZnmVZn4Yons=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/1xneUzQIZzRdHdQnc6xkeJY2tpwpaMuQjVxatQcD6xtNIjsCC0q103MVKMNqXFoZVYsHWI4cqP5I7m9Lko/nw2DsNT7Czhp1qySR/U5LgFWmYtFuGNzgMDF/JjXu0DJnRhfh9jBZsZmfWITSp71+Cqcg+8cjEtUrn8df+hrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGV647uj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O0um/ZCs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bf3yVEuQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UafGAvGq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5EFB5CC90;
	Thu, 21 Mar 2024 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711018237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MkA3INDRNrQmyii/A1Er4UKsQqNsow2c9O8EOAoimo=;
	b=TGV647ujMQMD9P/44azK1++hnYVprPTitT1iBwUxc3WKMcwcwAH+qmJZMY0PXCALBlbuRV
	xQk91wyrYLPY/JAWPV3hRUuOqg60Gp8/0nyy3Yq3FywIKc1OixnP2sIhwYPZw1uL0+mVYR
	sAgbJhwBRDOPJAgUkDgXqkSX9pGqIQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711018237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MkA3INDRNrQmyii/A1Er4UKsQqNsow2c9O8EOAoimo=;
	b=O0um/ZCsYEDTkSq6O/1z+N6jBNMwWroTr0EEDcPFJhvwkuFbvVeLLrsDQEG87XUWG3bA0A
	OkCyyjsCGI6Q8yCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711018236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MkA3INDRNrQmyii/A1Er4UKsQqNsow2c9O8EOAoimo=;
	b=bf3yVEuQ0R7YJNEJO87pQGedAOLqemHiYI6CdtPgLob77SIfhK+/CZjpilvGPlZUq3n5sr
	rEZe7zEHzqYrgOW+TG++qOTOrXXMRAEmStMUJsRhOLIIznlFhagO71gakZ5lo9jNqXrtyN
	3e2/UII5UXz4pxRqVbiHKJFQxy9ilH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711018236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MkA3INDRNrQmyii/A1Er4UKsQqNsow2c9O8EOAoimo=;
	b=UafGAvGqBrejNTrrT3Lsf9XntQh5zFs41qz06HNSy77C9TRt6So1WyXOQuow0DUEhTRiBP
	3NnxdpRghbLSCSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD366136AD;
	Thu, 21 Mar 2024 10:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T2PAMfwQ/GUVJgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 21 Mar 2024 10:50:36 +0000
Message-ID: <ed41d5cf-d068-412d-b7bb-5468df2fefb7@suse.cz>
Date: Thu, 21 Mar 2024 11:50:36 +0100
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
To: Oscar Salvador <osalvador@suse.de>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-3-osalvador@suse.de>
 <Zfnd_w0ZLOVhgACt@casper.infradead.org>
 <ZfptWDsfdxBltN6T@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZfptWDsfdxBltN6T@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[30.81%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com,i-love.sakura.ne.jp];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On 3/20/24 06:00, Oscar Salvador wrote:
> On Tue, Mar 19, 2024 at 06:48:31PM +0000, Matthew Wilcox wrote:
>> Is this the right way to fix this problem?  I would have thought we'd
>> be better off accounting this as migration freeing the old page and
>> allocating the new page.  If I understand correctly, this is the code
>> which says "This page was last allocated by X and freed by Y", and I
>> would think that being last freed (or allocated) by the migration code
>> would be a very nice hint about where a problem might stem from.
> 
> I hear you, and I had the same thought when I stumbled upon this.
> I did not know that the handle was being changed, otherwise it would
> have saved me quite a lot of debugging time.
> 
> Checking the history of this, I can see this decision was made in
> 2016 in:
> 
>  commit d435edca928805074dae005ab9a42d9fa60fc702
>  Author: Vlastimil Babka <vbabka@suse.cz>
>  Date:   Tue Mar 15 14:56:15 2016 -0700
>  
>      mm, page_owner: copy page owner info during migration
> 

Yeah I think we could keep that logic.

But we could also simply subtract the refcount of the old handle (the
"allocated for migration") in __folio_copy_owner() no? Then we wouldn't need
the extra migrate_handle.

Also we might have more issues here. Most page owner code takes care to set
everything for all pages within a folio, but __folio_copy_owner() and
__set_page_owner_migrate_reason() don't.



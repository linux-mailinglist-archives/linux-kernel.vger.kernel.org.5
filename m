Return-Path: <linux-kernel+bounces-127955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36889538D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6551F23094
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0746F7D07A;
	Tue,  2 Apr 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JBEaGuaQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pFjoKW9y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798A786273
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061578; cv=none; b=q/fEoGKtHUg+aI/41xI7oNmi2vZvsf13QJfHw1Avd0TLhKp4/71nnAOXzeM7n33yURbi65no2r/wqVk+2TOI4fV9b/suQmyYdw3FHuM7n3imvB21qIyrgHIep/GTuIuibntwl2mobK19qYrwXiP11FFoML5hdBkfvrjBtvi7Ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061578; c=relaxed/simple;
	bh=8a45iYd+/AMeVZRQwnXzykG92NiWnx83jk3ndfNXPXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbAvy9fNE0Lzpk3tMma28uAyqn9fVqJn8cAjauiIAjgd3sd867Rp2KOlwG0kw5/kiZLfejlbfpry/3YmX1o3Pa4XlDmB6zgvbWpSBXoKZAWt75jBx+DPnF+EWsooOZGMZQ1jjQIh271lGOSKDXSvUMkZFUxJU9fATcMQCeoh3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JBEaGuaQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pFjoKW9y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 591A234695;
	Tue,  2 Apr 2024 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712061569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17nfIwhr2J6EqJPvt6WiOi3WK73dMRHs/vc3cZf3PnY=;
	b=JBEaGuaQJDg98/s5Ofujt2YLWFKHBeEjhU4gnarvkgBGXHkun/w9dKLPqU3IE7ZoreaH+q
	s1XKO6giyDAzYliyDBcye6n6ZXktQ872qJ7Vkd8xRxe1HZOk/85u/Hjbk17HRlEzj7XxNl
	tJiPxlyfcfSLoieVddQ77Pgg+COs0oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712061569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17nfIwhr2J6EqJPvt6WiOi3WK73dMRHs/vc3cZf3PnY=;
	b=pFjoKW9yKpaMZ3bQM74sAyJb3mDXSpHOEEViumXPBNL/WwpUFWgvGHpGVNWs8YyAtOYbwo
	vxDkpKGvIJKBRAAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 479AB13357;
	Tue,  2 Apr 2024 12:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ct8oEYH8C2arQwAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 12:39:29 +0000
Message-ID: <819252eb-0ad5-4464-87d5-bbf13661c379@suse.cz>
Date: Tue, 2 Apr 2024 14:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm,page_owner: Fix accounting of pages when
 migrating
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240326063036.6242-1-osalvador@suse.de>
 <20240326063036.6242-4-osalvador@suse.de>
 <50f31489-b5c3-480e-a7db-20edbbb2c9c2@suse.cz>
 <ZgvqWoZsYJLenSE_@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZgvqWoZsYJLenSE_@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.33 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.03)[56.73%];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Level: 
X-Spam-Score: -0.33
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 591A234695

On 4/2/24 1:22 PM, Oscar Salvador wrote:
> On Tue, Apr 02, 2024 at 12:26:51PM +0200, Vlastimil Babka wrote:
>> Can the migration still fail after __folio_copy_owner()? That goes again to
>> the comment you changed in patch 1/3. If it can, this will kinda create a
>> mess with the old folio's handles not reflecting reality? (although
>> refcounts will be ok)
> 
> According to my research (I replied in patch#1), no, migration cannot
> fail after __folio_copy_owner(), so we are safe here (Tm).

OK then,

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>



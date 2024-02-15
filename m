Return-Path: <linux-kernel+bounces-67332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5F8856A00
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94E81F21081
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927E136644;
	Thu, 15 Feb 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8AaE/PO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRxyCuYe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HDp2IEKY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pC0Ba+7t"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51E12EBDB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015948; cv=none; b=bCG0UId++EoA4az2iWTku2NQGFf+vYJWC2Ha7gGZt2jbbCuoU7QAy2YucsitVnNwipqYg6GrXzD5s6mHHqEOCs6iYZQDy0X4qJnrFSBzJIKSJu//6KVLTWpeMT38wGz0/UR1Kuy5F3mezJO3ziTzaG3jP6VA1IdYDRK9f+oAcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015948; c=relaxed/simple;
	bh=h9jfbXo112+uwPXFYGv/HtqdQCy5lFyT4ZOk3OCdz4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBdlfdi21ETzFXMJcziK0nxWjH6xoa6gNcXLnbMnK+FKQ7+OTH/VcH0e2yumH8bocwzTtTuhpKzyo3+6uv8+BtZ+TqzU6quaVO6nfGoUZNulHnjPK8T9Wgd+yomS7KQNAuP8rSwnYXIbxrG+sqiELNx0LXttFn/JjgbQyO1chNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8AaE/PO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XRxyCuYe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HDp2IEKY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pC0Ba+7t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E56E01F8C8;
	Thu, 15 Feb 2024 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708015945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciAK3UmOQFXUXmlelpdBbf3qEyQO9Ipdb1FXEM6L3d0=;
	b=x8AaE/PORJVyrTlOprVAqTjjDJiUubSBa5tOUR7SCM2njmQ+EcGzu2xYOhN1uRli6Gejci
	wWvBEW43DYD+aAowQ8SbdGwfmT1oD1a3jZn4Ol9+C/eufQFZKFqZxRn+SLXpzVGl6OHoD+
	AO7GjdeXm/Tq0FMS63iNbVqlCQjrRfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708015945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciAK3UmOQFXUXmlelpdBbf3qEyQO9Ipdb1FXEM6L3d0=;
	b=XRxyCuYeRVThXkyrn6tVlQlY7IxhEivS38D9UH2LOxUNbAuP/oIL5zTq53Bg/uzAf/9m4q
	A5TbgkjQ3Pd/a1Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708015944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciAK3UmOQFXUXmlelpdBbf3qEyQO9Ipdb1FXEM6L3d0=;
	b=HDp2IEKYp5ziILDa1S7p964GU4PqGkWSCrinwGRifRNcEyhgZf+nWdKs453iqH1Z/Z7VxF
	HvV32Wj4l1+JRpX0tLmW53sZIWWAKLAvOnP8Y6bW/q27tR1G6xwM2LTT3Pg9HHsfoWNmcw
	K5yhUohvHnSf7Q4qSypmBuu7oOQlyyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708015944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciAK3UmOQFXUXmlelpdBbf3qEyQO9Ipdb1FXEM6L3d0=;
	b=pC0Ba+7tkq7tljGcQXKb8aDqY3Vwi653EDo9pHaR2IYvFWGqHuIMDGIoTqIrFVBFlQFn3n
	Xqtw40TxOeEfQODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B245C13A53;
	Thu, 15 Feb 2024 16:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HsooK0hBzmW3CwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 16:52:24 +0000
Message-ID: <f7aa107d-600f-4ef0-a93d-970b3bb56c39@suse.cz>
Date: Thu, 15 Feb 2024 17:52:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] mm/compaction: optimize >0 order folio compaction
 with free page split.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rohan Puri
 <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240214220420.1229173-1-zi.yan@sent.com>
 <20240214220420.1229173-4-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214220420.1229173-4-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HDp2IEKY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pC0Ba+7t
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfsxmn1qwoupcjwdqfx65548p)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.01)[45.74%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: E56E01F8C8
X-Spam-Flag: NO

On 2/14/24 23:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> During migration in a memory compaction, free pages are placed in an array
> of page lists based on their order.  But the desired free page order
> (i.e., the order of a source page) might not be always present, thus
> leading to migration failures and premature compaction termination.  Split
> a high order free pages when source migration page has a lower order to
> increase migration successful rate.
> 
> Note: merging free pages when a migration fails and a lower order free
> page is returned via compaction_free() is possible, but there is too much
> work.  Since the free pages are not buddy pages, it is hard to identify
> these free pages using existing PFN-based page merging algorithm.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Yu Zhao <yuzhao@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!



Return-Path: <linux-kernel+bounces-119358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50FE88C7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E596B28B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EE13CC65;
	Tue, 26 Mar 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTZEPcMe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QEwjy77f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpAqAX4M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UyeLBPli"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150913D606
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467628; cv=none; b=jDiE4qFkQ9rjsodtYgDPWqlUM1vfyavITyh01jTXp79l3GRCn0U/86hna/d58Yls5VA0vwzBS83bSuQDjE7cYcQG9SGZxoX/E/F+Y46Borxs8OCl8vH27n9HaICG394VyAoyrl1l4ZHFA/cIdEj8+jTJ+sNwsIzZuk/Bl+/zk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467628; c=relaxed/simple;
	bh=YLHWn5BJOrKJ+2xir7dWReqRTfipeHVsQyX2Cy7Sxgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=he14DC/WakX6t/YG6C6K8CtodXOMwcX8+CZ5qFEvlISL05pppMWISsVyXzlOUZxmUS9TuZN+WwE9TxupITZqrhBV1n1Bu/GxrIVXZRYjJU6XwroOoI8U6PI0LGitxHtmx1U85e8nID2Thlg0QbdJfGRWCakq2uz4w3VbCH5W5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTZEPcMe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QEwjy77f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpAqAX4M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UyeLBPli; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0D1A37567;
	Tue, 26 Mar 2024 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711467625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3LMrPw3hFL/KxR4GxnsJbdTzCydmab5ztQVxw3j4/k=;
	b=QTZEPcMedNYTiTlIL9cj4EcjvL6MPr6YJNgPj9/W1fgmmEPssWwUBe8t/Spsb8uza2rZHR
	wJ90jbI7Y3OzERn6lloKdOTbPoi8fii9ankxwSy63e/OTK/xHi4y0wLTPLm3fYrTxhasj/
	Y4RGtqmyv5vdg3qghQ0+m+fwEndd0oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711467625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3LMrPw3hFL/KxR4GxnsJbdTzCydmab5ztQVxw3j4/k=;
	b=QEwjy77fRbTGI159P4h4K7fi9A4ZdzRHgxMk3rgMwN2rPggtS9BIfEJFflqOmhDkPgwy2u
	MZ44a2bEJB3ThiBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711467624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3LMrPw3hFL/KxR4GxnsJbdTzCydmab5ztQVxw3j4/k=;
	b=LpAqAX4MKqTcZYFKdIMQLjk3/pTrlMc2dNpbYamp1mwAyUBhscrIvaZ4WAF1GUfvm+OTdV
	qf+MwZjX5Q+AA4KmMC6IVp8aVP8ZPMG8lo7p2lX0GqY96rdtZxcCaCCoaDSveFnKdxCRCJ
	+q+FUbpURBsT71KhMBuWQkQd3COxlUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711467624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3LMrPw3hFL/KxR4GxnsJbdTzCydmab5ztQVxw3j4/k=;
	b=UyeLBPlisU5UrUU1ROGntR8vTq4+hpGXd3mGsT8pVNQkGoJnR9b7IA6iPgyor6e7M5POwM
	f6NFndWD8SaYQjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD5AF13306;
	Tue, 26 Mar 2024 15:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9NzfLWjsAmYjUQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Mar 2024 15:40:24 +0000
Message-ID: <59998760-491d-408b-a452-852d3250b5db@suse.cz>
Date: Tue, 26 Mar 2024 16:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] mm: page_alloc: set migratetype inside
 move_freepages()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-9-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-9-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LpAqAX4M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UyeLBPli
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.64 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.14)[95.85%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.64
X-Rspamd-Queue-Id: D0D1A37567
X-Spam-Flag: NO

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> This avoids changing migratetype after move_freepages() or
> move_freepages_block(), which is error prone. It also prepares for
> upcoming changes to fix move_freepages() not moving free pages
> partially in the range.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

BTW noticed in -mm this has R-b: Zi Yan which is odd as he's the author. In
the subthread for patch 9/10 Zi posted a R-b for patch 9/10 and its fixup,
not this one :)



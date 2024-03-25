Return-Path: <linux-kernel+bounces-117421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4888AB33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6611F3EA67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC960153509;
	Mon, 25 Mar 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ta4Jy1+l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u3yXqXNA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ta4Jy1+l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u3yXqXNA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479D15250B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382222; cv=none; b=AJD3kiMAOB34KA1rl8Xf9BMt/S35X1Vq3gMQUuHWGehCUD//8GjhAEK2/rYPqTHnXnNCsiXfHi3qJYqD8pQMsbFplO9fjFcHpOy3u8jcOMQxVhoQW5+c2aAP0DIkHuoH3wpgEB4sh+87CYSBYXp42d+zbUuxborEXJ+PzTqeXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382222; c=relaxed/simple;
	bh=ljfdK/CVngTKqGJljr/DtWtTghZNbfd10iwQCKtdKFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llcDgkrJVq8Ldn7Nlm0hWE7G0rssONRcdef237B2PHuJl+GWGn+wpehHJNJaYwjO8pO61ReYdiIdXJOjOAICSvO7BA29qLxivq1rjth2DEGW3ZKxPVLESO+H2wGhUR4fDI9KdhkZcH8gvszmA8Ja1DhGHDDEdqJwUDX+LupyonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ta4Jy1+l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u3yXqXNA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ta4Jy1+l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u3yXqXNA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73D6F5BE09;
	Mon, 25 Mar 2024 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711382218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6UdZw/G7kV8+imSHh6TIPRYUBq5OCd52fb0mHOJXzQ=;
	b=Ta4Jy1+lCvNxvUYujjOdB+EaSHXgKQgKBYDBU6/ZEN0kTO5/0LhkNqixgGtIlb8biZI3mY
	p7j3MHptwOWCLFeq8u8wplvdnzUZ8pg6JK+c14UAT3FwFjXznxOdtkjdgbHK6c4Z2c4sXr
	G4g0X3YcrsRxeqIOc78lwTE1eZ5yNW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711382218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6UdZw/G7kV8+imSHh6TIPRYUBq5OCd52fb0mHOJXzQ=;
	b=u3yXqXNAFcefQn/9NMdIUdLKLQFz+Ekx9P7zjmKRn1nl1lB3ksuVKP8O+nonl1Q8gECxHo
	vbto++V/zu75NGAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711382218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6UdZw/G7kV8+imSHh6TIPRYUBq5OCd52fb0mHOJXzQ=;
	b=Ta4Jy1+lCvNxvUYujjOdB+EaSHXgKQgKBYDBU6/ZEN0kTO5/0LhkNqixgGtIlb8biZI3mY
	p7j3MHptwOWCLFeq8u8wplvdnzUZ8pg6JK+c14UAT3FwFjXznxOdtkjdgbHK6c4Z2c4sXr
	G4g0X3YcrsRxeqIOc78lwTE1eZ5yNW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711382218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6UdZw/G7kV8+imSHh6TIPRYUBq5OCd52fb0mHOJXzQ=;
	b=u3yXqXNAFcefQn/9NMdIUdLKLQFz+Ekx9P7zjmKRn1nl1lB3ksuVKP8O+nonl1Q8gECxHo
	vbto++V/zu75NGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61812137C4;
	Mon, 25 Mar 2024 15:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xhBKF8qeAWbjDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 15:56:58 +0000
Message-ID: <1ad38cac-e90d-4d9a-bf5e-afbcf6ca5bc5@suse.cz>
Date: Mon, 25 Mar 2024 16:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm: page_alloc: optimize free_unref_folios()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-3-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ta4Jy1+l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u3yXqXNA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.81)[84.89%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.31
X-Rspamd-Queue-Id: 73D6F5BE09
X-Spam-Flag: NO

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> Move direct freeing of isolated pages to the lock-breaking block in
> the second loop. This saves an unnecessary migratetype reassessment.
> 
> Minor comment and local variable scoping cleanups.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>



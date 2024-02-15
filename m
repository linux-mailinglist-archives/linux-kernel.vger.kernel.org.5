Return-Path: <linux-kernel+bounces-67168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD485676F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD1D1F271A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758F13341D;
	Thu, 15 Feb 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YXDVk8m5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZnmgzdU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vqtMDufh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYcWr/ft"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38098132C1E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010528; cv=none; b=kwg3Ph5FqHe9+gVojWV3Fqwj9rpzSx4hzWrg+H1XP5X3ZNG2k5YB6ciexT8IyNkXkwDBZagL2tLMlp79ROgwZ7oKQjrvP5VLbDgzenMOgHa6uw8WkD/8qjYUfsCP8Hqxc/MP2xhpWb7gWSZSko6XVDRD8RFBZN6pAcvrcGhQhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010528; c=relaxed/simple;
	bh=4YBPTtk7uCC1xbpOjXR6O+jMjYRn4Ee+zQPRL4OEbDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3KyGdzgg5OFvsSwUOHCGEnECpi24bkgtgclBJZ8gkl5kc/FWIfXUz1yzu2MhVeM9e7+2jBRn6Ii6XPEQTeRcvLUE/k0DeqN3r/Qd8srwrwOQiF6WPrDGvaMz3YfqSXuVxGRXZJ1y8sicYSc9g3PBHzO0TlIUNkyXLWVdPDfjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YXDVk8m5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dZnmgzdU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vqtMDufh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYcWr/ft; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 051FF1F8B8;
	Thu, 15 Feb 2024 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708010524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12kNV5kIRJt316jEGsRdZBsN4TCrOSXuKDUGfy8DHBM=;
	b=YXDVk8m5L81Wk/ZMXTUZkPx5YMXU4K3EaG/AKg/tOSRwvCPKm2UCFNYPvUMiGU36c7mYxX
	snsI5bz+DUKmBux05WNXCr7vcsnleciTGMpNVHEcciYtQ35KPJM6yGZmKA+ITvYJKqIBbx
	j000kA7umP7yJBQSWArnhu6ebDSz83c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708010524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12kNV5kIRJt316jEGsRdZBsN4TCrOSXuKDUGfy8DHBM=;
	b=dZnmgzdUZ9GRAIBLc1QAKzo3iVb/Iwx/L82ctIcR7UnixfLSUZPd7w5OJLMpAgZjRhWZTC
	X3NT+1Dxz55ZknCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708010523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12kNV5kIRJt316jEGsRdZBsN4TCrOSXuKDUGfy8DHBM=;
	b=vqtMDufhvhotMmJiidrfs4WlO8cta9GJScf5PBRtEYi7qDK8KfRRbqJ/gXzk3MLtLH5+OE
	Rhm1aTQVktug73NgNXoeBwZEpPTC7YnPDmkuOe6sX86572bn4LAnL9j0+87hB9ruzj+grI
	slB34y5P6UVHRb3AexvDniJKMx86KRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708010523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12kNV5kIRJt316jEGsRdZBsN4TCrOSXuKDUGfy8DHBM=;
	b=rYcWr/ftod6blOiTC9RhqpiBCrz6h5w+io9C68D0xJd8VW1gOHxftpAUpzWBa2MZq+ChrS
	85iV7av9EEEpWvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D09D313A53;
	Thu, 15 Feb 2024 15:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id abiOMhoszmUedAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 15:22:02 +0000
Message-ID: <cf19bbcd-ee9f-4f59-979a-c19a8b8fb75d@suse.cz>
Date: Thu, 15 Feb 2024 16:22:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] mm/compaction: enable compacting >0 order folios.
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
 <20240214220420.1229173-2-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214220420.1229173-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.23
X-Spamd-Result: default: False [-2.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-2.44)[97.44%];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,samsung.com:email,cmpxchg.org:email,techsingularity.net:email,intel.com:email,nvidia.com:email,arm.com:email,suse.cz:email,alibaba.com:email,huaweicloud.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/14/24 23:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> migrate_pages() supports >0 order folio migration and during compaction,
> even if compaction_alloc() cannot provide >0 order free pages,
> migrate_pages() can split the source page and try to migrate the base
> pages from the split.  It can be a baseline and start point for adding
> support for compacting >0 order folios.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Yu Zhao <yuzhao@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yin Fengwei <fengwei.yin@intel.com>



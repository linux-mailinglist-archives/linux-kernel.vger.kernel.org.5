Return-Path: <linux-kernel+bounces-69061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555F8583FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B143281E74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39104130E47;
	Fri, 16 Feb 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2fl2ZDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0l2jzgeG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAFmCTbF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ULGWGSag"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23288131724
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104006; cv=none; b=aNvtd6i1AQmvOiK1uEG24LupfFjG2Woj1ugCOH1iP7y2/AaPbXpJLIalA8jU5cqhh/5/On9u/ud8ff83seVSR9YUr+1LGXD19XDF+dPat2c5bBfPygSS5pSLVN3I6x4cT5c4PICB6EclEyQEHO0F7x06DtGUgdxOVpT0je19rfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104006; c=relaxed/simple;
	bh=Eml5OPhCyf0cojnUh5A9KsegwkRtYllLTFweDVfQ+t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1NC0dWzRkKhd/8WuIBlRFZojFhcbnCk1QC76VMxEJCRTvSnwe46zIrNnXXEiGl9YzA+XbVC2cmcHqy2bJWkBwzSXWWWoVc8imvglg7HA6t3YvkXXIDaLaJ3KVL8ngT7wgQAJSj1m41G7FTMgBAdDpGIoIR4UKGaV/dMkG7AIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2fl2ZDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0l2jzgeG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qAFmCTbF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ULGWGSag; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1563722281;
	Fri, 16 Feb 2024 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708103993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhznNdyBX4sr1r0BuB44YrySuOrmrfaloMLREZc2cjk=;
	b=o2fl2ZDUfZ21cTNCWT542Tuy6mI0U531zLrRlEEGQPKCj47OTI1dZTr91h4Lo4tC2INOiS
	nm0/Ie8lfuzECEJtrbFj6jEcU7/m/xFFXnbZ/SSfIbFpahAfGPjZR+zlePMGbAwsHjqzzT
	TfNnD/XgzZSlFyQlRrHsoInHL0G8Tbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708103993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhznNdyBX4sr1r0BuB44YrySuOrmrfaloMLREZc2cjk=;
	b=0l2jzgeGR++FkgYJPqLxtW9LIdVFhhFPOZwBFxxeQAasoUKJY4vnA/nlfbQ9vX75FSnvee
	FeDvzvBCIlDzBoBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708103991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhznNdyBX4sr1r0BuB44YrySuOrmrfaloMLREZc2cjk=;
	b=qAFmCTbFnKuwCj9C4J3rz0mkVO1eW7uxRI7DjJ0xpsmBOiMUTq7bl2Q2kdq5nSIUdwAsVR
	SerYF/HBdS8trqOSysSoGz/yG8xLtVGoShUehMDSnqiH0bnDYG3XZ2ti0B0VuO6J+0bq7D
	uBlm4o9D9c3GPpnhNETKoPb+0U6Idbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708103991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhznNdyBX4sr1r0BuB44YrySuOrmrfaloMLREZc2cjk=;
	b=ULGWGSaguxdyM68XjH9ur9Cu6X9FCPx/9zE0IIk36A6YZOImnXp2lfNngAZWruIsD45ZDb
	u6me4RU9yNhbFoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD1F1398D;
	Fri, 16 Feb 2024 17:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SdZiMjaZz2UYWwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 17:19:50 +0000
Message-ID: <07f7a98b-5cb0-49f3-8672-53e3bd63c922@suse.cz>
Date: Fri, 16 Feb 2024 18:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] mm/page_alloc: remove unused fpi_flags in
 free_pages_prepare()
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
References: <20240216170432.1268753-1-zi.yan@sent.com>
 <20240216170432.1268753-2-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240216170432.1268753-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.14 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-1.55)[92.08%];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.14

On 2/16/24 18:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> fpi_flags is only passed to should_skip_kasan_poison() but ignored
> by the function. Remove the unused parameter.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.




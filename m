Return-Path: <linux-kernel+bounces-156896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7798B0A07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B2CB22321
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8915957A;
	Wed, 24 Apr 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WDYLaaVr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GwLeC0wL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p99q5IYe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0hCiIXIx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1033142E70
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963057; cv=none; b=IqyOkRi20JmKHw7VfBG83QuCfWugHHAyN9Pp4KWWnzE762Bic/lji2zbW+eJnc7RWJyiFt+s74Yx7zUpuEtlxvft1SPXKNVnrXjhvLpAGGzdF/elPkLGSKiKxOlk+abCO63xj8CHDzdAtqLLLpOdFgKLQMOYg6LB0ryPQt1+usM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963057; c=relaxed/simple;
	bh=cNUU/fcKqcvPSW6ILcwShEiDZljjCvHYFosKxgiCjj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJX5/7UmJ+8HeK9PUjLOJdDIn97Bo3BptI750XBGhLyyz6JiwsSSSlPVJ2o7yyMEpqQgDBxP5GwJeOrcoDU8iPrNtd81sbuaq4V/c0XlgAO/HesW0eR1WAOCATs3n2i0iRQ7GQAyDrz1z8jQCf4o91z/SwHyU9Mns6IBFa+2Mro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WDYLaaVr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GwLeC0wL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p99q5IYe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0hCiIXIx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D57C366D87;
	Wed, 24 Apr 2024 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713963054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXtNZw8CKU8Xn6cglX2Jt4nhiH7S3y2VuCDIBRk3nX8=;
	b=WDYLaaVrMXMk7idZIY4DIYVp30+cWDuIUc/31xfBq7mjE0ZkJjf2TwI1fS4avoMrL7L7bD
	TJy8uxK+BFLVfYTNys76wN9XWBHxTh9fMasXA4fcaaL2dvyaGUgvGh3w3bJhw1dxYdiFNH
	LQOwOKJ6Qrj8euYKm8AYbickbFjONU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713963054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXtNZw8CKU8Xn6cglX2Jt4nhiH7S3y2VuCDIBRk3nX8=;
	b=GwLeC0wLJ0uVE8fbv9KVNsW2h6xAGRXfIn5Bnz+5JRh5hzIkcJunPDbiKji/R99K6oNCex
	ojhz48eMxOowTsBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p99q5IYe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0hCiIXIx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713963053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXtNZw8CKU8Xn6cglX2Jt4nhiH7S3y2VuCDIBRk3nX8=;
	b=p99q5IYeUiZHiIYatIXThbeVmmkiAkP1mAIH5tXbR3SQNI0rTfyUx4+qtio1kw6Tw/JHeP
	r37VJ4Y8Bx2WQ14Y8AsO9Ywg92CpbdeQoGvw/4vJ6LOGCadc7Wt+i4RIRmwTIlEm2VU8D1
	Sq4ySFXPwq+QJQSVbEJHTv7cbe/L2Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713963053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXtNZw8CKU8Xn6cglX2Jt4nhiH7S3y2VuCDIBRk3nX8=;
	b=0hCiIXIxQ/CmOXsoppYZR4Vm/LCrLzKubwQWyDtob2OVthv2C5Q/eHuntOAmONYV7KfQiX
	ObLTVtNP1319kaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEBD51393C;
	Wed, 24 Apr 2024 12:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eVfqKS0AKWaddQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 24 Apr 2024 12:50:53 +0000
Date: Wed, 24 Apr 2024 14:50:52 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Hariom Panthi <hariom1.p@samsung.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, vbabka@suse.cz, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, r.thapliyal@samsung.com,
	Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 1/2] mm: page_owner: fixing wrong information in
 dump_page_owner
Message-ID: <ZikALBw17JePpWVh@localhost.localdomain>
References: <CGME20240424112123epcas5p46e76f51b8913661a6b740dcbbec83621@epcas5p4.samsung.com>
 <20240424111838.3782931-1-hariom1.p@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424111838.3782931-1-hariom1.p@samsung.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,infradead.org,suse.cz,kvack.org,vger.kernel.org,samsung.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D57C366D87
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.51

On Wed, Apr 24, 2024 at 04:48:37PM +0530, Hariom Panthi wrote:
> From: Maninder Singh <maninder1.s@samsung.com>
> 
> with commit ea4b5b33bf8a ("mm,page_owner: update metadata for tail pages"),
> new API __update_page_owner_handle was introduced and arguemnt was passed
> in wrong order from __set_page_owner and thus page_owner is giving
> wrong data.
> 
> [   15.982420] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 80, tgid -1210279584 (insmod), ts 80, free_ts 0
> 
> Fixing the same.
> Correct output:
> [   14.556482] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 80, tgid 80 (insmod), ts 14552004992, free_ts 0
> 
> Fixes: ea4b5b33bf8a ("mm,page_owner: update metadata for tail pages")
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Hariom Panthi <hariom1.p@samsung.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks!

 

-- 
Oscar Salvador
SUSE Labs


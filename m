Return-Path: <linux-kernel+bounces-44689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07EE8425FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B26291AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8736BB29;
	Tue, 30 Jan 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuipvvRH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVaiJwa/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LQQqIBom";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yMtdf8av"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892606A00C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620572; cv=none; b=JZgHGFb5sEWdpjmFYCHr2DQan687Vr36I6vSIqr8ohGGhqY6KIWcWx1fVl7I8ahf7/sfX7LKWnV5P4luyi1XLkuOCceHzu5F4qF5aHofy4+8PJJ2/qJyKvJJr/kOkMt12rHRt6VVUCK6csrDb3Uzq/22u3w5Xx79ejcwIkCFBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620572; c=relaxed/simple;
	bh=YiNWA5mVJlv6bd2w7OgoxKxdc6mVSEXQGz66b8oomzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvah6rNqqwd6/+68hY4mbsaZ8GlT3kjEiSRgmmpUodR8khwX8oYRqyTBR1Cnv8PXMVC0rKLRGEGYqTGYog33xR3VzLnBqG61X88IQzLWX5j2ISrAAyxoLzO9uFL/jB/SstvJXgmUCvo8a7ip0EGnKcCAwfGZPz6AF40MUlBVpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuipvvRH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVaiJwa/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LQQqIBom; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yMtdf8av; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 855201F84A;
	Tue, 30 Jan 2024 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706620568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCNq95+0rNCD2kp/hKAX5Oke9fUmnEml0yRbLl6Ruxw=;
	b=kuipvvRHAvzTQ+A7AvAZFcMzriCKYKUNWAgTzhiX0PZRFcWd2bTgx7ZtBzvU+9dbz5F+Kk
	mhnzHuG9R4iWzBLwsdXgqbqRO+MpGUVlh2kr7sQmHLMFy3iFuEKtAOAwVqzhD2QFpgTWlV
	WEWRYER3uq+kInX+h3u4TA1nG4uvfEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706620568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCNq95+0rNCD2kp/hKAX5Oke9fUmnEml0yRbLl6Ruxw=;
	b=TVaiJwa/GeGS1+L9+5/rTFN1xODWweM9oYSvxK8EHMANFo7NUjVqK+66RXbX86q7GAfxn4
	N/+x3sDWfg8K3nCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706620567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCNq95+0rNCD2kp/hKAX5Oke9fUmnEml0yRbLl6Ruxw=;
	b=LQQqIBomU7yb+znQm6ltiLwJDTZoN+kYWf42c8yxRV4tqANHD6Mc7Qq2g2WgM/1FSeVW//
	mzfTywwSLaiFpVJAChjXvkqf7386B2OUxbJQ/bxC2WLrcal6mut/69JxCf1KZk0N9oN092
	k+HHB/rGM5lm1kPdPoecmcKbBbIhILQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706620567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCNq95+0rNCD2kp/hKAX5Oke9fUmnEml0yRbLl6Ruxw=;
	b=yMtdf8avSWT2b/snjWyDhLsFTO2qRHbMubYXCu+rcJNR9UtTc5FBThLtGpkJnqP5Rj7ige
	2kijJP3Wfvby7SDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CCC712FF7;
	Tue, 30 Jan 2024 13:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g9UkGpf2uGURWgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jan 2024 13:16:07 +0000
Message-ID: <e57c86b6-aa5e-4680-b146-5eb5dfb53bf8@suse.cz>
Date: Tue, 30 Jan 2024 14:16:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slub: remove parameter 'flags' in
 create_kmalloc_caches()
Content-Language: en-US
To: Zheng Yejian <zhengyejian1@huawei.com>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014107.1262373-1-zhengyejian1@huawei.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240130014107.1262373-1-zhengyejian1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LQQqIBom;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yMtdf8av
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[huawei.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[11.35%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.00
X-Rspamd-Queue-Id: 855201F84A
X-Spam-Flag: NO

On 1/30/24 02:41, Zheng Yejian wrote:
> After commit 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"),
> parameter 'flags' is only passed as 0 in create_kmalloc_caches(), and
> then it is only passed to new_kmalloc_cache().
> 
> So we can change parameter 'flags' to be a local variable with
> initial value 0 in new_kmalloc_cache() and remove parameter 'flags'
> in create_kmalloc_caches(). Also make new_kmalloc_cache() static
> due to it is only used in mm/slab_common.c.
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Thanks, merged for 6.9



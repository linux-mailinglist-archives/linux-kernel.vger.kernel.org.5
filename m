Return-Path: <linux-kernel+bounces-22396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843DA829D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3B31C21A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169AD4BAB0;
	Wed, 10 Jan 2024 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xTsoCLGT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uyNrZy2C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xTsoCLGT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uyNrZy2C"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10294BA89;
	Wed, 10 Jan 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1F271F8B4;
	Wed, 10 Jan 2024 15:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYbYAQRK1HI4UHlc+NM2fJBWwh8XcB6rEpayh07rLJ4=;
	b=xTsoCLGTYbFz023JDcIZllwTB9btdqwjUt8ooUT+8V7pMwEIc/9jRe1PwPuTLWGJ8mnsJ5
	RXoV+W9/EZskjZtnjRnelkZVZ+/yJPq8CfmlP/C6dczuJrY3NJIxbRxVWn0veKB2aNM+rD
	RGmqAHm8+XOw0oNk6fHUJT5vsfiibjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYbYAQRK1HI4UHlc+NM2fJBWwh8XcB6rEpayh07rLJ4=;
	b=uyNrZy2Cs5HOvPAF0PMgdz4NfX6GGSiHM+Jnj9KTb7vqeorL5docUm7xHlA/XIy5diHNbN
	25e5nyWuIacptTDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYbYAQRK1HI4UHlc+NM2fJBWwh8XcB6rEpayh07rLJ4=;
	b=xTsoCLGTYbFz023JDcIZllwTB9btdqwjUt8ooUT+8V7pMwEIc/9jRe1PwPuTLWGJ8mnsJ5
	RXoV+W9/EZskjZtnjRnelkZVZ+/yJPq8CfmlP/C6dczuJrY3NJIxbRxVWn0veKB2aNM+rD
	RGmqAHm8+XOw0oNk6fHUJT5vsfiibjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYbYAQRK1HI4UHlc+NM2fJBWwh8XcB6rEpayh07rLJ4=;
	b=uyNrZy2Cs5HOvPAF0PMgdz4NfX6GGSiHM+Jnj9KTb7vqeorL5docUm7xHlA/XIy5diHNbN
	25e5nyWuIacptTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA51713786;
	Wed, 10 Jan 2024 15:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eTQfKd6ynmVdSwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Jan 2024 15:08:14 +0000
Message-ID: <81daaa15-60f1-4edc-9442-2a9b1e6006f3@suse.cz>
Date: Wed, 10 Jan 2024 16:08:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] mm/slub: make the description of slab_min_objects
 helpful in doc
Content-Language: en-US
To: sxwjean@me.com, 42.hyeyoo@gmail.com, cl@linux.com, linux-mm@kvack.org
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
 arnd@arndb.de, akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 quic_jjohnson@quicinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiongwei Song <xiongwei.song@windriver.com>
References: <20231215034150.108783-1-sxwjean@me.com>
 <20231215034150.108783-5-sxwjean@me.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231215034150.108783-5-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RL9sdddhhbu1oo5wyhn6sr3k5b)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[me.com,gmail.com,linux.com,kvack.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-2.10)[95.63%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,me.com:email,suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.10
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D1F271F8B4
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xTsoCLGT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uyNrZy2C

On 12/15/23 04:41, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> There is no a value assigned to slab_min_objects by default, it always
> is 0 that is initialized by compiler if no assigned value by command line.
> min_objects is calculated based on processor numbers in calculate_order().
> For more details, see commit 9b2cd506e5f2 ("slub: Calculate min_objects
> based on number of processors.")
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  Documentation/mm/slub.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
> index 6579a55b7852..213491ffb66f 100644
> --- a/Documentation/mm/slub.rst
> +++ b/Documentation/mm/slub.rst
> @@ -150,7 +150,7 @@ list_lock once in a while to deal with partial slabs. That overhead is
>  governed by the order of the allocation for each slab. The allocations
>  can be influenced by kernel parameters:
>  
> -.. slab_min_objects=x		(default 4)
> +.. slab_min_objects=x		(default:automatically scaled by number of cpus)

Added a space after "default:" locally.

>  .. slab_min_order=x		(default 0)
>  .. slab_max_order=x		(default 3 (PAGE_ALLOC_COSTLY_ORDER))
>  



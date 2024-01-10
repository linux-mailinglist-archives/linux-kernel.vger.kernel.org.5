Return-Path: <linux-kernel+bounces-22400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E771829D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC86287816
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6264C3AF;
	Wed, 10 Jan 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJ90PBHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VwEz0ob6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJ90PBHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VwEz0ob6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7844C3A0;
	Wed, 10 Jan 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43E651F8B4;
	Wed, 10 Jan 2024 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngam/HRyYzoj85sv8uX/jXHAXpXjri79QCqTP+n6cIU=;
	b=ZJ90PBHG2SobtAgLaK2ekYY2cTkWTef+Id1mAMw1d7bZt1vEAMkh+IUS0ASL/n7eJsTzKn
	5fMqC9R1dXCXt0LRe6//lR4xTUjsFygsy9nzcMLf863HLsUY/RDY9tCHP7XAhpqR/4tPLd
	ccExpOj9K1gpmmtyOAhWMm0cZWlNGLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngam/HRyYzoj85sv8uX/jXHAXpXjri79QCqTP+n6cIU=;
	b=VwEz0ob6BjJr8e5GUUgPWXs8sIeORJfBMw2XAqoIDrzvj6+EBCqDGVxfiKHjLB3O8lOEst
	YYYlF91pNhO8IgDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngam/HRyYzoj85sv8uX/jXHAXpXjri79QCqTP+n6cIU=;
	b=ZJ90PBHG2SobtAgLaK2ekYY2cTkWTef+Id1mAMw1d7bZt1vEAMkh+IUS0ASL/n7eJsTzKn
	5fMqC9R1dXCXt0LRe6//lR4xTUjsFygsy9nzcMLf863HLsUY/RDY9tCHP7XAhpqR/4tPLd
	ccExpOj9K1gpmmtyOAhWMm0cZWlNGLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngam/HRyYzoj85sv8uX/jXHAXpXjri79QCqTP+n6cIU=;
	b=VwEz0ob6BjJr8e5GUUgPWXs8sIeORJfBMw2XAqoIDrzvj6+EBCqDGVxfiKHjLB3O8lOEst
	YYYlF91pNhO8IgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D79713786;
	Wed, 10 Jan 2024 15:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /6fKBtuznmVEUgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Jan 2024 15:12:27 +0000
Message-ID: <3f9e3cfa-c86d-4770-b531-87138803156f@suse.cz>
Date: Wed, 10 Jan 2024 16:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] supplement of slab allocator removal
Content-Language: en-US
To: sxwjean@me.com, 42.hyeyoo@gmail.com, cl@linux.com, linux-mm@kvack.org
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
 arnd@arndb.de, akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 quic_jjohnson@quicinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiongwei Song <xiongwei.song@windriver.com>
References: <20231215034150.108783-1-sxwjean@me.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231215034150.108783-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.16
X-Spamd-Result: default: False [0.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL8m16cxuawb3bjqy6gedmikd6)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.05)[60.61%];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,me.com:email];
	 FREEMAIL_TO(0.00)[me.com,gmail.com,linux.com,kvack.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 12/15/23 04:41, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Hi,
> 
> Patch 1 is to remove an unused parameter. It has a longer history, please
> see the change history inside the patch.
> 
> ---
> Patch 2 is to replace slub_$params with slab_$params.
> Vlastimil Babka pointed out we should use "slab_$param" as the primary
> prefix for long-term plan. Please see [1] for more information.
> 
> I did the basic tests with qemu, which passed values by sl[au]b_max_order,
> sl[au]b_min_order, sl[au]b_min_objects and sl[au]b_debug in command line.
> The values looks correct by printing them out before calculating orders.
> 
> ---
> Patch 3 is to replace slub_$params in Documentation/mm/slub.rst based on
> the changes of patch 2.
> 
> ---
> Patch 4 is original patch 3. It is not related to slab allocator removal.
> It's to correct the description of default value of slab_min_objects in
> Documentation/mm/slub.rst. 
> 
> ---
> This series is based on [2].

I will queue this for 6.9 after the merge window. But since the changes are
mostly in Documentation, maybe Jon would prefer his tree, then we would
split away the code comments changes in patch 2 to go through slab tree.

Vlastimil


Return-Path: <linux-kernel+bounces-22393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00225829D18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04B2286200
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905CC4BA98;
	Wed, 10 Jan 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFKUtmEe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xq53b1xx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFKUtmEe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xq53b1xx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C14B5CA;
	Wed, 10 Jan 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91A661F8B4;
	Wed, 10 Jan 2024 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ml63POBLvJX+b4mv8tB916BNz9hw8t0vfu68ICso2Ic=;
	b=UFKUtmEeHzXmdGo86Fy0Zn85sNNO7ipDADUI7RLFEmNWvYLy1/7cEC/Ohx3wbKwjPgNmTl
	rbcrf9NtAE/NeFutMKfQh5nf2CTtHkwVdJuydJvGabkwg1EQkpTFafj0bmjk344BA4n+6o
	2SCVmrsqaThyIm4wKMPISsz7gTMSllk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ml63POBLvJX+b4mv8tB916BNz9hw8t0vfu68ICso2Ic=;
	b=Xq53b1xxLn/ZNuUgNwMyq4j5dEcy2aczP5+OrB7X1xfbW/lqo6UclSKllvmggKaYIPU6Ba
	KONrxnfI4PlZzXCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ml63POBLvJX+b4mv8tB916BNz9hw8t0vfu68ICso2Ic=;
	b=UFKUtmEeHzXmdGo86Fy0Zn85sNNO7ipDADUI7RLFEmNWvYLy1/7cEC/Ohx3wbKwjPgNmTl
	rbcrf9NtAE/NeFutMKfQh5nf2CTtHkwVdJuydJvGabkwg1EQkpTFafj0bmjk344BA4n+6o
	2SCVmrsqaThyIm4wKMPISsz7gTMSllk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ml63POBLvJX+b4mv8tB916BNz9hw8t0vfu68ICso2Ic=;
	b=Xq53b1xxLn/ZNuUgNwMyq4j5dEcy2aczP5+OrB7X1xfbW/lqo6UclSKllvmggKaYIPU6Ba
	KONrxnfI4PlZzXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A12213786;
	Wed, 10 Jan 2024 15:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4FCmFb2xnmW1QwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Jan 2024 15:03:25 +0000
Message-ID: <639c0b0a-dfbc-4612-aeaf-460a68c9e6a0@suse.cz>
Date: Wed, 10 Jan 2024 16:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Content-Language: en-US
To: sxwjean@me.com, 42.hyeyoo@gmail.com, cl@linux.com, linux-mm@kvack.org
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
 arnd@arndb.de, akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 quic_jjohnson@quicinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiongwei Song <xiongwei.song@windriver.com>
References: <20231215034150.108783-1-sxwjean@me.com>
 <20231215034150.108783-3-sxwjean@me.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231215034150.108783-3-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UFKUtmEe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xq53b1xx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.44 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 SUBJECT_HAS_CURRENCY(1.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL9sdddhhbu1oo5wyhn6sr3k5b)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[me.com,gmail.com,linux.com,kvack.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-1.44)[91.23%];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.44
X-Rspamd-Queue-Id: 91A661F8B4
X-Spam-Flag: NO

On 12/15/23 04:41, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Since the SLAB allocator has been removed, so we can clean up the
> sl[au]b_$params. With only one slab allocator left, it's better to use the
> generic "slab" term instead of "slub" which is an implementation detail,
> which is pointed out by Vlastimil Babka. For more information please see
> [1]. Hence, we are going to use "slab_$param" as the primary prefix.
> 
> This patch is changing the following slab parameters
> - slub_max_order
> - slub_min_order
> - slub_min_objects
> - slub_debug
> to
> - slab_max_order
> - slab_min_order
> - slab_min_objects
> - slab_debug
> as the primary slab parameters for all references of them in docs and
> comments. But this patch won't change variables and functions inside
> slub as we will have wider slub/slab change.
> 
> Meanwhile, "slub_$params" can also be passed by command line, which is
> to keep backward compatibility. Also mark all "slub_$params" as legacy.
> 
> Remove the separate descriptions for slub_[no]merge, append legacy tip
> for them at the end of descriptions of slab_[no]merge.
> 
> [1] https://lore.kernel.org/linux-mm/7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz/
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Thanks.


Return-Path: <linux-kernel+bounces-81014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A741866F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB828B257F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA5249F9;
	Mon, 26 Feb 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k2/5MnNm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7Vocu1K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k2/5MnNm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7Vocu1K"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB6249F8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938702; cv=none; b=HC5a8W5MfehCK3nOFDpg5EkRZe7CfkCFhJhEiQQFFqTveRqlyckyZ7hGGyWIFLG2xYsoAiVUxuQtjwdJU7ox6upJwcBeeV6aWEnfVOwqNUY/7994p83My7arkyZOTN97b+xLJFc+rYnY1U+eyiGsukDr8wLMohlsTP+94YnJ0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938702; c=relaxed/simple;
	bh=ab6hYbyC5KieS4nv+ZIHD2ncwsQksRliIipFl1xjrnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9MNtVa1p5L8RvfiRIEIZoOyYKjgf7rAERyUkWP6n3dgg66LghS3276gqOO7lEFRjRwuT2B9/YYtqbP6Ixl0DQUHK2I32enX+B2z19RGwRgbN/iDanS5g8Sn8F3H5wdt7dk76mNfMOR9P0zPZXD7C82FEL6gxBVauc04MpVlKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k2/5MnNm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7Vocu1K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k2/5MnNm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7Vocu1K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C4361F896;
	Mon, 26 Feb 2024 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708938698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89yAF6qEhgvcbbVCO+3NfAAxt3pVNwScA2PuWa4QdPY=;
	b=k2/5MnNmCuRZCyE22O9S+yaD2Aq91DDO0PVVUa2bFRPpuFDw4GJNI1Xy8MC66lHng9QXl/
	RIEWFC2OtvA5WGNY/6XRFCvliAfIeFGUuShc/QP96T3LVpSkLkJEmGwujVXtotO5i+gyEF
	hnj4x/Lk6WEMZqWu6m1mEQ+NCSFnShE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708938698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89yAF6qEhgvcbbVCO+3NfAAxt3pVNwScA2PuWa4QdPY=;
	b=S7Vocu1KYjptijIjFq1WYqyP41BQy4Diu0CGnCJr52O/jDMDA3QnOfawjSlIS7UPhWN7N9
	ITrcrYa+MAcuEmAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708938698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89yAF6qEhgvcbbVCO+3NfAAxt3pVNwScA2PuWa4QdPY=;
	b=k2/5MnNmCuRZCyE22O9S+yaD2Aq91DDO0PVVUa2bFRPpuFDw4GJNI1Xy8MC66lHng9QXl/
	RIEWFC2OtvA5WGNY/6XRFCvliAfIeFGUuShc/QP96T3LVpSkLkJEmGwujVXtotO5i+gyEF
	hnj4x/Lk6WEMZqWu6m1mEQ+NCSFnShE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708938698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89yAF6qEhgvcbbVCO+3NfAAxt3pVNwScA2PuWa4QdPY=;
	b=S7Vocu1KYjptijIjFq1WYqyP41BQy4Diu0CGnCJr52O/jDMDA3QnOfawjSlIS7UPhWN7N9
	ITrcrYa+MAcuEmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53DAC13A58;
	Mon, 26 Feb 2024 09:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zqYiFMpV3GV7HAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 09:11:38 +0000
Message-ID: <38f7952a-bee7-4a21-a89f-facff1803c41@suse.cz>
Date: Mon, 26 Feb 2024 10:11:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cleanup of SLAB_ flags
Content-Language: en-US
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>,
 Xiongwei Song <xiongwei.song@windriver.com>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.41 / 50.00];
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
	 R_RATELIMIT(0.00)[to_ip_from(RLqdadssyy1w6u3twx3pq4jyny)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.00)[19.95%];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.41
X-Spam-Flag: NO

On 2/23/24 19:27, Vlastimil Babka wrote:
> This started by the report that SLAB_MEM_SPREAD flag is dead (Patch 1).
> Then in the alloc profiling series we realized it's too easy to reuse an
> existing SLAB_ flag's value when defining a new one, by mistake.
> Thus let the compiler do that for us via a new helper enum (Patch 2).
> When checking if more flags are dead or could be removed, didn't spot
> any, but found out the SLAB_KASAN handling of preventing cache merging
> can be simplified since we now have an explicit SLAB_NO_MERGE (Patch 3).
> 
> The SLAB_MEM_SPREAD flag is now marked as unused and for removal, and
> has a value of 0 so it's a no-op. Patches to remove its usage can/will
> be submitted to respective subsystems independently of this series - the
> flag is already dead as of v6.8-rc1 with SLAB removed. The removal of
> dead cpuset_do_slab_mem_spread() code can also be submitted
> independently.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Pushed to slab/for-next

> ---
> Changes in v2:
> - Collect R-b, T-b (thanks!)
> - Unify all disabled flags's value to a sparse-happy zero with a new macro (lkp/sparse).
> - Rename __SF_BIT to __SLAB_FLAG_BIT (Roman Gushchin)
> - Rewrod kasan_cache_create() comment (Andrey Konovalov)
> - Link to v1: https://lore.kernel.org/r/20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz
> 
> ---
> Vlastimil Babka (3):
>       mm, slab: deprecate SLAB_MEM_SPREAD flag
>       mm, slab: use an enum to define SLAB_ cache creation flags
>       mm, slab, kasan: replace kasan_never_merge() with SLAB_NO_MERGE
> 
>  include/linux/kasan.h |  6 ----
>  include/linux/slab.h  | 97 ++++++++++++++++++++++++++++++++++++---------------
>  mm/kasan/generic.c    | 22 ++++--------
>  mm/slab.h             |  1 -
>  mm/slab_common.c      |  2 +-
>  mm/slub.c             |  6 ++--
>  6 files changed, 79 insertions(+), 55 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240219-slab-cleanup-flags-c864415ecc8e
> 
> Best regards,



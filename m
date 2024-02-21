Return-Path: <linux-kernel+bounces-75599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B85185EBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B511F22F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615512882B;
	Wed, 21 Feb 2024 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNAIyQ+a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ylT2uZtA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNAIyQ+a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ylT2uZtA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B34A1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553987; cv=none; b=k+hDVgMlMulJxpCLhz57m8URlYmt+4A1Obdn9h+dONbcbc9VCh0Z9YzfHMxTkEC4fyHloxSj1MPRdve06gpkBtY1vj3xJ1ueDv9vT9fKnMNYjdSqRiPQSyplKNvzDAWI1lmHbaAnBHchV7jbyNYD7qPXzn9LDmgS7rcQHmA1BLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553987; c=relaxed/simple;
	bh=cT6C/4EpDCLlKk2JB1GbRKSlK0IkmvxaRUnPUNkSeKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfV6PyvUVk8XoK6yeBiriv3/gbkNmPAVSMVBuO1pCEK06HIaKin+u+sM8fDINzVu6GxyNnLfIYuJg2+agcvOM2dRcDtlhWRXS7jShx/hXlO6g3NmVHmmQKfbVfKWzlzsF+js6V6biHfQY+wdgjaQvVsPzSUXcev27f3SMO7Vcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNAIyQ+a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ylT2uZtA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNAIyQ+a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ylT2uZtA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B314F22264;
	Wed, 21 Feb 2024 22:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708553983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxL/y8ewJsj/ttUnxwt5FKrTF34RqTIXa5SPkRu66jo=;
	b=HNAIyQ+ahHkAIn6rhh4PTHj7GaX8akTDyFZj5HSpNlFr9CBIbh5mYFjhMG1R+ub6boLNec
	d9UNHYsKgCvb7cVooS57qb/MuNto8z+8MkbRp/2MAoF5pLpchxA/hrNNc6QTAd3v602sNz
	iWLBLPoV8UYXEVlzPezpD9JcO+eRJnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708553983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxL/y8ewJsj/ttUnxwt5FKrTF34RqTIXa5SPkRu66jo=;
	b=ylT2uZtA6ijAAl4YOMxqD0T/sDVxsbh94+eVefkNKCDlOMG8qRhRJMpP1QWeRQ6vTRlOT6
	MKoIMLVDL09WjqCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708553983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxL/y8ewJsj/ttUnxwt5FKrTF34RqTIXa5SPkRu66jo=;
	b=HNAIyQ+ahHkAIn6rhh4PTHj7GaX8akTDyFZj5HSpNlFr9CBIbh5mYFjhMG1R+ub6boLNec
	d9UNHYsKgCvb7cVooS57qb/MuNto8z+8MkbRp/2MAoF5pLpchxA/hrNNc6QTAd3v602sNz
	iWLBLPoV8UYXEVlzPezpD9JcO+eRJnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708553983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxL/y8ewJsj/ttUnxwt5FKrTF34RqTIXa5SPkRu66jo=;
	b=ylT2uZtA6ijAAl4YOMxqD0T/sDVxsbh94+eVefkNKCDlOMG8qRhRJMpP1QWeRQ6vTRlOT6
	MKoIMLVDL09WjqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AE6413A69;
	Wed, 21 Feb 2024 22:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vOGYIf921mUObgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Feb 2024 22:19:43 +0000
Message-ID: <e8e9d68d-8bbd-41ea-a627-eed17ba37ebe@suse.cz>
Date: Wed, 21 Feb 2024 23:19:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm, slab: use an enum to define SLAB_ cache creation
 flags
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
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HNAIyQ+a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ylT2uZtA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.68 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLycmwa99sdzp837p77658kns5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.18)[70.31%];
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
	 RCPT_COUNT_TWELVE(0.00)[18];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.68
X-Rspamd-Queue-Id: B314F22264
X-Spam-Flag: NO

On 2/20/24 17:58, Vlastimil Babka wrote:
> @@ -156,9 +195,9 @@
>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
>  #ifndef CONFIG_SLUB_TINY
> -#define SLAB_RECLAIM_ACCOUNT ((slab_flags_t __force)0x00020000U)
> +#define SLAB_RECLAIM_ACCOUNT __SF_BIT(_SLAB_RECLAIM_ACCOUNT)
>  #else
> -#define SLAB_RECLAIM_ACCOUNT ((slab_flags_t __force)0)
> +#define SLAB_RECLAIM_ACCOUNT 0

lkp/sparse tells me this was the wrong way to unify all noop-due-to-config
flags [1,2]

so in v2 I'll unify all those to
((slab_flags_t __force)0U)

also the deprecated SLAB_MEM_SPREAD in patch 1

[1] https://lore.kernel.org/all/202402212310.KPtSDrRy-lkp@intel.com/
[2] https://lore.kernel.org/all/202402211803.Lmf1ANXx-lkp@intel.com/


>  #endif
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */




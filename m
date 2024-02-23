Return-Path: <linux-kernel+bounces-78746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80F861832
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AEC1C211DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FF612839B;
	Fri, 23 Feb 2024 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRPkpehn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/IAv2tlZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRPkpehn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/IAv2tlZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70923186A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706478; cv=none; b=bSFo2TFYblAkqH4jYMub2vb0kYEFGLgbXieSg403Uvn5DseTU6SIVfffHxvCwUNhNh5AvbRus8nkggWpNfxuRlTgSPJ177d6wDPVqtmi7PnkAEjIrf9xPnp2P/qcVVxaUVF/sms3A5SNzGLRXt3JCwlZti5nq2iKy6Wp6R6A3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706478; c=relaxed/simple;
	bh=o+lkzSu9bKND8zPTcC+UoXjCPmFf+l5opinlVCsd+wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzp+anfxrrykfL8mpqaoQn5IV8yGzXUIOwGrpT/8JesgBy504IHqRKaSAH0uukvmwUJBH7iHBktKcm9gFwzHaxg4QizxxUPH2VxdloLTr1kpvNM8zw4BfAiSLWR9alEXOpaJV3oySxsc0hOOVRFP8pa8VpWxRu44UztXIrs6pm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRPkpehn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/IAv2tlZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRPkpehn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/IAv2tlZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A59421FB4;
	Fri, 23 Feb 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708706474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAyabS4dUGUNPXWjy9UPvrWPskMGtOkshIYfRSgL3r4=;
	b=eRPkpehnV4uR++163NsNLDZoA9/Mt9Aj+g7KBwm2DfBhiLadErubvt+kPbbyfSdFm9jcMH
	toSihyegXKtz0gA/yGvTLLbG67yR6yBFmRqnvH1qtsga/O5iKrPO2xjRmXHkmWI8tG+iMM
	k2VisWWV4kfEv8iEDaVZ9f3WLkSp2+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708706474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAyabS4dUGUNPXWjy9UPvrWPskMGtOkshIYfRSgL3r4=;
	b=/IAv2tlZQXeHlX8AvgRpFW90Y8zTqTp+M16BU90+qscDZ19GX75hEQz7EnCevERr7GRmoz
	AMXLtvg1UmB9O3Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708706474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAyabS4dUGUNPXWjy9UPvrWPskMGtOkshIYfRSgL3r4=;
	b=eRPkpehnV4uR++163NsNLDZoA9/Mt9Aj+g7KBwm2DfBhiLadErubvt+kPbbyfSdFm9jcMH
	toSihyegXKtz0gA/yGvTLLbG67yR6yBFmRqnvH1qtsga/O5iKrPO2xjRmXHkmWI8tG+iMM
	k2VisWWV4kfEv8iEDaVZ9f3WLkSp2+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708706474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAyabS4dUGUNPXWjy9UPvrWPskMGtOkshIYfRSgL3r4=;
	b=/IAv2tlZQXeHlX8AvgRpFW90Y8zTqTp+M16BU90+qscDZ19GX75hEQz7EnCevERr7GRmoz
	AMXLtvg1UmB9O3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 527E2133DC;
	Fri, 23 Feb 2024 16:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ayq0E6rK2GWUNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 16:41:14 +0000
Message-ID: <beb2b051-af97-4a6a-864c-e2c03cd8f624@suse.cz>
Date: Fri, 23 Feb 2024 17:41:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>,
 "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
 <ZdZBN_K8yJTVIbtC@P9FQF9L96D.corp.robot.car>
 <CO1PR11MB51854DA6F03753F12A540293EC562@CO1PR11MB5185.namprd11.prod.outlook.com>
 <7e27b853-e10f-4034-bc81-2d5e5a03361a@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <7e27b853-e10f-4034-bc81-2d5e5a03361a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eRPkpehn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/IAv2tlZ"
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLycmwa99sdzp837p77658kns5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 BAYES_HAM(-3.00)[100.00%];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,arm.com,huawei.com,kvack.org,vger.kernel.org,googlegroups.com,goodmis.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A59421FB4
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 2/22/24 03:32, Chengming Zhou wrote:
> On 2024/2/22 09:10, Song, Xiongwei wrote:
>> Hi Vlastimil,
>> 
>>> On Tue, Feb 20, 2024 at 05:58:25PM +0100, Vlastimil Babka wrote:
>>> 0;95;0c> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>>>> removed.  SLUB instead relies on the page allocator's NUMA policies.
>>>> Change the flag's value to 0 to free up the value it had, and mark it
>>>> for full removal once all users are gone.
>>>>
>>>> Reported-by: Steven Rostedt <rostedt@goodmis.org>
>>>> Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>
>>> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>>>
>>> Do you plan to follow up with a patch series removing all usages?
>> 
>> If you are not available with it, I can do.
> 
> Actually, I have done it yesterday. Sorry, I just forgot this task. :)
> 
> I plan to send out it after this series merged in the slab branch. And
> I'm wondering is it better to put all diffs in one huge patch or split
> every diff to each patch?

I'd suggest you do a patch per subsystem (mostly different filesystems) and
send them out to respective maintainers to pick in their trees. I've talked
to David from btrfs and he suggested this way.

You don't need to wait for this series to be merged. The flag is already a
no-op as of 6.8-rc1. Also I'd suggest sending the patches individually. In a
series they wouldn't depend on each other anyway, and you would either have
to Cc maintainers separately per patch of the series, or everyone on
everything, and there would always be somebody who would prefer the other
way that you pick.

> Thanks!



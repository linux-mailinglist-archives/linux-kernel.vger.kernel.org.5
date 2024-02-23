Return-Path: <linux-kernel+bounces-78749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B219A86183D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C591F23EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809884FA6;
	Fri, 23 Feb 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0ENLgm3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqf1noHa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0ENLgm3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqf1noHa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912B12838F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706556; cv=none; b=uOrarbrt7N2cAFTvx0GqBYdrdP1hKrNgdzBw7rCy4pS3Z0txjL/MzZo9YgBRmZB8tKs3dJgFAVtLSxnY4xCXMtSaae35M7tjqCJBswv8hT+KcWUnWhVkzpTh3DNTgwU4zBW9FFhsODlD+SKekNTvicZgiUZDflI/4eOxK+vU6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706556; c=relaxed/simple;
	bh=lYsVMJERJhvZE4jmpUqSAbs+W+UI8cO7lAplPHyIyFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecudEMhoTib/Uc2ND8YlzNsPNIMFml7ceRMSnMqet3ZP/TzMcbIhikhO17qWoRNn/mY8hpX7UGoZ6k7E3ikAGjr5EIwCEhulYsDu8khj6b9h9TaebhJVmJOy1/cnxzhD1lvY3pcXeFCqUnnBunnwrVooZ8X1i+fBtkVglkGE8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0ENLgm3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqf1noHa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0ENLgm3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqf1noHa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7706421FB5;
	Fri, 23 Feb 2024 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708706552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFNMZIie6l19aBPMWRYEEnQsnBcUocAqPJ4rC3B7ytY=;
	b=B0ENLgm37c4QgheVXQWeRnAwR3WJS6MDYsvcQzrFclBddWdvDFGT8290voIijVLfoVdBcj
	d4LEOJBHdDt3iCFFEuv7NfpymJctXz/uDVzAYWrWfmcbfVbW9ucJCRZdXNPpgy+iwanlYx
	wgM+3VTnyQMmbWPZ6wa76W9E9ysThis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708706552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFNMZIie6l19aBPMWRYEEnQsnBcUocAqPJ4rC3B7ytY=;
	b=jqf1noHamoZfUX1sMsxHWVltkIU7bGem5pt5ygmMoJc27fVq8w7v3/1eyNBE07LqOFgrKA
	Kmi5/+XBCJloceAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708706552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFNMZIie6l19aBPMWRYEEnQsnBcUocAqPJ4rC3B7ytY=;
	b=B0ENLgm37c4QgheVXQWeRnAwR3WJS6MDYsvcQzrFclBddWdvDFGT8290voIijVLfoVdBcj
	d4LEOJBHdDt3iCFFEuv7NfpymJctXz/uDVzAYWrWfmcbfVbW9ucJCRZdXNPpgy+iwanlYx
	wgM+3VTnyQMmbWPZ6wa76W9E9ysThis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708706552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFNMZIie6l19aBPMWRYEEnQsnBcUocAqPJ4rC3B7ytY=;
	b=jqf1noHamoZfUX1sMsxHWVltkIU7bGem5pt5ygmMoJc27fVq8w7v3/1eyNBE07LqOFgrKA
	Kmi5/+XBCJloceAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 443D6133DC;
	Fri, 23 Feb 2024 16:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YCWsD/jK2GWUNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 16:42:32 +0000
Message-ID: <0a30e148-2698-44d5-83c9-da102c0ba753@suse.cz>
Date: Fri, 23 Feb 2024 17:42:32 +0100
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
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Xiongwei Song <xiongwei.song@windriver.com>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
 <ZdZCDEFX4_UuHSWR@P9FQF9L96D.corp.robot.car>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZdZCDEFX4_UuHSWR@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B0ENLgm3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jqf1noHa
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.11 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLycmwa99sdzp837p77658kns5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.11)[66.23%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,arm.com,huawei.com,windriver.com,linux.dev,kvack.org,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.11
X-Rspamd-Queue-Id: 7706421FB5
X-Spam-Flag: NO

On 2/21/24 19:33, Roman Gushchin wrote:
> On Tue, Feb 20, 2024 at 05:58:26PM +0100, Vlastimil Babka wrote:
>> The values of SLAB_ cache creation flagsare defined by hand, which is
>> tedious and error-prone. Use an enum to assign the bit number and a
>> __SF_BIT() macro to #define the final flags.
>> 
>> This renumbers the flag values, which is OK as they are only used
>> internally.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> +#define __SF_BIT(nr)	((slab_flags_t __force)(1U << (nr)))
> 
> I'd rename it to (__)SLAB_FLAG_BIT(), as SF is a bit cryptic, but not a strong
> preference. Otherwise looks really good to me, nice cleanup.

OK, it's also less likely that somebody would collide it.

> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks!



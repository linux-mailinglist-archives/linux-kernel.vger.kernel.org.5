Return-Path: <linux-kernel+bounces-66702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1964285605F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CC6288671
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E092F12BF15;
	Thu, 15 Feb 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KI35Qn12";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQCiYYIe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KI35Qn12";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQCiYYIe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28A12BEAB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993807; cv=none; b=Z4G35hkB5rIsCUIHKY4xDrdSGh6J/LmXSUakQm/nsMZAHOcuq0AJEaAJ9eQ68kiHEeViwtftg94r7pIZy1SSGYURMfdQ9ITiFp3++cTgW23qy3NxeGJDiybu5jnVr53rXeXPDTB0xZPbu3QmdKnlb5tUatlhveknrKFVNVVqiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993807; c=relaxed/simple;
	bh=aFSQulMeyo4/QHvqW8B8dxT0k+X9xP+M+5qjKcwSajc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOyD3vrKTgdJyYQe1qkNZyq9U7p6/R+SF+mMxlG0n2qh1qbq38UkIlJJgnhNwnN4bmC2atbP/jbqddgOJozUwEkmybM9/zRz7ZwivJir5UCQI1U+uxD7Aa/DmZ7ZqGf4HlCpCqLROqSPwbTuZPoWrFWpoFoUNlMELqKLmNewALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KI35Qn12; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQCiYYIe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KI35Qn12; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQCiYYIe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84EE51F88B;
	Thu, 15 Feb 2024 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707993796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=288n+FGoThYvjHnUnq89Nh/a/z6Cws0UYcrsQ/yco4Q=;
	b=KI35Qn12481Ln2ZZewWVpteK+lENtR7HPTOvfza89bRj6j53RQX9gYenYbtICoge+38xZL
	hK4VHT0LebTZFw+9i9B9HBaSg8DwPyUCWdNsx+2gftIp1Li0Ol3HbANb1LJSvOE8TyBQpq
	HnE8KTLqXTc2Y9PNmtouYP1b1/nWU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707993796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=288n+FGoThYvjHnUnq89Nh/a/z6Cws0UYcrsQ/yco4Q=;
	b=KQCiYYIeIn7g+piswyKNBgJa6zCseAbyyqGnxoPfw+mpeWbD0So/Ul19mqgWiS49p37Sgc
	c4C3CUhLOUXCt7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707993796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=288n+FGoThYvjHnUnq89Nh/a/z6Cws0UYcrsQ/yco4Q=;
	b=KI35Qn12481Ln2ZZewWVpteK+lENtR7HPTOvfza89bRj6j53RQX9gYenYbtICoge+38xZL
	hK4VHT0LebTZFw+9i9B9HBaSg8DwPyUCWdNsx+2gftIp1Li0Ol3HbANb1LJSvOE8TyBQpq
	HnE8KTLqXTc2Y9PNmtouYP1b1/nWU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707993796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=288n+FGoThYvjHnUnq89Nh/a/z6Cws0UYcrsQ/yco4Q=;
	b=KQCiYYIeIn7g+piswyKNBgJa6zCseAbyyqGnxoPfw+mpeWbD0So/Ul19mqgWiS49p37Sgc
	c4C3CUhLOUXCt7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D0D713A53;
	Thu, 15 Feb 2024 10:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xmfcGcTqzWW9LQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 10:43:16 +0000
Message-ID: <a5242c82-8373-44ee-b1af-ba98de5075f4@suse.cz>
Date: Thu, 15 Feb 2024 11:43:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] lib/stackdepot: Move stack_record struct
 definition into the header
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-3-osalvador@suse.de>
 <CANpmjNPypJM5icG9M5yP5-psSofbA7D35eaKx+E6NyCsHMa=qg@mail.gmail.com>
 <a310c3cf-049d-4067-b950-f6abf9b5b098@suse.cz>
 <CANpmjNOgiqcXx1T=-W6QL6RuYsZSLOdSjGH9iLVJru_3=15Bnw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNOgiqcXx1T=-W6QL6RuYsZSLOdSjGH9iLVJru_3=15Bnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KI35Qn12;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KQCiYYIe
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[suse.de,linux-foundation.org,vger.kernel.org,kvack.org,suse.com,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 84EE51F88B
X-Spam-Flag: NO

On 2/15/24 10:33, Marco Elver wrote:
> On Thu, 15 Feb 2024 at 10:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 2/15/24 09:16, Marco Elver wrote:
>> > On Wed, 14 Feb 2024 at 18:00, Oscar Salvador <osalvador@suse.de> wrote:
>> >>
>> >> In order to move the heavy lifting into page_owner code, this one
>> >> needs to have access to the stack_record structure, which right now
>> >> sits in lib/stackdepot.c.
>> >> Move it to the stackdepot.h header so page_owner can access
>> >> stack_record's struct fields.
>> >>
>> >> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> >> Reviewed-by: Marco Elver <elver@google.com>
>> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> >> ---
>>
>> >>  #define DEPOT_POOLS_CAP 8192
>> >> -/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
>> >> +/* The pool_index is offset by 1 so the first record does not have a 0 handle */
>> >
>> > Why this comment change? We lost the '.' -- for future reference, it'd
>> > be good to ensure unnecessary changes don't creep into the diff. This
>> > is just nitpicking,
>>
>> Agree with this part.
>>
>> > and I've already reviewed this change, so no need
>> > to send a v+1.
>>
>> But confused by this remark. There is a number of nontrivial changes in the
>> series from v8, and IIRC v8 was dropped from mm/ meanwhile, so a v+1 of the
>> whole series is expected and not fixups. Which means including patches that
>> were already reviewed. That's the usual process.
> 
> This is already v9. Of course, still need to look at rest of v9 and if
> there are major changes needed then a v10 is needed.

Ah sorry I misunderstood you completely. What you meant v10 isn't needed for
the missing "." and I thought you were saying v9 already wasn't needed (for
this particular patch).


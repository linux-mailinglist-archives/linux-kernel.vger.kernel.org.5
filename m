Return-Path: <linux-kernel+bounces-66543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8820E855E23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28DC1F211D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACF3175AA;
	Thu, 15 Feb 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nW+x/sC/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0QZXljE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nW+x/sC/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0QZXljE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306017BA0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989427; cv=none; b=nxJn9ZClZhoVaki1prnMeIkARLOorsFnOHEdZN709L9YXE5oy+jANjzcMKAVeBmgJRMXumcIQWKrT6ZGCTAiEBueD8yo342MwEUMbEGXMRqac0VK/M93l/vEd03ryWl0ElwYXfy3TD/h/EqMcGQue2Ov3S32X9AIzrjLEkTGodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989427; c=relaxed/simple;
	bh=4ILdyWdSvMLol8jxdDnLSvgHKrBM8vPf4GNHm0JWmpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jygs+fjAUmpNFvygwQ+nicfKgo2KKLFI1RUobpomgoYov8t7GK47tf8bIfDoEMOjfaSkpX24FBMehCXcRG+3RbCIXhkWxbHN2hrRmK+97URzpF9wJikCuwvzEXt7Ao3Kpw6SOxytC4uqXFkR5lV4oEiAtCaJBA7iteWBTU8qor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nW+x/sC/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0QZXljE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nW+x/sC/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0QZXljE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71D2321E6F;
	Thu, 15 Feb 2024 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItpbHQ3bDK2Ms6tbFLF9ssZWlzu3EH1B6fIwNh9aF2g=;
	b=nW+x/sC/btYdct1t+azeY4/OpFnHWcucp0cgCJ2BLeUqzyr8hp0XmcLLB4ICd8idTcZF8S
	lN9ro9mvNHm6mB/F09T5I/WtxRdtRCGh9AzG5105vs3BEU5xdimOCY7sr0LXCDsYgtKtA/
	KsJUoE0CDxvZOkGBP+UUpQGPvI4qitA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItpbHQ3bDK2Ms6tbFLF9ssZWlzu3EH1B6fIwNh9aF2g=;
	b=a0QZXljEiEzIKftYOPfeA0eKZuqWdDB8QuQmlg/PREAHzYbs/k+HNi9VLqLj5quCxNGJTe
	A9VAUoFRXnXb+xBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItpbHQ3bDK2Ms6tbFLF9ssZWlzu3EH1B6fIwNh9aF2g=;
	b=nW+x/sC/btYdct1t+azeY4/OpFnHWcucp0cgCJ2BLeUqzyr8hp0XmcLLB4ICd8idTcZF8S
	lN9ro9mvNHm6mB/F09T5I/WtxRdtRCGh9AzG5105vs3BEU5xdimOCY7sr0LXCDsYgtKtA/
	KsJUoE0CDxvZOkGBP+UUpQGPvI4qitA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItpbHQ3bDK2Ms6tbFLF9ssZWlzu3EH1B6fIwNh9aF2g=;
	b=a0QZXljEiEzIKftYOPfeA0eKZuqWdDB8QuQmlg/PREAHzYbs/k+HNi9VLqLj5quCxNGJTe
	A9VAUoFRXnXb+xBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D7DB13A82;
	Thu, 15 Feb 2024 09:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y8SAFq/ZzWUxGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 09:30:23 +0000
Message-ID: <a310c3cf-049d-4067-b950-f6abf9b5b098@suse.cz>
Date: Thu, 15 Feb 2024 10:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] lib/stackdepot: Move stack_record struct
 definition into the header
To: Marco Elver <elver@google.com>, Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-3-osalvador@suse.de>
 <CANpmjNPypJM5icG9M5yP5-psSofbA7D35eaKx+E6NyCsHMa=qg@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNPypJM5icG9M5yP5-psSofbA7D35eaKx+E6NyCsHMa=qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.59
X-Spamd-Result: default: False [-2.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-1.30)[90.07%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/15/24 09:16, Marco Elver wrote:
> On Wed, 14 Feb 2024 at 18:00, Oscar Salvador <osalvador@suse.de> wrote:
>>
>> In order to move the heavy lifting into page_owner code, this one
>> needs to have access to the stack_record structure, which right now
>> sits in lib/stackdepot.c.
>> Move it to the stackdepot.h header so page_owner can access
>> stack_record's struct fields.
>>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: Marco Elver <elver@google.com>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> ---

>>  #define DEPOT_POOLS_CAP 8192
>> -/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
>> +/* The pool_index is offset by 1 so the first record does not have a 0 handle */
> 
> Why this comment change? We lost the '.' -- for future reference, it'd
> be good to ensure unnecessary changes don't creep into the diff. This
> is just nitpicking, 

Agree with this part.

> and I've already reviewed this change, so no need
> to send a v+1.

But confused by this remark. There is a number of nontrivial changes in the
series from v8, and IIRC v8 was dropped from mm/ meanwhile, so a v+1 of the
whole series is expected and not fixups. Which means including patches that
were already reviewed. That's the usual process.


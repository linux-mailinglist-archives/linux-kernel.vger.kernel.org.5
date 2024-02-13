Return-Path: <linux-kernel+bounces-63734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF908533CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C01F2CD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB4F5EE88;
	Tue, 13 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DiHQcjrL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+mPykfoK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DiHQcjrL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+mPykfoK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723ED5B05E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836178; cv=none; b=spRFr11AskJZim+koaoQRuA0gcyAWlh36E3f5RQy52J4zQD5kY5ptPZLujpIYfB9xnMjwaYRr8JG6Ds/7o1UmOWDuminUWwKK68Zk1f8fUDayRnbP3UPtb12xQ+FnjbH4ZKfMK2u2Kc/UPZXL1nPPFQqxEsHQ+lp7dznhz2JUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836178; c=relaxed/simple;
	bh=HKtresPiT6cFIZNqHkF0PAC254gqBTnOeejLfEvIDK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYYfSEaAbiBOHsA7lIEm8PtA5FPKzdckNkMWVwSTBVYKVO7/M3aO1Ay4/HkTDiyrfS2iMpmwH9MlTqIj+Xiqnq9W+SHuG0aigczOgiVjRfptK8bdpkY4HJMIpAbZjPPy0IveT8tVzxpCk3KNT28x4dxaK9LZ5PdEdt6CEWAm7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DiHQcjrL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+mPykfoK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DiHQcjrL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+mPykfoK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE9F02119E;
	Tue, 13 Feb 2024 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707836174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1g8t9w8mOs8leh8n6Zjz85Vov4skANTzgCxAT47VW0=;
	b=DiHQcjrLMK4mx/z9/bYB1uFVaOrPXM8EddspOekZxMPHk2kaJdCL0HK/Qe2XZO9QP5ljq9
	TereFf2D89nesaacLczgf9TuVDR/GHgWiovoUgePENsL7y7MzrPMBCo88dKA2HKN/VlEKU
	nuPn0/kwSaeBL2EGdiFrN1FEI6FQhYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707836174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1g8t9w8mOs8leh8n6Zjz85Vov4skANTzgCxAT47VW0=;
	b=+mPykfoKC8L5Bcg7+bmgSCgnijof1TmVnYhh55toN4x7bECyoMYK31BfGyVW85Zi4k25SW
	B7AShECFZo0afEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707836174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1g8t9w8mOs8leh8n6Zjz85Vov4skANTzgCxAT47VW0=;
	b=DiHQcjrLMK4mx/z9/bYB1uFVaOrPXM8EddspOekZxMPHk2kaJdCL0HK/Qe2XZO9QP5ljq9
	TereFf2D89nesaacLczgf9TuVDR/GHgWiovoUgePENsL7y7MzrPMBCo88dKA2HKN/VlEKU
	nuPn0/kwSaeBL2EGdiFrN1FEI6FQhYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707836174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1g8t9w8mOs8leh8n6Zjz85Vov4skANTzgCxAT47VW0=;
	b=+mPykfoKC8L5Bcg7+bmgSCgnijof1TmVnYhh55toN4x7bECyoMYK31BfGyVW85Zi4k25SW
	B7AShECFZo0afEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C9C513404;
	Tue, 13 Feb 2024 14:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JnqJQ6Dy2WSMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Feb 2024 14:56:14 +0000
Message-ID: <25f8fa78-53e1-4b53-a70b-6b758d671452@suse.cz>
Date: Tue, 13 Feb 2024 15:56:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] mm,page_owner: Filter out stacks by a threshold
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>, Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-5-osalvador@suse.de>
 <CANpmjNNWv1eDL5MQXtdXnsV=sCp_8MC11xBAgsNt_1K-V30H8Q@mail.gmail.com>
 <Zcs0ruHxL9YOsKN_@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Zcs0ruHxL9YOsKN_@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.85
X-Spamd-Result: default: False [-6.85 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-1.56)[92.14%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On 2/13/24 10:21, Oscar Salvador wrote:
> On Tue, Feb 13, 2024 at 09:44:47AM +0100, Marco Elver wrote:
>> On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de>
>> wrote:
>>> +       debugfs_create_file("set_threshold", 0600, dir, NULL, +
>>> &proc_page_owner_threshold);
>> 
>> Can't you also read from "set_threshold", so the name "set_threshold" 
>> is misleading. Why not just "threshold"?
> 
> Yes, it can also be read. I guess I was too focused on the set part.

Maybe name it "count_threshold" so it's more clear of whate exactly it's the
threshold of?

> I will rename that one, plus add the {READ,WRITE}_ONCE.
> 
> Thanks!
> 



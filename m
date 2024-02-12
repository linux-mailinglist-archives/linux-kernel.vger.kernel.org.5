Return-Path: <linux-kernel+bounces-61371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED785117C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843EF2872CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382133A1AA;
	Mon, 12 Feb 2024 10:47:06 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525C3A1A3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734825; cv=none; b=SL4grVD/+fd73Lh4HC15ZnzJtK8+b5YGov7GRdy0MChqiyicd6KCTdssvpWJoziYhS7liAhHs9tLfl1/yD5UqsYF8sYFhtFgSl1qsU+g3mqvvIhS9EKi7rmQjS4rlCnBrA0mfXW5aR/A9faUuL/gDhiBrGVq/7Ts4k+yIhVkWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734825; c=relaxed/simple;
	bh=jGnr0+O9DZqdVBEJOnvpErLfdj7poycde5lERZ7vgRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ixrw7QyZFb5AdZRrtqkFRE/awdbGQD5jZP2Yg9Fpze3NjZWCHUPacgjqjNVQqcmEQegDWjlgnQDmmryNzaoMLeIfnGYHE932PYYQPt7OJ0COUWLZ3d/99GeDVXOvmsqumI4ph5TJZx7LvMM3pcdoiiYxTpXNqhyzdCYGj7Yyw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5460022150;
	Mon, 12 Feb 2024 10:47:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C54612FF7;
	Mon, 12 Feb 2024 10:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SjwPDib3yWUUGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Feb 2024 10:47:02 +0000
Message-ID: <9081f1ca-825e-4285-9b22-854d265e3af3@suse.cz>
Date: Mon, 12 Feb 2024 11:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>, Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208234539.19113-4-osalvador@suse.de>
 <CANpmjNNcPr=pPco_HN9nXBabubtfo02SAH=taZGNCvYDq42YUQ@mail.gmail.com>
 <ZcaesCP4mY-94ciJ@localhost.localdomain>
 <ZcaxxQE1PkepEWwf@localhost.localdomain>
 <CANpmjNOpfdgMT1jNPJev_e6tecZjGn4n8Sk6aoaLVDsqfJgmKg@mail.gmail.com>
 <ZckwfAk3rAWU0Jg-@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZckwfAk3rAWU0Jg-@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 5460022150
X-Spam-Flag: NO

On 2/11/24 21:39, Oscar Salvador wrote:
> On Sat, Feb 10, 2024 at 08:52:25AM +0100, Marco Elver wrote:
>> The extra bits are used by KMSAN, and might conflict if enabled at the
>> same time. I think the safest option is to keep your own list. I think
>> that will also be more performant if there are other stackdepot users
>> because you do not have to traverse any of the other entries.
> 
> Ok, I thought we had spare bits for other users.
> But thinking about it some more, yes, it makes sense for page_owner to
> maintain its own list, so traversing it is faster and we do not have
> to place code to traverse the buckets in stackdepot.

Would it make sense to introduce per-user stack depot instances? ("user"
being a subsystem i.e. kasan or page_owner). I'd expect each to have a
distinct set of stacks, so there's no benefits of using the same hash table,
only downsides of longer collision lists?

I can imagine this would be easier for users that don't need the early init
kind of stackdepot, but maybe even there it could be feasible to have a
small fixed size array of hash table roots and every user would get a
separate index?


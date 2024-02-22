Return-Path: <linux-kernel+bounces-77387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB128604A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBF81C22C91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F073F26;
	Thu, 22 Feb 2024 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTH7S3Pa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="klL58VXW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTH7S3Pa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="klL58VXW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6914B832;
	Thu, 22 Feb 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636796; cv=none; b=thjx5Drd4ZrlytC5DLcSBhsGnu7Ixzh9kLrlIKBPhWYW0GvHJW3ZDcKEXJV8wblrI8ov9rCbMoM43pVZYjbrehLsbarLlQr3ZzIevd5jco0CUb1MOlpKJnXj1Aw/6vll4Wwcugu+SjCgu/rcsqJWYZN95ohZfHQns+XXR+Va8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636796; c=relaxed/simple;
	bh=a0WLqrpp2l3G1FiWSHQkOMJyuTQ+z8ar0GIz5jZCnIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hjwGq3R/Hxb8hT7XkOfDn/9mgElaj1L/4HmyMsN2mi0sKUapQSMHfKgna0vHVSvsEKKZJFMNuwaHI9NYmkhdow+t22bbSOJMi6M9f9rI6AaoUAukyBHEeaUb60hW33OXiKkiwQhMl/cBgdDBHdiN+htDh4/TK2LdPNG4v2GJ/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTH7S3Pa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=klL58VXW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTH7S3Pa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=klL58VXW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F4231FBB6;
	Thu, 22 Feb 2024 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708636792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmwy2si2pJ2mNU0MlM/z5AaEWl08Athx/4vltay9xWM=;
	b=nTH7S3PanwNm0vSUAJGfofhoWbap77NuQWPXpHbQ1p7+vVMIlw2H6L+4fv8xNbT/5bIVRP
	/phzpnBch87802xFXGhA3UOKXzuh7SlC2vBUXS0vISLNPddWML0M4zO+Gz7M2RIoHO02DM
	haUdYTIkowYrr+g/xV3yoByT2O9W+8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708636792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmwy2si2pJ2mNU0MlM/z5AaEWl08Athx/4vltay9xWM=;
	b=klL58VXW0qULmuuzYQPKnVJUsqc30dJTQ/BQnFmCOK6IyMR2r2OHG7tTqCzhoo6DGh+Dxd
	LyCGHxjDZeogT/Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708636792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmwy2si2pJ2mNU0MlM/z5AaEWl08Athx/4vltay9xWM=;
	b=nTH7S3PanwNm0vSUAJGfofhoWbap77NuQWPXpHbQ1p7+vVMIlw2H6L+4fv8xNbT/5bIVRP
	/phzpnBch87802xFXGhA3UOKXzuh7SlC2vBUXS0vISLNPddWML0M4zO+Gz7M2RIoHO02DM
	haUdYTIkowYrr+g/xV3yoByT2O9W+8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708636792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmwy2si2pJ2mNU0MlM/z5AaEWl08Athx/4vltay9xWM=;
	b=klL58VXW0qULmuuzYQPKnVJUsqc30dJTQ/BQnFmCOK6IyMR2r2OHG7tTqCzhoo6DGh+Dxd
	LyCGHxjDZeogT/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A69513A8C;
	Thu, 22 Feb 2024 21:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GnyhHHi612WzKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 22 Feb 2024 21:19:52 +0000
Message-ID: <18565605-7f68-4950-b66f-496c1f3c393b@suse.cz>
Date: Thu, 22 Feb 2024 22:19:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, mmap: fix vma_merge() case 7 with vma_ops->close
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
 Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
References: <20240222165549.32753-2-vbabka@suse.cz>
 <20240222185642.rmnp76oquu5wfo6c@revolver>
 <20240222192746.cb65qvtmhaikfeko@revolver>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240222192746.cb65qvtmhaikfeko@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nTH7S3Pa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=klL58VXW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[Oracle.com,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,suse.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 9F4231FBB6
X-Spam-Flag: NO

On 2/22/24 20:27, Liam R. Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [240222 13:56]:
>> * Vlastimil Babka <vbabka@suse.cz> [240222 11:56]:
>> This separates the check for potentially merging previous to a later
>> failure case.  Would it be better to check:
>> 	if (curr && curr->vm_ops && curr->vm_ops->close)
>> 
>> and not set merge_prev = true, ie we cannot merge with the predecessor?

Good suggestion, thanks!

>> That way we would exit as merge_prev == false.
>> 
>> We would have the added benefit of not having to look at merge_prev &
>> merge_next case with this vm_ops->close in mind (case 1 and 6).. because
>> I'm pretty sure we can currently get to case 6 in this way:
>> 
>> merge_prev = true
>> check for merge_next.. can_vma_merge_before(next...);
>> is_mergeable_vma(next.... , true);
>> if (true && next->vm_ops && next->vm_ops->close) /* Fine for next.. */
>> 
>> Remove curr by case 6 without checking curr->vm_ops &&
>> curr->vm_ops->close
>> 
>> If I am correct, then are we blaming the right commit?

It was bisected with no nondeterminism in the test, so yeah.

> I am not correct.
> The file check will ensure the same ops, so the file and ops must match.
> As long as both are checked on one VMA then it will work as required.

Right, otherwise we would have bigger issues even before the buggy commit,
we were never checking curr's vma_ops before.

>> 
>> Perhaps we should just fail earlier when we find a curr with the close
>> ops?
> 
> I'd rather fail earlier, but it's not a big deal.

Your suggestion will indeed result in a nicer and more obvious code, so will
do, thanks!

>> 
>> >  			} else {			/* case 5 */
>> > +				err = dup_anon_vma(prev, curr, &anon_dup);
>> >  				adjust = curr;
>> >  				adj_start = (end - curr->vm_start);
>> >  			}
>> > -- 
>> > 2.43.1
>> > 



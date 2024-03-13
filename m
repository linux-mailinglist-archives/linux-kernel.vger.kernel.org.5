Return-Path: <linux-kernel+bounces-101279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E5587A4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A070D1C21949
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42720313;
	Wed, 13 Mar 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQD8gXkg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83aRbC3B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QcDcfomP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R3f1pvkU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26811D53F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322078; cv=none; b=CUh5zV7IRVDIDrv6v2dicgq5PLXGGB4HRNUh37LhZS6sBGg0pz9PXjYeo2PISWAOHaYSc/niT0swBLKbcPfr+sIatRBXSxOAWCbpHh4zwICoutbbKOWUoqyZKRaBt7UgUYURbp21rt0mndEMFs0Ar/uzlZMnTqtVmb5dDTLUoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322078; c=relaxed/simple;
	bh=ChtvqZSV/GDTm2swlFe2KXFB8b6Bn3ktu6XhPTvkP90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmnR8HwSyTiJyom+AETrhK/1L6+CHY8cHxYSv9cpCSaEe+PF10ZjG1WHv4Pt2P/ESazplzzWP3BJrdheQlnbgElJgtHOJ8dVcDRJxkS81wUx6iiZnrwO6zk1sU4cwL6WcE8M6hij21uHyH+C0urMUqIEb4MC9nMHZRIoFoGdlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQD8gXkg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=83aRbC3B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QcDcfomP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R3f1pvkU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E15B421C4A;
	Wed, 13 Mar 2024 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710322075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx2Kyk0SeWQkpTeiwcrKDHoVpXu3gJUOIFIE++sH4jM=;
	b=IQD8gXkghWN3jyp4yhEJh+YkQYcjIQKvF/+cdex+FHUh9NqQQnIt3qJYsoDeLpDdP62hx8
	8DzizJ7wW/jGDUJRM/F9AmPh73RSKyeoSsYrQ8UZ7zx7Cpt7MtTxOww1FsA4e/I95+IRx4
	Uut4xkcAw0Glg7FLk+M/Ik8MP/wY4E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710322075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx2Kyk0SeWQkpTeiwcrKDHoVpXu3gJUOIFIE++sH4jM=;
	b=83aRbC3BTHOul7pZvX+LU/XoH5lNTluY51bLuMUHjPyz3pYtTyASuU7KPenAcD2Qqz7QKH
	0VW4YhyaRbKHQNDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710322074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx2Kyk0SeWQkpTeiwcrKDHoVpXu3gJUOIFIE++sH4jM=;
	b=QcDcfomPfFa1MiKGd8h/cW/hJ8Wy4w7qMO2V3PNmca7JXLxsabyVkLEjpVqGUCpnpIfM2q
	FcqZL0jhFeRpmW9jr/Ip0r5sPOsueCu8tZD3ZOl8X55bvjjRW/wykAmvIPWNhXjpStoJ3V
	5SmfZ+qt2D5gk0UmMusJDzXwieaIrDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710322074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx2Kyk0SeWQkpTeiwcrKDHoVpXu3gJUOIFIE++sH4jM=;
	b=R3f1pvkUe1JbTlfUpBFhzSpMd8lJ/Cef6DjHnPlccvjdqwlOA0//Irs94EZHl6dw+fXrJn
	nMmHO//F4w2rTrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D16AC1397F;
	Wed, 13 Mar 2024 09:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kEfxMppx8WWEdQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Mar 2024 09:27:54 +0000
Message-ID: <97982cbd-a329-4630-89fb-e96e2e3f855f@suse.cz>
Date: Wed, 13 Mar 2024 10:28:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] slab updates for 6.9
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Xiongwei Song <xiongwei.song@windriver.com>
References: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
 <CAHk-=wiFUvms3x7BC1R_4-t80K3O_XTOW3BKp6nPL_FkFSPzzQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=wiFUvms3x7BC1R_4-t80K3O_XTOW3BKp6nPL_FkFSPzzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QcDcfomP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R3f1pvkU
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.81 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-1.81)[93.85%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[google.com,lge.com,linux.com,kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,lists.linux.dev,linux.dev,gmail.com,windriver.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.81
X-Rspamd-Queue-Id: E15B421C4A
X-Spam-Flag: NO



On 3/13/24 04:54, Linus Torvalds wrote:
> On Tue, 12 Mar 2024 at 02:55, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>>       Also deprecate SLAB_MEM_SPREAD which was only
>>   used by SLAB, so it's a no-op since SLAB removal. Assign it an explicit zero
>>   value.  The removals of the flag usage are handled independently in the
>>   respective subsystems, with a final removal of any leftover usage planned
>>   for the next release.
> 
> I already had the patch ready to go:
> 
>     https://lore.kernel.org/all/CAHk-=wji0u+OOtmAOD-5JV3SXcRJF___k_+8XNKmak0yd5vW1Q@mail.gmail.com/

Aha, missed that thread.

> so I just did a "git stash apply" and got rid of the final stragglers.
> No need to have various random maintainers have to worry about a flag
> that hasn't had any meaning since 6.7, and very little before that
> either.

Noted, thanks a lot.

>               Linus


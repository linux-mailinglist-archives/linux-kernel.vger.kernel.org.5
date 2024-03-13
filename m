Return-Path: <linux-kernel+bounces-101112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4DC87A295
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB64F1C21A66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D97125CF;
	Wed, 13 Mar 2024 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PyEjcNRn"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF01170A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710306659; cv=none; b=KBz+qw2szL3k0B962Y4EA1ArPU/WCMg1rCzrE1mm25BQYfYmclxksLwMC91O23K1+Z61fiegDJ7AaNgiStQTHUcJd7Ywa5Zd9z0pvsdT3u7smFcnBqOHGO8vT6toOT2vLfHDWomvKj+8ttda8MXemWeiVnpZXEQEaAJBSm0+Pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710306659; c=relaxed/simple;
	bh=wewy7uaRPeiTZxNNUz+7Jc43Bc5c/R4w0IVXzPUj4qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASvulLiOztFJ4iRu/BfN4dms7lcyXQyg7Dc93tp/i1uU71XLy2Z7aWFKOjIia7rv8BnX0E0ICPSEMvS1N0VV+BSgEBQBZ0J5LexQzxYRu0w2vyEuJINFtDHktdcg0elW8BvlVtIjvcj2FvjJ/NQD7agqG2MBfGxYOYTs+gzD1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PyEjcNRn; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15e3cf4e-f8d3-4706-b667-2575659b5552@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710306655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KYgfvIsMcO/TmdlLE/KJZBk82wNlhv38pmZ/YdZGdw=;
	b=PyEjcNRnemsMncI1JJwbShz3Q5spPyB8OWIoT1y9FU+GGOPB5XldanrEYgQxmHE+griePS
	7MGZkD5qG2dtZ0GngwEpLdK5bCMqBz+2Hd+6EG9XN5I6OBZFbWAHtr533WS0nqMgp8H/Tn
	QBi09lD4KzjWzBedjn91lpi9qE1TM2s=
Date: Wed, 13 Mar 2024 13:10:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL] slab updates for 6.9
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Xiongwei Song <xiongwei.song@windriver.com>
References: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
 <CAHk-=wiFUvms3x7BC1R_4-t80K3O_XTOW3BKp6nPL_FkFSPzzQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAHk-=wiFUvms3x7BC1R_4-t80K3O_XTOW3BKp6nPL_FkFSPzzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/13 11:54, Linus Torvalds wrote:
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
> 
> so I just did a "git stash apply" and got rid of the final stragglers.
> No need to have various random maintainers have to worry about a flag
> that hasn't had any meaning since 6.7, and very little before that
> either.

Great! It's better. Thanks for doing this.



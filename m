Return-Path: <linux-kernel+bounces-72685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E27285B73A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C312889BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0560C5FDC5;
	Tue, 20 Feb 2024 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NGIS05Sb"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307395FDA6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420996; cv=none; b=rs/hm1aJAxzHZicAqGQaHBD7Hn5EL62rPshV0u1f5yJUmhl2ZardOr9QUZqNahsgQpmhswKvv9DSvUtklbmHxBardHlO0pQqrGD0W2gPookwx8N7Eil8xP/HWjj6UnzV16FxH5PIlnlW3p2/Fyxw9fxXZ3xzOtK+s86xSnX9cfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420996; c=relaxed/simple;
	bh=1GyxVLus3y0Y3z7nhQnZBajXS2dyFfhURG0hJiCFSMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv5xdYc5ndPk533Zef7fthGKMIKRr1Yjq1hb8TKRDXbU5mS0X0qYuqZxUwgBy9isdr9SVMQqwmffWRlQfEtVr69s1kw1DFBdw5zD7TYyV8uMZRlD1lWnfKL0c3StwiM6UcrJb9AMRD7s1koCyaKFusYs4GepbVBRzzM88Yz134A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NGIS05Sb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41K8bhmh3560893
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 20 Feb 2024 00:37:43 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41K8bhmh3560893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1708418264;
	bh=WZhTIkMEDXfBS+v/xlQmW53/Jt7i6xPDZx3y3BeuvW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NGIS05SboiOeG4Y+Hs6laMsl3tN6+kvZTgV33YE/77YlGbTVoNuDeQsG9ZkaO69uX
	 cWKGPQwkj7/L2vA7W21wvEGhMfGnyTVKD2SK7CQgu6HqqA7zGi73DlWD/AP68jRpEW
	 tdLtrPhSunhKn/XdnGOGpDEpzwFN0s34dcNC0Vb9Mx2uEYf36qxosDE/0rofd/LyL/
	 Elk0ivIc4fxlTBY4iNscT6uMQ2b1IO/ss7X/mDhEij+PlQLT38NiSB+0hFRy/v332/
	 Y+mgGcaBh6o+XR8LlAuZQeaP/bGul4cSQCanz5ngT8JMQLQM5XaNioPpv6LvjHmWbX
	 CR8Wsek/z7J0w==
Message-ID: <07d43633-d707-415d-a662-ecd3a50b12ae@zytor.com>
Date: Tue, 20 Feb 2024 00:37:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Cleanup for PAT
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, bp@suse.de, mingo@redhat.com,
        rdunlap@infradead.org, bhelgaas@google.com, linux-mm@kvack.org
References: <20240220034835.507022-1-mawupeng1@huawei.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240220034835.507022-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/2024 7:48 PM, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 

This patch set is all about follow_phys() cleanups, so "Cleanup for PAT"
seems too generic.

> Patch #1 move follow_phys to memtype.c since only pat use this.
> Patch #2 cleanup parameter in follow_phys.
> Patch #3 drop the unnecessary WARN_ON_ONCE if follow_phys fails.

I'm more curious why follow_phys() ended up this way?

follow_phys() was introduced in commit 28b2ee20c7cba ("access_process_vm
device memory infrastructure") in 2008 for getting a physical page address
for a virtual address, and used in generic_access_phys(). And later it's
used in x86 PAT code.

Commit 03668a4debf4f ("mm: use generic follow_pte() in follow_phys()") made
follow_phys() more of a wrapper of follow_pte(), and commit 96667f8a4382d
("mm: Close race in generic_access_phys") replaced follow_phys() with
follow_pte() in generic_access_phys(). And the end result is that
follow_phys() is used in x86 PAT code only.

As follow_phys() in untrack_pfn() can be replaced with follow_pfn(), then
maybe we don't have to keep follow_phys(), and just use follow_pte() in
track_pfn_copy()?

Thanks!
     Xin

> 
> Changelog since v3:
> - rebase to latest linux
> - fix compile warnings
> 
> Changelog since v2:
> - rebase to latest linux
> 
> Changelog since v1:
> - split patch #1 into two patches based on Boris's advise
> 
> Ma Wupeng (3):
>    x86/mm/pat: Move follow_phys to pat-related file
>    x86/mm/pat: Cleanup unused parameter in follow_phys
>    x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails
> 
>   arch/x86/mm/pat/memtype.c | 32 ++++++++++++++++++++++++++------
>   include/linux/mm.h        |  2 --
>   mm/memory.c               | 28 ----------------------------
>   3 files changed, 26 insertions(+), 36 deletions(-)
> 




Return-Path: <linux-kernel+bounces-118763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525488BF05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2977BB255E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7B6CDB7;
	Tue, 26 Mar 2024 10:14:15 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC953809;
	Tue, 26 Mar 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448055; cv=none; b=hqglNoeUnCu8nx2NXZr69OarQXPodpvj/TJ1bqUOnF+0fgibLmedEYua1+8egto8dNcjYnF082xWslFpqeDIBj2IWkxv87VMvxWUp1K8ErfECdUU0NlteRgpFY6QWQF7HAUwGnvl8O12syNpMMUJ0v4KfP2Y0djgrfLeBYt5I/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448055; c=relaxed/simple;
	bh=JGRP3b7RyHt0jY8rO1qj8kXKS7IMTy0Xcjt1MUCQvNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvYBe7HPwUxBvMbJGPDHOO5/2qOTtQch8JpfZk1reG8IXc48f6Ruzx1xuzE7PspTugIanQng3TCv1p8N7P2GbsO9hbcSLfNaSkJgJgEOCf0L+DMtb/wJB+xLNKrd6QEML8fciCdnvyVNnkxVbsVd27K2YuHxp6GMN1Hs6n0rxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42QADk2S086096;
	Tue, 26 Mar 2024 19:13:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 26 Mar 2024 19:13:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42QADk68086093
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 19:13:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <27e443af-398f-4e8b-8b75-b5b172546dfb@I-love.SAKURA.ne.jp>
Date: Tue, 26 Mar 2024 19:13:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] usb-testing boot error: WARNING: refcount bug in
 __reset_page_owner
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
        syzbot <syzbot+73c1dfb19c10b7e49777@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000151f4a06148c0966@google.com>
 <ZgKSfNM3lujt38-R@localhost.localdomain>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZgKSfNM3lujt38-R@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/26 18:16, Oscar Salvador wrote:
> On Tue, Mar 26, 2024 at 01:25:40AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
> ...
>> ------------[ cut here ]------------
>> refcount_t: decrement hit 0; leaking memory.
>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> 
> This is fixed by [1]
> 
> [1] https://lore.kernel.org/linux-mm/20240326063036.6242-1-osalvador@suse.de/
> 
> 

The correct format is shown below.

#syz fix: mm,page_owner: Fix refcount imbalance



Return-Path: <linux-kernel+bounces-148766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0858A871C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5BFB217E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE77146A7D;
	Wed, 17 Apr 2024 15:11:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A31D13959C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366674; cv=none; b=WgKBqiNY7ivRWHVjiJRHhYr1ZQvJ+ixrNF/dSOpnRDsStvnh082V7e32bhh8qMmBCxFGqRRDBzZFnnuBjpb3gsokPSuW0IOnO44IUQ6gPRyAIL1XpFPp0+aMwP+khVZ+eKdGItTVr5qVD2ID3unH5jD1Xgc0bPPqpB9y7azI17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366674; c=relaxed/simple;
	bh=YGwAjQ6Hwll5MFLaD9jsL+3cLXc+yqGURfoQiR/7mW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJgv22ioP3KJtKPpfODHvjujaVCp3NoAjrJLmLfYWUohdZhVauQbiTNycUQJcfQtEc61BKePlXuvQWpjb4TLBqWVY4uYCSUkRcj+Z2akHbs2RB+CSWMCpkI1dRs4baZ58lc5M5kqFnCM3EyG94W3rGWdBGY0846+AwKRAeX1kBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4679B2F;
	Wed, 17 Apr 2024 08:11:40 -0700 (PDT)
Received: from [10.1.37.181] (XHFQ2J9959.cambridge.arm.com [10.1.37.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66D213F738;
	Wed, 17 Apr 2024 08:11:11 -0700 (PDT)
Message-ID: <1f384d41-4c65-4efb-a171-26b54dacfb30@arm.com>
Date: Wed, 17 Apr 2024 16:11:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clang: error: unknown argument '-static-libasan'; did you mean
 '-static-libsan'?
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>, kernel test robot <yujie.liu@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>
References: <202404141807.LgsqXPY5-lkp@intel.com>
 <31b4e05d-62c6-44cd-8038-7ac8d21320c3@arm.com>
 <a5516289-96b6-41f4-8cbb-6c34c7bf7996@app.fastmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a5516289-96b6-41f4-8cbb-6c34c7bf7996@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 15:42, Arnd Bergmann wrote:
> On Tue, Apr 16, 2024, at 16:33, Ryan Roberts wrote:
>> On 16/04/2024 08:42, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
>>> commit: c652df8a4a9d7853fa1100b244024fd6f1a9c18a selftests: link libasan statically for tests with -fsanitize=address
>>> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <yujie.liu@intel.com>
>>> | Closes: https://lore.kernel.org/r/202404141807.LgsqXPY5-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>> # tools/testing/selftests/fchmodat2$ make CC=clang
>>> clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan -isystem usr/include     fchmodat2_test.c  -o tools/testing/selftests/fchmodat2/fchmodat2_test
>>> clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
>>> make: *** [../lib.mk:181: tools/testing/selftests/fchmodat2/fchmodat2_test] Error 1
>>>
>>> # tools/testing/selftests/openat2$ make CC=clang
>>> clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan     openat2_test.c helpers.c helpers.h  -o tools/testing/selftests/openat2/openat2_test
>>> clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
>>> clang: error: cannot specify -o when generating multiple output files
>>> make: *** [../lib.mk:181: tools/testing/selftests/openat2/openat2_test] Error 1
>>>
>>
>> Hi Arnd,
>>
>> This change went in quite a while ago and is on;y just blowing up. I saw your
>> comment in another thread [1] that Andrew merged your change to set -Wextra.
>> Perhaps that's what has caused this to show up only now? *although I don't
>> actually see -Wextra in the command line).
>>
>> I guess the problem is that `-static-libasan` is only supported by gcc. But I'm
>> Makefile-illiterate. Can anyone advise on what's the best way to make this
>> argument gcc-only?
> 
> Thanks for letting me know about the problem, I had indeed missed
> build-testing any of tools/testing, so this might not be
> the only problem there.
> 
> I'm not entirely sure how much of the Kbuild infrastructure we
> can rely on here. If the .config file gets included, this should
> work:

Thanks for the pointers. Unfortunately neither don't works as we don't have any
of the Kbuild infrastructure.

I'm not really sure what to do here. The best I've come up with so far is to
just remove asan from these binaries. They are pretty simple selftests. I'm not
sure its adding a whole lot of value anyway.

Does anyone have any advice?

> 
> --- a/tools/testing/selftests/fchmodat2/Makefile
> +++ b/tools/testing/selftests/fchmodat2/Makefile
> @@ -1,6 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
> +ifdef CONFIG_CC_IS_GCC
> +CFLAGS += -static-libasan
> +else
> +CFLAGS += -static-libsan
> +endif
> +
>  TEST_GEN_PROGS := fchmodat2_test
>  
>  include ../lib.mk
> 
> Alternatively, if the cc-option macro is available, you could
> try this one
> 
> CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan) 
> 
>      Arnd



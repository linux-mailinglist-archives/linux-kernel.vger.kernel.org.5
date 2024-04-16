Return-Path: <linux-kernel+bounces-147024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13B78A6E56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E48D1C22840
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E186C12D771;
	Tue, 16 Apr 2024 14:33:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D112C7E8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277985; cv=none; b=dFhYeWKcLoZLOsv3r6/YJb3TNztPGBCwQEDY/UtrsKa+1mvgqqMRmdDdpogt9kjWu3lrxw7l2BP81zwASYE+xGaE0c7Ym2Xfr6653ajY1KBFPHfOxb/iL3sgC9ot0lcR+Ludma0j+5hCQQtdqDSIlR4CYsXwzNJET5LDK5BDKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277985; c=relaxed/simple;
	bh=l5m29NIiX6i9/9OYQJmF2WeFnvO1SUvcqsKMNMHrFjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT32nPITSt0dz8PxL3RXYJ1FHygCICEsHMgRkNhfs7AUxdrGYQFMTz69DaZb8Zp87gQ5UQ69M2waL9RhHQoW2hHyslws+ZW0XYJKi2JkmGQHfn2cvNZeN+TNZ+BbKOdoyRrHXBYqDfYn+Lj72FpnkuPViMH2h7EqH203fyiOiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A1B339;
	Tue, 16 Apr 2024 07:33:31 -0700 (PDT)
Received: from [10.1.39.189] (XHFQ2J9959.cambridge.arm.com [10.1.39.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07D043F738;
	Tue, 16 Apr 2024 07:33:01 -0700 (PDT)
Message-ID: <31b4e05d-62c6-44cd-8038-7ac8d21320c3@arm.com>
Date: Tue, 16 Apr 2024 15:33:00 +0100
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
To: kernel test robot <yujie.liu@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>
References: <202404141807.LgsqXPY5-lkp@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202404141807.LgsqXPY5-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Arnd

On 16/04/2024 08:42, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
> commit: c652df8a4a9d7853fa1100b244024fd6f1a9c18a selftests: link libasan statically for tests with -fsanitize=address
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Closes: https://lore.kernel.org/r/202404141807.LgsqXPY5-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> # tools/testing/selftests/fchmodat2$ make CC=clang
> clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan -isystem usr/include     fchmodat2_test.c  -o tools/testing/selftests/fchmodat2/fchmodat2_test
> clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
> make: *** [../lib.mk:181: tools/testing/selftests/fchmodat2/fchmodat2_test] Error 1
> 
> # tools/testing/selftests/openat2$ make CC=clang
> clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan     openat2_test.c helpers.c helpers.h  -o tools/testing/selftests/openat2/openat2_test
> clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
> clang: error: cannot specify -o when generating multiple output files
> make: *** [../lib.mk:181: tools/testing/selftests/openat2/openat2_test] Error 1
> 

Hi Arnd,

This change went in quite a while ago and is on;y just blowing up. I saw your
comment in another thread [1] that Andrew merged your change to set -Wextra.
Perhaps that's what has caused this to show up only now? *although I don't
actually see -Wextra in the command line).

I guess the problem is that `-static-libasan` is only supported by gcc. But I'm
Makefile-illiterate. Can anyone advise on what's the best way to make this
argument gcc-only?

Thanks,
Ryan

[1]
https://lore.kernel.org/linux-mm/53d194db-c7d4-4026-9fbb-3b41de545849@app.fastmail.com/


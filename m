Return-Path: <linux-kernel+bounces-148857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C98A8830
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F61C21CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700A14884F;
	Wed, 17 Apr 2024 15:52:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070414884B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369162; cv=none; b=fiCftHYmLFPvWlW7dkK1WyfP2dG+JAT4ccpT4e09V6ydmqT3qOlSbAg0Wz2da82Q6MZ/0bdamsNDIRguxeI3K/wf1hU0jR6mG41WZH3A6QtYt5oqNsINLT2sjxoNrdaRn2Zh5KMwEhZ4ydUNCUtTbeCzhvxuT51osjt00SVY78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369162; c=relaxed/simple;
	bh=kuX3OcKWgILgSLAxfzh2AQyYp1j6PjeGzoP26JTex64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkKNw97dM/9Ngs1zpoNV2Nxe+r1euwGeNndojTwyHkaUmDp+Me458TNxWr49hiYE+bJKfPuQS/3bChokUAUoJUMxTpg9LPbrFm6P95lrnhPDnrpctEGwcPhNCh8mNfhGncJ0/G0StMCPeaowRYM9+L0AKA6mLunSFcTSjzRMvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4185B339;
	Wed, 17 Apr 2024 08:53:07 -0700 (PDT)
Received: from [10.1.37.181] (XHFQ2J9959.cambridge.arm.com [10.1.37.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 670BD3F792;
	Wed, 17 Apr 2024 08:52:38 -0700 (PDT)
Message-ID: <28b20153-62d8-40f2-9305-60943696d4a1@arm.com>
Date: Wed, 17 Apr 2024 16:52:36 +0100
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
 <1f384d41-4c65-4efb-a171-26b54dacfb30@arm.com>
 <e95bb670-7c20-496f-80e1-8b1891816764@app.fastmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e95bb670-7c20-496f-80e1-8b1891816764@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 16:23, Arnd Bergmann wrote:
> On Wed, Apr 17, 2024, at 17:11, Ryan Roberts wrote:
>> On 16/04/2024 15:42, Arnd Bergmann wrote:
>>> On Tue, Apr 16, 2024, at 16:33, Ryan Roberts wrote:
>>>
>>> I'm not entirely sure how much of the Kbuild infrastructure we
>>> can rely on here. If the .config file gets included, this should
>>> work:
>>
>> Thanks for the pointers. Unfortunately neither don't works as we don't have any
>> of the Kbuild infrastructure.
>>
>> I'm not really sure what to do here. The best I've come up with so far is to
>> just remove asan from these binaries. They are pretty simple selftests. I'm not
>> sure its adding a whole lot of value anyway.
>>
>> Does anyone have any advice?
>>
> 
>>> Alternatively, if the cc-option macro is available, you could
>>> try this one
>>>
>>> CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan) 
> 
> I had another look at this and found example code in
> tools/thermal/tmon/Makefile that you should be able to adapt.
> Apparently the cc-option macro is not provided by default, but
> there is a copy you can include:
> 
> # We need this for the "cc-option" macro.
> include ../../build/Build.include
> WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
> override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
> # Add "-fstack-protector" only if toolchain supports it.
> override CFLAGS+= $(call cc-option,-fstack-protector-strong)

Ahh thanks! That sorted it:

diff --git a/tools/testing/selftests/fchmodat2/Makefile
b/tools/testing/selftests/fchmodat2/Makefile
index 71ec34bf1501..a68bb5a00797 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# We need this for the "cc-option" macro.
+include ../../../build/Build.include

-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
$(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
+CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan)
 TEST_GEN_PROGS := fchmodat2_test

 include ../lib.mk
diff --git a/tools/testing/selftests/openat2/Makefile
b/tools/testing/selftests/openat2/Makefile
index 254d676a2689..02af9b6ca5eb 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,8 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# We need this for the "cc-option" macro.
+include ../../../build/Build.include

-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
+CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan)
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test

 include ../lib.mk

-$(TEST_GEN_PROGS): helpers.c helpers.h
+$(TEST_GEN_PROGS): helpers.c


I'll tidy this up and send it out.

Thanks,
Ryan




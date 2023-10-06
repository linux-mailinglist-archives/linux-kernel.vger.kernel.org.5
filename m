Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287217BB5E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjJFLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjJFLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:05:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D4CA;
        Fri,  6 Oct 2023 04:05:41 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C417366125F2;
        Fri,  6 Oct 2023 12:05:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696590340;
        bh=Br2dDU51tDwN159y1nk0DEOvOinELT3kcnJgVWVZ96I=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=NWC7KZpOJ4vkunO0YgdxRWPlEeQUuzQvdd6SZ0K/qb0ynsFvQfWHCRLd+dgdVauJH
         Cjl+eEaglVWwNTl452zEBtgYkyE+0k1Or7Ae1ucJY5EZNm1EIlmBJHhzjFDuJkVkYO
         Bj97ga7KPDpVUWaNS4LjV39nUUH0Vc6Zn4fsYuCi3HGQ2+anTakmBLCZe4w8eOJ4u8
         ZpRHAk3Mz8zbqTT2lD0JEJ6gqk9I3n17rNKJf47lvLHkMAWzvFUFLKovFmAiUGIsYi
         GKq0FtPCIScbeL5zyNQ97UAKM/5YaFnsxHmFafx2CpOToqyffk37jvJ9FhZYnYct6u
         TgZ0P2EXklAYQ==
Message-ID: <1b9a4e52-cfa3-4f56-b259-41c94abed362@collabora.com>
Date:   Fri, 6 Oct 2023 16:05:31 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: locking/core] locking/futex/selftests: Remove duplicate ABI
 defines
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
 <20231006104325.GC36277@noisy.programming.kicks-ass.net>
 <ZR/oKYY7R52wKYC5@gmail.com> <ZR/ptQMWKxHCeXyp@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZR/ptQMWKxHCeXyp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 4:04 PM, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>>
>> * Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Fri, Oct 06, 2023 at 10:32:20AM -0000, tip-bot2 for Muhammad Usama Anjum wrote:
>>>> The following commit has been merged into the locking/core branch of tip:
>>>>
>>>> Commit-ID:     d351a9e56cc90a9ff694550e4b3bcaf51a391525
>>>> Gitweb:        https://git.kernel.org/tip/d351a9e56cc90a9ff694550e4b3bcaf51a391525
>>>> Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> AuthorDate:    Fri, 06 Oct 2023 14:55:37 +05:00
>>>> Committer:     Ingo Molnar <mingo@kernel.org>
>>>> CommitterDate: Fri, 06 Oct 2023 12:29:45 +02:00
>>>>
>>>> locking/futex/selftests: Remove duplicate ABI defines
>>>>
>>>> Kselftests are kernel tests that are built with kernel headers
>>>> from the same source version. The kernel headers, which includes
>>>> current ABI definitions, are already being included correctly
>>>> in the futex selftest Makefile with the help of KHDR_INCLUDE,
>>>> no need to define them again.
>>>>
>>>> Remove duplicate ABI definitions, which is effectively dead code.
>>>>
>>>> No functional changes intended.
>>>
>>> so.. as it happens I recently built these things as stand-alone, and
>>> then you ver much end up using the system headers.
>>>
>>> Also see 20230922205449.808782861@infradead.org where I add more of
>>> this.
>>>
>>> Specifically, if one does:
>>>
>>> cd tools/testing/selftests/futex/functional; make
>>>
>>> You don't get kernel headers and stuff does not build.
>>
>> Hm, I did this after applying the patch, and it does work,
>> but maybe I missed that those definitions were picked up
>> from system headers...
>>
>> So how about we make sure current kernel headers are applied
>> correctly in a 'standalone' build? There's no reason they
>> shouldn't be.
> 
> Anyway, I've removed this patch from tip:locking/core until
> this is cleared up, as your usecase is obviously a valid one ...

These days a error should appear if the kernel headers aren't found at
build time of kselftests. After building headers, kselftests should be build.

➜  functional (06bc8fe4bfc4b) ✗ pwd
/linux_mainline/tools/testing/selftests/futex/functional
➜  functional (06bc8fe4bfc4b) ✗ make

-e error: missing kernel header files.
Please run this and try again:

    cd /linux_mainline/tools/testing/selftests/../../..
    make headers

make: *** [../../lib.mk:81: kernel_header_files] Error 1
➜  functional (06bc8fe4bfc4b) ✗ (cd $mainline && make headers) > /dev/null
➜  functional (06bc8fe4bfc4b) ✗ make
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../
futex_wait_timeout.c -lpthread -lrt -o
/linux_mainline/tools/testing/selftests/futex/functional/futex_wait_timeout

Before and after applying this patch the behavior is same. I'm doing
testing on next-20231005.

> 
> Thanks,
> 
> 	Ingo

-- 
BR,
Muhammad Usama Anjum

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2709B7B1D11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjI1Mzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjI1Mzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:55:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6B19B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:55:38 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qlqYK-0002Ga-Bp; Thu, 28 Sep 2023 14:55:36 +0200
Message-ID: <8343dcf3-96e9-4601-aaac-e0a80686586b@leemhuis.info>
Date:   Thu, 28 Sep 2023 14:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: kmalloc memory leak over time.
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, freeze0985@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <4f01f302-9d59-4146-b7ff-0478c4bd94b1@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4f01f302-9d59-4146-b7ff-0478c4bd94b1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695905738;b6543d0d;
X-HE-SMSGID: 1qlqYK-0002Ga-Bp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.23 10:40, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:

@mm developers: feel free to ignore this, the user has Nvidia's driver
loaded (see bugzilla; I'll ask to reproduce without it).

Ciao, Thorsten

>> Since 1st weak of Sept I have been observing memory leak in my system, so after doing a little big of digging I found out that the leak is caused by kmalloc. In Linux 6.5.3 memory leak would increase  to nearly 50% of my ram over a period of 6-9 hours. In the Newer Linux 6.5.4 I am yet to observe that much memory leak(Haven't used my laptop for that long till now) but over a period of 3 hours I see 2.2GB reserved and it is not used by any program at all. this is just after 3 hours of usage on Linux 6.5.4.
> 
> Later, the reporter (Cc'ed) narrowed down the version range, with
> memory statistics:
> 
>> 6.4 works fine I down graded to it before linux 6.5.4 was released. no memory leak.
>>
>> today i ran my laptop for 6 hours and 40 mins and this memory leak is still happening at same rate.
>>
>>               total        used        free      shared  buff/cache   available
>> Mem:            15Gi       7.2Gi       2.8Gi       797Mi       6.4Gi       8.1Gi
>> Swap:             0B          0B          0B
>> Total:          15Gi       7.2Gi       2.8Gi
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217943
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217943
> 

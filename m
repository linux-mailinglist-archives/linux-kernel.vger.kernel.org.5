Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4196B7F9C83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjK0JUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjK0JUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:20:08 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93418CB;
        Mon, 27 Nov 2023 01:20:14 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r7Xml-00074A-2E; Mon, 27 Nov 2023 10:20:11 +0100
Message-ID: <69f4eb55-a96b-49a1-9503-5796e90c2add@leemhuis.info>
Date:   Mon, 27 Nov 2023 10:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: parisc: bug.h:71:17: error: invalid 'asm': operand number out of
 range
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        regressions@lists.linux.dev
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <CA+G9fYsM4Aa1smp2Xahf=z2WOGpXsAC3GzUW06HJN9pucm837Q@mail.gmail.com>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CA+G9fYsM4Aa1smp2Xahf=z2WOGpXsAC3GzUW06HJN9pucm837Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701076814;a7274c5d;
X-HE-SMSGID: 1r7Xml-00074A-2E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.23 09:57, Naresh Kamboju wrote:
> The parisc tinyconfig built with gcc-11 failed on mainline v6.7-rc3.
> 
> git_describe: v6.7-rc3
> git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> 
> parisc:
>   build:
>     * gcc-11-tinyconfig
> 
> In file included from lib/math/int_log.c:14:
> lib/math/int_log.c: In function 'intlog2':
> arch/parisc/include/asm/bug.h:71:17: error: invalid 'asm': operand
> number out of range
>    71 |                 asm volatile("\n"
>          \
>       |                 ^~~
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.7-rc3/testrun/21323529/suite/build/test/gcc-11-tinyconfig/log
>  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.7-rc3/testrun/21323529/suite/build/test/gcc-11-tinyconfig/history/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Yk9c7RsS6V5pdDdOYzHSrlpZQk/

Thx for the report. FWIW & TWIMC, briefly looked into this and to my
untrained eyes it looks like the kernel test robot ran into this a few
days ago already with a randconfig and gcc13:

https://lore.kernel.org/all/202311230405.edAXyqKp-lkp@intel.com/

Ciao, Thorsten


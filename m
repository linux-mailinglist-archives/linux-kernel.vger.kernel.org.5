Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE337C854C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjJMMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJMMFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:05:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDCBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:05:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qrGv4-0004ip-VD; Fri, 13 Oct 2023 14:05:31 +0200
Message-ID: <9787bd09-91b3-4a79-9ca9-e7199c925f36@leemhuis.info>
Date:   Fri, 13 Oct 2023 14:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [regression] some Dell systems hang at shutdown due to "x86/smp: Put
 CPUs into INIT on shutdown if possible" (was Fwd: Kernel 6.5 hangs on
 shutdown)
Content-Language: en-US, de-DE
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yanjun Yang <yangyj.ee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
References: <e6d1dae8-e28a-455a-a851-661c825fbdcf@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <e6d1dae8-e28a-455a-a851-661c825fbdcf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697198735;8913fc85;
X-HE-SMSGID: 1qrGv4-0004ip-VD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing x86 maintainers]

Hi Thomas!

On 12.10.23 11:37, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
>>> I use Dell OptiPlex 7050, and kernel hangs when shutting down the
computer.
>> Similar symptom has been reported on some forums, and all of them are using
>> Dell computers:
>> https://bbs.archlinux.org/viewtopic.php?pid=2124429
>> https://www.reddit.com/r/openSUSE/comments/16qq99b/tumbleweed_shutdown_did_not_finish_completely/
>> https://forum.artixlinux.org/index.php/topic,5997.0.html

Another report: https://bugzilla.redhat.com/show_bug.cgi?id=2241279

From all those links it seems quite a lot of users with Dell machines
are affected by this problem.

>> Tested with various kernel and this bug seems to be caused by commit: 88afbb21d4b36fee6acaa167641f9f0fc122f01b.

Thomas, turns out that bisection result was slightly wrong: a recheck
confirmed that the regression is actually caused by 45e34c8af58f23
("x86/smp: Put CPUs into INIT on shutdown if possible") [v6.5-rc1] of
yours. See https://bugzilla.kernel.org/show_bug.cgi?id=217995 for details.

Ciao, Thorsten

> Anyway, I'm adding this regression to be tracked by regzbot:
> [...]

#regzbot introduced: 45e34c8af58f
#regzbot link: https://bugzilla.redhat.com/show_bug.cgi?id=2241279

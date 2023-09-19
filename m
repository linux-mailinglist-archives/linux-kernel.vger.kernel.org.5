Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AF07A68C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjISQXG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjISQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:23:04 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445FEB3;
        Tue, 19 Sep 2023 09:22:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5074A635DB51;
        Tue, 19 Sep 2023 18:22:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m6Ardn4BMmQu; Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6D072622F591;
        Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rJmHKg4qnWLe; Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 16951635DB51;
        Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Date:   Tue, 19 Sep 2023 18:22:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     anton ivanov <anton.ivanov@cambridgegreys.com>
Cc:     tglx <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, x86 <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, bp <bp@alien8.de>,
        dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>,
        mingo <mingo@redhat.com>, juri lelli <juri.lelli@redhat.com>,
        vincent guittot <vincent.guittot@linaro.org>, mgorman@suse.de,
        Steven Rostedt <rostedt@goodmis.org>,
        jon grimm <jon.grimm@amd.com>, bharata@amd.com,
        raghavendra kt <raghavendra.kt@amd.com>,
        boris ostrovsky <boris.ostrovsky@oracle.com>,
        konrad wilk <konrad.wilk@oracle.com>, jgross <jgross@suse.com>,
        andrew cooper3 <andrew.cooper3@citrix.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        linux-alpha <linux-alpha@vger.kernel.org>
Message-ID: <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
In-Reply-To: <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org> <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de> <20230919134218.GA39281@noisy.programming.kicks-ass.net> <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com> <87y1h2ur98.ffs@tglx> <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
Subject: Re: Arches that don't support PREEMPT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Arches that don't support PREEMPT
Thread-Index: bIFTlUwZ+xXV2WWntYYwoPsb2f3c+g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
> It's been a while. I remember that I dropped it at the time, but do not remember
> the full details.
> 
> There was some stuff related to FP state and a few other issues I ran into while
> rewriting the interrupt controller. Some of it may be resolved by now as we are
> using host cpu flags, etc.

I remember also having a hacky but working version almost 10 years ago.
It was horrible slow because of the extra scheduler rounds.
But yes, if PREEMPT will be a must-have feature we'll have to try again.

Thanks,
//richard

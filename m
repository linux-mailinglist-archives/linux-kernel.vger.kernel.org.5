Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E344979A515
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjIKHyQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjIKHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:54:15 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06713F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:54:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62534635DB5B;
        Mon, 11 Sep 2023 09:43:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zt4T-9st26DK; Mon, 11 Sep 2023 09:43:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 08DD16234896;
        Mon, 11 Sep 2023 09:43:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bc_dpGCLszHV; Mon, 11 Sep 2023 09:43:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D05ED635DB5B;
        Mon, 11 Sep 2023 09:43:47 +0200 (CEST)
Date:   Mon, 11 Sep 2023 09:43:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc:     davidgow <davidgow@google.com>, x86 <x86@kernel.org>,
        dave hansen <dave.hansen@linux.intel.com>,
        kernel <kernel@axis.com>,
        rafael j wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        mingo <mingo@redhat.com>,
        linux-um <linux-um@lists.infradead.org>,
        tglx <tglx@linutronix.de>, andreyknvl@gmail.com,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Dmitry Vyukov <dvyukov@google.com>, hpa <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        ryabinin a a <ryabinin.a.a@gmail.com>, frederic@kernel.org,
        bp <bp@alien8.de>, Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <1681710160.12996.1694418227692.JavaMail.zimbra@nod.at>
In-Reply-To: <f11475f922994b88f5adb14d23240716e16d5303.camel@axis.com>
References: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com> <CABVgOS=X1=NC9ad+WV4spFFh4MBHLodhcyQ=Ks=6-FpXrbRTdA@mail.gmail.com> <f11475f922994b88f5adb14d23240716e16d5303.camel@axis.com>
Subject: Re: [PATCH] x86: Fix build of UML with KASAN
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: x86: Fix build of UML with KASAN
Thread-Index: AQHZmsQx3HM02RYVik+aPUiiZcEw2q+Dtz2AgJIVpwAaWaDaFg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Vincent Whitchurch" <Vincent.Whitchurch@axis.com>
>> Thanks: I stumbled into this the other day and ran out of time to debug it.
>> 
>> I've tested that it works here.
>> 
>> Tested-by: David Gow <davidgow@google.com>
> 
> Thanks.  Perhaps someone could pick this up?  It's been a few months,
> and the build problem is still present on v6.6-rc1.

I'll happily carry it though the UML tree if we get an ACK from x86 maintainers.

Thanks,
//richard

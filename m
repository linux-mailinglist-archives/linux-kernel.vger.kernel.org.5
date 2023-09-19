Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5F7A6757
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjISOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjISOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:54:39 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001D7BC;
        Tue, 19 Sep 2023 07:54:33 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38JEoefQ2134063
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 19 Sep 2023 07:50:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38JEoefQ2134063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1695135044;
        bh=tUr/tHfO1etLyJ5iEsuuEqfdyv68/fcilJS639sYECk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=rKxd+En5VITJVOEGiLmUKlIHqjSXGvGPVilskDP5cDHYQFDKWK93NnuXqpVPm85sg
         IQ8mukavFvwyuQ2+LZQx/SFeLAJwt3NRGCnufaQHbyTI8yWPctJU8mvsKC8ydIURew
         TWPjynPQFVYSogaCk173v4hcW64i46jcQU9Kvle5dlPXtXvcQsapqcrc0+JX4lPkGr
         sf4WDdKOaq1+eQt1DQ0rhsH9vVqYCi8L00mlI3ZyOafcEgEQnuvBKUCD1TlG5Gwolf
         v/ICNSdydZcPDXpEjwZCuJJ1aG9hOBj/BpI/RLMLoqn1ibICPlO3SW2Zd9eA3bsF4x
         ffTTSTGuqyWmA==
Date:   Tue, 19 Sep 2023 07:50:36 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
User-Agent: K-9 Mail for Android
In-Reply-To: <877comw8m7.ffs@tglx>
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com> <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com> <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx> <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com> <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org> <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de> <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de> <877comw8m7.ffs@tglx>
Message-ID: <7EB81196-3A32-4638-A076-0C0CFF722996@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 19, 2023 7:17:04 AM PDT, Thomas Gleixner <tglx@linutronix=2Ede=
> wrote:
>On Tue, Sep 19 2023 at 15:48, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
>>> > The agreement to kill off ia64 wasn't an invitation to kill off othe=
r stuff
>>> > that people are still working on! Can we please not do this?
>>>=20
>>> If you're working on one of them, then surely it's a simple matter of
>>> working on adding CONFIG_PREEMPT support :-)
>>
>> As Geert poined out, I'm not seeing anything particular problematic wit=
h the
>> architectures lacking CONFIG_PREEMPT at the moment=2E This seems to be =
more
>> something about organizing KConfig files=2E
>>
>> I find it a bit unfair that maintainers of architectures that have huge=
 companies
>> behind them use their manpower to urge less popular architectures for r=
emoval just
>> because they don't have 150 people working on the port so they can keep=
 up with
>> design changes quickly=2E
>
>I don't urge for removal=2E I just noticed that these four architectures
>lack PREEMPT support=2E The only thing which is missing is the actual
>preemption point in the return to kernel code path=2E
>
>But otherwise it should just work, which I obviously can't confirm :)
>
>Even without that preemption point it should build and boot=2E There migh=
t
>be some minor latency issues when that preemption point is not there,
>but adding it is not rocket science either=2E It's probably about 10 line=
s
>of ASM code, if at all=2E
>
>Though not adding that might cause a blocking issue for the rework of
>the whole preemption logic in order to remove the sprinkled around
>cond_resched() muck or force us to maintain some nasty workaround just
>for the benefit of a few stranglers=2E
>
>So I can make the same argument the other way around, that it's
>unjustified that some architectures which are just supported for
>nostalgia throw roadblocks into kernel developemnt=2E
>
>If my ALPHA foo wouldn't be very close to zero, I'd write that ASM hack
>myself, but that's going to cost more of my and your time than it's
>worth the trouble,
>
>Hmm=2E I could delegate that to Linus, he might still remember :)
>
>Thanks,
>
>        tglx

Does *anyone* actually run Alpha at this point?

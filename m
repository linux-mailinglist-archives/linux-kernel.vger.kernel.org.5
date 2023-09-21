Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34FB7A96CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjIURF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjIURFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:05:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C831FF7;
        Thu, 21 Sep 2023 10:02:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6827E5C018F;
        Thu, 21 Sep 2023 08:22:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 21 Sep 2023 08:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695298930; x=1695385330; bh=bI
        CU49f3R5e6tOFgPrJQcVi5tnUnFNXIHPGMh+L+TBg=; b=L6lYR2Tkg6YW09ZEP7
        OC3REXNbmFESOwzVxVw2xX2d4Mi1KLdjyBDeCIwOzEDPQelkPCFvhPiTDReuvjRa
        0K1hEEajfz0y5nKBcAX7j8/UhzL1ElgAUMXKoBLoTo1KDUxLJWpLAygQ2ew2IDsj
        yEf5ZXz91216EYizxRSDX6hehjnrwtBmiUcDsF3KmYhM2APrLSnFrmpF/TEJpq25
        j3Ps22K2WbFlR6SjGyseavSRtb9b6d8mN8o6jtErbySiShiA4GoNRtuQAnjzlHCi
        xMcSOr8TwAzbkGJWZcVMfLHINdShZIY7AaXYAdPb5nJpyTv+4zntqwaEt9FTkovz
        J26g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695298930; x=1695385330; bh=bICU49f3R5e6t
        OFgPrJQcVi5tnUnFNXIHPGMh+L+TBg=; b=RVjMo7y3by+104e0tpt3AaC3rxAB/
        BkN16pzGhr3PFOnA7+MzV5/LwVyFOToOKDEebEeB37my8a5dUM8dxWXyv71kgWpH
        g8G4rKJYqZNrQuEP2VH5DcjJbhzkWhqCuLtvX7/i62XytcJ1QDvDI8XBMSTLJEBD
        Zjs7BSkgAJHit6Pq6JzybieBHCckG9lZuYEPH8f3T/JN9tCgDrFEQ79omye4NBL6
        1NxzbRH7G4K6UmvQHcjFoxIuEmJjkWSv3iVjrtsoa8UKTZw061MvDMOgFXUhnn/r
        xH28CZr8YCId7DqtXVl4D3XfokExmYeY/SIZShdXISc78kCqeNrRTcl8g==
X-ME-Sender: <xms:cDUMZZfHqGJA1G8hVLLuSymrLbqfsosmGLzQiXgHQr-wDrS3u52hTQ>
    <xme:cDUMZXPBWN7Auqv283cTRULm1U3P_0m1VBoYqTUVFph6Uj51rEysJzFsHUzFYIrD5
    0n8hV6VP3CnHXHtShk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cDUMZSgI_HDLvPE_akP06dwVgCPrabVlV6Zt6d4t4Y82ndufHOIAhw>
    <xmx:cDUMZS_VZgQGWyzpfOQzG-M7CtJpOZFbRJocDUxZ4wNV18Ue-b5c4w>
    <xmx:cDUMZVvD6MhHPWwFEaEXMXTiFzhtV_Rp4EfEJVjERLQjYEuZ9mqDVQ>
    <xmx:cjUMZQjiLzrp7P5i599cAuQd37lDKYGf5YqvCg-xeP_1dr3AEPQuzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E4B47B60089; Thu, 21 Sep 2023 08:22:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <020d4d23-ee7e-49aa-9ed5-1bde21fd0a5d@app.fastmail.com>
In-Reply-To: <20230919141627.GB39281@noisy.programming.kicks-ass.net>
References: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <20230919141627.GB39281@noisy.programming.kicks-ass.net>
Date:   Thu, 21 Sep 2023 08:20:38 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc:     "Matthew Wilcox" <willy@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ankur Arora" <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        juri.lelli@redhat.com,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Steven Rostedt" <rostedt@goodmis.org>, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, andrew.cooper3@citrix.com,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        "Richard Weinberger" <richard@nod.at>,
        "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, "Brian Cain" <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023, at 10:16, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 03:48:09PM +0200, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
>> > > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>> > > that people are still working on! Can we please not do this?
>> > 
>> > If you're working on one of them, then surely it's a simple matter of
>> > working on adding CONFIG_PREEMPT support :-)
>> 
>> As Geert poined out, I'm not seeing anything particular problematic with the
>> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
>> something about organizing KConfig files.
>
> The plan in the parent thread is to remove PREEMPT_NONE and
> PREEMPT_VOLUNTARY and only keep PREEMPT_FULL.
...
>
> PREEMPT isn't something new. Also, I don't think the arch part for
> actually supporting it is particularly hard, mostly it is sticking the
> preempt_schedule_irq() call in return from interrupt code path.
>
> If you convert the arch to generic-entry (a much larger undertaking)
> then you get this for free.

I checked the default configurations for both in-kernel targets and
general-purpose distros and was surprised to learn that very few
actually turn on full preemption by default:

- All distros I looked at (rhel, debian, opensuse) use PREEMPT_VOLUNTARY
  by default, though they usually also set PREEMPT_DYNAMIC to let users
  override it at boot time.

- The majority (220) of all defconfig files in the kernel don't select
  any preemption options, and just get PREEMPT_NONE automatically.
  This includes the generic configs for armv7, s390 and mips.
  
- A small number (24) set PREEMPT_VOLUNTARY, but this notably
  includes x86 and ppc64. x86 is the only one of those that sets
  PREEMPT_DYNAMIC

- CONFIG_PREEMPT=y (full preemption) is used on 89 defconfigs,
  including arm64 and a lot of the older arm32, arc and
  mips platforms.

If we want to have a chance of removing both PREEMPT_NONE and
PREEMPT_VOLUNTARY, I think we should start with changing the
defaults first, so defconfigs that don't specify anything else
get PREEMPT=y, and distros that use PREEMPT_VOLUNTARY use it
use it in the absence of a command line argument. If that
doesn't cause too many regressions, the next step might be
to hide the choice under CONFIG_EXPERT until all m68k and
alpha no longer require PREEMPT_NONE.

     Arnd

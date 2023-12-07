Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B0808001
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjLGFKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjLGFKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:10:43 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287E3D53;
        Wed,  6 Dec 2023 21:10:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F6CA5C0212;
        Thu,  7 Dec 2023 00:10:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 00:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1701925838; x=1702012238; bh=Z3Xli2pOVHMbO4d5HDdfaRwqVwxvsQsrbmu
        GcEpy9xI=; b=gwK4x++VCHNA3TzbdtOAHjyugPMqyAupkJnWbkrbilgAV3Lf5P7
        05722qsMcPKgmZ1dUn1e+H2mNub8rr7EfkWIBFRGNQaK1EMYY2SdAa1hGLyxwYMO
        Svp+fQCpxmvJGv4dB4Z0ywFOCKSrQJTlLMcVOl4zpHvJj5Eu3W4oXI6dnpChiiNJ
        eIsG42/7NYb8LyCQZCyoVIADFuNax00gBT4MgT9y3c2gLBlIMgcFFcvIVBKWeHUX
        gh7baREcyi6M9UK+4bSLw687PD6Cllz43nqhT/9SIJjC+da2SgH679XIBDmkrRRe
        Rw1bkG+cWWEd+N7IN86R7ApX3UUezts5dHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701925838; x=1702012238; bh=Z3Xli2pOVHMbO4d5HDdfaRwqVwxvsQsrbmu
        GcEpy9xI=; b=3eGwlA49VGICR5s3rPrh6zPKV11Y+Lmas/r7XLUalIBU6dr3an3
        k31TNCFFDOMYsUxTVzM0C32i8vp9DFBPa7npJAuEsh6hZcvkAG4m6efyEWNybtfW
        ZiZV46PCgpqn2D5XuHuIuXGyPdihyZYJ5oBkjkAtJSQpXqfBURmb617fTbtS9+gr
        VDrDY8TEunBtBdkO26LvA/m8ZFWqkocpLA9GdOfi6lXuHNu4/qcnp+RU+F+Lr9i5
        KUeSsfQMDgSCOp+zwV5TpKOwT4/8ae9vv88UZALoSwn6DArFejKoIzbuwVy5uUbx
        AnBsSvz6H/hYrhtFkK0dNxLImHRnpnGkIjA==
X-ME-Sender: <xms:zVNxZYTlBZiQsQGMb2pG0h-iRsxvLDrr0M7DSsertsvWUCPpYsCTtg>
    <xme:zVNxZVxtXVyckV_TA3KYIyZy7fHKPermMFHQJnTvVNJx6UmNBA8Ml4YEi5Z0xOqHV
    nOJXj2bRfTD9SYzMA>
X-ME-Received: <xmr:zVNxZV2QONTloWeRiqBNUmLSDEr93Z82ZfN9PKMl54ujS4VWT4lWIRQNy9tWi-oq2k5WmP_zJxSr86v2AlckBELuh7CTnML6m9-y74NllFlkZfSlVJCNsGnN8bA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeehkefhtefhiefhtdegieeifeevfefhgeekvdevieeltedvieeuhfdv
    ledtleejhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigv
    lhdruggv
X-ME-Proxy: <xmx:zVNxZcBxaC5DA5U56uC9b_diIRjXSwLUl4FtS2evBlprhalOzkGD7A>
    <xmx:zVNxZRiz7jG99d-HhwcVcPtCmOT8225yPmUkQg0c1rtIT6jnvWY3rg>
    <xmx:zVNxZYptkCKCaEFdfXUk0mSrTdqebrt4NjNxIl-ROieif63IdaNaMg>
    <xmx:zlNxZYOCfUH7511ZfTieLj_CbCaDCDfqMsbrSIUBxCIlD-I9A2MpUw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 00:10:36 -0500 (EST)
Date:   Wed, 6 Dec 2023 21:10:35 -0800
From:   Andres Freund <andres@anarazel.de>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Message-ID: <20231207051035.yef3jix44uo6jlav@awork3.anarazel.de>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
 <20231122221947.781812-1-jsperbeck@google.com>
 <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
 <904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com>
 <20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de>
 <c3b064004a1748c68829f804b3da56a610fbfc8e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3b064004a1748c68829f804b3da56a610fbfc8e.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-12-07 02:41:34 +0000, Zhang, Rui wrote:
> On Tue, 2023-12-05 at 22:58 -0800, Andres Freund wrote:
> > Hi,
> > 
> > On 2023-12-01 08:31:48 +0000, Zhang, Rui wrote:
> > > As a quick fix, I'm not going to fix the "potential issue"
> > > describes
> > > above because we have not seen a real problem caused by this yet.
> > > 
> > > Can you please try the below patch to confirm if the problem is
> > > gone on
> > > your system?
> > > This patch falls back to the previous way as sent at
> > > https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/
> > 
> > 
> > I've just spent a couple hours bisecting why upgrading to 6.7-rc4
> > left me with
> > just a single CPU core on my dual socket workstation.
> > 
> > 
> > before:
> > [    0.000000] Linux version 6.6.0-andres-00003-g31255e072b2e ...
> > ...
> > [    0.022960] ACPI: Using ACPI (MADT) for SMP configuration
> > information
> > ...
> > [    0.022968] smpboot: Allowing 40 CPUs, 0 hotplug CPUs
> > ...
> > [    0.345921] smpboot: CPU0: Intel(R) Xeon(R) Gold 5215 CPU @
> > 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
> > ...
> > [    0.347229] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6 
> > #7  #8  #9
> > [    0.349082] .... node  #1, CPUs:   #10 #11 #12 #13 #14 #15 #16 #17
> > #18 #19
> > [    0.003190] smpboot: CPU 10 Converting physical 0 to logical die 1
> > 
> > [    0.361053] .... node  #0, CPUs:   #20 #21 #22 #23 #24 #25 #26 #27
> > #28 #29
> > [    0.363990] .... node  #1, CPUs:   #30 #31 #32 #33 #34 #35 #36 #37
> > #38 #39
> > ...
> > [    0.370886] smp: Brought up 2 nodes, 40 CPUs
> > [    0.370891] smpboot: Max logical packages: 2
> > [    0.370896] smpboot: Total of 40 processors activated (200000.00
> > BogoMIPS)
> > [    0.403905] node 0 deferred pages initialised in 32ms
> > [    0.408865] node 1 deferred pages initialised in 37ms
> > 
> > 
> > after:
> > [    0.000000] Linux version 6.6.0-andres-00004-gec9aedb2aa1a ...
> > ...
> > [    0.022935] ACPI: Using ACPI (MADT) for SMP configuration
> > information
> > ...
> > [    0.022942] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
> > ...
> > [    0.356424] smpboot: CPU0: Intel(R) Xeon(R) Gold 5215 CPU @
> > 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
> > ...
> > [    0.357098] smp: Bringing up secondary CPUs ...
> > [    0.357107] smp: Brought up 2 nodes, 1 CPU
> > [    0.357108] smpboot: Max logical packages: 1
> > [    0.357110] smpboot: Total of 1 processors activated (5000.00
> > BogoMIPS)
> > [    0.726283] node 0 deferred pages initialised in 368ms
> > [    0.774704] node 1 deferred pages initialised in 418ms
> > 
> > 
> > There does seem to be something off with the ACPI data, when booting
> > without
> > the patch,
> 
> which patch are you referring to? the original patch in this thread?

Yes, the the original patch / the state in 6.7-rc4.


> Does the second patch fixes the problem? I mean the patch at
> https://lore.kernel.org/all/904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com/

Yes.

Greetings,

Andres Freund

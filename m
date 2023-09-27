Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437FA7B01C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjI0KYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjI0KYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:24:15 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9DCEE;
        Wed, 27 Sep 2023 03:21:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4593832003D3;
        Wed, 27 Sep 2023 06:21:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 27 Sep 2023 06:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695810112; x=1695896512; bh=G7
        dGvBd5JsvFwgK2DiyTTK5tZ9qMJXgbyFZhkcns0j8=; b=jJLQRHOAPLDSOvLQqW
        WexvwtHRbbvyYZN4KpedDK9YccRpe43O8KW6HCHNmUOvgDytGvWCxRVlt2WRcWAI
        w7J2R1N8qolU3EvO62bbJOpcszJHsBP6Cstv29tacwiI4pv+fI3A1bsWk5TkAis3
        lydKl3qhhTWR1SjJNPJePPSt9qTT7rYJCtozU60/KXpPiz2Xsk906JXVplRtaOis
        T7arKLWfu+xbmagOY9lGeFQgWtGeDY5iZTTGAkhu/Cmn9QUr8j26eodbL5hOb8Y2
        JDZIDbFr4m6K/8jRSVM1L38P9P5lWtkrIDx41cwz3uXjStv22w78aagvfDMvaNIR
        89mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695810112; x=1695896512; bh=G7dGvBd5JsvFw
        gK2DiyTTK5tZ9qMJXgbyFZhkcns0j8=; b=XuAhfabudNl+kqZNOXcRIxfP89H1a
        KPFafcBWfDl/Scy7NW7BlMWmJZkxEc2tnHz9ed8U+0WsyVXygiEdK7lCzsSBfB69
        XRsqdTGQ0MdyPVSIYtFUxltswAeKap/nWJQ6Kh1ZPIZcdMXCVdE219albEBWH073
        Zvp8ASEatxFtRsRGheszk9lOFk3QMzscA5nXFxzx4ol9FL2V1yt5bu8ubqxHMaDH
        2VD/4268cqPTilnXUFC+IPXIP1svuq4bwW7oZJkvUh/NzjOMH5I5kaFa55zRfxDv
        rl7hzJSbHtZtKSBHLbymF9gly5ei0S+T946ox6OuKBxVmD729kf2UY+Ig==
X-ME-Sender: <xms:PgIUZQgd8wc2oEIwXUtFjGaBVd_-mvP1lYS227cqqe0FiDn0uLTNgw>
    <xme:PgIUZZCo7skyPjFBGoK2IMEXJHEGYAwh_uDjnYl6ch7H7KOJiBYBD2-hYGLFwGxn3
    XeG4oHpeDz_6U3JYfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdefucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epvdefjeevfefhvdevjeeuheefieetvdduheeludevtdefhfekleduhfdvjedtieeinecu
    ffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:PgIUZYF9L6JvIGCmFcBH-mWGhkd-RDEh2UMI0pQsOFgkWAMcm-rhyA>
    <xmx:PgIUZRTCyY6yWS5f1bwEKcP2SDwSysedEghOT0XswqmFlKSpCxdnIQ>
    <xmx:PgIUZdxe-Y4wWjYltbwliWqsUiL_Z0RS3qKLeIajl6UkqiCFW_krgw>
    <xmx:QAIUZT62hUezLzCf7tWCLY3gFCsJGirrafP915pncyO15zAz5TE6UQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0E99B60089; Wed, 27 Sep 2023 06:21:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <f636d6c8-d437-48d4-9582-33b3ee77c145@app.fastmail.com>
In-Reply-To: <6n7o7p99-9pr2-9orq-6nq1-093n7n7n43o9@syhkavp.arg>
References: <cover.1695679700.git.falcon@tinylab.org>
 <fbb6f526-0db9-4bbe-9635-8cb55b4335ee@app.fastmail.com>
 <a08e1cee-05e0-447a-b25b-6c2ebb116e8d@app.fastmail.com>
 <6n7o7p99-9pr2-9orq-6nq1-093n7n7n43o9@syhkavp.arg>
Date:   Wed, 27 Sep 2023 12:21:27 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nicolas Pitre" <nico@fluxnic.net>
Cc:     "Zhangjin Wu" <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, paulburton@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Willy Tarreau" <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Tim Bird" <tim.bird@sony.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [PATCH v1 0/7] DCE/DSE: Add Dead Syscalls Elimination support, part1
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 22:49, Nicolas Pitre wrote:
> On Tue, 26 Sep 2023, Arnd Bergmann wrote:
>
>> $ size build/tmp/vmlinux-*
>>    text	   data	    bss	     dec    hex	filename
>>   754772  220016  71841	 1046629  ff865	vmlinux-tinyconfig
>>   717500  223368  71841	 1012709  f73e5	vmlinux-tiny+nosyscalls
>>   567310  176200  71473	  814983  c6f87	vmlinux-tiny+gc-sections
>>   493278  170752  71433	  735463  b38e7	vmlinux-tiny+gc-sections+nosyscalls
>> 10120058 3572756 493701	14186515 d87813	vmlinux-defconfig
>>  9953934 3529004 491525	13974463 d53bbf	vmlinux-defconfig+gc
>>  9709856 3500600 489221	13699677 d10a5d	vmlinux-defconfig+gc+nosyscalls
>> 
>> This would put us at an upper bound of 10% size savings (80kb) for
>> tinyconfig, which is clearly significant. For defconfig, it's
>> still 2.0% or 275kb size reduction when all syscalls are dropped.
>
> I did something similar a while ago. Results included here:
>
> https://lwn.net/Articles/746780/
>
> In my case, stubbing out all syscalls produced a 7.8% reduction which 
> was somewhat disappointing compared to other techniques. Of course it 
> all depends on what is your actual goal.

Thanks for the link, I had forgotten about your article.

With all the findings combined, I guess the filtering
at the syscall table level is not all that promising
any more. Going through the list of saved space, I ended up
with 5.7% (47kb) in the best case after I left the 40 syscalls
from the example in this thread.

Removing entire groups of features using normal Kconfig symbols
based on the remaining syscalls that have the largest size
probably gives better results. I can see possible groups
of syscalls that could be disabled under CONFIG_EXPERT,
along with making their underlying infrastructure optional:

- xattr
- ptrace
- adjtimex
- splice/vmsplice/tee
- unshare/setns
- sched_*

After those, one would quickly hit diminishing returns.

     Arnd

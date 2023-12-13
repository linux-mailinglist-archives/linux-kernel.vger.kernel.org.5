Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2FA811EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442110AbjLMTSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjLMTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:18:30 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931899;
        Wed, 13 Dec 2023 11:18:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3BD0E3200A87;
        Wed, 13 Dec 2023 14:18:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Dec 2023 14:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :subject:to:to; s=fm3; t=1702495111; x=1702581511; bh=rTKNnsrQRM
        nS8HXpSk58pANoO1SStG84VUsz7kfxXxM=; b=ClLqg68gARRSVfy2COP9A3lr0P
        Ir1J775L5oC6BkvE5DBCMFzJC/Kg2zPBJ6wRG5CsaeUIqWhVMgUSNb1YID/143+w
        vSzoFS7WvI34FBktKH/F5/X4n5k7iHsSkfXvR9Tlg7IDuEleNhh9YiE/obYVmA64
        fTMqxBHGKbuFELGM89Ztty8EZQJOsUTEur3P8RSlkVZECovtH6hVCFvj9v69wAUH
        V6hKoKy2eN4TQDZB3PL7dxs2uZcoge/5H895xcRA7gktmWrgh3/eG88TcfF+vBca
        LqZg7E6WagrSttnVqUJoTWSOaYW55luK1a1MY+h6VF2lhTaWiW4eCOvF2pFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702495111; x=1702581511; bh=rTKNnsrQRMnS8HXpSk58pANoO1SS
        tG84VUsz7kfxXxM=; b=Owk85+cJNwk+wQvXcZB7S38pZKIpiNd7oMm5ZjXlCYt2
        X1afxwu1nvbz4jViVwLAYKhPhMAxwglo3vGuv/ZwTipJZCusYy6YGGWIa8E7dZSu
        ejei6gRs5rvrCwmia0r4emvPf5OMrSvSkdddKvVnRxqZyNZ9KYZ5MpmeXLo8H3yw
        Aiuy2P3cCC2/eHH6DoUVoY7oxwig2WtbKBf94GpS7Q8pvqv4S5sDESafxaN9RBGM
        ZRiyWd9F18ThbJbrqbW1/XG0BBD7xHRYrU39xohMF43/Pevhy/7OUw0ykHxPuXcp
        4RfiNMyvpUUoRtGQFDKDuHvFedvdivWmtpGwod1J2Q==
X-ME-Sender: <xms:hwN6ZTCBO1LqDuRNiQ-g6pcGIu_h222gbkn8pYuZvjdu2eZoJ0Dl2Q>
    <xme:hwN6ZZg9nXlUZy09TwSxvz7GzfCUpGRYFGxAN2Exj7tM1-Zw045LdhWS1ZjnK8Vmu
    vT5IsNktr-uReNFLM0>
X-ME-Received: <xmr:hwN6Zekhypx6Jn36t-L1YAbi4OX3x212uT6IuWIRahv6xiGW7H2wx3JVtE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepveektdeihedvgeeffeejgfduheekheeiledtvefhuddtgeeftdfgudek
    jeevhfetnecuffhomhgrihhnpehpihgufhgupghtvghsthdrfhgrihhlpdhgihhthhhusg
    drtghomhdpkhgvrhhnvghlrdhorhhgpdhpihgufhgupghpohhllhgpthgvshhtrdhfrghi
    lhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthi
    gthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:hwN6ZVwyN_LXKrS-j1E4N8FX2NKXML4qFy9GnwAPNWto2ktG2jvCjg>
    <xmx:hwN6ZYTd0il5S5GoOr9Ap9C_CZYcQLj6PshFR1EHa0EUAVD0vdldLA>
    <xmx:hwN6ZYaFY3AA7lGci3c7hxNJ_I3nmaTNFYiZ0ngiIlnQtqfOEYns4A>
    <xmx:hwN6ZdRdsfaqGr7G05gyK_zuR-xnRKoyT2YqhWbcNRXmkEJ1hgQtRg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 14:18:30 -0500 (EST)
Date:   Wed, 13 Dec 2023 12:18:28 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZXoDhLkWJB5HM1i/@tycho.pizza>
References: <20231207170946.130823-1-tycho@tycho.pizza>
 <202312111516.26dc3fd5-oliver.sang@intel.com>
 <20231213-famos-chillen-41adc67ac0ef@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-famos-chillen-41adc67ac0ef@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:18:03PM +0100, Christian Brauner wrote:
> On Mon, Dec 11, 2023 at 03:28:09PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kernel-selftests.pidfd.pidfd_test.fail" on:
> > 
> > commit: e6d9be676d2c1fa8332c63c4382b8d3227fca991 ("[PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group leaders")
> > url: https://github.com/intel-lab-lkp/linux/commits/Tycho-Andersen/selftests-pidfd-add-non-thread-group-leader-tests/20231208-011135
> > patch link: https://lore.kernel.org/all/20231207170946.130823-1-tycho@tycho.pizza/
> > patch subject: [PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-60acb023-1_20230329
> > with following parameters:
> > 
> > 	group: pidfd
> > 
> > 
> > 
> > compiler: gcc-12
> > test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202312111516.26dc3fd5-oliver.sang@intel.com
> > 
> > 
> > besides, we also observed kernel-selftests.pidfd.pidfd_poll_test.fail on this
> > commit, but clean on parent:
> > 
> > bee0e7762ad2c602 e6d9be676d2c1fa8332c63c4382
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6          100%           6:6     kernel-selftests.pidfd.pidfd_poll_test.fail
> >            :6          100%           6:6     kernel-selftests.pidfd.pidfd_test.fail
> > 
> > 
> > 
> > TAP version 13
> > 1..7
> > # timeout set to 300
> > # selftests: pidfd: pidfd_test
> > # TAP version 13
> > # 1..8
> > # # Parent: pid: 2191
> > # # Parent: Waiting for Child (2192) to complete.
> > # # Child (pidfd): starting. pid 2192 tid 2192
> > # # Child Thread: starting. pid 2192 tid 2193 ; and sleeping
> > # # Child Thread: doing exec of sleep
> > # Bail out! pidfd_poll check for premature notification on child thread exec test: Unexpected epoll_wait result (c=0, events=0) (errno 0)
> 
> So it seems that this broke multi-threaded exit notifications.

Yeah... I've been trying to figure out how to fix it.

de_thread() calls release_task() for the original leader, which I
didn't realize.

Tycho

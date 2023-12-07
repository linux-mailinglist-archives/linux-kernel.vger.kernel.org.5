Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D308808F1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443572AbjLGRwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443447AbjLGRwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:52:38 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3710D8;
        Thu,  7 Dec 2023 09:52:44 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 09D813200AC9;
        Thu,  7 Dec 2023 12:52:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 12:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701971562; x=1702057962; bh=9S
        PuDsUJwGeei3z+4rDX4Q1weGr+WJTZBwyJEr/m8Mw=; b=iUTCAs4qx2M/wphlu+
        vPnGBcKG4F0yO+5ihhHEHCkOjOEq+hiK5Oe9sd4w2N0tm7fyCZq5jc6SwqtlM+BT
        Gt0cYDf4/TOyiyWqHJdvH5Rq/qqvt9kimhhDd5I6C4yubPsRa3b7AERUz1pVd+Vz
        kABcgIWwnhArRbkQI30RZhWxP5l3sXfpLi+ZA2w/KfB6OyrpKNyQ2RyCzdGeU4TS
        RHqnM+jS0AtYpdljHqPdrroIpOlRqvu68NOvkyRruthpxeU4k3+zZUptwddwmTFY
        GNGqf5KiE8ALQt9gP/HVYICuuHOnJ3QBo23Lui9Lb/4D0Bzo98SU/LXszBVHVQef
        nvMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701971562; x=1702057962; bh=9SPuDsUJwGeei
        3z+4rDX4Q1weGr+WJTZBwyJEr/m8Mw=; b=Olgz8eycoNjHzFvs2SHIEUL7pWbcL
        3dv7v6zbBcypnzWso9uRrTfhnNxKDbDy4c+k4wDaG42LaXtfc9DB+BN98gq8i5za
        TxENHLpe3eSdgM42dAep3ryZuCGBdeSry3BiWDFD9fVJMC8b+GQItSWfQrZXAjUR
        i7+M7aL4HiYpJsU1FAdAQyWOP/9Z37UNVUyWbMFttswD2yluO+UTcoHgf2iKs2Ft
        MOwKBxZZb1pPhamNGEZFDDCT3cVxpfTGKOuoPuaHfvVwnCoMSL/47HmWtdnHhSG1
        l8nxJSnpnuIBtb4siR8lWWK+FW8VVwbq+QSNyOZhxdnsO59yjV2qxGocw==
X-ME-Sender: <xms:agZyZVm4DSd34wRd17n1n6Z8GCgVrhOtYUINxIQcM0BdQe7_mIbHmg>
    <xme:agZyZQ2QeVyvh0_Zh6xbFr91I-UnWnR21nDP0Ek53f-BJMx2ig6IC3eZuRX6j8B0u
    Cx_Eb3YnSRIZoHxZS4>
X-ME-Received: <xmr:agZyZbpbiqAEyRnE-ZEcR_ZtawngNtY5Q2nK-Ct8b7bgCw3YOcuo__IRCFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekfedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:agZyZVmWrcnjmRK67J16oX163voS7ZkPzUeidPc18AKSihcaCBXrjQ>
    <xmx:agZyZT2-TNh94lrT1Sja0qFHM76vezY_IODaBaYmo4fA3YzGb53oIQ>
    <xmx:agZyZUtqutLA5n3vcKIADAcrheSDIV221HIqRNqTVe3PV0zrU-PwdA>
    <xmx:agZyZYk3S4YpUFIf4pbFy0KbVuB6jTgHphirH2w3gjBvys4iXsLl-A>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 12:52:40 -0500 (EST)
Date:   Thu, 7 Dec 2023 10:52:38 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZXIGZq18Bb6LK1qt@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231207-netzhaut-wachen-81c34f8ee154@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-netzhaut-wachen-81c34f8ee154@brauner>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 06:21:18PM +0100, Christian Brauner wrote:
> [Cc fsdevel & Jan because we had some discussions about fanotify
> returning non-thread-group pidfds. That's just for awareness or in case
> this might need special handling.]
> 
> On Thu, Nov 30, 2023 at 09:39:44AM -0700, Tycho Andersen wrote:
> > From: Tycho Andersen <tandersen@netflix.com>
> > 
> > We are using the pidfd family of syscalls with the seccomp userspace
> > notifier. When some thread triggers a seccomp notification, we want to do
> > some things to its context (munge fd tables via pidfd_getfd(), maybe write
> > to its memory, etc.). However, threads created with ~CLONE_FILES or
> > ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
> > purpose, since their fd table or mm are distinct from the thread group
> > leader's. In this patch, we relax this restriction for pidfd_open().
> > 
> > In order to avoid dangling poll() users we need to notify pidfd waiters
> > when individual threads die, but once we do that all the other machinery
> > seems to work ok viz. the tests. But I suppose there are more cases than
> > just this one.
> > 
> > Another weirdness is the open-coding of this vs. exporting using
> > do_notify_pidfd(). This particular location is after __exit_signal() is
> > called, which does __unhash_process() which kills ->thread_pid, so we need
> > to use the copy we have locally, vs do_notify_pid() which accesses it via
> > task_pid(). Maybe this suggests that the notification should live somewhere
> > in __exit_signals()? I just put it here because I saw we were already
> > testing if this task was the leader.
> > 
> > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > ---
> 
> So we've always said that if there's a use-case for this then we're
> willing to support it. And I think that stance hasn't changed. I know
> that others have expressed interest in this as well.
> 
> So currently the series only enables pidfds for threads to be created
> and allows notifications for threads. But all places that currently make
> use of pidfds refuse non-thread-group leaders. We can certainly proceed
> with a patch series that only enables creation and exit notification but
> we should also consider unlocking additional functionality:
> 
> * audit of all callers that use pidfd_get_task()
> 
>   (1) process_madvise()
>   (2) process_mrlease()
> 
>   I expect that both can handle threads just fine but we'd need an Ack
>   from mm people.
> 
> * pidfd_prepare() is used to create pidfds for:
> 
>   (1) CLONE_PIDFD via clone() and clone3()
>   (2) SCM_PIDFD and SO_PEERPIDFD
>   (3) fanotify
>   
>   (1) is what this series here is about.
> 
>   For (2) we need to check whether fanotify would be ok to handle pidfds
>   for threads. It might be fine but Jan will probably know more.
> 
>   For (3) the change doesn't matter because SCM_CREDS always use the
>   thread-group leader. So even if we allowed the creation of pidfds for
>   threads it wouldn't matter.
> * audit all callers of pidfd_pid() whether they could simply be switched
>   to handle individual threads:
> 
>   (1) setns() handles threads just fine so this is safe to allow.
>   (2) pidfd_getfd() I would like to keep restricted and essentially
>       freeze new features for it.
> 
>       I'm not happy that we did didn't just implement it as an ioctl to
>       the seccomp notifier. And I wouldn't oppose a patch that would add
>       that functionality to the seccomp notifier itself. But that's a
>       separate topic.
>   (3) pidfd_send_signal(). I think that one is the most interesting on
>       to allow signaling individual threads. I'm not sure that you need
>       to do this right now in this patch but we need to think about what
>       we want to do there.

This all sounds reasonable to me, I can take a look as time permits.

pidfd_send_signal() at the very least would have been useful while
writing these tests.

Tycho

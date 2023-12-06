Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA728073AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379177AbjLFP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379088AbjLFP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:27:14 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340B9FA;
        Wed,  6 Dec 2023 07:27:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D6935C02A9;
        Wed,  6 Dec 2023 10:27:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 10:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701876439; x=1701962839; bh=FT
        6UEoWVsDlfq8nOucO+L8572l+DeQGXhub/tbWtdrE=; b=eIx0mXmLhdGLez1Q+u
        Ee0o8vn+1rJ13CAy0ryFOtVnfnOY+WReKAgmoSV4pq8Vs+TP72SYcIjuSMtCtzmF
        pcievzijmVoLfI5+sB+MIS70mdvBmkCKNnevaxVwbbb+MN26eH3A+uEhzKjczoSz
        u/w7NDif0QudJR6wwfRTVoiP4d+2of1LB8BF2NPwvPsUJQ4avEJ2oRbuaXGfLvqC
        baZt32UXCPuIV1Havxch7H5KmOP951fwRSdaA3lvrM6Er6BQ+SyiMvZ/t++Idn/h
        BzUIwjgzuEB4bYUqfTeYDhkBXdkIxnu5csUDEWBrWdloWM4PdhCVYfpFTuklaPZh
        Deyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701876439; x=1701962839; bh=FT6UEoWVsDlfq
        8nOucO+L8572l+DeQGXhub/tbWtdrE=; b=IwmUrbSAlb0Twy6EorGSDlLkjaeuS
        gncuJoTYDmFaLztU8O1f+k3nVftAOr6uwAvtyQ2p25abP9n9ABGhJ8HeWmKEzu3w
        VQ5jFbnTPgX4KnHsLip9ZBlpBn8X0NcOay6IDDfDYUc01iljg0GzwZ+cSVK0gVvf
        PIZSUKS7rgrirb4BeGeNXq89LXAzbi+JbpJB2agitfOedDLq+NQYgHhAaKeQ4wPs
        ZZcQIdB2L6OMg5Zc1zal6ba21fu60MRp0c6V9f8jnsbfDdNrYARTx9bRqvR2JCUy
        acVwAoJWgdzb708JXKEDmayeajdLhfiWQi5uvI+Tawqxd5bR2JIGV7UIA==
X-ME-Sender: <xms:15JwZZ1cm5uK11ww6N-OFCKcAnz0RCROi6eKV7kdGS6b5NLTRHWKIg>
    <xme:15JwZQGZDaXb1NplmNVvbtoawJFeTsk3moR1fftaslpix2x3UcGuokJBU7qtD-Wu3
    pPwoWXYGdg8d3lF4ss>
X-ME-Received: <xmr:15JwZZ5jjWAA2PGEJgIzgAg3FPkysEWkpdsYc_XEwf0SU_bYzxwxX1g9OdtNromuiu52hQ1wyfCOILwaRbX61ygIn3RS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:15JwZW3KPkIw_b256pFVavGfelUCZSAZmcD4F7XfQo-BxljvgPEUOg>
    <xmx:15JwZcHiWf1EVl_MGU2gnyOw1nhOIW3CJ0f-aJBG532qiIXjaY2kzQ>
    <xmx:15JwZX-O0YmgE6YUwpkjTmjO-mLtu_mScNcWu4IHKerjrEDztmuruw>
    <xmx:15JwZR4jvTsL_SOv-sronCWcxDVhFM1w3cdMJC7A9WOo1JXwmn5bFA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 10:27:18 -0500 (EST)
Date:   Wed, 6 Dec 2023 08:27:17 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZXCS1SMQLhSPtjdp@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
 <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttp3rprd.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:43:18PM +0100, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> >>> I'd like to offer a userspace API which allows safe stashing of
> >>> unreachable file descriptors on a service thread.
> 
> >> By "safe" here do you mean not accessible via pidfd_getfd()?
> 
> No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
> intra-process transfer using /proc, but I'm hoping for something nicer.

It occurred to me that we could get the seccomp() protected-memory
functionality almost all the way via some combination of
memfd_create(MFD_ALLOW_SEALING), fcntl(F_SEAL_WRITE|F_SEAL_SEAL), and
mmap(PROT_NONE). Some other thread could come along and unmap/remap,
but perhaps with some kind of F_SEAL_NOUNMAP married to one of these
special files we could both get what we want?

I submitted a talk to FOSDEM just for grins, if anyone is planning to
attend that.

Tycho

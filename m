Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0407BD601
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJIJAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjJIJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:00:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EDBA;
        Mon,  9 Oct 2023 02:00:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CB11D3200A39;
        Mon,  9 Oct 2023 05:00:41 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 05:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696842041; x=1696928441; bh=o/
        wzvx34TIgXR11wBM5KYdkH55zx4SvySDjKi5HnqWM=; b=baMvRfbpiizIGEKynj
        8QKUMDhCWWf9WXAbY67udr5Lfse6o0EJBzz90WcfFdU4fPoSXQN761RMqtGkZahQ
        GlOJFeCBVJJtH2xrZp5VPjPzItoqF2xewuDdMNMENZDS2Jm8Kh27ZPAJznLOvhu0
        SDv4q5//k8h5Kz2gIXR5vxcw96JaygSkfU6G1sTxejIHEaKBZHrasfsh7XwJfNNa
        1w+VF3COjk1Z54wSt8s0hw1wJp85p7wJklZdRjstLhkUA689elRyIjs6T3IU+cUE
        YxNW1d49mj0Ov+zmUaGf6XHeQmhpAG/ZVpAN+Z6VD0RRBg85dslqcP/IrwbIa3jl
        jGcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696842041; x=1696928441; bh=o/wzvx34TIgXR
        11wBM5KYdkH55zx4SvySDjKi5HnqWM=; b=c1nEUkMF/Uxb8yYlIMwUldweLushx
        +H39Iv6GVqx7z1WDNp9SjmI6YrG9mzLsWqH3w+YOihhG01HQySGH6a9UJBxfupC7
        nwfqExLhbJcydnMB2lMG06OjnX5OLJl4iQcnYEFQp0NrphOTZYa/Pzx1/Sf/sc2h
        6ogvBDNk8U/eFfsYDZo5dSrxFGcUkSnqyWdMMTjq/UxOaZdejUAaVnXUVbPoAuK7
        jJFKy1GUmjSVDGHipy1riHl2sAxDde7WQIAPrnhYdsGAalSe/GRYwJkdq0KIO3Tb
        oBmKUAlyvlhO4CSrMSEe3iJuTv7mip2MHPLFFVrAC33RcOkk3pE68dKAw==
X-ME-Sender: <xms:OMEjZfCWyqIz3tyzRfv7z5jG9Cjz7BQpPov5pycFlpbkAanYU96Mlw>
    <xme:OMEjZVgAFOH-SuF-T1fOtlxU6F-iPEUKSVhF1lc7keGZuRSIZL-bFt1C__G0iieIb
    XP6IfA8MfiX_-NDO4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OMEjZamNU2YfNjlUineL7MxC3XWUVH1-dp5AGa7hRVorrkAl6mu4IA>
    <xmx:OMEjZRyTiA0MZZgU7oGRMIHp9i6KMl49Y4RUAc2Jle2D32kN6RxH5A>
    <xmx:OMEjZUSPZZlRE_m62m7UvN4qEl3wqXVoCWBqhT90mSGZiA1JBCgjFA>
    <xmx:OcEjZaccwJ4H3IPTseV3QxUzB5MAyHHhT-e_dZgRtCgD6Nggb0X-qA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ACCDB1700089; Mon,  9 Oct 2023 05:00:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
In-Reply-To: <20231009084812.GB14330@noisy.programming.kicks-ass.net>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
Date:   Mon, 09 Oct 2023 11:00:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Jens Axboe" <axboe@kernel.dk>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        "Sohil Mehta" <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023, at 10:48, Peter Zijlstra wrote:
> On Mon, Oct 09, 2023 at 12:31:18PM +1100, Stephen Rothwell wrote:
>> diff --cc arch/alpha/kernel/syscalls/syscall.tbl
>> index 5d05ab716a74,b1865f9bb31e..000000000000
>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
>> @@@ -492,4 -492,6 +492,7 @@@
>>   560	common	set_mempolicy_home_node		sys_ni_syscall
>>   561	common	cachestat			sys_cachestat
>>   562	common	fchmodat2			sys_fchmodat2
>>  -563	common	futex_wake			sys_futex_wake
>>  -564	common	futex_wait			sys_futex_wait
>>  -565	common	futex_requeue			sys_futex_requeue
>>  +563	common	map_shadow_stack		sys_map_shadow_stack
>> ++564	common	futex_wake			sys_futex_wake
>> ++565	common	futex_wait			sys_futex_wait
>> ++566	common	futex_requeue			sys_futex_requeue
>
> So this renumbers the (futex) stuff on Alpha, does anybody care? AFAICT
> Alpha does not follow the unistd order and meh.

Let's not make it worse for now. All the numbers since the
introduction of the time64 syscalls are offset by exactly 120
on alpha, and I'd prefer to keep it that way for the moment.

I still hope to eventually finish the conversion of all architectures
to a single syscall.tbl for numbers >400, and if that happens before
the end of alpha, a different ordering would just be extra pain.

    Arnd

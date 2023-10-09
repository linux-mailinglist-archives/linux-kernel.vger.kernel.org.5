Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16357BE2A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376960AbjJIOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376745AbjJIOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:24:02 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A148E;
        Mon,  9 Oct 2023 07:23:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A3F263200A8F;
        Mon,  9 Oct 2023 10:23:58 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 10:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696861438; x=1696947838; bh=FE
        DD7vM00CaYpOVlpzRp/CBL/7AEDKYztWJ0515TFA0=; b=Clxg5PhylX3c8if860
        OZQxKJj91a+vFdyI9G65A0O+35KMyRxCiK3eU/0VJMkGoY9lop7mBr2PIe0QT3zA
        wmGVEm9/uT700T4yfZkDtNsgQGehtdD+gBfHyiNeoV3bmv8/7lWfSB6uV0VFPSHA
        gZlvAExX1QM+NBNPB59eaAbJByN96EY2ZOnsccriznmwvRCAWihmTK6bUMWA4gs4
        nq2+4C1qQWwkNFLXWRi7FE+GP9Qz0cjIkWxUsN6eKufkxWeXSsojdPZwFj1mXqxi
        L+VzIj0Nt81AhrQYCFHxlQxn86WAk00LH4oCT9sWy4lHGChQgwxXY8VBu/5QQ96n
        mrfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696861438; x=1696947838; bh=FEDD7vM00CaYp
        OVlpzRp/CBL/7AEDKYztWJ0515TFA0=; b=YQ77sidi3144dQxqDvNuR2PsaBK/3
        kuKSyMvy1TyiiSIzllElB0gjYX1QZr1a2pT5jeis85WC7Ie2iiFoSa1NsaRAxVKf
        KgJ7UYGYmgRMvhCp5B/wppdQvhv/potZ3mFv2FKb41km9mxxofns3xCYOH2irSyV
        YN/yi0IG9QX33nMDRIrDIFDG5yHdrdnuMylFVpW6EvhusjWJnq8QrVdZISBytsaw
        dSwoeMDQqqhPsIR3f4jaTyY0PDyTPsKQT3sz8b+JiXBu9Nf8DP+PuwQYHCIvmlSs
        Eyqix0OK7BB61xQoRSjP1BYx2RzD2EbDErk1DtHBGp/cvjd0DGjNidTbw==
X-ME-Sender: <xms:_QwkZdg00LCxRqsZ8NuZoe00xgwrzLsbV5dwkWPVItHD7f9ZHqxFAA>
    <xme:_QwkZSCsNqeYHFtf6W9abUfVEy8iwa5WyIT-ScKsULzGVbUCSzhP1sUg-xggUjfeR
    Qn16YtYRCuyYeAR-JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_QwkZdFhzLXvRqawB3bmTNudQek5MkzxsbVGEb9lqO8MfeTj4l9hvw>
    <xmx:_QwkZSTYdrdWPiS1Ce8O-EVf-oIikbvPPXePafi-fnzZDuzOimJSZw>
    <xmx:_QwkZawjPpmw8Fa0tZ7b79eCQAE13rGbN7fiO5X_1x-phLMCkU2c4A>
    <xmx:_gwkZe99tQqfRaQEKv6KyV2Xn8EAv4EXy3o68zP_AY_edKGoEFGnrA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CD8C1700090; Mon,  9 Oct 2023 10:23:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <af82e327-5d80-4031-a1a7-a275bed8e248@app.fastmail.com>
In-Reply-To: <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
 <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
 <20231009141351.GD14330@noisy.programming.kicks-ass.net>
 <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
Date:   Mon, 09 Oct 2023 16:21:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jens Axboe" <axboe@kernel.dk>,
        "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        "Sohil Mehta" <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023, at 16:16, Jens Axboe wrote:
> On 10/9/23 8:13 AM, Peter Zijlstra wrote:
>> On Mon, Oct 09, 2023 at 11:00:19AM +0200, Arnd Bergmann wrote:
>>>
>>> Let's not make it worse for now. All the numbers since the
>>> introduction of the time64 syscalls are offset by exactly 120
>>> on alpha, and I'd prefer to keep it that way for the moment.
>>>
>>> I still hope to eventually finish the conversion of all architectures
>>> to a single syscall.tbl for numbers >400, and if that happens before
>>> the end of alpha, a different ordering would just be extra pain.
>> 
>> Fair enough; should we look at rebase those futex patches for this? (bit
>> of a pain as that would also mean rebasing block)
>
> From my point of view, this isn't a huge problem if we do it now. The
> io_uring-futex branch is a separate branch and I have nothing on top of
> it, so I could easily just re-pull your updated branch and rebase my
> changes on top.
>
>> Or do we want to keep this fixup in the merge resolution and make sure
>> Linus is aware?
>
> If you're OK with it, I'd say let's rebase and save ourselves the
> trouble at merge time.

Sounds good, thanks.

If it's any help, I can also merge the patches that wire up the
syscalls through the asm-generic tree to avoid the conflicts
altogether.

     Arnd

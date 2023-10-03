Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5E7B6F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbjJCQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjJCQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:58:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD5A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:57:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 702E13200B0B;
        Tue,  3 Oct 2023 12:57:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696352277; x=1696438677; bh=V2
        FQ7Cu/afkL6EriG0Uiq965GFYkq5JFljrsPV+qIn8=; b=LOvNGpJORUwJ+gnnJ3
        SQOqcVf8X1032fc2EgB7r2YcuiMQitNDg/0tJ9vb9FZBtuovzUkmIig9fTzQQnLH
        EwmFn7MTsgDpooNLbNlUB6b5xLgQ6eS0/VJezsWQiB0uhMIk0lWGP+5d0R4dDQRF
        GC2zvsBPjKmHAwz1nruBxHRb6wUETQXUUPEujhrRIc3HP19+ApeS0XRxnwgpWUBK
        8Htx4DX0lq3xo8oSakrxxbsNXOAhQDyvoKMXt4F1hDOrnXLPakmDqkLqzvj2eZGd
        cBW3dtKGFlpuvZTf15nffXAIr2Jk8t/tdihnr0PBRC/ZHhGy8J83kyFNK99ZFczu
        8dtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696352277; x=1696438677; bh=V2FQ7Cu/afkL6
        EriG0Uiq965GFYkq5JFljrsPV+qIn8=; b=B+M5wR9XKOQzUfvOYQDdsd7u+Lsm1
        qcE6NqAKlY3Snkcg6MI7WrfVsZ4ME+H2OA49Jl6Bjt338iBImrBYA/6RppClxSbn
        3RPGjXc2UC2Gisegg27LE4R+wTF/SjZPi0/943A+0q7FwB1GQw9Ab/pMf/cJ40wY
        Icpby1udhs/unsXxL2fR1iCc+z03Vdyet82SpMC0H9XLYfZ5+x3Ec1TITQR1YSCW
        8RWIn3vxuYC8GYtaQaV85+bJiqNYapiaYGGx7l+lvZdFNBF41H5gfYXfhOjrbtZV
        VRzdhzbR8fWw0vvF2ktA9kFj5LgTXVKyJ+PdTouubvl7CMmwQ3djPEi9w==
X-ME-Sender: <xms:FUgcZYWcQ_dgaND97fj43BS5s25gj1XlxJ2kura5FnPFUI4xskJ_iw>
    <xme:FUgcZck---7EQqqjXJmnSfJZaXIonMyl8Bk0ThXdM64gq2eBfgjYfRopscs84rzfX
    5UxhhgVUEPMFzLd7hY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FUgcZcapDqK6KluEtxOr4x-qL9hBqYhjACgtVEMmGwAX7YyHmIElXg>
    <xmx:FUgcZXWZMaj8u1C3lvBiLvjrmhlbs1Tgp_LQEDV23zjqPiHXUHPrRw>
    <xmx:FUgcZSk5HVekcN92d5a_CufSlwNcXg6rHuqzW0ix45C6227E1pD4Yw>
    <xmx:FUgcZXzi_NePzE8UOtmWEYttMeYjKSvEns8veI0XxQSYP3uNsRRdGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B5DCCB60089; Tue,  3 Oct 2023 12:57:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <325de88f-1237-4910-aa2a-97707bedae26@app.fastmail.com>
In-Reply-To: <20231003094912.08cf57998135446ef475dd19@linux-foundation.org>
References: <20231003144857.752952-1-gregory.price@memverge.com>
 <20231003094912.08cf57998135446ef475dd19@linux-foundation.org>
Date:   Tue, 03 Oct 2023 18:57:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Gregory Price" <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH] mm/migrate: fix do_pages_move for compat pointers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023, at 18:49, Andrew Morton wrote:
> On Tue,  3 Oct 2023 10:48:56 -0400 Gregory Price 
> <gourry.memverge@gmail.com> wrote:
>
>> do_pages_move does not handle compat pointers for the page list.
>> correctly.  Add in_compat_syscall check and appropriate get_user
>> fetch when iterating the page list.
>
> What are the userspace visible effects of this change?

It makes the syscall in compat mode (32-bit userspace, 64-bit kernel)
work the same way as the native 32-bit syscall again, restoring the
behavior before my broken commit 5b1b561ba73c ("mm: simplify
compat_sys_move_pages").

       Arnd

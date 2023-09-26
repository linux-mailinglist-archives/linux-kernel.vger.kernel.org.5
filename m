Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142D87AE56F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjIZGBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIZGBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:01:32 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2871D6;
        Mon, 25 Sep 2023 23:01:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7298832009A9;
        Tue, 26 Sep 2023 02:01:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 02:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695708084; x=1695794484; bh=w/
        4ipUt4YaYJVMn90dIRLMV9blP8uDxHBm7ZB3nucyE=; b=S02BKYOI6Rh5Iumm/y
        Iubc3e3DDnrQMuYwumMWaqDk/+s0aZVKTRWF/5pRHhLF3zjsWN/nH1Tck9WcOQ+B
        XQN7n+Ni6oeu8pW5Itv4Hw3PKhsGjuAlLlvqe/SqdRqK1kbv1wnUHd3Qr3hsHKQW
        gH/hN9kW9NKIKhoLlFpBODiiS/mu0NA8rYhuuC/4FwXktdjdOdDgEE/pFyZH7l6s
        Ec9N4yzST+CS13M6pfhwdOun751FShA2sobg/q2JFx9pITQjlfdOAnzceRIUS7m6
        SoJCjDtVwss+b1i6xRyOhE4ofbtObhBFLIbg+hsWnzCXUSMhVBEPolG53QH7d2lR
        0Gzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695708084; x=1695794484; bh=w/4ipUt4YaYJV
        Mn90dIRLMV9blP8uDxHBm7ZB3nucyE=; b=kZ2VJNxITGz5/swa9vulf6xSIyV+6
        Xc/eVnsJjNXSR2pwgMYABr0E7P+HpQN+pVb80NX4lFSKvD4Or6y9Lz0ts36lDt1Y
        ZE5D60TVKkgyCmkLkmzB5WBQ4BdEl+ZEievW+zJi2/2Srnd2GM+aMijO7vB4Wx2Y
        KVExowlqj2wnIZHjFbzLRj2hBTs0xrnJPhSieZVWpjVU3EDG2ezPSGKons4BvpgB
        98rBprrLuYb3PUo7IhLAFd7uaNwpQXst28sySTMg6hv9oVdjz8b0tPnqjZ8HnWGk
        mHQrkv9LgwPFgiEYtkXMhHhz/pyeYYxjGVR9obj+Drwt1lxgBH9Erkn8Q==
X-ME-Sender: <xms:s3MSZfRA4S6VZNEKTVtbfIthvJOuhe66GTAcahugSYVAAb7kOS47uQ>
    <xme:s3MSZQz8KRc5scIw-3RZHLgiVkGs2Xn4Ee9YUBelHR9a7K1L7OcW5cNXMVCDwztYW
    81N-lIQ-gTtwJ-BxCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:s3MSZU1xw0_yZN340Dg_WoIYhEKBL1_XF3S2n7RZAkx2MGFFYQXkNg>
    <xmx:s3MSZfDX4QsOSyKtre_kCi5kz3VUkYwUj7cTAuEzzf8nLk7W6hXOqw>
    <xmx:s3MSZYhVrmSJGmIduNkqhcGbOvr02avWQvkfgv6JEVXE9fxqhrRg2Q>
    <xmx:tHMSZbPU3L2STJGA2xUZrEWAFbsIvUebNFGh1PiyxqJit-CFsZI3ug>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5E4D0B60089; Tue, 26 Sep 2023 02:01:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <e160b4df-92ce-4b9c-96ba-200f259c8216@app.fastmail.com>
In-Reply-To: <aad452c57bce2ab7983e723d78bd2cc7b6f533c1.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
 <aad452c57bce2ab7983e723d78bd2cc7b6f533c1.1695679700.git.falcon@tinylab.org>
Date:   Tue, 26 Sep 2023 08:01:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, paulburton@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Willy Tarreau" <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Tim Bird" <tim.bird@sony.com>
Subject: Re: [PATCH v1 7/7] DCE/DSE: riscv: trim syscall tables
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 00:43, Zhangjin Wu wrote:
> When the maximum nr of the used syscalls is smaller than __NR_syscalls
> (original syscalls total). It is able to update __NR_syscalls to
> (maximum nr + 1) and further trim the '>= (maximum nr + 1)' part of the
> syscall tables:
>
> For example:
>
>     sys_call_table [143] = {
> 	[0 ... 143 - 1] = sys_ni_syscall,
>         [64] = sys_write,
>         [93] = sys_exit,
>         [142] = sys_reboot,
>     }
>
> The >= 143 part of the syscall tables can be trimmed.
>
> At the same time, the syscall >= 143 from user space must be ignored
> from do_trap_ecall_u() of traps.c.
>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  arch/riscv/include/asm/unistd.h               |  2 ++
>  arch/riscv/kernel/Makefile                    |  2 ++
>  arch/riscv/kernel/syscalls/Makefile           | 22 +++++++++++++++++++
>  .../kernel/syscalls/compat_syscall_table.c    |  4 ++--
>  arch/riscv/kernel/syscalls/syscall_table.c    |  4 ++--
>  5 files changed, 30 insertions(+), 4 deletions(-)

This bit feels like you are overoptimizing for a corner case:
there is not much to be gained in terms of memory savings, but
you add complexity in an area that I feel should be made common
between architectures.

I hope to get back to working on consolidating both the
syscall.tbl input files and the build infrastructure for them
across architectures, and you make that harder here, so I'd
prefer you to drop this part, at least until the code is
shared across all architectures.

    Arnd

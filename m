Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602DD7AE54E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjIZF4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZF4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:56:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2ADE9;
        Mon, 25 Sep 2023 22:55:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9EADC32009B8;
        Tue, 26 Sep 2023 01:55:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 01:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695707754; x=1695794154; bh=YR
        rleeex828q75JmCNLzXDAVcVLBERWC6QvUePC8cFI=; b=uU92RTmRMEWMLlVvtx
        i4w6UTw8tlWqOYGhJjwrHDaHb1+iiK8ZLbHSDr8Q4kEuUdh7Fqc/6NB1YxL6uR9h
        gyrhhWHOWDAAUFvmklo5lI/PfiZ/3/IaMeVy1ddV0ItoW/lsBbE248i1moQpZRoh
        ZUGYxcjChlhQApofJXRv64crfcpZNSD/SPE6WXEnfBZo8T354gOaifxSQwbZaMAf
        b2Q/6tT0j/Ac77Qr/uC7DODJFfW3CfmDL+VFk/2MHxvVyx/4UXHEFSe2FuikFfsa
        KLwFMBDSRi6uxL78Ow6hzYRHxrbBNhEK1k7HR07B1GBfxL/JExwS6yatJrCydv9J
        kz5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695707754; x=1695794154; bh=YRrleeex828q7
        5JmCNLzXDAVcVLBERWC6QvUePC8cFI=; b=SOO5xYa9rEjJjyK0tUjttPAxA+W6k
        gUEVsNGvgYOr+N8UFdrYoXqwRDja2UDLDBjFWqvuVb90C9Wo4uqKBno06aft3+lY
        g0dvJD9aNuxI97F/TMbehfcdo/zq0pk+xGIK6ZBiHSMCbws/n0Uf0WTrnBF2PXr3
        dd9OW1e2H7q6OCbgbXzl88drAFBdiaWkc+vVd1bZ3efLVukyOs6NCwnyxP41W9Ld
        Y4A/rDcDFgtzUYzWSG26DQa0ltuXGcWAtydTI/m/zlhutV+MNx1vS1icRUAKqaHJ
        m6BKxxE+PrJMuhQLwr08fLmPq2myINs1m8h1UzfVAPDm3Oum16P3awwqQ==
X-ME-Sender: <xms:aHISZa8xgeauB0XaSgrtJah2-U0olHnVTEXRb_6Nkw9IdqLmXrp7eQ>
    <xme:aHISZat97w4bQXYA6ZKZaIb_gGm9fbmmu1rUN6u6hJnOAkv_QT2wg9Pzux8suB6sr
    NXEONxD2AJhjwCnHas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:aHISZQB85KGuwgRCrpGa_iBUUKSt-RsVSGGsjx-z4A07TOEj74qeXA>
    <xmx:aHISZSc4lMrYhaYapEyW1iMXMakHsTGCGe3YJ6SCeMCC5ueenP8l7Q>
    <xmx:aHISZfO2xj0Kl9NF0Nkd2KilNan_vsbhEJXeC225ZmS2aE6V8Ztdnw>
    <xmx:anISZaqw08Y2scEbkHMqs1q4rPsB1bOemD_-rCquvLZYeApib2gsfw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 71738B60089; Tue, 26 Sep 2023 01:55:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <2c4bcf65-69f1-4af6-8f80-fe23a4fb20ab@app.fastmail.com>
In-Reply-To: <df1ce8c514c3efc1323d5ed69e6ecbdb2542b960.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
 <df1ce8c514c3efc1323d5ed69e6ecbdb2542b960.1695679700.git.falcon@tinylab.org>
Date:   Tue, 26 Sep 2023 07:55:32 +0200
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
Subject: Re: [PATCH v1 3/7] DCE/DSE: Add a new scripts/Makefile.syscalls
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 00:38, Zhangjin Wu wrote:
> When CONFIG_TRIM_UNUSED_SYSCALLS is enabled, get used syscalls from
> CONFIG_USED_SYSCALLS. CONFIG_USED_SYSCALLS may be a list of used
> syscalls or a file to store such a list.
>
> If CONFIG_USED_SYSCALLS is configured as a list of the used syscalls,
> directly record them in a used_syscalls variable, if it is a file to
> store the list, record the file name to the used_syscalls_file variable
> and put its content to the used_syscalls variable.
>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

I like the idea of configuring the set of syscalls more, but we
should probably discuss the implementation of this here. You
introduce two new ways of doing this, on top of the existing
coarse-grained method (per syscall class Kconfig symbols).

Both methods seem a little awkward to me, but are doable
in principle if we can't come up with a better way. However,
I'd much prefer to not add both the Kconfig symbol and the
extra file here, since at least one of them is redundant.

Do you have automatic tooling to generate these lists from
a profile, or do you require manually writing them? Do you
have an example list?

      Arnd

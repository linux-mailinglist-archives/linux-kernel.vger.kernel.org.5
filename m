Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081127AE592
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjIZGLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjIZGLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:11:00 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920AE55;
        Mon, 25 Sep 2023 23:10:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E07D432009F0;
        Tue, 26 Sep 2023 02:10:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 02:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695708639; x=1695795039; bh=oC
        YIjuW89ugmbyi2Z2bcvS41djt8ybKt3d7f3d7YUtg=; b=ouBK1gk5nfLdyJrDUI
        wdVsO41CB6GBBarwCeJyFPMDWdoV68AgcEYOMCB167pKfQw5T3b/0yNArFnUaAi1
        9XPWYRWWdK4GRlTP/vVy9dznUHP+KWfCtdNwRh/UFPzXOqYUEvqQsKEHzjS1Unb7
        Ur3ehzaONMVwXFqRa0X9d/eu9Va05CnXhf/h9ahqd1V78WjLlMBhS6Osps22QLIm
        +Wmtf2gBFte97YLyyg0ReXeZM4DCCt5qO0Qlcmt6zGWPsuEsTShJvODFNKVW33TF
        K8Ps/ik5XfZTK/U1fqviD0qH4xfWosZoUs31UWkITtpDyT1iVofsRxdiM+km24P4
        lPvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695708639; x=1695795039; bh=oCYIjuW89ugmb
        yi2Z2bcvS41djt8ybKt3d7f3d7YUtg=; b=MpaLGSaJtda/meO2nTAhN9DT3q6Uy
        AkxW0eyOBXlGqw066njGrSEW1Eu6QPBQz8gVp2yN3kQsJjB/qqocqMAHNhF+DO+P
        ioO/+KCDWcsM5mkd/uqf1vFuL2IDgMw19wFtr8H68rFD6A74oxtqAXIpR62xxkoF
        BgBTndlxVKGpdn6g9KLQgVeGlGNkftsz5Pk3InWj8odoUtqCtdw0VeMsueuSAXZV
        Z+meKr+nn/7VkQxXTJonIeIIzqJabeEDCf7e0GLcFI+L6PGKdy8dlZ6FLsEkK9MM
        +NiHuk3zGFd/yY9M35Sz22fY/yy8rKeaLPQ63oLBpX116mbX7eL+JSdHQ==
X-ME-Sender: <xms:33USZfZAcbkSN8QCtuvncxGpsKPXgIYsjJsSIReBOXVReTblJGowbA>
    <xme:33USZebIUzSjZvt6N_6FeN8K5sBdt89_cS4EiFQnocuUiIrhaexA4ul1v1dKboMIM
    QI2eT5r2fgrHVa8EDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:33USZR-Gky2tN1vqb_XJk8lV_2y5pK0Upu7mfQAdSOYmDAjYzjzP4Q>
    <xmx:33USZVphx70509OBzc38Mvd8x6PaY5aM90xynxsfDgpUfldWeO4RQA>
    <xmx:33USZaoTl_b7HbfCBmNplViPJl8yTHsm0-PxiDHMby1GiB4ivUGb3A>
    <xmx:33USZZ2MP7jWG3cYDDrsd9VqvYUClaPgWkZ-5VFGFAdk9ABmjohJpg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 24B8AB60089; Tue, 26 Sep 2023 02:10:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <3a8f0d0a-25ad-49c3-9cd2-66db44a4a1e6@app.fastmail.com>
In-Reply-To: <ce00dad5acdd4aff099b289843e30c83f7e31764.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
 <ce00dad5acdd4aff099b289843e30c83f7e31764.1695679700.git.falcon@tinylab.org>
Date:   Tue, 26 Sep 2023 08:10:17 +0200
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
Subject: Re: [PATCH v1 6/7] DCE/DSE: riscv: add HAVE_TRIM_UNUSED_SYSCALLS support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 00:42, Zhangjin Wu wrote:
> For HAVE_TRIM_UNUSED_SYSCALLS, the syscall tables are hacked with the
> inputing unused_syscalls.
>
> Firstly, the intermediate preprocessed .i files are generated from the
> original C version of syscall tables respectively, and named with a
> 'used' suffix: syscall_table_used.i, compat_syscall_table_used.i.
>
> Secondly, all of the unused syscalls are commented.
>
> At last, two new objective files sufixed with 'used' are generated from
> the hacked .i files and they are linked into the eventual kernel image.
>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

As mentioned in my comment on the mips patch, hacking the preprocessed
file here is too much strain on the old infrastructure, the
asm-generic/unistd.h file is already too hard to understand for
anyone and in need of an overhaul, so let's work together on fixing
it up first.

      Arnd

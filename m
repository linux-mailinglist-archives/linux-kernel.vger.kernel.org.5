Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBA7AE580
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjIZGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjIZGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:08:10 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544011D;
        Mon, 25 Sep 2023 23:08:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 85E0D32009F4;
        Tue, 26 Sep 2023 02:08:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 02:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695708481; x=1695794881; bh=xZ
        //d5rAxIyL4DIO25l3Kqx9snAaHxvzdTIm60dV7fo=; b=k8GgK8b8bdbMrxec14
        vQF7AIOuOLxboNppmnLK9zaKi+d+Tp+yVgazv7sqFmNtdeP0aZyrlf2hB+9CyTyN
        Bxd1N65CUpF5BifXyNljwPU/YIJAYl8cEmqO9eW1ozNxx0StAkRpBJsp5R7EDOy3
        FVDekivSaQOYc5qjMWOJe79cnfv+KEySWlJ094MwFD1fYe9AtFT419Le66TH3vJS
        E2y7cYRgaD/RvN205GxckZuiYZ2JTGRiYZnv6SDpII80yMXXkEajwtcKgKWWqzNK
        vVHTE/5+Hwj8R9Qe888Dc/etYdGyczVAvk9/uNGBSGFRgL7TlnhQMY6CCmKac5/q
        jxuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695708481; x=1695794881; bh=xZ//d5rAxIyL4
        DIO25l3Kqx9snAaHxvzdTIm60dV7fo=; b=VGOMi6HnfP/cfR1kzW9zh1OSswSZv
        bKIiaa3E3Ar5x6E4b4QKSoqZ3FYSSs10iBjwp9sl7Wev0ChCekF3gGbCKH39kePz
        upTMKHZpcyO7pROwYUqN2j5eXZ7VWaj0rXuyvYr1v05qq/t0lTemD0UHnRkuxJh9
        uVe35RrBngFSnrTeZABHHKjP186/bfOc+BkMg259YYIeS0tXnIUQYq3vrnNuvOjU
        xWGOM82HD7sKxUoq/sjU2AmF57UgMjwe0/Thfr3oYK/oY2jMU2QMJEl/MkDxG7bK
        RbNtqegmLQoDj5AN0MYPtS74aYSHrMUXTg2BrqK+w9eSGeRC/akkkuqUQ==
X-ME-Sender: <xms:QHUSZajDXIX5_yCRxxvH7o-mrbsKQTdX0bAjIs3_kRQ9FyUIW5cH6A>
    <xme:QHUSZbBaHncRGc0IZDGhQ8qrMWwBalhH1sBWhKd9f9sClogo_5K9bcJarPYD7anHI
    a3D-seLtmR8uywxBGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QHUSZSEVBy-pvO9Y3AXNe4lXaTCLCq_hUJWd92qLhYb_FVX1DN9JXw>
    <xmx:QHUSZTQRT8BIkEhcXeJlYjH-WpkB1XpfGY-DiRGJbms_dx66_HEGvQ>
    <xmx:QHUSZXzPUhtAkHMiX8NWg9APAPN0R3Yp1_t8Srl28f1J7bDpSaBa8g>
    <xmx:QXUSZffm2tqYl_AVYJWmXUiqNNcVNPAYcaep-TztM4cGFhvs4vNBKQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0DEBB60089; Tue, 26 Sep 2023 02:08:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <862f42d7-b582-4d88-a9d2-f72ea5bfe903@app.fastmail.com>
In-Reply-To: <3042b32a13aecbf8f3c8bedee34a4ca8c7d7cb2e.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
 <3042b32a13aecbf8f3c8bedee34a4ca8c7d7cb2e.1695679700.git.falcon@tinylab.org>
Date:   Tue, 26 Sep 2023 08:07:40 +0200
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
Subject: Re: [PATCH v1 4/7] DCE/DSE: mips: add HAVE_TRIM_UNUSED_SYSCALLS support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 00:40, Zhangjin Wu wrote:
> For HAVE_TRIM_UNUSED_SYSCALLS, the syscall tables are hacked with the
> input used syscalls.
>
> Based on the used syscalls information, a new version of tbl file is
> generated from the original tbl file and named with a 'used' suffix.
>
> With this new tbl file, both unistd_nr_*.h and syscall_table_*.h files
> are updated to only include the used syscalls.
>
>     $ grep _Linux_syscalls -ur arch/mips/include/generated/asm/
>     arch/mips/include/generated/asm/unistd_nr_n64.h:#define 
> __NR_64_Linux_syscalls	165
>     arch/mips/include/generated/asm/unistd_nr_n32.h:#define 
> __NR_N32_Linux_syscalls	165
>     arch/mips/include/generated/asm/unistd_nr_o32.h:#define 
> __NR_O32_Linux_syscalls	89
>
>     $ grep -vr sys_ni_syscall 
> arch/mips/include/generated/asm/syscall_table_*.h
>     arch/mips/include/generated/asm/syscall_table_n32.h:__SYSCALL(58, 
> sys_exit)
>     arch/mips/include/generated/asm/syscall_table_n32.h:__SYSCALL(164, 
> sys_reboot)
>     arch/mips/include/generated/asm/syscall_table_n64.h:__SYSCALL(58, 
> sys_exit)

My feeling is that instead of postprocessing the generated files,
it would be much better to make the elimination part of the
existing infrastructure that generates the files from syscall.tbl,
and finally change the include/asm-generic/unistd.h to the
same format, as we had planned for a long time.

I should be able to help out with that part.

      Arnd

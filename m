Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F076B81B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjHAO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHAO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:57:00 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E7212B;
        Tue,  1 Aug 2023 07:56:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C708A3200973;
        Tue,  1 Aug 2023 10:56:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 10:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690901814; x=1690988214; bh=m5
        w/FN7NhnyKPGl0XOXnEVsMCY0ctzZc2rLRkLgXhMA=; b=JOsdkIsi/b9dWNyLQ8
        X1KkXWDDH/ZnpY8Uh33eF0SRVcZBVaPVYVawQXfYeerTRMeNJ1m86GJYSSwsemaR
        Jq89DQ6yKa2d5ZlvdNDoimGqsfsm/MBbLGuu5srkfM9YdtVgpMNuTxvfwwXL/ypL
        Hfw8Yk/BqJkvvUGRDrQYw2017BymUbKwYU6CmkC4vg1t8dde7M/HFZj+e6+xAu/r
        nIlQstCQu4zTqjlUQqpgNhUp/u7MO8yRt+OAxR3BJCiTV6XemFQ89+pNF6VDyVGs
        OUwZg/wq0oTyQGUqaqUlUE5t5Mh9Pk4q2X6VskUbJuElGkpghmNL9tIR0H0b6tS/
        WqJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690901814; x=1690988214; bh=m5w/FN7NhnyKP
        Gl0XOXnEVsMCY0ctzZc2rLRkLgXhMA=; b=jmu5Md0n9CSOV7Z5moH2KKyqndzH0
        393L8FYxxZfDSYejFJQ36QLi2KRqptTKu6pxjC+7D/1oTastlUd0+sOl6rbvG3Wx
        xnotnk0kRZuJeSjC9N8hGfxKLG5E61GYdOOEcYZwqK5rmISuG+SEYydQrb7I0ACQ
        oMmLFDvVrN2QewFxApMmoKTqhbWvQnJLhtWIKcdh1nmt0PiTbpeSXGrzbiOrYUWK
        DUdlNgJeGuwOZ4XLPoL/I17vxko+aHM7maMDmGwmwLwd9E6br3FXo5Wpj/p5v42F
        /GZjkp6Ak2jL//x2zeDVmOiyT9wgU/5QpEXZcrfBzZ6+gfBv16WOCQqmw==
X-ME-Sender: <xms:NR3JZI-gI3pBaM71ZJ4qYfQbhyvRqP7UbNGrRkUfyLR0gnruA9iDzg>
    <xme:NR3JZAvzNVFrAgE9jZzsU4gxPGpKi_ygVpDZA51jBmzPaljaJNLxh2mBBKHMGU9Q5
    5RGWIxK0LtKUAy5m2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefffefgheejtdejhfefuefggfffudehiefgffekheekffeghfdvkedthfdvjeej
    ffenucffohhmrghinheplhhinhgrrhhordhorhhgpdhkvghrnhgvlhdrohhrghdpghhoug
    gsohhlthdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:NR3JZOC12JuP5WwXVgaTbK_1WwJvSyBVYbhPf4917yKzAhNfOTKU0Q>
    <xmx:NR3JZIccED47NrbQTkOocpqJM-RXWMKnUjtX0g09BprR2VZjtl76Lw>
    <xmx:NR3JZNMzNYGrJJr4Z-eve96Z1NJhWxTIqd9PXt_vQh7WRHQqY8Ko-g>
    <xmx:Nh3JZA2XYrfAK00ILGpupCAoHYan74uFcrCpBxbN4HixGlQBbWO7_Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CAD6EB60089; Tue,  1 Aug 2023 10:56:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <227327a3-399a-4a9f-a775-e9627656b5a1@app.fastmail.com>
In-Reply-To: <CA+G9fYsYifn9ywPc8KqYHwDDSTRQGOgf_T58Gpt9CYDBs8u+SQ@mail.gmail.com>
References: <CA+G9fYur8UJoUyTLJFVEJPh-15TJ7kbdD2q8xVz8a3fLjkxxVw@mail.gmail.com>
 <a660adba-b73b-1c02-f642-c287bb4c72fc@acm.org>
 <CA+G9fYsYifn9ywPc8KqYHwDDSTRQGOgf_T58Gpt9CYDBs8u+SQ@mail.gmail.com>
Date:   Tue, 01 Aug 2023 16:56:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "Bart Van Assche" <bvanassche@acm.org>
Cc:     "open list" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        linux-next <linux-next@vger.kernel.org>,
        "Avri Altman" <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: next: arm64: gcc-8-defconfig: ufshcd.c:10629:2:
 /builds/linux/include/linux/compiler_types.h:397:38: error: call to
 '__compiletime_assert_553' declared with attribute error: BUILD_BUG_ON
 failed:
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023, at 16:23, Naresh Kamboju wrote:
> On Tue, 1 Aug 2023 at 18:53, Bart Van Assche <bvanassche@acm.org> wrote:

>> >   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/log
>> >   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/details/
>> >   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/history/
>>
>> I can't reproduce this build error with a gcc-12 arm64 cross-compiler. How
>> important is gcc-8 for the ARM community?
>
> You are right,
> gcc-12 build pass.
> gcc-8 build failed.

I can also reproduce this with gcc-9.5.0 from
https://mirrors.edge.kernel.org/pub/tools/crosstool/ but
not with 10.5.0 or clang.

I get the same results for x86 with gcc-9.5.0.

See https://godbolt.org/z/GjGrW9znc for a partially reduced testcase.

      Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC10768800
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjG3UgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG3UgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:36:20 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF65FE78;
        Sun, 30 Jul 2023 13:36:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B20255C006F;
        Sun, 30 Jul 2023 16:36:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 30 Jul 2023 16:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690749374; x=1690835774; bh=KX
        x1odTZH/+yyu8Xceytmb1rqrk/nlaenTURJ0pY3Bo=; b=NQKMjRqK0xMvMTQNgv
        iAifdPQ+ZfrI0rGu+Tehf2cN9P+75cBZV6qyzBYP9/cl0PHGmqm6D3P3gGsHyjTr
        S+M01OnB33J0JWjZoMc0jMNJnhSg43s3buwdvZdNLJYHa0COx9rFsTwyhtyf5mqK
        NJW9QUOXXmG0Z9EzwhiMtxS4QgxBdp8xap1LxOkuq9Zb2EZuqssgNmFGJDZf+5bk
        HBQKSKmtlBKcbh1KKJZiO7E7T+o0npHKaC4caulAihNpGQxJiSeTORNjbSRhCeaN
        wE8t5NkRIbej9ACZdOTCghDpu5+KMPDIpm7Qb6pQ4C3cfN80fV9S7OkVzILJRu1B
        c7Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690749374; x=1690835774; bh=KXx1odTZH/+yy
        u8Xceytmb1rqrk/nlaenTURJ0pY3Bo=; b=XcK3hl6SNRH0FRh9ZhQSBQTC2hpgR
        vq2D9BxSc+T5kyXofL/I9FfYKkXcYXYi6Uzn8I/zmHoE6oJZmYJudIm7laFKa3qc
        xPK1Y4tG20hJmgV2Qb4pGN6P18rvadmomk7IhK01sbV3nX79RwmztK8qMELzUjEA
        dl/A4O9h1e+2FTVRK0B6gHMyeiSKYtYShFR/WvubRtIGtlYD7Yk6FtTvRjXvjeOB
        /XMcctI6ix6rtUsy9/5eVkApBzt9uix73Hl70me3ZsSKXCQxsasDti4oYn4/lhB0
        gM0jJ8EhZB9LtAHuPknm2xoxRbBGFuXhlY7GayIUtMNNCUd1fx4DAd0nA==
X-ME-Sender: <xms:vMnGZDd90uJ1foq-grnJmtBlmUsF17Rbz69CrSheZjp5lLqE-hMUTA>
    <xme:vMnGZJPWyBhIPsbwpjdLFzApjvx0sybQ9b-Op_BuP0Tgg6_Xm8wYzJmbvKEmZjK1f
    U_T5vcRI4tIspQLMx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedugdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vMnGZMjGLz8XJmZOJKPjTD4r_uiTFXyKaJgtjAFWjT2TOoDAEs7bzA>
    <xmx:vMnGZE-_MsmlnFKJh2aZb_O-mAyWEsd_OKjQMJPxwe_SI1jZf1d4Og>
    <xmx:vMnGZPsylF0bgytZ9CtTuyWfA1QtygVBzKfwzcVMbNUiIHQ2j1aZfA>
    <xmx:vsnGZLRVyn53NbhgDOMKWCn6oF1H6ZMi2YyuD2rlHQj1YZ8ErcNjdw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 25B5BB60089; Sun, 30 Jul 2023 16:36:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <92c00ddb-e956-4861-af80-5f5558c9a8f5@app.fastmail.com>
In-Reply-To: <CAJM55Z8vF8_xq0QyByLUGM2W-8m6R-_6SdOFdLETV7J-yo5DMQ@mail.gmail.com>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZMZ6XB6gX2kFd/Nt@xhacker>
 <CAJM55Z8vF8_xq0QyByLUGM2W-8m6R-_6SdOFdLETV7J-yo5DMQ@mail.gmail.com>
Date:   Sun, 30 Jul 2023 22:35:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        "Jisheng Zhang" <jszhang@kernel.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        guoren <guoren@kernel.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Samuel Holland" <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        "Christoph Hellwig" <hch@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache operations
 support
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023, at 17:42, Emil Renner Berthing wrote:
> On Sun, 30 Jul 2023 at 17:11, Jisheng Zhang <jszhang@kernel.org> wrote:

>> > +
>> >  static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
>> >  {
>> >       void *vaddr = phys_to_virt(paddr);
>> >
>> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
>> > +     if (unlikely(noncoherent_cache_ops.wback)) {
>>
>> I'm worried about the performance impact here.
>> For unified kernel Image reason, RISCV_NONSTANDARD_CACHE_OPS will be
>> enabled by default, so standard CMO and T-HEAD's CMO platform's
>> performance will be impacted, because even an unlikely is put
>> here, the check action still needs to be done.
>
> On IRC I asked why not use a static key so the overhead is just a
> single nop when the standard CMO ops are available, but the consensus
> seemed to be that the flushing would completely dominate this branch.
> And on platforms with the standard CMO ops the branch be correctly
> predicted anyway.

Not just the flushing, but also loading back the invalidated
cache lines afterwards is just very expensive. I don't think
you would be able to measure a difference between the static
key and a correctly predicted branch on any relevant usecase here.

     Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59647FC907
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbjK1V7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1V7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:59:41 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E17198;
        Tue, 28 Nov 2023 13:59:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C9DE05C01C9;
        Tue, 28 Nov 2023 16:59:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 28 Nov 2023 16:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701208783; x=1701295183; bh=d8
        dJOAJYV2mmOf6TcGIvZmDZwHIgzbX0ltRZ3M1V2lw=; b=YadBYp87SiMJCaGzl2
        yVc3F50keLYMG0BPExwY8/BqRr1jtomyhEMHUHcjv1B7Y0wKLCawIKdX6iESbFQQ
        4vhEAkznbyaTd6QYK3Aw58pnQHFyNK7vOzA0xuTo1K++WTdH5Hw9XWP9l0j+6nVn
        aMeRCc5Uf2YujIdPdbaVOX/Bh3mZ+/TW16bSdDf4ucNINlZNB1pXhksKlpfCROo/
        6m4seBQbPWXnNI+dzGPyZfycWzf88q44WxOIe7T3h+z2rLUlaWRhfIufbJOOfLdV
        ItxFUAyRfq4woqYXsdgd8c8vLoaSeWJRAzQis6EPnhDwx7jnuVX6WuyHBj8WbET3
        jmvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701208783; x=1701295183; bh=d8dJOAJYV2mmO
        f6TcGIvZmDZwHIgzbX0ltRZ3M1V2lw=; b=YRhLjdkUetYblVbHU3qi3TsBj1N2h
        l371QqfFu4yKaZo3e7wvdFu3CVifWDqBD8dyKz2ggJ4czdkoJzGz06jtLorXUU+6
        RvWcCmE9CLI7OpYTNPr2fSgg/fdrdB14owu5Zn/rvCfBNCJ5xtt187Tvi1UaG+gT
        fGPzNFACe1HInjwdphnTR9FoPucssW079THQ01K0hPBWOAJK/e6lVzFBv4ZMT7sK
        EizBVnE11+dpAYOLLJ3xMQxHPUPqh2PKIrrp9zU5mkLJ6cRdtHa1u7X0wmPT+B+t
        3tEeaZWfKA5axK/pCDxMSm/P9w+dco8mszuqdC14OBpH/v2oah6z2Xfww==
X-ME-Sender: <xms:zmJmZb3O7tz8UuCX34Rn3M6sKvNG9N9HnwtRSnNKVnLmvL_YHCc2Yw>
    <xme:zmJmZaHwnWMoR0sl6URtWgfkI0DFEkmahH_9Z2MIpTIPgnXe8THtaV-n244CqPda9
    yPCC1FHZ8WsoY_wMAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zmJmZb5yPLqTPRHYUrooghTHvcLDx4wQxgxZ14cQzvaSCiD1ZAF4dQ>
    <xmx:zmJmZQ373mqOsYB-HA5iTc6aJBCrxpkHOc47MjyLqeZA06N54nbWKg>
    <xmx:zmJmZeFWvsgXQqwrMDFVDDw2pagiE28iAO3k1HCBrc60O5RDW-NnnQ>
    <xmx:z2JmZcGX0YtYNEWQuMvvSVOro-SvT-xoqxQYgMlal-5ZjNj0PeT3vw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4C268B60089; Tue, 28 Nov 2023 16:59:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <00c225bf-ed99-4721-9d6a-1e58cdffc79f@app.fastmail.com>
In-Reply-To: <fvbe4625dgh57c3njx7fhd6vlnfxynzipfz43ieu2txflc2q4r@xzvrrmmktxsb>
References: <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c1c0a409-902e-4609-ae84-8939226b4fa0@app.fastmail.com>
 <fvbe4625dgh57c3njx7fhd6vlnfxynzipfz43ieu2txflc2q4r@xzvrrmmktxsb>
Date:   Tue, 28 Nov 2023 22:59:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Serge Semin" <fancer.lancer@gmail.com>
Cc:     "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Yinglu Yang" <yangyinglu@loongson.cn>,
        "Alexey Malahov" <Alexey.Malahov@baikalelectronics.ru>,
        "Aleksandar Rikalo" <aleksandar.rikalo@syrmia.com>,
        "Aleksandar Rikalo" <arikalo@gmail.com>,
        "Dragan Mladjenovic" <dragan.mladjenovic@syrmia.com>,
        "Chao-ying Fu" <cfu@wavecomp.com>, "Marc Zyngier" <maz@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mips: dmi: Fix early remap on MIPS32
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023, at 14:52, Serge Semin wrote:
> On Tue, Nov 28, 2023 at 01:41:51PM +0100, Arnd Bergmann wrote:
>> On Mon, Nov 27, 2023, at 17:23, Serge Semin wrote:
>> > On Fri, Nov 24, 2023 at 10:03:49PM +0000, Jiaxun Yang wrote:
>> but ioremap_cache() is generally underspecified because the
>> resulting pointer is neither safe to dereference nor to pass into
>> readl()/writel()/memcpy_fromio() on all architectures.
>
> I don't know about ARM64 (which for instance has it utilized to access
> the DMI region), but at least in case of MIPS32 (a fortiori MIPS64
> seeing the ioremap_cache() method actually returns a pointer to the
> uncached region) I don't see a reason why it wouldn't be safe in both
> cases described by you. All IO and memory regions are accessed by the
> generic load and store instructions. The only difference is that the
> MMIO-space accessors normally implies additional barriers, which just
> slow down the execution, but shouldn't cause any other problem. Could
> you clarify why do you think otherwise?

On arch/powerpc, CONFIG_PPC_INDIRECT_MMIO makes all ioremap()
type functions return a token that can be passed into the readl/writel
family but that is not a pointer you can dereference.

On s390, the mechanism is different, but similarly __iomem
tokens are not pointers at all.

>> There was an effort to convert the remaining ioremap_cache() calls
>> into memremap() a few years ago, not sure if that's still being worked
>> on but it would be the right thing to do.
>
> I see. Thanks for the pointing out to that. I guess it could be done
> for MIPS too (at least on our MIPS32 platform DMI is just a memory
> region pre-initialized by the bootloader), but the conversion would
> require much efforts. Alas currently I can't afford to get it
> implemented in the framework of this patchset. (I saved your note in
> my MIPS TODO list though. Let's hope eventually I'll be able to get
> back to this topic.)

I just noticed that the only architectures that actually provide
ioremap_cache() are x86, arm, arm64, mips, loongarch, powerpc, sh
and xtensa. The ones that have ACPI support still definitely
need it, most of the other ones can probably be fixed without
too much trouble.

     Arnd

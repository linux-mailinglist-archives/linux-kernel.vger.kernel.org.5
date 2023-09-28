Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813B7B2228
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjI1QV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjI1QVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:21:25 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639CE136
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:21:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 297385C0326;
        Thu, 28 Sep 2023 12:21:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 12:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695918079; x=1696004479; bh=p4
        69W9XInE59/vnc2w8MJndcGm8KAMBXNFVAn/JwZEc=; b=Z1Kq296job7vIE/mHu
        VbYAvcBzkKkYvSUTPLWGS9loNusIlqPcMhqfwYzenbo798nIvGXv5wuF2KgxJqPH
        ZaZXEaYppw1FXDHgmY+DrHYXD9IfywbETYIHhmB/qPcfAum6z9xlwfvcWnZoW2sQ
        VUuPjWuglLUqof6omzQUt7UyRjK4esti+K/gM1FourvAcCwvS4Efa89U0gr1+72e
        IsT33D1cBpvIygNIf+G8wIX6NIN6ujO28aTfuPsWmHklIWyE/iENqWyfYVJKMWRb
        XbcJ8IEqBNO7tO9gXrnaHnwUqOn6chylfEZrgkMPvEnHn3TgNRu4NoAwtXo6WvKR
        pOFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695918079; x=1696004479; bh=p469W9XInE59/
        vnc2w8MJndcGm8KAMBXNFVAn/JwZEc=; b=JD7SZWCc1+erEigqzF1UR86Q4nect
        JM6ZE+yzZCwc3yzImH8KKsd4HEZkv4XhXnacHvPrQsO7lVWMwz4sgLwpGNP0dxav
        +rrzXE709wxj6CLygtVwG9azQI6yba22R/ifCP/41p+L3VaDjTOiMCW5DDlyzIk3
        NYXVqZQ8CQ3fxpy0uyUU/TCJMwaAJw5pQfMgds7iTKzwMJqsbwaxSL6ltntAJhqI
        oZw2tKxfvf9g4Rr1tWgr/ivdDokveDrFIlOrDqaUOcpBHqHNvxkTKOAb65QMRc9I
        w/HNplw9LVYkjN+h1K/rUgziIuV3sz2WkqxZS5mZmL7rIteixAPwyjD3g==
X-ME-Sender: <xms:_acVZYTxMWUApzkIKal8tRvtBIEhMVFJHLlIyxO3jZkRlKWHsL3X1Q>
    <xme:_acVZVyJ5lp8o1J0ov0IerXb_D5I2AsSOSMmFEzk65qBJzocA5DE8LsyamzeqxDNc
    oOVZfI8kYhttVVeh3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_acVZV18wTPrdwuv0rJt7fhWcjc7aPLayZETCa0yrdmyjZeJfq8Ipg>
    <xmx:_acVZcDtvG-TZiXGlunAQLmOaenN1fapZFcTYRpsF15XXzJukVcTwg>
    <xmx:_acVZRh_TzrUklrHM9LuZe19kShAvWa36N6A1EvWSc-_GomerE7qNg>
    <xmx:_6cVZaY_EABsQAfjiymdPIjjkh3Cu1Ivv7Hgo6eXIBzvR6tvwlFOcA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A70AAB6008F; Thu, 28 Sep 2023 12:21:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <ee63dd71-77d3-4d98-9f7f-64c82ae8045c@app.fastmail.com>
In-Reply-To: <f0b03b73-cb01-f613-c4a6-da546ab47464@arm.com>
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com>
 <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
 <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com>
 <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
 <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com>
 <f0b03b73-cb01-f613-c4a6-da546ab47464@arm.com>
Date:   Thu, 28 Sep 2023 12:20:56 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Robin Murphy" <robin.murphy@arm.com>,
        "Jim Quinlan" <james.quinlan@broadcom.com>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Christoph Hellwig" <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        "Russell King" <linux@armlinux.org.uk>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Eric DeVolder" <eric.devolder@oracle.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Claire Chang" <tientzu@chromium.org>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, at 11:33, Robin Murphy wrote:
> On 28/09/2023 4:16 pm, Arnd Bergmann wrote:
>
>> It's unlikely but not impossible, as the driver has some
>> unusual constructs, using a lot of coherent mappings that
>> might otherwise be streaming mappings, and relying on
>> dma_sync_single_for_device(..., DMA_BIDIRECTIONAL) for other
>> data, but without the corresponding dma_sync_single_for_cpu().
>> If all the testing happens on x86, this might easily lead
>> to a bug that only shows up on non-coherent systems but
>> is never seen during testing.
>
> Probably the significant thing about restricted DMA is that it forces 
> all streaming DMA to be bounce-buffered. That should expose busted 
> synchronisation even more decisively than a lack of coherency. If 
> there's no IOMMU, then testing the driver in the absence of restricted 
> DMA but with "swiotlb=force" should confirm or disprove that.

I see this sequence in the iwlwifi driver, in the
iwl_save_fw_paging() function:

       block = alloc_pages(GFP_KERNEL, order);
       phys = dma_map_page(dev, block, 0,
               PAGE_SIZE << order, DMA_BIDIRECTIONAL);
       memcpy(page_address(block), ...);
       dma_sync_single_for_device(dev, phys, size, DMA_BIDIRECTIONAL);

Which clearly violates the interface by writing into
a page that is already owned by the device, without
giving it back to the cpu first. Not sure if or how this
would explain actual data corruption on armv7, since we
write back the buffers in both the map and sync operations
and never invalidate the cache, but the driver also doesn't
ever read from the buffer (despite it being bidirectional).
If it's not this problem, there is a good chance of others.

     Arnd

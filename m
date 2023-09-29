Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912FA7B3ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjI2TxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Tw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:52:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999EBB4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:52:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5B7C0320024A;
        Fri, 29 Sep 2023 15:52:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 29 Sep 2023 15:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696017173; x=1696103573; bh=Xnud7i5mgK2eh+mvhdn41o9zzX9PrdtiIrm
        +V6iN9Ac=; b=LETLOekAVF6F970qHbuvW17gVSn4E4NspDqbmHAPksHJ5BNT2Xb
        LhpfDpWBwiR+Ajjp0qexs2NtpACv2ACWbpdoIsOGRtZC1Y/lDrAkil/fiPT+ZHGf
        nYGVVV/a80owmQKh0lWZnZLHM5ctBNa3XZdccmY9YpW3xYOi/gM6GZyuK1TRBVDm
        8uwL2y2L1YKDFWozuyNWvXHijQYlNhYVDkhWiZIlIK9+CVdJRGzggGqMRS0BgfK6
        OaNXBxv08HH9nzVt7cmszTD4rh6AQaoZOtJxmOsBCArTWI7M6gVsufPCOq3wS+fn
        BCU+R8NqmNncsWhf9gE7Suis4WiAbFFkKcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696017173; x=1696103573; bh=Xnud7i5mgK2eh+mvhdn41o9zzX9PrdtiIrm
        +V6iN9Ac=; b=Mq5thkXuxCuBCKOFim/mtAJSIub9suLEpKOAW5FnU6rofegxxfA
        XbhKFW/7alwyo3OoaVWtCMbYslPoLrGDQAWHlkXt1wWP6kZuLuyJaJalX9fbxuYX
        WLI3C33Wny7TJYjWRJ0KX3oQCfep/X4PjWkKJfvTUyMo3qaXqMfx5lspwjZsLTj+
        +Z83LoETzZv+3iM3ovD1bDfFFXM/ua8Jkn7LwtMSztBy57iEy+rH+s7hSU3dBkYN
        WktIuivEM3aLqEkh2Uki+iF3Vy36t3eHvU4DCJdCTDb8S7ASoA9CNEbMAiTAJvjv
        4KsRjtSskVgnmnbYnS0OX1BUoUC/4QNzCMA==
X-ME-Sender: <xms:FCsXZaDDQeGBSrz6rNVPDOnfQvoxmyTqOuS3Dt5bOib5fr20HSooQA>
    <xme:FCsXZUgnOF7J_8lSM-SHSMW7VOCDQPUVa1-tGmtPv_IrM8AGWV1ngOucPebR4wdZA
    Xi0Jxdc7OE1y3uqB3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtdefucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueeffeeigeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FCsXZdnB8y5M7xcddh9XInbhtgJjcMX_Vpb6C3VECfpMU3SgectvTA>
    <xmx:FCsXZYzr4SSYAwr7mg5EzFYMW10qCKYceey8rcnDkd4y2afks6q59A>
    <xmx:FCsXZfTWJHcpiHWDLOS-hMoFP9WaDhuHlto0s32-lqK9mYWdnRS6Pg>
    <xmx:FSsXZQLGCvnayApJY9cqqbOLnoI2VxMMLqYIGWgh4dcN6p0MzVrwrg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4952BB60089; Fri, 29 Sep 2023 15:52:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <edc3a774-adc0-4873-8ebe-a346b51cb9ca@app.fastmail.com>
In-Reply-To: <CA+-6iNwmkV0PagHehOhnYxOjwURhXZy-GnVzhkBL+9YaGMRmgQ@mail.gmail.com>
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com>
 <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
 <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com>
 <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
 <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com>
 <CA+-6iNwmkV0PagHehOhnYxOjwURhXZy-GnVzhkBL+9YaGMRmgQ@mail.gmail.com>
Date:   Fri, 29 Sep 2023 15:52:17 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jim Quinlan" <james.quinlan@broadcom.com>
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
        "Claire Chang" <tientzu@chromium.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023, at 15:24, Jim Quinlan wrote:
> On Thu, Sep 28, 2023 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> On Thu, Sep 28, 2023, at 10:00, Jim Quinlan wrote:
>
> Our RC is definitely not coherent with the ARM/ARM64 caches.

Ok, thanks for the confirmation.

>> It's unlikely but not impossible, as the driver has some
>> unusual constructs, using a lot of coherent mappings that
>> might otherwise be streaming mappings, and relying on
>> dma_sync_single_for_device(..., DMA_BIDIRECTIONAL) for other
>> data, but without the corresponding dma_sync_single_for_cpu().
>> If all the testing happens on x86, this might easily lead
>> to a bug that only shows up on non-coherent systems but
>> is never seen during testing.
>>
>> If the problem is not the "dma-coherent" property, can you
>> double-check if using a different PCIe device works, or narrow
>> down which specific buffer you saw get corrupted?
>
> I've done some testing, below are the results.  The new two devices, a
> USB controller
> and an M2 NVMe stick, behave the same as iwlwifi.
>
> Note that I'm not advocating that "select DMA_DIRECT_REMAP" is the
> anser, I'm just showing that it fixes my examples.

Ok, so I think we can stop looking at the device drivers for
bugs then.

> VER      PCI-DEV                       <--------- RESTRICTED DMA -----=
---->
>                       ARM64    ARM     ARM64    ARM    ARM+DMA_DIRECT_=
REMAP
> 5.15     iwlwifi        P       P        P       F             P
> 5.15     nvme           P       P        P       F             P
> 5.15     usb            P       P        P       F             P
>
> 6.1      iwlwifi        P       P        P       F             P
> 6.1      nvme           P       P        P       F             P
> 6.1      usb            P        P       P       F             P
>
> Upstrm   iwlwifi        P       P        F       F             F
> Upstrm   nvme           P       P        F       F             F
> Upstrm   usb            P       P        F       F             F
>                       ARM64    ARM     ARM64    ARM    ARM+DMA_DIRECT_=
REMAP
> VER      PCI-DEV                       <--------- RESTRICTED DMA -----=
---->
>
> LEGEND:
>   P       :=3D pass, driver probe and some functional test performed
>   F       :=3D fail, usually when probe is called; impossible to do
> functional test
>   Upstrm  :=3D 633b47cb009d "Merge tag 'scsi-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi"
>
>   iwlwifi :=3D 7260 Wifi 8086:08b1
>   nvme    :=3D 1e95:1007
>   usb     :=3D Supahub, 1912:0014

Thanks for the thorough testing, that looks very useful, even though
I don't have an answer immediately. Maybe Robin can see something
here that I don't.

It's particularly interesting how arm64 only started failing
on fairly recent kernels, so if nothing else helps you could
always try bisecting the history between 6.1 and 633b47cb009d,
hoping that the commit that broke it points us to the arm32
problem.

The only change I see in that time frame that seems related
is 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache
invalidation from arch_dma_prep_coherent()"""), so you could
start by reverting that. However, it's probably something
else since this is for the coherent mappings, not the
streaming ones.

       Arnd

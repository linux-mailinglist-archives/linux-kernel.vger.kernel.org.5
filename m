Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43D7B20E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjI1PRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjI1PRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:17:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD24CD4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:17:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BE8725C25FF;
        Thu, 28 Sep 2023 11:17:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 11:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695914237; x=1696000637; bh=guUXz8cYY0yQUNOCyKqcjrjmSl7M48U0TTd
        HZunOnk4=; b=ZtMSRMKmXEuyWV+y5HTAlmtoN+pglESveGXg7lTYt6QFXgbzdNf
        /K5BZACVM+Dg40jL5n5OJiNGVnO0dU9dKf+87vTUjwU4/WTn7aXrE5CR4Fp8cjvU
        hPueckwDbHUP2yr+s/HjIIDOY8IszoDy1dhMi22xb2OFitgVZfvtwYDykbXKBD/q
        WOobyNHFftNfjLvmmgjNor+4CGj4Us6Oq9X8pFT3WoHQGSGzi5KJe0YN7vqodrY+
        AdpaGWD6qcIaGk5MA54txyFlJKaj1TL9qxJagkXr/q7NKE9rbfIzbbtZ0tFO+DmM
        /er/ibTmaENeB5OrjvR6dZDOWSI2su/JdfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695914237; x=1696000637; bh=guUXz8cYY0yQUNOCyKqcjrjmSl7M48U0TTd
        HZunOnk4=; b=B28IRvs1ZTGZeSKFxMXDQKIMHoqnEZyE1ZtoVpc1id59ygl/W1Z
        oBn1qcGHjssi9MkDPsx11Du+5LoRu9nXcGYXg0nw+P/S4pmiKdvZ0/t892C2mTTw
        QwcUmAf/gRP2lmFVuN+StOCuPMhVOXYbQY7NPCb3rHZ1EnyK3vDO8pTJZv2Oe57J
        hk8DOGq9Q3hOh0jJXrEAMr7VYYMu1fEzo9UKC/uvWoV04zuHKNYnECJuLjZOamyo
        mFh8uF7O+RaHHa7BHSwUKXexmSG3t9BLfTAy8Wp1x+ex7JkAG2Qr12q1usd5axWb
        iHp7gSKSxFifpJeQb97J/AVPy/QumYTFIQA==
X-ME-Sender: <xms:9ZgVZehDyQEv2GebL1DbFWM9BJmNauqQO76sPD--iYU8VSFJ91Xm5w>
    <xme:9ZgVZfB1iqec_oP33SxunyIWZqndURHDGX5Ii5S55VX5TKs6ThsRFLMXFzey7mhdY
    S2AORRv8OvJ1ZSEBUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:9ZgVZWEviozFPreEbsUGvRWgJ1BPe-pkPkUiDJ_RUz7eivbfBV-tAw>
    <xmx:9ZgVZXS-tg0hjubjYuAk8tK9eVK55qxwrErJ9Xw_zFcjEWiNR64eMQ>
    <xmx:9ZgVZbwTH22_ArkjnzGej_Wgzeewj4vmCWc-kOf-EniyzJqoy-xYyQ>
    <xmx:_ZgVZblv2JoROUYdLFrmwW0poJk89BgDm_Mnscx5M0TaAJKAMU_ggQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 021FDB60089; Thu, 28 Sep 2023 11:17:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com>
In-Reply-To: <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com>
 <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
 <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com>
 <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
Date:   Thu, 28 Sep 2023 11:16:47 -0400
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
        "Claire Chang" <tientzu@chromium.org>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, at 10:00, Jim Quinlan wrote:
> On Thu, Sep 28, 2023 at 9:32=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> On Thu, Sep 28, 2023, at 08:07, Jim Quinlan wrote:
>> > On Wed, Sep 27, 2023 at 7:10=E2=80=AFPM Linus Walleij <linus.wallei=
j@linaro.org> wrote:
>> >>
>> >> Clearly if you want to do this, surely the ARM-specific
>> >> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
>> >> needs to be removed at the same time?
>> >
>> >
>> > Yes, this is the reason I used "RFC" as the fix looked too easy to =
be viable :-)
>> > I debugged it enough to see that the host driver's
>> > writes to the dma_alloc_coherent() region  were not appearing in
>> > memory, and that
>> > led me to DMA_DIRECT_REMAP.
>>
>> Usually when you see a mismatch between the data observed by the
>> device and the CPU, the problem is an incorrect "dma-coherent"
>> property in the DT: either the device is coherent and accesses
>> the cache but the CPU tries to bypass it because the property
>> is missing, or there is an extraneous property and the CPU
>> goes the through the cache but the devices bypasses it.
>
> I just searched, there are no "dt-coherent" properties in our device t=
ree.
> Also, even if we did have them, wouldn't things also fail when not usi=
ng
> restricted DMA?

Correct, it should be independent of restricted DMA, but it might
work by chance that way even if it's still wrong. If your DT
is marked as non-coherent (note: the property to look for
is "dma-coherent", not "dt-coherent"), can you check the
datasheet of the SoC to if that is actually correct?

If the chip is designed to support high-speed devices on
PCIe, it's likely that the PCIe root complex is either coherent
with the caches, or can (and should) be configured that way
for performance reasons.

>> It could also be a driver bug if the device  mixes up the
>> address spaces, e.g. passing virt_to_phys(pointer) rather
>> than the DMA address returned by dma_alloc_coherent().
>
> This is an Intel 7260 part using the iwlwifi driver, I doubt it has
> errors of that kind.

It's unlikely but not impossible, as the driver has some
unusual constructs, using a lot of coherent mappings that
might otherwise be streaming mappings, and relying on
dma_sync_single_for_device(..., DMA_BIDIRECTIONAL) for other
data, but without the corresponding dma_sync_single_for_cpu().
If all the testing happens on x86, this might easily lead
to a bug that only shows up on non-coherent systems but
is never seen during testing.

If the problem is not the "dma-coherent" property, can you
double-check if using a different PCIe device works, or narrow
down which specific buffer you saw get corrupted?

     Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3857B1E78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjI1NdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjI1NdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:33:01 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E7196
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:32:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 10A915C0145;
        Thu, 28 Sep 2023 09:32:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 09:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695907979; x=1695994379; bh=p5cefE8C1CwlgpUHYq3dLNNX5/KWHU5zG5b
        A7CGF3xM=; b=iSaF1I3Hhe5fqkmDR2jWoX20fTbrJwWAIBOgBmMGJmx3PUcWudF
        AMLc3+nRa3KUppaUobrWEXRYSZ/D9R+70Z4+3o0c5gTvZ68P9RLcz85HFw21DNAH
        kl4PxBgextOShnSVVrXjHWQt9gOOsd9dTuQPrUaubgXdqiCSciK9Go9/XwS4f2NX
        h2kHP4AerkUzY3l8jshN6M0sri2CMYu9ghUCnyFCAJfk5Azyah4zmyJLe9rr/3HH
        GSfW3xcmE/3aDKvnyz6mFI+J/HQ/g7fQAEJxHcTxEOLDRpVy6PDV2wVc92eVA/zS
        GDrDqiYm8SQNkcqU71d8er4FTAy/tfpkReg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695907979; x=1695994379; bh=p5cefE8C1CwlgpUHYq3dLNNX5/KWHU5zG5b
        A7CGF3xM=; b=asKPp9HT5ko1OK/VCHu79KA2qEvayaMZR/kEysd/FXnTovx9n1R
        WHnzxtUI1goe4+lAiPkdwNp4b1YwqFiMYJYiK2s3Ek3QBas7Z30nbsqTE5khlcyq
        XfzDAhxQNQpaJ2DQ++G8kDexygAWYPQVKgvKSCmHgbRRPP3ro8kFIEVpMTxr/mbq
        Wv6kbKaqIQ+irWTR5JECajXlixj4YpTfzA8Tck50Kq2F+rHPR+fQvEneLl28RMCt
        U04qDqquokk11mioWyN3a8MTdi0cOGzNR+oChey4A1IiERT7M0S5DViYig3exZ4d
        CHQT0HC3ccAF6hhhAjOkB08Th8dlvR4B+AQ==
X-ME-Sender: <xms:iYAVZTUDVYpLb4n_2HIOoKbwRAPzxXY2Bzbpt72CE5FDnBAguuqBWQ>
    <xme:iYAVZbkX5nlQde9omsIkkkmHtAegKPRIJzQ_4Dcsqy8gLq9pgP8oOrj6WsfLm2KS9
    B7t7E2yIa4sqizWQfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iYAVZfanNOSzSbUtbhk5aYqZRvdSOEh3yi4ByVwvhVPE-RPfDvuCHQ>
    <xmx:iYAVZeXz_ejCUF3p1VrlkUXj_vyCN57LVUKVZ6A67BcKGSDHfPw-sQ>
    <xmx:iYAVZdlaoAaH08qEkQ2OOsPo4_HzmHHhB2XxZWvHITFdwplW8yeHjA>
    <xmx:i4AVZYpIauBdkEZdRcO4z15fFwgTfT2FVbO6qEAy4c6fNy-CyWQz_w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 06274B6008D; Thu, 28 Sep 2023 09:32:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com>
In-Reply-To: <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com>
 <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
Date:   Thu, 28 Sep 2023 09:32:35 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jim Quinlan" <james.quinlan@broadcom.com>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Christoph Hellwig" <hch@lst.de>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, at 08:07, Jim Quinlan wrote:
> On Wed, Sep 27, 2023 at 7:10=E2=80=AFPM Linus Walleij <linus.walleij@l=
inaro.org> wrote:
>>
>> Clearly if you want to do this, surely the ARM-specific
>> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
>> needs to be removed at the same time?
>
>
> Yes, this is the reason I used "RFC" as the fix looked too easy to be =
viable :-)
> I debugged it enough to see that the host driver's
> writes to the dma_alloc_coherent() region  were not appearing in
> memory, and that
> led me to DMA_DIRECT_REMAP.

Usually when you see a mismatch between the data observed by the
device and the CPU, the problem is an incorrect "dma-coherent"
property in the DT: either the device is coherent and accesses
the cache but the CPU tries to bypass it because the property
is missing, or there is an extraneous property and the CPU
goes the through the cache but the devices bypasses it.

It could also be a driver bug if the device  mixes up the
address spaces, e.g. passing virt_to_phys(pointer) rather
than the DMA address returned by dma_alloc_coherent().

    Arnd

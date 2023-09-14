Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742847A09EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbjINP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjINP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:57:20 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10AE1BDD;
        Thu, 14 Sep 2023 08:57:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 25FD75C0794;
        Thu, 14 Sep 2023 11:57:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 14 Sep 2023 11:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694707036; x=1694793436; bh=D1
        Dh6oQfyKo2m4In2UHMqMu6/cg0jek1Ga5qSZ41amY=; b=DO1KxuA4yLhkDnUhZc
        oF9OHCmT2d2aBxzyJPfSKuWWUj1zD0X5ZSPbRY9cHzaXtA13Cdz1tFR7/QuqfFtr
        V1/ARdbuDHWfsIwkEuv3nxL5xFoMJd4WEKQZhiqZFfctQaZXpGuYz5yKoCn4sYJn
        BOBvLXxrVNceKQWyndYn9LaoVMbAa9AYpXVDg8ct/KaRh+R+tadNLGDzwcAOBZI6
        IscHgtIwgugCAaBgc2wn1w8s3wgNmWU/Y4UmnL23zAZhK2RYE8t30k0V+nxB7c1h
        ye6X7rKxxd7FUQHKCYfID+eyZN+5LYlZAXyMxv1qr/ikSR+otgYcfMTXd9f2UnBZ
        q8bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694707036; x=1694793436; bh=D1Dh6oQfyKo2m
        4In2UHMqMu6/cg0jek1Ga5qSZ41amY=; b=NC35CZ5wO9IDwGD/4Zih/FLMTGX6J
        NtVFGFImU4agnQuH2UXmtD82OBUpHTS35WdXov2Dj9mDPjhMGtUYrzhDnaaILo3H
        JyrTrIL4CRZ8YUZR0QrxDqNidKRCheRMOhhyKJT+JMPX4F26+IKoOn5o+FEWm3bJ
        AH7rWvE/GEAJN8rez6wjH5UJLRG+y2MmfOCr6Wt9QqED9rHMDtzbsiDynuStIE+R
        40bYsxVfIGgrGhAYKYjF02tp0NdFOhR5p3DwvcAgF6ITgE+jSY6EZTyjoz4cwSe1
        sk76Hi4yfFHqzmx4JT99EH/5bi4pw8J4hPOXmfuv8Jlv2Ba9hP16Xicow==
X-ME-Sender: <xms:Wy0DZQp89EVJx81r_dhkzejH2uIBct3lYp8KycGFdEzjlxEjsk96Lw>
    <xme:Wy0DZWrot73VY9VpbloKV3AlkRXN1-36rPvmaw7tFUCBZeFd7mNdm184-f3CTLAwF
    syJczCV4DbdhHe2SP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Wy0DZVOJNSds_ig4NZ_Ly-kgR4WmRoioq7KUAK7IOLt3xH74DpR8Jw>
    <xmx:Wy0DZX52k6IHu6bOC-papL0Tbqrt1egKUTU9mPfQzhHUVACHboKt0g>
    <xmx:Wy0DZf5rqnElCJxBXSLZ4It4BOD6dzo6_-eKcJLafBUt6xkiIMr4CA>
    <xmx:XC0DZS0o_QqtHB2HNaEOwC4psmyEjlQ_xAmaf5oSDSZl3fV2lUUivg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2D2FBB60089; Thu, 14 Sep 2023 11:57:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <73cdb822-4819-4621-bbd0-de60392552b5@app.fastmail.com>
In-Reply-To: <70e9fe45ca8bbe2dec5541a0c21bee3de8f82f91.camel@physik.fu-berlin.de>
References: <20230802184849.1019466-1-arnd@kernel.org>
 <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
 <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
 <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
 <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
 <70e9fe45ca8bbe2dec5541a0c21bee3de8f82f91.camel@physik.fu-berlin.de>
Date:   Thu, 14 Sep 2023 17:56:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, linux-sh@vger.kernel.org,
        "Rich Felker" <dalias@libc.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023, at 08:23, John Paul Adrian Glaubitz wrote:

> On Wed, 2023-09-13 at 16:30 +0200, Arnd Bergmann wrote:
>> > In the meantime, there is a v2, which I wasn't aware of when I wrote
>> > my previous email, so perhaps my comment is no longer valid.
>> > "[RFC PATCH v2 00/30] Device Tree support for SH7751 based board"
>> > https://lore.kernel.org/linux-sh/cover.1694596125.git.ysato@users.sourceforge.jp
>> 
>> Right, it looks like the GENERIC_IOMAP part if gone from that
>> series, and I also see that the PCI host bridge does not actually
>> map the port I/O window. That's usually fine because very few
>> drivers actually need it, and it also means that there should be
>> no need for GENERIC_IOMAP or the simpler alternative.
>> 
>> The first version probably only did it accidentally, which is a
>> common mistake, and I think the ones for hexagon, m68k, and
>> mips can probably be removed as well with some simplifiations.
>> 
>> x86 and ia64 want GENERIC_IOMAP because they require using
>> custom instructions for accessing IORESOURCE_IO registers,
>> but it's not really generic.
>
> Would you suggest to apply your series before or after Yoshinori's series to
> convert arch/sh to device trees? If you want it to go in before the conversion,
> could you rebase your series against v6.6-rc1?
>
> I'm asking because the current version did not apply against v6.5-rc2.

I've rebased and resent the series now, with no other changes
added in. I expect that you can apply it in either order now
if the other series no longer relies on GENERIC_IOMAP.

    Arnd

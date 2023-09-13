Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771E479EB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbjIMOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbjIMOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:30:44 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F192;
        Wed, 13 Sep 2023 07:30:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 988875C026F;
        Wed, 13 Sep 2023 10:30:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 10:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694615439; x=1694701839; bh=NhpcqPVyhTViuvq4Fg+wUDv1BlytxzozHxC
        RDkjhY08=; b=NMsb9PyQSsPsibltS40zPbm9eXfEAuMjBuyQzLTEp38luBZ+vgg
        APRVixaifeUESQaGxQ2YgjN1uSTZwwMboTcL/M6RbB72P8/6piflNIzlu+6LoJ/r
        MjdA7DYThkvYxfsY4hK+uU9qPfse0BydHC5YsrXC1LQcW1J44rfciTf1ivFKcMnF
        TMHboi6fpE821jV5JCLPJvIbrHMghFtlEY4D6DMSAXpmNneqWKUj7sE8zQfIS2/U
        81x9EOo78otROCCyL8U3D0AUWy9mF8DSiSvkuwmW4rYTScMMFrs56qAmLatxSk4a
        VnMnfyIKbf8XkpqgGZFCHMT6WQOG4BgOO3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694615439; x=1694701839; bh=NhpcqPVyhTViuvq4Fg+wUDv1BlytxzozHxC
        RDkjhY08=; b=BGRvU8t5MYedFXtupTsPGt70fle0arCFF6mWvkdpnUaHrvXMXRg
        OZi7b2hWaNFaJExZ1wIGRv/zM4f7myrDv7tQ3Xk2mfS/F2MaPMqicSPgrVr6Xb8+
        5OY1cVXKuu6GhQzh5AMCUmRC5p2VJdN1iDgDzY7osyMGpuzOSqsQn578P5XW3r7O
        3s35dWsFrCmzJyeYcNnuuxlJZd/d2mROYiFJgciF1r5UqFWbEvQxE6oV3D1TnO0M
        ar0qpg2neZIXYtn7VsLadBYHBiMHlw74rSuuwn2jqMy/uFD0/w3SdotQfl1GOnm8
        o2Q3XlCXXd70h/EJ5pfVX4cE9L/RaxzldUg==
X-ME-Sender: <xms:jscBZcgvjzwfecPxptoMhcLog7PyxQqfrRzzPl2Gsf4Cg6OcwZwdNg>
    <xme:jscBZVAkOzIqWpwPTNVkrQNzs78fyFeXElAzUDcJ3LcDoScxCOqU5YEDwIvdNH4vk
    pmlJhyU8xkbdOp9WR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jscBZUGu7lZcBYwFKmf-Z9thGfu9jbKMcX4ifdlbk9hO3X6q0OLwjw>
    <xmx:jscBZdQD_roqy8m2CQNwX6wq1LcaS1QmQw89qk3TvJOMPZNY9G6XfA>
    <xmx:jscBZZzdS3GeUfH-w2t4FG8QojGtvVzqQaUE1v5RRsuYapeksv7MGw>
    <xmx:j8cBZbuZfr969Bw-tQvozuBfnoJ7fdb7afnAvJhuMMWkJwY6xkjjfg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C94FEB60089; Wed, 13 Sep 2023 10:30:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
In-Reply-To: <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
References: <20230802184849.1019466-1-arnd@kernel.org>
 <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
 <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
 <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
Date:   Wed, 13 Sep 2023 16:30:18 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "Rich Felker" <dalias@libc.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 16:13, Geert Uytterhoeven wrote:
> On Wed, Sep 13, 2023 at 4:08=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Wed, Sep 13, 2023, at 14:32, Geert Uytterhoeven wrote:
>> > On Wed, Aug 2, 2023 at 8:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.o=
rg> wrote:
>>
>> Do you have a link to that series? I don't understand why you'd
>> want to enable GENERIC_IOMAP on sh, given that its PIO accesses
>> are always memory mapped in the end.
>
> "[RESEND RFC PATCH 00/12] DeviceTree support for SH7751 based boards."
> https://lore.kernel.org/linux-sh/cover.1693444193.git.ysato@users.sour=
ceforge.jp/

Ok, thanks.

> In the meantime, there is a v2, which I wasn't aware of when I wrote
> my previous email, so perhaps my comment is no longer valid.
> "[RFC PATCH v2 00/30] Device Tree support for SH7751 based board"
> https://lore.kernel.org/linux-sh/cover.1694596125.git.ysato@users.sour=
ceforge.jp

Right, it looks like the GENERIC_IOMAP part if gone from that
series, and I also see that the PCI host bridge does not actually
map the port I/O window. That's usually fine because very few
drivers actually need it, and it also means that there should be
no need for GENERIC_IOMAP or the simpler alternative.

The first version probably only did it accidentally, which is a
common mistake, and I think the ones for hexagon, m68k, and
mips can probably be removed as well with some simplifiations.

x86 and ia64 want GENERIC_IOMAP because they require using
custom instructions for accessing IORESOURCE_IO registers,
but it's not really generic.

    Arnd

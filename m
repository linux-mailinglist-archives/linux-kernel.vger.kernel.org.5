Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0944B7AF1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjIZRv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:51:54 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B711F;
        Tue, 26 Sep 2023 10:51:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D309A5C007F;
        Tue, 26 Sep 2023 13:51:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 13:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695750704; x=1695837104; bh=Va
        tiiq1gZOzxN4XlZZr69JB0/W7VEpnHbxzOMAKG1eA=; b=ZLF3PscOBSvp2Btli/
        JtvyLDUcuaue8C0slp7a2/U45O9auHsnokJYllFadO4OQVS1/LQ8BNmBX4b9FGyP
        cV/XY+MDFU2Ao5PnRc9BPb4PWZo2zCOzIigg+DNFVnyTnYTAS4zJKIjpcUsVziFm
        RkqKtyvAXKMvGqGq4MVW3M1NXL+ElK/us8NXYfg2V7eDEM8T5ayA9EGVJ9vack5R
        AfXJrWSaU6o/sUutRHSaCAUGLWHY6ANHSBWXSe+X2xw4EhMUz41kxDQs9q7NMzsu
        sCXwFmYTY2fqwKxuscRt4z90+uPkvDAdvvIG7avPxThGgQZcMNFdhwzWKe4G8+2e
        ak+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695750704; x=1695837104; bh=Vatiiq1gZOzxN
        4XlZZr69JB0/W7VEpnHbxzOMAKG1eA=; b=AZ4rCx+s8I8mAM1VlaRYei3Ffo8GI
        UQ37Bpgk9AHL5W4dU0lwXGpSz3mGor4OANqK0R1vDxq9r9m3mdbYFvQ6zofCX76W
        fC0p+IgaEgvEkFKKjR9jCywspjgPggUBvKQGxzGuK52PLaJ+ZzFrau8iD5YHpvDc
        55dJzWaZlqtFPpmU4F3KuG63sGlZfzCDxzoHVqjvNnHFeU7BZzqyYU7VIOKzNrfq
        W26wMjB9dupshoXjmYtYNx4UHoMpH9B4pMQI29qwjDVzKIsqE0Z8G1GkOr7HBfFd
        00W9c6XeDhQ7KcCs9vxAPcBbkW9RNSdpIZJr+nXoWQOe7szbwGX8S9hlA==
X-ME-Sender: <xms:LxoTZXDEXhJ9vPFt8irquhh_s-nnU7Osz62pGQSNTfRgYxDMUY6m3w>
    <xme:LxoTZdhfDHZPdPpiaD_jPh3Ed7OaiOQyrV4acW_y2vfy-35GQvfucRTS0TYDImard
    _Iegy2sNHYNzQjzXAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LxoTZSk34QNRAKMIfPePjLPT-WD4LXr4vpsYAdMSRzRp8DVTKH1H1A>
    <xmx:LxoTZZy-IquBwvJD9QSvHoUnJQTXxcdRo2421cQMn82W3kMYltftOA>
    <xmx:LxoTZcQUH1FTgoElpbkuXpKOrxlZpKKdt80pneYsOYYzyi-UYZ28eA>
    <xmx:MBoTZcEH6t0APRh5m1qHM-TiEapr9xi-LZ1cgbekw2-JK3ROkUio0A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0423BB6008D; Tue, 26 Sep 2023 13:51:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <aa1bb018-cfdf-43de-a1d0-47b11dd626fa@app.fastmail.com>
In-Reply-To: <20230926174716.41705-1-blarson@amd.com>
References: <68ca306c-5ea2-437e-b7f1-68bad88557a0@app.fastmail.com>
 <20230926174716.41705-1-blarson@amd.com>
Date:   Tue, 26 Sep 2023 19:51:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Brad Larson" <blarson@amd.com>
Cc:     "Adrian Hunter" <adrian.hunter@intel.com>, alcooperx@gmail.com,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        brendan.higgins@linux.dev,
        "Brian Norris" <briannorris@chromium.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "David Gow" <davidgow@google.com>, devicetree@vger.kernel.org,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Greg Ungerer" <gerg@linux-m68k.org>, gsomlo@gmail.com,
        "Hal Feng" <hal.feng@starfivetech.com>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Joel Stanley" <joel@jms.id.au>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Lee Jones" <lee.jones@linaro.org>, "Lee Jones" <lee@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        suravee.suthikulpanit@amd.com,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, vaishnav.a@ti.com,
        "Walker Chen" <walker.chen@starfivetech.com>,
        "Will Deacon" <will@kernel.org>, "Yinbo Zhu" <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v16 6/6] soc: amd: Add support for AMD Pensando SoC Controller
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 19:47, Brad Larson wrote:
> On Fri, Sep 22, 2023, at 06:24:00 -0400, Arnd Bergmann wrote:
>> On Wed, Sep 13, 2023, at 17:49, Brad Larson wrote:
>> I'm sorry I've been out of the loop for so long, and I hope
>> we can find a way to manage your SoC support soon. My impression
>> is that the normal support patches (1, 3, 4, and 5) are largely
>> uncontroversial, while the SoC controller support seems like
>> we are still not converging onto something that is ready to
>> merge, so I would suggest you split the two parts and send
>> the basic support for inclusion in linux-6.7 while we continue
>> to discuss the soc controller driver.
>
> I've sent a patchset with only patches 1, 3, 4, and 5.  Correctness
> is the priority for upstream inclusion.

Ok, I took a look already and it all looks good. I should
be able to pick it up into linux-next in the next few days
when I open my branches for 6.7.

> I'll redirect and reframe what the SoC driver is doing to
> #armlinux IRC to find an appropriate solution.

Ok.

    Arnd

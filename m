Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564547AAF6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjIVKYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjIVKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:24:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D094;
        Fri, 22 Sep 2023 03:24:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B16D55C01FE;
        Fri, 22 Sep 2023 06:24:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 06:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695378262; x=1695464662; bh=A0
        XJfKTmT4m+q8kCLVyRa+uLfx4AGYjYo6nvHEPffdA=; b=GTD+dHmCDg7zufMm6p
        oXcyZ+t63bJq7ylCADy4w931wBNORB8rG7UgSuVklWYaRFEuOu5aHNZPdmFLtMSB
        z08eD/Nn6jXWMniDEwxD6LzsXcUQY4xp/b361ExdTROSjpzbetbVHE6P9YdNyyTk
        FbqHNIjP2GQoOpdXqMlCic1dRIPLPsL8eMdwb9gzq9Zw/o1AtzkuzcCLyEBmv4vZ
        h62U+uKA0DR84cWYdYFyqck9MZx3RBdh4J/6tHOGcr8DWS8xO5HYizYl8A2od3AC
        N7ItA4WkWiLmcQ08OrP5ECW3BYkyKlTB3yWL0PvnpqGNd0Qw38ES8tZzGKWyV1Ys
        HnAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695378262; x=1695464662; bh=A0XJfKTmT4m+q
        8kCLVyRa+uLfx4AGYjYo6nvHEPffdA=; b=XRMNJeYlK72hMxhN/3An8PUSvQ8Zs
        vbI4+6agWjVM0MapR6INJWexsglDbkRUw7pMOeIsBfBSF1u+I+kdSQvu6VXoH+54
        Z/11Tc1BobX2Np+7T6CZYURaptzhz+rjsXYOkbASJLozDJx5cK15NSxhAmYM/AUZ
        2e/5zWEHJJ0/0Dh/sZCMk+2887tX7mUlo91limrXLcG3vC8EvaPFrtrEGYowlpVv
        bJwczwlEqcyEZFYWJpM6WMohIUBeGFVTD3Nm0+YmHX/TYx7JUGeiE8thTOq/mSsD
        xVTDZaCp7sMtOHrzFQyaurf9kLy1W5x/zJs1rN0uiPf3yxciqCOhWPvZw==
X-ME-Sender: <xms:VWsNZbfMidwvWFraBYFRXS97Td5dBI8J6aWczIKGH9GzVo7dKde-ug>
    <xme:VWsNZROwQmd7C5eHy7HCavTbeiJDi-sa8u40DwxSzQv57cVYG2cl6DVofq5gWmhO7
    BdN_Ko9aLNudgs32Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepveefvdekgeejhfeggfejteeuieffhfevudeuudevtddukeejtedtteekveeg
    geehnecuffhomhgrihhnpehlihgsvghrrgdrtghhrghtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VWsNZUhieqRV1B_7-A9rXHAwppqWiOJmbfNefxyUCnpIwmSi_LTZ-Q>
    <xmx:VWsNZc_0q0vWpQNsjCzyvmhLDB2LiEAZ27YGR210PK2-VcJEDfzZqg>
    <xmx:VWsNZXv6QCPeZDfkr-HcluIRtm_i5zyhivYKZ1VJ7SHdmx5ybHMDCQ>
    <xmx:VmsNZQT1iCfOjJrZSE_aRFDPAoIBWBhFtEF6QCpv81Zg_gYD8WOK5w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EF820B60089; Fri, 22 Sep 2023 06:24:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <68ca306c-5ea2-437e-b7f1-68bad88557a0@app.fastmail.com>
In-Reply-To: <20230913214944.59804-7-blarson@amd.com>
References: <20230913214944.59804-1-blarson@amd.com>
 <20230913214944.59804-7-blarson@amd.com>
Date:   Fri, 22 Sep 2023 06:24:00 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Brad Larson" <blarson@amd.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "Adrian Hunter" <adrian.hunter@intel.com>, alcooperx@gmail.com,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        brendan.higgins@linux.dev,
        "Brian Norris" <briannorris@chromium.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "David Gow" <davidgow@google.com>, gsomlo@gmail.com,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Joel Stanley" <joel@jms.id.au>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        suravee.suthikulpanit@amd.com,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, vaishnav.a@ti.com,
        "Walker Chen" <walker.chen@starfivetech.com>,
        "Will Deacon" <will@kernel.org>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org
Subject: Re: [PATCH v16 6/6] soc: amd: Add support for AMD Pensando SoC Controller
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 17:49, Brad Larson wrote:
> The Pensando SoC controller is a SPI connected companion device
> that is present in all Pensando SoC board designs.  The essential
> board management registers are accessed on chip select 0 with
> board mgmt IO support accessed using additional chip selects.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>
> v15 changes:
> - Drop custom ioctl and use existing miscdevice interface.
> - Delete unused definitions in amd-pensando-ctrl.h 
> - Makefile change to compile for ARCH_PENSANDO

Hi Brad,

I'm sorry I've been out of the loop for so long, and I hope
we can find a way to manage your SoC support soon. My impression
is that the normal support patches (1, 3, 4, and 5) are largely
uncontroversial, while the SoC controller support seems like
we are still not converging onto something that is ready to
merge, so I would suggest you split the two parts and send
the basic support for inclusion in linux-6.7 while we continue
to discuss the soc controller driver.

Please remove any references to the soc controller from the
dts files and send that first series to:soc@kernel.org
cc:linux-arm-kernel (and the other interested parties) so
I can pick those up.

Regarding the soc controller driver, let me try to give
you my impression of where we are:

- you have gone through 16 revisions already, which is way
  too much for a public review, we should have been able
  to find a solution earlier than that, and this is partly
  our fault on the reviewer side, and I'm sorry about that.

- Andy's latest comments and a lot of the earlier reviews
  were focused on implementation details. While those comments
  are helpful suggestions for improving the code, they miss
  the larger point about the system design that I'm worried
  about and probably don't help you actually get it merged.

- The main problem I still see is that this driver completely
  bypasses our normal kernel abstractions and instead creates
  a low-level passthrough interface for handling kernel
  functionality in userspace. This creates a liability both
  for the user ABI and the kernel implementation and prevents
  any 

- There is a chance that your design is in fact the
  best way to handle this particular hardware, but it is
  your job to write a convincing explanation of why this
  platform is different from all the others in the patch
  description. Your current one-paragraph text does not
  explain this at all.
 
I would suggest you prioritize getting the other patches
included for the moment, but we can keep discussion the
API design for this driver either in this thread or on the
#armlinux IRC channel (irc.libera.chat) in parallel if you
like. In order to help you here, I would need either
the documentation of the SPI software interface, or the
source code for the userspace tool.

     Arnd 

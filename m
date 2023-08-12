Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E786779EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjHLJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:53:23 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2287DA3;
        Sat, 12 Aug 2023 02:53:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D3EB5C00AF;
        Sat, 12 Aug 2023 05:53:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 05:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691834005; x=1691920405; bh=mY
        UqS16hIoXcMat3fBevhpVqH1JCvKdTqNUMSDYLzVs=; b=bhdJjeoakVCe31JB0Q
        dReZBwF+Yizzu0IMk5j0PU38mM28wCWB1O8M6CpkOg0OOnEwGyfRKH8HQhxoy+Ru
        oUugmINlBgg70VtkoRv9SD6fvRkFhMReOEhoi6lEdlP2uwKDz6HB/ziyWPsTArRs
        upZxKt6yrNjQG2xY6xVPKJ9sW1+2lOqiAo7vpIEWRLXAwOpjcNmtnG5Ps0KZPO5a
        Z+qQjL12VjBGdvqC5cz804+ZtsVfJSMkD6J5plLHjD8WJc5ln3gFMSONKP3cKD06
        6OjIQ91aNuHVp4WfG6mb/nn34YSBh/yBiL3QpQmDDJVBd9y3plMSmOCV60RxhQiK
        6IuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691834005; x=1691920405; bh=mYUqS16hIoXcM
        at3fBevhpVqH1JCvKdTqNUMSDYLzVs=; b=dcfEauSy9r5QC/5WskQe2aa+K2aCO
        Mt6XtaiqK09a+txh6nbqcMwifLiMFgEkK2sGLIyOm9subRaKZGr3efGMn21Gcegv
        GLeLOPOgEpz5c1IEp/XA3iqsSPNew4qDpIi5rCXEkoNlymULQ5eRHHiBIjc0a72/
        OieTCoa85TJBX2LPNF9c+iL/O2tuYRK1EicB0EyCr1g58UQX0H+2Lf+K1K5UhX06
        cX6xnThztkatMkVAtYCLdwTkP2CoaIRGhk4h7zVXI4PLpwzCyKFsYHELmA4PoB4v
        50BLY1AWKIqZp+LG6Jij0k2xS64tGg6uCA7UTHueMcScIfuGN22fPYeNQ==
X-ME-Sender: <xms:lFbXZNrSx4nor6nW6gYMLo6ZDsSDA8VErPlu4fCnOy85ZRkcvoa7XQ>
    <xme:lFbXZPq-cubSM6YK9VC3SOkH3z0DQO0L2cagwJYHYAgTSNPmBCVKfEcm6sJHCV64J
    M6qfmG3gjzRhxPbpgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lFbXZKNESAicxU8b9w7dhPqWCGViZTgPsbsQRw6NRSv5HNsOJANZIg>
    <xmx:lFbXZI4Xl1kPif8oGrFAEMJ2lgCPQqkIvR5FQmJMbtnYpIP2tLlStw>
    <xmx:lFbXZM5fqvvWLkP0SemkjzF7FXBXwrP9V2JzL7fbErc1060KThh37w>
    <xmx:lVbXZOubbRxoZAdJytVkIDCVeXwaPsh-Nk9CMJQAzN7Kp1UeFKevYA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B9F8AB60089; Sat, 12 Aug 2023 05:53:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <484a1fb8-cba3-4fa8-9f37-21caf8ba6fc3@app.fastmail.com>
In-Reply-To: <4849173.31r3eYUQgx@fabians-envy>
References: <20230802153333.55546-1-afd@ti.com>
 <4849173.31r3eYUQgx@fabians-envy>
Date:   Sat, 12 Aug 2023 11:53:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Fabian Vogt" <fabian@ritter-vogt.de>,
        "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Daniel Tang" <dt.tangr@gmail.com>, "Andrew Davis" <afd@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/9] TI-Nspire cleanups
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

On Fri, Aug 11, 2023, at 17:13, Fabian Vogt wrote:
> Hi,
>
> Am Mittwoch, 2. August 2023, 17:33:24 CEST schrieb Andrew Davis:
>> Hello all,
>> 
>> This series is an extended version of the series started here[0]
>> and here[1].
>> 
>> We break out what was the first patch into one for DTS change and
>> one for code changes as suggested by Krzysztof. Those are now patches
>> 1 and 8 of this series (I kept the ACKs, hope that is okay).
>> 
>> While I was adding that, I noticed some other dtbs_check issues,
>> so while here fixed some of those up too (patches 2-6).
>
> Whole series applied on top of cacc6e22932f and confirmed to work:
>
> Tested-by: Fabian Vogt <fabian@ritter-vogt.de>

I've added all 9 patches to the soc tree now, the first seven
in the soc/dt branch, the other two in the soc/arm branch.

This does mean that the soc/arm branch has a minor regression
when tested by itself, as it won't be able to restart the
system, which is a regression we'd still get with old dtb
files, but I think this is acceptable here since it does not
impact normal operation, and there is a very small user base
that is affected by this.

Thanks,

       Arnd

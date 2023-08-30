Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9A78D14D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbjH3As0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbjH3AsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:48:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57901A2;
        Tue, 29 Aug 2023 17:47:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7E488320094B;
        Tue, 29 Aug 2023 20:47:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 29 Aug 2023 20:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1693356478; x=1693442878; bh=uB
        VoM3kwg2LnNnne4tXK5d6hJs34FxnDPqZqQuGBRXk=; b=omSpel1dMon5IJIDg0
        H50dhNo8FiLEyYohprC+qPJJWoJYseB4Uah5LFxOO4PhVFx6b8xbbyXkRJQ8bL53
        QkLHWeNjG0Hg8HXxC4mruB3BxyJuG6PN8DaARgmIJd89yru9mE/bk79JuZgYMrYJ
        rY8UqohSsBP6aq7BaauDpESKV0HNwd52MnxWCYBpfDMA86tcdQUQJvHc6tbcmTUb
        qkhfvLsOiTkqtdpkiSbOWswBd+hVgZ5k8UpSA2IW7MFw1wK00+Nto1ryIfw08d0L
        Ghe2UAgPufDPGGIvsVpnsPfsHgQPvXwJ+FWXsDV15rgGANEkA5htAc89Xac1bwo3
        WbNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693356478; x=1693442878; bh=uBVoM3kwg2LnN
        nne4tXK5d6hJs34FxnDPqZqQuGBRXk=; b=BRSubTu7WPGeSRyCbt1hx4AjagFAg
        5Q7kNDUzOCzGZJ0Sex4BwUZ6rAhZOPZ/MVVF6ggvpzNAVatBslj2jbBTmBvDrLgz
        xPCsGZvtx2lv4RilvQySdDnDxoX0qEM/vqLQGpEkyyt8052oBM79CdIajwPfxppL
        XvufURNBHXB/+4BeCUBDufnkHQSnwivzcvVXOrByrK5b/2j3giQVvosKqv87X1y+
        5AX7MA9CWHiMXVMliufTSvd1lUI1xE+GLR7AHnMUkCkiM9FZZrkh8RdtbOItyxvA
        U5hatwE/F7CWqEsCGMw1mkajatIPm+0JKzUOodwET8JHw19zhlUnX/WPw==
X-ME-Sender: <xms:vZHuZMFOl9iyV9zsKlqAACpcoARHFki3NqfRQJ9Zvf4QnYysgieu3w>
    <xme:vZHuZFUKEGloq5iUDhViTz7_lUSa_zXuG0f_hhYw08ij-9aDuVM6qysnMdFNXKDz5
    QUmUmYnzFThjDqvKRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vZHuZGIc2ViUA68sZ2asEkwB6YrV06mi2JLcKlOb-mtgme9N5amO6w>
    <xmx:vZHuZOGNLE86EpwDRBKSItM59npxEbiPrPQk5lo981XjTIt4kOe4Gw>
    <xmx:vZHuZCVTIOOK3x6Ozs0lsR4j3r3Nyx7kvQbEyRwRFJe1ctg2WpSfEA>
    <xmx:vpHuZELm6edu0clWPTfg0KrMwhLrT_DBm4mZ4RFnF0nynaDWwPWESg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8A517B60089; Tue, 29 Aug 2023 20:47:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com>
In-Reply-To: <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
Date:   Tue, 29 Aug 2023 20:47:37 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Olof Johansson" <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023, at 20:31, Linus Torvalds wrote:
> On Tue, 29 Aug 2023 at 17:18, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Please don't use random letter combinations that have absolutely
>> no meaning to anybody else, and that aren't even explained.
>
> Side note: at least to me, 'gen' is short for 'generate'. Looking at
> existing kernel naming, that's how we've used it (lots of examples of
> that from different areas).
>
> Do we also have "generic"? Yes. And because 'gen' does not mean
> 'generic' to anybody, we've typically spelled it out - as in
> asm-generic, but also 'sound/soc/generic', or in fact a _lot_ of other
> examples.

How about moving it to drivers/power/domain/ instead? We already
have some only loosely connected subsystems under drivers/power
today (reset and supply, both maintained by Sebastian Reichel),
moving it there is probably less confusing.

It looks like there are only a couple of dev_pm_domain providers
that are not of the "genpd" variant, so I think drivers/power/domain
can just be the location for the generic drivers without making
that part of the name.

I don't think we can easily rename the interfaces that have been
in use for the past 12 years, but the directory (and MAINTAINERS
file references to it) could easily be changed with another
patch on top of Ulf's series, without interfering with my
pull requests.

       Arnd

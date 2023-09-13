Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9EF79E03D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjIMGxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjIMGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:30:25 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECE198D;
        Tue, 12 Sep 2023 23:30:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 15CB52B0014C;
        Wed, 13 Sep 2023 02:30:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 02:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694586613; x=1694593813; bh=Ce
        b4aT1WPu9kJYMz0+axHKLX036tvDE1NLFhquYjUyo=; b=uelx2bRLfFCEOk/4Sn
        tdEf/3G7NqzDKtaz6FXZiE8HwkannShE9Vhl+FY1Vyrg1jYOOVeHKxVtb1UC0zjb
        GrOQMFl7fvpgz2z3BKaIVFAhQ77NOVRQgEdOg0efgMorMz5kt4ZqCeOTas9rUz4n
        9VSTyGoY4SRTo7eCvp3ZPR9qKhUenCYw/OGADEOzi8qNzEjcdXVxnBDUP3IUMw3V
        YG1NOFiAJ3rtuTHzqiMCVpXT4LnQXb2X2dYLdiY36mZ0jv9svbz0gutKBLVE7NBE
        L6zaA03V22duVrXe++FpzJWzWnZV9KX3alRKvGmqeS3QLj6IWAXKa3i3g99vhVYU
        0uUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694586613; x=1694593813; bh=Ceb4aT1WPu9kJ
        YMz0+axHKLX036tvDE1NLFhquYjUyo=; b=bsmlqKiFayLkn7sKMcRyIGpoz2xfe
        m4SZ+z3qnnfUMf8iOWbpxG2zcy+fQxjTEb3SST6CEIr7rcVXoDQdphZCaLTm5MLK
        RUjrltoMn8hWyHIMBqapF65rYagxDdHAiyoi1LquC2AL8BihE4KFVHasJ6/ROrrF
        kvsYS4TUeexXwIRXafoQwQlCKQbdFGMqn2F574SuoqVNDLiapQR0z+CfojcnaO86
        2gGM4rj5cK+SdUZ+945sxw8I2oxyOuM1EUJ2rSwLVo2fVkmCz9iscXQIxHu/Pqur
        o0bn247bMTgWVg0zFIat5TKAP6ZRs01zbgxcIqzmU0FRVcULrt9KP3UOQ==
X-ME-Sender: <xms:81YBZaG0Mnf6_vYAAd1hAeWFS6cps4Nwb30US9DstqV3L2GUcNCnzg>
    <xme:81YBZbWqQbmpnrIuqWOTMsih5b2MUzAz4ervZQnQ_FzRNoJeVVZV22RYMszM_dYhc
    PReZqlG_mcotBaq79M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:81YBZUKlkCyNX_SzBwYJ_ZCSk6PBhMpZay9X34r4z8pzgOgwJ3zFIQ>
    <xmx:81YBZUEVy8fAgG9T9lwjzta2ySQn2_8-V7lrS5cBtRCj1ECyZoaVVQ>
    <xmx:81YBZQU3wLh4CSPYSiI-slV5m2JhBcmn9-nvFebAiPUTSa59sS_ZVQ>
    <xmx:9VYBZWydeG8ghXMVJqcVWi22uwiECWEdaCfONoA428U5Y9LoDYT_gyqWpkY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F34F1B60089; Wed, 13 Sep 2023 02:30:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <7b13a832-972a-4de6-ae0f-73b3bbb372b9@app.fastmail.com>
In-Reply-To: <20230912221127.487327-1-ulf.hansson@linaro.org>
References: <20230912221127.487327-1-ulf.hansson@linaro.org>
Date:   Wed, 13 Sep 2023 08:29:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Olof Johansson" <olof@lixom.net>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Michal Simek" <michal.simek@amd.com>,
        "Nishanth Menon" <nm@ti.com>,
        "Santosh Shilimkar" <ssantosh@kernel.org>,
        "Tero Kristo" <kristo@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        "Conor Dooley" <conor@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Florian Fainelli" <florian.fainelli@broadcom.com>,
        "Ray Jui" <rjui@broadcom.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Sven Peter" <sven@svenpeter.dev>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: Rename the genpd subsystem to pmdomain
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 00:11, Ulf Hansson wrote:
> It has been pointed out that naming a subsystem "genpd" isn't very
> self-explanatory and the acronym itself that means Generic Power Domain, is
> known only by a limited group of people.
>
> In a way to improve the situation, let's rename the subsystem to pmdomain,
> which ideally should indicate that this is about so called Power Domains or
> "PM domains" as we often also use within the Linux Kernel terminology.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

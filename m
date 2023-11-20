Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD37F0DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjKTIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjKTIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:44:33 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6CA2;
        Mon, 20 Nov 2023 00:44:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C93F55803A1;
        Mon, 20 Nov 2023 03:44:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 20 Nov 2023 03:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1700469865; x=1700477065; bh=gf
        FgJZ50InRlxA1bXQ5aRh+dZLzQhN0FPLPbgFDX9v8=; b=yJY4c/z49wu6OVpuBT
        3vrAuNBqGx/HJh0CxqiWKIthY1AlXlOQjAYzcts97tbP3Ex2GGPQQnXTtmrB5Vhz
        woHAtqMnkGd4WiBPUTrulr/h+k4WVwA9z9/cKMcle0aiA/drai6rbsntsIHuR5Wn
        1Ya7DsMYWbsHYCNlGVJfmyqxp1uQgRNmYfgmh9l8z0+5KjR8a2D7HJ1oNO4dMxgo
        zhk79szjzuCFuW7X+x3WeeD/23HoubJcgAeEuR9VaST0H1/3oI+Fhqv05mU6nOyi
        Q94vDFCnHNjpgnV2ODYbANb45IAexy3h2GuRXe9+WqFXcyjo4/bQ4yA0ABFK7UoM
        p3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700469865; x=1700477065; bh=gfFgJZ50InRlx
        A1bXQ5aRh+dZLzQhN0FPLPbgFDX9v8=; b=QSLFSYboW8mIu3dJ5DjlbwdMObuuN
        kPd20GyFcMT9IcXzoaduqkfNG+IQWUeZXiPs+y6S2qDT6ob3ePqPvz/mMrwQ4ZbQ
        FFbbbzHtjVRoD1c84wG2ErsQFxg5Ne3cfCE3O3rYyasOgF6fcG7LDMDm7W9jP1mn
        bYFf6HyiS8d7s449+/4J4hD1SZT5CJqQNvJuP2gIs6fCyk+2lyvhXJ7kepp3hbPY
        WNpYe70r/TKJyzsIkrfg7RkcN654pS/aUIb38XeR+BswLivSm6W4Ri3zBbSvJUtq
        XeyCNBpFC6rzdYEjwQABacq7mB7MLA9jTr2nv8gov/MNdI7Joepn6xPIw==
X-ME-Sender: <xms:ZxxbZSjBS8ra_sObY5jpHOgzkteFSOyuM5dj_Cv8PUZRLyRqjwyUmw>
    <xme:ZxxbZTBKoTp0rH1NMZo4pfUDsV7YsaTm0JFXz4ZOMsofDPOEgKmK6_aqKyuG7NNxr
    h7GEGQzOTIeP4Ugx90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeghedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ZxxbZaEO9Np9FB7qMx9p2aGgFYghtTBdl6qb3umOSdjyh8o3z7CnPQ>
    <xmx:ZxxbZbRMXt7VlWjH7F8ieB3Pg-61rVM08ZKBfsNCIwg5MGKQyoXfGw>
    <xmx:ZxxbZfwkRHHzpjJjPJnLXY42gxyhTY4mWs8sp4iZW7920ijqVIwv0w>
    <xmx:aRxbZY8Pfk7Y5L9tx8y9q5icA1GrErC01q3EpZ9X8WYKxu4Y42GBSQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1C2F9B60089; Mon, 20 Nov 2023 03:44:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <bd25377b-b191-4d81-b144-2936cb5139d9@app.fastmail.com>
In-Reply-To: <20231120070024.4079344-15-claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-15-claudiu.beznea.uj@bp.renesas.com>
Date:   Mon, 20 Nov 2023 09:44:02 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Andrew Davis" <afd@ti.com>, "Mark Brown" <broonie@kernel.org>,
        "Alexander Stein" <alexander.stein@ew.tq-group.com>,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 14/14] arm: multi_v7_defconfig: Enable CONFIG_RAVB
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023, at 08:00, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> ravb driver is used by RZ/G1H. Enable it in multi_v7_defconfig.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

We have a mix of =y and =m for ethernet drivers, and usually
only have drivers built-in when they are frequently tested
with NFS root booting.

Do you need this as well, or could it be =m instead?

    Arnd

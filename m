Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500287C7065
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346817AbjJLOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbjJLOg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:36:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9934391;
        Thu, 12 Oct 2023 07:36:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3182B3200977;
        Thu, 12 Oct 2023 10:36:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 12 Oct 2023 10:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697121411; x=1697207811; bh=dT
        K6vB86TTa39cmBteipnbE5ZieH/rRMtOJjJ9SFwYw=; b=Tivic6xGP99PN1FGrn
        eZ+OO4z9CT92jlXaBKxpci5w57UD1TD2KXotzk9uDohCCnhbeJe/LzTefY4j2SHr
        90SYJqOZf/KYm+ub73LawRFmrUmbJdHw9L7oHVbz+O7Ahs5FDCHS/IMc/OyfuMbr
        GjjzO9ALVzlRkSjmwD11zZetCvlZc8fR1xlFcYZHUmFaaQJgMa9hysZ+EnjPdHC1
        RuJyQZycVAWOfJHN+4LZdjxcjsmcYCtfepHcGYw6TaYWdvP4PLBEih6O+Q/gsWwX
        eUXOHbgZKgIrUitwVDWrhmYMKNK/MKRDldciix1V4149vGzwLhWSLviwW0xMq0OS
        0NjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697121411; x=1697207811; bh=dTK6vB86TTa39
        cmBteipnbE5ZieH/rRMtOJjJ9SFwYw=; b=g1Teoq2cG0IIV16g9UqalYOHpKNTX
        HIkN6/I4aZlyVvxyfmsUtEyoSQExzv+IMiCN3vj3fCcpWmb+m8r97LUbaiHBlxw2
        TEdHCKjfL/nwBujQGA6Kgl8dhPEqT+PjlVaORvxHLzI8KD573EGeg7xtnItS7PVr
        Gyj/JEg4g/Uz/eoJIFQkD60RgKcQNXBycHCmC7TYKdA3qkENeFKWhDHYbT5tA0lY
        wMLDlw5D3QbfJPoSKqDEHSS782Ren2ZqCaF6YOnisF9gDDZQOMClC14Zqx89rNOs
        oYeVioBmZMLDrjJXvq2z0kGTe5Ec/2ITiqF8pqObJ4cxo2lx80/xC0wNw==
X-ME-Sender: <xms:gwQoZXtty0NQfKaC3SwT2-HChUmZ3T5-G7hS6T7l6-KjSk-0oVLdwA>
    <xme:gwQoZYc7VIGN6FhiyWDBzSEr7TdJ-EPzZmlxLPBJOBBS1-xWauqIIdNpAPtLIJsQn
    _BihDzBuduc8o-9Mjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gwQoZaz6LKiQWiEoR-kC2R-iQgLHvMUlh9K9q8UqMojCckK4gQtZhA>
    <xmx:gwQoZWOv0Id1TAPb8pHY66ENEePxYuWiIArJeJmoFfWcJeuaV6-lBw>
    <xmx:gwQoZX9j9RZ0Gq1FnOzEoIzlswnaE2vi9f1evz8-zLQsx2VZJiZu6w>
    <xmx:gwQoZWXJ36zrWUNE5v4AY8Ge_1jsj2TljiM2_fMcrqza9AwAReJ0ww>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 54B9DB60089; Thu, 12 Oct 2023 10:36:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
In-Reply-To: <87sf6g2hc8.fsf@kernel.org>
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
 <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
 <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
Date:   Thu, 12 Oct 2023 16:36:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kalle Valo" <kvalo@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Pavel Machek" <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023, at 13:47, Kalle Valo wrote:
>
> Is anyone willing to submit patches? Use wireless-next as the baseline
> for patches and one driver per commit, please. That way it's easy to
> revert later, if needed (hopefully not).

I can do it, I've already done most of the work for moving the
drivers, so I just need to split up my existing patch and leave out
the bits that get added to drivers/staging.

I'll also send Greg a patch to remove rtl8192u now that we know
that this has been broken for 7 years. Similarly, I'd include
another patch to remove PCMCIA support for libertas, as that
would otherwise be the only remaining 16-bit PCMCIA wlan card,
and I could find no indication of this one ever being popular,
unlike the USB/SDIO/SPI variants of the same device or the
other PCMCIA drivers.

This would leave only a handful of wext implementations in the
tree: ipw2x00, ps3-gelic-wireless, staging/rtl8712, staging/rtl8192e
and staging/ks7010. Since ipw2x00 is apparently still supported
in theory and was rather popular on Pentium-M based systems 20
years ago, this may still need to be converted to cfg80211
before you can remove support for wext style drivers altogether.
ps3-gelic-wireless and rtl8712 are also still maintained but have
a much smaller user base I assume.

      Arnd

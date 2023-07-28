Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C224776714F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjG1P7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjG1P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:59:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9E110;
        Fri, 28 Jul 2023 08:59:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 42D155C00BE;
        Fri, 28 Jul 2023 11:59:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 28 Jul 2023 11:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690559985; x=1690646385; bh=qe
        prRb5ewEtA801/sByp5QkC5fP6Mty2WClCI4vUDyY=; b=GQgIcy4Pj5IML3N/U+
        muKPT/yi2mD0T9FSsMKqUPLjbTKA/2rj9ALRX8jCqneWSJM36GXeopCXKNSVXBzq
        Nu2zUEJCHDPQ2O2/yx0yWPHy4ikGSfMT3VXOZSCwEY46P/UNAjDSsac4bXlkHvNE
        MNXQ9hwmYVAHtkRmF7MiHR/rXa3HiG/KdOSusFIMeTClTXrrgaayaL4L0DO9izQm
        vJA7XKrN74xm4y2qXGDjrq06Rn7+OfRPYXIYyyk6eQxrhv9669kTMu0q74z37Pzf
        n6dVzAyANj4suvYmcNIys2HmTUeNl7EeZ4sI3JcxCnY3ZsP85mBEnWmSYaRNxIOI
        mGYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690559985; x=1690646385; bh=qeprRb5ewEtA8
        01/sByp5QkC5fP6Mty2WClCI4vUDyY=; b=fqd+s0ENlYsKTRcjseNDnt5Za3Fxp
        r+wf+9KV/9zCpAPXpDD0r9bKp2LsJY8PGLgeHZ1crURsURghk4PFGfioDGq14SRX
        q0fcHkLQaHjvMqYpddp+xdbJlN7i1uUyC8FzigDrWahYAqVUD/b3Ej2aDDbPgfmz
        1eYOfhZuRucmnbgNsReFyniIlwwvsBykugsbWzjeC+FO3bReIvZGR6Ypj/yLXUVa
        UHvyB4ebn5p5j8xRpUiKJ6EVEjZ31qNWW2Vu1skcH0eiqkhlNAx7clHh2bo+INlp
        +ZyP/PO+eRjJ1qUD1BPlpy91/kEYFfUUNPZcb45JcKe9Pey6v2ckoaTZA==
X-ME-Sender: <xms:8OXDZAWfjZKaeFGK9DxQo2r5IelHq7-EXGnliym7ZC1j0MlCEdYLaQ>
    <xme:8OXDZElPvdmk2uyEBiHAEMKvcC5N9mgZk-OMx4OEM4yXiaRVf2WR-SKuH87Ejcu92
    ROd7yiIKJGLnZONJ5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeigdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8OXDZEawgidolfxWA1zuJA-NjZvZ9DTXiwcUqy3Y-b0GAasNoQR5bQ>
    <xmx:8OXDZPVdb7bc06N5Jc4FRQ6c2jY8Jeh_G3C0My5ieDI_mVqo3YQAmQ>
    <xmx:8OXDZKnj9Auv7CKFQuB0xS406pKEqQj2t1HnjDKNJ6hPOT204DObKA>
    <xmx:8eXDZNGgebKPDnDW7VjiBpIHriNK8L5WWfqVUbRBa6skv3tyx9m_-Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F3CC1B60089; Fri, 28 Jul 2023 11:59:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <0808604b-a26e-43b8-83da-2c3dc12446d2@app.fastmail.com>
In-Reply-To: <20230517154525.ljoamjlfhpejtizm@viti.kaiser.cx>
References: <20230516153109.514251-1-arnd@kernel.org>
 <20230516153109.514251-6-arnd@kernel.org>
 <CAOMZO5B0stW2X6YqPTTKDpCOAzPDvm=4HT8jfBAgbTy11gnKgg@mail.gmail.com>
 <4e026f08-d733-4b01-ab47-e921d041e74e@app.fastmail.com>
 <20230517154525.ljoamjlfhpejtizm@viti.kaiser.cx>
Date:   Fri, 28 Jul 2023 17:59:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Martin Kaiser" <martin@kaiser.cx>
Cc:     "Fabio Estevam" <festevam@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>, soc@kernel.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>, "Andrew Lunn" <andrew@lunn.ch>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Viresh Kumar" <vireshk@kernel.org>,
        "Shiraz Hashim" <shiraz.linux.kernel@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 05/13] ARM: imx: remove unused mx25_revision()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023, at 17:45, Martin Kaiser wrote:
> Thus wrote Arnd Bergmann (arnd@arndb.de):
>
>> I think either way is ok to address the warning. If we wanted to do this
>> properly, the mx{25,27,31,35,5}_revision functions could all be removed
>> and the logic hooked up to imx_set_soc_revision() in the same way that
>> they already use mxc_set_cpu_type() for drivers/soc/imx/soc-imx.c.
>
>> I'll leave it up to you, if you want to merge Martin's patches or
>> a replacement for the soc-imx driver through the imx tree for 6.5,
>> I'll drop my patch from this series, otherwise I'll keep it for now
>> and we can still do it better at later point.
>
> I suggest we merge my patches for imx25 first and then clean up all the
> older imx families to use the common functions.
>
> I've just rebased the patches against today's linux-next. My understanding
> is that they have to go through the clk tree.

This never happened, right? I see that mx25_revision() is still in the
tree without any users, so I can't easily turn on the warning by default
yet. Should I just go ahead and remove it for 5.6, or do you expect to
have your patch ready in time for the merge window?

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80A7FDEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjK2RpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2RpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:45:07 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46D112;
        Wed, 29 Nov 2023 09:45:14 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 09DF55C02BA;
        Wed, 29 Nov 2023 12:45:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 Nov 2023 12:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701279912; x=1701366312; bh=6G
        7IT/Y1jFfvBeoGH3Rt7qh2CE2/hGJu4agITadubDU=; b=meC0G2VmkKl3g7OBWK
        nh2tjz8RFuOUGlReuOKjJgg+rYbG2sHmE5vhMO+kjETfXsfAoBLtR328SaoCqwZW
        5TLbvvgN6IUdeSJM2T0CgWVUNQf4y+lWVyewxzxuTstU6vv/AODKo6oPSGEf9Gx7
        5/X4bb02reUNaq5Ol4Wx4QS9zlXQYq0dZru5uSkIw7zKir1d6DukCEGK38q87v33
        JJqsV5OAZ3fun9N15vUXKnYxQtInzrnVeZ1BoSxo3McH4gQ8jCKPkcqtEPUCPchO
        xtT2X3qSj9vseLJU7e1Y7AHLTIH6EyUF9bcvS1Lpurje3JeJ5ahmDgzuKUIZL63s
        VCTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701279912; x=1701366312; bh=6G7IT/Y1jFfvB
        eoGH3Rt7qh2CE2/hGJu4agITadubDU=; b=oXy1/rknpubOIFgpzRF9euwcOLTPI
        pxBf3vJPXkx6q8uCe9+XdEFnH5u8n4767scv50MA1A6LJd41LtlxJZAoDLsPy0Ej
        uYt6OdCAywUm1xK0d6lt0582kra/xhjQkJOq+tn39nJxuk8BlaGaI8vV2UkjzdGX
        yiwWn3XhahlTTW9bSo5b+BNxFI++G2SEShYyNVl4rddfpmRzw/Hek8NZyrAjXorI
        bgRGe29e7q/uL3uKwEb7byeNEbQ2EpoGLrKMFZ8V4DI/okyzCqm3su6dfe3VdyGm
        ev/WypPAIEi6BdFYVS1oWaZWsyW/cqrGrpnAW/Pf1RkXCuItT4+IXEFZA==
X-ME-Sender: <xms:pnhnZa6eymBOO4TKATClO5dvCZpdUaSKz-j9Egaw1wAD7vdD9ZMkMw>
    <xme:pnhnZT4ANLWwTBHnYU6h1hdv8zQl2iSOHHtCn2JcQShK4_PT0042bHDeVtAnZ8BJI
    JpzDN9Zfoxa_eX64_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:pnhnZZcm5NMOo61NyXDe9HZm2NEVjniWzznsFbg5Y_XoGwLmiTGbOQ>
    <xmx:pnhnZXKE5_whbIGPhxO5YRrdjXTUg571b5XlLg_PgRrpD3V5kplkHA>
    <xmx:pnhnZeKU7eAZcmDIcMgVnNr81YqL8-4Ko0WyYfx_8bheab0YIg9v5w>
    <xmx:qHhnZbWljuYvYKWLg1uNigJlHcmtEwA31LHf4d-_LqFBlGqEoxoCVw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AC574B6008D; Wed, 29 Nov 2023 12:45:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <0cb00798-6510-4456-81fd-90131b97fdb8@app.fastmail.com>
In-Reply-To: <20231129174722.7d4e768c@xps-13>
References: <20231127164623.1008176-1-m.felsch@pengutronix.de>
 <CAMRc=MdsEWxJLHL__zYXGEMYvvLSH99GsTRv_NTaVXt2fGtNvg@mail.gmail.com>
 <20231129174722.7d4e768c@xps-13>
Date:   Wed, 29 Nov 2023 18:44:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>
Cc:     "Marco Felsch" <m.felsch@pengutronix.de>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        "Jean Delvare" <jdelvare@suse.de>
Subject: Re: [RFC PATCH] mtd: devices: add AT24 eeprom support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023, at 17:47, Miquel Raynal wrote:
> brgl@bgdev.pl wrote on Wed, 29 Nov 2023 10:10:28 +0100:
>> Though if I'm being honest - I would prefer a single driver with
>> backwards compatibility. Have you estimated the effort it would take
>> to abstract both nvmem and mtd?
>
> Also agreed :-)

+1

I think this particularly makes sense in the light the other
at24 driver that was recently removed in commit 0113a99b8a75
("eeprom: Remove deprecated legacy eeprom driver").

The other problem with having two drivers is the need to
arbitrate between them, e.g. when you have a machine with
two at24 devices but want to use one of each for the two
subsystems. This does not really work with our DT probing
logic at the moment.

     Arnd

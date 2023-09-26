Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7649A7AE35B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjIZBcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIZBcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:32:50 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6BD101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:32:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DF2E35C0568;
        Mon, 25 Sep 2023 21:32:43 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 21:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695691963; x=1695778363; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=iqFM2qdrwdtNuhzQ4HP+X2tJ4aPrgSuXnESCe4kabvf4tgeuSXG
        IUQOdVRdzeATuztIh9yui6KA838SFU1N3/2h8xCycaThXuG9AMguZJ2d6dTIbOs2
        IP31yp12JYAHcc2lDPg0arkshhIaWPktn1mu3bTV+2p2ISBd9pGDA6aDeSsaLENx
        OPcxblSQrzZqaG1motcw0IuZlH06NlpKHcgGplBlI6ek4iCiq6YYqeL/w0C9Waib
        X4WRGK+befqhNGeKMynyFgKiwdWIyZBtR6U0HrvcRRcT/5rPPXIvG84uwn4dupy+
        YfvyZ3SVC300H5MxRjDAhsw1Ch8eY8wGrRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695691963; x=1695778363; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=A9sS/MXGzuXTVZNOK/xoupemIzzx8zkQ6LCm+LyJJXZ675lsGPG
        F45lhCbPKE7gOsoQpPMDUOMuBZ8ft6zb/P750LAX+HVJ/zNdebIHWw1ZINv8eLy6
        P4EuwMsrEscw0ulP8LqsThb3BG81f4vpAQdNTYFQYFnt68rgMOzCVeJJyrN4KiN4
        nsQxMOGP6jJsNLjd2Tbc7yfkq8v/fSCqf19BtszNCtM+tO4Aeue0G2SUbX7ec6/Z
        +N+2yANyP0eWhOey/2V5Mm4TkuptID8iv/VT2VhqmYT7Kzm5tXGL+1kBPjUPJryW
        +NcQXd2CvJZMApE0MtYMN+Y+3qFg2xcdOHA==
X-ME-Sender: <xms:uzQSZaiik_uOHbXBuo778rY44N4I3PwL5_gRMdsxEnc74c-cZWEkgA>
    <xme:uzQSZbBN1azh8vkJgNhvM60G-il_hCR7p6iw-ZYpQjUjyppYWAeDg3JBssBC_zhog
    RfZRQTguuCjDDLCXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecugg
    ftrfgrthhtvghrnhepgfeiieettdelkeehffevieetgeejgeffveefhfffkedvudefuddv
    veejgeehheevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:uzQSZSGMPnBpxE2FLuwPhejybGgZYc4ljo8wPyPU7aoSRTWskM85_Q>
    <xmx:uzQSZTS81g2KeyQd4eJQio0m7GOm9fRRFnLSjIISZiymmiSvnr9snw>
    <xmx:uzQSZXyeuKVB114erpw1liVOPuUOVWBcIrLyXIrD3ifOkZPfuTOrhA>
    <xmx:uzQSZSq3-6NyOTYpKOPYawPpq7Bd0dUP2ROJZ0jmgt-eE2OoIsjjww>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EE4111700089; Mon, 25 Sep 2023 21:32:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <e447ec5b-ae06-42cb-957b-30442bf4d85f@app.fastmail.com>
In-Reply-To: <20230925095532.1984344-4-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-4-u.kleine-koenig@pengutronix.de>
Date:   Tue, 26 Sep 2023 11:02:21 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     "Rob Herring" <robh@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>
Subject: Re: [PATCH 03/40] soc/aspeed: aspeed-p2a-ctrl: Convert to platform remove
 callback returning void
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Sep 2023, at 19:24, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling =
by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

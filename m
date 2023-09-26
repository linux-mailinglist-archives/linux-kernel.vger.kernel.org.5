Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4717AE359
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjIZBcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIZBcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:32:04 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DE101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:31:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 041455C055E;
        Mon, 25 Sep 2023 21:31:58 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 21:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695691918; x=1695778318; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=X1B7IwH9Z7pNYWjuJbsmT5j8TdwAG9mA2BJRnYuid3E3JnOKs6J
        y2U/xjtMaJQxhGS+WzfMfAwXxdc0gNIG/hi/dG0hgZBbrBl3KfRUzj54I71LKyzd
        qOWjjZLMJBJ5HXOguPKLyQkJGZuenrziik2wMu5d3j91a/jD6JqNfrPa0+6T9W17
        +jOsR45x4LQijVqSpScShEV6MrhUuFFMiSvsxpt4JiErB68eCAIRRj9DIkXwQVdC
        cBRp4vehqzynqVFfXs4qBwcsiDuMlkaH4NODEz/CKL/gqJH9dr5PCGlSPtcco96n
        /N/zxrMMLV+0wuqz75zbclHAP+1NzQkGOwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695691918; x=1695778318; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=fnJN54T9+SnjIHbVcow95ohxasTi4HnBQZIUWXwVuY51vwyy0iC
        9O+ceWsOPtw68oRgguX5Hb7lRF8yvJ1SBV+pfC5jHIpib+gAOv47OwS3yaPfSg4f
        CcvmrN1ItYfxiv/GUadeoX5lnMR4+SS7GOv2h2I/Al/Nd1DTyDb6HEMkWUvF+1bX
        65q32K9lA57rp/Dd+evlTPSR8EE8SE/FrkZG/q7NIhdVWNMP18eFiPyRURGEt0ts
        LiN9PBaP8aOitbtuOe+Ec8EZjEiaqCWLwzJgvZgrI0581gioT2mKMXP47rGAoPK3
        HfUT+4xm6spA/Ht5pDARwaGECO7P3umBjvA==
X-ME-Sender: <xms:jTQSZbZcg-hrl3m_f6-0O4PhJH7xcKYF8urFw0HPAljGzT7lQMsA9Q>
    <xme:jTQSZaYZ-JghluPL3FHYJVcN0N6F_kqkAWAq6lmmbNaXUGzlAnIuFSpaR4RnPgDRb
    67c7-huwf0G9ipIhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecugg
    ftrfgrthhtvghrnhepgfeiieettdelkeehffevieetgeejgeffveefhfffkedvudefuddv
    veejgeehheevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:jTQSZd9nFpnFir7uShfPmzV2roLNu7oYt7XxNz25uMQUOPLdmMe7qQ>
    <xmx:jTQSZRoAVLjJkPQSDSWTNCk3uZvMiyWhSHn5S3fwHoaCPLWPq0D8vg>
    <xmx:jTQSZWorF9SSMCuv80ZsFEood1IDBMSpK-6vnGjdJKkCUUGd-xKzzQ>
    <xmx:jjQSZXdb-f09A84in6OUrt3oVLSc1eJMRll-GOGaJ2NewT_RHfXZzw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 99F091700089; Mon, 25 Sep 2023 21:31:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <066ea199-30fe-44e8-a3ef-aca3ca92605c@app.fastmail.com>
In-Reply-To: <20230925095532.1984344-5-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-5-u.kleine-koenig@pengutronix.de>
Date:   Tue, 26 Sep 2023 11:01:37 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     "Arnd Bergmann" <arnd@arndb.de>, "Rob Herring" <robh@kernel.org>,
        "Zev Weiss" <zev@bewilderbeest.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>
Subject: Re: [PATCH 04/40] soc/aspeed: aspeed-uart-routing: Convert to platform remove
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

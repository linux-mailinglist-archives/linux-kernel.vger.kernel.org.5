Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDC57AE358
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjIZBbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjIZBbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:31:16 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2473810A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:31:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C1FA85C017D;
        Mon, 25 Sep 2023 21:31:06 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 21:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695691866; x=1695778266; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=eiMP9I+GYtijmNB30gzVkjhrZ07gKOEGyhOfsl71Wzz33L1Sny1
        rX4v5syH41sqU0+lwNZlnCazh3LYB6X+k0rPvmIfRJEwcAXCvEqdTpviZyiljv6A
        NqZ2EQQ+h840ORSuy8oXXoOHBQT7fNUVJFyixPzASnlNthryoEC0Bqe6BLuVRSjP
        unUwITl8Opus4zcdK8iYAtEWOzrobHEFroXwjN+RkHfSzjhG98u/UqaeLs+/HIfW
        UgLcg6lIY0LLMZiX5quNk/UJowncsfD7P39lE583/OF8ZPs5ezodkxX1kVQBbAfr
        fa3Mwqj08cYPDW6QsTqOh1CPkHsY/cid5OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695691866; x=1695778266; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=bjG9ANdSBUgpnplqMQZ5v+3DZx/VmzCVt4tn9IXyRJVkA4gZW3v
        qsKptQKPqZ4OKB/sJG/kuBfoKLVeSswySMaledWcp2oLuroGP9w/yDCrtUbGP6Bk
        pDF1cEkXFzMD9tjLf1j9o4RCn2WTTsFxrL1P/7VKd2wTBH+bbfcwa8WrLgMcajnY
        Ygo7+8EPbmgNvLao2+WWhy437Mmq+ExY/Edc9ceiX0fO1WjVbH/QpqNtsW5Ni/vA
        tmkuq8Xa+niEwneJFXwa2YxjfCeAWPwxHgLrApA/0Wtg/uJiVsrbpe/IJ+oDOuWI
        MvVrI5+rR25WdvR9orz8LhXeqLHoetF8+/Q==
X-ME-Sender: <xms:WjQSZcWvWkT_Pmn0CVwGHaYCs3xp6lIgtz5e8ThJyBfeEWqkI2mXlQ>
    <xme:WjQSZQnxGbzKgUBSH6vd9m-rP6dAAkCosS56sbz5Y0iByWVgCxOQ2Ge4NUUtjQGWk
    HVYXkUflRDgXi9TbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecugg
    ftrfgrthhtvghrnhepgfeiieettdelkeehffevieetgeejgeffveefhfffkedvudefuddv
    veejgeehheevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:WjQSZQYPRl_OKkOAF2tMOK2yF8-NZKt3AJrJiqX5mioRZdq3qpPrTQ>
    <xmx:WjQSZbU1v9RsPtKCJ-agKhaxCq0_zTO1hCuy3vNe3ltgsTvhaY7O_g>
    <xmx:WjQSZWlAyhRgW3AJFCwVZNZp9qlNhJrzvFKLpBY1FJ_0pcOZxmxbug>
    <xmx:WjQSZdvIa2U8ULxtE0u0fYpkqFnZZFUYFJ9P51iuwl1fuGcdcRxI6g>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 398831700089; Mon, 25 Sep 2023 21:31:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <39fe757e-0b0c-4aa0-9150-29bf4e255788@app.fastmail.com>
In-Reply-To: <20230925095532.1984344-3-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-3-u.kleine-koenig@pengutronix.de>
Date:   Tue, 26 Sep 2023 11:00:44 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     "Rob Herring" <robh@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>
Subject: Re: [PATCH 02/40] soc/aspeed: aspeed-lpc-snoop: Convert to platform remove
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

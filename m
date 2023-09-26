Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5647AE35E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjIZBdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIZBdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:33:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0C101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:33:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E25A85C2686;
        Mon, 25 Sep 2023 21:33:44 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 21:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695692024; x=1695778424; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=hIuW4ymTKqQ4AcVsxoZIYE3WOO4oCddhfwnhBZHX0suyvfCdq5O
        /UE8xYo17PaSaeQDBm99nGWhRh4fm/6bJ/neUWUM34Ut5qm3hqKDRM0l9HXMOA+j
        j5cIgH+jelC7MQbtgciHSXW0auQ+JIRZ0CtG3cmxVsLFmS5yc2y6+b01cANHB6EE
        DXoTa1TWVeZKj4fu8iL79lGMy6JgcW7icCGyecM9yjPtTbV+1u63Q0P7I6rauhhG
        bvaIsWyHv7z5iB4AJ5kRVIeUEQoANEttIIucsdSreKwiw2Zoj5/DQKw5+U8FNtYO
        I+pPvIK39aIZKGnncEajbgeyyLK2NBBUh8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695692024; x=1695778424; bh=w4gsiSlns8NKzCbLupKqwoRRqRNO/EeFJL+
        H/CZgEis=; b=j4TqUsQRKNKlyRbBubsg+GMJzT+6o+b+DJyngz+034OiFvn0/Jk
        AmOnhI90UEQZu4Bnq4x8JHqah7VCxPJ5MYVylNb5/USXSoWeIuCgDd/FpgIKxMd1
        8Y5u2V6JqvQVbj7AmYWYVYMNpbTCPiZOi65gFhoy7PiqrMOn8z8vmT1/nVmB114N
        GO/gHeBIi6Cvm0RPtqo2RssIGjJxgmT2AxvG0IHLGTn4I3HvhGNtCfr61OcthTSd
        q6mDPzQ2WZ0KD5e1lNP2MGilxQ5eCc4cKXgNxpoQIaWGBU5TARnaAxkw0DLrk81X
        A2bN3vD9tsqfKsdw73MegshEYeFExy4UeAg==
X-ME-Sender: <xms:-DQSZVnbdOA6QwqiLsmHdLusfTnCDRDYAC7aACMnpHCotjufhKaIfQ>
    <xme:-DQSZQ131TqvzocHClzhBZQex1kmAWVTOOBeX1kKS8tnE8i-Nm2bd9w7d2q6A_Hzo
    h5eHTNEBAampQkKag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecugg
    ftrfgrthhtvghrnhepgfeiieettdelkeehffevieetgeejgeffveefhfffkedvudefuddv
    veejgeehheevnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:-DQSZbq2NdObvNPCY5iZt5h4yRJ6Lei1pnq_uCSzyV89cNk9SXn10w>
    <xmx:-DQSZVlVZTS-kriRKXTOJnCzD4lVnZ0FFF-FJu9cVkZdKMKFI33_Jw>
    <xmx:-DQSZT0RI3JmBKW3NaLDOw1HQ_hwN-NGyjwS_5IQ0xQrl1iNzRVELg>
    <xmx:-DQSZUzl0oy8IwJIleKH-TJpLHn-IIH3Vsqk3uQcVEECZnMn_MslNQ>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A58A1700089; Mon, 25 Sep 2023 21:33:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <97424091-2784-4daf-b7a2-062fde210c2d@app.fastmail.com>
In-Reply-To: <20230925095532.1984344-2-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-2-u.kleine-koenig@pengutronix.de>
Date:   Tue, 26 Sep 2023 11:03:23 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>
Subject: Re: [PATCH 01/40] soc/aspeed: aspeed-lpc-ctrl: Convert to platform remove
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

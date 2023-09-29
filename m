Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7ED7B3A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjI2TOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2TOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:14:01 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD281AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:13:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0A44E320055E;
        Fri, 29 Sep 2023 15:13:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 29 Sep 2023 15:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696014837; x=1696101237; bh=zZPTi9rC6WiqSpWMNCP3ybSRnhAovP9bviw
        /z6BgAXQ=; b=E3letZpQ4ekkxzGazFRiLpwm7o2URG6Y+BYutSovQzMJ/bccR8z
        ObvOPHn9wQ1auA/MB3qGtR2wUuh1mQ8tH7JRyDA4dG8u2zFhwEnAoZoFwooXEdx+
        gTC3BIaJ3lYorRF/GvnsHUcd7ixu4mQOGzg+x7/G0Y6d8gYw8ilS1wB7sVCJ5zRI
        9mCLk9cuQWxkZ2M9KH5KyMo0I0kclM6HJVXh9QHR2F16yHzTQQYrrv+D7+u54Rxd
        Tm3oTuD8rGRxQe020F/FcGZCGgCL4gmrJNz8kyrsXWehCYQdiRkPoo8TVZISyww8
        0l47/aJp1/V6ujE88y0UmgpwWM6BW6m24+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696014837; x=1696101237; bh=zZPTi9rC6WiqSpWMNCP3ybSRnhAovP9bviw
        /z6BgAXQ=; b=kKbHxDsJ+iDXutFwP2fkVJlx2cxvoyFs19JgO6rvRgbcU69ZoV6
        vJT3+bri5+9HTt6FfCe3GcUdGtILRam7L7LevToNenRKYgB4psiGUgkugxpf4x+T
        J76vMoONub3XLMk4BRrkoJB5mYekP4qONNROCgNh4wKclItORCgQaJ4W8lqhA3Jk
        nmSmUWb4DPpO0GXftadGL8EiaBEX9WA4tMWYANSE07Ap/Acx5Xh5daS/8QIjVhLg
        X/f50ampDCTpwxrcICcUNgeSa/j67PJeoQ85VrRTUVio3nILk+wFoV4s8Id0F0A1
        Wr/EQxTvGuQML+ISjoJ63C/nGSdFxHVFoXA==
X-ME-Sender: <xms:9CEXZYht6wTLYYBw0DpelSK1A-M1l2nQE2C4ZHRMUvTsJx3vi6LwNw>
    <xme:9CEXZRDv-80uc1081A_CHfOgUXdkvgR1JZ8XcJtdZwjrDl44R-eYvSosfY7Y6yURM
    IiM9bDgIJKD4YoyCcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9CEXZQGCLUfKgyXIN1HVffKtuhZC900lVE35msSD_ynCaX0L863iyA>
    <xmx:9CEXZZSs_CxTTyRileYABBmzllPmgxoIAPknkCIDqGSTLf0InI5Giw>
    <xmx:9CEXZVw3VtcS0oO3s90bg0WdWdtEuPUsqB0obopGVXRpiJJ-w4q6MA>
    <xmx:9SEXZQ9Uli-nRCQFhrjQJwyGn-qm54H2iZu_9hb0oJzhUwPjTULaog>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C9730B60089; Fri, 29 Sep 2023 15:13:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <b0fdfb95-dcd9-4d63-9e72-5a985808de3f@app.fastmail.com>
In-Reply-To: <20230929060114.zbex7z4atuzojs45@pengutronix.de>
References: <20230928070652.2290946-1-u.kleine-koenig@pengutronix.de>
 <a5aadd2b-6c88-4a7e-a0e5-580dfe604c68@broadcom.com>
 <20230929060114.zbex7z4atuzojs45@pengutronix.de>
Date:   Fri, 29 Sep 2023 15:13:35 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc:     "Pengutronix Kernel Team" <kernel@pengutronix.de>, soc@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Fix Florian Fainelli's email address
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023, at 02:01, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Sep 28, 2023 at 11:21:50PM +0200, Florian Fainelli wrote:
>> On 9/28/2023 9:06 AM, Uwe Kleine-K=C3=B6nig wrote:
>> > Commit 31345a0f5901 ("MAINTAINERS: Replace my email address") added=
 13
>> > instances of ...@broadcom.com and one of only ...@broadcom. I didn't
>> > double check if Broadcom really owns that TLD, but git send-email
>> > doesn't accept it, so add ".com" to that one bogous(?) instance.
>> >=20
>> > Fixes: 31345a0f5901 ("MAINTAINERS: Replace my email address")
>> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
>>=20
>> Embarrassing, thanks for fixing this Uwe!
>>=20
>> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
>
> Who picks this up? 31345a0f5901 went in via arm-soc. Arnd, will you?
>

Yes, I've already included it in the arm/fixes branch now, doing
some final testing on the branch before I send the PR.

       Arnd

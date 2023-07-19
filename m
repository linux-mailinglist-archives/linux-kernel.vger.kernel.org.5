Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0475941F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:26:32 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292CE4D;
        Wed, 19 Jul 2023 04:26:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id EB43C3200929;
        Wed, 19 Jul 2023 07:26:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 19 Jul 2023 07:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689765987; x=1689852387; bh=mD
        imigewmW3nMEJvSbjoGyHdnkBM+54sakILIw7rvCw=; b=lxiBjfqdegMMLqCzTD
        rDjT/jzYGMvhreJ8bov2nBM3Q23o+uXqmDkyBqBIlUjBcrAgOfe9FRCY642KGJ+f
        coXKBZIi1vxWVXDY1ATwy1FR9tHj9olK4tB9COiv74a31gIpS4Yt4xM9tdIyzuIw
        9WunAtm7tiYbzrsUBwJjf2BozUqUH3PbguNTsZ7U4oMENeBwXa5/3oDmhljC/CI3
        nBTZJTH2GqTiY3H+mW/mhVWKBuHK2k5T9snjQ3bjInyDnfwuC8JtUIFcQ97yIxmd
        sXQ/wHcNIybTDB6QEXUOkcv6zk73kGeiFkfLU3RSmJYjmn86w/QKeCz8b8etXzUg
        XLIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689765987; x=1689852387; bh=mDimigewmW3nM
        EJvSbjoGyHdnkBM+54sakILIw7rvCw=; b=Qv3DbYCHxiXOUWbm/ZC3xIqdV99fk
        gUGmF4B9p/tGncXwnJb0h9XhjrgRluwAdGu3Tm+c/YLKvV+ag3q5M1HMEhAmvmJr
        Gq/fdU0zzC8rAMXttuRVdcFL3EFfnbvn4f24DZsBCiw5KVWYNTWaSdMaaMmqF4gt
        O/0+rC06YVRuM1d0iykH3WcYnYtPwhAGHKpjlBMOIEsxBAXS9NrH76pPjVZEPtUA
        rPvl7R2h/jYsHBhV2x5UfNuj5joP1TpwvLjnLc3Y5fhoCsqPC+vDPntIm7KXinvr
        L7PKZ+kH1zreKGVRYR9Hm3qXPrCbsGU/7VuNi+dcNkKEzxwfVwff9Sihg==
X-ME-Sender: <xms:Y8i3ZKarZHkOWUoyj1WKDLDUrq7euxanvjr8C4B2X6fEwBh0rGuLFA>
    <xme:Y8i3ZNZVEpvgOHS8Hin8q9aB3fSeoHv1TMpXhTSG6LlKZhE5g-FLzH1ru8Fc9F8GY
    Ou1fKFxCkmHW3-DNiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Y8i3ZE8olSz_V8K5f0SGTXRLq4zStgly3_jVCCj5wILcRdOsGS0MiQ>
    <xmx:Y8i3ZMqPcO26jlO20bp_8k1F1fLMfr0ORJol_f-r1z3drR6L12hmCA>
    <xmx:Y8i3ZFp5mDDDJDew0ynktm6nbzB-GlX_wxI6svqt0fR3j6FJ92_X4Q>
    <xmx:Y8i3ZA03US-QuJ8sXvoZrOIegS3Zps0PEnnhlgwRo7xT1-CI3ItfLA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01EECB60086; Wed, 19 Jul 2023 07:26:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <3e7dbbf3-351c-430e-9bfe-a9e9e9cb895c@app.fastmail.com>
In-Reply-To: <319ee5f7-2dbd-430d-8ab1-a7b072ac7a9f@kadam.mountain>
References: <20230718193913.3578660-1-arnd@kernel.org>
 <319ee5f7-2dbd-430d-8ab1-a7b072ac7a9f@kadam.mountain>
Date:   Wed, 19 Jul 2023 13:26:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Shenwei Wang" <shenwei.wang@nxp.com>,
        "Andy Shevchenko" <andy@kernel.org>, "Marek Vasut" <marex@denx.de>,
        "Marc Zyngier" <maz@kernel.org>,
        "Dan Carpenter" <error27@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: mxc: fix unused function warnings
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023, at 11:44, Dan Carpenter wrote:
> On Tue, Jul 18, 2023 at 09:39:08PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The new runtime PM support causes a harmless warning about
>> unused functions when runtime PM is disabled:
>> 
>> drivers/gpio/gpio-mxc.c:612:12: error: 'mxc_gpio_runtime_resume' defined but not used [-Werror=unused-function]
>> drivers/gpio/gpio-mxc.c:602:12: error: 'mxc_gpio_runtime_suspend' defined but not used [-Werror=unused-function]
>> 
>> Change the driver to use the more modern helper macros that avoid these
>> warnings, and remove the now unnecessary __maybe_unused annotations
>> 
>> Fixes: 3283d820dce64 ("gpio: mxc: add runtime pm support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> The patch is nice, but I don't understand why __maybe_unused doesn't
> work?

Adding __maybe_unused to both mxc_gpio_runtime_resume and
mxc_gpio_runtime_suspend would avoid the warning, and that is
what we used to do in the past before we had the new macros,
including for the mxc_gpio_noirq_suspend/mxc_gpio_noirq_resume
functions in this driver.

Since I'm moving the driver to the new method, it's best to
do it for both pairs of PM functions at the same time, so
the __maybe_unused annotation becomes redundant.

      Arnd

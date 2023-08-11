Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DB7790E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjHKNi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHKNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:38:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB022ED;
        Fri, 11 Aug 2023 06:38:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 386155C0099;
        Fri, 11 Aug 2023 09:38:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 11 Aug 2023 09:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691761102; x=1691847502; bh=FS
        1HpjgV5XWBmUntM3Uxn3bym8vCanuc3UC0yqx/KW8=; b=PjWFWT7UYzW6ZfAj/J
        +Fv0hoZeXq1YPNcyENya6gIijy0/PaUqhYLzhnJOSUDkE516eFZoBAGizkzTJnfy
        lEx7X0vVkxfxe042X95w84QlYp7eTFHTyQFdsBEBUU3hOzJt6sdD1kE579iQkcze
        V35ou5vqgW8N59ufIH4nyi56/4Hp6pq9c9R5LOksMs8XiO1cebkdaUbzqnlgVwff
        AF+N9/nHH8zdURpPexWi49qaOUx6xfCO1xkEN3EhLgVb43OTJcKQkc3s00dvsi7n
        /JRzdsAEaEpopFdezS8gO0767iVhG+dHmKjVBj/9D3wFbJU5O3TFNWpCg+KMtUpF
        JDIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691761102; x=1691847502; bh=FS1HpjgV5XWBm
        UntM3Uxn3bym8vCanuc3UC0yqx/KW8=; b=TQQbf3Mu01WkJwzGpHKzbchWQj16P
        I+klZ0U7DlPXKh1YREsN8OgtsU+H/J/Yg0yorNWJQnwHTokM4qgHBJA4sy1tpY3R
        FMtfBrqNyGSawXBMSkJ2YpW9rAZuy4cs+ba0XntzIji73wPOU4WJiSbngxU2zgNM
        nMvvxWjWD36dbDxvhWb2RgcpvIB+nR84VsbzhUP1GZSdehRyyo0395Pi3urK4f7F
        w8meh4ysQ7QYZvrB5721d+sd6euOXKlkCZzVlq5lOLQ+Itx8DH5dDk/9beIOflAK
        wt61ohFhF7UC5YmboL4WcaCWyaTIZV+0dJys/3D4GxLbr3gGoeEwmpG9w==
X-ME-Sender: <xms:zDnWZP0mnJDANDj0MfLmJ_fpTZfDXH8Iasyp5io9ZiW9qaUur57opQ>
    <xme:zDnWZOEDtnxKvb-paTYhrkPb44MfK-8NQRhnfKXNQlPI0UhR_gUxvkHFqdaCbfr9s
    25maaUJnAKoGiVCMYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zDnWZP4kyEkgMmwOZ6cOHuKg2CKyjQ5cpLotp9x43ll21PF8cDomjA>
    <xmx:zDnWZE1gf95ogYQrj7s3dqr6BfyQU4fqHV2Te9uDldrl3bulhwqxCw>
    <xmx:zDnWZCHzAPbr4aoW0j33YTfeeL21WZw0S1SgW5sJp8nDgkSjv_y7cw>
    <xmx:zjnWZPceAKh_hczubs1YVb754fJvuV5IXdK3We5yN3avfb9RhFYtMQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AB450B60089; Fri, 11 Aug 2023 09:38:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <8c3b242f-7d6f-4bec-9a44-61ac65a26637@app.fastmail.com>
In-Reply-To: <ZNYSFWA3WNAdRqfg@gondor.apana.org.au>
References: <20230724135327.1173309-1-arnd@kernel.org>
 <ZMyz27awrVJ8QHzA@gondor.apana.org.au>
 <d9184ad7-7d34-45bf-81e3-db053bf7425c@app.fastmail.com>
 <ZNYSFWA3WNAdRqfg@gondor.apana.org.au>
Date:   Fri, 11 Aug 2023 15:38:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Ryan Wanner" <Ryan.Wanner@microchip.com>,
        "Yangtao Li" <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        "Sergiu Moga" <sergiu.moga@microchip.com>,
        "Ayush Sawal" <ayush.sawal@chelsio.com>,
        "Gaosheng Cui" <cuigaosheng1@huawei.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH 1/2] crypto: drivers - avoid memcpy size warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023, at 12:48, Herbert Xu wrote:
> On Mon, Aug 07, 2023 at 02:04:05PM +0200, Arnd Bergmann wrote:

>
> 	struct atmel_sha_hmac_ctx *hmac = crypto_ahash_ctx(tfm);
> 	size_t bs = ctx->block_size;
>
> 	memcpy(hmac->opad, hmac->ipad, bs);
>
> The block_size is set by the algorithm, you can easily grep for
> it in atmel-sha.c and the biggest one there is SHA512_BLOCK_SIZE,
> which is how big hmac->ipad/hmac->opad are.
>
> So logically this code is perfectly fine.

Right, that was my conclusion as well.

> There is no way for the compiler to know how big ctx->block_size is.
> So why do we expect it to make deductions on how big bs can be?
>
> This warning looks broken to me.

I'm still unsure how exactly it goes wrong here, but I suspect
it works as designed and just happens to run into a case in these
drivers that is just not that common. I also see that the kernel's
memcpy() declaration is missing the "restrict" annotation,
but the fortified version calls the __builtin_memcpy() variant
that has an implicit prototype with those annotations.

> It looks like there is already a solution to this though.  Just use
> unsafe_memcpy and be done with it.

Fine with me, I'll send a new version doing that.

     Arnd

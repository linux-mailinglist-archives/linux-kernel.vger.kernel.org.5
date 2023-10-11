Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722707C5605
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346782AbjJKN7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346969AbjJKN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:58:55 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF55A4;
        Wed, 11 Oct 2023 06:58:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 10527320097E;
        Wed, 11 Oct 2023 09:58:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 09:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697032729; x=1697119129; bh=55
        13x7CGlfvER0v0ogwIOJMgIvkS5URYby8pnUxjHR8=; b=alJF+gknS2t5bXhjAI
        sHkdyHEbB2MitewZdRAIdFZasn477ImxMwNrXFioAbdM/U416qCeUfcxm9BpHs0R
        M4bK/poCaK1m8vfq95p64ppRkVYwHdBThVzOoqlDaoatV6H0MTzq0Q/Z+YJBnBxu
        YDv2opHprMua5t8BGYHezCnyj45pYOUa6JsT4cIPv5BEc2JMq7yRbui/M546V3pc
        6bOos0XpBCVBtt36Ah2ROhXetL2mxZk5zmL2zExElh0GP9jiX+97YDngBwKnwa3D
        ZkMh42iadXSCupDijSt9sGgSlyqJM6Y1j58N2r5CONLd6K6pJbsvugGxUBf6TeCr
        WQ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697032729; x=1697119129; bh=5513x7CGlfvER
        0v0ogwIOJMgIvkS5URYby8pnUxjHR8=; b=POeVMESARlnmKLJfn8KdtvyPlYTG6
        rdbHlG0otsElBsUAP6PO/EUIOBpHrZ8kJjxMELYwVJn0l7mhV+ZxwMrZoD2TVOGG
        W9BOLCQePG/hO54QeCtPGVNj8hmIrcoJq7MgKGUjQvO2Bw8p1cs9efMozPxMylmk
        RyBox4WkV4QfKj69yjYchYSELECrYu2RxY/AKBoU2+NH1o6AI2BeLcDwI+L3xH5S
        YM7ttmwmYMxKWU634w9OLqrgsAuB/kaqS6rej5kLeT7JDcMfd+0jUWkMLFG5Ejxb
        FodyPV1/T2gJPZw8QEOMkhQ9dyy6ow6r/+s9EHLC6O4givhy8YlUNaDRA==
X-ME-Sender: <xms:GaomZbV6q8RmxQ-S8K9LBD_37CNPSDmx7xYMsq3jygiS8iwY4mkR8A>
    <xme:GaomZTn5EyqxG0KeWEWTmKosDZheRMiW-zCyd-5-IQ4DueQYUd9FEgq5X7bAmnSEf
    wWsIYC4XyongdeR7VM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GaomZXarVgL099yr9bZj1XydrRvGNIQO4m8LHvsvLkCWI_ZwZN_cLQ>
    <xmx:GaomZWVxnobGn3E7dcVdcMlXue6aDZ_YBtwrYxdLsgUICrxM5Bsa4g>
    <xmx:GaomZVnKtgZSpIPxtAZb4PQGA2hRFkSzTmtWobTkurdjX2sX4Vqbqg>
    <xmx:GaomZbfIN1j-4OmLC7i9t1_m52NFOc3VoWAWXckXvId4jDJxM-b7YQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1AA24B60089; Wed, 11 Oct 2023 09:58:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <08cfd4d6-d12f-4e63-8f87-12cda83fa7b3@app.fastmail.com>
In-Reply-To: <87v8bfezcz.fsf@kernel.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-9-arnd@kernel.org> <87v8bfezcz.fsf@kernel.org>
Date:   Wed, 11 Oct 2023 15:58:27 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kalle Valo" <kvalo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Jakub Kicinski" <kuba@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        "Johannes Berg" <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, "Doug Brown" <doug@schmorgal.com>
Subject: Re: [PATCH 09/10] wireless: hostap: remove unused ioctl function
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

On Tue, Oct 10, 2023, at 09:00, Kalle Valo wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The ioctl handler has no actual callers in the kernel and is useless.
>> All the functionality should be reachable through the regualar interfaces.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> In the title we prefer "wifi:" over "wireless:" but that's nitpicking. I
> assume this goes via a net tree so:

Changed for v2

> Acked-by: Kalle Valo <kvalo@kernel.org>

Thanks

> Let me know if I should take this to wireless-next instead.

I think it's better to keep the series together and merge it
through net-next directly, since the last patch depends on all
the ones before it.

     Arnd

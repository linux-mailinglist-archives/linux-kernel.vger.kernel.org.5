Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD777BF574
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379448AbjJJIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442712AbjJJIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:16:06 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E4197;
        Tue, 10 Oct 2023 01:16:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 44FD13200A7A;
        Tue, 10 Oct 2023 04:15:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 10 Oct 2023 04:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696925758; x=1697012158; bh=37O+bLcXHzAtlGTxAl7BM9VidjbxHB5bNg3
        Khnx7FEY=; b=VX5fC4Q/Fwzp47Fe1GjiddDyNK6GDmgxx9AnAlw4N6tKQ9xxeBk
        zFlj2nlHzuctJSCQlBv2ocNWNH2aGJ6TkRsuPsCPAmGsEwNdqNQfnfXyjQFdLmC2
        p20GdS9jwh1UhwKKIhrVXTgpEO66+qw4ocoezSvp+Hk+zWMDywZxkPKfwM8WKWNX
        30DuzJc7DSxQoCHRrnZAjwPrYfD65PQI/ZzQa/2hVyrj+dEd5bc8MzAN09+K7VOi
        IMZHBtT2nuMB+UyNtJTp4PVF6VbA+0wPZd6RHDkEoyMSwk3r2sSiyAs5nztOiIQ6
        ye+LVryb4ZqiKVba2ZACFlsWyGGFjAn3pvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696925758; x=1697012158; bh=37O+bLcXHzAtlGTxAl7BM9VidjbxHB5bNg3
        Khnx7FEY=; b=h28zTzFXfFrEIvsbBtlAfMw0eohC+N8xcl2PZe9Kt3YlxfrZqXG
        LEBluCJSUym0hj2jGGfiAeqFNWkxjl7aDHJ+X+JYVr4kE3+QAp5EZ+JmY/jd4GHM
        ydK2HCjCxGdSuhF6dg5YgVhVw3jOis7wUxmVozKbKDcj8OhoEwB1rzuaP3PwYzjs
        7EY+jFPyrt1HKFHC+EXe16a8K8+vfRk7SdHowKaYYof6YDLEUEXVjzK0VHZG2H+r
        J18d9S0uNBjcariQVw4gZ2yDZuc6dI2cfR3MAc3wyM+dku8Mt+Nk9iXMD6Q0eGkK
        Om4hmkiXa5LPS3H4J/Yma2LN7KxrTu0EmXw==
X-ME-Sender: <xms:PgglZTAGcVIWHAnllWjXsXLzjrKuM5Ia5b6pURc-mYQz2Q4Se0aVBg>
    <xme:PgglZZje5EFxgF098kwzO0XJE0zxvlw8wplo68kuRsgPo5ZKmIgbbzTw5pXfWSk2t
    foH45KKGLoglj8-kiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedtgfejveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:PgglZemu76nlIQmFWr9QTNdfapasFxAjU4ddnU8Sq_F_XhYxQNBl0A>
    <xmx:PgglZVw74kOKcxNCm28y3EDpsrNJ90A1UHaex7izTALL6caigKZOoQ>
    <xmx:PgglZYSyu-Up5FKPRurAXX-XE-pfpCH4V0bFBhnfJjxnEXKAu3tPiA>
    <xmx:PgglZcb2rHKW8mgK4EV70Q9Ym7cs5vMZJmjRUQjAuSuoc7zvNhZeqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2C21EB60089; Tue, 10 Oct 2023 04:15:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <2d325867-95c9-4bff-8f24-9083c730d7ba@app.fastmail.com>
In-Reply-To: <DE61EEA5-D560-40B6-8F4D-22F299AC61ED@xhero.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
 <3cb4bb96-1651-4179-9c32-507937282d7d@app.fastmail.com>
 <DE61EEA5-D560-40B6-8F4D-22F299AC61ED@xhero.org>
Date:   Tue, 10 Oct 2023 10:15:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rodolfo Zitellini" <rwz@xhero.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Jakub Kicinski" <kuba@kernel.org>,
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
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023, at 09:10, Rodolfo Zitellini wrote:
>> Il giorno 9 ott 2023, alle ore 19:29, Arnd Bergmann <arnd@arndb.de> h=
a scritto:
>> On Mon, Oct 9, 2023, at 18:49, Rodolfo Zitellini wrote:
>> I can see a few ways this could work out:
>>=20
>> - add a custom callback pointer to struct atalk_iface to
>>  get and set the address for phase1 probing instead of going
>>  through the ioctl
>
> This was my initial thought, at least for the moment, mostly to keep=20
> netatalk happy and make sure I don=E2=80=99t break other stuff that ma=
kes=20
> assumptions on how the address probing worked. There are other bits I=20
> would like to improve, for example tcpdump (which parses correctly=20
> appetalk packets!) is broken in the current implementation.
>
>> - rewrite the probing logic in aarp.c more widely, and improve
>>  the userspace interface in the process by introducing a netlink
>>  interface
>
> This is sorta the =E2=80=9Csecond step=E2=80=9D I was planning, I thin=
k the logic for=20
> probing could be redesigned and simplified (it also does not work 100%=20
> correctly), and it could be a good chance to improve the interface wit=
h=20
> netatalk too.

Ok, I've adapted my patch now to not actually drop the
localtalk code for now, and sent that out, I hope that works
for you. Even if we go with the v1 patch that removes it all,
you could just as well start with a revert of my patch when
you add your driver, so in the end it shouldn't make much
of a difference.

>> - Move your entire driver into userspace and go to the kernel
>>  using tun/tap. This has the added benefit of avoiding a lot
>>  of the complexity of the tty line discipline code you have.
>
> We had some discussion too if to just make the lt an userspace stack, =
I=20
> personally like how it is currently implemented because existing code=20
> can run basically without modification.
>
> I would propose at this stage to change the TashTalk driver to remove=20
> ndo_do_ioctl and to use a custom callback, if this ok.

It looks like you still need a custom userspace tool to set up
the uart for your new driver, so my feeling would be that having a
userspace bridge to implement the localtalk/uart to ethertalk/tap
driver would actually be nicer for both usability and maintenance.

It's not something we need to decide now though, and is up to
you in the end.

      Arnd

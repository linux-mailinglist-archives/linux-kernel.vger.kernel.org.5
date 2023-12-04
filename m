Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF48038BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjLDP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjLDPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:25:51 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8504C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:25:57 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8623B5C0245;
        Mon,  4 Dec 2023 10:25:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 10:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701703554; x=1701789954; bh=b7
        Jfe0z+E3yskagVg0fpJ9qK0bnSoK3D+mAs7GPfrWE=; b=nZPEKAl3tL1Ryy0L4G
        e70iBH7XPg5GZXpI4ZD540jR5VMnFQjlK9Ap1oqqlKUH7RklM0I+CPbQA2yLl01+
        BgPJXRMEaBxGRJ8kfTXyi05Jzee1hb6fvnL0MRWwXVVIk5epHfLrZCRAWAQO+n3Q
        lZRsLfhhRRS0uuHuIxDgQGRZssQzPjqXPy0fFZSoTBul/PtolFcd+Pqk3X6wL9vn
        LRzUifzQUhZyv6BPYGVtW5kIVyCZfbDX2pBL8VaigqQvLY2zS5M0P2PjsNbyg26y
        y9Gg/EqHwdb4xXce7qaa3/odxnC3ZKCeR62ZGUnsGTfbe8e3zjOKqXSFDYPk1/T8
        8wKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701703554; x=1701789954; bh=b7Jfe0z+E3ysk
        agVg0fpJ9qK0bnSoK3D+mAs7GPfrWE=; b=e7a73IB0wSDU5OBI467rwpcGSG/yE
        p3N1pNk0dKEggTC9tQdaADVAujTzXq8a2nZY23h87CZyRQZNxrAqt5fEluv0Sykt
        f/cWNfC5JNG0mCAZhslx/LbjymazFbgHs8KVVsK7Wpp9fCyuIuwJTncSB8405k7Y
        zn+DE+TkG94PMacYL/nfBab6JzoRDWn3aefO4T/gOIpE/ANy4CzgbsyngbeEpWQr
        2wb/kKUmPmPJl7EfovjAf7kM3/G5CH+BbVc4BgpIgGGqUjM444KVVE961w1E5Hoy
        inO7o5dQiKJWOTvH5qeMZAoPSk2PnG2CmplXdrUChxHQFrKB/5QX1z6SA==
X-ME-Sender: <xms:ge9tZeEdTVbRqhQUwjLTchh25-gxQv-YtndoVMVoRJ6wYbEf_MiEsQ>
    <xme:ge9tZfX6D_m3sc0SURkFITecicX5uOjBGXww6pWD51Pq9oBF-ZCbHitNGnJknWdFd
    0h34DRI2A1e_ysLNAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ge9tZYJQgi7kvpyKRdgvGXc2drXrI7CV4wsxhSKd999kzoJ9rTmEhg>
    <xmx:ge9tZYF_jBqrKlAxjiq65QSiXNmU6wvRfV6GE6RNpvMXWVOjqGeAZg>
    <xmx:ge9tZUX0jy3Bc01pNsk6cjm6uobCJLwZOtjD91OotlrVeLhrToIe_g>
    <xmx:gu9tZWK9MRkA58r0c1NYdIHJmnHRJk87IG6gSTR-0_CjjhUSCs4yFQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CE083B60089; Mon,  4 Dec 2023 10:25:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <b1ed5744-5262-492b-af26-96c70982ab1e@app.fastmail.com>
In-Reply-To: <20231201232614.jvj4d5nu7j2xf5ia@ability>
References: <20231201171544.1901-1-francesco@dolcini.it>
 <20231201191958.kmwkpmttmebsas47@kooky>
 <ZWo5kVMoLTzST6F5@livingston.pivistrello.it>
 <20231201232614.jvj4d5nu7j2xf5ia@ability>
Date:   Mon, 04 Dec 2023 16:25:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nishanth Menon" <nm@ti.com>,
        "Francesco Dolcini" <francesco@dolcini.it>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Tero Kristo" <kristo@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>
Subject: Re: [PATCH v2] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023, at 00:26, Nishanth Menon wrote:
> On 20:52-20231201, Francesco Dolcini wrote:
>> On Fri, Dec 01, 2023 at 01:19:58PM -0600, Nishanth Menon wrote:
>> > On 18:15-20231201, Francesco Dolcini wrote:
>> To me Arnd was just stating a fact, not raising a concern that was supposed
>> to be addressed (just correct me if I'm wrong, of course).
>> 
>> [1] well, apart AMD Pensando and Bitmain, at the moment, but you get the
>> point, I'm sure ;-).
>> 
>
> Hehe, thanks Francesco.
>
> Arnd, my memory was a bit right on the topic though.. .. I think we
> had gone down a similar road before in trying to increase the number
> of 8250 UARTs [1] but without this strong a reason.. Been a while, I
> think our v3 is much stronger case now.
>
> [1] 
> https://lore.kernel.org/all/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/#t

I think in that case the problem was that the aliases were
done in the .dtsi file but enabled in the board specific .dts,
which would be pointless and confusing.

If we have a board that actually wires up more uarts to connectors
or devices, can clearly raise the compile time limit to whatever
that needs.

       Arnd

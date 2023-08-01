Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A334676BB32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjHAR2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjHAR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:28:09 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5DB0;
        Tue,  1 Aug 2023 10:28:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BE1443200786;
        Tue,  1 Aug 2023 13:28:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 13:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690910885; x=1690997285; bh=pB
        pYc/Pf6EGtAPeRfMhWXTZpwXc2kxuh9RaouaWP5Dw=; b=Nsg+7TxwZjrfPQ0oUg
        Rd6gTA3CErwZSNBVie63BRxs9h6FBgRV8/3PuKHqUYEnEu3EEDOP/AbKtmrfpkjJ
        46ImZDp7lFRV/tj/HFACQRWOcj5TxnOi/hbEtOxu4jUButpFnUeW8+oEfXeHBIvG
        eBPQtO0a7cXSeUc3auFEgkTwJIJI59b9LKX2LKqr91BoXjLrh2rWJNH9S0vwTpGE
        L7YIZ9G3s3aeQyceSuNmGtF+TJ6nMDEShXsE93eVw1TmBypL7a/FUH8eHvXCXkE0
        kR/AiAPMnXicENica8y8iVSx1GpQ35nyyE8opqcofFl1LJz2Xr4Rp5tSUfBsgSXe
        MvLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690910885; x=1690997285; bh=pBpYc/Pf6EGtA
        PeRfMhWXTZpwXc2kxuh9RaouaWP5Dw=; b=iSXVeUBA4GKKpcMQFBgspREN365eW
        PnF8/KeAneSZRg+gggl2J22u5eeTprMXHUdYbwL3BUu2kyDdT2OHTeiyPx377FNc
        P4sR5zN4z899zJWyPPNDRon85E/tOnRiwhHBLR5xCrDnN1DTkKD+Fc6gvnzAnPoR
        ZFPOquO0ss5gy11sOamUF4bSvbQYZfsf40rXSxF82/dTSax4b8TQq9fXAMEKf/iB
        DFsKR85PcSwvKR938w2M/GGWKRRmEnp3Y3bR+RNXmU0nW+Pv3RIqvXDjr/Gxwigt
        u9XfYQflMIeCjja0l4jB29FW9O5y1BRf97KAMfhrcTcCM9M7stfNLEVyQ==
X-ME-Sender: <xms:pEDJZCFHMoIEi0_cCZO9ZwJjueZCHRyMR8Ofe90iDsIUayKJ2v7tyw>
    <xme:pEDJZDULshMJlCAsK9bRZmQQvbtyTFUISO0rbDPHpv-pipkNqFmiotqAFCbUFO-ee
    lJQb-MWRkI_AvKyXs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pEDJZMK7HJugwr8VpLH6EMN-UDvUKPbLpsyTkSJibenVWxwhp7h0dg>
    <xmx:pEDJZMGpp3NkTYEKgECHYNFL6sA_UWIdH_kUZumSIxGEw2qKJjT2SA>
    <xmx:pEDJZIVxFvnTVTrD5zzJL_VewZKxdu_9DmgyCr298k7iArTkmIQg3A>
    <xmx:pUDJZJsHq8hLtjehM9o8mpkXz_eDn5miyg0-GrtI6QKuzmxrs1qONA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9176CB60089; Tue,  1 Aug 2023 13:28:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <b795ccdf-ad53-407e-ba01-a703e353b3fb@app.fastmail.com>
In-Reply-To: <z3gp6rcrlotwjwux7chza4vmbgv747v5jlr4xhuaad3y2yofsf@jjiju6zltbmh>
References: <20230801150304.1980987-1-arnd@kernel.org>
 <z3gp6rcrlotwjwux7chza4vmbgv747v5jlr4xhuaad3y2yofsf@jjiju6zltbmh>
Date:   Tue, 01 Aug 2023 19:27:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Daniel Xu" <dxu@dxuuu.xyz>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Jozsef Kadlecsik" <kadlec@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] netfilter: bpf_link: avoid unused-function warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023, at 17:20, Daniel Xu wrote:
> Hi Arnd,
>
> On Tue, Aug 01, 2023 at 05:02:41PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The newly added function is unused in some random configurations:
>> 
>> net/netfilter/nf_bpf_link.c:32:1: error: 'get_proto_defrag_hook' defined but not used [-Werror=unused-function]
>>    32 | get_proto_defrag_hook(struct bpf_nf_link *link,
>>       | ^~~~~~~~~~~~~~~~~~~~~
>> 
>
> This was fixed in 81584c23f249 ("netfilter: bpf: Only define 
> get_proto_defrag_hook() if necessary").

Ok, I guess this will be in tomorrow's linux-next then, right?

    Arnd

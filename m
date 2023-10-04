Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE4D7B79F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbjJDIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJDIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:25:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BDFA6;
        Wed,  4 Oct 2023 01:25:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 563C15C02AC;
        Wed,  4 Oct 2023 04:25:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 04 Oct 2023 04:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696407924; x=1696494324; bh=aq
        tZu7OFev7NROEvHGfYU30sQ+IlAUffS+3M2Pl5nF4=; b=QjhymVHWCqusF8IFqT
        ikZjK6+FYk62zzoOY02+GtlFMMYgrPC8q8moBEWyctTt6AEIPTbXPogUOAQlQaU1
        NFGkH9LjZBkt1/oIQe6NARo3fCY26gdZqXsC/3Ir/spAs7RXGVAy8/lzjY0+XDda
        Gu0dPduOCOdBizXgePcKUDorKki5BZAg+zKNiZN0BXI0oW2VbDXyQm1dEXnZl9G7
        ctuLq/yh4R8hodREyyuNZE+2IQU/rEZQPV47uBGDAjb3hqr3Chwv3pJgd85gqkrC
        wkFzWSISTswJHDyZASe/5WN58Y65xx2XgstA7+PG+Qd3VzX8+AcZgRaAQMCUQbRm
        sz7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696407924; x=1696494324; bh=aqtZu7OFev7NR
        OEvHGfYU30sQ+IlAUffS+3M2Pl5nF4=; b=P+F31/JaounfPvJtB8ifQo9UlK2wY
        VDzT07Umo/inHQhOv+N20tod9dXqxMBQtMyWQtTn8k5EXWQEx8hvKNWo2wtBqdv8
        rdzZU/CXPT1TnjROA+MMf65bRX6DPAXtrv7k9wA/tdN0szYX3KCCTtYLw83MoE83
        3KZ5Yldj302bDaKyo07Yqn29hOfPYWguRVo6WRl5juRSiyk9OQw1H0uVhOIs11xV
        /XWqiNk2XJixQwOkMqYpxSd2KHs1jJIneViSHugqYq3ZjNaKY7dFJMIquXnAZ/oP
        qXHdMQjwSSSzkj/cIm/5PbsfXhgdbNHSaBZmC76NJf/Eh8o+slHt7zCxw==
X-ME-Sender: <xms:cyEdZThGkcgtQKiNst9aTwmEfzTst4M7xcrSYZmWa3IkY3bRp17LkA>
    <xme:cyEdZQBSh34aldmGUvRX7_wdtWHlOh3lMWKMjw6KHlxYUaiTNBtD4-avXcJaZ8JAs
    u4Mq1v7YuvMWYk6XOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cyEdZTFCqgKmgsRORsrDsuR3xr0oiFQ3Ydqt6Y7zeOtu8pp1R0q8Wg>
    <xmx:cyEdZQShBeKyeRzuSBnw7h22xWk9cVMOAIrLycCyt_kkaMK4v4cHkA>
    <xmx:cyEdZQzrAm_5oERKTLRD2DEmY3_rMxL8KM0lNK8ZzDxQBMciokUpTA>
    <xmx:dCEdZVhJC96TxtIqfrsA2ZZ39TmeWfs7mqWtsqOL1RwBAQvUvPxxPQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A361EB6008F; Wed,  4 Oct 2023 04:25:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <4ed81222-9409-4c9b-bd29-dbaf4275984f@app.fastmail.com>
In-Reply-To: <20231003154326.213e9c81@kernel.org>
References: <20230925155858.651425-1-arnd@kernel.org>
 <1430f3d3-4e84-b0ec-acd9-8a51db178f73@intel.com>
 <20231003154326.213e9c81@kernel.org>
Date:   Wed, 04 Oct 2023 10:25:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jakub Kicinski" <kuba@kernel.org>,
        "Anthony L Nguyen" <anthony.l.nguyen@intel.com>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Alan Brady" <alan.brady@intel.com>,
        "Sridhar Samudrala" <sridhar.samudrala@intel.com>,
        "Willem de Bruijn" <willemb@google.com>,
        "Phani Burra" <phani.r.burra@intel.com>,
        "Joshua A Hay" <joshua.a.hay@intel.com>,
        "Pavan Kumar Linga" <pavan.kumar.linga@intel.com>,
        "Madhu Chittim" <madhu.chittim@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        "Alexander Lobakin" <aleksander.lobakin@intel.com>
Subject: Re: [PATCH] idpf: fix building without IPv4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023, at 00:43, Jakub Kicinski wrote:
> On Mon, 25 Sep 2023 10:05:03 -0700 Tony Nguyen wrote:
>> Also, a pending patch for this [1], however, this does look a bit more 
>> efficient. Adding Olek as he's author on the other patch.
>> 
>> netdev maintainers,
>> 
>> If this is the version that does get picked up, did you want to take it 
>> directly to close out the compile issues?
>
> Sorry for the delays. Should we not add a !INET static inline wrapper
> for tcp_gro_complete()? Seems a bit backwards to me to make drivers
> suffer and think about such a preposterous config :S
>
> $ git grep tcp_gro_complete -- drivers/
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:        tcp_gro_complete(skb);
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:              tcp_gro_complete(skb);
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:    tcp_gro_complete(skb);
> drivers/net/ethernet/qlogic/qede/qede_fp.c:     tcp_gro_complete(skb);
>
> We have 4 drivers which need ifdefs already and the number will only
> grow with GRO-HW spreading.

That sounds good to me, but it's better if someone that understands
this code patch better than me writes the stub helpers, to ensure
all callers have sensible behavior in that configuration.

I also had a brief look at who might be using kernels without CONFIG_INET.
In the kernel source tree, there are 19 defconfig files that completely
enable CONFIG_NET, which means that both INET and ETHERNET are always
turned off as well.

There are four configs that enable CONFIG_NET but not CONFIG_INET:

arch/arm/configs/spear3xx_defconfig
arch/arm/configs/spear6xx_defconfig
arch/m68k/configs/virt_defconfig
arch/s390/configs/zfcpdump_defconfig

I'm confident that the two arm configs are a mistake, as these are
regular embedded SoCs with on-chip ethernet that is enabled in
the config but almost certainly has no other use. The virt defconfig
lost CONFIG_INET after commit d7385ba13771 ("9p: Remove INET
dependency") added an 'imply INET'. This sounds like a bad idea,
since it messes up the 'defconfig' logic when a leaf driver enables
an entire subsystem.

The s390 zfcpdump defconfig looks like a legitimate case for
disabling INET, but it's not that size constrained and it might
not actually need CONFIG_NET either.

So overall, it seems there is no real need to support CONFIG_NET=y
with CONFIG_INET=n and we could just make them be the same and
avoid bugs like this. In theory we could also go the opposite way
and try to make INET a tristate symbol that can live in a loadable
module like all other network protocols. This would be nice
conceptually and for smaller vmlinux files (some systems are
much more limited in the size of their boot partition than their
RAM and rootfs), but would clearly cause way more build failures.

      Arnd

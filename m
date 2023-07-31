Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FF769BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjGaQBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGaQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:01:43 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E7B1726;
        Mon, 31 Jul 2023 09:01:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C96BC5C006E;
        Mon, 31 Jul 2023 12:01:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 12:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690819297; x=1690905697; bh=d5
        dF3/UEnHkJTXw+9iMGuzyye12DF3XcugC4tBkJDDU=; b=m0kNMmJmwpdMk9chUj
        Nv47pJkPnChzBqAd6DmYtxnmKj8N2cnzD9rAbIC5oOiCG1970Tj0H0JG2F3ma+X8
        fLlXR+Brrw6bOfWXs1VdFOopemuq088FhpAxOjx00xcGSOP6AMMF7uzowenBruCZ
        g5GXrFh+meQ1HKFYRJEDNgFVxKl2qEMaCqq75kqhcNT9+j1mgtE3zoYdHYomaMvk
        4/1CciGNH/94Rk6GRiO4yQywuGljf4ZzdNLySgf1v83xB49hA+TtYzjWoXZcPPnZ
        QSATIzdpRxYso0zZq0+oph+qDifZPdPPT3DMrzg2QeCvP6US1+IWhx5rHpiX/W2p
        yQrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690819297; x=1690905697; bh=d5dF3/UEnHkJT
        Xw+9iMGuzyye12DF3XcugC4tBkJDDU=; b=Tb1mOB+s43WvrIiDpGmlcvMLu8434
        YfNGjrSQDwygtj1XXkRvC7p+1WqeWmsf4jDCzEhikiUT2H7rAtvsyv8jv6uspwdN
        yjyIFcGD0hwrz7Fl2eCcnPR8U7/SX9ZVUlna1ZmUdkJYcpE/HuUG+M5aVy0YbGUB
        X5Ld2xYbruwfkPmsME8BbQPcgFVqcXYYs4ON7wS0NZiSX8YUX/aZ5OtAcvWVljzi
        Ldf8BEozpDUgwU2I6oFUFELIM4r31t56cMUrsOFih2kd5RGijziCJjU757EMHV+o
        KVVBjOsCWvx9I77SuL9LjUVqgPNwcKv7YbglWGIGUvJNiBR9BFqRHX1cg==
X-ME-Sender: <xms:3trHZC9LlanB8jArCNsV04YyeOgDFeZImBJ7BDxQ_B02VJ-mD7kooA>
    <xme:3trHZCtZZ6_9ydxxnjzOhH6m8WHjAkKxXgnubZupSfM18frTAhcN4aGV9VZXydC93
    2a8gBPBHhn6kEIAclc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3trHZIDxIf6E1MzJcCXi5ok_er88S2F7m5gAUUJPplTWNHHhQmgfug>
    <xmx:3trHZKc_UJqqB8QjXrRfzY-MVn3MYDCmX6YVvCsKhsgLkP2ZGusS_A>
    <xmx:3trHZHPokom41T-Zan2EXJx0fTw530OGM5mFfq0KmluUF-XslDUvvw>
    <xmx:4drHZCE-DX7boRJ-NF9q3Jnqy41iEV_O1xdMal0pELSjSAopxs8iAw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 597ABB6008F; Mon, 31 Jul 2023 12:01:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <dd614e72-dc04-4dd1-b2c8-b16166c3c21b@app.fastmail.com>
In-Reply-To: <ZMfWuHPdcHuIeUHQ@xhacker>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZMZ6XB6gX2kFd/Nt@xhacker>
 <CAJM55Z8vF8_xq0QyByLUGM2W-8m6R-_6SdOFdLETV7J-yo5DMQ@mail.gmail.com>
 <92c00ddb-e956-4861-af80-5f5558c9a8f5@app.fastmail.com>
 <CAJF2gTTRHzT+CEtb1LVYdfCorVUdLvCh_eMxrmC=xjdQ_JS6Sg@mail.gmail.com>
 <8b3466e4-a295-4249-bd05-2edbf7b3f6e3@app.fastmail.com>
 <ZMfWuHPdcHuIeUHQ@xhacker>
Date:   Mon, 31 Jul 2023 18:01:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jisheng Zhang" <jszhang@kernel.org>
Cc:     guoren <guoren@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Samuel Holland" <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        "Christoph Hellwig" <hch@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache operations
 support
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

On Mon, Jul 31, 2023, at 17:43, Jisheng Zhang wrote:
> On Mon, Jul 31, 2023 at 07:39:30AM +0200, Arnd Bergmann wrote:

>> >> Not just the flushing, but also loading back the invalidated
>> >> cache lines afterwards is just very expensive. I don't think
>> >> you would be able to measure a difference between the static
>
> I read this as: the cache clean/inv is so expensive that the static
> key saving percentage is trivial, is this understanding right?
>
> this could be measured by writing a small benchmark kernel module
> which just calls cache clean/inv a buf(for example 1500Bytes)in a loop. 

While you can trivially measure the cost of the clean/inv operation,
I think the higher cost is the fact that the cache lines are
invalidated and have to be reloaded when accessing the data the next
time. So if the loop test shows that the static key is not worth
it, that is a clear answer, but if it shows that the cache operation
itself is cheap, that does not automatically mean that the
static key makes a difference compared to a cache miss.

     Arnd

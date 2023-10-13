Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18BD7C8348
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJMKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJMKis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:38:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22AC0;
        Fri, 13 Oct 2023 03:38:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 50A7E3200A86;
        Fri, 13 Oct 2023 06:38:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 13 Oct 2023 06:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697193518; x=1697279918; bh=uQ
        ONiwQaIF/sUvhTpH5QtV/9W9EUUvHLTz8ZcxZqN78=; b=PzdqkqKheJs2lGFvXF
        92FwJxgJcR25WRALDHRIqO2qOIcndbt9h94qL92ewEeTVvx97qcCbXouIaO2BIvl
        bCKvlk9G0QbzCdMM+QFbTMrZojNd5+w244We7mYkSlGb1CEmarRRuGUoFQJzoz+A
        ue+Mj6YK3fLgbYdbmg6j/MyIneWYG+YVd6z/nHe6T441KKDd4TEBws6804sr9ueD
        p5P3PjIik4EYhzSdcLVNgAnWenXDMjjaqvRPV4zTh7BhcpqJrHUIWF3wjkt8Oo9U
        4GYTVD7DbA84raZB6C2jPWJPDoWzxW90/ZPL7on7VXP/Ld8nFDQdNaphgS/oVUO8
        FPHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697193518; x=1697279918; bh=uQONiwQaIF/sU
        vhTpH5QtV/9W9EUUvHLTz8ZcxZqN78=; b=FMXHgJoyJ2eE3dgfDYk4A0cdOf640
        HhqDawZtyhTe8sjz3+TYj1vZOpjMCRWqERcixTXIPTVLpDgS/hnPepA6hoegSu2s
        UZabIbKe6SAIpR33StB1F/zMK8rCE6qlG3I8j0p2g3DO9mtJJu6UapGR5Uv4WeZI
        0770ipQDCfFkyhnqRHIN1pkIdFM/p1GbHmx67iYFwft2gpcAoRIZtqGPi++soWD/
        6q2YntB+8gSDXkMNQ6aWX6TQl4pP92Nm+KPndKKdaZGYyYRvnMl27JoinpF3h+2+
        D7K7TreWvJTFbGDQRDDQxoAltoLzm+fqXf5n6497fzXTRppysOoQyiY/w==
X-ME-Sender: <xms:LR4pZV4gzFlRYc-UReteXwH6GoAOIMy6_Bu3f91zd93vDh9Q69A9AA>
    <xme:LR4pZS5YnEPdIJ3f2eksMXTvsy86uIxZ5PWjA-Wz7L1L8XGO_O4VrYy4M6_YjAm8t
    G1EQnB2ZQpBpCaHuDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:LR4pZcc3k2a_658Fu8YHSK1-ME80R1YPj5DZt7U78-yoMDhAeK7bRA>
    <xmx:LR4pZeL1IjNL_1tGFYTjQTKmJCwmx61Ty2-IrkoGfdyA-JQIsS93cg>
    <xmx:LR4pZZKBZxNU8s2zjzbLq5MJaUSH2bzH-msJdV2KC_UtSiZH_WWHTg>
    <xmx:Lh4pZTCeI4p6X3G4EUfdPUDe3_PiS1S3EAwO_A78vbrjLsk9qufC4g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B992EB6008D; Fri, 13 Oct 2023 06:38:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <4a53722d-e31d-4598-a4a9-cf374c84bc44@app.fastmail.com>
In-Reply-To: <20231013100549.3198564-1-danishanwar@ti.com>
References: <20231013100549.3198564-1-danishanwar@ti.com>
Date:   Fri, 13 Oct 2023 12:38:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "MD Danish Anwar" <danishanwar@ti.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        "Simon Horman" <horms@kernel.org>, "Roger Quadros" <rogerq@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        srk@ti.com, r-gunasekaran@ti.com,
        "Roger Quadros" <rogerq@kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: Fix mixed module-builtin object
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023, at 12:05, MD Danish Anwar wrote:
> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
> the expected CFLAGS are different between builtins and modules.
>
> The build system is complaining about the following:
>
> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
> ti-am65-cpsw-nuss
>
> Introduce the new module, k3-cppi-desc-pool, to provide the common
> functions to ti-am65-cpsw-nuss and icssg-prueth.
>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

I submitted a different patch for this a while ago:
https://lore.kernel.org/lkml/20230612124024.520720-3-arnd@kernel.org/

I think I never sent a v2 of that, but I still have a
working version in my local tree. I've replaced my version
with yours for testing now, to see if you still need something
beyond that.

    Arnd

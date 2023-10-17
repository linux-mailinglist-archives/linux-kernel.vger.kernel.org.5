Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD57CC1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbjJQLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQLil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:38:41 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89D9F;
        Tue, 17 Oct 2023 04:38:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6C74F3200AC8;
        Tue, 17 Oct 2023 07:38:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697542707; x=1697629107; bh=57
        /G7WSXTmaZb6K7f8o8ahaOG8BjQ2KoRfaSP0thpXY=; b=K9nslS4Wb6lGu8N4ir
        GgUlDFBSLEzP7MWQOzXPOfaIdkXh7u0SCVt+zQ61Z6ApZamjy47GabwWhrldGo3X
        XTuGO1lu8qyTrM8sgctNqVGkXGvbdOVfgDK1aBCYqXibr45X3/EWadxCRApCmXe5
        m2iECv+u9eR1nNMX0zEAIfqg0rYo1eNo1nFjYTNZG7B3Kq70e7ZGvxkkbW8Sk1n4
        xCQvLX+tdgWf6OIUbdVREdI2pmS7oormVxyXJk6CAQ9ZnlGvU0M5GQeSa0aqa3Gb
        o5HMWAIJLHM8D25xOS2m0XPCkZocqcB0XL1g4/OVSPouW9ulv4Z4fm70mW1Ab9Yc
        5PCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697542707; x=1697629107; bh=57/G7WSXTmaZb
        6K7f8o8ahaOG8BjQ2KoRfaSP0thpXY=; b=Y8vRS8JS17Tp4VM+0TT/mZFFVMTQV
        Kkw4+i18iU0Tubska0NIPWDzN1nArITjmS1vQFL+BISe9vrIzD/rmDBj1hOUYSnS
        lrr5CNO7yAr13XxUU0+HimhAqpaldgcvlSAV3CWoAzmEOCokHcclSNIVKmhwtNLb
        p+eBiVi0vGsLbi3v+i3QDSZT6AZ+gGoG5WQz4B7y44RbaTUMHlrgY3cthtjBQGYy
        HBIOh2kRsdSIdPzYNagKv0MsYuXSYsbJwpjZwRiLpT/2a3NVJKgQBExMV9+ohuBs
        CHH6eEKXRLGm2wiNyCNL7J6g6gbCh1rekyelMqw5sd2hdEbaStLjw9dDg==
X-ME-Sender: <xms:M3IuZQ-U-fP_sHNdneS4Q8-WR67xZldCVaETTsSbGoPOmT8sex0uvQ>
    <xme:M3IuZYugE-R1JCnJ_ilUk-d6oCzFWUmBfMi6hUNj0ZEf0-P_9wM3o-yr70X_ALndM
    ERh0CfyeXfYTINg9RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:M3IuZWCVHECofKc0WrmGIVw9Stn4c2kOu5oPEq9N2NxbVTawTMeikg>
    <xmx:M3IuZQdGwzP23_8hUa43P1mJFmfoR3UW3Y-Zk9oDvJMSDryOc6Cadg>
    <xmx:M3IuZVPfxlfNU6CPgjqRzKpjEdIw2_LaZvi1P2sSIFu6_fl-ONcbww>
    <xmx:M3IuZZl4mk0PG3myo7b_tDWzEIcSwyCVmwyL53kp5lDjZfVd9V8CwQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 69A7DB60089; Tue, 17 Oct 2023 07:38:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <ff6c4489-7816-4fe2-b6da-53c5d3a24331@app.fastmail.com>
In-Reply-To: <7b0a02ad-d23c-2c04-6672-58f16f2cca5a@ti.com>
References: <20231013100549.3198564-1-danishanwar@ti.com>
 <4a53722d-e31d-4598-a4a9-cf374c84bc44@app.fastmail.com>
 <7b0a02ad-d23c-2c04-6672-58f16f2cca5a@ti.com>
Date:   Tue, 17 Oct 2023 13:38:07 +0200
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023, at 13:10, MD Danish Anwar wrote:
> On 13/10/23 16:08, Arnd Bergmann wrote:
>> On Fri, Oct 13, 2023, at 12:05, MD Danish Anwar wrote:
>>> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
>>> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
>>> the expected CFLAGS are different between builtins and modules.
>>>
>>> The build system is complaining about the following:
>>>
>>> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
>>> ti-am65-cpsw-nuss
>>>
>>> Introduce the new module, k3-cppi-desc-pool, to provide the common
>>> functions to ti-am65-cpsw-nuss and icssg-prueth.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> 
>> I submitted a different patch for this a while ago:
>> https://lore.kernel.org/lkml/20230612124024.520720-3-arnd@kernel.org/
>> 
>> I think I never sent a v2 of that, but I still have a
>> working version in my local tree. I've replaced my version
>> with yours for testing now, to see if you still need something
>> beyond that.
>> 
>
> I see your patch addresses different modules. My patch introduces a new
> module for k3-cppi-desc-pool which is used by both am65-cpsw-nuss and
> icssg-prueth driver. Where as your patch addresses modules common across
> different cpsw drivers (davinci-emac, cpsw, cpsw-switchdev, netcp,
> netcp_ethss and am65-cpsw-nuss). So I think that both these patches are
> addressing differet warnings.

Right, I can resend my patch (or Alexander Lobakin can rebase his version)
after yours makes it in. Note that your patch introduces a warning about
a missing license and description for the new module, so you should
probably include this hunk:

--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -131,3 +131,6 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
        return gen_pool_avail(pool->gen_pool) / pool->desc_size;
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");

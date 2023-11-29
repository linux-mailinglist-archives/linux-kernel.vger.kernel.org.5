Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC657FD276
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjK2J0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjK2J0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:26:37 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77194B9;
        Wed, 29 Nov 2023 01:26:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 199485C0193;
        Wed, 29 Nov 2023 04:26:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Nov 2023 04:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1701250001; x=1701336401; bh=UZVLXVj/9RM66jjJ3eRMLi+UGrfZP/eo/Zt
        B3Eh+csY=; b=ahXwRa31VVIzIv7TGZMjoPdq9ofW5j0qtOT/iNwP5gKPGwIVNzK
        FAd8mZnDZE08x6HPEiDM/qxb3bQFAjipxxk+Qr1GJ0oHYfO/LUOBLHuzYJL/DfzM
        JmJEX82jkbs6ZkX3IaZv1fqxrRMmlKrS7FzNkV0cC5aTTO8QW5IdNDP+oB4IcITd
        JftSk5dzc9twc+p+1vdOWivFJ2iiXZ+RbiWfATMVhqvGjM0Wx7godtRMypz84XV8
        KSARqd8iMfL5UYRgaEpycyqAtieR6q7cfVMriIbMGAP2p26AYgu+iKcTIKEZN+6S
        qK1s9cNkTqw81TY+DQhUa4xEL1RBjaGoKug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701250001; x=1701336401; bh=UZVLXVj/9RM66jjJ3eRMLi+UGrfZP/eo/Zt
        B3Eh+csY=; b=FLv6B1yC56io4Ntf3Oo67RjJuFe1aoL7Ihw1ItOs2iLUhb+Q5gI
        LxCwICkGVxVdfXwI9Dide0LNzxY/pTxmxesC6t72fQCzn6Kqr+l3B1S+4WK3Ah+M
        cWs0qYRH/KlXH5kIHfaNhvCdYaJklCz0FA0AMMoJb344yLHIbr/46+LkwX2BJlrJ
        Dmb7cgy0iMMfUwLvvhu+iFF5cLZcWiGCjO8l0n1Ywm2cXeeSUNv23/X60mUFpYoY
        PfPVj3bkvPArhtagqn0kmrnxl1tbS/DFZXZkTJCxXRQKTURnLGPuN4EPyPzlek0u
        4EbsxH/dfu1pQmbaNkfGgX/0GnVmkkXOuIg==
X-ME-Sender: <xms:0ANnZXIqJ9HG_BNpMBXVYgnKb6KRkNLTv2dkYfj0e5HBYEtZeTvVfA>
    <xme:0ANnZbKa3YLYuFAeOcE6QUDiNTALfeBj2_3pbUi8kLg-MmJzeohenvsfY-khGnRkY
    lZm06v-MU1fqA>
X-ME-Received: <xmr:0ANnZfshz8BxS9kKJ2xn4G5BOD6py01w4EzJfRBs-tR5IocCSggUBc7wKD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:0ANnZQZmAHOzMV6hVU7pL5s_ujbL_l-kOniHq8UE7KyiG416iN42Mg>
    <xmx:0ANnZeaYoND-MfOeMXlCTF5VocpDj3TWuS2qb8cSqUC64_BnxTba_Q>
    <xmx:0ANnZUBargby5kHdPPA0zi8k8XGxypFoBeyp7kNOeTaBEbcuZ-muXg>
    <xmx:0QNnZbQwl1I7tvvUjvpbJdA9qg37rVyxeHjvLthxQYNUBCIDYlxWsg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 04:26:39 -0500 (EST)
Date:   Wed, 29 Nov 2023 09:26:37 +0000
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the char-misc tree
Message-ID: <2023112919-multiple-trickily-9bd2@gregkh>
References: <20231129122405.27a5e54a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129122405.27a5e54a@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:24:05PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the powerpc tree as different commits
> (but the same patches):
> 
>   bc1183a63057 ("misc: ocxl: main: Remove unnecessary ‘0’ values from rc")
>   29eb0dc7bd1e ("misc: ocxl: link: Remove unnecessary (void*) conversions")
>   0e425d703c30 ("misc: ocxl: afu_irq: Remove unnecessary (void*) conversions")
>   62df29a542f9 ("misc: ocxl: context: Remove unnecessary (void*) conversions")
> 
> These are commits
> 
>   29685ea5754f ("misc: ocxl: main: Remove unnecessary ‘0’ values from rc")
>   220f3ced8e42 ("misc: ocxl: link: Remove unnecessary (void*) conversions")
>   84ba5d3675e2 ("misc: ocxl: afu_irq: Remove unnecessary (void*) conversions")
>   82d30723d58f ("misc: ocxl: context: Remove unnecessary (void*) conversions")
> 
> in the powerpc tree.

Thanks, that should be fine, I didn't realize these ended up in the
powerpc tree already.

greg k-h

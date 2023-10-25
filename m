Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ACE7D6191
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjJYGWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYGWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:22:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC18BD;
        Tue, 24 Oct 2023 23:22:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 969745C0270;
        Wed, 25 Oct 2023 02:22:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 02:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1698214952; x=1698301352; bh=bn
        tHUPZSCmddA74HTy38wmPbWm7fGNmAPdQ0hqdS/Wg=; b=PHrfOXfUP/zErTeW/W
        t6lHKZavkLAkti+jo2lAfSioeodSKN1cZ0T2BxzGO4vd52t2LLc3Z4GEzPEYk6Qa
        iCrHHSB+reRLYWb7v5E0ieqbuZX+GSF5WACVaI5o8DMXelDWKfahKFZOpWQdDkCa
        1s0r9GlwWL8pk7xQQzsR1qmIAhyszXqYTu8HFOTUPIwhlColaa+ef0uyf4NJIlfO
        A8JHAs1lGH7SYe8jgz/ENO6BaQsF7jYGwNw1Ly5ncUZ4kjVjFPCbPeDCMZgpwbet
        VLYY1oKbTC0+mvNALluVt+QdaIkBKRbXRbNhDncZeutUoIMsXgJmV2m6EZByJlBB
        YYwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698214952; x=1698301352; bh=bntHUPZSCmddA
        74HTy38wmPbWm7fGNmAPdQ0hqdS/Wg=; b=F27Qng0/p4f+sqt4mPdR+BXmzOe7w
        aphCK7ER4ACW7Ewi9prvrYvuzmPKmmzwhX9yLJn2Emkpo7QsmmrmbPueihPGg/Gp
        KPVGm08ocuTZNjjheoUS0qDlz0BbySVlyxde/raPCDDKHeJSK17OIjIrpPlBhbSr
        uDFqDyam3kywmbvIIImTogGyRu/Go8WNaNu+cNttqOJY9b0r38D0jKv8UL1QZk4E
        iMqxvby6shXMoHYQPvSu0nL6blxHv+ulPb9gPgndDQ8Z2GUsjL5yoZ/GWdbcQgP4
        QooLTdKAeVOsBMmalKrfCEIP//SLUkk0Uy2+UC1nDd54um7dZczbraWaA==
X-ME-Sender: <xms:KLQ4Ze6-WN3k1ewwNIhL6y7-5u0j3AKHwL_jrjacBISY3TtQHD7LYA>
    <xme:KLQ4ZX47salsk7lJ4-jGP9rzZ93bAcdVhsOJWMp8-dXdawvRSabQQptTRYMmk6Ieu
    8gFkHyfNzHMkw>
X-ME-Received: <xmr:KLQ4ZdfgcY-MGUa-zKkrHqCxxjkwyNyG1Q1HitydVtSxVVf3DAScoZ5PH3hABVjQR8bZ2-hI_tNyjTwx76DQxuvdp0H98xXgrah7SMZjiNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:KLQ4ZbJRlWDv9SqFCuoEtpDBayrNJ4NSaCDDodgk4b1H4VJWtBff2w>
    <xmx:KLQ4ZSJ5VS-X53csjeFphwgDVcm9W8hlez1iHUX4EEBJG1fu3zfZbA>
    <xmx:KLQ4Zcy7d5rl5nM5C-ReVsApXson3fQrgwY91AiXLsfKeZbpCaHVEw>
    <xmx:KLQ4ZfCXdOPDtreAKGa0ACkciReyVMxiFaSpE2cZKV3iRCza0SZ1OA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 02:22:31 -0400 (EDT)
Date:   Wed, 25 Oct 2023 08:22:30 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: linux-next: manual merge of the usb tree with the rockchip tree
Message-ID: <2023102520-salvage-fancied-b186@gregkh>
References: <20231025143326.1ae29596@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025143326.1ae29596@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 02:33:26PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> 
> between commit:
> 
>   5a6976b1040a ("arm64: dts: rockchip: Add DFI to rk3588s")
> 
> from the rockchip tree and commit:
> 
>   bbd3778da16b ("arm64: dts: rockchip: rk3588s: Add USB3 host controller")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good to me, thanks

greg k-h

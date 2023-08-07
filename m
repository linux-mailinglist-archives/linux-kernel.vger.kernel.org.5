Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20556771A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjHGGka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHGGk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:40:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA6134;
        Sun,  6 Aug 2023 23:40:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E6FC5C00F0;
        Mon,  7 Aug 2023 02:40:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Aug 2023 02:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691390422; x=1691476822; bh=7w
        sLwwq7EjWKcy2P5DPl/2RDDmu+tk7L8a+2xFPiBJE=; b=JphD8sarulUSb0Nqm7
        wCDstecxWol0fIP1nHbDkU/rETvXL6nj7ano49b491QJWt/IqW1RU1s+rxFVxc0t
        QcZljlRXKdsSMoGGisVtihStb8Y6H1EfRt7Ux8JHZepc9kiUrD/GU7EHxx4oa0CJ
        luJIZi1dy+b6NcW9bWyZRa9tn2xp2biUxZn44QbgTtmNFvqxUYJNv98iv0GaTuyH
        k5et18Vlr+znk++RVXLTZNbH4z8CgEL/5EM+1WYV08mIVHCoPAJTu7VY9jGGxUiI
        pSTpi6nvc+jdf4czMDf5i9teKz1xbIzsrbRRNaLtxa48NOdu/06DVILUi/5lsPrE
        +NXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691390422; x=1691476822; bh=7wsLwwq7EjWKc
        y2P5DPl/2RDDmu+tk7L8a+2xFPiBJE=; b=tDTpNjdZq1WbqMb48Kz+wTFeZQSi4
        n0BL9hqJAzAWHdBz56r6CzitZ2xf0bE5wgXXEfsJYdZZI+RCbj5+DwzGAaSL2yn0
        LBAh23yXxqFsWd8uesD+pvy96vXUqUMxR8o7ObMES3lUej7Qj2FzkjEyvNArMY7n
        xYKruQE9WewJ1H/0nFF7icOqiRi4XomlS2bXsVXGFJlmIrzmpiqBjzpl9KP92y6C
        xaD8LovoNCX+mKOYeCNW7/GZF5Zi9NidajUSiG6EzOXcAeNwJGzEQ644VrB6+emo
        rM/ijA7lUQ3TY7WfZAER0qglziGF4t705EcsSupCroWjs0qXHQqgOImIA==
X-ME-Sender: <xms:1ZHQZInIPC7CKnnaiTQ-SKWEaMAJ3FKpnceqg5sOPOFqDgsY9DQb3Q>
    <xme:1ZHQZH2UTkDdbcRG2sjet-rlELhRXSqoH9ktZIq-RdYtoSkMo3Oq5KG43tU3mDZ-D
    _hdX7xne_1Ifw>
X-ME-Received: <xmr:1ZHQZGrfeTsAswTI9HZaDAFv5qhtFNAPDDPzhwmYsU2NeF1XZUBY7GCAL9icluz2YXQd-_mAmqb_wPQ3LyfYHGGgStZSAaBTY4cjqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeelgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:1pHQZEnIOPiXiabuZ9IAeStFTJbuMSs36EMNTfNWV84VP2JvTRJDBQ>
    <xmx:1pHQZG2hruFVJ6xC5yNIvSJldTSKm5SyBJeL2AFXcx0maoH7_5SGuw>
    <xmx:1pHQZLtFxdPXxrUM7A8G_KK4ZkRmxd80elLbYtHZjZzE_Vyl4yhYHQ>
    <xmx:1pHQZPtoZEBUKJuE6KXcgNw9JY49vrpDvyOx1Jfp9z02ebUFXBmr9g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 02:40:21 -0400 (EDT)
Date:   Mon, 7 Aug 2023 08:40:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the char-misc tree
Message-ID: <2023080703-renewable-rust-233d@gregkh>
References: <20230807154457.062a8a1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807154457.062a8a1a@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 03:44:57PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the mm tree as different commits
> (but the same patches):
> 
>   acdbfa04816a ("pcmcia : make PCMCIA depend on HAS_IOMEM")
>   aefc8b57af77 ("misc: open-dice: make OPEN_DICE depend on HAS_IOMEM")
>   806eb9e4160d ("char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM")
> 
> These are commits
> 
>   2ef95c7f4177 ("pcmcia : make PCMCIA depend on HAS_IOMEM")
>   3650ce6d8409 ("misc: open-dice: make OPEN_DICE depend on HAS_IOMEM")
>   420d959a77fe ("char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM")
> 
> in the mm tree.

Thanks for the notice, should be fine if they end up getting merged both
ways.

greg k-h

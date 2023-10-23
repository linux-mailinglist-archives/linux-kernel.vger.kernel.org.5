Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7336C7D2B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjJWH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjJWH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:28:02 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF010C7;
        Mon, 23 Oct 2023 00:27:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7D4A63200902;
        Mon, 23 Oct 2023 03:27:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 03:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1698046071; x=1698132471; bh=Y+
        wypWLyKPvzQcBs6mJy6il4rEIozWzd7v6BEQHv4G0=; b=Q9Ow7oajQkFUaifCx7
        nHmVYAn73+zB0Dc8m4Ymd+JtwlLEc6JJq/WZJwilonvqxqib94aHKb5zkD+SBIdq
        +n/IJc2dRrTLAMTi6a2l26nOBTUPQb1GA1ApwcI5QC/bESOhQwUw66Qn0/PhIDdm
        sDsXJDWGD6d/XLfVbq7o61wJ/KM4VSnUxWIYPeGWjBR8dXoLIHyPySaN5wRJRTvs
        YvHq7WH52GxoYhVtkqCeiHfGhn44ZXJqvSfiNSYtOOW1tX9I+/Z04gAhJUvJ7e3x
        ku9iUyXP/eEWmHpReREsBclpoj4ccIXtWoHieq7oIzw89SU9EUkiqDPsXKhaDwC5
        EimQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698046071; x=1698132471; bh=Y+wypWLyKPvzQ
        cBs6mJy6il4rEIozWzd7v6BEQHv4G0=; b=DzJUHB8AwagwcDqRIz/2CVASvV3Hg
        94YSgbywpr7TqDnvkbntPThx5Bve85xUuYgMp2dN0QyDwxek9dKax2DVfDhddTQq
        MsPZNBfqYSRLj1XzJpTKua1itanKmMJsRcGbOaEmngtk9SJFPd5ieT+gjH9oOQfg
        wpAyfsZGhaJlkUOD1+e1vaQnBkoCIDpiojtIO4rlAlfjevGxdrouP9kaMWIZtrlx
        vFoybK7hLG1TbY8npAdoHFvfyGpEvzbrDLBGF1ef6QpOf+fJ18UMji/5pMXosJAG
        ggMH0K+nufH1Vno6D2IqrNzjyjhYY6uSsnzX/uuYwSIV5kpSHyVuM1Frw==
X-ME-Sender: <xms:diA2ZSQlyuH80c2Qa2PBlpGJEU1D41hPM5ZAoRWhdQwU631SBd2ZBQ>
    <xme:diA2ZXxEln3kgHV-inXfAAfzPVH6PEVEo9XqSA9VVTdwk1TiQcjrTsvP1X-RyOkfw
    qp2yGpetS7urg>
X-ME-Received: <xmr:diA2Zf3oMhyG09EiJZR7eSoWfwYSdrWYkKzvVeE8FJN9UlWzDfTUMvzdbQB9mImUhAAZxtF4SMY1qSEWvjRzEgtZuS4mZ-TqRwbkDrqPbZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:diA2ZeDtHzPMYz1V6-0U52bobMSAisV_03MOU1n_VGeVt8tR5_pOZg>
    <xmx:diA2ZbhMEztJg-r3Aj-qzGszyztUYjuzVeT7ioOQbZ9ZGpRLcaUehw>
    <xmx:diA2ZaqWq0jt6BKHsQz6SnCmChAq4KTkoEcL8kJtsRmTAi4SLPv2lQ>
    <xmx:dyA2ZaQoI9s7r91G1dZ1Pv6HI3pEaRxgm9dtOutp1WdzPpRPUI7bkw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 03:27:49 -0400 (EDT)
Date:   Mon, 23 Oct 2023 09:27:47 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Benjamin Poirier <benjamin.poirier@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: linux-next: manual merge of the staging tree with the net-next
 tree
Message-ID: <2023102338-repaying-golf-a200@gregkh>
References: <20231023144720.231873f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023144720.231873f1@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:47:20PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/qlge/qlge_devlink.c
> 
> between commit:
> 
>   3465915e9985 ("staging: qlge: devlink health: use retained error fmsg API")
> 
> from the net-next tree and commit:
> 
>   875be090928d ("staging: qlge: Retire the driver")
> 
> from the staging tree.
> 
> I fixed it up (I just deleted the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Wonderful, thanks for deleting the file.

greg k-h

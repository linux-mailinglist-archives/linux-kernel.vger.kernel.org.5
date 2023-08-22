Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A0678401E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjHVLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjHVLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:52:49 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6EE56;
        Tue, 22 Aug 2023 04:52:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9BF963200495;
        Tue, 22 Aug 2023 07:51:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 22 Aug 2023 07:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692705113; x=1692791513; bh=WX
        idqPU1bEX5huuNnsnICqlNlGqjuUA0dGv6wQlW+Nc=; b=jD3zGBoHdWaHl76sqq
        NU/zn/UbZ15Ip8IgsSg3CHpN16uxVxQ3NY+FL2z5fmJBuJiPcJeIzK1ACxkRrqHT
        Y3u8aLyJLpjTglwIi+RXVn/NV/Z62fEhuAXcDiYOQAx5hX75jJBOdLXfCPhYfdBG
        /QuhXLXluSg4DCm1bBQrfdhkWRW7l5FYJRuWM1O2y3HtsakXiGDfF+3Bd1aEPtsK
        b71fCf6pMTqpRWBZMKzGCrxlcSM+Zy/FpzyGU6XBBrwHsJ/A+WGwlYk8dsCIvPUm
        t8m60OprdX6tr3nfa5avChlsE69MQjs006prWqOwq7uxCPy36KGHTIE7Fd1VaUvD
        nWNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692705113; x=1692791513; bh=WXidqPU1bEX5h
        uuNnsnICqlNlGqjuUA0dGv6wQlW+Nc=; b=vZazz0SU7Wqtq+xBaWOn7smcdWfwY
        /d9Ioa2GRv2lv8SYKKTB9/JMBJ6kHOC0NN4eWW7cFIn7obxLyVQG3/2ApYntf9ge
        R7d2iDKnAQPvXRsIUQFThQIGjrf+pRrCIEkbdpyFDMfiBdLV3XzYtzCEbV/MJHSl
        3MNaRsDKYoMjJl2qTQyqxPe5ITc3jeMx9xogfnNqKfq7+7uC7JYsUlDOhXa8GpOY
        Sllr0Ec70pvcmEYxHXB8iQmHy5PKRtS6iVFGs9gw2T2twrgaYxzhbBGAFHfC4ydJ
        q2lfjMqjjepMnrl6vBtbShjir985kpImAry3h4Z67ybjcL9TZsSLWe9kA==
X-ME-Sender: <xms:WKHkZHpXR2DcKNKP_4TTVkHWFKNoVbfT-_R8nIpJ-Dk8xYEFHUESHA>
    <xme:WKHkZBr3Zc-YtDYiblsWPRoqBWifLItk_2jVXrqaG6YcTwA6eOy3GhT8vqZEg6T2Z
    qgK6ZYvr2JRBQ>
X-ME-Received: <xmr:WKHkZEPqwzl2LuPM3uXeRSJf3OpSWRmR6bEBAtYHWJRjqXIoNl9V9cVTG_YmvRRUJkDRL0SLzoBDXwfMv-Z90l58lnEHtBw_XxPrOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:WKHkZK5civFd6y7xxQTKgXbWH__L2ow2h8cSqoRNw-iPhZ_I_zhKkg>
    <xmx:WKHkZG6O2bfIrNBuK7bEgzlsjEr6EahbEyr2vI8c9QeXPjT0-MiXWw>
    <xmx:WKHkZCgV5-_fu-t2DHIabRH7F4lkN-TTGMYecPJos9Db1-N51UhkeQ>
    <xmx:WaHkZDyYmLuXJgccN1SCRXM2urvaDWLcHh1Vq2c_Sds9HCYwDeZ1Vg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 07:51:52 -0400 (EDT)
Date:   Tue, 22 Aug 2023 13:51:50 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the powerpc tree
Message-ID: <2023082218-pecan-chef-e4bc@gregkh>
References: <20230818145826.00c7ead1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818145826.00c7ead1@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:58:26PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   arch/powerpc/include/asm/fs_pd.h
> 
> between commits:
> 
>   e6e077cb2aa4 ("powerpc/include: Declare mpc8xx_immr in 8xx_immap.h")
>   fecc436a97af ("powerpc/include: Remove mpc8260.h and m82xx_pci.h")
>   fbbf4280dae4 ("powerpc/8xx: Remove immr_map() and immr_unmap()")
>   7768716d2f19 ("powerpc/cpm2: Remove cpm2_map() and cpm2_unmap()")
> 
> from the powerpc tree and commit:
> 
>   c2d6c1b4f034 ("serial: cpm_uart: Use get_baudrate() instead of uart_baudrate()")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> Note that after all the above are applied, it looks like this file can
> be removed completely as nothing in the tree includes it any more.

Thanks for the notice, I'll let the ppc developers remove it as it's in
their tree.

thanks,

greg k-h

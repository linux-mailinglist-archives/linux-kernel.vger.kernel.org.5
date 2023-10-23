Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A792E7D2B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjJWH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjJWH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:28:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6644E9B;
        Mon, 23 Oct 2023 00:28:05 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 106CA320097D;
        Mon, 23 Oct 2023 03:28:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 23 Oct 2023 03:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1698046083; x=1698132483; bh=4t
        S7wTIq5gjgJ7VQWrm4xGur6XyZli0T1vZpPDfxzU0=; b=rWf2mi0ctnXq2hl1Bf
        yrWwM635rkhMiAy1dbtIbXoDzINs1NIAa5++dn6RE9ekNd7Rgu5FNIUe+tkwu9Qw
        mfoofsk8hi5yHtfIttT6qmCbUnaOCCm25cwsBGQPRdnYNlx/4mlsT24CNjESrIG+
        +m27oEIvfacIq/ILTw4GHgzcKNgnNY2yTApgxA97Swg9kmWN/mCDUW8ozJOVwtOX
        6ird5Sg13/yaEGIL58xG0242mNDFwnkKXYtSWFuAGYfBFsuCk1vLpghf6iTVNFmU
        kwr8QL4G9YY3dWee98Mw3BzMzGm54+hVAvr8LfRPck9wZ7TxhNOQqmje3EEFLevD
        sAbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698046083; x=1698132483; bh=4tS7wTIq5gjgJ
        7VQWrm4xGur6XyZli0T1vZpPDfxzU0=; b=M3epvxCdg7yjWjnU7hZX7ffMBEl6O
        KWtABwQ1shCOlEFp0I8iXhtyR+4NQl6I1I8yWAbxbAIPCOh/O6H/BHgK+tT5auV6
        CvenYXIHGV1Bpc7rHrN91A0tZYYK5BY5nSI5aLvooq5lP4D0dk1vWKW5kIWBaWKG
        anXBCUDrTFob2WA/KEz2yQxqKAsQBb7HOb4E1YQ1HNp8S9vcCqDcaBc+6hJkY7Hw
        zaXmpnvOYbxR3vCQW68oeHaYAWNWSj/s6a9t0qETeqW3zz+iQ/NXKjtq7QI1tavY
        s5ma56G8KdE9ZNvN1N0zr2SXUwXfe6vXr+ndnvkxZmzqi2SpdSxUzLjTw==
X-ME-Sender: <xms:gyA2ZeNuOSEUJb2CLzdFcy-bMDutIfQXtn42c9wyRzIokZ_2cW6yzQ>
    <xme:gyA2Zc9EThr_kb9fJzidPeBS5yQU03J5r0g9nPsXdJOudiLIgynJg6DQ6o-T-t-kR
    c2eTkbj-9zJ8Q>
X-ME-Received: <xmr:gyA2ZVSeWW0EZIei9M3qyy2Xlv9Xl9H10-hZb4lE44iqiapsvVOgS1Z6eQ9AYSxCdk3n8iUhFnupYRBbSjulHvRrgS0fwId1vKS89QGXvk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:gyA2ZetNuyUOnGb74p5mFKYV8CWfnid8SRBHQxhA5f-6uFkB-f2urw>
    <xmx:gyA2ZWcTqTMJrIu65CjCfzneXppAUl4kKrzcvORH0MTA_HjJ6gJnHA>
    <xmx:gyA2ZS1pRpyL6Cy6A9NFlfuxh0Fhpnv0JqkZT52sS6mQWwg5gnc2eg>
    <xmx:gyA2ZdzDvOwELTWFKEy7GmlwYbby95JRZDJTbMGSLnr7gmmxoJibkw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 03:28:02 -0400 (EDT)
Date:   Mon, 23 Oct 2023 09:28:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the asm-generic
 tree
Message-ID: <2023102350-gumminess-crease-db03@gregkh>
References: <20231023144327.7d18a847@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023144327.7d18a847@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:43:27PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got conflicts in:
> 
>   arch/ia64/kernel/setup.c
>   drivers/firmware/pcdp.c
> 
> between commit:
> 
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> 
> from the asm-generic tree and commits:
> 
>   8a736ddfc861 ("vgacon: rework screen_info #ifdef checks")
>   acfc78823326 ("vgacon: remove screen_info dependency")
>   555624c0d10b ("vgacon: clean up global screen_info instances")
> 
> from the tty tree.
> 
> I fixed it up (I deleted the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Deleting the files are fine, thanks!

greg k-h

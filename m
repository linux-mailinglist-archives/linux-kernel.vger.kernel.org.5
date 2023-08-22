Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B805F78401B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjHVLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjHVLwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:52:10 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE910C1;
        Tue, 22 Aug 2023 04:51:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1C32B32003AC;
        Tue, 22 Aug 2023 07:51:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Aug 2023 07:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692705072; x=1692791472; bh=K0
        OMi/eIXCAexvqslzj5XCVnjnfiAH3S5U59gZVUDhY=; b=B7nJ/X0TaARMrK4K1n
        LheuRUj37rlEI6wmrlygrAQl8kHM89w7zWEwpmPDiG4m4kAZAGyCqN29iR9VhCOZ
        2h/3OgeJkg+Mdy+RP1SrloZbb0GPQ+2lF7+Vw+RnYFRgqcUBewZn7M+VEa+uhY1u
        fgdtVtoYvyDLpbHEg6e9s0Kp9JKXjHyGoQfkFyUNoZ8bXJt94CHgkl7u1SHMUzw2
        LyI/ybZ+FD12eGUQwbTTLn8aapEI/p16NUEazJMOIvM/YE/tXaomahTStkh+rXeX
        9izUwB9JIstJW2LD71JgQBNzmYzbVvJACWqst5yWVrUn9UHzV/GsWgo98AQNN4jj
        8++w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692705072; x=1692791472; bh=K0OMi/eIXCAex
        vqslzj5XCVnjnfiAH3S5U59gZVUDhY=; b=hz+Mpb4nldBFhDOEjhlsK5rMh7daR
        6iVIfq51RJTi9GNbeorrrTZWD7Y7gxz3gJapkgyqx8oCX9p4Gkl1ixB1+S2m6iLa
        3r9KMwA35rDzWfaGHC/wpDZr9hdA8GXKlh80ak1VeJ/utLwGdipq5CJ0JHzKi7no
        YX1tGUnJwaFve/naGKQWYc2EAoFi8e791HrMy/IVsNgA/aqCnIBfKdA++ZWWtCgS
        iSvwa9VIjhaV0NJtfTndMOhHc2NBf6pvqw5Mr3qS31xqoSc/Xar2kQTmLRX65oN3
        vxpbFScmmO4ohhwY98mHYRhtS+ycLO+lw4lMzG8etf8QBw1mJauozfoyg==
X-ME-Sender: <xms:L6HkZCBMhBgqeuN_WmFq5vcl5GyJkMxznyXGghASjtj00FBUH1nVmA>
    <xme:L6HkZMhFL4JRQLBAoABMXWtRQ7D-3i7VQoy0w2_tbKu6ycjlykWJTbFk2xDyFsNZv
    CypB-wVXxt8kQ>
X-ME-Received: <xmr:L6HkZFm-kqIJeo-LAbFiRgN9SSiCkqYBJqEhhStA8WVyfmYU18r7xSWTLb8qa-CtubEgFUQ9zWvhCNmokny28PH5gTLQV-XWcIcGeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:MKHkZAxubvyO-Upn4k77NIfolC4g_o_ZlLJz_sr5voCR5TdJIxne0Q>
    <xmx:MKHkZHRnN8lq9o3cTfT6GS0-L0yJAGIzDb3laSq4pKctFHz60_GgrQ>
    <xmx:MKHkZLbgX-uiN8iXIQjasU68m4SUuRaSTkLqWow94BkzUcT5-GXKxQ>
    <xmx:MKHkZGKMDg3svwML1-kXAyTiyfykY02dKsN4FMqU3wTT1pn2YwyxbQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 07:51:11 -0400 (EDT)
Date:   Tue, 22 Aug 2023 13:51:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the driver-core tree
Message-ID: <2023082202-playgroup-yogurt-3b91@gregkh>
References: <20230815213400.49afbd8f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815213400.49afbd8f@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:34:00PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the hid tree as different commits
> (but the same patches):
> 
>   32944855bac7 ("HID: hidraw: make hidraw_class structure const")
>   afdf5dd33a91 ("HID: roccat: make all 'class' structures const")
> 
> These are commits
> 
>   21168bdba6ea ("HID: hidraw: make hidraw_class structure const")
>   fadfcf360161 ("HID: roccat: make all 'class' structures const")
> 
> in the hid tree.

Should be fine, thanks for the report.

greg k-h

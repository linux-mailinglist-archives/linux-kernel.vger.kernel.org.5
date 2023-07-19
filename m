Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142AD75A2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGSX2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:28:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB61E68;
        Wed, 19 Jul 2023 16:28:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 533D95C00FE;
        Wed, 19 Jul 2023 19:28:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 Jul 2023 19:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689809314; x=1689895714; bh=wY
        8PfMfkVL6NTJtz/GzYW6jmjrEhPsMhcGGQ+OuvYsk=; b=OUhjFhr0Bbbv/HiOi/
        8XnCQBmYn7EJ3K7aDNQ6bYWlBrlERMrD6OeCcAt2oRWEaaFWl1L44OGXmKLKSOdo
        Vnhy+Vb/X7sJtIcZHXEcyJK18VvT/L62+UXoR5MwBsNWxSOpInCKLGrgsZbWkKeK
        uENkRv3vpfFoWoEmQOZMspKkajjOMKeV/VTGATnjIRYN2vzu/T4IfILtnzAW6Ljl
        UzEwIxvYTcMXCIhd+hbrOW1L8QIclUVtSG2xJq7juAyKhLBnckZ3Pj59ctmIKrir
        Y6TeIV+mMnI4w/KUFBkSGMAkBrAG3PtDokCGKXhrDzGrqIT4xmFIoDEI1N+lr9LG
        6CJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689809314; x=1689895714; bh=wY8PfMfkVL6NT
        Jtz/GzYW6jmjrEhPsMhcGGQ+OuvYsk=; b=w+HZOJPU/XBC+igZ8efxOMZ2HDdnv
        zLwem9lUZiMbSbx21vuQj3Mt8PAO8g1X6yJp0RraTNInUHTwbY7b1Mum5GT/8RNQ
        mGKhFWoVlQVI37EOyKoaDFr103NaQIHhjaKcl+VCfLDN7XpCZjKgYUFO2A24niUJ
        QJhMZlNiuvNaxBOVu3i84gsOa3ltDx4F4vMiq38xYXixF6Qoq/xT/bTBLFFROZ6N
        YL7UJTh67KP8cXG6UTXcm0kErD4U3qbyDNEwwzSRWBzwkX4Er+bvYJZPODq8MMGO
        Ze0SV51InXQa4av8odKTV8BFoyZYf56O2a4COv+3HVWa01N5G8wZrtApA==
X-ME-Sender: <xms:oXG4ZLUWqpJ3C77gPQ4fVooknyxJQIky4RIP22sPj5C_hVYfkDRzHg>
    <xme:oXG4ZDllpG-pqN6AHGPGmD_yOlpemgq3uv6HmvE2MVyqTNOcwb8ZyrpS3qJvbpnjT
    mZTzZxQ8MUcFgegAxY>
X-ME-Received: <xmr:oXG4ZHan3PEqTtw_gUTwlpaAgapWZt6MJbfDjpxTJdsOG9umLPWFHAvL1rPNibXJsdZgxlHxMgE6Y7ss0WHJZH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihlvghr
    ucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpedvhedvtddthfefhfdtgfelheefgefgudejueevkeduveekvdegjedttdefgfelieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    esthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:oXG4ZGW9EjOglrTepMFAYNpVZI2iQbm4BPPc7UCSr37xcRAqYd7mKw>
    <xmx:oXG4ZFkmgwAnVdPuURkGpmyDPneYxeEJ0RnNq3X8b3fZRC0ppJfFAg>
    <xmx:oXG4ZDfmPRWlQxo2M6MdHFcGPQlW56KRmJ71820MCrmQwYaGNqzzsg>
    <xmx:onG4ZLg7koMswvAgjnIcM5WPjK6VzKgYRMlMoW9cXbN2Y9iDSmEpcg>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 19:28:33 -0400 (EDT)
Date:   Wed, 19 Jul 2023 18:28:29 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <ZLhxg0uPpV8bLGKc@sequoia>
References: <20230717101114.5add1194@canb.auug.org.au>
 <20230719-dramen-komisch-9c43665a0a5a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-dramen-komisch-9c43665a0a5a@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-19 08:16:03, Christian Brauner wrote:
> On Mon, Jul 17, 2023 at 10:11:14AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commit is also in the ecryptfs tree as a different commit
> > (but the same patch):
> > 
> >   8b70deb8ca90 ("fs/ecryptfs: Replace kmap() with kmap_local_page()")
> > 
> > This is commit
> > 
> >   031a0300f2c9 ("ecryptfs: Replace kmap() with kmap_local_page()")
> > 
> > in the ecryptfs tree (where it has been since Sept, 2022).
> 
> @Tyler, mind dropping it? I'll send it all in one go for v6.6.

Done. Thank you!

Tyler

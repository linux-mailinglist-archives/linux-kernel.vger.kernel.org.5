Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D54784018
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjHVLwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjHVLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:52:00 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA522E65;
        Tue, 22 Aug 2023 04:51:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 79038320046E;
        Tue, 22 Aug 2023 07:51:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 22 Aug 2023 07:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692705063; x=1692791463; bh=mw
        hEjKPbDW55XLCvNV/I1AYDhsUf2O9oDef/8G905ag=; b=rA5ImhckT4gVwAoFcQ
        scAIzmSVOezBBwSzLD9IAQM236SX2UAcTkKbI71YsfxO5LgWs+hhtXI3xBvfREI0
        X38yFwJP61Fk6WrRWT8cg0dsfrnl+H5Gk98WX52ePwA1ho/2mKYmlRtWP43oyX3n
        gFn67l2XztICIAsrR27jQ8daaYLJUN+K7isCMWAagKL384nBBCNhb6ChuO4Jpj87
        BWPNIUd67TRBs1ixegCWU9OXhfouvjx9idHjd6Qz3JkaiMRyHI7B2Kg7RfZzrlAK
        BnfM6CtO6K0ujprjMs74m99clMH59r5PxadXYcgM3SNdZvYnkgcat+yKbceKYbnv
        9UFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692705063; x=1692791463; bh=mwhEjKPbDW55X
        LCvNV/I1AYDhsUf2O9oDef/8G905ag=; b=HqqGTAarrBKiXwgKsADUhVP2jYzLm
        xRnfYnQo8HgxqJ8bQxqdl7965IxVNQ1mQGKvKzqprPerCdIwP7dfFfeKREFTVFHW
        Z338wBzkuqIGTPy4WD6Ld/0Wqog4KE6xHiAMJ3ghGefATznOObacd5NdI0Ok/+WH
        EOHY60pAtHtDfhRM2330L7/WF3BEZctXqd8mVd4z3LT98oXhpMaOnxlNC1byzGFY
        GOmCDD2q2wdDImezu+bXaobSX/4sWSseorb20yvH0Mre8IgXPlKLn5A/iAk1FB2e
        E0V00OCwxrMSLPtWNZLF+AxDm57fSOsxOYqpT6DUixqN/kPjKnu/VmRSg==
X-ME-Sender: <xms:JaHkZISIaaBaoB446DItYODMcxPHo3953DrJHmmM77Da58zP47QVWg>
    <xme:JaHkZFzUO7f3ficcR1T0sMYmx4s5GC069X1B6MBiRcuCWAGO6ymwYD_8ID1iOyqNU
    EVqTid9mstt_g>
X-ME-Received: <xmr:JaHkZF1rdEk2QiNq-b2Coz-mA2Zr3av6ESVUf4BwXSDCdePTJ-lU66P1lM-KfnkWEPJT-67tWdaa-e0MIY5laFNg2JEvIuE_MBw0uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:JaHkZMCwpsN4vo2UzXqN6q1aeZs8YFBQjw4DL-5gajLp-v69WFA4Iw>
    <xmx:JaHkZBiGCb5S_W9Uc411jzFGIsS7ZnqcPOLIWpY8FevMZ3M0IXRrXw>
    <xmx:JaHkZIpEjmcwSlqmsfY0OwFATBVQrurcHs9wIpz1Iqas6ZM__ZB7RA>
    <xmx:J6HkZKZe8OY7waY5qiCiNasiWGN2yMfypzd8MVVdVPBkQJpZVasdfQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 07:51:01 -0400 (EDT)
Date:   Tue, 22 Aug 2023 13:50:58 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the fsi tree with the char-misc tree
Message-ID: <2023082241-uncloak-mammary-92fb@gregkh>
References: <20230815182737.534f4ec2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815182737.534f4ec2@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:27:37PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the fsi tree got a conflict in:
> 
>   drivers/fsi/fsi-core.c
> 
> between commits:
> 
>   adde0e112c63 ("fsi: Improve master indexing")
>   b1d3a803acfa ("fsi: Lock mutex for master device registration")
> 
> from the char-misc tree and commit:
> 
>   4ecd69609bc0 ("fsi: Improve master indexing")
> 
> from the fsi tree.
> 
> I fixed it up (I used the char-misc tree version as it seems to be newer)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

This should hopefully be fixed now that the fsi tree sent me these
changes to take.

thanks,

greg k-h

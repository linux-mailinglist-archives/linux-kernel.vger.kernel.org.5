Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703B784020
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjHVLw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjHVLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:52:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE3E49;
        Tue, 22 Aug 2023 04:52:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 397B03200920;
        Tue, 22 Aug 2023 07:52:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Aug 2023 07:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692705121; x=1692791521; bh=bO
        Ms+N6hNfwJNcAlSW0dBwj/mwZ5nJVfwmmN7NU9qc4=; b=mIb1F/7nM1iNj+fYz7
        6vRfM+ZqKjr2RWWSwJ8RQeqDLoMe8k/o2H9rnAm8FQojzBchwJd+xqcLVUlRZwTz
        fB6qSp4sZ48H7lmHLBZ9XsFPsVm52nESTYzAxLP6qtaruejg/3WnTXIxrj5/Y0wy
        x9fSTl5WkQ+IYGUOoHZNsh2D1hR2MsDnBBCJxoWe6iLgJzKdN11nG0JxdLjGPSsL
        tCi1W2gwST8e416GTfCef2rWMwbxrepYARdvVyjAGXUSfu9EtleKRehHx0aDEZ0r
        7z4SeQvsgDviKh6t5aE9qSCnYxDFYAwyLLxAM9p6fIau2s8IGCIvZJs8ETvrkNa8
        Kg1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692705121; x=1692791521; bh=bOMs+N6hNfwJN
        cAlSW0dBwj/mwZ5nJVfwmmN7NU9qc4=; b=ob8+elqcZSCy5xKWavjRFsOwxHbSL
        wV+OWrv6RCUdqTVcT1wiD8QKap56v+fwbNAUdPMeozB358EmkptLkHshf4Sue0NX
        GMnU0tBTUYKkxjPhZvUUimO7gFNrs7h09i0kkpor7U8DaZDaxsRMVmxUfAqmFPTC
        lH0lTHO+ba/klRuk6x1YPGsa+Cy34J98nweMowfVO9LG5lX6+qySPLE1D26pOkPn
        ORokgdLgxrdndcOi8vDjoVSuAH7U51yvuqW0Jskx3qE+Vwj2f00ulp+ezegJ/tEK
        nfQ80oFegLxuTgdGCgdnzKbnOWGWtg7zO04nxd8M68Y+9TOgeHwXcLV1A==
X-ME-Sender: <xms:YaHkZA9nhHMHAccPcN_bTiOg-o9NkY1g5t-2OAXEv1hKGH4GX64KIQ>
    <xme:YaHkZIt3wW-K9NHC-K7vRn_JCO9sUHsoa1NzU3O3tNV6mwX9JOuI5PoFwliIOFy5R
    r8sTfdpBGfgOg>
X-ME-Received: <xmr:YaHkZGAgSxyw7X4SMYmBlXfDUJgdo-3yhdkCLJMBZ_9wwE_MA0Wrvyw8ZlwJkCbHVbgV3-u-X5W4-pLARbyo4fCs9hfTYd0N-Bygbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:YaHkZAd1duih5GdyeHcodoutIDFkoJZsY-d3I-r5hewXNPB8FbnltA>
    <xmx:YaHkZFPiS5h2Vyc5CyGobhjam57d4EftETTLLwgtWxQ5HqFfyJzHXA>
    <xmx:YaHkZKmLECU_n9ZonDYdE37KOne9d7hDwmZ2N0dc53xKqViUC2n8Ug>
    <xmx:YaHkZGGvC4Fx8ojjjy3u33XQHDZhfrfpn2uQwsVYKUW6FBwO_33cPg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 07:52:00 -0400 (EDT)
Date:   Tue, 22 Aug 2023 13:51:59 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the jc_docs tree
Message-ID: <2023082254-prognosis-myself-5449@gregkh>
References: <20230821142148.14b1b4be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821142148.14b1b4be@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:21:48PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   Documentation/ABI/testing/sysfs-bus-umc
>   Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc
> 
> between commit:
> 
>   ebab9426cd73 ("Documentation/ABI: Fix typos")
> 
> from the jc_docs tree and commit:
> 
>   f176638af476 ("USB: Remove Wireless USB and UWB documentation")
> 
> from the usb tree.
> 
> I fixed it up (I rmeoved the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Removal is fine, thanks!

greg k-h

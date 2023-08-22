Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA68784022
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjHVLx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHVLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:53:27 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A0E70;
        Tue, 22 Aug 2023 04:53:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7197E320084E;
        Tue, 22 Aug 2023 07:52:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Aug 2023 07:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692705135; x=1692791535; bh=7J
        qCoAJuk8u8xSkOV38YwLmi1T9XqDBxcThvHVj3fmQ=; b=wmfhwMyd1w5NblHAM3
        8z9Xpfnc0/u+D5YvYkzjriC8ltohHitQiN6Jbqh9m4Py9a43svCAUwvxspV6OjH4
        3HJhlVSNBedy08dNoEgm7kA6KKJlxuNNe1e50c5xzJltk4nPG9n+/cBb16RytBGA
        0rlcpWiz0CwI6EUle7HGn0Nhp8uLwSl6HGM4xswtzRxZoWN00QatYIAcdg0QDP0K
        nqcON8wFfZZCshYkoboLLBvGjTH8/0mRrpJsUQH78rJiTzZ1gG7hdF32oq7n3WRl
        guyq+nuxGAjEVYtpQXGdqHTbRR1IauIAup1nMNagSElL1z60PMGlbBVt3RhtMNNf
        jRLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692705135; x=1692791535; bh=7JqCoAJuk8u8x
        SkOV38YwLmi1T9XqDBxcThvHVj3fmQ=; b=zKOFuO5B2nHDMEWcv4xRcXBRP7TSB
        i/WeataN7k9z1/mqKwSGfBFiLBWbHMe6hzDRclCbDOkQBHzz+Oo2zEiTQww0/rnc
        0cr11FkQ+09Rj/55XtwT4oImFWEoy7FGbMcHYoRI42YCTOTZW/xc/ueS/BrP69FX
        N32GMqgJ61ctpl9qhyX7Lu3HLptRnF0ip2oGGl8w3IstORK98p4uH0AK7PJ0OEj7
        2xW2tICctF8I+2wBAeFykE4yw2yLkUjWnr+Irg+eH4j8XaHskhWgf00Z2yFSzif1
        KMCp9/AMdTPfR+oY9YbNjkr26UnZQUzcyzifL4x9k23B4km7g2h/WoGNQ==
X-ME-Sender: <xms:bqHkZCTxx2hAQ8LMDCb0ySR_eYdDn10iotCzv_iwUf5ZQPASqkqB9w>
    <xme:bqHkZHwg7gyohhbJvVXrLryrqwcdPSw9KKZXba15EVwDzMCLj-KiV9OjZiNqANTLn
    qmo_XfOpx9XnQ>
X-ME-Received: <xmr:bqHkZP2UQ-TdXRhayMMVXT4rsVbQJ1icR2z4VxJFlA0tkjN-D1YfPuVsQnmRnCs4UbrJdRewhS-gHtcb8_h_iPnHC4SZkR66cmYizQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:bqHkZOApwexpATu_wnEnvdcWiIADsR5Vp8V2cBVLiBhB3wPTRc9SWw>
    <xmx:bqHkZLjYoXCFP6xJqnEKdaD1mlK_EtI6awDK0f2_fOMi6U8ZyGcnkw>
    <xmx:bqHkZKoyJTiJDc2JmTtgvP6SBrhkGs-rbNlbfipkFJR_ldKK_vbeQQ>
    <xmx:b6HkZL52JE4ust_cMXkNnC5P4lZpprk1FtbrD8Rq3Kg6PC8L28b2nQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 07:52:14 -0400 (EDT)
Date:   Tue, 22 Aug 2023 13:52:12 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the jc_docs
 tree
Message-ID: <2023082203-pueblo-octane-3ca5@gregkh>
References: <20230821142550.232faf95@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821142550.232faf95@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:25:50PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
> 
> between commit:
> 
>   ebab9426cd73 ("Documentation/ABI: Fix typos")
> 
> from the jc_docs tree and commit:
> 
>   2cd9ec2a5147 ("docs: ABI: fix spelling/grammar in SBEFIFO timeout interface")
> 
> from the char-misc tree.
> 
> I fixed it up (the latter is a superset of the former) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Thanks for the notice, all looks good.

greg k-h

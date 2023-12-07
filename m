Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A97808645
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjLGKW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjLGKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:22:57 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED8128;
        Thu,  7 Dec 2023 02:23:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2BD5E3200A28;
        Thu,  7 Dec 2023 05:23:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Dec 2023 05:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701944579; x=1702030979; bh=mD
        2V8g0UR8RLd5sraGPK/zq8abiEOAWHhLadwJjNkwU=; b=D3E6Zz2iZure7isn4k
        R/4kP6MJEkuKrG7WM1IWBIyLBuimHwWZihEdsF/CBUHUNK6UDSfNdPCcNiLiCKrZ
        B82TnOTaSkdwnONYH51PqZXGf4uEYnllgMo5AuDLc5M+4euKF7nW5rEMBsknskk5
        6hnCk3qAC61yKJyD1rk91ZZhe4e0ElyTdbXVyEa6mN0cb2Kf9ouklf/T7wwc/KDh
        TAaeqAJwAk/nic77Iq58g2ZfyPUrLR8iDbza/D/jHFBTp5EgbyvYDlqVum1076RR
        nfmGRSXSRjSPDG8sgJSYOYwZlDQpUExYYusgsA5MbV1VKsUeoP6mJuanI80WBB0t
        0CGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701944579; x=1702030979; bh=mD2V8g0UR8RLd
        5sraGPK/zq8abiEOAWHhLadwJjNkwU=; b=rrU1M+DxSHTzy7Hly4+Fmnju7q9gr
        ScB1ImAtgHfYLDNO8ZYCj+ZYKykUdYQ17AkBAwvglsW/IOWVb16KNx3q3WzsFjbG
        vNcVrqvRvELhQDS5gETOLigCNZr9e2k/el5Py7bAKl7cK040NFLqdQnkqBhK/CWo
        +LmVRyel6TjutaaTJAhMVY0+wzRmyKpktkDtXqAz2879lNpj+UEpCQDMWOtvPf4p
        hnaAT6NHxRphv+biPTbYI6wgOaVUB4Yq2Y2hQVqu5sVzUh6RIwDszwKr03QmnAjQ
        nmsTnIa2RKuVUs17zYlNfBeyN8CJgJqL3VTqdthnpvjZcIZ6QszgFC0AQ==
X-ME-Sender: <xms:Ap1xZcLb-XY1fxmpnOMshfMEBjg14Et4Lwwl9VgzujChVr5s8OsU-Q>
    <xme:Ap1xZcL5oD5WAamNeWa_7_E5EfbB1Jmr73s8mtYrqzC9gtIOA1oNPCX485pK2sYqQ
    juier8YCtlSzw>
X-ME-Received: <xmr:Ap1xZcv7Jr2CbLxXtZQU9NwlMjeCpTN4Om1yvKurptfGq9_cTFWJNTG8trI4KtvBdwFNx_eHbdFHrG7Zjg6ZL10bp-Ru76U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Ap1xZZYD2f3ccthpw-NN5czFZti1u_v7_vxZ-AEXcvFdizhZhJ0hDg>
    <xmx:Ap1xZTYPK61WyaQxJiZhE8qjlc44rDSxpDPRSeA2IeZZwsOtg0yASg>
    <xmx:Ap1xZVCarsUvMZK24SmIwZEO4Dq0vnh3ZOpUy0rTCNVzzmKaqyZb2w>
    <xmx:A51xZXS3kVWHTHatsGPKCvBECAhcCSybVKL6OlXTwch1-uwj_brcfQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 05:22:58 -0500 (EST)
Date:   Thu, 7 Dec 2023 11:22:54 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nhat Pham <nphamcs@gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the mm tree
Message-ID: <2023120721-footman-falcon-efad@gregkh>
References: <20231207134213.25631ae9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207134213.25631ae9@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:42:13PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/android/binder_alloc.c
> 
> between commit:
> 
>   8b59d7857c30 ("list_lru: allow explicit memcg and NUMA node selection")
> 
> from the mm tree and commits:
> 
>   ea9cdbf0c727 ("binder: rename lru shrinker utilities")
>   ea2735ce19c1 ("binder: refactor page range allocation")
> (and maybe others)
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the merge resolution, sorry it's so complex.  I'll keep this
around in case I need it when sending stuff to Linus for 6.8-rc1.

thanks,

greg k-h

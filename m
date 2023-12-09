Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502E80B0C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjLIAEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIAEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:04:49 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5369123;
        Fri,  8 Dec 2023 16:04:55 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 796B8320029B;
        Fri,  8 Dec 2023 19:04:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 08 Dec 2023 19:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1702080290; x=1702166690; bh=ZlhhGC8MmDwntW/X5pZovx9haHFb4sqy2tr
        4l/qUhmA=; b=WsagpBE/4lHxnO4cJAERP37lw5hQZJ9dA8uDrsIZaZeR3zPHnaB
        6lo8X2/n+WMJQkYWQKCf3BhrM4CcISSDi1Q2du6x+lkZyBjGCf5X3wVVBFq11rL1
        K/zi+NF8nvjqRH5oXglArIMBu48RegZhtqQD/K2gZhGXhin6THuNlpD5NP7vKmHt
        HZfscyw0ptuu6vC3r/NKZvNd0zZ+02weRZaykCk+6USnEl5919/iqQkaB9m8DrZH
        3HoTuth4KDfjBZJ2kJiEccopod+ftFF9vOUkVoaRhMmIeeOHSrcf25hkl2eastVF
        0wqYztwu0319mUg2aQHTrPNvhm2gIi7Z6ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1702080290; x=1702166690; bh=ZlhhGC8MmDwntW/X5pZovx9haHFb4sqy2tr
        4l/qUhmA=; b=uJCPgsY6B12Hjt+ZQnsxdMtY+eYFbyOYYxDIEBAklq/SjGQqeER
        diE56E0hdOZ/4UIuOIUOvLwTBDDAu+/5xso6zV33eQr9B3YnE5vchemDHjjUUBrR
        1JBwub/kdxc22XcEnzodGTbZ4nsRJyW1fFuc17SYCM5Pq9ftp5Lkc40riUfH4MW+
        yuMc1N93TtwNgD+M/kq9vSpgLFdt3yZEgqbzfPrkgYghdMFpu7GAONZv13fxxVJ/
        OkHtG53RpS/zPAN3Xif9afKBn9TDxteSQPHW/I9dNF1IJC/LkWbVap8ypdmI7oYq
        Ob9Ts0IaEGzIJsN3+pdZybA/PE3+hBTIJ4A==
X-ME-Sender: <xms:Ia9zZSS4GxDfvKyTbGcmo9t9SdVP34m1Yg1EZDMXr40_XDJ-R_Vinw>
    <xme:Ia9zZXzbYwRFfp3k5A2bg2A76hNoVLbjgaPa-1shpnOh15jeR9bwz4RUTFhQpW-Gu
    etbZPnqmGiQUQsq_A>
X-ME-Received: <xmr:Ia9zZf0zZmsmS-xffZubVIeCYh2_RFmCZbLQlSxC-gC5E1BUbCNGSFBFUo43AKq7WY4jbxmZoSDc6rQnOlfEjlx8EZVWtEQHbycT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekjedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Ia9zZeDcWCUxunzmSASplIBSawA1Ex3GMvzMQYhEnJEyX5roIPgPjg>
    <xmx:Ia9zZbgPC9g4rpv0-sm1GtSeMgDmFFakJM7v-1p09o39kYSApiT-qA>
    <xmx:Ia9zZaqdW3sw1H_7ormCbEn2UF1KZSKPjx9nwv3lj_Tq_RcIMPMPJg>
    <xmx:Iq9zZWSCz_bPAd8iXfRgW4fifXhOHSSi63ZJ-ouRIGlyUjK5e7Nxlg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 19:04:48 -0500 (EST)
Date:   Fri, 8 Dec 2023 17:04:47 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexei.starovoitov@gmail.com, devel@linux-ipsec.org,
        eddyz87@gmail.com, edumazet@google.com,
        Eyal Birger <eyal@metanetworks.com>, yonghong.song@linux.dev,
        kuba@kernel.org, bpf@vger.kernel.org, pabeni@redhat.com,
        davem@davemloft.net
Subject: Re: [devel-ipsec] [PATCH bpf-next v4 01/10] xfrm: bpf: Move
 xfrm_interface_bpf.c to xfrm_bpf.c
Message-ID: <njhajqix6x6ktmlhatjrdpsgmtehsizgrbyd6equfiippqtqie@rboplircto53>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
 <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
 <ZXGx7H/Spv634xgX@gauss3.secunet.de>
 <CAHsH6GtmhP=hZcf2Qv=21dAOSb5dD4GDa+QYdLFz9_FsCZq6tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GtmhP=hZcf2Qv=21dAOSb5dD4GDa+QYdLFz9_FsCZq6tA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eyal,

On Thu, Dec 07, 2023 at 01:08:08PM -0800, Eyal Birger wrote:
> Hi Daniel,
> 
> On Thu, Dec 7, 2023 at 3:52 AM Steffen Klassert via Devel
> <devel@linux-ipsec.org> wrote:
> >
> > On Mon, Dec 04, 2023 at 01:56:21PM -0700, Daniel Xu wrote:
> > > This commit moves the contents of xfrm_interface_bpf.c into a new file,
> > > xfrm_bpf.c This is in preparation for adding more xfrm kfuncs. We'd like
> > > to keep all the bpf integrations in a single file.
> 
> This takes away the nice ability to reload the xfrm interface
> related kfuncs when reloading the xfrm interface.
> 
> I also find it a little strange that the kfuncs would be available
> when the xfrm interface isn't loaded.

I think technically since the xfrm interface module does the kfunc
registration, the kfuncs would only be available after the module is
loaded.

> 
> So imho it makes sense that these kfuncs would be built
> as part of the module and not as part of the core.

But yeah, point taken. I will revert this commit for v5.

> 
> Eyal.

Thanks,
Daniel

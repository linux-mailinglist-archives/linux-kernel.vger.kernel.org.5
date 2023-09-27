Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E17AFF83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjI0JK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjI0JKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:10:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3A492;
        Wed, 27 Sep 2023 02:10:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 866613200A3B;
        Wed, 27 Sep 2023 05:10:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 27 Sep 2023 05:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695805820; x=1695892220; bh=jM
        eK127ejzIDJuM4VM/wgP8FtWBmLzqzxn8NWLLkhXg=; b=os3C1FUA7o/WzrclHY
        SRNPRe4M+YjFSbv2wF7Zp2bNOXjQHeqzjmpaNLfbxTPAAmivQCIVmlhxx5RvS3Yk
        aJqMy+OE8GKlxhg6fMx9NsIL+TH1SMtl+3YurAaHrTcnojvvvRdojqOBLsO88QNq
        j0pJCjt4DEi9YSYpDraRhwhZbq/SgAhqCv4gwkzDp9HtzpH3j835V+ircMWklpGE
        Q6e9l7RuMXaT4JqJ01Wxn9vDW5jpy+cj5a6zDsG7C1b6H/Dvq7hxfdDTkjhiJe4w
        IG9IRU6+7a8UlvNXGr9hiLNA9e6KyS63F1oTb+MGlADV/+BWyy9EE/2BrfaIrHFe
        YmTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695805820; x=1695892220; bh=jMeK127ejzIDJ
        uM4VM/wgP8FtWBmLzqzxn8NWLLkhXg=; b=gCWph6jXv9d4V4KMwnYWdqwOUxB14
        35Tvqai2gzjHBdLdXgse+L6dv2J2PH59ObyI+xJ7rbBXQPEj2qRK4bKIHQkGo5cJ
        jdPA0TT/zhjyOiqf8f7fx6KMM+HmWp+Y6jygcy4htinMbvABAN1HaE2CKVlv7n2x
        f4XFtYu88qP9Qp7Zg5xs10WaCf8cGC6BAhe949FaHQlzAbqRZkN3UpIUrwwzS//x
        Q+zEhSZ7GeMpDcUTfzWjw0IgRTi5eFlJCjD/DrtOdixUTS14E5t0q6N4fdL9dFKs
        QLhz6lmDqwSnmiQEsHIAAaNvy/Jax9C66NIQEE9XU8kxmc2Q0iGikUpYQ==
X-ME-Sender: <xms:e_ETZQ3ok_LBT78esrESTnI0oUlDRs-hWpGscMSM4ke6D3s2VmePDQ>
    <xme:e_ETZbGXZ6Utp2mWbab6OhS13Ld1JyPQ72KPtnX8OO0M6HmLV4p6Mwbel1saW-G64
    4mKMRZ6OT3E0wkeLYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:e_ETZY708Mtm6Aee2DBJ6ggD69DITco5Rm3d26guAIo7kF_XVCeF5w>
    <xmx:e_ETZZ0gGy17bK4UJhpqn3IA8eGuRYic4T0yXaZaneClI2e9k4UN_Q>
    <xmx:e_ETZTG12QbPA6IZ_Vylg62d78TXGiaOjk33VuIUn_uJ01LdiqReHQ>
    <xmx:fPETZYTXeXVTfMg9eDWancF9IDBi_irlfF7wsTE8U7bTGSJ_WmAWww>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9052AB60089; Wed, 27 Sep 2023 05:10:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <46a9b2f5-ecbd-494a-8a88-ff5fc7b4fe84@app.fastmail.com>
In-Reply-To: <20230927070444.6e32666f@canb.auug.org.au>
References: <20230927070444.6e32666f@canb.auug.org.au>
Date:   Wed, 27 Sep 2023 11:09:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Olof Johansson" <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc-fixes tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 23:04, Stephen Rothwell wrote:
> Hi all,
>
> Commits
>
>   4e7b558e320a ("soc: loongson: loongson2_pm: Populate children syscon 
> nodes")
>   019d79fe6c3d ("dt-bindings: soc: loongson,ls2k-pmc: Allow 
> syscon-reboot/syscon-poweroff as child")
>   59598d7ba6a8 ("soc: loongson: loongson2_pm: Drop useless of_device_id 
> compatible")
>   8e5f17483ab4 ("dt-bindings: soc: loongson,ls2k-pmc: Use fallbacks for 
> ls2k-pmc compatible")
>   9a7c9c7e34ac ("soc: loongson: loongson2_pm: Add dependency for INPUT")
>
> are missing a Signed-off-by from their committers.

I have fixed it up by re-merging all patches in the arm/fixes
branch that I had merged yesterday or earlier.

Thanks for letting me know about these.

      Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8131079F9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjINFJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjINFJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:09:12 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4298
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:09:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D37E5C0267;
        Thu, 14 Sep 2023 01:09:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 14 Sep 2023 01:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694668148; x=1694754548; bh=yd
        JTNhSaUGGtg0mobQUwtBl+Oa8gBYThWl5NgNFBv+M=; b=kWSgLc7j9kEBO4uJgN
        wSavPAVuaWHtZfMRBfsIMbXRuoaZVBo9Q/ooFDP6erl5ujtDJ5rnaJKNJIanayu/
        9hJKstmZn8ArTRSQEqCHo1IeDuGETGql3s2sDerV6H2hbm2irEI5L2Guc3G2+eVc
        KJFvAge4UD6wvGLkS5FRaP2XYh1Kl5thZRPigrl7YYbF8Ufswv79j81JNEkWnCq4
        b7W2MNaMzCdZgyHxesOY5dx55gYHvascpFj5hhWa1tCk0QTTxLT3TRAky4rApyZN
        7PPKQLNaELW/2JtrLl7+y6+aMpx+2K3F8d/sKhGrYHNWprS+NMmzen/z97ZC9xRU
        KXGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694668148; x=1694754548; bh=ydJTNhSaUGGtg
        0mobQUwtBl+Oa8gBYThWl5NgNFBv+M=; b=riZbqwy3rL5Ha4BCuoaZogNIjd56E
        HkLQDxUTtNsz2UIzLauerPae2aR+qvlLwNv8dOshW/PBSkZ1EE9p3yoYs+7tjQy1
        b1f/OJbrbclcpStnfc2rFv04vjCMduVTFmkKsuYn3gfMJx/jmdUJRTH7v+XMzxdu
        S4m3P8JJqAgyeWjuVnTJqF78kjw373Y4/1zPJmEjQvDRbHEistFr7Wi9aOvyRQSC
        kIv/fdNcRnxKak3GfuUkkIydxC4fv4H1aW80K2JIF0/dBmLto5rjw8vJ7ila4EJX
        oOFEpvMiPcxsL5Hw1Pzm8ON1Ezz5YMxj4b4HZxCbDdN5z+agdEURRpLqw==
X-ME-Sender: <xms:c5UCZahM7-7ai_2pds8mz8FQHNWPZVUKCs-sWupIKvkPdOCJcp4i9w>
    <xme:c5UCZbCvmF1YKg9Zx1KfJ-UC7ut9ZAHUVqgbzWYA8GJl3jYYczce1TpIZtYDkKN3O
    Ot4FjxaHpeRcDC8NYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiledgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:c5UCZSFGe5XAzgjQWKe5a0XHdkti_gljUFkeX3hHOSijRT5MQM1hMg>
    <xmx:c5UCZTTuze8Re_FeY6OoANbU4CBv0cRa1x9QYDB_-iYrtfDpp0IksA>
    <xmx:c5UCZXzo5AqSn9cmjr8I6M-kTAHWV6aNifsthxKLs6HvkMiPikeXtQ>
    <xmx:dJUCZQoMWaVZyI0-QfqEgduDrScXcuyb2WTlt3nacQa3bvV6F5TiCA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B16E7B60089; Thu, 14 Sep 2023 01:09:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <5cace191-31f6-4aa5-8b19-aa6c1f2db7e6@app.fastmail.com>
In-Reply-To: <202309141131.pNe5J6HH-lkp@intel.com>
References: <202309141131.pNe5J6HH-lkp@intel.com>
Date:   Thu, 14 Sep 2023 07:08:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Jens Axboe" <axboe@kernel.dk>
Subject: Re: arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8
 format
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023, at 05:45, kernel test robot wrote:
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202309141131.pNe5J6HH-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8 format
>    arm-linux-gnueabi-ld: failed to merge target specific data of file 
> .btf.vmlinux.bin.o

It's a completely unrelated issue at the link stage that gets
exposed by fixing the other bug. I don't see this in my
randconfig builds right now, so I probably have a workaround for
it somewhere, but I can't find it.

     Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C877CF07
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbjHOPWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbjHOPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:21:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827DAE5;
        Tue, 15 Aug 2023 08:21:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AB7A5C010C;
        Tue, 15 Aug 2023 11:21:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 15 Aug 2023 11:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692112898; x=1692199298; bh=bG
        W5fgwXN3XABGnruszG50+xXP+Vl0cz4MBqJr/9aOA=; b=rLtiiuTIU6TjnVveb/
        x+VaaMf/PteXImoQ/ZjnANXV1cA3IGk+cIeKUwt7u4Hd7HPf8jdmUDSA1p/GVXme
        VNT3o5aQGE4TB7z37Szhoo6YmJk4DJAfau4Beq8WPBBTGO0RyeizGeS3XAM21ADP
        mCGn8I5LYNlijRCSa6Ibn+w96AspFC9cbFEd1vHQI89FxUgUdO1+yotD+2uZSEB+
        PvzjSXIfoVpUMVZl3N5//xa4LQ1tDyGEkRwaHJ1d0N4of4r9MXtQXnP6KUQZ6twD
        4wyYlRMmTiVPmUih9iMSRqsufoSGFtCvEWRqFwSQsCx+nrZi7iWMlsdm9TDJvewf
        cVHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692112898; x=1692199298; bh=bGW5fgwXN3XAB
        GnruszG50+xXP+Vl0cz4MBqJr/9aOA=; b=VeW1B1E3z2wAN38yVR1aht7rUeE77
        STMPccquKEOM5tVqg8t6/UP9vURG9fqD0JjPfAnPRlhToajLjuguRtz8UDjffAZY
        K4uyzKNnKn+XZZja8m0q1ypuLW/Y5BPXL7keUyBU/LIbtzsZib+mdJSPa7zbwX57
        cfgWG20H6slP37vUQeBW9bSxhQGb1tASwzgDIjvCQMCXvXBGL7HOry2+m3Gv19mx
        bB/nbCU/p2RQzRiyHSa1ANOD/KXzWoWTBNQ2GVoh1iatUR+gin8StnwTv735l3Nq
        JvRqk/pyjtNdprV+OPlPcNiYcEBtmjSEK3awEWXl2r8wQKnuZrnJik2vg==
X-ME-Sender: <xms:AZjbZFH120MIINJLxMhgKAN3TcM6_P_dtyJsCLm9abEQgcD3ywj4rQ>
    <xme:AZjbZKVVsC9xnBlJNbecdzFImFbDjmTGhw5ya8Mq5_Mvk4dBf7qXHqH9-OmbeSu2K
    FXU5bX3MFOVmg>
X-ME-Received: <xmr:AZjbZHINg7zqhyKN1sxp8So077R47k6wwcDOfh4hee_NR_Zo1f8Ll9CjkuF1QOaCPOF_E0N2FT8iv8z3gSq2xG_T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:AZjbZLGR3IfBRpKSUFyRvaOwnrmTYx3O2I3SFRouGxuZ-11dXmTG6Q>
    <xmx:AZjbZLXSPg1gT9-HM7ekXz4yXg2c4jMjjDlVhSPHPZ_mCOo1gT8s9w>
    <xmx:AZjbZGPx0MoLWYZmZ1wJu9RZpEeBP166aMNsFV1LV9Ok6z7wOOPV_A>
    <xmx:ApjbZNJQ5SZfQPKTax8JVKRqXoUNNMlHGWQnNXFGiiSX0VzEBHuw5Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Aug 2023 11:21:37 -0400 (EDT)
Date:   Tue, 15 Aug 2023 17:21:35 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <2023081546-unpaved-important-3d18@gregkh>
References: <20230815172454.138a386b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815172454.138a386b@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:24:54PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/base/test/root-device-test.o
> ERROR: modpost: missing MODULE_LICENSE() in drivers/base/test/platform-device-test.o
> 
> Caused by commits
> 
>   06188bc80ccb ("drivers: base: Add basic devm tests for root devices")
>   b4cc44301b9d ("drivers: base: Add basic devm tests for platform devices")
> 
> I have used the driver-core tree from next-20230809 for today.

Ick, obviously no one tested these somehow :(

Maxime, can you send me a fix, or I can just revert the changes for now
and wait for a new series?

thanks,

greg k-h

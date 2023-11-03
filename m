Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EF47E017A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjKCIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjKCIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:45:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E11BC;
        Fri,  3 Nov 2023 01:45:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E9F9332009A4;
        Fri,  3 Nov 2023 04:45:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 Nov 2023 04:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699001109; x=1699087509; bh=OJ
        CUEPYvZB4ErKIoNHvStKHVpMlY0MiGU3IchItY5gs=; b=ozD/VUdE4sJ+mm0gMD
        VPxWC6c0N1XhvSr5H2DSXMjUKlPJz5FLOH7qQZZExBZEZEL3pQADryRO5qE9Zcdy
        xJGc1/duwdoiyFyuEkIijNl7gjAlqeo7NCodOrox33rfz8jdMDoHCwGO0USzllv1
        e/2ri3HnaQGJ1JWA1Ph61r10oxSNl3D+CNyqpTiToQcSGRG+CVCoovkk+k+UNu/J
        7eV26OKkSheQPYZ0W1vIyEztHDKMN+/+GZqXTaKslYYD3hl0hdEFjmtBO+njwV0I
        aqNQ2Z68dvqlET16nY1Ir4ZL4MM+ZWevN2dMfrznOBpU0H6kDtBwRjMTFy7YdkuQ
        04TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699001109; x=1699087509; bh=OJCUEPYvZB4Er
        KIoNHvStKHVpMlY0MiGU3IchItY5gs=; b=nlRBFxnlBa0YdE61dG1PRWe7r6FQP
        YOkAXmCAlSghhAsm0SNIWKE/sg/gfFhX8s/v9hhtwaV1wwlM+JkMXRDHbD12Dv94
        9ZRoUIbsa3ee8tehp+qKJn0GDH+uEiSwyFa+SwQMu5SWMX3rGI90bKmzRf6rlrUw
        GuI9iK0hmNFhAEiBCOr5iCM4MIV9fIoRO/PcGGPdI3EEYH84/xuvGdpLs4PrJ/S0
        ceYL6psfI6lsrvVgD27KZIc0IjLIuII8CLp/8TbG8Zz1gOeiYkhoD8ljI9M9WLOt
        RZPTn/90TfbwpgcokeWhybYm8C5fLJoYKvfNC9bSqQRrtHFO8oSeWk47Q==
X-ME-Sender: <xms:FLNEZTBUy0oEQ2bagMmiKyAT5cQGsLOie2D0Dt41C1RNohzzLNtU1w>
    <xme:FLNEZZgUbApiApCF8fbw4OEeq6YFRnL-HGldhC74uWtMU9ziUbxcochuNb-a6B0Uz
    OFl7FWa4Tor3g>
X-ME-Received: <xmr:FLNEZemsBU5KB_dZoHbKUK73yV3YRSGQQPZ748hK5HsKVLTi3DMjgPOVYLaSEH7Jibw8ulcnkFIB4lf7YDRNuJB8MTzUOv04h5Bm_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtjedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:FLNEZVxhcwsnE37FTVKFVD5LExSA_8P30QgPmokZiU440qLhJL3iiQ>
    <xmx:FLNEZYTgrE5Ta8RWGbJpGGtsUiSf8Q_Q-uVhtyryWnC4qdq0yU4bEA>
    <xmx:FLNEZYbM6MP7ZoangTdNXwIrjNuqgHI2_S9YFXIL-4mHEbhpfmVaLQ>
    <xmx:FbNEZfLXGMHX0DnDGrFB6fu_bmETh75OxsgSKy5m5wT5owW2xUHErw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Nov 2023 04:45:07 -0400 (EDT)
Date:   Fri, 3 Nov 2023 09:45:04 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wentong Wu <wentong.wu@intel.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the usb tree
Message-ID: <2023110355-reuse-spoken-9945@gregkh>
References: <20231016134159.11d8f849@canb.auug.org.au>
 <20231102112950.4706f887@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102112950.4706f887@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:29:50AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 16 Oct 2023 13:41:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Today's linux-next merge of the gpio-brgl tree got a conflict in:
> > 
> >   drivers/gpio/gpio-ljca.c
> > 
> > between commit:
> > 
> >   1034cc423f1b ("gpio: update Intel LJCA USB GPIO driver")
> > 
> > from the usb tree and commit:
> > 
> >   da2ad5fe2292 ("gpio: ljca: Convert to platform remove callback returning void")
> > 
> > from the gpio-brgl tree.
> 
> This is now a conflict between the usb tree and Linus' tree.

Thanks, I'll note this in my pull request to Linus.

greg k-h

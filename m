Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02D377F0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbjHQGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbjHQGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1010BA6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8729A60AC1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9A9C433C8;
        Thu, 17 Aug 2023 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692254791;
        bh=kGXjHIIItKcedfobgcUxtg3pCMarIyql5LXTBLsFlpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4aL0lJ7SR0dE9hoY4FkVsTWiCI6kza6xK1INUjId1UOv7aPcLmh4tc8QPN6FNdVw
         vWyhIAYKlnqyLCcZ4XxveR/gvvrA2ULuHLC7Ux045lvSSr/jL0Kt/gVHOEkLioCpgB
         hDhrEZFMJeajMn5FhYTqnSqpQxVsgWTwJdMkxmSGYF+1Jc4Dle2yWeYsRVrnQnzB20
         LRspb2K7pNvqTWEonJN6Z+0Am5Ay3th/k0tWE5u4IcI0DEwO/yyaGyRoK5x4jRvvY2
         eI7MWXvNFhJSyhFJMk+d0iKLxU8yZTN7Fmfb+wm/sKKoV7h7nf4vjoZF9mqpAmKzcK
         Zlp2ZVcIreokg==
Date:   Thu, 17 Aug 2023 12:16:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
Message-ID: <ZN3CQ1Y3yC9p/01Y@matsya>
References: <202308161422.37GEMlZkA018197@rtits1.realtek.com.tw>
 <6c02765f89eb4455806b895a6e0cb763@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c02765f89eb4455806b895a6e0cb763@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-23, 02:06, Stanley Chang[昌育德] wrote:
> Hi Geert,
> 
> > diff --git a/drivers/phy/realtek/Kconfig b/drivers/phy/realtek/Kconfig index
> > 650e20ed69af41d2..75ac7e7c31aec6f2 100644
> > --- a/drivers/phy/realtek/Kconfig
> > +++ b/drivers/phy/realtek/Kconfig
> > @@ -2,6 +2,9 @@
> >  #
> >  # Phy drivers for Realtek platforms
> >  #
> > +
> > +if ARCH_REALTEK || COMPILE_TEST
> > +
> >  config PHY_RTK_RTD_USB2PHY
> >         tristate "Realtek RTD USB2 PHY Transceiver Driver"
> >         depends on USB_SUPPORT
> > @@ -25,3 +28,5 @@ config PHY_RTK_RTD_USB3PHY
> >           The DHC (digital home center) RTD series SoCs used the Synopsys
> >           DWC3 USB IP. This driver will do the PHY initialization
> >           of the parameters.
> > +
> > +endif # ARCH_REALTEK || COMPILE_TEST
> 
> Thanks for your patch.
> Why not use "depends on"?
> depends on ARCH_MEDIATEK || COMPILE_TEST

I think this patch is better, this way all future rtek drivers will be
fixed as well, no need to add for each driver

-- 
~Vinod

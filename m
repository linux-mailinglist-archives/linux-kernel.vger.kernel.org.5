Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D107C851B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjJML5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJML5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BDBF;
        Fri, 13 Oct 2023 04:57:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37664C433C7;
        Fri, 13 Oct 2023 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198232;
        bh=qmNJK5kb0pjOZzNaO3kMDXlaWvXC+MM1xD16tJxhhBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guvnoj8QEFgUXYVa4hApXHh4Edmp7s55USpRL1S7t9YqCWRi1etuNV5xbRZZ4Ogjj
         KoQwzRKJrrNJBsLubdhan8ogOEbIe6HYkrDpnpBXr0CCZDG7Vae3c1KmiTU7XH/WJz
         Vc38ykCC5ilmuduuYpjH8UozzxW6XAp0bx4eTx3GrswzzhYHHLoXRZV5nVBRtfgCZ7
         Zc56AzcSEmGLA6+hkrscfSwSDo9K/kJIVOBaRBOalyvv6g3WdAIJOYbzkocdJ31V7G
         C6Hthh75FdF6ANntNhoHnYw8pujwNwX3R9yn0bQf3ISDb4Eq66z6PPo2E1bFTMgtuj
         sPAAsgqfPEbzQ==
Date:   Fri, 13 Oct 2023 17:27:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] phy: sun4i-usb: Fix a W=1 compilation failure
Message-ID: <ZSkwlILa0fjh7cop@matsya>
References: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
 <169719382030.165658.16055633686751767855.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169719382030.165658.16055633686751767855.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-10-23, 16:13, Vinod Koul wrote:
> 
> On Sun, 03 Sep 2023 12:11:06 +0200, Christophe JAILLET wrote:
> > With gcc 12.3.0, when this file is built, we get errors such as:
> > 
> > drivers/phy/allwinner/phy-sun4i-usb.c: In function ‘sun4i_usb_phy_probe’:
> > drivers/phy/allwinner/phy-sun4i-usb.c:790:52: error: ‘_vbus’ directive output may be truncated writing 5 bytes into a region of size between 2 and 12 [-Werror=format-truncation=]
> >   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
> >       |                                                    ^~~~~
> > drivers/phy/allwinner/phy-sun4i-usb.c:790:17: note: ‘snprintf’ output between 10 and 20 bytes into a destination of size 16
> >   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] phy: sun4i-usb: Fix a W=1 compilation failure
>       commit: 9e34abc7abfac781df909891c8d53781f607105d

FWIW, I have modified patch title to reflect the change it introduces
while applying

-- 
~Vinod

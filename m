Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1680D2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbjLKQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjLKQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:46:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6506CCF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:46:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F92AC433C8;
        Mon, 11 Dec 2023 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702313218;
        bh=M40PI+a7RNFzj/ZFgspMXJXtnJLcZwidsLCpYvdczs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oE/OlgqySbql/JS2lw29WxTdP8SDQ/XWh/IJ73gM+4NRb0Vf38scOsUGTtNynCB/I
         pVrpb3Scme+8mexL2fjcntYaLwVOi43r/u33GYgFfVgnONz6DM+AYfiOlE+DP/5MFG
         Qkf2raas9EqIB75LC8Lk7+jWk4uXGIqSvwm+QEm9NjouPRx5gQue5BJhRg4Sriaaaw
         TMVNLPbpOLV//SdM0OL/sLVO+1E/TyAzS38cU51H1QDaZgEMFmwTuQF2TP2DGebn11
         Jk10m3MO97ydZhWQVAe5eMBKvqLl3stiVs6NuFoCAjZTrU4d0WEkoucam3d/imR+Ax
         efIVKNY5mrZ2g==
Date:   Mon, 11 Dec 2023 08:46:56 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <20231211084656.26578d89@kernel.org>
In-Reply-To: <6577315e.050a0220.50f30.0122@mx.google.com>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
        <170142826116.3357002.9561246405642038358.b4-ty@kernel.org>
        <6577315e.050a0220.50f30.0122@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 16:57:15 +0100 Christian Marangi wrote:
> > [1/2] leds: trigger: netdev: extend speeds up to 10G
> >       commit: bc8e1da69a68d9871773b657d18400a7941cbdef
> > [2/2] docs: ABI: sysfs-class-led-trigger-netdev: add new modes and entry
> >       commit: f07894d3b384344c43be1bcf61ef8e2fded0efe5
> >  
> 
> Hi, Lee
> 
> I'm working on adding LEDs support for qca8081 PHY. This PHY supports
> 2500 link speed.
> 
> Is it possible to have an immutable branch for this series so we can
> have this in net-next? 
> 
> Jakub can you also help with this?

I'm guessing that if it's already applied - it's already applied.

Lee, we seem to be getting quite a few LEDs/netdev patches - do you
reckon we should ask Konstantin for a separate repo to which we can
both apply, and then merge that into our respective trees? Because
stacking the changes on stable branches may get weird and/or error
prone. Or is separate tree an overkill at this stage? IDK..

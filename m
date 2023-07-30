Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265847687B8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjG3Tws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjG3Twq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C110D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC64760C81
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4658C433C8;
        Sun, 30 Jul 2023 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746764;
        bh=q6hhOZkoXhxMvYqFPQ1Z+qQRU5p1Zz9lZvoCEx4F4EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1lckKZV5i8eyVgwOnKZYUcpNNH60WXuY7KUiSq2kQBeOkTZqA/YihmaJK+EMr5PB
         e1xYfC8mJipj3eYWbcip5VLy/Otmsxog2l7XVIoGnZnD3yGsYxBh1sgrcU99X7vOU/
         2qS9sPcvRP1lcXFHwXwGMDovVG03Nx4Snug5kUUWAahAOCSoQciucdbAjErqwE4w09
         McaVF0h1ZScFzTANVawTaQGGboRsqYxHd48A08LNjFbIc7XyaASaCYxreIi8Y+UoGU
         1jSPhd+36IB36M5MzuG7Z0bO4lU+TkINDuWO9JD4PDDdDd86b3CONY5peyI+ta1vGA
         W8TBQlbPeAEAQ==
Date:   Sun, 30 Jul 2023 21:52:39 +0200
From:   Simon Horman <horms@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/5] net: dsa: qca8k: move qca8xxx hol fixup
 to separate function
Message-ID: <ZMa/h1SdZJCgBs+O@kernel.org>
References: <20230729115509.32601-1-ansuelsmth@gmail.com>
 <20230729115509.32601-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729115509.32601-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 01:55:08PM +0200, Christian Marangi wrote:
> Move qca8xxx hol fixup to separate function to tidy things up and to
> permit using a more efficent loop in future patch.

nit: efficent -> efficient

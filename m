Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C222A801DF2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 18:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjLBRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 12:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBRXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 12:23:32 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485EEE6;
        Sat,  2 Dec 2023 09:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=UOg0neSwYTvDFET+i5iPup/ZjKSuSV49mahFCPqPDAY=; b=vYz903PdIZNmg8KxSnMl1ZR6kx
        A20pWgJjKZ8AqI6SmnMAhDMADeNodT+QUYeDprwy2rgO6em50G/AieniE74FWIuQxysIxcX3+bWni
        L5Lr5HhK/NVYiciAcsvy/sdHSyYXONMQk7Ba4kqgIEDVygkU7fgqR2SgymgmKhg6R6eM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9TiG-001rLm-2T; Sat, 02 Dec 2023 18:23:32 +0100
Date:   Sat, 2 Dec 2023 18:23:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Wu <david.wu@rock-chips.com>
Cc:     netdev@vger.kernel.org, sebastian.reichel@collabora.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: stmmac: dwmac-rk: Repair the clock
 handling
Message-ID: <334c740b-eda2-450d-b000-2ed39b86779e@lunn.ch>
References: <20231202091806.179512-1-david.wu@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202091806.179512-1-david.wu@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 05:18:06PM +0800, David Wu wrote:
> It's clarier and simpler to replace devm_clk_bulk_get_optional
> via devm_clk_bulk_get_all. And it may be a different clocks
> combination for different Socs, so for the clk_mac_speed, it is
> more correct to obtain the clock directly by its name.

Is this fixing a real bug? What is that bug?

This is a big change, and it is not obviously correct. Please take a
look at the stable rules:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Could you create a minimal fix for stable, and direct this change to
net-next?


    Andrew

---
pw-bot: cr

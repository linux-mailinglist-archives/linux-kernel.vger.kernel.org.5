Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B617F9B66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjK0INK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjK0INH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:13:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22503136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:13:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F7BC433C7;
        Mon, 27 Nov 2023 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701072790;
        bh=jdApDdp5fys2vmxXQeWrknDBds70DchNIYMmgGQiSmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arUeWjhhaXTIyqScRkphKIC+XgOr5v/R9e9FLSNERvhxALI6UDy5a8u/yUznOhxn8
         O/ZT5lxDW/iYsSuPnqGJt0nJvgV1AG9l9IHMcUkhg1QrLwyDw8W4AxHkxvEBobWZ5M
         Ylvv5ac9l1eT1xxmYmKJoeKFyYMQ1bmHujkJjQyNR/4dnzCfWNz8OQ/FcYRFLRJRt8
         v48/FfXdspUqZvxSo4uBLwmuqudrRQfGwXJ87g+42HIeQwjOmv6qPO/4n11vDRAQGG
         0VsFtsmsNnrBHpOaEowODs+sGbYp3+VZNvFP/0Oagugw9NX2hIxlA49rPLyFlQNSaa
         mJ54Yd+9Tf4dQ==
Date:   Mon, 27 Nov 2023 08:13:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Pavel Machek <pavel@ucw.cz>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <20231127081305.GB1470173@google.com>
References: <3655d56c08b60f0ce562ceab3a627fef046a7617.1701029732.git.daniel@makrotopia.org>
 <4bade634-f2f7-4bfc-b882-67cfe9e47b8f@lunn.ch>
 <ZWPCdHBt_g4-5ArV@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWPCdHBt_g4-5ArV@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023, Daniel Golle wrote:

> Hi Andrew,
> 
> On Sun, Nov 26, 2023 at 10:04:22PM +0100, Andrew Lunn wrote:
> > On Sun, Nov 26, 2023 at 08:17:03PM +0000, Daniel Golle wrote:
> > > Add 2.5G, 5G and 10G as available speeds to the netdev LED trigger.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > One thing to consider is how this get merged. I assume you will have a
> > PHY driver patch soon making use of this?
> 
> Yes, exactly. I'm working on adding support for LEDs to MaxLinear and
> RealTek PHY drivers.
> 
> > We can either:
> > 
> > 1) Get Lee to merge it into the LED tree and then create a stable
> > branch which gets pulled into netdev.

I'll create an immutable branch.

> > 2) Merge into netdev, with Lees Acked-by: 
> > 
> > It seems unlikely there will be any merge conflicts. So netdev does
> > seem like an O.K. way to go.
> 
> Via netdev (net-next) would be better imho as it would allow to add
> changes to PHY drivers making use of the new constants without having
> to wait for LED tree being merged.

The former solution does not prevent this.

> Note that I've sent v2 which adds missing use of sysfs attributes.

-- 
Lee Jones [李琼斯]

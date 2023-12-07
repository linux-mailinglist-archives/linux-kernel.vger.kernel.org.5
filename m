Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A13808DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjLGQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:29:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E112D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:29:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CCC433C8;
        Thu,  7 Dec 2023 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701966569;
        bh=bIk2zEVd/ALsJPnzNnUpGKKfoLp6VvygCrV4NUYPhF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kvy7Py4VdNM01E7IR4ovzeKQYpJ0CpAazXTFaU0+LlVFKhJa+fOJ+SFDiL/ULejgO
         2a5yJX24skY1woXVm/qciCgYVfOhQ7XZVDfofDm1keqA24gzRdTFcIq5bCD1zpo+zL
         3J3+jl4KtUNGxwcCyvlIi2uDQO30qCIAzmZ3yPIAk79b4C0pQFXDIGobLi91soZFdk
         VI8UrLKkxWPg6xAiXnDHMJr5vKHz/UhUdK3vTdGzf60uaIF71i6opKBnOID0xPtRso
         3fV62ZIpqTJJJ8XReBK281wn/fb5SECPg8LwO5AwCqIWNjLGGHF2n6LX2SSqakGs5t
         hkm6fT1RVh3Aw==
Date:   Thu, 7 Dec 2023 17:29:23 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <20231207172923.62ce530e@dellmb>
In-Reply-To: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 04:00:10 +0000
Daniel Golle <daniel@makrotopia.org> wrote:

> Add 2.5G, 5G and 10G as available speeds to the netdev LED trigger.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

So what will happen when there are more speeds? Will we create a
separate file for each speed?

Will we have a separate sysfs file for 10, 100, 1000, 2500, 5000,
10000, 20000, 25000, 40000, 50000, 56000, 100000, 200000, 400000,
800000 ?

These are all speeds from include/uapi/linux/ethtool.h.

Maybe we should have reused ethtool link mode bits, or something...

Also, the files should only be present if the requested speed is
supported by the net device. So if 2500 mbps is not supported, there
should no be link_2500.

Marek

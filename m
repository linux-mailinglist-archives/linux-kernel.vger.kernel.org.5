Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B4808DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjLGQbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjLGQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:30:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F3128
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:30:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B75C433C7;
        Thu,  7 Dec 2023 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701966649;
        bh=lQQtU4tYIZ245AplOqW4Zvwsb+ueZMLoO44f/yIejSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MQ3seVR2dDL05UbmXkM8yxg6e/AANgmppkO7hfPNFLUIdFsiYjzsCeI65h+EvTxLj
         Om4vuRDd/nQ/f6aLxNLSTfjwWYSS2d49NsLLenTvKxmNk5jxCHM/NUlwTHeTtyMnSI
         KD5sYHsw+MhiJy0A3SoYvqTc3ozluoevgqeE5fJ4JjLaex8eDlQDrKiI7QcmJ6FsB6
         hRpvkwM09R8KczL+U6lOwyVG3sKl+zJqNURvGVlaU05ZR2yBZWyJtvWyJNYJQUElcD
         Z8o4PWSZ+Ll2b9hUWYZaO1Nfx8FKbU1vY46+FLH+jFE4VlRNAj9rv5xVOZfeSwn/40
         XL2eSZRLbwpJQ==
Date:   Thu, 7 Dec 2023 17:30:44 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 2/2] docs: ABI: sysfs-class-led-trigger-netdev: add
 new modes and entry
Message-ID: <20231207173044.67ec3c9d@dellmb>
In-Reply-To: <e72a6794639cf3881d698e1d34b456e747da1b95.1701143925.git.daniel@makrotopia.org>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
        <e72a6794639cf3881d698e1d34b456e747da1b95.1701143925.git.daniel@makrotopia.org>
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

On Tue, 28 Nov 2023 04:00:39 +0000
Daniel Golle <daniel@makrotopia.org> wrote:

> Document newly introduced modes for the LED netdev trigger.
> 
> Add documentation for new modes:
> - link_2500
> - link_5000
> - link_10000
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: include this documentation patch as well
> 
>  .../testing/sysfs-class-led-trigger-netdev    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
> index f6d9d72ce77b7..a6c307c4befa0 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
> @@ -114,6 +114,45 @@ Description:
>  		speed of 1000Mbps of the named network device.
>  		Setting this value also immediately changes the LED state.
>  
> +What:		/sys/class/leds/<led>/link_2500
> +Date:		Nov 2023
> +KernelVersion:	6.8
> +Contact:	linux-leds@vger.kernel.org
> +Description:
> +		Signal the link speed state of 2500Mbps of the named network device.

Should this file be present even if the network device does not support
that speed?

Marek

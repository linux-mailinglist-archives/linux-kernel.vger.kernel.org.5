Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E3750EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGLQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGLQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A4106;
        Wed, 12 Jul 2023 09:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF7D6182F;
        Wed, 12 Jul 2023 16:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717BEC433C9;
        Wed, 12 Jul 2023 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689179965;
        bh=k8GGEKyGtTizvlzKcz2cYIOJibPG0QzEDyGItCmD5oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqVy6+MBRaLQ+CT6RhF906zPEzT8zIKMMLX/+a9OvH90uVauwYkj+cLy4okFWihWG
         fSrphTswhdn1M5Q3GYr38bF0CjKCeKjqDs4mwsDtFG+bPbdVwVFGh6p1KgvFxqRf7u
         6eudH1Atx5XQEDROI32UWKIrCV4dA7JTEhxk+6T4=
Date:   Wed, 12 Jul 2023 18:39:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Message-ID: <2023071222-asleep-vacancy-4cfa@gregkh>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr>
 <ZKM5nbDnKnFZLOlY@rivendell>
 <2023070430-fragment-remember-2fdd@gregkh>
 <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
 <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:00:55PM +0200, Johannes Berg wrote:
> On Wed, 2023-07-12 at 11:22 +0200, Oliver Neukum wrote:
> > 
> > On 04.07.23 08:47, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
> > > > Hi all!!
> > > > 
> > > > I think the rndis_host USB driver might emit a warning in the dmesg, but disabling the driver wouldn't be a good idea.
> > > > The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated in routers do use this protocol.
> > > > 
> > > > We may also distinguish between these cases and devices you might plug in - as they pose different risk levels.
> > > 
> > > Again, you have to fully trust the other side of an RNDIS connection,
> > > any hints on how to have the kernel determine that?
> 
> > it is a network protocol. So this statement is kind of odd.
> > Are you saying that there are RNDIS messages that cannot be verified
> > for some reason, that still cannot be disclosed?
> 
> Agree, it's also just a USB device, so no special trickery with DMA,
> shared buffers, etc.
> 
> I mean, yeah, the RNDIS code is really old and almost certainly has a
> severe lack of input validation, but that still doesn't mean it's
> fundamentally impossible.

You all are going to make me have to write some exploits aren't you...

Ok, I'll put it on my todo list and do it before submitting this patch
again.

thanks,

greg k-h

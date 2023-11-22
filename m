Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBE17F4872
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbjKVOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343965AbjKVOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:02:54 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B702101;
        Wed, 22 Nov 2023 06:02:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A49C20011;
        Wed, 22 Nov 2023 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700661769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWBqSZ0d2/YYtI3gI0JVxUXQAtOv2ZHu2s8DSzjbYUI=;
        b=hXUBjRkC+zbu4gxz3FlLfskV2M9hDWhTvgbmgp50mfxfNrhQDvRlYkr+OiW5l0/723GtXS
        FEyKOthGV8afYUqry2TW3eGXoj8CU1IMixeno1gM7TldbmwB+QSix7NKAZVMGhuL+0i4x2
        rJQP01jVfEDSYgEHzm1bmgQe6vaYi6nGOO6r3bzp6OGteGB4Rrvblh8m8J4oXNdlua+fJR
        RWrSFGZaXBLEAeYnQWVbe0tNlalWRR3WphnOJWtJENXKZE7/eU+n6fiFebwwJdrb237IQW
        2fhWtssuFA5T7sYgaK4xORm5Bp1yZZJOj3isGKsnICAJHTdUBSrW+dnOSV0BWA==
Date:   Wed, 22 Nov 2023 15:02:47 +0100
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Tommaso Merciai <tomm.merciai@gmail.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <ZV4KB7/TO66if41o@pc-70.home>
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
 <ZVz58b0r4gtxyVQy@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <9570dc1c-a437-46d4-95e7-1f3dd399e458@wolfvision.net>
 <ZV3_xe6A0v7kKgmo@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV3_xe6A0v7kKgmo@aptenodytes>
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

> > >>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
> > >>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
> > >>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
> > >>  create mode 100644 drivers/media/platform/rockchip/cif/capture.h
> > >>  create mode 100644 drivers/media/platform/rockchip/cif/common.h
> > >>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
> > >>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
> > > 
> > > Just a logigistic comment on my side for now, sorry :)
> > > What about use cif-* prefix in front of driver files?
> > > 
> > > like:
> > > 
> > > cif-capture.c
> > > cif-capture.h
> > > cif-common.h
> > > cif-dev.c
> > > cif-regs.h
> > 
> > What would be the rationale here?
> > 
> > IMHO the files are in a folder named cif, so adding this prefix seems
> > kind of redundant.
> > 
> > That said, if there is a good reason I could live with cif-*.{c,h} as
> > well, of course. My only request would be to agree on something ASAP.
> 
> It's rather common to do that in Linux and one advantage is that it makes it
> clear in your text editor which driver you are looking at when only the file
> name is shown.
> 
> I don't have any strong opinion on this either though.

I see that the majority of the drivers are named like suggested. I will
change the names in the V12.

--
Kind Regards
Mehdi Djait

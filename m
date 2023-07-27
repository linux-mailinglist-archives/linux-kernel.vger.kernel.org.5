Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D191765E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjG0VYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjG0VYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:24:24 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB53A8C;
        Thu, 27 Jul 2023 14:24:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91CBF1C0005;
        Thu, 27 Jul 2023 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690493045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORG5dgngYFtAHPnQ7QoUeAEsgIr39oZ6NJsu8Dq7mTE=;
        b=JfdcVMrkwF8LPNEFSZlrmHDMYc44jjXYx8n4Dkili5JJjEx6z1mK2kDcn/SC17urFbpDVD
        vtGurY2uGg9NmQub4ZHVnhkxmFQPibHcVsjj2Z0a+qkm/XhXB+RdQmiksZoL/PIxKGgzDG
        muG1X1bTY1s+y3MiZh2kN2l9smQtNJKaSppuSTbWR5TUBvb986xYoAdbU9frWHB96oQghO
        GWjAtCkt4cduhkJ3+KwexJpPHPoEAAjaIyLXEsoGiIsKnipakulHwyl06kRABQGOw8F8yf
        SiGKuc73yWop4E94rjQNfOKYbJf90Go5cPKtPmp54IPyhFrIFspJibmB7s9tXw==
Date:   Thu, 27 Jul 2023 23:24:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        =?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: Explicitly include correct DT includes
Message-ID: <169049302660.636147.12256189755653244870.b4-ty@bootlin.com>
References: <20230714174623.4057784-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174623.4057784-1-robh@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 11:46:23 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] i3c: Explicitly include correct DT includes
      commit: 574ca75f8d2935053872aa1b15d8ba24bfb5e51c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

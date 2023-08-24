Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0977786FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbjHXNI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbjHXNIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE91988;
        Thu, 24 Aug 2023 06:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FCB263FF3;
        Thu, 24 Aug 2023 13:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294F8C433C8;
        Thu, 24 Aug 2023 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692882516;
        bh=tVE1QYOXv6IpCCh+hH800wxS4nGPdh//Y3mgj0IDueU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2DGqBgSMvbtNuu+cWBZM5UgH/OgvS6+0B1hBEnP2KZETszBm8ZtMJU5Pz/gLGIlk
         Tqn815A4fxSu65k0ftGzVK+nexTf8NWMNUwpw/GPKEp0UT3XeahzmMSZgno+yUolK0
         uV54E+0PQK5/PQqmwkhNMr4ZU7TqX/au1w7iEUPs=
Date:   Thu, 24 Aug 2023 15:08:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
Subject: Re: [PATCH v8 0/8] Add StarFive Camera Subsystem driver
Message-ID: <2023082416-flanking-requisite-a8ed@gregkh>
References: <20230824080109.89613-1-jack.zhu@starfivetech.com>
 <2023082436-spendable-reshuffle-878d@gregkh>
 <a6f60dfc-ffbf-da4d-a81c-06caf92955d6@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f60dfc-ffbf-da4d-a81c-06caf92955d6@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:23:33PM +0800, Jack Zhu wrote:
> Hi Greg,
> 
> On 2023/8/24 19:37, Greg Kroah-Hartman wrote:
> > On Thu, Aug 24, 2023 at 04:01:01PM +0800, Jack Zhu wrote:
> >> Hi,
> >> 
> >> This series is the v8 series that attempts to support the Camera Subsystem
> >> found on StarFive JH7110 SoC.
> > 
> > I don't see anything here about why this is in drivers/staging/media/
> > now and not just in drivers/media/.  What is preventing this to be put
> > into the correct place to start with?  What needs to be done to the code
> > to get it out of drivers/staging/media/ and who is going to do that
> > work?
> > 
> 
> The series does not contain 3A interface. According to Laurent's suggestion,
> we put the driver in the staging directory first. In the next stage, we will
> continue to submit the 3A interface in the way of incremental development,
> and finally expect the code to be placed in the drivers/media/.

Can you please say that in the changelog text for when you are adding
the driver so that we know this?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62ED77143E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 11:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHFJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 05:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8A19A2;
        Sun,  6 Aug 2023 02:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC89860FF5;
        Sun,  6 Aug 2023 09:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1999C433C7;
        Sun,  6 Aug 2023 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691315528;
        bh=iLg14PgiXyDCt6R+keTK1cRDsoDH3Jk4ky5vKqUz6IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAuLlUlydksVby4Nqk2chMwgIQ65H9ADuyGu4FUDkjLgUzbKR8sSeWBWSiU68No4w
         y5F5Mx6wxYHvm1oWTHdEUv1a/OUr8pvHzUU6qAcKTcvpIl4Qb9LJ9qSCqzCVCG2GbJ
         hGCfjvMbX4JvTZWvc1OAivfd4cZC6a4lns21Y+pHFgJussdpTQJ+KAqKxipTS2uOuE
         FvLFNt0k3v5vUkKUT14eQ7Pr4pNYgRm3ypDpgJNCrMtOKzcb4xYXuZhnq/05H7bi1m
         qJS5iysYagDVYYRc1XcSlCRPE59ajnBQLcu4k8y4+PEnH8P08xWq1a3blm7DqUQe24
         zRpJ3jqDmU6iA==
Date:   Sun, 6 Aug 2023 17:40:27 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: make
 interrupt optional
Message-ID: <ZM9qi6VYo1qaBhoI@xhacker>
References: <20230802150545.3742-1-jszhang@kernel.org>
 <20230802150545.3742-2-jszhang@kernel.org>
 <20230802-halogen-bungee-63273b2c456c@spud>
 <ZMrRWP5mK+nksn4M@smile.fi.intel.com>
 <20230802-risk-getting-e6005e86be81@spud>
 <ZMuSFYQ4YyIKnI0k@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMuSFYQ4YyIKnI0k@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:40:05PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 02, 2023 at 11:53:59PM +0100, Conor Dooley wrote:
> > On Thu, Aug 03, 2023 at 12:57:44AM +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 02, 2023 at 04:43:48PM +0100, Conor Dooley wrote:
> > > > On Wed, Aug 02, 2023 at 11:05:44PM +0800, Jisheng Zhang wrote:
> > > > > The driver fall back to poll style when there's no irq. "poll" still
> > > > > looks better than no support.
> > > > 
> > > > What is the user for this where the interrupt is not actually wired up
> > > > in the hardware?
> > > 
> > > FYI: kernel console doesn't use interrupts, so for example it might be
> > > the debug port. Note, I have no idea of the Zhang's case, just my assumption.

Hi Conor, Andy,

Andy's assumption about the uart dedicated for debug purpose is true, since
it's for log only, so no interrupt need at all. We can also see such no
irq support in litex uart driver(liteuart.c) and even a 8250
variant(8250_ioc3.c).

Thanks
> > 
> > I'm less interested in what the software is doing, it's what the device 
> > that has not connected the interrupt is that I am curious about.
> 
> As I said. The hw may be purely for debugging purposes (and yes, I have heard
> about such a hardware).
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

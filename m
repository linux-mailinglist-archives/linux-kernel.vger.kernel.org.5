Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC27BA344
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjJEPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjJEPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3908C27;
        Thu,  5 Oct 2023 07:16:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3ACC43140;
        Thu,  5 Oct 2023 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515395;
        bh=nNp35xI077yQXxP8uX1fwQCGUbyzwbzHw+RybI+zhrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fz60a5EalsIPlI5xmAewZKSyJP5mY4XoFeQDpBsnmgL9e7G3G8SljF26stQkNdgNS
         HILBXuyxFF8L90iDCJZAHTiMcIsmnVR6DjcB3jDHb4St7B8foBOfQcLv0hFXxLjJg3
         7IpJA8Pukze6X5P3okmQPKniObWAkfUBWBtgAu1PNSga3fZg0+qfhgqxv8lsOWXTR4
         bmcI1hsszsN8RyCCYkOwQOZGLqYfdfa8dJYOaml+R1cz5vw2z5j1xlbX6ZC1U78mnM
         cZjyEBd9R9bJgTvrWr03+hGL1ZngMpOrph7iiQMnoluZB8btSQNcR6VeVuuAwgeHMn
         Y2JAy24wGJspg==
Date:   Thu, 5 Oct 2023 07:16:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] net: cpmac: remove driver to prepare
 for platform removal
Message-ID: <20231005071634.581fa8c2@kernel.org>
In-Reply-To: <ZR7Dd8wy91+G2U3v@alpha.franken.de>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
        <20230922061530.3121-6-wsa+renesas@sang-engineering.com>
        <ZR7Dd8wy91+G2U3v@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 16:08:55 +0200 Thomas Bogendoerfer wrote:
> On Fri, Sep 22, 2023 at 08:15:26AM +0200, Wolfram Sang wrote:
> > AR7 is going to be removed from the Kernel, so remove its networking
> > support in form of the cpmac driver. This allows us to remove the
> > platform because this driver includes a platform specific header.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Changes since v1:
> > * added ack
> > 
> >  MAINTAINERS                      |    6 -
> >  drivers/net/ethernet/ti/Kconfig  |    9 +-
> >  drivers/net/ethernet/ti/Makefile |    1 -
> >  drivers/net/ethernet/ti/cpmac.c  | 1251 ------------------------------
> >  4 files changed, 1 insertion(+), 1266 deletions(-)
> >  delete mode 100644 drivers/net/ethernet/ti/cpmac.c
> > [..]  
> 
> is it ok for network people to route this patch via mips-next tree
> or do you want to apply to net-next ?

We have a ".remove callback should return void" conversion from Uwe
queued for the deleted driver (231ea972ccaf5b). The conflict will be
really trivial, but I guess no conflict beats trivial conflict so better
if we take it? :S

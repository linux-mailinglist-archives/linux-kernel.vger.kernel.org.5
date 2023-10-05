Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE627BA30E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjJEPvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjJEPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:54 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 170E664D74;
        Thu,  5 Oct 2023 07:09:08 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qoP2H-0000yp-00; Thu, 05 Oct 2023 16:09:05 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 836FEC0148; Thu,  5 Oct 2023 16:08:55 +0200 (CEST)
Date:   Thu, 5 Oct 2023 16:08:55 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] net: cpmac: remove driver to prepare for
 platform removal
Message-ID: <ZR7Dd8wy91+G2U3v@alpha.franken.de>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922061530.3121-6-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 08:15:26AM +0200, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its networking
> support in form of the cpmac driver. This allows us to remove the
> platform because this driver includes a platform specific header.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes since v1:
> * added ack
> 
>  MAINTAINERS                      |    6 -
>  drivers/net/ethernet/ti/Kconfig  |    9 +-
>  drivers/net/ethernet/ti/Makefile |    1 -
>  drivers/net/ethernet/ti/cpmac.c  | 1251 ------------------------------
>  4 files changed, 1 insertion(+), 1266 deletions(-)
>  delete mode 100644 drivers/net/ethernet/ti/cpmac.c
> [..]

is it ok for network people to route this patch via mips-next tree
or do you want to apply to net-next ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78D79D4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjILPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjILPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:20:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFF10D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:20:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733CCC433C8;
        Tue, 12 Sep 2023 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694532036;
        bh=CyzBP67+/V5pqHwJ0uKs92bHtbAg4F+shcqqbAJgXWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGnWVRXtlWgAILYsdIav3nXuMmQ+VX5b/GUXFPNWmwltMafQ7hkSF2ZFlvLYqUHcp
         anRxuLJA5ikIr21kILDE9SXrAwtQHeIiQh5zeNeNcpAfipCWABZEfz1t/dreihyzI+
         jmOGyYGbWwM79H3Wnarn26MYUkreBqZxqdoNXKo7xQx4uCHiN+oZNYc0ODEdRpOu8D
         74sA2R/+EGR1LCF3Qv5kT6n2fbtNQn6wM8DBTn1ZaQUsPPgHzbefAd8OkrsqX6GOjd
         M8s5IsR1v7Y/7cnCDKQOFTasA5JDDOjBOIYE2SXBOsKXBY42ik1KEpDPl8h0yCOkEV
         Fx94Pgfv6JtDw==
Date:   Tue, 12 Sep 2023 17:20:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Message-ID: <20230912152031.GI401982@kernel.org>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> It's rather a gigantic list of heards that is very hard to follow.
> Sorting helps to see what's already included and what's not.
> It improves a maintainability in a long term.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

At the risk of bike shedding, the sort function of Vim, when operating
with the C locale, gives a slightly different order, as experssed by
this incremental diff.

I have no objections to your oder, but I'm slightly curious as
to how it came about.

diff --git a/net/core/dev.c b/net/core/dev.c
index d795a6c5a591..770138babf7e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -92,9 +92,9 @@
 #include <linux/if_ether.h>
 #include <linux/if_macvlan.h>
 #include <linux/if_vlan.h>
+#include <linux/in.h>
 #include <linux/indirect_call_wrapper.h>
 #include <linux/inetdevice.h>
-#include <linux/in.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ip.h>
@@ -105,9 +105,9 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/net_namespace.h>
 #include <linux/netdevice.h>
 #include <linux/netfilter_netdev.h>
-#include <linux/net_namespace.h>
 #include <linux/netpoll.h>
 #include <linux/once_lite.h>
 #include <linux/pm_runtime.h>
@@ -142,8 +142,8 @@
 #include <net/ip.h>
 #include <net/iw_handler.h>
 #include <net/mpls.h>
-#include <net/netdev_rx_queue.h>
 #include <net/net_namespace.h>
+#include <net/netdev_rx_queue.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/sock.h>

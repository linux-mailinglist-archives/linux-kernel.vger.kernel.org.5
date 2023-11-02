Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678657DEBF5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348449AbjKBEmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBEmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:42:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10501E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:42:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041E7C433C7;
        Thu,  2 Nov 2023 04:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698900145;
        bh=SdcnFgAMPvml22ndDL1ro8QzzwIFpE/APZHZjpE2mRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CPPnrpyuFEFaOf1GOL8iEw0u6PiEQANR5D6CaAlBZZiblAg86Bkv7NyNPk/pYYP+u
         bMMfuQGmHKwXEKlPVFI7l0VuxfKWssy0TPvbACTc1MjQhym2ohDd/ZMJeXWxkO+MZb
         UiGz6PeGPZKW98WsPinIimfOLgsG7rSd3UDEre1boI0q+2QyfMAA1FzIVytw1JQZcq
         HOYZpBl2jwBj+uaVU3z+UF4XnZj6wj3BKnN1ZHfQAqIU/7ppvxiulbnZmP+50DltZU
         CVPogkwr1nzn4hrWxJuXODrAv6psKv1jlMHrOBFeMHZdQhHBDlfglUR6JMgNJcQABh
         Rxx+rt8ymrMHA==
Date:   Wed, 1 Nov 2023 21:42:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
        <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next v2 PATCH] octeontx2-pf: TC flower offload support for
 ICMP type and code
Message-ID: <20231101214223.0de10cdb@kernel.org>
In-Reply-To: <20231031165258.30002-1-gakula@marvell.com>
References: <20231031165258.30002-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 22:22:58 +0530 Geetha sowjanya wrote:
> Adds tc offload support for matching on ICMP type and code.
> 
> Example usage:
> To enable adding tc ingress rules
>         tc qdisc add dev eth0 ingress
> 
> TC rule drop the ICMP echo reply:
>         tc filter add dev eth0 protocol ip parent ffff: \
>         flower ip_proto icmp type 8 code 0 skip_sw action drop
> 
> TC rule to drop ICMPv6 echo reply:
>         tc filter add dev eth0 protocol ipv6 parent ffff: flower \
>         indev eth0 ip_proto icmpv6 type 128 code 0 action drop

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


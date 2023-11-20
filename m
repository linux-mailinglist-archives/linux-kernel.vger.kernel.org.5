Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7B7F0EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjKTJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTJYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:24:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9FBA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:24:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F54C433C8;
        Mon, 20 Nov 2023 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700472258;
        bh=fxoh0pL86/4smqTnSz9uKd5qu4zvJ+xr/Q1R84vNLWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgTshboGGQ6fGpXAFrlgRaNE1lTG+TrNz3ovLNYYeMS21Fxm0FZwEFNl9JGdU16l5
         B/Yn1RZQYHpZaEua2Vcpivx0aV51hisexo/ZHwUqFLAkpsXTu5hpB6+F6KPv7isr5p
         VYzMdFLpl+DJsgOhutSTecygoVI0SQgDNHP6mWWGPUl2+qo7khZddxw9gaqLTiPdpA
         /rnSIUKz/izvwehsN7/iBifoZ8EnW7b20A05qWfoxopWZuimCswm3tBzg0gruONpW+
         +rZjUxE65Xpt1ibUi5sWqSp0vXCU6tQb3PiUQ0yfRNuBy05VmHNdes/XHQF8xAKQLO
         XuNu7iMG321yQ==
Date:   Mon, 20 Nov 2023 09:24:14 +0000
From:   Simon Horman <horms@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] indirect_call_wrapper: Fix typo in
 INDIRECT_CALL_$NR kerneldoc
Message-ID: <20231120092414.GJ186930@vergenet.net>
References: <20231114104202.4680-1-tklauser@distanz.ch>
 <20231115175626.GW74656@kernel.org>
 <20231116010310.4664dd38@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116010310.4664dd38@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 01:03:10AM -0500, Jakub Kicinski wrote:
> On Wed, 15 Nov 2023 17:56:26 +0000 Simon Horman wrote:
> > To the netdev maintainers: get_maintainer.pl doesn't seem to
> > know much about include/linux/indirect_call_wrapper.h.
> > Should that be fixed?
> 
> I'm curious how many of such files exist under include/linux.
> Files which are not really networking specific but only tree
> the changes ever went thru is netdev.. 
> But yes, in the interest of "taking responsibility" we should
> probably claim it.

Thanks, patch sent.

Link: https://lore.kernel.org/netdev/20231120-indirect_call_wrapper-maintainer-v1-1-0a6bb1f7363e@kernel.org/

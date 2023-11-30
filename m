Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6BE7FFD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376808AbjK3VEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjK3VEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:04:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201D93
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:04:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A43C433C8;
        Thu, 30 Nov 2023 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701378282;
        bh=lqzEStZR0L5lwWNPbnwIia8GbV3FVO0c24b7gkUIOQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OY00rGQg65nix2pUBaTEtqsZ9WNsqsURFuEyte3ukcKkfiF9Yp7gCYAidbvKJglkb
         HZWBKljsJ7JxV1s3uBODYRBSN+bTC0ZiYiHwfaNcjl3OuFZ4PPgnqaZetnyiDXXGsZ
         g0nWhbdF6A2reE4hF69pC1xOn2svr2G/w6LudWoOGeauXSiB6NRHsVfyF3C4+cK4Aw
         USi4zlOY9oXOfgafC+9pEgLlVgmEV7uZOX8Mfql9zLRMXst0ZU+Z++UWaGmp6gMs5t
         FxI8IfjzyX1MD0tPWDoWcWx5xeIeAVVhytg62VIP1BtGaAE3/ATAdE6XzrzuE2G0Qn
         48C1dxb+QFFkA==
Date:   Thu, 30 Nov 2023 21:04:38 +0000
From:   Simon Horman <horms@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of
 the copy of a definition
Message-ID: <20231130210438.GP32077@kernel.org>
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
 <20231130210339.GO32077@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130210339.GO32077@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:03:44PM +0000, Simon Horman wrote:
> On Tue, Nov 28, 2023 at 07:48:13PM +0200, Andy Shevchenko wrote:
> > BYTES_PER_KBIT is defined in units.h, use that definition.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Did you consider a patch to update sja1105_main.c?
> It also seems to have a copy of BYTES_PER_KBIT.

I now see that you did :)

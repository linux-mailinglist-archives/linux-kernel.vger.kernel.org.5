Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373F7FFD39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376802AbjK3VDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:03:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C2610D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:03:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC6CC433C8;
        Thu, 30 Nov 2023 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701378224;
        bh=FYzHZid8c6XjOdWhWeelNMtPY06u1fDsv1tVwwjawik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1L/ZKxQBxggZ1qM08BUUtRelszOqyMXNJmbam8Q8Mb8j20Ew95ekcQIiG/hILJmR
         vfmIOtmsqH25UYsaPurgvyNYnbykydjTh0f7YUutOD4aZOhTpsGhugKtT8wDsO+xXB
         4cIMjauEYUUAzFJsjdURx7JQUopvUhIYEsPY+26pM/McIXwOUhmxnpa4yGOFi3eNmO
         4Z6sVfC9E+xmK6e4lHxFrpjVsHptoNuTdO1fmOYFsmauyO3UFAEPdkITCTzM85udu8
         BYm+hiDbWyCL/yS/PghlhUfyGIK0iF8ezT8fGj1S5wPMe53ir25uh1YyeIp4dGMowx
         qpyyekmJ1DbXw==
Date:   Thu, 30 Nov 2023 21:03:39 +0000
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
Message-ID: <20231130210339.GO32077@kernel.org>
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 07:48:13PM +0200, Andy Shevchenko wrote:
> BYTES_PER_KBIT is defined in units.h, use that definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

Did you consider a patch to update sja1105_main.c?
It also seems to have a copy of BYTES_PER_KBIT.

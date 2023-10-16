Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83117CA150
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjJPIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71611A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15412C433C9;
        Mon, 16 Oct 2023 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697443824;
        bh=hy4665Tqe22tAQwJ1oDqGVuhQuSrzBC3ikTfqc6HLNs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pGwqhzULeQMXsBvaVnHU2f8rFjpE+3M9u4I/7pbWJZVuMjYcjtOW9g+g2O7401cC1
         WjrQj4cW+4VvX/ngms2S3QsNT5Qhe/Shm3zDJTOmAb5uOv5mFn2l2Kh5sbL2PSEeAz
         X+Uc8k0zgc3KW4uzO2qdWqpIwpIP/DN/kvAV4fhO9v1biUiPhw9RO3+xeZP7UistA5
         o0p4cHfCdwDf8UtS3I/4FAhNKO9QMQ1MZiy1tvHogg6g8bFgCLnx5YbT/3mbIjdbUn
         MFStZpw9ih9EG0WpVCNkTHj+Q7jYoY9sTKPsoNzXiJQymAk5/WWmMTUH8hl6JR7tjt
         lmdfK014RJJAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0F2CE4E9B5;
        Mon, 16 Oct 2023 08:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: cxgb3: simplify logic for rspq_check_napi
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169744382398.7812.17747534311837223482.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 08:10:23 +0000
References: <20231012091429.2048-1-ansuelsmth@gmail.com>
In-Reply-To: <20231012091429.2048-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 12 Oct 2023 11:14:29 +0200 you wrote:
> Simplify logic for rspq_check_napi.
> Drop redundant and wrong napi_is_scheduled call as it's not race free
> and directly use the output of napi_schedule to understand if a napi is
> pending or not.
> 
> rspq_check_napi main logic is to check if is_new_response is true and
> check if a napi is not scheduled. The result of this function is then
> used to detect if we are missing some interrupt and act on top of
> this... With this knowing, we can rework and simplify the logic and make
> it less problematic with testing an internal bit for napi.
> 
> [...]

Here is the summary with links:
  - [net-next] net: cxgb3: simplify logic for rspq_check_napi
    https://git.kernel.org/netdev/net-next/c/101c6032031f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



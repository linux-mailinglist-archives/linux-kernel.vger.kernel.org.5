Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6276454A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjG0FKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjG0FKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2261985
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBBDC61D41
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25F21C433C8;
        Thu, 27 Jul 2023 05:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690434621;
        bh=BE1Xq1IRKwkqNNFUXpjvkjz1bngrVlNgq7E+8RUPC14=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aT76/NS7jhAUJXxa66Ab+w+JqyN95LpT+3VOCNC+Hhvi69XRUb0INtERhVVZcWcJ7
         IFpPN2kYb9yuiNZopzshJz5DyrNkutxyLUKbTQGCvBVQAO3PIFSJEd8TKV9tD4aPSw
         0LltPyn6efHqlETDxj8/tr6UO2aX9+pINer31B/kpijXEXPoYLMRGdzLQs5pDxaTf+
         lE08j9V6GQwpfAeV5Lhrm+1w0+KJmp9DDkvWAo3p1QlG5OVarVIPc2HZiLfI12VEDT
         kSEWTaQhkDMC5GlrIRyS4Pq/VujFYraju1v8v+J/Szz5g9p0qCqCJIWMf9cGMiwjhd
         tNuNxaxRYnp3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CDEBC59A4C;
        Thu, 27 Jul 2023 05:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043462104.30073.7457238060155028542.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 05:10:21 +0000
References: <20230725024227.426561-1-linma@zju.edu.cn>
In-Reply-To: <20230725024227.426561-1-linma@zju.edu.cn>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, amritha.nambiar@intel.com,
        jeffrey.t.kirsher@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 10:42:27 +0800 you wrote:
> The nla_for_each_nested parsing in function mqprio_parse_nlattr() does
> not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as 8 byte integer and passed to priv->max_rate/min_rate.
> 
> This patch adds the check based on nla_len() when check the nla_type(),
> which ensures that the length of these two attribute must equals
> sizeof(u64).
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64
    https://git.kernel.org/netdev/net/c/6c58c8816abb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



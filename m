Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43D280AD38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjLHTkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:40:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D84A1729
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29601C433C9;
        Fri,  8 Dec 2023 19:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702064424;
        bh=svnHpPC/9E4At2WtpKG5ZuXyHxnRjwD9asqsLDvt+68=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qB/y6gu9T+Q7DVG1z19vhZ2bTRlspJpAkukXKdP3NmD2KBTI0USAnjq/eN5gkdD4I
         kHnwHzxTauv1BFv6+XYRMbDkWMjMGfsuVeG3juqWBnEtecndaNW99ZypdhALg6N267
         rJ/5Fl2H7DKq6kTEocd8k7vzwU+Y6bXmBtjRD6rf9datgGYT79COtSDDkXSq7wSSLt
         pDs0d7Q9CdWfLt9SUQkVB6XR8cJUYM+skdGT9MRr2SPIs59mtodyi8Wm399LDBOHoE
         uV/5NuQO65n2+eNc49VomykyLVPwkXg4LP4e0aNRgDWPiWtGAudR4gFLA3/m9gufB8
         uhV/A9gj+ahtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1186BC04E24;
        Fri,  8 Dec 2023 19:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] netlink: Return unsigned value for nla_len()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170206442406.2842.16381176213819730158.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Dec 2023 19:40:24 +0000
References: <20231206205904.make.018-kees@kernel.org>
In-Reply-To: <20231206205904.make.018-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kuba@kernel.org, lkp@intel.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, johannes@sipsolutions.net,
        quic_jjohnson@quicinc.com, mwalle@kernel.org,
        max.schulze@online.de, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 12:59:07 -0800 you wrote:
> The return value from nla_len() is never expected to be negative, and can
> never be more than struct nlattr::nla_len (a u16). Adjust the prototype
> on the function. This will let GCC's value range optimization passes
> know that the return can never be negative, and can never be larger than
> u16. As recently discussed[1], this silences the following warning in
> GCC 12+:
> 
> [...]

Here is the summary with links:
  - [v3] netlink: Return unsigned value for nla_len()
    https://git.kernel.org/netdev/net-next/c/172db56d90d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



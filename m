Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24B80F997
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377367AbjLLVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377185AbjLLVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:40:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D2B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:40:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB30C433C9;
        Tue, 12 Dec 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702417223;
        bh=W+a8QMxDJQ/wYzGPICirRFBKNDviDAgz3f9h+vYPOVs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ahltqe3GMajhJjOwZIMS9LnC1dVNv/CJeMj99NUsY5zFpeify4fEmCnVLrIz/WA5B
         ilQQlRw/Xe8TI7WdIfHPQYAKP5rdzG8CH8Zs18AMs8DUMhnrS4bnzK+axx0d6JHBsg
         u58Ih445lqMrBnj0Szjl72+txqphW594iZ6/u52lwWhtBpbgUt+Qyvc8k4FABBpyFv
         CXS4fb2E4v6QkfsegyCYmh82PA9InOlT21aui99zGZZvOuamjqgVV1qMW+AvYcOYaF
         iT47kGgYTzp4wxgJ0uhnno41Ypl/RSfVshxtyu47MgRsXCMNlD7MjJWpcWcqF820pc
         q9eHw4EFsAN6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 233A6DD4EFE;
        Tue, 12 Dec 2023 21:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v3] qed: Fix a potential use-after-free in
 qed_cxt_tables_alloc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170241722314.18097.10660076112019451693.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Dec 2023 21:40:23 +0000
References: <20231210045255.21383-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20231210045255.21383-1-dinghao.liu@zju.edu.cn>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Yuval.Mintz@qlogic.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Dec 2023 12:52:55 +0800 you wrote:
> qed_ilt_shadow_alloc() will call qed_ilt_shadow_free() to
> free p_hwfn->p_cxt_mngr->ilt_shadow on error. However,
> qed_cxt_tables_alloc() accesses the freed pointer on failure
> of qed_ilt_shadow_alloc() through calling qed_cxt_mngr_free(),
> which may lead to use-after-free. Fix this issue by setting
> p_mngr->ilt_shadow to NULL in qed_ilt_shadow_free().
> 
> [...]

Here is the summary with links:
  - [v3] qed: Fix a potential use-after-free in qed_cxt_tables_alloc
    https://git.kernel.org/netdev/net/c/b65d52ac9c08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



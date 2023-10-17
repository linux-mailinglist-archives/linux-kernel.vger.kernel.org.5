Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE47CB7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjJQAuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjJQAuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:50:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3476BA7;
        Mon, 16 Oct 2023 17:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C69F9C433C7;
        Tue, 17 Oct 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697503822;
        bh=/pGdAm7PXGj9anP5SKs4K42VM25v0gGyZYaa8W3Bo4c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EVuSvDVM7xs/ez5ZfhaChA8kw4DL14lD4S11lNFQ0S8W5WIuFs2eVbMASEPPrZ4eh
         tlb8Uku0XBMiEhKYTpAy5T8JJ2Saeg0fkVwgMd+/Qg7qIaCSaVsBF07p1HN9Xk/+Qe
         ZDm3fzGWQUl8GAhwcKoameJUbMVpto5qYX9fMmV/YdBmCzeg+V1f7/Jbyy4QwPQNhE
         I4n/tfj6F6YmhB1Yzmh3gYaVe1Yu+48tTSkLJqoqPXSgIROyht/bKjTTHlKh/ArO9c
         nkYSKMpo05SJcDJ8SAUuS3Zx4Flg9fCDrB1dH+iWEcpHqR+Mg988Y1996oDB+lVkBr
         0uVqwhuoLExJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B22C6E4E9B6;
        Tue, 17 Oct 2023 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfc: nci: fix possible NULL pointer dereference in
 send_acknowledge()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169750382271.30000.6808834861432208355.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 00:50:22 +0000
References: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, sameo@linux.intel.com,
        frederic.danis@linux.intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, huangsicong@iie.ac.cn,
        stable@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 20:41:29 +0200 you wrote:
> Handle memory allocation failure from nci_skb_alloc() (calling
> alloc_skb()) to avoid possible NULL pointer dereference.
> 
> Reported-by: 黄思聪 <huangsicong@iie.ac.cn>
> Fixes: 391d8a2da787 ("NFC: Add NCI over SPI receive")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] nfc: nci: fix possible NULL pointer dereference in send_acknowledge()
    https://git.kernel.org/netdev/net/c/7937609cd387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



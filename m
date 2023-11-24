Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CD37F739F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbjKXMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:20:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41510CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:20:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12FDCC433C8;
        Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700828430;
        bh=UFRH5rcaYhZTd94yrrbN6G28EYOXdfnM0jmlWUNt8pU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gEr44iVTRfWKOQDVQcfmYm08HPPfNsxr2dfuQqiU4GzoS4CqqHHUsJxpIUYOTBKYC
         Bl/jg0HPxVoGmTB06yljv2G5UruHye7pRs6z+El+LaDoT1UFYM2m5LJgdVD0+eNJ8l
         6n8bFCjAu6qmPi0dPg98OUX4zafydY/P5eIikXq/96hZzUfYeEpmYOlwz2ypnUMZYD
         JsCFGvVLs6QJI5S4Bd0ubbltqPRm4qUGugZgTNCnjNfEfaoFX0PE1Be2+g5H0vpiAg
         EUh7GF284JV7/3GxMzdbecml5mrJtP/l8GgQ6Hu/aaEn/MOohuUgeZ7i7xiNjvfMWX
         9wLWEBpKhlVnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F05E5E29F40;
        Fri, 24 Nov 2023 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: ipa: add IPA v5.5 support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170082842997.28500.2650195064099739924.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Nov 2023 12:20:29 +0000
References: <20231122230909.895482-1-elder@linaro.org>
In-Reply-To: <20231122230909.895482-1-elder@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andersson@kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 17:09:04 -0600 you wrote:
> This series adds IPA support for the Qualcomm SM8550 SoC, which uses
> IPA v5.5.
> 
> The first patch adds a new compatible string for the SM8550.  The
> second cleans up "ipa_reg.h" a bit for consistency.  The third patch
> adds definitions and some minor code changes related to IPA v5.5.
> The fourth defines IPA register offsets and fields used for IPA
> v5.0; most--but not all--register definitions are the same as used
> in IPA v5.0.  The final patch adds configuration data used for IPA
> v5.5 (here again this mostly duplicates IPA v5.0 definitions).
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] dt-bindings: net: qcom,ipa: add SM8550 compatible
    https://git.kernel.org/netdev/net-next/c/dd043b393c85
  - [net-next,2/5] net: ipa: update IPA version comments in "ipa_reg.h"
    https://git.kernel.org/netdev/net-next/c/b134b10cf5bb
  - [net-next,3/5] net: ipa: prepare for IPA v5.5
    https://git.kernel.org/netdev/net-next/c/b00e190cc200
  - [net-next,4/5] net: ipa: add IPA v5.5 register definitions
    https://git.kernel.org/netdev/net-next/c/1bfeafabcd5e
  - [net-next,5/5] net: ipa: add IPA v5.5 configuration data
    https://git.kernel.org/netdev/net-next/c/7c5929407620

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



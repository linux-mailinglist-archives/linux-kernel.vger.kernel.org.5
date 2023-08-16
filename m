Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6F77EA45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbjHPUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjHPUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F70D198E;
        Wed, 16 Aug 2023 13:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AB861FBE;
        Wed, 16 Aug 2023 20:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08465C433C9;
        Wed, 16 Aug 2023 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692216022;
        bh=D7d6wuVGzkWQOCUZmhR9pJ/mB+VrH8L9Q24bxgQAm/k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TejQbEIwzkNlw9KtnPwOjt3+MJejbe/Vf9JLtbRzhBs50hdqAlD/Mq1lVecQpKMU0
         pCSmIOFj91b63UnUIoW6pBZZA0wILyP23UESMAVeqNb6UporYbQZfJ+JLigx80OtSn
         YlyK9FDyCIipNLsqMXBrTc79uUPPfjCi5PdINgDsZ9ljtn2sln8J7aTKwVKZx+oQV0
         AmAkTB96r8VJsaOUE1LvWP3PrjrkOGj9MT6dJkRrOclue52t6MLFiyh926C2V+SCuN
         9IRGQJNI7l7yLTG66+bAAT9In8stG1kn7mcssPRk8S4CEC0Zr2R2fuNIr2dNI8rz4n
         06MnFvfjtmM8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD62AE93B30;
        Wed, 16 Aug 2023 20:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] bluetooth: qca: enable WCN7850 support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169221602190.24089.3443584024796789580.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 20:00:21 +0000
References: <20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org>
In-Reply-To: <20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 03 Aug 2023 10:45:25 +0200 you wrote:
> This serie enables WCN7850 on the Qualcomm SM8550 QRD
> reference platform.
> 
> The WCN7850 is close to the WCN6855 but uses different
> firmware names.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v3,1/3] dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
    https://git.kernel.org/bluetooth/bluetooth-next/c/f38a5adcbd53
  - [v3,2/3] bluetooth: qca: use switch case for soc type behavior
    https://git.kernel.org/bluetooth/bluetooth-next/c/08292727a9fc
  - [v3,3/3] bluetooth: qca: add support for WCN7850
    https://git.kernel.org/bluetooth/bluetooth-next/c/ef6d9b23aa58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



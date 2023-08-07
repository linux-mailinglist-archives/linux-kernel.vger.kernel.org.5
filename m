Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54D577331B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHGWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjHGWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E07E103;
        Mon,  7 Aug 2023 15:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06388622E6;
        Mon,  7 Aug 2023 22:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CCBCC433CC;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691448622;
        bh=UqATlph8Eo/e5YiJi8/QqaqNEUFiDAYOsk+a0ly4odQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iFqW/QLFnyeNdEkB1FKRTxoutUm2irL9EmxC/fd8R/KCcmR2ugMQ2o31g+GSKyijc
         9HGH+3As9jM0cRlD+3fFT3LMZx5pVCDHp3stPOyJ/COiNcQAVrZOTFTjVaB7ZwUxUQ
         a4YjlPbobB7TaBygDxUclDdqijqqZE6lK3t7wePOIfqphlPIUEpz4KkfEHSkzX2JZg
         quaLQKLdoaG/Cm6zCp06ZwNB0Q75YnAWMPYhPyEf1ssEhLBJq+Dup5YBXk7unXTTeD
         Hd/pCanVfBh7ZGEUfxJFrPpsh4aO49QoUWS+nV4eFoevaSpcH2M79hV4pRGJbt2fXN
         aWlBVu4pD1IfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FB26E33098;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169144862225.1999.15719551303477888698.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 22:50:22 +0000
References: <20230807114259.13654-1-max.chou@realtek.com>
In-Reply-To: <20230807114259.13654-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com,
        kidman@realtek.com, juerg.haefliger@canonical.com,
        vicamo.yang@canonical.com, Riley.Kao@dell.com, jwboyer@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, regressions@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 7 Aug 2023 19:42:59 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> In this commit, prefer to load FW v2 if available. Fallback to FW v1
> otherwise. This behavior is only for RTL8852C.
> 
> Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
> Cc: stable@vger.kernel.org
> Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
    https://git.kernel.org/bluetooth/bluetooth-next/c/77bceb7a4d68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



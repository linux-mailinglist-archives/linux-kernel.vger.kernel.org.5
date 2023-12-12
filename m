Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9E80F24B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjLLQUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjLLQUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE65D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:20:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A0CC433C9;
        Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702398025;
        bh=Gv+mO4PMFcKCSTAW/D0ZVcdMq7d8CoX5pEYybTDqgPE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YjaaCOW1fCwRdEEdOl0SVCkPGKPdXzosMlrVNXS6mJLoyFN7V8yCuOK439aihW5q6
         Kd6VYSryGu9NKDwCQnMfqYwoQf4p/7bNzD3Hz6hXU2gl11HjGQv2cK4d8G4OxZHRod
         gXnsuz4AqrB2OZifQjmhpubDMJTMXq13qwSdvTg7/VYIn36+oyCfTxs901uWn8HspY
         ZE418llpCZrBmPmoW+bshBpKQO2w9vyom5wryOMov93dVogs5eQEUkHDz5JWP7EzG/
         NYxMBTUKsZ6MAf5nEtNXIJ/UwfSLuho6vg71bqbYQNPoEbW7tuFUyU3cbDTRIo0wK/
         dug9xTU6yfq5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D7EBC4314C;
        Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: fix recv_buf() return value
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <170239802557.22444.1717551799062581956.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Dec 2023 16:20:25 +0000
References: <20231211164020.173253-1-francesco@dolcini.it>
In-Reply-To: <20231211164020.173253-1-francesco@dolcini.it>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com,
        francesco.dolcini@toradex.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jirislaby@kernel.org
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

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Dec 2023 17:40:17 +0100 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Serdev recv_buf() callback is supposed to return the amount of bytes consumed, therefore an int in between 0 and count.
> 
> Do not return negative number in case of issue, just print an error and return count. This fixes a WARN in ttyport_receive_buf().
> 
> In addition to that a small cleanup patch is added on btnxpuart to remove a useless assignment.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: btnxpuart: fix recv_buf() return value
    https://git.kernel.org/bluetooth/bluetooth-next/c/7954bbcdd7ea
  - [v2,2/3] Bluetooth: btmtkuart: fix recv_buf() return value
    https://git.kernel.org/bluetooth/bluetooth-next/c/687d2de93b11
  - [v2,3/3] Bluetooth: btnxpuart: remove useless assignment
    https://git.kernel.org/bluetooth/bluetooth-next/c/99f188d71731

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



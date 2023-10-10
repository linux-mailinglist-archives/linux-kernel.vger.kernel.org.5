Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755837C0395
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjJJSke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjJJSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310629E;
        Tue, 10 Oct 2023 11:40:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C191FC433CA;
        Tue, 10 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696963230;
        bh=VvYCBuzvTxNqvXI0/Dte7XGp/9z7rAbpUZxhqoH0w1g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DcGMjb98/Qa93ZeX32y6kT0w0V/oo3n1UBPLX163GVEIVSKlSq2dZBcXXlDZ9FIUj
         RbMcDVXRD4HszXwziM4dkr0fGYJEkdhtWXrGdR3Bp3Cftfn5jGHajzGHF1wHj2JRbF
         WJkOO5O5voSB5AJXvaA/5mmsuiV/s2vPEewKGI8blHZ/50k1mVrQQUmh3QTR95IY9i
         EKcttPJthdufQgygRx9w9lhYQl+hJ52qGmsptn+XJPL/OxSHmeN8tMrqcdvZQrjMSO
         QaTWtF/mh0Uu+Hbze15UWMHXXaWU0Rghk7woOwSsjcHKlAm/TRVsRIdmSVWyI2kGC2
         z20v6NewERRTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A39CAE0009E;
        Tue, 10 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sock: fix slab oob read in
 create_monitor_event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169696323066.22645.5131811474824547611.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 18:40:30 +0000
References: <20231010053656.2034368-2-twuufnxlz@gmail.com>
In-Reply-To: <20231010053656.2034368-2-twuufnxlz@gmail.com>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
        davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Oct 2023 13:36:57 +0800 you wrote:
> When accessing hdev->name, the actual string length should prevail
> 
> Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
> Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  net/bluetooth/hci_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: hci_sock: fix slab oob read in create_monitor_event
    https://git.kernel.org/bluetooth/bluetooth-next/c/78480de55a96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



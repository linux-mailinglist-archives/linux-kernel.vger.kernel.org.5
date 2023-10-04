Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826657B8D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjJDTaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjJDTah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:30:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028FAD;
        Wed,  4 Oct 2023 12:30:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E865C433CC;
        Wed,  4 Oct 2023 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696447834;
        bh=qUFTQIRoEeKJZwY5Eyghpz6w7q9r9nOu0dTBfAehd54=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S5V5OXcYaUqJLMtLezbcz9IUc9KQej++5Pl05X/Be+olaaYfH6GZNFzkTyXeYu7n2
         wHDFgoRjsv3X8ye7JOy1HNS903LCyAm7QNvxpFtV9Bogi+NskVvQA+xScGv1P3UhNr
         9YhiWsaTAx0gZwu84ICTbtu6H4WZ4QZJVgS889C2vSzXUPyN632ZZvEqXAA1SZDgnt
         jplEHQY1HyyIg7/uZSF8ARW5xIFXnxvrP0pOQZ0GIrlu1bERovKLpqtv06rvLJOoQs
         wkg9HXXw9ZuEUhZ16XHjynRtEdmlQrrUTpgZcGD1EayvFlTxkHFIz4nZbIesTbhqQW
         VYGWMuE86XI8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36A57E632D6;
        Wed,  4 Oct 2023 19:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix a refcnt underflow problem for hci_conn
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169644783421.9933.17180442549400716324.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 19:30:34 +0000
References: <20231004124224.630914-1-william.xuanziyang@huawei.com>
In-Reply-To: <20231004124224.630914-1-william.xuanziyang@huawei.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 4 Oct 2023 20:42:24 +0800 you wrote:
> Syzbot reports a warning as follows:
> 
> WARNING: CPU: 1 PID: 26946 at net/bluetooth/hci_conn.c:619 hci_conn_timeout+0x122/0x210 net/bluetooth/hci_conn.c:619
> ...
> Call Trace:
>  <TASK>
>  process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
>  process_scheduled_works kernel/workqueue.c:2703 [inline]
>  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
>  kthread+0x33c/0x440 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix a refcnt underflow problem for hci_conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/6be21d987868

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



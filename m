Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7557C482F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbjJKDK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjJKDK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453CA91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6D9CC433CA;
        Wed, 11 Oct 2023 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696993825;
        bh=chhBCKkV6ZerimGonFhRxw877THTC2UOjXgTOzI0cxw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uliMU3Dbeg2uHNffO1m5HRHiMQDIb8dS3e0RUtjyg+HY5B2fNk7N11YHjoaVRDqq4
         bXKTY/R5kLh3EEtAHu+vSsMVKcUnTgP6sWUsNs80b5qwevgGwWV1wUQ0+LTQyldhQA
         kxFLw1tr8yvSdfeyKHqRjH6p0APsUBtUTYrtRGFOsfv3L9uialQ/zLO7cEQSiC3Eqo
         Qlj5vE91gMnlMSbt2Rw6LDBFsRyra/9QMMDJdWpSvdFzFbnWLMBQ+2TPIiUW0cfhOO
         7Z4nfgUr0taYgSK/WA9u675nIyGq5DRczNSOCHh50qiymoe1Ude+FyCNKSLHZZC5VC
         33DxgP5gqEHtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7C24E11F43;
        Wed, 11 Oct 2023 03:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169699382568.3301.6960021020124970856.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 03:10:25 +0000
References: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
In-Reply-To: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     peter@korsgaard.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 00:26:14 +0200 you wrote:
> syzbot has found an uninit-value bug triggered by the dm9601 driver [1].
> 
> This error happens because the variable res is not updated if the call
> to dm_read_shared_word returns an error. In this particular case -EPROTO
> was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of dm_read_shared_word
> and propagating the error if the read operation failed.
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
    https://git.kernel.org/netdev/net/c/8f8abb863fa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



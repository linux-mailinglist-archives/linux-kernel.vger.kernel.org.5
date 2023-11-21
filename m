Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390227F395E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjKUWkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUWk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:40:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BDE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:40:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAA1EC433D9;
        Tue, 21 Nov 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700606424;
        bh=BCqZvJQBa/wE6TafX7ndIlv2XcDSydEYgzFZ8mfueQs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XupgcuotIa2srbEszQDG45/XAkGEU1Owo0a1PTXnu91iRoCHt4z/uxFVqO83ZS1MH
         kcCulnq3sNCSoWgFv1V0tYyvdE9TCujTB8sBKhvS9SgcBmiseWsJPsFUK947V6/KHC
         9PiIAcn8bsghK8DYiQSAHiChNpchrUVAw4oX1UOEEL0sR87iTu7AQHd2f6bCRKwyjc
         YrNQ6tC6mPGW267Iz8yWfFhg4+ozEGLClCg2ru3bsVNGodprKV8dCBQ7Vw2+iaeUkP
         HdXhklwj5Fne/e0OaOKFb8fym/6QRZ3qnj3BuMeufrNFGDICvv6oxP2nRk1Sn28ptr
         esn6PTkHlvHLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A16FDC691E1;
        Tue, 21 Nov 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] net: usb: ax88179_178a: fix failed operations during
 ax88179_reset
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170060642465.8112.10987867450533291011.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Nov 2023 22:40:24 +0000
References: <20231120120642.54334-1-jtornosm@redhat.com>
In-Reply-To: <20231120120642.54334-1-jtornosm@redhat.com>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        weihao.bj@ieisystem.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Nov 2023 13:06:29 +0100 you wrote:
> Using generic ASIX Electronics Corp. AX88179 Gigabit Ethernet device,
> the following test cycle has been implemented:
>     - power on
>     - check logs
>     - shutdown
>     - after detecting the system shutdown, disconnect power
>     - after approximately 60 seconds of sleep, power is restored
> Running some cycles, sometimes error logs like this appear:
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to write reg index 0x0001: -19
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0001: -19
>     ...
> These failed operation are happening during ax88179_reset execution, so
> the initialization could not be correct.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: usb: ax88179_178a: fix failed operations during ax88179_reset
    (no matching commit)
  - [v2,2/2] net: usb: ax88179_178a: avoid two consecutive device resets
    https://git.kernel.org/netdev/net-next/c/d2689b6a86b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



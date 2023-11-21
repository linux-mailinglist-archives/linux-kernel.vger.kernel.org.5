Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6517F2CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjKUMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjKUMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:20:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57597137
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E82EDC433C7;
        Tue, 21 Nov 2023 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700569224;
        bh=yQOaPm61GV3Mm5JVJVeShLYhMtyr0KKQXZu6Fb8eSqU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bLA89/NiF6DDvYabq6kNw5fFtzEEK2FP/tRf7MYtsALi8v7nexakB29K8lSZBctMR
         prQJ7jF0D86vSg/LKTbwbE2WS75DivZxEQCmC74TqFbVgnyoy9zr6Zzs+aof8klcFv
         miGzrT7T9q6Wrrcu9dhpqC2/TAXUQ+GqMGisQ3LGMyIKoPvvAPBWbeW3sYXxH4PHCz
         xndpwSACxSk14GW1KT7m1pDX3pkPdoszufGUrAfzlPMrodJrkjYSuhi/OnthZinwnu
         //6taz0hMdfFBeAFqjkMNb46rrOhMRk/jkjlNQ3GU2AKtsMbo++oZaIE4kY+UOwLk2
         GvXVRd9AQEkaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5017EAA95F;
        Tue, 21 Nov 2023 12:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v5, 0/3] hv_netvsc: fix race of netvsc, VF register,
 and slave bit
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170056922379.17536.3153244680248688483.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Nov 2023 12:20:23 +0000
References: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        stephen@networkplumber.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 19 Nov 2023 08:23:40 -0800 you wrote:
> There are some races between netvsc probe, set notifier, VF register,
> and slave bit setting.
> This patch set fixes them.
> 
> Haiyang Zhang (2):
>   hv_netvsc: fix race of netvsc and VF register_netdevice
>   hv_netvsc: Fix race of register_netdevice_notifier and VF register
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] hv_netvsc: fix race of netvsc and VF register_netdevice
    https://git.kernel.org/netdev/net/c/d30fb712e529
  - [net,v5,2/3] hv_netvsc: Fix race of register_netdevice_notifier and VF register
    https://git.kernel.org/netdev/net/c/85520856466e
  - [net,v5,3/3] hv_netvsc: Mark VF as slave before exposing it to user-mode
    https://git.kernel.org/netdev/net/c/c807d6cd089d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



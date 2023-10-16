Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70237CB718
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjJPXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJPXk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F5A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39D29C433C8;
        Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697499625;
        bh=8frB8n8EpgvpOJk/TwuP74aMZY4wj+dhkEtmKJLVsK8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pNjxJ6GotWta56mc4UQ4181lUvYPIg3ECNlN8hxxM9y7B/WyqSP1nvbFrZTTFeyQo
         f2WAyyncKh5NYzH1qWGOSGalh51v+jKkO/ELxpffbW8dZCuC2j7oLj8fwQhG3mGtQq
         oYxZcD4eUzjoMiV95yjsmqeuoRrW6vAEOdAMIQkxSe0xsYGQoJK8vncW60xiNCNl8f
         96XbwKRNRMBz2EZlO4S2V/k0G8zVLYdvf5tuz0n0e6MfEDOTRmpm47UNAAWWRB52as
         REI7Zb8s1yUHRrbqR+3ohXWEilaWcrNbMNuy7G0fFrNaSzsrVU8qT5oE8GLyoh5sUA
         +6jFs85berg9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2515BC41671;
        Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2] cgroup,
 netclassid: on modifying netclassid in cgroup,
 only consider the main process.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169749962514.28594.17942649071337663537.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 23:40:25 +0000
References: <20231012090330.29636-1-zhailiansen@kuaishou.com>
In-Reply-To: <20231012090330.29636-1-zhailiansen@kuaishou.com>
To:     Liansen Zhai <zhailiansen@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuwang@kuaishou.com,
        wushukun@kuaishou.com, zhailiansen@kuaishou.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 17:03:30 +0800 you wrote:
> When modifying netclassid, the command("echo 0x100001 > net_cls.classid")
> will take more time on many threads of one process, because the process
> create many fds.
> for example, one process exists 28000 fds and 60000 threads, echo command
> will task 45 seconds.
> Now, we only consider the main process when exec "iterate_fd", and the
> time is about 52 milliseconds.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] cgroup, netclassid: on modifying netclassid in cgroup, only consider the main process.
    https://git.kernel.org/netdev/net-next/c/c60991f8e187

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



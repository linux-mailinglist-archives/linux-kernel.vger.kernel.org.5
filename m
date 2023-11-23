Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD927F64A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345597AbjKWRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjKWRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF49D6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B39C43395;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758826;
        bh=QAhKOwmSyYL/06pMRYmwqRumPVYS4ikPDyPLMLk4BuA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AVlUgOAd/6Qj6nT4t8NFVdUtPwQ2l/VvAr/AsYAyEhcsdIDgNE74ytiYqDubRqE6S
         p0e/zkaOVwOAzshbkNW6MePqAsUbguzkjL48aPfFSqbNhpH1U70AWOr3jAAdyiSBic
         EVtmD37c45/gc21eptnlVFgYG/z2ZiNP1/wwzFi1VbaFCpzS2nJxCdUX/cVxQu7zld
         ezgZjc97kOLjvSYG9EPn/1PHIzVE04Gdl5kPsMZt1D8vH5sytLhN6Ytj/g0zSkZIGo
         rXjYt3gI0HhFVPv/fqpnNH1Wv5qV53VHTAMUFgwPGG3PHkHWZgiEPitcHT5BcrbR/o
         Uulq4AblryAaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8277EE00087;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] vsock/test: fix SEQPACKET message bounds test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170075882653.541.9262158470588794948.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Nov 2023 17:00:26 +0000
References: <20231121211642.163474-1-avkrasnov@salutedevices.com>
In-Reply-To: <20231121211642.163474-1-avkrasnov@salutedevices.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mst@redhat.com, jasowang@redhat.com, bobby.eshleman@bytedance.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 00:16:42 +0300 you wrote:
> Tune message length calculation to make this test work on machines
> where 'getpagesize()' returns >32KB. Now maximum message length is not
> hardcoded (on machines above it was smaller than 'getpagesize()' return
> value, thus we get negative value and test fails), but calculated at
> runtime and always bigger than 'getpagesize()' result. Reproduced on
> aarch64 with 64KB page size.
> 
> [...]

Here is the summary with links:
  - [net,v1] vsock/test: fix SEQPACKET message bounds test
    https://git.kernel.org/netdev/net/c/f0863888f6cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



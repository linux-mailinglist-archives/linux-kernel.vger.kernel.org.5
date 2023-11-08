Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315247E52DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjKHJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5A9199;
        Wed,  8 Nov 2023 01:50:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5618DC433C9;
        Wed,  8 Nov 2023 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699437025;
        bh=d2gSTy+vkT+31H7XELYbOwZiriPnni4XDCQCXWXVTrQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rmaJLzq9K6LWU0TbEY9k20In79eVvajZ22oEEq8TGY4P8tnVxWKySpBAm/W5C7x9t
         PzbMuqPOiFFZhKr9lDQAcdlCA28tlCo22V1JEjFn/OnhqlqfK9skepSUO5JsYOP8BT
         wI8xH74EUD39nUm/9TbEadQqP/Huf6JrYwDpkyT/L5K9DIHfUESpeP3ofn7ioJfQUF
         GSUVxHEukp005F8DHWfwcffv3CGdLhkn7i0HYTnllanWV6aWSDSClJBtulljiQQGku
         K3yxHk7MKRRfZVRYmtagBRs6PWlErPd//eBNuUQrqtahssNTbhImQcRs3Bk0f7vwN9
         SDX1GraA1AHkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B6CEE00084;
        Wed,  8 Nov 2023 09:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] drivers/net/ppp: use standard array-copy-function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169943702523.25861.15308203568486315499.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Nov 2023 09:50:25 +0000
References: <20231106091559.14419-2-pstanner@redhat.com>
In-Reply-To: <20231106091559.14419-2-pstanner@redhat.com>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, sdf@google.com, gregkh@linuxfoundation.org,
        benjamin.tissoires@redhat.com, viro@zeniv.linux.org.uk,
        linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, airlied@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  6 Nov 2023 10:16:00 +0100 you wrote:
> In ppp_generic.c, memdup_user() is utilized to copy a userspace array.
> This is done without an overflow-check, which is, however, not critical
> because the multiplicands are an unsigned short and struct sock_filter,
> which is currently of size 8.
> 
> Regardless, string.h now provides memdup_array_user(), a wrapper for
> copying userspace arrays in a standardized manner, which has the
> advantage of making it more obvious to the reader that an array is being
> copied.
> The wrapper additionally performs an obligatory overflow check, saving
> the reader the effort of analyzing the potential for overflow, and
> making the code a bit more robust in case of future changes to the
> multiplicands len * size.
> 
> [...]

Here is the summary with links:
  - [v2] drivers/net/ppp: use standard array-copy-function
    https://git.kernel.org/netdev/net/c/caf3100810f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



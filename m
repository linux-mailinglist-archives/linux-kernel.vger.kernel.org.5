Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE2779C61
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjHLBuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 21:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHLBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 21:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F140630DB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 18:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6112D640E6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 01:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0AC1C433C9;
        Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691805022;
        bh=ysoHYj+KZaxlSNAKflnuGhG1OWXzEAypWEPI1ZJHcjk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZEHGs0X7jv4gVnW1sdAWB6l2HKmDSlWf/SZGUl+PSaCA+nmNb/LGlQ7UpD3OnOhA3
         sPijIcrMqYvZrid0UvVDXYLPT/h/lg6EVA9pWJOsKsQrLisd0i8lEEYiVMXVmf9nP0
         2pxMcVFw2whF04SubVi1NACZ340yL6O+dRNxAeLgIDpa+IACUk+PSRd4C3B/gDgL5P
         UuNMXXbxgJxTEOP0F5aScGJref8QgidTreFGL7eOUb26R2BiIzqUlrxpDniOdp8mD1
         mmNleM0kItEYMTgreRlvtnFZF6ZfLLjNxkKZ/p4Id4YiIoEzbhMxHvBzf3iQu/f9Ho
         C3ut/w9WgaSkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E88DC395C5;
        Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] ethernet: ldmvsw: mark ldmvsw_open() static
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169180502257.32437.12168332345794994475.git-patchwork-notify@kernel.org>
Date:   Sat, 12 Aug 2023 01:50:22 +0000
References: <20230810122528.1220434-1-arnd@kernel.org>
In-Reply-To: <20230810122528.1220434-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, arnd@arndb.de, geoff@infradead.org,
        petrm@nvidia.com, piotr.raczynski@intel.com,
        wsa+renesas@sang-engineering.com, windhl@126.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Aug 2023 14:25:15 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The function is exported for no reason and should just be static:
> 
> drivers/net/ethernet/sun/ldmvsw.c:127:5: error: no previous prototype for 'ldmvsw_open' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> [...]

Here is the summary with links:
  - [1/2] ethernet: ldmvsw: mark ldmvsw_open() static
    https://git.kernel.org/netdev/net-next/c/ea6f782fe584
  - [2/2] ethernet: atarilance: mark init function static
    https://git.kernel.org/netdev/net-next/c/7191c140faa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



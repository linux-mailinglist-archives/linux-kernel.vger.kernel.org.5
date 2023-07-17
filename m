Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38619756DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjGQUA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGQUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90145C0;
        Mon, 17 Jul 2023 13:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E2A6123D;
        Mon, 17 Jul 2023 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87CCCC433C9;
        Mon, 17 Jul 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689624023;
        bh=VvUrr/lNy1RoFBlVS4sKFuvySllf8RjVXY1xZwC6b70=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MZrlWvYUmlwnP1oX+amr5BrJ8tdljFYHzoA9Jy3kbUXjFK5cX1ak8Nqwi2j+uy81P
         uqk3oBy9Y4oB2Ze2g91CuFNPYQqoJDb2DLEB994tPuT+MM4UXmByZC6+/eNiCVDJ3R
         cPV61Kq9fkgwzusBnPK1RyuyN3MY+tBN3rT42hHy6aHlCzfTept0U7nA+Q7orxyIMb
         oi45hH8kXDXs98+ZB+g81AQP6Ek2++I49qqnRnxtKq3P+374oVE36zQ6xAhvRKWepk
         K/NlaXT93VxoU3IFPssPEgFC5H8Wx9huY0YvJu91RArnE7vDn0LLhCZ9BPOXsDjjil
         RbU+v8iX/KVgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D747C561EE;
        Mon, 17 Jul 2023 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] Bluetooth: MGMT: Use correct address for memcpy()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168962402343.17606.5289910658256471701.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 20:00:23 +0000
References: <20230717093214.82102-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230717093214.82102-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Jul 2023 12:32:14 +0300 you wrote:
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘get_conn_info_complete’ at net/bluetooth/mgmt.c:7281:2:
> include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [v1,1/1] Bluetooth: MGMT: Use correct address for memcpy()
    https://git.kernel.org/bluetooth/bluetooth-next/c/75401514ef1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



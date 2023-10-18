Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F77CD1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbjJRBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjJRBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:10:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C40410C;
        Tue, 17 Oct 2023 18:10:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF9ABC433C8;
        Wed, 18 Oct 2023 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697591422;
        bh=WPJ/r8+0jyetchJwy0VLkx+UQMJn64TVCXqZ4uqyTz0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sR8wrLxO9NaaYo7u5jAGmbvtGAnodVa5rRjKLeDjWUX1o1XwubZqFJr8vyFbv69Ym
         o8fpJGdaQsugI9naJ61lloVTHSxyMdfh0+NRNs7Lt+/ublPQzZMs5+QWWHpAmZ6RWJ
         s0yZf6zw5V+BYZS1DkqrjryZdcZECWaz186hhBEUpZnm4GJETRYlQx7RPGBVu0yfhL
         jbO9RxxY+eRqb4rYQlgqewmpQON3OBBuLYjxg/vubZPUsBuAjf5zXa6ui5Tgn273kR
         88kGpX/yrVQ+prfxQzXb4EY29oVOJeINeTCrta0dPEZlNsvpSQICPW9o6J+aiVz3Xm
         Vq3rwy51eo7mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B472FC04E24;
        Wed, 18 Oct 2023 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] hamradio: replace deprecated strncpy with strscpy_pad
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169759142273.24973.7934258453986488450.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 01:10:22 +0000
References: <20231016-strncpy-drivers-net-hamradio-baycom_epp-c-v2-1-39f72a72de30@google.com>
In-Reply-To: <20231016-strncpy-drivers-net-hamradio-baycom_epp-c-v2-1-39f72a72de30@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     t.sailer@alumni.ethz.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Mon, 16 Oct 2023 18:42:42 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both hi.data.modename and hi.data.drivername to be
> NUL-terminated based on its usage with sprintf:
> |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
> |               bc->cfg.intclk ? "int" : "ext",
> |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
> |               bc->cfg.loopback ? ",loopback" : "");
> 
> [...]

Here is the summary with links:
  - [v2] hamradio: replace deprecated strncpy with strscpy_pad
    https://git.kernel.org/netdev/net-next/c/d4b14c1da5bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



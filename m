Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2977692C6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjGaKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGaKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E871E5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1225160E86
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C6E8C433C9;
        Mon, 31 Jul 2023 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690798221;
        bh=bTHJ9VChM2m57vgnBWAk42nSD+NFdt8fXYORrSzZ8gY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KGraYiNtgjbIE4YvL7OoFzuO4NBNPWqHlLHyXoT2W8qQJ/PbtTyrKlnC+nmXLWHzD
         UOpmT5RPnjW+fCcT1lsrZBNHfF2epqi1wDDvXWHqS0OBcTYIEggwShZ6PyUggoyqB3
         vDNXKEuQi8+/aN8N28ycni00UK0Z1sygg0W8OuPwS6wND/nWKL7qaPVk2tnEow4TZX
         o/YyRAJ/8yNUGk0gG+0zDmg8/e2jp3H9cO67A4Gi+EbEhS/HhoarMSyfJiOfjaVKvO
         jXnIWn0wN0jmaBQ/lVrS8qFecuRCzUIvBVRwBNjhFVnOjnd1aCQoyC0TgxDak0doQA
         IkGqay4YDHI1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 593A4E96AD7;
        Mon, 31 Jul 2023 10:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Sync filesystem on EC panic
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169079822136.24246.16960757983645261559.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 10:10:21 +0000
References: <20230726181738.1.Ic6b8e25120b2aec95e3d0f4ac92c2a35fc7a40e8@changeid>
In-Reply-To: <20230726181738.1.Ic6b8e25120b2aec95e3d0f4ac92c2a35fc7a40e8@changeid>
To:     Rob Barnes <robbarnes@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        dtor@chromium.org, chrome-platform@lists.linux.dev,
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

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 26 Jul 2023 18:17:39 +0000 you wrote:
> Perform a filesystem sync when an EC panic is reported. The
> sync is performed twice in case some inodes or pages are
> temporarily locked. Testing showed syncing twice significantly
> improved reliability.
> 
> hw_protection_shutdown is replaced for a couple reasons. It is
> unnecessary because the EC will force reset either way.
> hw_protection_shutdown does not reliably sync filesystem
> before shutting down.
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_lpc: Sync filesystem on EC panic
    https://git.kernel.org/chrome-platform/c/0a329167220a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



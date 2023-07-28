Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9AB766190
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjG1CAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG1CAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB3173F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6078E61FA1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBA49C433C9;
        Fri, 28 Jul 2023 02:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690509619;
        bh=dqrBr3LGlxHks7/U5bcjxzrJD9lsAaXyTek6qcarDc4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bUypoGRNlE4tizoKu59uFnqrrTXk5kXGGIApqyzuPuX3Kbokm8AQqmVJl+Gc74GXN
         vQ+FBur3H359iEc6dzXedgArCiOJXpr8+E1N4NuRnHurPutFUjIYRnHeNRv7fDfWI7
         sB+ietWsthK8WDs0dIeDTIXrGjnEokNAkrT2yCPETXG4z5WtjJqANyAMb8HRpKcUi7
         9Qlc2HJG38m0XRbk7C2PFVEBAxkaZlN68bgey+UaEB5+aze7MwxPWVJ7E3sLwLZ1k4
         HOGFwN0EkeGfnYf6ncBh9VHujoBFA+yHIGj66jrnOK4b7dlt/wDjU3Sud7h5u5eL/1
         hGsFhIs0yloiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1643C595D0;
        Fri, 28 Jul 2023 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Sync filesystem on EC panic
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169050961965.7430.17069420658023468694.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 02:00:19 +0000
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
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


